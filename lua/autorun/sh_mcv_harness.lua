// Development harness: lets a script outside the game drive a singleplayer session.
//
// Only active when garrysmod/data/mcv_harness/enable.txt exists (work/harness.py creates it).
// The driver drops command files into data/mcv_harness/queue/; the server works through them
// one line at a time and writes results into data/mcv_harness/results/ and screenshots into
// data/mcv_harness/shots/. Keys are pressed through the local player's console (+attack2 and
// so on), so the weapons see real input. Everything is written to disk, which both realms of
// a singleplayer game share, so no reply channel is needed.
//
// Commands (one per line, # comments):
//   give <class>            give the weapon and select it        strip          remove all weapons
//   select <class>          switch to a carried weapon           pos x y z      teleport
//   ang p y r               set the view angles                  noclip / god   toggle
//   key +attack2            press (or release with -) a key      tap +attack [seconds]
//   wait <seconds>          pause                                hud 0|1        cl_drawhud
//   shot <name> [marker]    screenshot, marker draws a centre cross and the sight state
//   report <name>           dump weapon / viewmodel state to results/<name>.json
//   spawn <class> [dist]    entity <dist> units in front of the player (npc_citizen 300)
//   cmd <console command>   server console                       ccmd <command>  client console
//   lua <code> / clua <code> run Lua on the server / client
//   quit                    close the game

if !file.Exists("mcv_harness/enable.txt", "DATA") then return end

MCV = MCV or {}
MCV.Harness = MCV.Harness or {}
local H = MCV.Harness

local ROOT = "mcv_harness/"
local QUEUE = ROOT .. "queue/"
local RESULTS = ROOT .. "results/"
local SHOTS = ROOT .. "shots/"

for _, d in ipairs({ROOT, QUEUE, RESULTS, SHOTS}) do
    if !file.IsDir(d, "DATA") then file.CreateDir(d) end
end

if SERVER then
    util.AddNetworkString("mcv_harness")
end

local function log(...)
    local s = "[harness] " .. table.concat({...}, " ")
    print(s)
    if SERVER then
        file.Append(ROOT .. "log.txt", os.date("%H:%M:%S ") .. s .. "\n")
    end
end

// ---------------------------------------------------------------------------------------
// State the client reports about the active weapon
// ---------------------------------------------------------------------------------------

local function vecs(v) return {math.Round(v.x, 3), math.Round(v.y, 3), math.Round(v.z, 3)} end
local function angs(a) return {math.Round(a.p, 3), math.Round(a.y, 3), math.Round(a.r, 3)} end

function H.WeaponState(ply)
    local wep = ply:GetActiveWeapon()
    local t = {realm = CLIENT and "client" or "server", time = CurTime(), map = game.GetMap(),
               pos = vecs(ply:GetPos()), eye = vecs(ply:EyePos()), ang = angs(ply:EyeAngles()),
               health = ply:Health(), onground = ply:IsOnGround()}
    if !IsValid(wep) then t.weapon = nil return t end
    t.weapon = wep:GetClass()
    t.printname = wep.PrintName
    t.base = wep.Base
    t.clip = wep:Clip1()
    t.reserve = wep:Ammo1()
    if wep.MilitaryConflictVietnam then
        t.ironsight = wep:GetIronsight()
        t.sighted = wep:GetSighted()
        t.sight_amount = wep.GetSightAmount and math.Round(wep:GetSightAmount(), 3)
        t.sight_visual = CLIENT and wep.GetSightAmountVisual and math.Round(wep:GetSightAmountVisual(), 3) or nil
        t.speed = wep.GetSpeed and math.Round(wep:GetSpeed(), 1)
        t.firemode = wep.GetFiremodeName and wep:GetFiremodeName()
        t.action_state = wep.GetActionState and wep:GetActionState()
        t.holster_time = wep:GetHolsterTime()
        t.next_idle = math.Round(wep:GetNextIdle() - CurTime(), 3)
        t.anim_lock = math.Round(wep:GetAnimLockTime() - CurTime(), 3)
        t.hold_type = wep.CurrentHoldType
        t.ironsight_pos = wep.IronsightPos and vecs(wep.IronsightPos)
        t.ironsight_ang = wep.IronsightAng and angs(wep.IronsightAng)
    end
    local vm = ply:GetViewModel()
    if IsValid(vm) then
        local seq = vm:GetSequence()
        t.vm = {model = vm:GetModel(), sequence = vm:GetSequenceName(seq), activity = vm:GetSequenceActivityName(seq),
                cycle = math.Round(vm:GetCycle(), 3), rate = vm:GetPlaybackRate(), pos = vecs(vm:GetPos()), ang = angs(vm:GetAngles()),
                pose = {}, bodygroups = {}}
        for i = 0, vm:GetNumPoseParameters() - 1 do
            local name = vm:GetPoseParameterName(i)
            t.vm.pose[name] = math.Round(vm:GetPoseParameter(name), 3)
        end
        for i = 0, vm:GetNumBodyGroups() - 1 do
            t.vm.bodygroups[vm:GetBodygroupName(i)] = vm:GetBodygroup(i)
        end
        if CLIENT then
            // where the muzzle and the camera attachment land on screen, for sight checks
            t.vm.screen = {}
            for _, att in ipairs({"muzzle", "eject", "cam"}) do
                local id = vm:LookupAttachment(att)
                if id > 0 then
                    local a = vm:GetAttachment(id)
                    if a then
                        local s = a.Pos:ToScreen()
                        t.vm.screen[att] = {math.Round(s.x), math.Round(s.y), s.visible}
                    end
                end
            end
            t.screen = {ScrW(), ScrH()}
            t.fov = ply:GetFOV()
        end
    end
    return t
end

// ---------------------------------------------------------------------------------------
// Client: screenshots, reports, marker
// ---------------------------------------------------------------------------------------

if CLIENT then
    H.PendingShot = nil
    H.Marker = false

    local function drawMarker()
        if !H.Marker then return end
        local x, y = ScrW() / 2, ScrH() / 2
        surface.SetDrawColor(255, 0, 255, 255)
        surface.DrawRect(x - 1, y - 40, 2, 30)
        surface.DrawRect(x - 1, y + 10, 2, 30)
        surface.DrawRect(x - 40, y - 1, 30, 2)
        surface.DrawRect(x + 10, y - 1, 30, 2)
        surface.DrawOutlinedRect(x - 3, y - 3, 6, 6)
        local ply = LocalPlayer()
        local wep = ply:GetActiveWeapon()
        if IsValid(wep) then
            local vm = ply:GetViewModel()
            local txt = string.format("%s  sight %.2f  seq %s  cycle %.2f", wep:GetClass(),
                wep.GetSightAmountVisual and wep:GetSightAmountVisual() or -1,
                IsValid(vm) and vm:GetSequenceName(vm:GetSequence()) or "?",
                IsValid(vm) and vm:GetCycle() or -1)
            draw.SimpleText(txt, "MCV_8", x, ScrH() - ScreenScale(4), Color(255, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
        end
    end
    hook.Add("HUDPaint", "MCV_HarnessMarker", drawMarker)

    hook.Add("PostRender", "MCV_HarnessCapture", function()
        if !H.PendingShot then return end
        // wait one frame so the marker state is drawn
        if H.PendingShot.frames > 0 then
            H.PendingShot.frames = H.PendingShot.frames - 1
            return
        end
        local name = H.PendingShot.name
        H.PendingShot = nil
        local data = render.Capture({format = "png", x = 0, y = 0, w = ScrW(), h = ScrH(), alpha = false})
        if data then
            file.Write(SHOTS .. name .. ".png", data)
            log("shot", name, #data .. " bytes")
        else
            log("shot", name, "capture failed")
        end
        file.Write(SHOTS .. name .. ".done.txt", "1")
    end)

    net.Receive("mcv_harness", function()
        local kind = net.ReadString()
        local arg = net.ReadString()
        if kind == "shot" then
            H.Marker = net.ReadBool()
            H.PendingShot = {name = arg, frames = 2}
        elseif kind == "report" then
            file.Write(RESULTS .. arg .. ".client.json", util.TableToJSON(H.WeaponState(LocalPlayer()), true))
            file.Write(RESULTS .. arg .. ".client.done.txt", "1")
        elseif kind == "clua" then
            local fn = CompileString(arg, "harness_clua", false)
            if isfunction(fn) then
                local ok, err = pcall(fn)
                if !ok then log("clua error", tostring(err)) end
            else
                log("clua compile error", tostring(fn))
            end
        elseif kind == "marker" then
            H.Marker = arg == "1"
        end
    end)
    return
end

// ---------------------------------------------------------------------------------------
// Server: queue processing
// ---------------------------------------------------------------------------------------

H.Job = nil // {name, lines, i, waituntil, waitfile, results}

local function send(ply, kind, arg, flag)
    net.Start("mcv_harness")
    net.WriteString(kind)
    net.WriteString(arg or "")
    net.WriteBool(flag or false)
    net.Send(ply)
end

local function firstPlayer()
    return player.GetAll()[1]
end

local function finishJob(job)
    file.Write(RESULTS .. job.name .. ".json", util.TableToJSON(job.results, true))
    file.Write(RESULTS .. job.name .. ".done.txt", "1")
    log("job", job.name, "done")
end

local function step(job, ply, line)
    local cmd, rest = string.match(line, "^(%S+)%s*(.-)%s*$")
    if !cmd then return end
    local args = string.Explode(" ", rest)
    table.insert(job.results.log, line)

    if cmd == "give" then
        local w = ply:Give(rest)
        if IsValid(w) then
            timer.Simple(0.05, function() if IsValid(ply) then ply:SelectWeapon(rest) end end)
        else
            table.insert(job.results.errors, "give failed: " .. rest)
        end
        job.waituntil = CurTime() + 0.3
    elseif cmd == "select" then
        ply:SelectWeapon(rest)
        job.waituntil = CurTime() + 0.2
    elseif cmd == "strip" then
        ply:StripWeapons()
    elseif cmd == "pos" then
        ply:SetPos(Vector(tonumber(args[1]) or 0, tonumber(args[2]) or 0, tonumber(args[3]) or 0))
        ply:SetLocalVelocity(vector_origin)
    elseif cmd == "ang" then
        ply:SetEyeAngles(Angle(tonumber(args[1]) or 0, tonumber(args[2]) or 0, tonumber(args[3]) or 0))
    elseif cmd == "noclip" then
        ply:SetMoveType(ply:GetMoveType() == MOVETYPE_NOCLIP and MOVETYPE_WALK or MOVETYPE_NOCLIP)
    elseif cmd == "god" then
        ply:GodEnable()
    elseif cmd == "key" then
        ply:ConCommand(rest)
    elseif cmd == "tap" then
        local key = args[1]
        local hold = tonumber(args[2]) or 0.1
        ply:ConCommand(key)
        timer.Simple(hold, function() if IsValid(ply) then ply:ConCommand("-" .. string.sub(key, 2)) end end)
        job.waituntil = CurTime() + hold + 0.05
    elseif cmd == "wait" then
        job.waituntil = CurTime() + (tonumber(rest) or 1)
    elseif cmd == "hud" then
        ply:ConCommand("cl_drawhud " .. rest)
    elseif cmd == "shot" then
        local name = args[1]
        file.Delete(SHOTS .. name .. ".done.txt")
        file.Delete(SHOTS .. name .. ".png")
        send(ply, "shot", name, args[2] == "marker")
        job.waitfile = SHOTS .. name .. ".done.txt"
        table.insert(job.results.shots, name)
    elseif cmd == "report" then
        local name = args[1]
        file.Delete(RESULTS .. name .. ".client.done.txt")
        file.Write(RESULTS .. name .. ".server.json", util.TableToJSON(H.WeaponState(ply), true))
        send(ply, "report", name)
        job.waitfile = RESULTS .. name .. ".client.done.txt"
        table.insert(job.results.reports, name)
    elseif cmd == "spawn" then
        local class = args[1]
        local dist = tonumber(args[2]) or 300
        local ent = ents.Create(class)
        if IsValid(ent) then
            local ang = ply:EyeAngles()
            ent:SetPos(ply:GetPos() + Angle(0, ang.y, 0):Forward() * dist)
            ent:SetAngles(Angle(0, ang.y + 180, 0))
            ent:Spawn()
            ent:Activate()
            table.insert(job.results.spawned, ent:EntIndex())
        else
            table.insert(job.results.errors, "spawn failed: " .. class)
        end
    elseif cmd == "cmd" then
        game.ConsoleCommand(rest .. "\n")
    elseif cmd == "ccmd" then
        ply:ConCommand(rest)
    elseif cmd == "lua" then
        local fn = CompileString("local ply, job = ... " .. rest, "harness_lua", false)
        if isfunction(fn) then
            local ok, err = pcall(fn, ply, job)
            if !ok then table.insert(job.results.errors, "lua: " .. tostring(err)) end
        else
            table.insert(job.results.errors, "lua compile: " .. tostring(fn))
        end
    elseif cmd == "clua" then
        send(ply, "clua", rest)
    elseif cmd == "marker" then
        send(ply, "marker", rest)
    elseif cmd == "quit" then
        finishJob(job)
        H.Job = nil
        game.ConsoleCommand("quit\n")
        return "stop"
    else
        table.insert(job.results.errors, "unknown command: " .. line)
    end
end

local function tick()
    local ply = firstPlayer()
    if !IsValid(ply) then return end

    if !H.Job then
        local files = file.Find(QUEUE .. "*.txt", "DATA")
        if #files == 0 then return end
        table.sort(files)
        local fname = files[1]
        local text = file.Read(QUEUE .. fname, "DATA") or ""
        file.Delete(QUEUE .. fname)
        local lines = {}
        for raw in string.gmatch(text, "[^\r\n]+") do
            local l = string.Trim(raw)
            if l != "" and string.sub(l, 1, 1) != "#" then table.insert(lines, l) end
        end
        H.Job = {name = string.StripExtension(fname), lines = lines, i = 0, results = {log = {}, errors = {}, shots = {}, reports = {}, spawned = {}}}
        log("job", H.Job.name, #lines .. " commands")
    end

    local job = H.Job
    if job.waituntil and CurTime() < job.waituntil then return end
    job.waituntil = nil
    if job.waitfile then
        if !file.Exists(job.waitfile, "DATA") then
            job.waitstart = job.waitstart or CurTime()
            if CurTime() - job.waitstart > 10 then
                table.insert(job.results.errors, "timed out waiting for " .. job.waitfile)
                job.waitfile = nil
                job.waitstart = nil
            else
                return
            end
        else
            job.waitfile = nil
            job.waitstart = nil
        end
    end

    job.i = job.i + 1
    if job.i > #job.lines then
        finishJob(job)
        H.Job = nil
        return
    end
    if step(job, ply, job.lines[job.i]) == "stop" then return end
end

timer.Create("MCV_Harness", 0.1, 0, function()
    local ok, err = pcall(tick)
    if !ok then log("tick error", tostring(err)) end
end)

hook.Add("PlayerInitialSpawn", "MCV_Harness", function(ply)
    file.Write(ROOT .. "ready.txt", os.date("%H:%M:%S ") .. game.GetMap())
    log("ready", game.GetMap())
end)

log("enabled")

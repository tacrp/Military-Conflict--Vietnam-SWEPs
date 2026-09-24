// Server-authoritative flight; clients simulate the same trajectory for tracers only.
function MCV.PhysicalBulletsEnabled(wep)
    if !MCV.ConVars.mcv_physbullets:GetBool() or wep:GetProjectileClass() then return false end
    if (wep.MuzzleVelocity or 0) <= 0 then return false end
    local owner = wep:GetOwner()
    if !IsValid(owner) then return false end
    if owner:IsNPC() and !MCV.ConVars.mcv_physbullets_npcs:GetBool() then return false end
    return wep:GetBulletCount() <= 1 or MCV.ConVars.mcv_physbullets_pellets:GetBool()
end

// Analytic integration of constant gravity and linear drag, independent of tick rate.
// Velocity is HU/s, gravity is HU/s^2, drag is inverse seconds.
function MCV.BulletFlightStep(pos, vel, dt, gravity, drag)
    local acceleration = Vector(0, 0, -gravity)
    if drag <= 0 then
        return pos + vel * dt + acceleration * (0.5 * dt * dt), vel + acceleration * dt
    end
    local decay = math.exp(-drag * dt)
    local factor = (1 - decay) / drag
    return pos + vel * factor + acceleration * ((dt - factor) / drag),
        vel * decay + acceleration * factor
end

function MCV.PhysicalBulletParameters(wep)
    return math.max(wep.MuzzleVelocity, 1) / 0.0254
            * math.Clamp(MCV.ConVars.mcv_physbullets_velocity:GetFloat(), 0.1, 3),
        9.80665 / 0.0254 * math.Clamp(MCV.ConVars.mcv_physbullets_gravity:GetFloat(), 0, 3),
        math.Clamp(MCV.ConVars.mcv_physbullets_drag:GetFloat(), 0, 2),
        math.Clamp(MCV.ConVars.mcv_physbullets_lifetime:GetFloat(), 0.1, 10)
end

function MCV.PhysicalShotKey(wep)
    local owner = wep:GetOwner()
    if !owner:IsPlayer() then return "" end
    local cmd = owner:GetCurrentCommand()
    if !cmd or cmd:CommandNumber() == 0 then return "" end
    return wep:EntIndex() .. ":" .. cmd:CommandNumber() .. ":" .. wep:Clip1() .. ":" .. wep:GetBurstCount()
end

function MCV.PhysicalImpactKey(owner, key, pellet, serverID)
    if key == "" then return "server:" .. serverID end
    return owner:EntIndex() .. ":" .. key .. ":" .. pellet
end

function MCV.PhysicalBulletCount(wep)
    local count = wep:GetBulletCount()
    if wep:GetFiremodeValue() == MCV.FIREMODE_VOLLEY then
        count = count * math.min(wep:Clip1(), wep.VolleyCount)
    end
    return count
end

function MCV.PhysicalBulletHeading(wep, dir, pellet, key)
    local owner = wep:GetOwner()
    local spread = owner:IsNPC() and wep:GetNPCSpread() or wep:GetSpread()
    local draw = 0
    local function random()
        draw = draw + 1
        if key == "" then return math.Rand(-0.5, 0.5) end
        return util.SharedRandom("MCV_PhysicalSpread:" .. key, -0.5, 0.5, pellet * 256 + draw)
    end
    local x, y
    repeat x, y = random() + random(), random() + random() until x*x + y*y <= 1
    local angle = dir:Angle()
    return (dir + angle:Right() * (x * spread) + angle:Up() * (y * spread)):GetNormalized()
end

// The game's tracer particles, drawn from the gun that fired: the viewmodel's muzzle in first
// person, the drawn world model's in third person (the left gun of a dual on magnitude 1).
// The server sends the hit position; the origin is worked out here, where the drawn models
// live. Flags: 1 the smoke trail, 2 the bright tracer.
function EFFECT:Init(data)
    local wpn = data:GetEntity()
    if !IsValid(wpn) then return end
    local owner = wpn:GetOwner()
    local to = data:GetOrigin()
    local left = data:GetMagnitude() >= 0.5
    local flags = data:GetFlags()

    local from
    if IsValid(owner) and owner == LocalPlayer() and !owner:ShouldDrawLocalPlayer() then
        local vm = owner:GetViewModel()
        if IsValid(vm) then
            local att = 0
            if left then
                att = vm:LookupAttachment("muzzleleft")
                if att <= 0 then att = vm:LookupAttachment("muzzle2") end
            end
            if att <= 0 then att = vm:LookupAttachment("muzzle") end
            local a = att > 0 and vm:GetAttachment(att)
            if a then from = self:ViewModelToWorld(a.Pos, wpn) end
        end
    elseif wpn.GetWorldModelAttachment then
        local mdl, att = wpn:GetWorldModelAttachment("muzzle", left)
        if IsValid(mdl) and att > 0 then
            mdl:SetupBones()
            local a = mdl:GetAttachment(att)
            if a then from = a.Pos end
        end
    end
    if !from then
        from = IsValid(owner) and owner.GetShootPos and owner:GetShootPos() or wpn:GetPos()
    end

    local tracer = wpn.TracerParticle
    if !tracer or tracer == "" then return end
    local smoke = wpn.TracerSmokeParticle or string.gsub(tracer, "_primary$", "_smoke")
    if bit.band(flags, 1) != 0 and smoke and smoke != tracer then
        self:Trail(smoke, from, to)
    end
    if bit.band(flags, 2) != 0 then
        self:Trail(tracer, from, to)
    end
end

// The viewmodel is drawn with its own FOV (cl PreDrawViewModel), so a point on it sits on the
// screen where the world FOV would put a point with its lateral offsets from the eye scaled
// by the ratio of the two projections. The trail draws in the world, so its start is moved
// there; otherwise it leaves from well inside the muzzle's screen position.
function EFFECT:ViewModelToWorld(pos, wpn)
    local vs = render.GetViewSetup()
    local eye, ang = vs and vs.origin or EyePos(), vs and vs.angles or EyeAngles()
    local worldfov = vs and vs.fov or LocalPlayer():GetFOV()
    local vmfov = wpn.VMFov or worldfov
    if !worldfov or !vmfov or worldfov <= 0 or vmfov <= 0 or worldfov == vmfov then return pos end
    local k = math.tan(math.rad(worldfov * 0.5)) / math.tan(math.rad(vmfov * 0.5))
    local rel = WorldToLocal(pos, angle_zero, eye, ang)
    rel.y = rel.y * k
    rel.z = rel.z * k
    return LocalToWorld(rel, angle_zero, eye, ang)
end

// A two-point trail: control point 0 the start, 1 the end (what a tracer particle expects).
// util.ParticleTracerEx binds the start to the entity it is given, and with no entity that is
// the world's origin, so the system is made here with its points set outright.
function EFFECT:Trail(name, from, to)
    local ps = CreateParticleSystemNoEntity and CreateParticleSystemNoEntity(name, from)
    if ps then
        ps:SetControlPoint(0, from)
        ps:SetControlPoint(1, to)
        return
    end
    util.ParticleTracerEx(name, from, to, false, -1, 0)
end

function EFFECT:Think() return false end
function EFFECT:Render() end

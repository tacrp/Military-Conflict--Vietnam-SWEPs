// The game's tracer particles, drawn from the gun that fired: the viewmodel's muzzle in first
// person, the drawn world model's in third person (the left gun of a dual on magnitude 1).
// The server sends the hit position; the origin is worked out here, where the drawn models
// live. Flags: 1 the smoke trail, 2 the bright tracer.
function EFFECT:Init(data)
    local wpn = data:GetEntity()
    if !IsValid(wpn) then return end
    local owner = wpn:GetOwner()
    local to = data:GetOrigin()
    local left = data:GetMagnitude() == 1
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
            if a then from = a.Pos end
        end
    elseif wpn.GetWorldModelAttachment then
        local mdl, att = wpn:GetWorldModelAttachment("muzzle", left)
        local a = att > 0 and mdl:GetAttachment(att)
        if a then from = a.Pos end
    end
    if !from then
        from = IsValid(owner) and owner.GetShootPos and owner:GetShootPos() or wpn:GetPos()
    end

    local tracer = wpn.TracerParticle
    if !tracer or tracer == "" then return end
    local smoke = wpn.TracerSmokeParticle or string.gsub(tracer, "_primary$", "_smoke")
    if bit.band(flags, 1) != 0 and smoke and smoke != tracer then
        util.ParticleTracerEx(smoke, from, to, false, 0, 0)
    end
    if bit.band(flags, 2) != 0 then
        util.ParticleTracerEx(tracer, from, to, false, 0, 0)
    end
end

function EFFECT:Think() return false end
function EFFECT:Render() end

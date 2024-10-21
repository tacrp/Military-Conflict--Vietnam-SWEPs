function SWEP:CanBipod()
    local owner = self:GetOwner()

    local pos = owner:EyePos()
    ang = ang or owner:EyeAngles()

    local maxs = Vector(2, 2, 2)
    local mins = Vector(-2, -2, -48)

    local tr = util.TraceLine({
        start = pos,
        endpos = pos + (ang:Forward() * 64),
        filter = owner,
        mask = MASK_PLAYERSOLID
    })

    if tr.Hit then return end

    -- ang:RotateAroundAxis(ang:Right(), -30)

    local d = (tr.HitPos - pos):Length()
    d = d / 2

    mins.z = -d

    local tr2 = util.TraceHull({
        start = pos,
        endpos = pos + (ang:Forward() * 24),
        filter = owner,
        maxs = maxs,
        mins = mins,
        mask = MASK_PLAYERSOLID
    })

    if tr2.Hit then
        return true
    else
        return false
    end
end

function SWEP:Think_Bipod()
    if !self.HasBipod then return end

    local owner = self:GetOwner()

    if !self:GetBipod() then
        if owner:KeyPressed(IN_USE) and self:CanBipod() then
            self:PlayAnimation(ACT_VM_DEPLOYED_IN, 1, true)
            self:SetBipod(true)
        end
    else
        if !self:CanBipod() and !self:GetReloading() and !self:StillWaiting() then
            self:PlayAnimation(ACT_VM_DEPLOYED_OUT, 1, true)
            self:SetBipod(false)
        end
    end
end

function SWEP:ScopeToggle(on)
    on = on or !self:GetIronsight()

    if on and !self.Ironsight then return end
    if self:GetReloading() then on = false end

    if on == self:GetIronsight() then return end

    self:SetIronsight(on)

    if on then
        self:SetLastScopeTime(CurTime())
    end

    if on then
        self:EmitSound("MCV_Weapon_Foley_Ironsights.In")
    else
        self:EmitSound("MCV_Weapon_Foley_Ironsights.Out")
    end
end

function SWEP:Think_Sights()
    local owner = self:GetOwner()
    local target_sight_amount = 0

    if self:GetIronsight() and !self:GetIsSprinting() then
        target_sight_amount = 1
    end

    if owner:KeyDown(IN_ATTACK2) and !self:GetIronsight() and !owner:KeyDown(IN_USE) and !self:StillWaiting() then
        self:ScopeToggle(true)
    elseif !owner:KeyDown(IN_ATTACK2) and self:GetIronsight() then
        self:ScopeToggle(false)
    end

    self:SetSightAmount(math.Approach(self:GetSightAmount(), target_sight_amount, FrameTime() / 0.2 * self.IronsightSpeedScale))
end

function SWEP:GetViewModelPosition(pos, ang)
    local offsetpos = Vector(0, 0, 0)
    local offsetang = Angle(0, 0, 0)

    local aim_delta = self:GetSightAmount()

    offsetpos = LerpVector(aim_delta, self.CustomPos, self.IronsightPos)
    offsetang = LerpAngle(aim_delta, self.CustomAng, self.IronsightAng)

    pos = pos + (ang:Right() * offsetpos.x)
    pos = pos + (ang:Forward() * offsetpos.y)
    pos = pos + (ang:Up() * offsetpos.z)

    ang:RotateAroundAxis(ang:Up(), offsetang.p)
    ang:RotateAroundAxis(ang:Right(), offsetang.y)
    ang:RotateAroundAxis(ang:Forward(), offsetang.r)

    return pos, ang
end

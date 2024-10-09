
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

    if self:GetIronsight() then
        target_sight_amount = 1
    end

    if owner:KeyDown(IN_ATTACK2) and !self:GetIronsight() and !owner:KeyDown(IN_USE) then
        self:ScopeToggle(true)
    elseif !owner:KeyDown(IN_ATTACK2) and self:GetIronsight() then
        self:ScopeToggle(false)
    end

    self:SetSightAmount(math.Approach(self:GetSightAmount(), target_sight_amount, FrameTime() / 0.2 * self.IronsightSpeedScale))
end
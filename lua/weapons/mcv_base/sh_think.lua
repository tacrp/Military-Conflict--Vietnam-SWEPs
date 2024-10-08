function SWEP:Think()
    local owner = self:GetOwner()
    local vm = owner:GetViewModel()

    self:Think_Sights()
    self:Think_Reload()

    if self:GetNextIdle() <= CurTime() then
        self:Idle()
    end

    if !IsValid(vm) then return end

    if self:GetReloading() then
        vm:SetPoseParameter("ammo_fraction", 1 - (self:Clip1() / self.Primary.ClipSize))
    else
        vm:SetPoseParameter("ammo_fraction", (self:Clip1() / self.Primary.ClipSize))
    end

    vm:SetPoseParameter("empty", self:Clip1() == 0 and 0 or 1)

    vm:SetPoseParameter("player_movement", (owner:GetVelocity():Length() / owner:GetRunSpeed()) * Lerp(self:GetSightAmount(), 273, 100))

    vm:SetPoseParameter("ironsight", self:GetSightAmount())
    vm:SetPoseParameter("move_yaw", 0)
end

function SWEP:Think_Sights()
    local owner = self:GetOwner()
    local target_sight_amount = 0

    if owner:KeyDown(IN_ATTACK2) then
        target_sight_amount = 1
    end

    self:SetSightAmount(math.Approach(self:GetSightAmount(), target_sight_amount, FrameTime() / 0.2 * self.IronsightSpeedScale))
end


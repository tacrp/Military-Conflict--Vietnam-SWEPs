function SWEP:Think()
    local owner = self:GetOwner()
    local vm = owner:GetViewModel()

    self:Think_Sights()
    self:Think_Reload()
    self:Think_Speed()

    if self:GetNextIdle() <= CurTime() then
        self:Idle()
    end

    if owner:KeyReleased(IN_ATTACK) then
        self:SetNeedTriggerPress(false)
    end

    if !IsValid(vm) then return end

    if self:GetReloading() then
        local bullets_to_load = math.min(self.Primary.ClipSize - self:Clip1(), self:Ammo1())
        vm:SetPoseParameter("ammo_fraction", bullets_to_load / self.Primary.ClipSize)
    else
        vm:SetPoseParameter("ammo_fraction", (self:Clip1() / self.Primary.ClipSize))
    end

    vm:SetPoseParameter("empty", self:Clip1() == 0 and 0 or 1)

    vm:SetPoseParameter("player_movement", self:GetSpeed() * Lerp(self:GetSightAmount(), 1, (1 + self.IronsightWalkBobbingStrength)))

    vm:SetPoseParameter("ironsight", self:GetSightAmount() ^  3)
end

function SWEP:Think_Sights()
    local owner = self:GetOwner()
    local target_sight_amount = 0

    if owner:KeyDown(IN_ATTACK2) then
        target_sight_amount = 1
    end

    if owner:KeyPressed(IN_ATTACK2) then
        self:EmitSound("MCV_Weapon_Foley_Ironsights.In")
    elseif owner:KeyReleased(IN_ATTACK2) then
        self:EmitSound("MCV_Weapon_Foley_Ironsights.Out")
    end

    self:SetSightAmount(math.Approach(self:GetSightAmount(), target_sight_amount, FrameTime() / 0.2 * self.IronsightSpeedScale))
end

function SWEP:Think_Speed()
    local target_speed = 0

    local speed = self:GetSpeed()

    local owner = self:GetOwner()

    if !owner:IsOnGround() then
        target_speed = 100
    else
        if owner:KeyDown(IN_FORWARD) or owner:KeyDown(IN_MOVERIGHT) or owner:KeyDown(IN_MOVELEFT) or owner:KeyDown(IN_BACK) then
            if owner:KeyDown(IN_SPEED) then
                target_speed = 273
            elseif owner:KeyDown(IN_WALK) then
                target_speed = 25
            else
                target_speed = 120
            end
        end
    end

    speed = math.Approach(speed, target_speed, FrameTime() * 1000)

    self:SetSpeed(speed)
end
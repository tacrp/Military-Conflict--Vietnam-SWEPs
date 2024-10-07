function SWEP:Think()
    local owner = self:GetOwner()
    local vm = owner:GetViewModel()

    self:Think_Sights()

    if !IsValid(vm) then return end

    vm:SetPoseParameter("ammo_fraction", self:Clip1() / self:GetMaxClip1())
    vm:SetPoseParameter("empty", self:Clip1() == 0 and 1 or 0)
    vm:SetPoseParameter("player_movement", owner:GetVelocity():Length() / owner:GetRunSpeed() * 273)
    vm:SetPoseParameter("ironsight", 0)
    vm:SetPoseParameter("move_yaw", 0)
end

function SWEP:Think_Sights()
    local owner = self:GetOwner()
    local target_sight_amount = 0

    if owner:KeyDown(IN_ATTACK2) then
        target_sight_amount = 1
    end

    self:SetSightAmount(math.Approach(self:GetSightAmount(), target_sight_amount, FrameTime()))
end
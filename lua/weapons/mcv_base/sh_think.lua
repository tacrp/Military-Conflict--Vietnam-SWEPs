function SWEP:Think()
    local owner = self:GetOwner()
    local vm = owner:GetViewModel()

    self:Think_Sights()
    self:Think_Reload()
    self:Think_Speed()

    self:ProcessTimers()

    if self:GetNextIdle() <= CurTime() then
        self:Idle()
    end

    if owner:KeyReleased(IN_ATTACK) then
        self:SetNeedTriggerPress(false)
    elseif self:GetReloading() and self.ShotgunReload and owner:KeyPressed(IN_ATTACK) then
        self:SetEndReload(true)
    end

    if !IsValid(vm) then return end

    local displayRoundsToLoad = self:GetReloading()

    if displayRoundsToLoad then
        local reloadprogress = (self:GetAnimLockTime() - CurTime())

        if self:Clip1() == 0 then
            displayRoundsToLoad = reloadprogress >= self.MagInTimeEmpty
        else
            displayRoundsToLoad = reloadprogress >= self.MagInTime
        end
    end

    local bodygroupbulletscount = self:Clip1()

    if displayRoundsToLoad then
        if self.ShotgunReload and self:GetReloading() and self:GetEmptyReload() then
            vm:SetPoseParameter("ammo_fraction", 0)
            bodygroupbullets = 0
        else
            if self.MagInClip then
                local bullets_to_load = math.min(self.Primary.ClipSize - self:Clip1(), self:Ammo1())

                vm:SetPoseParameter("ammo_fraction", bullets_to_load / self.Primary.ClipSize)
                bodygroupbulletscount = bullets_to_load
            else
                local reserve = self:GetInfiniteAmmo() and math.huge or (self:Clip1() + self:Ammo1())
                local bullets_to_load = math.min(self.Primary.ClipSize, self:GetClip1Capacity(), reserve)

                vm:SetPoseParameter("ammo_fraction", bullets_to_load / self.Primary.ClipSize)
                bodygroupbulletscount = bullets_to_load
            end
        end
    else
        vm:SetPoseParameter("ammo_fraction", (self:Clip1() / self.Primary.ClipSize))
    end

    if self.BulletBodygroups then
        for i, bg in pairs(self.BulletBodygroups) do
            if i > bodygroupbulletscount then
                vm:SetBodygroup(bg[1], bg[2])
            else
                vm:SetBodygroup(bg[1], 0)
            end
        end
    end

    vm:SetPoseParameter("empty", self:Clip1() == 0 and 0 or 1)

    vm:SetPoseParameter("player_movement", self:GetSpeed() * Lerp(self:GetSightAmount(), 1, (1 + self.IronsightWalkBobbingStrength)))

    vm:SetPoseParameter("ironsight", self:GetSightAmount() ^  3)

    if self:GetBayonet() then
        vm:SetBodygroup(self.BayonetBodygroup, 1)
    else
        vm:SetBodygroup(self.BayonetBodygroup, 0)
    end

    if IsValid(self.MuzzleLight) then
        if (self.MuzzleLightEnd or 0) < UnPredictedCurTime() then
            self.MuzzleLight:Remove()
            self.MuzzleLight = nil
        else
            local att = vm:GetAttachment(1)
            self.MuzzleLight:SetPos(att.Pos)
            self.MuzzleLight:SetAngles(att.Ang)
            self.MuzzleLight:Update()
        end
    end
end

function SWEP:Think_Speed()
    local target_speed = 0

    local speed = self:GetSpeed()

    local owner = self:GetOwner()

    if !owner:IsOnGround() then
        target_speed = 0
    else
        if owner:KeyDown(IN_FORWARD) or owner:KeyDown(IN_MOVERIGHT) or owner:KeyDown(IN_MOVELEFT) or owner:KeyDown(IN_BACK) then
            if owner:KeyDown(IN_SPEED) then
                target_speed = 273
            elseif owner:KeyDown(IN_WALK) then
                target_speed = 25
            else
                target_speed = 100
            end
        end
    end

    speed = math.Approach(speed, target_speed, FrameTime() * 750)

    self:SetSpeed(speed)
end
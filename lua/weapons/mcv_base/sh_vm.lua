function SWEP:DoBodygroups()
    local owner = self:GetOwner()
    local vm = owner:GetViewModel()

    if !IsValid(vm) then return end

    vm:SetBodyGroups(self.BodyGroups)

    local displayRoundsToLoad = self:GetReloading()

    if displayRoundsToLoad then
        local reloadprogress = vm:SequenceDuration() - (self:GetAnimLockTime() - CurTime())

        if self:Clip1() == 0 then
            displayRoundsToLoad = reloadprogress >= self.MagInTimeEmpty
        else
            displayRoundsToLoad = reloadprogress >= self.MagInTime
        end
    end

    local bodygroupbulletscount = self:Clip1()
    local clipsize = self.Primary.ClipSize

    if self:GetAkimbo() then
        clipsize = clipsize * 2
    end

    if displayRoundsToLoad then
        if (self.ShotgunReload or (self.HybridReload and self:Clip1() > 0)) and self:GetReloading() and self:GetEmptyReload() then
            if self.MagInClip then
                local bullets_to_load = self:Clip1()

                vm:SetPoseParameter("ammo_fraction", bullets_to_load / clipsize)
                bodygroupbulletscount = bullets_to_load
            else
                vm:SetPoseParameter("ammo_fraction", 0)
                bodygroupbullets = 0
            end
        else
            if self.MagInClip then
                local bullets_to_load = math.min(clipsize - self:Clip1(), self:Ammo1())

                vm:SetPoseParameter("ammo_fraction", bullets_to_load / clipsize)
                bodygroupbulletscount = bullets_to_load
            else
                local reserve = self:GetInfiniteAmmo() and math.huge or (self:Clip1() + self:Ammo1())
                local bullets_to_load = math.min(clipsize, self:GetClip1Capacity(), reserve)

                vm:SetPoseParameter("ammo_fraction", bullets_to_load / clipsize)
                bodygroupbulletscount = bullets_to_load
            end
        end
    else
        vm:SetPoseParameter("ammo_fraction", self:Clip1() / clipsize)
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

    if self:GetGrenadeLauncher() then
        vm:SetBodygroup(self.GrenadeLauncherBodygroup, 1)

        local reloadprogress = vm:SequenceDuration() - (self:GetAnimLockTime() - CurTime())

        if self:Clip2() > 0 or (self:GetReloading() and reloadprogress > self.MagInTimeGrenade) then
            vm:SetBodygroup(self.GrenadeBodygroup, 1)
        else
            vm:SetBodygroup(self.GrenadeBodygroup, 0)
        end
    else
        vm:SetBodygroup(self.GrenadeLauncherBodygroup, 0)
        vm:SetBodygroup(self.GrenadeBodygroup, 0)
    end

    if self.RevolverFiremodePose then
        local pose = 0

        local fm = self:GetFiremodeValue()

        if self:GetAkimbo() then
            if fm == MCV.FIREMODE_DA then
                pose = 1
            end
        else
            if fm == MCV.FIREMODE_FAN then
                pose = 1
            elseif fm == MCV.FIREMODE_DA then
                pose = 0.5
            end
        end

        vm:SetPoseParameter("revolver_firemode_pose", pose)
    end
end

function SWEP:PreDrawViewModel()
    self.RenderingRTScope = false
    if self:GetHolsterTime() < CurTime() then
        self:DoRTScope()
    end

    self:DoBodygroups()

    cam.Start3D(nil, nil, Lerp(self:GetSightAmount() ^ 3, self.ViewModelFOV, self.SightedViewModelFOV))
    cam.IgnoreZ(true)

    if self.OEGScope and self:GetSightAmount() > 0.6 then
        render.SetBlend(0.2)
    end
end


function SWEP:ViewModelDrawn()
    local newactiveeffects = {}
    for _, effect in ipairs(self.ActiveEffects) do
        if !IsValid(effect) then continue end
        if !effect.VMContext then continue end

        effect:DrawModel()

        table.insert(newactiveeffects, effect)
    end

    self.ActiveEffects = newactiveeffects
end

function SWEP:PostDrawViewModel()
    cam.End3D()
    cam.IgnoreZ(false)

    cam.Start3D()
        cam.IgnoreZ(false)
        local newpcfs = {}

        for _, pcf in ipairs(self.PCFs) do
            if pcf and IsValid(pcf) and pcf.Render then
                pcf:Render()
                table.insert(newpcfs, pcf)
            end
        end

        if !inrt then self.PCFs = newpcfs end
    cam.End3D()
end
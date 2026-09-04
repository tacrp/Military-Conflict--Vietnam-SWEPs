// Drives viewmodel bodygroups and pose parameters.
//
// Called from two places on purpose:
//  * Think (server, and the predicting client in multiplayer) with the deterministic
//    gameplay values. Viewmodel bodygroups and pose parameters are networked from the
//    server, so if the server never wrote them the client would keep receiving zeros
//    that fight what it draws (visible as a flickering "ghost" viewmodel, worst in
//    singleplayer where the client does not predict).
//  * PreDrawViewModel (client, every rendered frame) with `visual = true`, using the
//    frame-smoothed values so the pose is exact for the frame being drawn.
function SWEP:DoBodygroups(vm, visual)
    local owner = self:GetOwner()
    if !IsValid(owner) or !owner:IsPlayer() then return end

    vm = vm or owner:GetViewModel()

    if !IsValid(vm) then return end

    local sa, speed

    if visual then
        sa = self:GetSightAmountVisual()
        speed = self:GetSpeedVisual()
    else
        sa = self:GetSightAmount()
        speed = self:GetSpeed()
    end

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
                bodygroupbulletscount = 0
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

    local shouldhammer = self:GetNeedCycle() or self:GetEmptyReload() or ((self.ShotgunReload or !self:GetReloading()) and self:Clip1() == 0)

    if self.InvertAnimationHammer then
        shouldhammer = !shouldhammer
    end

    vm:SetPoseParameter("hammerpos", shouldhammer and 0 or 1)

    vm:SetPoseParameter("empty", self:Clip1() == 0 and 0 or 1)

    vm:SetPoseParameter("player_movement", speed * Lerp(sa, 1, (1 + self.IronsightWalkBobbingStrength)))

    vm:SetPoseParameter("ironsight", sa ^ 3)

    // Dual wield pose-driven recoil: 0 = frame 0 of the hand's shoot animation, 1 = at rest.
    if self:GetAkimbo() and self:HasPoseRecoil() then
        local len = math.max(self.AkimboRecoilTime, 0.01)
        vm:SetPoseParameter("recoil_r", math.Clamp((CurTime() - self:GetLastShotTimeR()) / len, 0, 1))
        vm:SetPoseParameter("recoil_l", math.Clamp((CurTime() - self:GetLastShotTimeL()) / len, 0, 1))
    end

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

// Keeps the muzzle flash light attached to the muzzle for the few frames it lives.
// Runs per rendered frame (not per tick) so the light does not lag behind the viewmodel.
function SWEP:UpdateMuzzleLight(vm)
    local lamp = self.MuzzleLight
    if !lamp then return end

    if !IsValid(lamp) or (self.MuzzleLightEnd or 0) < UnPredictedCurTime() then
        if IsValid(lamp) then lamp:Remove() end
        self.MuzzleLight = nil
        return
    end

    local att = vm:GetAttachment(1)
    if !att then return end

    lamp:SetPos(att.Pos)
    lamp:SetAngles(att.Ang)
    lamp:Update()
end

function SWEP:PreDrawViewModel(vm)
    vm = vm or self:GetOwner():GetViewModel()

    self.RenderingRTScope = false
    if self:GetHolsterTime() < CurTime() then
        self:DoRTScope()
    end

    self:DoBodygroups(vm, true)
    self:UpdateMuzzleLight(vm)

    local sa = self:GetSightAmountVisual() ^ 3

    cam.Start3D(nil, nil, Lerp(sa, self.ViewModelFOV, self.SightedViewModelFOV))
    cam.IgnoreZ(true)

    if self.OEGScope and sa > 0.216 then // 0.6 ^ 3
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
    render.SetBlend(1)

    cam.Start3D()
        cam.IgnoreZ(false)
        local newpcfs = {}

        for _, pcf in ipairs(self.PCFs) do
            if pcf and IsValid(pcf) and pcf.Render then
                pcf:Render()
                table.insert(newpcfs, pcf)
            end
        end

        self.PCFs = newpcfs
    cam.End3D()
end
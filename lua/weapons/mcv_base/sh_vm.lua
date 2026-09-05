// Gun bodygroups and pose parameters (called from mcv_base_core/sh_vm.lua DoBodygroups
// with the gameplay values from Think and the frame-smoothed values from PreDrawViewModel).
function SWEP:DoBodygroupsWeapon(vm, visual, sa, speed)
    local displayRoundsToLoad = self:GetReloading()
    local magOut = false // the old magazine / belt is out and the new one not yet in

    if displayRoundsToLoad then
        local reloadprogress = vm:SequenceDuration() - (self:GetAnimLockTime() - CurTime())
        local empty = self:Clip1() == 0
        local tin = empty and self.MagInTimeEmpty or self.MagInTime
        local tout = empty and self.MagOutTimeEmpty or self.MagOutTime

        displayRoundsToLoad = reloadprogress >= tin
        magOut = !displayRoundsToLoad and !self.MagInClip and tout > 0 and reloadprogress >= tout
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
    elseif magOut then
        vm:SetPoseParameter("ammo_fraction", 0)
        bodygroupbulletscount = 0
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

    // 1 = clip empty. The game's SlidePosition / BoltshootMovement layers blend towards the
    // locked-back bolt (and the non-cycling last shot) as this goes from 0.6 to 1.
    vm:SetPoseParameter("empty", self:Clip1() == 0 and 1 or 0)

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

function SWEP:PreDrawViewModelWeapon(vm)
    self.RenderingRTScope = false
    if self:GetHolsterTime() < CurTime() then
        self:DoRTScope()
    end

    self:UpdateMuzzleLight(vm)
end

// Occluded eye gunsight: one eye sees the gun and the dot, the other the scene, and the brain
// overlays them. Drawn as the opaque viewmodel with a copy of the frame from before the
// viewmodel composited on top at OEGSceneAlpha, so the gun reads as one half-transparent
// plane instead of a blend of every face that showed its innards.
SWEP.OEGSceneAlpha = 0.5

// Own copy of the frame: the gun's Refract lens materials refresh _rt_FullFrameFB while the
// viewmodel draws, so a plain screen-effect copy ends up containing the gun.
local scenert = CLIENT and GetRenderTarget("mcv_oeg_scene", ScrW(), ScrH(), false)
local scenemat = CLIENT and CreateMaterial("mcv_oeg_scene", "UnlitGeneric", {
    ["$basetexture"] = scenert:GetName(),
    ["$vertexalpha"] = "1",
    ["$vertexcolor"] = "1",
})
if CLIENT then scenemat:SetTexture("$basetexture", scenert) end

function SWEP:PreDrawViewModelBlend(vm, sa)
    // the hooks run for all three viewmodels; only the gun's own pass gets the frame copy,
    // a later pass would copy the drawn gun and composite it over itself
    if vm != self:GetOwner():GetViewModel() then return end
    self.OEGComposite = false
    if self.OEGScope and sa > 0.216 then // 0.6 ^ 3
        render.CopyRenderTargetToTexture(scenert)
        self.OEGComposite = true
    end
end

function SWEP:PostDrawViewModelWeapon(vm)
    if self.RenderingRTScope then
        render.OverrideDepthEnable(false, false)
    end
    if !self.OEGComposite or vm != self:GetOwner():GetViewModel() then return end
    self.OEGComposite = false
    local a = Lerp(math.Clamp((self:GetSightAmountVisual() - 0.6) / 0.4, 0, 1), 0, self.OEGSceneAlpha)
    if a <= 0 then return end
    cam.Start2D()
        surface.SetMaterial(scenemat)
        surface.SetDrawColor(255, 255, 255, a * 255)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    cam.End2D()
end

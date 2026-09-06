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

    // walk / run layers of every game viewmodel blend on this (sh_think.lua GetMovementPose)
    vm:SetPoseParameter("player_movement", self:GetMovementPose(speed, sa))

    self:DoBodygroupsWeapon(vm, visual, sa, speed)
end

// Class-level defaults only; SWEP:Initialize creates per-instance tables.
SWEP.ActiveEffects = {}
SWEP.PCFs = {}

function SWEP:PreDrawViewModel(vm)
    vm = vm or self:GetOwner():GetViewModel()
    if self:ViewModelHidden() then return true end

    self:PreDrawViewModelWeapon(vm)
    self:UpdateLitParticle(vm)

    self:DoBodygroups(vm, true)

    local sa = self:GetSightAmountVisual() ^ 3

    local fov = Lerp(sa, self.ViewModelFOV, self.SightedViewModelFOV)
    if self.ViewModelZNear then
        // a closer near plane keeps an eyepiece the aimed pose puts right at the camera from
        // being cut open (scoped rifles)
        cam.Start3D(nil, nil, fov, 0, 0, ScrW(), ScrH(), self.ViewModelZNear, 32768)
    else
        cam.Start3D(nil, nil, fov)
    end
    cam.IgnoreZ(true)

    self:PreDrawViewModelBlend(vm, sa)
end

// Runs inside the viewmodel's own render pass (the camera PreDrawViewModel set up: the weapon's
// viewmodel FOV and near plane, the engine's viewmodel depth range), so the in-flight shells
// share the gun's projection and sort against it. TacRP's system: a shell lives here until it
// hits something, then draws itself in the world. Nothing is drawn into the depth passes.
function SWEP:ViewModelDrawn(vm, flags)
    flags = flags or 0
    if bit.band(flags, STUDIO_SSAODEPTHTEXTURE) != 0 or bit.band(flags, STUDIO_SHADOWDEPTHTEXTURE) != 0 then return end

    local newactiveeffects = {}
    for _, effect in ipairs(self.ActiveEffects) do
        if !IsValid(effect) then continue end
        if !effect.VMContext then continue end

        effect:DrawModel()

        table.insert(newactiveeffects, effect)
    end

    self.ActiveEffects = newactiveeffects
end

// the lit flame follows the viewmodel's attachment; started when the item lights, stopped
// when it leaves the hand or the weapon is put away (ClientHolster)
function SWEP:UpdateLitParticle(vm)
    if vm != self:GetOwner():GetViewModel() then return end
    local particle = self:GetLitParticle()
    local lit = particle != nil and self:IsLit()
    if lit == (self.VMLit or false) then return end
    self.VMLit = lit
    if lit then
        local att = vm:LookupAttachment(self.LitAttachment)
        ParticleEffectAttach(particle, PATTACH_POINT_FOLLOW, vm, att > 0 and att or 0)
    else
        vm:StopParticles()
    end
end

function SWEP:PostDrawViewModel(vm, ply, wep, flags)
    flags = flags or 0
    local depthpass = bit.band(flags, STUDIO_SSAODEPTHTEXTURE) != 0 or bit.band(flags, STUDIO_SHADOWDEPTHTEXTURE) != 0

    // the viewmodel particle systems (muzzle flash and smoke, shell puffs and trails) are drawn
    // here by hand, still inside the camera PreDrawViewModel started, so they sit exactly on
    // the gun's attachments at its FOV and depth-test against it; they used to be drawn after
    // that camera was closed, in a plain 3D context at the world FOV, which put the flash off
    // the muzzle whenever the two FOVs differed and let the gun paint over it
    local worldpcfs = {}
    if !depthpass then
        cam.IgnoreZ(false)
        local newpcfs = {}

        for _, pcf in ipairs(self.PCFs) do
            if pcf and IsValid(pcf) and pcf.Render then
                if pcf.WorldContext then
                    table.insert(worldpcfs, pcf)
                else
                    pcf:Render()
                end
                table.insert(newpcfs, pcf)
            end
        end

        self.PCFs = newpcfs
    end

    cam.End3D()
    cam.IgnoreZ(false)
    render.SetBlend(1)

    if depthpass then return end

    // systems that reach out into the world (the flamethrower's jet) keep the world's
    // projection, or they would not land where they burn
    if #worldpcfs > 0 then
        cam.Start3D()
            cam.IgnoreZ(false)
            for _, pcf in ipairs(worldpcfs) do pcf:Render() end
        cam.End3D()
    end

    self:PostDrawViewModelWeapon(vm or self:GetOwner():GetViewModel())
end

function SWEP:GetViewModelPosition(pos, ang)
    local aim_delta = self:GetSightAmountVisual()
    local aim_punch = self:GetOwner():GetViewPunchAngles()

    local ipos, iang = self.IronsightPos, self.IronsightAng
    // the dual models aim from their own script offsets where those differ
    if self.GetAkimbo and self:GetAkimbo() and self.IronsightPosAkimbo then
        ipos, iang = self.IronsightPosAkimbo, self.IronsightAngAkimbo or iang
    end
    local offsetpos = LerpVector(aim_delta, self.CustomPos, ipos)
    local offsetang = LerpAngle(aim_delta, self.CustomAng, iang)

    // the gun points where it shoots: the hip sway of realistic mode turns the whole viewmodel
    if self.GetAimSway then
        local sw = self:GetAimSway(true)
        if sw != angle_zero then
            ang:RotateAroundAxis(ang:Right(), -sw.p)
            ang:RotateAroundAxis(ang:Up(), sw.y)
        end
    end

    pos:Add(ang:Right() * offsetpos.x)
    pos:Add(ang:Forward() * offsetpos.y)
    pos:Add(ang:Up() * offsetpos.z)

    // offsetang.y = offsetang.y + (aim_punch.p * 0.5)
    // offsetang.p = offsetang.p + (aim_punch.y * 0.5)

    // the script's ironsightpitch / yaw / roll: pitch turns about the viewmodel's right axis,
    // yaw about up (they were the other way round, which left the P38's 0.9 degree sight
    // pitch applied as a yaw and its front post below the notch)
    ang:RotateAroundAxis(ang:Right(), offsetang.p)
    ang:RotateAroundAxis(ang:Up(), offsetang.y)
    ang:RotateAroundAxis(ang:Forward(), offsetang.r)

    return pos, ang
end

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

    self:PreDrawViewModelWeapon(vm)

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

function SWEP:PostDrawViewModel(vm)
    cam.End3D()
    cam.IgnoreZ(false)
    render.SetBlend(1)

    self:PostDrawViewModelWeapon(vm or self:GetOwner():GetViewModel())

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

function SWEP:GetViewModelPosition(pos, ang)
    local aim_delta = self:GetSightAmountVisual()
    local aim_punch = self:GetOwner():GetViewPunchAngles()

    local offsetpos = LerpVector(aim_delta, self.CustomPos, self.IronsightPos)
    local offsetang = LerpAngle(aim_delta, self.CustomAng, self.IronsightAng)

    pos:Add(ang:Right() * offsetpos.x)
    pos:Add(ang:Forward() * offsetpos.y)
    pos:Add(ang:Up() * offsetpos.z)

    // offsetang.y = offsetang.y + (aim_punch.p * 0.5)
    // offsetang.p = offsetang.p + (aim_punch.y * 0.5)

    ang:RotateAroundAxis(ang:Up(), offsetang.p)
    ang:RotateAroundAxis(ang:Right(), offsetang.y)
    ang:RotateAroundAxis(ang:Forward(), offsetang.r)

    return pos, ang
end

// Gun implementations of the mcv_base_core hooks.

function SWEP:GetPrecacheParticles()
    return {
        self.MuzzleParticle, self.MuzzleParticleSmoke, self.MuzzleParticleIronsighted,
        self.MuzzleParticleIronsightedSmoke, self.MuzzleParticle3rdPerson, self.EjectBrassTrail,
        self.EjectBrassParticle, self.TracerParticle,
    }
end

function SWEP:IdleActivity()
    if self:GetGrenadeLauncher() and self.RifleGrenadeIsUBGL then
        return ACT_VM_IIDLE_M203
    elseif self:GetBipod() then
        return ACT_VM_DEPLOY
    end

    return ACT_VM_IDLE
end

function SWEP:DeployAnimation()
    if self:GetGrenadeLauncher() and !self.RifleGrenadeIsUBGL then
        return self:PlayAnimation(ACT_VM_DRAW_M203, 1, true)
    end

    self:SetGrenadeLauncher(false)
    return self:PlayAnimation(ACT_VM_DRAW, 1, true)
end

// Screen FOV while aiming. A scope does not zoom the screen: its picture is rendered on the
// lens at the scope FOV (cl_pipscope.lua), the world around it stays at the ironsight FOV.
function SWEP:GetZoomMagnification()
    return self.IronsightFov
end

// Magnification the player is looking through, for the mouse sensitivity
function SWEP:GetLookMagnification()
    if self.HasScope and !self.OEGScope then
        return 90 / self:GetScopeFOV()
    end
    return 90 / self.IronsightFov
end

function SWEP:GetFiremodeName()
    if self:GetGrenadeLauncher() then return "Launcher" end

    return MCV.FiremodeNames[self:GetFiremodeValue()] or ""
end

function SWEP:GetHUDAmmo()
    if self:GetGrenadeLauncher() then
        return self:Clip2(), self:Ammo2()
    end

    return self:Clip1(), self:Ammo1()
end

function SWEP:SecondaryAttack()
    local owner = self:GetOwner()

    if owner:KeyPressed(IN_ATTACK2) and owner:KeyDown(IN_USE) then
        self:ToggleBayonet()
    end
end

if CLIENT then
    local oeg_mat = Material("sprites/redglow1")

    function SWEP:DrawHUDExtra()
        if self.OEGScope and self:GetSightAmountVisual() > 0.6 then
            surface.SetMaterial(oeg_mat)
            surface.SetDrawColor(255, 255, 255, 255)
            local s = ScreenScale(16)
            surface.DrawTexturedRect((ScrW() - s) / 2, (ScrH() - s) / 2, s, s)
        end
    end
end

// Controls shown by the HUD after a deploy and in the weapon selection info
function SWEP:GetControlHints()
    local h = {
        {"+attack", "Fire"},
        {"+attack2", "Aim"},
        {"+reload", "Reload"},
    }
    if #self.Firemodes > 1 then
        table.insert(h, {"+use +reload", "Fire mode"})
    elseif self.AdjustableScopes then
        table.insert(h, {"+use +reload", "Scope magnification"})
    end
    if self.HasRifleGrenade then
        table.insert(h, {"+use +walk", self.RifleGrenadeIsUBGL and "Grenade launcher" or "Rifle grenade"})
    end
    if self.HasAkimbo then
        table.insert(h, {"+use +walk", "Dual wield"})
    end
    if self.HasBayonet then
        table.insert(h, {"+use +attack2", "Bayonet"})
    end
    if self.HasBipod then
        table.insert(h, {"+use", "Bipod (at cover)"})
    end
    table.insert(h, {"+use +attack", self.HasBayonet and "Bash / stab" or "Bash"})
    return h
end

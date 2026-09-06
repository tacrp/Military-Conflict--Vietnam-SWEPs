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

// Screen FOV while aiming. With a scope the screen zooms part of the way towards the scope
// FOV (ScopeScreenZoom times it, never wider than the ironsight FOV, never below 30 degrees):
// the lens reprojects the screen (cl_pipscope.lua), so a tighter screen gives it more pixels
// and a sharper picture; the rest of the magnification happens in the lens.
SWEP.ScopeScreenZoom = 2

function SWEP:GetScopeWorldFov()
    if !self.HasScope or self.OEGScope then return self.IronsightFov end
    return math.Clamp(self:GetScopeFOV() * self.ScopeScreenZoom, 30, self.IronsightFov)
end

function SWEP:GetZoomMagnification()
    return self:GetScopeWorldFov()
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
        table.insert(h, {"+use +walk", self:GetHasSecond() and "Dual wield" or "Dual wield (pick up a second one)"})
    end
    if self.HasBayonet then
        table.insert(h, {"+use +attack2", self:OwnerHasBayonet() and "Bayonet" or "Bayonet (carry a bayonet)"})
    end
    if self.HasBipod then
        table.insert(h, {"+use", "Bipod (at cover)"})
    end
    table.insert(h, {"+use +attack", self.HasBayonet and "Bash / stab" or "Bash"})
    return h
end

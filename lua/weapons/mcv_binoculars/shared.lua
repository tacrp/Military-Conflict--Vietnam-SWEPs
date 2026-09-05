// Binoculars: right click looks through them (the sight blend of the gun base), USE + reload
// steps the magnification. Nothing to fire.

SWEP.Base = "mcv_base"
SWEP.Spawnable = false

SWEP.SubCategory = "Equipment"
SWEP.Slot = 4

SWEP.HoldType = "slam"
SWEP.SprintHoldType = "normal"
SWEP.AimHoldType = "slam"

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 0.7
SWEP.ZoomLevels = {4, 8}
SWEP.SightedViewModelFOV = 60

SWEP.HasScope = false
SWEP.Firemodes = {MCV.FIREMODE_SEMI}
SWEP.FireRate = 0
SWEP.DamageGeneric = 0
SWEP.Spread = 0
SWEP.SpreadIronsighted = 0
SWEP.DrawCrosshair = false

SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false

SWEP.SequenceFiremode = "firemode"

AddCSLuaFile()

function SWEP:GetPrecacheParticles() return {} end
function SWEP:GetHUDAmmo() return nil, nil end
function SWEP:GetFiremodeName() return string.format("%dx", self:GetZoomMagnification()) end

function SWEP:GetZoomMagnification()
    local lvl = math.Clamp(self:GetScopeLevel(), 1, #self.ZoomLevels)
    return self.ZoomLevels[lvl]
end

function SWEP:PrimaryAttack()
    local owner = self:GetOwner()
    if owner:KeyDown(IN_USE) and !self:StillWaiting() then
        self:Bash()
        self:SetNextPrimaryFire(CurTime() + 0.6)
    end
end

function SWEP:Reload()
    local owner = self:GetOwner()
    if !owner:KeyPressed(IN_RELOAD) then return end
    if self:StillWaiting() then return end

    local lvl = self:GetScopeLevel() + 1
    if lvl > #self.ZoomLevels then lvl = 1 end
    self:SetScopeLevel(lvl)

    if !self:GetIronsight() and self:HasSequence(self.SequenceFiremode) then
        self:PlaySequence(self.SequenceFiremode, 1, true)
    else
        self:EmitSound("MCV_Weapon_Foley_AK47.DrawMetal")
        self:SetAnimLockTime(CurTime() + 0.2)
    end
end

function SWEP:ThinkWeapon()
    self:Think_Sights()
end

function SWEP:ToggleUBGL() end
function SWEP:ToggleBayonet() end

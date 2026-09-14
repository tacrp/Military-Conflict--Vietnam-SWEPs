// User kitbash: Mk.4 suppressor, XM177 stock and 4x optic, 30-round magazine, M203.
SWEP.Base = "mcv_m16a1_m203"
SWEP.Spawnable = true
AddCSLuaFile()

SWEP.PrintName = "XM16 Super"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.SubCategory = "Assault Rifles"
SWEP.ViewModel = "models/weapons/mcv/v_xm16super.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_xm16super.mdl"
SWEP.BodyGroups = ""
SWEP.WorldModelBodyGroups = ""

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.ClipSize = 30
SWEP.Primary.Chamber = 1
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true

SWEP.Secondary.Ammo = "smg1_grenade"
SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Automatic = true
SWEP.HasRifleGrenade = true
SWEP.RifleGrenadeIsUBGL = true
SWEP.RifleGrenadeEntity = "mcv_proj_40mm"
SWEP.RifleGrenadeForce = 2000

SWEP.Firemodes = {
    MCV.FIREMODE_AUTO,
    MCV.FIREMODE_SEMI,
    MCV.FIREMODE_BURST,
}

// Full-length suppressed barrel; retain the Mk.4's sound and muzzle effects.
SWEP.MuzzleVelocity = 960
SWEP.RangeModifier = 0.94
SWEP.SoundSingleShot = "MCV_Weapon_MK4MOD0.Single"
SWEP.SoundGrenadeShot = "MCV_Weapon_M203.Single"
SWEP.MuzzleParticle = "vietnam_muzzleflash_pistol_type2_fp"
SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_pistol_type2_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_pistol_type2_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_pistol_type2_fp_is_smoke"
SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_pistol_type2_tp"
SWEP.MuzzleFlashLightTexture = "effects/flashlight_muzzleflash_sl"
SWEP.TracerParticle = ""
SWEP.TracerParticle2 = ""
SWEP.ShootAnimRate = 0.5 // M16-M203 rifle-shot timing

SWEP.HasScope = true
SWEP.OEGScope = false
SWEP.ScopeMaterial = Material("models/weapons/mcv/optics/crosshair_4x")
SWEP.RTScopeMaterialIndex = 4 // lens_4x in the compiled kitbash, not the donor's index
// At the normal 90-degree view: 2x world zoom (53.13 degrees) and 2x lens zoom.
SWEP.ScopeFOV = 26.565051177
SWEP.ScopeFOV2 = 26.565051177
SWEP.IronsightPos = Vector(-0.01, -6.1, -1.02)
SWEP.IronsightAng = Angle(0, 0, 0)
SWEP.IronsightPosLauncher = Vector(0, -2, 0)
SWEP.IronsightAngLauncher = Angle(0, 0, 0)

function SWEP:GetScopeWorldFov()
    return self:GetGrenadeLauncher() and self.IronsightFov or (self.ScopeFOV * 2)
end

function SWEP:GetLookMagnification()
    return self:GetGrenadeLauncher() and (90 / self.IronsightFov) or 4
end

function SWEP:ShouldDoScope()
    return self:GetIronsight() and !self:GetGrenadeLauncher()
end

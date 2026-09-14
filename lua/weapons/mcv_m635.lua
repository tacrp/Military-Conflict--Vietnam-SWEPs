// User kitbash: compact Colt 9mm SMG, standard foregrip and modified Uzi magazine.
SWEP.Base = "mcv_swm76"
SWEP.Spawnable = true
AddCSLuaFile()
SWEP.PrintName = "M635"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.SubCategory = "Submachine Guns"
SWEP.Country = "United States of America"
SWEP.Caliber = "9x19mm"
SWEP.Slot = 2
SWEP.HoldType = "ar2" // the kitbash retains an M16 stock and standard foregrip
SWEP.AimHoldType = "rpg"
SWEP.ViewModel = "models/weapons/mcv/v_m635.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_m635.mdl"
SWEP.BodyGroups = ""
SWEP.WorldModelBodyGroups = ""

SWEP.Primary.Ammo = "pistol"
SWEP.Primary.ClipSize = 32
SWEP.Primary.Chamber = 1 // closed bolt; 32 in the magazine plus a chambered round
SWEP.Primary.DefaultClip = 96
SWEP.Primary.Automatic = true
SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0

// Physical specifications inform handling; damage/spread are addon balance choices.
SWEP.FireRate = 850 // within the Colt SMG's approximately 700-1000 RPM range
SWEP.MuzzleVelocity = 396 // m/s, typical 9mm load from the standard Colt SMG
SWEP.WeaponWeight = 2.61 // kg, unloaded
SWEP.DamageGeneric = 25 // same cartridge class as the M76
SWEP.RangeModifier = 0.86
SWEP.Spread = 7
SWEP.SpreadIronsighted = 2
SWEP.ViewSlideRecoilUp = 1.1
SWEP.ViewSlideRecoilRight = 0.32
SWEP.ViewSlideRecoilIronsightUp = 0.62
SWEP.ViewSlideRecoilIronsightRight = 0.20
SWEP.RecoilPushbackValue = 1.1
SWEP.ShakeScale = 0.45
SWEP.IronsightSpeedScale = 0.9
SWEP.IronsightPos = Vector(0,-2,0)
SWEP.IronsightAng = Angle(0,0,0)
SWEP.MovementPoseWalk = 148
SWEP.MovementPoseSprint = 245
SWEP.MovementPoseSighted = 130
SWEP.NearwallDistance = 18
SWEP.ShootAnimRate = 0.10 // finish the donor's bolt motion within the 850-RPM shot interval
SWEP.HasEmptyReload = true
SWEP.MagInTime = 1.47
SWEP.MagInTimeEmpty = 1.47
SWEP.HasScope = false
SWEP.HasRifleGrenade = false
SWEP.HasBayonet = false
SWEP.HasBipod = false
SWEP.SoundSingleShot = "MCV_Weapon_SWM76.Single"
SWEP.SoundReloadThirdPerson = "MCV_Weapon_Foley_ThirdPerson_SWM76.Reload"
// M76 9mm penetration, muzzle effects, brass and tracer settings are inherited.

SWEP.MuzzleParticle = "vietnam_muzzleflash_smg_type4_fp"
SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_smg_type1_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_smg_type4_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_smg_type1_fp_is_smoke"

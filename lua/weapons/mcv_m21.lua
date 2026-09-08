SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "XM21"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "United States of America"
SWEP.SubCategory = "Sniper Rifles"
SWEP.Caliber = "7.62x51mm"

SWEP.Slot = 3

SWEP.ViewModel = "models/weapons/mcv/v_m21.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_m21.mdl"

SWEP.BodyGroups = "00000"
SWEP.MagInTime = 1.13
SWEP.MagInTimeEmpty = 1.03
SWEP.MagOutTime = 0
SWEP.MagOutTimeEmpty = 0

SWEP.WeaponSelectIcon = NULL

SWEP.BayonetBodygroup = 1
SWEP.GrenadeLauncherBodygroup = 3
SWEP.GrenadeBodygroup = 4

SWEP.IconOverride = "entities/mcv_m21s.png"

// Stats

SWEP.DamageGeneric = 45 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 2.6
SWEP.DamageChestMultiplier = 1.25
SWEP.DamageStomachMultiplier = 1.2
SWEP.DamageLegMultiplier = 0.85
SWEP.DamageArmMultiplier = 0.8

SWEP.ExplosionDamage = 0
SWEP.ExplosionRadius = 0

SWEP.MuzzleVelocity = 860

SWEP.RangeModifier = 0.965

SWEP.Firemodes = {
    MCV.FIREMODE_SEMI
}

// Weapon must be manually cycled
SWEP.PlayCycleAnimation = false

// View slide from recoil
SWEP.ViewSlideRecoilUp = 2.2
SWEP.ViewSlideRecoilRight = 0.6

SWEP.ViewSlideRecoilIronsightUp = 1.44
SWEP.ViewSlideRecoilIronsightRight = 0.4

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 1
SWEP.ShakeFreq = 45
SWEP.ShakeDuration = 0.4

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 1.0
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.MovementPoseWalk = 134
SWEP.MovementPoseSprint = 228
SWEP.MovementPoseSighted = 130

SWEP.HasScope = true
SWEP.ScopeMaterial = Material("models/weapons/mcv/optics/crosshair_m21")
SWEP.ScopeFOV = 31
SWEP.ScopeFOV2 = 10.6
SWEP.RTScopeMaterialIndex = 4
SWEP.AdjustableScopes = true

SWEP.IronsightPos = Vector(-0.0025, -5.4, -0.84)
SWEP.IronsightAng = Angle(0, 0, 0)

SWEP.CustomPos = Vector(0, -2, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 9.25
SWEP.SpreadIronsighted = 0.35

SWEP.FireRate = 450 // in rounds per minute

SWEP.CrosshairMinDistance = 8
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 4.2

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.ClipSize = 20
SWEP.Primary.Chamber = 1
SWEP.Primary.DefaultClip = 60
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 45

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 0.7
SWEP.ProneSpreadMultiplier = 0.6
SWEP.StandMoveSpreadMultiplier = 1.55
SWEP.SneakMoveSpreadMultiplier = 1.45
SWEP.CrouchMoveSpreadMultiplier = 1.35
SWEP.JumpSpreadMultiplier = 4

SWEP.HasBayonet = false
SWEP.HasRifleGrenade = false
SWEP.HasBipod = false

SWEP.RifleGrenadeEntity = "mcv_proj_40mm"
SWEP.RifleGrenadeForce = 7000

// Penetration
SWEP.MetalPenetrationDepth = 10
SWEP.GlassPenetrationDepth = 16
SWEP.ConcretePenetrationDepth = 12
SWEP.WoodPenetrationDepth = 20
SWEP.OtherPenetrationDepth = 14

SWEP.MetalDamageModifier = 1.5
SWEP.GlassDamageModifier = 1.1
SWEP.ConcreteDamageModifier = 1.7
SWEP.WoodDamageModifier = 1.2
SWEP.OtherDamageModifier = 1.2

// Sound
SWEP.SoundSingleShot = "MCV_Weapon_M14.Single"
SWEP.SoundDoubleShot = ""
SWEP.SoundReload = ""
SWEP.SoundReloadThirdPerson = "MCV_Weapon_Foley_ThirdPerson_M14.Reload"
SWEP.SoundSpecial1 = ""
SWEP.SoundSpecial2 = ""
SWEP.SoundGrenadeShot = "MCV_Weapon_M14.RifleGrenade"
SWEP.SoundNearlyEmpty = "MCV_Weapon_Generic.NearlyEmptyClick"
SWEP.SoundEmpty = "MCV_Weapon_Generic.ClipEmpty_01"

// Particles
// SWEP.MuzzleParticle = "vietnam_muzzleflash_rifle_type1_fp"
// SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_rifle_type1_fp_smoke"
// SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_rifle_type1_fp_is"
// SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_rifle_type1_fp_is_smoke"

// SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_rifle_type1_tp"

// SWEP.EjectBrassType = 1
// SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
// SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.MuzzleParticle = "vietnam_muzzleflash_rifle_type1_fp"
SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_rifle_type1_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_rifle_type1_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_rifle_type1_fp_is_smoke"

SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_rifle_type1_tp"

SWEP.EjectBrassType = 7
SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle = "vietnam_tracer_sniperrifle_primary"
SWEP.TracerParticle2 = "vietnam_tracer_sniperrifle_secondary"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 1

SWEP.Secondary.Automatic = true
SWEP.Secondary.ClipSize = 1
SWEP.Secondary.Ammo = "smg1_grenade"
SWEP.Secondary.DefaultClip = 1
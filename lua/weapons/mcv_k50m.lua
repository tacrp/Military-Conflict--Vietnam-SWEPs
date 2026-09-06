SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "K-50M"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "Democratic Republic of Vietnam"
SWEP.SubCategory = "Submachine Guns"
SWEP.Caliber = "7.62x25mm Tokarev"

SWEP.Slot = 2

SWEP.ViewModel = "models/weapons/mcv/v_k50m.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_mas38.mdl"

SWEP.BodyGroups = ""

SWEP.WeaponSelectIcon = NULL

// Stats

SWEP.DamageGeneric = 36 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 2.6
SWEP.DamageChestMultiplier = 1.4
SWEP.DamageStomachMultiplier = 1.3
SWEP.DamageLegMultiplier = 0.8
SWEP.DamageArmMultiplier = 0.75

SWEP.ExplosionDamage = 0
SWEP.ExplosionRadius = 0

SWEP.MuzzleVelocity = 488

SWEP.RangeModifier = 0.73

// "auto", "semi", "burst", "singleaction", "doubleaction", "fanning", "bolt", "pump"
SWEP.Firemodes = {
    MCV.FIREMODE_AUTO,
	MCV.FIREMODE_SEMI
}

SWEP.LastShotAnimation = false

SWEP.MagInTime = 1.87
SWEP.MagInTimeEmpty = 2.53
SWEP.MagOutTime = 0
SWEP.MagOutTimeEmpty = 0

// View slide from recoil
SWEP.ViewSlideRecoilUp = 1.1
SWEP.ViewSlideRecoilRight = 0.8

SWEP.ViewSlideRecoilIronsightUp = 0.59
SWEP.ViewSlideRecoilIronsightRight = 0.32

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 0.6
SWEP.ShakeFreq = 60.0
SWEP.ShakeDuration = 0.30

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 0.85
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.MovementPoseWalk = 141
SWEP.MovementPoseSprint = 236
SWEP.MovementPoseSighted = 130

SWEP.HasScope = false
SWEP.ScopeMaterial = NULL
SWEP.ScopeFOV = 8
SWEP.ScopeFOV2 = 4

SWEP.IronsightPos = Vector(0, -5, 0)
SWEP.IronsightAng = Angle(0, 0, 0)

SWEP.CustomPos = Vector(0, 0, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 7.2
SWEP.SpreadIronsighted = 1.95

SWEP.FireRate = 700 // in rounds per minute

SWEP.CrosshairMinDistance = 8
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 3.85

SWEP.Primary.Ammo = "pistol"
SWEP.Primary.ClipSize = 35
SWEP.Primary.Chamber = 0
SWEP.Primary.DefaultClip = 105
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 40

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 0.85
SWEP.ProneSpreadMultiplier = 0.75
SWEP.StandMoveSpreadMultiplier = 1.25
SWEP.SneakMoveSpreadMultiplier = 1.15
SWEP.CrouchMoveSpreadMultiplier = 1.15
SWEP.JumpSpreadMultiplier = 1.7

SWEP.HasBayonet = false
SWEP.HasBipod = false

// Penetration
SWEP.MetalPenetrationDepth = 5
SWEP.GlassPenetrationDepth = 11
SWEP.ConcretePenetrationDepth = 7
SWEP.WoodPenetrationDepth = 15
SWEP.OtherPenetrationDepth = 9

SWEP.MetalDamageModifier = 1.7
SWEP.GlassDamageModifier = 1.3
SWEP.ConcreteDamageModifier = 1.9
SWEP.WoodDamageModifier = 1.4
SWEP.OtherDamageModifier = 1.4

// Sound
SWEP.SoundSingleShot = "MCV_Weapon_K50M.Single"
SWEP.SoundDoubleShot = ""
SWEP.SoundReload = ""
SWEP.SoundSpecial1 = ""
SWEP.SoundSpecial2 = ""
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

SWEP.MuzzleParticle = "vietnam_muzzleflash_smg_type2_fp"
SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_smg_type2_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_smg_type2_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_smg_type2_fp_is_smoke"

SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_smg_type2_tp"

SWEP.EjectBrassType = 11
SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle = "vietnam_tracer_smg_green_primary"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 1

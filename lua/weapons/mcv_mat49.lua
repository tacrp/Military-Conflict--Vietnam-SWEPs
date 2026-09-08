SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "MAT-49"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "France"
SWEP.SubCategory = "Submachine Guns"
SWEP.Caliber = "7.62x25mm Tokarev"

SWEP.Slot = 2
SWEP.SprintHoldType = "passive"
SWEP.AimHoldType = "smg"
SWEP.HoldType = "smg"

SWEP.ViewModel = "models/weapons/mcv/v_mat49.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_mat49.mdl"

SWEP.BodyGroups = ""

SWEP.WeaponSelectIcon = NULL

// Stats

SWEP.DamageGeneric = 25 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 2.85
SWEP.DamageChestMultiplier = 1.85
SWEP.DamageStomachMultiplier = 1.8
SWEP.DamageLegMultiplier = 0.95
SWEP.DamageArmMultiplier = 0.9

SWEP.ExplosionDamage = 0
SWEP.ExplosionRadius = 0

SWEP.MuzzleVelocity = 735

SWEP.RangeModifier = 0.88

// "auto", "semi", "burst", "singleaction", "doubleaction", "fanning", "bolt", "pump"
SWEP.Firemodes = {
    MCV.FIREMODE_AUTO
}

SWEP.LastShotAnimation = false

SWEP.MagInTime = 1.2
SWEP.MagInTimeEmpty = 2.77
SWEP.MagOutTime = 0
SWEP.MagOutTimeEmpty = 0

// View slide from recoil
SWEP.ViewSlideRecoilUp = 1.28
SWEP.ViewSlideRecoilRight = 0.44

SWEP.ViewSlideRecoilIronsightUp = 0.72
SWEP.ViewSlideRecoilIronsightRight = 0.24

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 0.6
SWEP.ShakeFreq = 60
SWEP.ShakeDuration = 0.3

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 0.85
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.MovementPoseWalk = 140
SWEP.MovementPoseSprint = 235
SWEP.MovementPoseSighted = 130

SWEP.HasScope = false
SWEP.ScopeMaterial = NULL
SWEP.ScopeFOV = 8
SWEP.ScopeFOV2 = 4

SWEP.IronsightPos = Vector(0, -5, 0)
SWEP.IronsightAng = Angle(0, 0, 0)

SWEP.CustomPos = Vector(0, 0, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 7.25
SWEP.SpreadIronsighted = 2.75

SWEP.FireRate = 600 // in rounds per minute

SWEP.CrosshairMinDistance = 4
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 3.5

SWEP.Primary.Ammo = "pistol"
SWEP.Primary.ClipSize = 32
SWEP.Primary.Chamber = 0
SWEP.Primary.DefaultClip = 96
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 22

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 0.85
SWEP.ProneSpreadMultiplier = 0.75
SWEP.StandMoveSpreadMultiplier = 1.15
SWEP.SneakMoveSpreadMultiplier = 1.1
SWEP.CrouchMoveSpreadMultiplier = 1.05
SWEP.JumpSpreadMultiplier = 2

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
SWEP.SoundSingleShot = "MCV_Weapon_MAT49.Single"
SWEP.SoundDoubleShot = ""
SWEP.SoundReload = ""
SWEP.SoundReloadThirdPerson = "MCV_Weapon_Foley_ThirdPerson_MAT49.Reload"
SWEP.SoundSpecial1 = ""
SWEP.SoundSpecial2 = ""
SWEP.SoundNearlyEmpty = "MCV_Weapon_Generic.NearlyEmptyClick_SMG"
SWEP.SoundEmpty = "MCV_Weapon_Generic.ClipEmpty_05"

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

SWEP.EjectBrassType = 12
SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle = "vietnam_tracer_smg_green_primary"
SWEP.TracerParticle2 = "vietnam_tracer_smg_green_secondary"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 2

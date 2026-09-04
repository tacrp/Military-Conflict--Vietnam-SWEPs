SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "QSPR"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "United States of America"
SWEP.SubCategory = "Revolvers"
SWEP.Caliber = "10mm QSPR"

SWEP.Slot = 1

SWEP.ViewModel = "models/weapons/mcv/v_qspr.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_mle1935.mdl"

SWEP.BodyGroups = ""

SWEP.WeaponSelectIcon = NULL

// Stats

SWEP.DamageGeneric = 30 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 2.4
SWEP.DamageChestMultiplier = 1.6
SWEP.DamageStomachMultiplier = 1.5
SWEP.DamageLegMultiplier = 1.15
SWEP.DamageArmMultiplier = 1.15

SWEP.ExplosionDamage = 0
SWEP.ExplosionRadius = 0

SWEP.Num = 10

SWEP.MuzzleVelocity = 315

SWEP.RangeModifier = 0.72

// "auto", "semi", "burst", "singleaction", "doubleaction", "fanning", "bolt", "pump"
SWEP.Firemodes = {
    MCV.FIREMODE_SA,
    MCV.FIREMODE_DA,
    MCV.FIREMODE_FAN
}

SWEP.LastShotAnimation = false
SWEP.ShotgunReload = false
SWEP.RevolverFiremodePose = true
SWEP.HasEmptyReload = false
SWEP.AkimboDualSingleActionReload = false

SWEP.MagInTime = 1
SWEP.MagInTimeEmpty = 1

// View slide from recoil
SWEP.ViewSlideRecoilUp = 0.75
SWEP.ViewSlideRecoilRight = 0.35

SWEP.ViewSlideRecoilIronsightUp = 0.35
SWEP.ViewSlideRecoilIronsightRight = 0.25

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 0.75
SWEP.ShakeFreq = 60.0
SWEP.ShakeDuration = 0.30

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 0.85
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25

SWEP.HasScope = false
SWEP.ScopeMaterial = NULL
SWEP.ScopeFOV = 8
SWEP.ScopeFOV2 = 4

SWEP.IronsightPos = Vector(0.095, -4, -0.05)
SWEP.IronsightAng = Angle(0.3, 0.22, 0)

SWEP.CustomPos = Vector(0, -2, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 12
SWEP.SpreadIronsighted = 6

SWEP.FireRate = 400 // in rounds per minute -- the MCV script claims its RPM is 50 but there's no way that's correct so im setting it to this for now

SWEP.CrosshairMinDistance = 8
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 3.85

SWEP.Primary.Ammo = "pistol"
SWEP.Primary.ClipSize = 6
SWEP.Primary.Chamber = 0
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 40

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 0.8
SWEP.ProneSpreadMultiplier = 0.75
SWEP.StandMoveSpreadMultiplier = 1.1
SWEP.SneakMoveSpreadMultiplier = 1
SWEP.CrouchMoveSpreadMultiplier = 1.05
SWEP.JumpSpreadMultiplier = 1.25

SWEP.HasBayonet = false
SWEP.HasBipod = false
SWEP.HasAkimbo = false

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
SWEP.SoundSingleShot = "MCV_Weapon_QSPR.Single"
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

SWEP.MuzzleParticle = "vietnam_muzzleflash_pistol_qspr_fp"
SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_pistol_qspr_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_pistol_qspr_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_pistol_qspr_fp_is_smoke"

SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_pistol_qspr_tp"

SWEP.EjectBrassType = 11
SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle = "vietnam_tracer_shotgun_dots_primary"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 1

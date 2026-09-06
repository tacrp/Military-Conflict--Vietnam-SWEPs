SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "M1917"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "United States of America"
SWEP.SubCategory = "Revolvers"
SWEP.Caliber = ".45 ACP"

SWEP.Slot = 1

SWEP.ViewModel = "models/weapons/mcv/v_m1917.mdl"
SWEP.ViewModelAkimbo = "models/weapons/mcv/v_dual_m1917.mdl"
SWEP.AkimboPoseRecoil = true
SWEP.WorldModel = "models/weapons/mcv/w_m1917.mdl"

SWEP.BodyGroups = ""

SWEP.WeaponSelectIcon = NULL

// Stats

SWEP.DamageGeneric = 30 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 4.25
SWEP.DamageChestMultiplier = 4
SWEP.DamageStomachMultiplier = 3.9
SWEP.DamageLegMultiplier = 2.3
SWEP.DamageArmMultiplier = 2.2

SWEP.ExplosionDamage = 0
SWEP.ExplosionRadius = 0

SWEP.MuzzleVelocity = 315

SWEP.RangeModifier = 0.775

// "auto", "semi", "burst", "singleaction", "doubleaction", "fanning", "bolt", "pump"
SWEP.Firemodes = {
    MCV.FIREMODE_SA,
    MCV.FIREMODE_FAN,
    MCV.FIREMODE_DA
}

SWEP.LastShotAnimation = false
SWEP.ShotgunReload = false
SWEP.RevolverFiremodePose = true
SWEP.HasEmptyReload = false
SWEP.AkimboDualSingleActionReload = false

SWEP.MagInTime = 1.27
SWEP.MagInTimeEmpty = 1.27
SWEP.MagOutTime = 0
SWEP.MagOutTimeEmpty = 0

// View slide from recoil
SWEP.ViewSlideRecoilUp = 2.2
SWEP.ViewSlideRecoilRight = 0.36

SWEP.ViewSlideRecoilIronsightUp = 1.28
SWEP.ViewSlideRecoilIronsightRight = 0.2

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 0.75
SWEP.ShakeFreq = 35
SWEP.ShakeDuration = 0.8

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 0.85
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.MovementPoseWalk = 161
SWEP.MovementPoseSprint = 260
SWEP.MovementPoseSighted = 130

SWEP.HasScope = false
SWEP.ScopeMaterial = NULL
SWEP.ScopeFOV = 8
SWEP.ScopeFOV2 = 4

SWEP.IronsightPos = Vector(0, -3.5, 0)
SWEP.IronsightAng = Angle(0, 0, 0)

SWEP.CustomPos = Vector(0, 0, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 9
SWEP.SpreadIronsighted = 2

SWEP.FireRate = 70 // in rounds per minute -- the MCV script claims its RPM is 50 but there's no way that's correct so im setting it to this for now

SWEP.CrosshairMinDistance = 4
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 1

SWEP.Primary.Ammo = "357"
SWEP.Primary.ClipSize = 6
SWEP.Primary.Chamber = 0
SWEP.Primary.DefaultClip = 12
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 22

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 0.8
SWEP.ProneSpreadMultiplier = 0.75
SWEP.StandMoveSpreadMultiplier = 1.2
SWEP.SneakMoveSpreadMultiplier = 1.1
SWEP.CrouchMoveSpreadMultiplier = 1.15
SWEP.JumpSpreadMultiplier = 1.35

SWEP.HasBayonet = false
SWEP.HasBipod = false
SWEP.HasAkimbo = true

// Penetration
SWEP.MetalPenetrationDepth = 6
SWEP.GlassPenetrationDepth = 12
SWEP.ConcretePenetrationDepth = 8
SWEP.WoodPenetrationDepth = 16
SWEP.OtherPenetrationDepth = 10

SWEP.MetalDamageModifier = 1.6
SWEP.GlassDamageModifier = 1.2
SWEP.ConcreteDamageModifier = 1.8
SWEP.WoodDamageModifier = 1.3
SWEP.OtherDamageModifier = 1.3

// Sound
SWEP.SoundSingleShot = "MCV_Weapon_M1917.Single"
SWEP.SoundDoubleShot = ""
SWEP.SoundReload = ""
SWEP.SoundSpecial1 = ""
SWEP.SoundSpecial2 = ""
SWEP.SoundNearlyEmpty = "MCV_Weapon_Generic.NearlyEmptyClick_Revolver"
SWEP.SoundEmpty = "MCV_Weapon_Generic.ClipEmpty_07"

// Particles
// SWEP.MuzzleParticle = "vietnam_muzzleflash_rifle_type1_fp"
// SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_rifle_type1_fp_smoke"
// SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_rifle_type1_fp_is"
// SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_rifle_type1_fp_is_smoke"

// SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_rifle_type1_tp"

// SWEP.EjectBrassType = 1
// SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
// SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.MuzzleParticle = "vietnam_muzzleflash_revolver_type1_fp"
SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_revolver_type1_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_revolver_type1_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_revolver_type1_fp_is_smoke"

SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_revolver_type1_tp"

SWEP.EjectBrassType = 18
SWEP.NoEjectOnShoot = true
SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle = "vietnam_tracer_pistol_primary"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 1

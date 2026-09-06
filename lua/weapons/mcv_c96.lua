SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "Mauser C96"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "German Empire"
SWEP.SubCategory = "Pistols"
SWEP.Caliber = "7.63x25mm"

SWEP.Slot = 1

SWEP.ViewModel = "models/weapons/mcv/v_c96.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_c96.mdl"

SWEP.BodyGroups = ""

SWEP.WeaponSelectIcon = NULL

// Stats

SWEP.DamageGeneric = 27 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 3.15
SWEP.DamageChestMultiplier = 1.6
SWEP.DamageStomachMultiplier = 1.55
SWEP.DamageLegMultiplier = 1.05
SWEP.DamageArmMultiplier = 1

SWEP.ExplosionDamage = 0
SWEP.ExplosionRadius = 0

SWEP.MuzzleVelocity = 315

SWEP.RangeModifier = 0.775

// "auto", "semi", "burst", "singleaction", "doubleaction", "fanning", "bolt", "pump"
SWEP.Firemodes = {
    MCV.FIREMODE_SEMI
}

SWEP.LastShotAnimation = true

SWEP.MagInTime = 2.9
SWEP.MagInTimeEmpty = 0.03
SWEP.MagOutTime = 0
SWEP.MagOutTimeEmpty = 0
SWEP.MagInClip = true

// View slide from recoil
SWEP.ViewSlideRecoilUp = 1.44
SWEP.ViewSlideRecoilRight = 0.56

SWEP.ViewSlideRecoilIronsightUp = 1.24
SWEP.ViewSlideRecoilIronsightRight = 0.48

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 0.6
SWEP.ShakeFreq = 50
SWEP.ShakeDuration = 0.35

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 0.85
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.MovementPoseWalk = 157
SWEP.MovementPoseSprint = 255
SWEP.MovementPoseSighted = 130

SWEP.HasScope = false
SWEP.ScopeMaterial = NULL
SWEP.ScopeFOV = 8
SWEP.ScopeFOV2 = 4

SWEP.IronsightPos = Vector(0, -6, 0)
SWEP.IronsightAng = Angle(0, 0, 0)

SWEP.CustomPos = Vector(0, 1, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 6.25
SWEP.SpreadIronsighted = 2.25

SWEP.FireRate = 540 // in rounds per minute -- the MCV script claims its RPM is 50 but there's no way that's correct so im setting it to this for now

SWEP.CrosshairMinDistance = 4
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 1.13

SWEP.Primary.Ammo = "pistol"
SWEP.Primary.ClipSize = 10
SWEP.Primary.Chamber = 0
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 22

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 0.95
SWEP.ProneSpreadMultiplier = 0.9
SWEP.StandMoveSpreadMultiplier = 1.1
SWEP.SneakMoveSpreadMultiplier = 1.05
SWEP.CrouchMoveSpreadMultiplier = 1
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
SWEP.SoundSingleShot = "MCV_Weapon_C96.Single"
SWEP.SoundDoubleShot = ""
SWEP.SoundReload = ""
SWEP.SoundSpecial1 = ""
SWEP.SoundSpecial2 = ""
SWEP.SoundNearlyEmpty = "MCV_Weapon_Generic.NearlyEmptyClick_Pistol"
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

SWEP.MuzzleParticle = "vietnam_muzzleflash_pistol_type1_fp"
SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_pistol_type1_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_pistol_type1_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_pistol_type1_fp_is_smoke"

SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_pistol_type1_tp"

SWEP.EjectBrassType = 16
SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle = "vietnam_tracer_pistol_green_primary"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 2

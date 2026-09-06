SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "Browning Hi-Power"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "Belgium"
SWEP.SubCategory = "Pistols"
SWEP.Caliber = "9x19mm"

SWEP.Slot = 1

SWEP.ViewModel = "models/weapons/mcv/v_highpower.mdl"
SWEP.ViewModelAkimbo = "models/weapons/mcv/v_dual_highpower.mdl"
SWEP.AkimboPoseRecoil = true
SWEP.WorldModel = "models/weapons/mcv/w_highpower.mdl"

SWEP.BodyGroups = ""

SWEP.IconOverride = "entities/mcv_hp.png"

SWEP.WeaponSelectIcon = NULL

// Stats

SWEP.DamageGeneric = 25 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 3.1
SWEP.DamageChestMultiplier = 1.55
SWEP.DamageStomachMultiplier = 1.5
SWEP.DamageLegMultiplier = 1.05
SWEP.DamageArmMultiplier = 1

SWEP.ExplosionDamage = 0
SWEP.ExplosionRadius = 0

SWEP.MuzzleVelocity = 315

SWEP.RangeModifier = 0.76

// "auto", "semi", "burst", "singleaction", "doubleaction", "fanning", "bolt", "pump"
SWEP.Firemodes = {
    MCV.FIREMODE_SEMI
}

SWEP.LastShotAnimation = true

SWEP.MagInTime = 1.07
SWEP.MagInTimeEmpty = 1.07
SWEP.MagOutTime = 0
SWEP.MagOutTimeEmpty = 0

// View slide from recoil
SWEP.ViewSlideRecoilUp = 1.48
SWEP.ViewSlideRecoilRight = 0.56

SWEP.ViewSlideRecoilIronsightUp = 1.24
SWEP.ViewSlideRecoilIronsightRight = 0.48

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 0.75
SWEP.ShakeFreq = 50
SWEP.ShakeDuration = 0.35

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

SWEP.IronsightPos = Vector(0, -5, 0.4)
SWEP.IronsightAng = Angle(0.5, 0.1, 0)
SWEP.IronsightPosAkimbo = Vector(0.06, -5, -0.07)
SWEP.IronsightAngAkimbo = Angle(0, 0, 0)

SWEP.CustomPos = Vector(0, -2, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 6.75
SWEP.SpreadIronsighted = 2.5

SWEP.FireRate = 540 // in rounds per minute -- the MCV script claims its RPM is 50 but there's no way that's correct so im setting it to this for now

SWEP.CrosshairMinDistance = 4
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 1.5

SWEP.Primary.Ammo = "pistol"
SWEP.Primary.ClipSize = 13
SWEP.Primary.Chamber = 1
SWEP.Primary.DefaultClip = 39
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
SWEP.HasAkimbo = true

// Penetration
SWEP.MetalPenetrationDepth = 6
SWEP.GlassPenetrationDepth = 12
SWEP.ConcretePenetrationDepth = 8
SWEP.WoodPenetrationDepth = 16
SWEP.OtherPenetrationDepth = 10

SWEP.MetalDamageModifier = 1.65
SWEP.GlassDamageModifier = 1.25
SWEP.ConcreteDamageModifier = 1.85
SWEP.WoodDamageModifier = 1.35
SWEP.OtherDamageModifier = 1.35

// Sound
SWEP.SoundSingleShot = "MCV_Weapon_HP.Single"
SWEP.SoundDoubleShot = ""
SWEP.SoundReload = ""
SWEP.SoundSpecial1 = ""
SWEP.SoundSpecial2 = ""
SWEP.SoundNearlyEmpty = "MCV_Weapon_Generic.NearlyEmptyClick_Pistol"
SWEP.SoundEmpty = "MCV_Weapon_Generic.ClipEmpty_03"

// Particles
// SWEP.MuzzleParticle = "vietnam_muzzleflash_rifle_type1_fp"
// SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_rifle_type1_fp_smoke"
// SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_rifle_type1_fp_is"
// SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_rifle_type1_fp_is_smoke"

// SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_rifle_type1_tp"

// SWEP.EjectBrassType = 1
// SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
// SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.MuzzleParticle = "vietnam_muzzleflash_pistol_type3_fp"
SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_pistol_type1_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_pistol_type3_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_pistol_type1_fp_is_smoke"

SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_pistol_type3_tp"

SWEP.EjectBrassType = 12
SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle = "vietnam_tracer_pistol_primary"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 2

SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "Baby Browning"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "United States of America"
SWEP.SubCategory = "Pistols"
SWEP.Caliber = ".25 ACP"

SWEP.Slot = 1
SWEP.SprintHoldType = "normal"
SWEP.AimHoldType = "revolver"
SWEP.HoldType = "pistol"

SWEP.ViewModel = "models/weapons/mcv/v_babybrowning.mdl"
SWEP.ViewModelAkimbo = "models/weapons/mcv/v_dual_babybrowning.mdl"
SWEP.AkimboPoseRecoil = true
SWEP.WorldModel = "models/weapons/mcv/w_babybrowning.mdl"

SWEP.BodyGroups = ""

SWEP.IconOverride = "entities/mcv_baby_browning.png"

SWEP.WeaponSelectIcon = NULL

// Stats

SWEP.DamageGeneric = 17 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 5
SWEP.DamageChestMultiplier = 1.7
SWEP.DamageStomachMultiplier = 1.6
SWEP.DamageLegMultiplier = 1.2
SWEP.DamageArmMultiplier = 1.1

SWEP.ExplosionDamage = 0
SWEP.ExplosionRadius = 0

SWEP.MuzzleVelocity = 253

SWEP.RangeModifier = 0.67

// "auto", "semi", "burst", "singleaction", "doubleaction", "fanning", "bolt", "pump"
SWEP.Firemodes = {
    MCV.FIREMODE_SEMI
}

SWEP.LastShotAnimation = false -- it does has a lastshot anim but it isnt visually different so there's no point. plus it jerks so this is an easy way to fix that

SWEP.MagInTime = 1.83
SWEP.MagInTimeEmpty = 1.83
SWEP.MagOutTime = 0
SWEP.MagOutTimeEmpty = 0

// View slide from recoil
SWEP.ViewSlideRecoilUp = 1.08
SWEP.ViewSlideRecoilRight = 0.44

SWEP.ViewSlideRecoilIronsightUp = 0.8
SWEP.ViewSlideRecoilIronsightRight = 0.32

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

SWEP.IronsightPos = Vector(0, -5, 0)
SWEP.IronsightAng = Angle(0, 0, 0)
SWEP.IronsightPosAkimbo = Vector(0.01, -5, -0.1)
SWEP.IronsightAngAkimbo = Angle(-0.15, 0, 0)

SWEP.CustomPos = Vector(0, 2, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 5
SWEP.SpreadIronsighted = 2

SWEP.FireRate = 540 // in rounds per minute -- the MCV script claims its RPM is 100 but there's no way that's correct so im setting it to this for now

SWEP.CrosshairMinDistance = 4
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 0

SWEP.Primary.Ammo = "pistol"
SWEP.Primary.ClipSize = 6
SWEP.Primary.Chamber = 1
SWEP.Primary.DefaultClip = 48
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
SWEP.MetalPenetrationDepth = 4
SWEP.GlassPenetrationDepth = 10
SWEP.ConcretePenetrationDepth = 6
SWEP.WoodPenetrationDepth = 14
SWEP.OtherPenetrationDepth = 8

SWEP.MetalDamageModifier = 1.8
SWEP.GlassDamageModifier = 1.4
SWEP.ConcreteDamageModifier = 2
SWEP.WoodDamageModifier = 1.5
SWEP.OtherDamageModifier = 1.5

// Sound
SWEP.SoundSingleShot = "MCV_Weapon_BabyBrowning.Single"
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

SWEP.EjectBrassType = 15
SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle = "vietnam_tracer_pistol_primary"
SWEP.TracerParticle2 = "vietnam_tracer_pistol_secondary"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 2

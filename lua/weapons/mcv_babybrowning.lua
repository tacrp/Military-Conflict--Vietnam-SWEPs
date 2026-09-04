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

SWEP.ViewModel = "models/weapons/mcv/v_babybrowning.mdl"
SWEP.ViewModelAkimbo = "models/weapons/mcv/v_dual_babybrowning.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_mle1935.mdl"

SWEP.BodyGroups = ""

SWEP.IconOverride = "entities/mcv_baby_browning.png"

SWEP.WeaponSelectIcon = NULL

// Stats

SWEP.DamageGeneric = 23 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 2.6
SWEP.DamageChestMultiplier = 1.7
SWEP.DamageStomachMultiplier = 1.6
SWEP.DamageLegMultiplier = 1.1
SWEP.DamageArmMultiplier = 1.05

SWEP.ExplosionDamage = 0
SWEP.ExplosionRadius = 0

SWEP.MuzzleVelocity = 253

SWEP.RangeModifier = 0.72

// "auto", "semi", "burst", "singleaction", "doubleaction", "fanning", "bolt", "pump"
SWEP.Firemodes = {
    MCV.FIREMODE_SEMI
}

SWEP.LastShotAnimation = false -- it does has a lastshot anim but it isnt visually different so there's no point. plus it jerks so this is an easy way to fix that

SWEP.MagInTime = 1
SWEP.MagInTimeEmpty = 1

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

SWEP.HasScope = false
SWEP.ScopeMaterial = NULL
SWEP.ScopeFOV = 8
SWEP.ScopeFOV2 = 4

SWEP.IronsightPos = Vector(0.07, -4, 0.1)
SWEP.IronsightAng = Angle(0.3, -0.28, 0)

SWEP.CustomPos = Vector(0, -2, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 5
SWEP.SpreadIronsighted = 2

SWEP.FireRate = 250 // in rounds per minute -- the MCV script claims its RPM is 100 but there's no way that's correct so im setting it to this for now

SWEP.CrosshairMinDistance = 8
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 3.85

SWEP.Primary.Ammo = "pistol"
SWEP.Primary.ClipSize = 6
SWEP.Primary.Chamber = 1
SWEP.Primary.DefaultClip = 12
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 40

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
SWEP.SoundSingleShot = "MCV_Weapon_BabyBrowning.Single"
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

SWEP.MuzzleParticle = "vietnam_muzzleflash_pistol_type3_fp"
SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_pistol_type1_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_pistol_type3_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_pistol_type1_fp_is_smoke"

SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_pistol_type3_tp"

SWEP.EjectBrassType = 11
SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle = "vietnam_tracer_pistol_primary"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 1

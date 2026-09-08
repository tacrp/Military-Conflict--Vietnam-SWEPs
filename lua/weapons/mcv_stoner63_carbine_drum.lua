SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "Stoner 63AC Drum"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "United States of America"
SWEP.SubCategory = "Carbines"
SWEP.Caliber = "5.56x45mm"

SWEP.Slot = 3

SWEP.ViewModel = "models/weapons/mcv/v_stoner63a_carbine_drum.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_stoner63a_carbine.mdl"

SWEP.BodyGroups = "001"
SWEP.MagInTime = 1.73
SWEP.MagInTimeEmpty = 1.73
SWEP.MagOutTime = 0
SWEP.MagOutTimeEmpty = 0

SWEP.WeaponSelectIcon = NULL

SWEP.BayonetBodygroup = 1
SWEP.IconOverride = "entities/mcv_stoner63_c.png"

// Stats

SWEP.DamageGeneric = 35 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 1.9
SWEP.DamageChestMultiplier = 1.05
SWEP.DamageStomachMultiplier = 1
SWEP.DamageLegMultiplier = 0.65
SWEP.DamageArmMultiplier = 0.6

SWEP.ExplosionDamage = 0
SWEP.ExplosionRadius = 0

SWEP.MuzzleVelocity = 735

SWEP.RangeModifier = 0.94

SWEP.Firemodes = {
    MCV.FIREMODE_AUTO,
    MCV.FIREMODE_SEMI,
}

// Weapon must be manually cycled
SWEP.PlayCycleAnimation = false

// View slide from recoil
SWEP.ViewSlideRecoilUp = 1.88
SWEP.ViewSlideRecoilRight = 0.88

SWEP.ViewSlideRecoilIronsightUp = 1.16
SWEP.ViewSlideRecoilIronsightRight = 0.52

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 1
SWEP.ShakeFreq = 50
SWEP.ShakeDuration = 0.3

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 1.0
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.MovementPoseWalk = 148
SWEP.MovementPoseSprint = 245
SWEP.MovementPoseSighted = 130

SWEP.HasScope = false
SWEP.ScopeMaterial = NULL
SWEP.ScopeFOV = 8
SWEP.ScopeFOV2 = 4

SWEP.IronsightPos = Vector(0, -3, 0)
SWEP.IronsightAng = Angle(0, 0, 0)

SWEP.CustomPos = Vector(0, 0, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 9
SWEP.SpreadIronsighted = 2

SWEP.FireRate = 800 // in rounds per minute

SWEP.CrosshairMinDistance = 4
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 3.52

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.ClipSize = 150
SWEP.Primary.Chamber = 1
SWEP.Primary.DefaultClip = 150
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 40

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 0.8
SWEP.ProneSpreadMultiplier = 0.7
SWEP.StandMoveSpreadMultiplier = 1.4
SWEP.SneakMoveSpreadMultiplier = 1.3
SWEP.CrouchMoveSpreadMultiplier = 1.2
SWEP.JumpSpreadMultiplier = 3

SWEP.HasBayonet = false
SWEP.HasBipod = false

// Penetration
SWEP.MetalPenetrationDepth = 7
SWEP.GlassPenetrationDepth = 13
SWEP.ConcretePenetrationDepth = 9
SWEP.WoodPenetrationDepth = 17
SWEP.OtherPenetrationDepth = 11

SWEP.MetalDamageModifier = 1.6
SWEP.GlassDamageModifier = 1.2
SWEP.ConcreteDamageModifier = 1.8
SWEP.WoodDamageModifier = 1.3
SWEP.OtherDamageModifier = 1.3

// Sound
SWEP.SoundSingleShot = "MCV_Weapon_Stoner63_Carbine.Single"
SWEP.SoundDoubleShot = ""
SWEP.SoundReload = ""
SWEP.SoundReloadThirdPerson = "MCV_Weapon_Foley_ThirdPerson_STONER63_Carbine_Drum.Reload"
SWEP.SoundSpecial1 = ""
SWEP.SoundSpecial2 = ""
SWEP.SoundNearlyEmpty = "MCV_Weapon_Generic.NearlyEmptyClick_LMG"
SWEP.SoundEmpty = "MCV_Weapon_Generic.ClipEmpty_01"

// Particles
// SWEP.MuzzleParticle = "vietnam_muzzleflash_rifle_type1_fp"
// SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_rifle_type1_fp_smoke"
// SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_rifle_type1_fp_is"
// SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_rifle_type1_fp_is_smoke"

// SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_rifle_type1_tp"

// SWEP.EjectBrassType = 4
// SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
// SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.MuzzleParticle = "vietnam_muzzleflash_machinegun_type3_fp"
SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_machinegun_type3_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_machinegun_type3_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_machinegun_type3_fp_is_smoke"

SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_machinegun_type3_tp"

SWEP.EjectBrassType = 4
SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle = "vietnam_tracer_assaultrifle_primary"
SWEP.TracerParticle2 = "vietnam_tracer_assaultrifle_secondary"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 3

SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "Stoner 63 Commando"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "United States of America"
SWEP.SubCategory = "Light-Machine Guns"
SWEP.Caliber = "5.56x45mm"

SWEP.Slot = 3

SWEP.ViewModel = "models/weapons/mcv/v_stoner63.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_stoner63.mdl"

SWEP.BodyGroups = ""

SWEP.WeaponSelectIcon = NULL
SWEP.IconOverride = "entities/mcv_stoner63.png"

SWEP.BulletBodygroups = {
    [1] = {1, 1},
    [2] = {2, 1},
    [3] = {3, 1},
    [4] = {4, 1},
    [5] = {5, 1},
    [6] = {6, 1},
    [7] = {7, 1},
    [8] = {8, 1},
    [9] = {9, 1},
    [10] = {10, 1},
}

// Stats

SWEP.DamageGeneric = 35 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 1.95
SWEP.DamageChestMultiplier = 1.1
SWEP.DamageStomachMultiplier = 1.05
SWEP.DamageLegMultiplier = 0.75
SWEP.DamageArmMultiplier = 0.7

SWEP.ExplosionDamage = 0
SWEP.ExplosionRadius = 0

SWEP.MuzzleVelocity = 735

SWEP.RangeModifier = 0.94

SWEP.Firemodes = {
    MCV.FIREMODE_AUTO
}

// Weapon must be manually cycled
SWEP.PlayCycleAnimation = false

SWEP.MagInTime = 2
SWEP.MagInTimeEmpty = 2
SWEP.MagOutTime = 0
SWEP.MagOutTimeEmpty = 0

// View slide from recoil
SWEP.ViewSlideRecoilUp = 1.72
SWEP.ViewSlideRecoilRight = 0.96

SWEP.ViewSlideRecoilIronsightUp = 1
SWEP.ViewSlideRecoilIronsightRight = 0.56

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 1
SWEP.ShakeFreq = 50
SWEP.ShakeDuration = 0.3

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 1.0
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.MovementPoseWalk = 80
SWEP.MovementPoseSprint = 158
SWEP.MovementPoseSighted = 130

SWEP.HasScope = false
SWEP.ScopeMaterial = NULL
SWEP.ScopeFOV = 8
SWEP.ScopeFOV2 = 4

SWEP.IronsightPos = Vector(0, -2, 0)
SWEP.IronsightAng = Angle(0, 0, 0)

SWEP.CustomPos = Vector(0, 2, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 8.75
SWEP.SpreadIronsighted = 3

SWEP.FireRate = 800 // in rounds per minute

SWEP.CrosshairMinDistance = 4
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 10.6

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.ClipSize = 150
SWEP.Primary.Chamber = 0
SWEP.Primary.DefaultClip = 150
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 40

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 0.95
SWEP.ProneSpreadMultiplier = 0.85
SWEP.StandMoveSpreadMultiplier = 1.5
SWEP.SneakMoveSpreadMultiplier = 1.4
SWEP.CrouchMoveSpreadMultiplier = 1.3
SWEP.JumpSpreadMultiplier = 3

SWEP.HasBayonet = false
SWEP.HasBipod = true

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
SWEP.OtherDamageModifier = 1.29

// Sound
SWEP.SoundSingleShot = "MCV_Weapon_Stoner63.Single"
SWEP.SoundDoubleShot = ""
SWEP.SoundReload = ""
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

// SWEP.EjectBrassType = 1
// SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
// SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.MuzzleParticle = "vietnam_muzzleflash_machinegun_type3_fp"
SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_machinegun_type3_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_machinegun_type3_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_machinegun_type3_fp_is_smoke"

SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_machinegun_type3_tp"

SWEP.EjectBrassType = 4
SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side_mg_stoner63"

SWEP.TracerParticle = "vietnam_tracer_assaultrifle_primary"
SWEP.TracerParticle2 = "vietnam_tracer_assaultrifle_secondary"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 3

SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "M60 Belt"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "United States of America"
SWEP.SubCategory = "Light-Machine Guns"
SWEP.Caliber = "7.62x51mm"

SWEP.Slot = 3

SWEP.ViewModel = "models/weapons/mcv/v_m60b.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_m60b.mdl"

SWEP.BodyGroups = ""

SWEP.WeaponSelectIcon = NULL

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
    [11] = {11, 1},
    [12] = {12, 1},
    [13] = {13, 1},
}

// Stats

SWEP.DamageGeneric = 45 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 2.4
SWEP.DamageChestMultiplier = 1.05
SWEP.DamageStomachMultiplier = 1
SWEP.DamageLegMultiplier = 0.7
SWEP.DamageArmMultiplier = 0.65

SWEP.ExplosionDamage = 0
SWEP.ExplosionRadius = 0

SWEP.MuzzleVelocity = 735

SWEP.RangeModifier = 0.965

SWEP.Firemodes = {
    MCV.FIREMODE_AUTO
}

// Weapon must be manually cycled
SWEP.PlayCycleAnimation = false

SWEP.MagInTime = 1.8
SWEP.MagInTimeEmpty = 3.1
SWEP.MagOutTime = 0
SWEP.MagOutTimeEmpty = 0

// View slide from recoil
SWEP.ViewSlideRecoilUp = 2.48
SWEP.ViewSlideRecoilRight = 1.12

SWEP.ViewSlideRecoilIronsightUp = 1.6
SWEP.ViewSlideRecoilIronsightRight = 0.72

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 1
SWEP.ShakeFreq = 50
SWEP.ShakeDuration = 0.3

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 1.0
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.MovementPoseWalk = 106
SWEP.MovementPoseSprint = 195
SWEP.MovementPoseSighted = 106

SWEP.HasScope = false
SWEP.ScopeMaterial = NULL
SWEP.ScopeFOV = 8
SWEP.ScopeFOV2 = 4

SWEP.IronsightPos = Vector(0, -4, 0)
SWEP.IronsightAng = Angle(0, 0, 0)

SWEP.CustomPos = Vector(0, 0, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 9.5
SWEP.SpreadIronsighted = 2.5
SWEP.SpreadBipodIronsighted = 1.2
SWEP.SpreadBipod = 3.25

SWEP.FireRate = 600 // in rounds per minute

SWEP.CrosshairMinDistance = 4
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 13

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.ClipSize = 200
SWEP.Primary.Chamber = 0
SWEP.Primary.DefaultClip = 200
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 45

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 0.65
SWEP.ProneSpreadMultiplier = 0.55
SWEP.StandMoveSpreadMultiplier = 1.65
SWEP.SneakMoveSpreadMultiplier = 1.55
SWEP.CrouchMoveSpreadMultiplier = 1.45
SWEP.JumpSpreadMultiplier = 3

SWEP.HasBayonet = false
SWEP.HasBipod = true

// Penetration
SWEP.MetalPenetrationDepth = 10
SWEP.GlassPenetrationDepth = 16
SWEP.ConcretePenetrationDepth = 12
SWEP.WoodPenetrationDepth = 20
SWEP.OtherPenetrationDepth = 14

SWEP.MetalDamageModifier = 1.5
SWEP.GlassDamageModifier = 1.1
SWEP.ConcreteDamageModifier = 1.7
SWEP.WoodDamageModifier = 1.2
SWEP.OtherDamageModifier = 1.2

// Sound
SWEP.SoundSingleShot = "MCV_Weapon_M60.Single"
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

SWEP.MuzzleParticle = "vietnam_muzzleflash_machinegun_type4_fp"
SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_machinegun_type4_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_machinegun_type4_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_machinegun_type4_fp_is_smoke"

SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_machinegun_type4_tp"

SWEP.EjectBrassType = 7
SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side_mg_m60"

SWEP.TracerParticle = "vietnam_tracer_machinegun_primary"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 3

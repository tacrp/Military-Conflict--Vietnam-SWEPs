SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "RP-46"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "Soviet Union"
SWEP.SubCategory = "Light-Machine Guns"
SWEP.Caliber = "7.62x54mmR"

SWEP.Slot = 3

SWEP.ViewModel = "models/weapons/mcv/v_rp46.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_rp46.mdl"

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

SWEP.DamageGeneric = 44 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 2.4
SWEP.DamageChestMultiplier = 1.3
SWEP.DamageStomachMultiplier = 1.25
SWEP.DamageLegMultiplier = 0.8
SWEP.DamageArmMultiplier = 0.75

SWEP.ExplosionDamage = 0
SWEP.ExplosionRadius = 0

SWEP.MuzzleVelocity = 735

SWEP.RangeModifier = 0.925

SWEP.Firemodes = {
    MCV.FIREMODE_AUTO
}

// Weapon must be manually cycled
SWEP.PlayCycleAnimation = false

SWEP.MagInTime = 1.13
SWEP.MagInTimeEmpty = 1.13
SWEP.MagOutTime = 0.5
SWEP.MagOutTimeEmpty = 0.5

// View slide from recoil
SWEP.ViewSlideRecoilUp = 2.02
SWEP.ViewSlideRecoilRight = 0.82

SWEP.ViewSlideRecoilIronsightUp = 1.22
SWEP.ViewSlideRecoilIronsightRight = 0.54

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 0.5
SWEP.ShakeFreq = 50
SWEP.ShakeDuration = 0.3

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 1.0
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.MovementPoseWalk = 100
SWEP.MovementPoseSprint = 185

SWEP.HasScope = false
SWEP.ScopeMaterial = NULL
SWEP.ScopeFOV = 8
SWEP.ScopeFOV2 = 4

SWEP.IronsightPos = Vector(0, -4, 0)
SWEP.IronsightAng = Angle(0, 0, 0)

SWEP.CustomPos = Vector(0, 0, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 9.87
SWEP.SpreadIronsighted = 2.35

SWEP.SpreadBipod = 3.5
SWEP.SpreadBipodIronsighted = 1.5

SWEP.FireRate = 600 // in rounds per minute

SWEP.CrosshairMinDistance = 8
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 3.85

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.ClipSize = 125
SWEP.Primary.Chamber = 0
SWEP.Primary.DefaultClip = 250
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 40

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 0.85
SWEP.ProneSpreadMultiplier = 0.8
SWEP.StandMoveSpreadMultiplier = 1.6
SWEP.SneakMoveSpreadMultiplier = 1.4
SWEP.CrouchMoveSpreadMultiplier = 1.3
SWEP.JumpSpreadMultiplier = 3.0

SWEP.HasBayonet = false
SWEP.HasBipod = true

// Penetration
SWEP.MetalPenetrationDepth = 8
SWEP.GlassPenetrationDepth = 14
SWEP.ConcretePenetrationDepth = 10
SWEP.WoodPenetrationDepth = 18
SWEP.OtherPenetrationDepth = 12

SWEP.MetalDamageModifier = 1.55
SWEP.GlassDamageModifier = 1.15
SWEP.ConcreteDamageModifier = 1.75
SWEP.WoodDamageModifier = 1.25
SWEP.OtherDamageModifier = 1.25

// Sound
SWEP.SoundSingleShot = "MCV_Weapon_DP28.Single"
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

SWEP.MuzzleParticle = "vietnam_muzzleflash_machinegun_type4_fp"
SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_machinegun_type4_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_machinegun_type4_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_machinegun_type4_fp_is_smoke"

SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_machinegun_type4_tp"

SWEP.EjectBrassType = 8
SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side_mg_rp46"

SWEP.TracerParticle = "vietnam_tracer_machinegun_green_primary"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 1

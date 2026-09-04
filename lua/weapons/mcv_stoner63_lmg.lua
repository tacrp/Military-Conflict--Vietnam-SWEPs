SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "Stoner 63 LMG"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "United States of America"
SWEP.SubCategory = "Light-Machine Guns"
SWEP.Caliber = "5.56x45mm"

SWEP.Slot = 3

SWEP.ViewModel = "models/weapons/mcv/v_stoner63_lmg.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_rpd.mdl"

SWEP.BodyGroups = ""

SWEP.WeaponSelectIcon = NULL

SWEP.IconOverride = "entities/mcv_stoner63_l.png"

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
}

// Stats

SWEP.DamageGeneric = 43 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 1
SWEP.DamageChestMultiplier = 1
SWEP.DamageStomachMultiplier = 1
SWEP.DamageLegMultiplier = 1
SWEP.DamageArmMultiplier = 1

SWEP.ExplosionDamage = 0
SWEP.ExplosionRadius = 0

SWEP.MuzzleVelocity = 735

SWEP.RangeModifier = 0.925

SWEP.Firemodes = {
    MCV.FIREMODE_AUTO
}

// Weapon must be manually cycled
SWEP.PlayCycleAnimation = false

SWEP.MagInTime = 2.5
SWEP.MagInTimeEmpty = 2.5

// View slide from recoil
SWEP.ViewSlideRecoilUp = 1.64
SWEP.ViewSlideRecoilRight = 0.32

SWEP.ViewSlideRecoilIronsightUp = 0.96
SWEP.ViewSlideRecoilIronsightRight = 0.16

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 1
SWEP.ShakeFreq = 45.0
SWEP.ShakeDuration = 0.4

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 1.0
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25

SWEP.HasScope = false
SWEP.ScopeMaterial = NULL
SWEP.ScopeFOV = 8
SWEP.ScopeFOV2 = 4

SWEP.IronsightPos = Vector(0.06, -4, -0.05)
SWEP.IronsightAng = Angle(0.22, 0.15, 0)

SWEP.CustomPos = Vector(0, -2, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 7.72
SWEP.SpreadIronsighted = 1.47

SWEP.FireRate = 775 // in rounds per minute

SWEP.CrosshairMinDistance = 8
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 3.85

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.ClipSize = 100
SWEP.Primary.Chamber = 0
SWEP.Primary.DefaultClip = 200
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 40

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 0.8
SWEP.ProneSpreadMultiplier = 0.75
SWEP.StandMoveSpreadMultiplier = 1.45
SWEP.SneakMoveSpreadMultiplier = 1.34
SWEP.CrouchMoveSpreadMultiplier = 1.25
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
SWEP.SoundSingleShot = "MCV_Weapon_Stoner63_LMG.Single"
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

SWEP.MuzzleParticle = "vietnam_muzzleflash_machinegun_type3_fp"
SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_machinegun_type3_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_machinegun_type3_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_machinegun_type3_fp_is_smoke"

SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_machinegun_type3_tp"

SWEP.EjectBrassType = 1
SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side_mg_stoner63"

SWEP.TracerParticle = "vietnam_tracer_assaultrifle_primary"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 1

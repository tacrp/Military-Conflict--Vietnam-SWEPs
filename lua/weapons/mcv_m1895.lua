SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "Nagant M1895"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "Belgium"
SWEP.SubCategory = "Revolvers"
SWEP.Caliber = "7.62x38mmR"

SWEP.Slot = 1

SWEP.ViewModel = "models/weapons/mcv/v_m1895.mdl"
SWEP.ViewModelAkimbo = "models/weapons/mcv/v_dual_m1895.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_mle1935.mdl"

SWEP.BodyGroups = ""

SWEP.WeaponSelectIcon = NULL

// Stats

SWEP.DamageGeneric = 43 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 3.7
SWEP.DamageChestMultiplier = 2.4
SWEP.DamageStomachMultiplier = 2.3
SWEP.DamageLegMultiplier = 1.3
SWEP.DamageArmMultiplier = 0.95

SWEP.ExplosionDamage = 0
SWEP.ExplosionRadius = 0

SWEP.MuzzleVelocity = 315

SWEP.RangeModifier = 0.72

SWEP.Firemodes = {
    MCV.FIREMODE_SA,
    MCV.FIREMODE_DA,
    MCV.FIREMODE_FAN
}

SWEP.LastShotAnimation = false
SWEP.ShotgunReload = true
SWEP.RevolverFiremodePose = true
SWEP.HasEmptyReload = false
SWEP.AkimboDualSingleActionReload = true

// View slide from recoil
SWEP.ViewSlideRecoilUp = 1.1
SWEP.ViewSlideRecoilRight = 0.8

SWEP.ViewSlideRecoilIronsightUp = 0.59
SWEP.ViewSlideRecoilIronsightRight = 0.32

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 1
SWEP.ShakeFreq = 35.0
SWEP.ShakeDuration = 0.8

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 0.85
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25

SWEP.HasScope = false
SWEP.ScopeMaterial = NULL
SWEP.ScopeFOV = 8
SWEP.ScopeFOV2 = 4

SWEP.IronsightPos = Vector(0, -4, 0)
SWEP.IronsightAng = Angle(0, 0, 0)

SWEP.CustomPos = Vector(0, -2, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 8.5
SWEP.SpreadIronsighted = 1.3

SWEP.FireRate = 300

SWEP.CrosshairMinDistance = 8
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 3.85

SWEP.Primary.Ammo = "pistol"
SWEP.Primary.ClipSize = 7
SWEP.Primary.Chamber = 0
SWEP.Primary.DefaultClip = 14
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 40

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 0.85
SWEP.ProneSpreadMultiplier = 0.75
SWEP.StandMoveSpreadMultiplier = 1.25
SWEP.SneakMoveSpreadMultiplier = 1.15
SWEP.CrouchMoveSpreadMultiplier = 1.15
SWEP.JumpSpreadMultiplier = 1.7

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
SWEP.SoundSingleShot = "MCV_Weapon_M1895.Single"
SWEP.SoundDoubleShot = ""
SWEP.SoundReload = ""
SWEP.SoundSpecial1 = ""
SWEP.SoundSpecial2 = ""
SWEP.SoundNearlyEmpty = "Vietnam_Weapon_Generic.NearlyEmptyClick"
SWEP.SoundEmpty = "Vietnam_Weapon_Generic.ClipEmpty_01"

// Particles
// SWEP.MuzzleParticle = "vietnam_muzzleflash_rifle_type1_fp"
// SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_rifle_type1_fp_smoke"
// SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_rifle_type1_fp_is"
// SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_rifle_type1_fp_is_smoke"

// SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_rifle_type1_tp"

// SWEP.EjectBrassType = 1
// SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
// SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.MuzzleParticle = "muzzleflash_pistol_rbull"
SWEP.MuzzleParticleSmoke = ""
SWEP.MuzzleParticleIronsighted = "muzzleflash_pistol_rbull"
SWEP.MuzzleParticleIronsightedSmoke = ""

SWEP.MuzzleParticle3rdPerson = "muzzleflash_pistol_rbull"

SWEP.NoEjectOnShoot = true
SWEP.EjectBrassType = 6
SWEP.EjectBrassTrail = "shellsmoke"
SWEP.EjectBrassParticle = "port_smoke"

SWEP.TracerParticle = "tracer"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 1

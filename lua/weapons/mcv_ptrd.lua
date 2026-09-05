SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "PTRD-41"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "Soviet Union"
SWEP.SubCategory = "Anti-Armor"
SWEP.Caliber = "14.5x114mm"

SWEP.Slot = 4

SWEP.ViewModel = "models/weapons/mcv/v_ptrd41.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_ak47.mdl"

SWEP.BodyGroups = "0"
SWEP.MagInTime = 2.17
SWEP.MagInTimeEmpty = 2.17

SWEP.WeaponSelectIcon = NULL

// Stats

SWEP.DamageGeneric = 99 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 2.4
SWEP.DamageChestMultiplier = 2.15
SWEP.DamageStomachMultiplier = 1.95
SWEP.DamageLegMultiplier = 1.15
SWEP.DamageArmMultiplier = 1.15

SWEP.ExplosionDamage = 0
SWEP.ExplosionRadius = 0

SWEP.MuzzleVelocity = 735

SWEP.RangeModifier = 1

SWEP.Firemodes = {
    MCV.FIREMODE_SEMI
}

// Weapon must be manually cycled
SWEP.PlayCycleAnimation = false

SWEP.HasEmptyReload = false

// View slide from recoil
SWEP.ViewSlideRecoilUp = 5
SWEP.ViewSlideRecoilRight = 1.25

SWEP.ViewSlideRecoilIronsightUp = 4
SWEP.ViewSlideRecoilIronsightRight = 1

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 2.5
SWEP.ShakeFreq = 40.0
SWEP.ShakeDuration = 0.75

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 1.0
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.MovementPoseWalk = 141
SWEP.MovementPoseSprint = 237
SWEP.MovementPoseSighted = 60

SWEP.HasScope = false
SWEP.ScopeMaterial = NULL
SWEP.ScopeFOV = 8
SWEP.ScopeFOV2 = 4

SWEP.IronsightPos = Vector(0, 0, 0)
SWEP.IronsightAng = Angle(0, 0, 0)

SWEP.CustomPos = Vector(0, 0, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 2.5
SWEP.SpreadIronsighted = 0.25
SWEP.SpreadBipodIronsighted = 0.15
SWEP.SpreadBipod = 3

SWEP.FireRate = 50

SWEP.CrosshairMinDistance = 8
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 3.85

SWEP.Primary.Ammo = "357"
SWEP.Primary.ClipSize = 1
SWEP.Primary.Chamber = 0
SWEP.Primary.DefaultClip = 6
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
SWEP.MustBipod = true

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
SWEP.SoundSingleShot = "MCV_Weapon_PTRD.Single"
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

SWEP.MuzzleParticle = "vietnam_muzzleflash_ptrd_fp"
SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_ptrd_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_ptrd_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_ptrd_fp_is_smoke"

SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_ptrd_tp"

SWEP.NoEjectOnShoot = false

SWEP.EjectBrassType = 19
SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle = "vietnam_tracer_ptrd_green_primary"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 1

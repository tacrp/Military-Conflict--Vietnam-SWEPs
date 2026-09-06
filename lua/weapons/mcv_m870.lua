SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "M870"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "United States of America"
SWEP.SubCategory = "Shotguns"
SWEP.Caliber = "12 Gauge Shell"

SWEP.Slot = 2

SWEP.ViewModel = "models/weapons/mcv/v_m870.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_m870.mdl"

SWEP.BodyGroups = ""

SWEP.WeaponSelectIcon = NULL

// Stats

SWEP.DamageGeneric = 25 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 2.5
SWEP.DamageChestMultiplier = 1.5
SWEP.DamageStomachMultiplier = 1.25
SWEP.DamageLegMultiplier = 0.9
SWEP.DamageArmMultiplier = 0.8

SWEP.Num = 6

SWEP.MuzzleVelocity = 403

SWEP.RangeModifier = 0.79 // Every 500 units the damage is multiplied by rangemodifier

SWEP.Firemodes = {
    MCV.FIREMODE_PUMP
}

SWEP.LastShotAnimation = false
SWEP.ShotgunReload = true
SWEP.PlayCycleAnimation = true
SWEP.HasEmptyReload = true

// View slide from recoil
SWEP.ViewSlideRecoilUp = 3.2
SWEP.ViewSlideRecoilRight = 0.96

SWEP.ViewSlideRecoilIronsightUp = 2.4
SWEP.ViewSlideRecoilIronsightRight = 0.72

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 3
SWEP.ShakeFreq = 30
SWEP.ShakeDuration = 0.4

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 0.85
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.MovementPoseWalk = 142
SWEP.MovementPoseSprint = 238
SWEP.MovementPoseSighted = 130

SWEP.HasScope = false
SWEP.ScopeMaterial = NULL
SWEP.ScopeFOV = 8
SWEP.ScopeFOV2 = 4

SWEP.IronsightPos = Vector(-0.025, -4, 0)
SWEP.IronsightAng = Angle(0, 0, 0)

SWEP.CustomPos = Vector(0, 0, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 8.25
SWEP.SpreadIronsighted = 2.75

SWEP.FireRate = 600 // in rounds per minute
SWEP.CycleSpeed = 0.4
SWEP.CyclePostDelay = 0.85

SWEP.WeaponWeight = 3.2

SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.ClipSize = 4
SWEP.Primary.Chamber = 1
SWEP.Primary.DefaultClip = 24
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 40

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 1
SWEP.ProneSpreadMultiplier = 1
SWEP.StandMoveSpreadMultiplier = 1
SWEP.SneakMoveSpreadMultiplier = 1
SWEP.CrouchMoveSpreadMultiplier = 1
SWEP.JumpSpreadMultiplier = 1

SWEP.HasBayonet = false
SWEP.HasRifleGrenade = false

SWEP.BashDamage = 50
SWEP.BayonetDamage = 100

SWEP.HasBipod = false

// Penetration
SWEP.MetalPenetrationDepth = 3
SWEP.GlassPenetrationDepth = 8
SWEP.ConcretePenetrationDepth = 5
SWEP.WoodPenetrationDepth = 13
SWEP.OtherPenetrationDepth = 6

SWEP.MetalDamageModifier = 1.7
SWEP.GlassDamageModifier = 1.3
SWEP.ConcreteDamageModifier = 1.9
SWEP.WoodDamageModifier = 1.4
SWEP.OtherDamageModifier = 1.4

// Sound
SWEP.SoundSingleShot = "MCV_Weapon_M870.Single"
SWEP.SoundDoubleShot = ""
SWEP.SoundReload = ""
SWEP.SoundSpecial1 = ""
SWEP.SoundSpecial2 = ""
SWEP.SoundNearlyEmpty = "MCV_Weapon_Generic.NearlyEmptyClick"
SWEP.SoundEmpty = "MCV_Weapon_Generic.ClipEmpty_08"

// Particles
// SWEP.MuzzleParticle = "vietnam_muzzleflash_rifle_type1_fp"
// SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_rifle_type1_fp_smoke"
// SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_rifle_type1_fp_is"
// SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_rifle_type1_fp_is_smoke"

// SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_rifle_type1_tp"

// SWEP.EjectBrassType = 1
// SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
// SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.MuzzleParticle = "vietnam_muzzleflash_shotgun_type1_fp"
SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_shotgun_type1_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_shotgun_type1_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_shotgun_type1_fp_is_smoke"

SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_shotgun_type1_tp"

SWEP.NoEjectOnShoot = true
SWEP.EjectBrassType = 2
SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle = "vietnam_tracer_shotgun_primary"

SWEP.MuzzleFlashLightTexture = "effects/flashlight_muzzleflash_sg"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 1
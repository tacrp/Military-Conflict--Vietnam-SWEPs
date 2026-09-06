SWEP.Base = "mcv_base"
SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "M40"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "United States of America"
SWEP.SubCategory = "Sniper Rifles"
SWEP.Caliber = "7.62x51mm"

SWEP.Slot = 3

SWEP.ViewModel = "models/weapons/mcv/v_m40.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_m40.mdl"

SWEP.BodyGroups = "00000"

SWEP.WeaponSelectIcon = NULL

SWEP.ViewModelFOV = 80
SWEP.SightedViewModelFOV = 25

// Stats

SWEP.DamageGeneric = 45 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 3.5
SWEP.DamageChestMultiplier = 3.1
SWEP.DamageStomachMultiplier = 3
SWEP.DamageLegMultiplier = 1.6
SWEP.DamageArmMultiplier = 1.5

SWEP.Num = 1

SWEP.MuzzleVelocity = 735

SWEP.RangeModifier = 0.985 // Every 500 units the damage is multiplied by rangemodifier

SWEP.Firemodes = {
    MCV.FIREMODE_BOLT
}

SWEP.LastShotAnimation = false
SWEP.MagInClip = true
SWEP.ShotgunReload = true
SWEP.ShotgunAltReload = true
SWEP.ShotgunReloadEmptyStartAnimation = false
SWEP.PlayCycleAnimation = true
SWEP.HasEmptyReload = false

SWEP.AdjustableScopes = true

// View slide from recoil
SWEP.ViewSlideRecoilUp = 2.84
SWEP.ViewSlideRecoilRight = 0.48

SWEP.ViewSlideRecoilIronsightUp = 1.36
SWEP.ViewSlideRecoilIronsightRight = 0.24

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 1
SWEP.ShakeFreq = 30
SWEP.ShakeDuration = 0.5

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 0.95
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.MovementPoseWalk = 116
SWEP.MovementPoseSprint = 207
SWEP.MovementPoseSighted = 130

SWEP.HasScope = true
SWEP.ScopeMaterial = Material("models/weapons/mcv/optics/crosshair_m40")
SWEP.ScopeFOV = 31
SWEP.ScopeFOV2 = 10.6
SWEP.RTScopeMaterialIndex = 3

SWEP.IronsightPos = Vector(-0.005, -0.3, 0)
SWEP.IronsightAng = Angle(0, 0, 0)

SWEP.CustomPos = Vector(0, 0, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 8
SWEP.SpreadIronsighted = 0.05

SWEP.FireRate = 600 // in rounds per minute
SWEP.CyclePostDelay = 0.9

SWEP.CrosshairMinDistance = 4
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 6.57

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.ClipSize = 5
SWEP.Primary.Chamber = 0
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 45

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 0.95
SWEP.ProneSpreadMultiplier = 0.85
SWEP.StandMoveSpreadMultiplier = 1.8
SWEP.SneakMoveSpreadMultiplier = 1.75
SWEP.CrouchMoveSpreadMultiplier = 1.65
SWEP.JumpSpreadMultiplier = 5

SWEP.HasBayonet = false
SWEP.HasRifleGrenade = false

SWEP.BashDamage = 50
SWEP.BayonetDamage = 100

SWEP.HasBipod = false

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
SWEP.SoundSingleShot = "MCV_Weapon_M40.Single"
SWEP.SoundDoubleShot = ""
SWEP.SoundReload = ""
SWEP.SoundSpecial1 = ""
SWEP.SoundSpecial2 = ""
SWEP.SoundNearlyEmpty = "MCV_Weapon_Generic.NearlyEmptyClick"
SWEP.SoundEmpty = "MCV_Weapon_Generic.ClipEmpty_06"

// Particles
// SWEP.MuzzleParticle = "vietnam_muzzleflash_rifle_type1_fp"
// SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_rifle_type1_fp_smoke"
// SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_rifle_type1_fp_is"
// SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_rifle_type1_fp_is_smoke"

// SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_rifle_type1_tp"

// SWEP.EjectBrassType = 1
// SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
// SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.MuzzleParticle = "vietnam_muzzleflash_sniperrifle_type1_fp"
SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_sniperrifle_type1_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_sniperrifle_type1_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_sniperrifle_type1_fp_is_smoke"

SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_sniperrifle_type1_tp"

SWEP.NoEjectOnShoot = true

SWEP.EjectBrassType = 7
SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle = "vietnam_tracer_sniperrifle_primary"
SWEP.TracerParticle2 = "vietnam_tracer_sniperrifle_secondary"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 1
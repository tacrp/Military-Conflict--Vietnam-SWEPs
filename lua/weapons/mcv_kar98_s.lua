SWEP.Base = "mcv_base"
SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "Karabiner 98K ZF39"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "Nazi Germany"
SWEP.SubCategory = "Sniper Rifles"
SWEP.Caliber = "7.92x57mm"

SWEP.Slot = 3

SWEP.ViewModel = "models/weapons/mcv/v_kar98_s.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_sks.mdl"

SWEP.BodyGroups = "00000"

SWEP.WeaponSelectIcon = NULL

SWEP.ViewModelFOV = 80
SWEP.SightedViewModelFOV = 40
SWEP.IconOverride = "entities/mcv_kar98k_s.png"

// Stats

SWEP.DamageGeneric = 65 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 2.4
SWEP.DamageChestMultiplier = 2.15
SWEP.DamageStomachMultiplier = 1.95
SWEP.DamageLegMultiplier = 1.15
SWEP.DamageArmMultiplier = 1.15

SWEP.Num = 1

SWEP.MuzzleVelocity = 735

SWEP.RangeModifier = 0.985 // Every 500 units the damage is multiplied by rangemodifier

SWEP.Firemodes = {
    MCV.FIREMODE_BOLT
}

SWEP.LastShotAnimation = false
SWEP.MagInClip = true
SWEP.HybridReloadCapable = true // clip when empty, one round at a time when partly loaded (mcv_hybrid_reload)
SWEP.ShotgunReload = false // clip reload (reload / reload_empty); the single-round animations stay unused, as on the Kar98
SWEP.ShotgunReloadEmptyStartAnimation = false
SWEP.PlayCycleAnimation = true
SWEP.HasEmptyReload = true

SWEP.AdjustableScopes = true

// View slide from recoil
SWEP.ViewSlideRecoilUp = 2.85
SWEP.ViewSlideRecoilRight = 0.48

SWEP.ViewSlideRecoilIronsightUp = 1.35
SWEP.ViewSlideRecoilIronsightRight = 0.16

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 1
SWEP.ShakeFreq = 30.0
SWEP.ShakeDuration = 0.5

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 0.95
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.MovementPoseWalk = 138
SWEP.MovementPoseSprint = 233
SWEP.MovementPoseSighted = 130

SWEP.HasScope = true
SWEP.ScopeMaterial = Material("models/weapons/mcv/optics/crosshair_kar98")
SWEP.ScopeFOV = 23.5
SWEP.ScopeFOV2 = 11.9
SWEP.RTScopeMaterialIndex = 6

SWEP.IronsightPos = Vector(0.03, -5.5, -0.8)
SWEP.IronsightAng = Angle(0, 0, 0)

SWEP.CustomPos = Vector(0, -2, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 7.7
SWEP.SpreadIronsighted = 0.05

SWEP.FireRate = 600 // in rounds per minute
SWEP.CyclePostDelay = 0.9

SWEP.CrosshairMinDistance = 8
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 3.85

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.ClipSize = 5
SWEP.Primary.Chamber = 0
SWEP.Primary.DefaultClip = 15
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 40

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 0.75
SWEP.ProneSpreadMultiplier = 0.5
SWEP.StandMoveSpreadMultiplier = 1.55
SWEP.SneakMoveSpreadMultiplier = 1.45
SWEP.CrouchMoveSpreadMultiplier = 1.35
SWEP.JumpSpreadMultiplier = 6.0

SWEP.HasBayonet = false -- sniper variants dont get bayos
SWEP.HasRifleGrenade = false

SWEP.BashDamage = 50
SWEP.BayonetDamage = 100

SWEP.HasBipod = false

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
SWEP.SoundSingleShot = "MCV_Weapon_KAR98K.Single"
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

SWEP.MuzzleParticle = "muzzleflash_m24"
SWEP.MuzzleParticleSmoke = ""
SWEP.MuzzleParticleIronsighted = "muzzleflash_m24"
SWEP.MuzzleParticleIronsightedSmoke = ""

SWEP.MuzzleParticle3rdPerson = "muzzleflash_m24"

SWEP.NoEjectOnShoot = true

SWEP.EjectBrassType = 10
SWEP.EjectBrassTrail = "shellsmoke"
SWEP.EjectBrassParticle = "port_smoke"

SWEP.TracerParticle = ""

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 1
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
SWEP.WorldModel = "models/weapons/mcv/w_kar98_s.mdl"

SWEP.BodyGroups = "00000"

SWEP.WeaponSelectIcon = NULL

SWEP.ViewModelFOV = 80
SWEP.SightedViewModelFOV = 40
SWEP.IconOverride = "entities/mcv_kar98k_s.png"

// Stats

SWEP.DamageGeneric = 50 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 2.7
SWEP.DamageChestMultiplier = 2.5
SWEP.DamageStomachMultiplier = 2.4
SWEP.DamageLegMultiplier = 1.3
SWEP.DamageArmMultiplier = 1.2

SWEP.Num = 1

SWEP.MuzzleVelocity = 735

SWEP.RangeModifier = 0.985 // Every 500 units the damage is multiplied by rangemodifier

SWEP.Firemodes = {
    MCV.FIREMODE_BOLT
}

SWEP.LastShotAnimation = false
SWEP.MagInClip = true
SWEP.ShotgunReload = false // clip reload (reload / reload_empty); the single-round animations stay unused, as on the Kar98
SWEP.ShotgunReloadEmptyStartAnimation = false
SWEP.PlayCycleAnimation = true
SWEP.HasEmptyReload = true

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

SWEP.Spread = 7
SWEP.SpreadIronsighted = 0.05

SWEP.FireRate = 600 // in rounds per minute
SWEP.CyclePostDelay = 0.9

SWEP.CrosshairMinDistance = 8
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 4.1

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.ClipSize = 5
SWEP.Primary.Chamber = 0
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 45

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 0.85
SWEP.ProneSpreadMultiplier = 0.75
SWEP.StandMoveSpreadMultiplier = 1.65
SWEP.SneakMoveSpreadMultiplier = 1.55
SWEP.CrouchMoveSpreadMultiplier = 1.45
SWEP.JumpSpreadMultiplier = 5

SWEP.HasBayonet = false -- sniper variants dont get bayos
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
SWEP.SoundSingleShot = "MCV_Weapon_KAR98K.Single"
SWEP.SoundDoubleShot = ""
SWEP.SoundReload = ""
SWEP.SoundReloadThirdPerson = "MCV_Weapon_Foley_ThirdPerson_KAR98.Reload"
SWEP.SoundReloadLoopThirdPerson = "MCV_Weapon_Foley_ThirdPerson_M40.ReloadLoop"
SWEP.SoundCycleThirdPerson = "MCV_Weapon_Foley_ThirdPerson_KAR98.Cycle"
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

SWEP.MuzzleParticle = "muzzleflash_m24"
SWEP.MuzzleParticleSmoke = ""
SWEP.MuzzleParticleIronsighted = "muzzleflash_m24"
SWEP.MuzzleParticleIronsightedSmoke = ""

SWEP.MuzzleParticle3rdPerson = "muzzleflash_m24"

SWEP.NoEjectOnShoot = true

SWEP.EjectBrassType = 10
SWEP.EjectBrassTrail = "shellsmoke"
SWEP.EjectBrassParticle = "port_smoke"

SWEP.TracerParticle = "vietnam_tracer_sniperrifle_green_primary"
SWEP.TracerParticle2 = "vietnam_tracer_sniperrifle_green_secondary"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 1
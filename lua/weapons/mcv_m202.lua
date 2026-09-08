SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "M202 FLASH"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "United States of America"
SWEP.SubCategory = "Anti-Armor"
SWEP.Caliber = "66mm Rocket"

SWEP.Slot = 4
SWEP.SprintHoldType = "passive"
SWEP.AimHoldType = "rpg"
SWEP.HoldType = "rpg"

SWEP.ViewModel = "models/weapons/mcv/v_m202.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_m202.mdl"

SWEP.BodyGroups = "0"

SWEP.WeaponSelectIcon = NULL

SWEP.IconOverride = "entities/mcv_xm202.png"

// Stats

SWEP.Num = 1

SWEP.Firemodes = {
    MCV.FIREMODE_SEMI
}

SWEP.BulletBodygroups = {
    [1] = {1, 1},
    [2] = {2, 1},
    [3] = {3, 1},
    [4] = {4, 1},
}

SWEP.VolleyCount = 4

SWEP.LastShotAnimation = false
SWEP.MagInClip = false

SWEP.MagInTime = 2.07
SWEP.MagInTimeEmpty = 2.07
SWEP.MagOutTime = 0
SWEP.MagOutTimeEmpty = 0

SWEP.ShootEntity = "mcv_proj_m202"
SWEP.ShootForce = 9000

// View slide from recoil
SWEP.ViewSlideRecoilUp = 3.12
SWEP.ViewSlideRecoilRight = 0.96

SWEP.ViewSlideRecoilIronsightUp = 2.64
SWEP.ViewSlideRecoilIronsightRight = 0.72

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 2.5
SWEP.ShakeFreq = 40
SWEP.ShakeDuration = 1

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 0.7
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.MovementPoseWalk = 77
SWEP.MovementPoseSprint = 160
SWEP.MovementPoseSighted = 154

SWEP.HasScope = false
SWEP.ScopeMaterial = NULL
SWEP.ScopeFOV = 8
SWEP.ScopeFOV2 = 4

SWEP.IronsightPos = Vector(0, 0, -0.465)
SWEP.IronsightAng = Angle(0, 0, 0)

SWEP.CustomPos = Vector(0, 0, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 4
SWEP.SpreadIronsighted = 2

SWEP.FireRate = 70 // in rounds per minute

SWEP.CrosshairMinDistance = 8
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 12

SWEP.Primary.Ammo = "rpg_round"
SWEP.Primary.ClipSize = 4
SWEP.Primary.Chamber = 0
SWEP.Primary.DefaultClip = 4
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 45

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 1
SWEP.ProneSpreadMultiplier = 0.75
SWEP.StandMoveSpreadMultiplier = 2
SWEP.SneakMoveSpreadMultiplier = 1.5
SWEP.CrouchMoveSpreadMultiplier = 1.25
SWEP.JumpSpreadMultiplier = 4

SWEP.HasBayonet = false
SWEP.HasRifleGrenade = false

SWEP.BashDamage = 50
SWEP.BayonetDamage = 100

SWEP.HasBipod = false
SWEP.HasEmptyReload = false

// Penetration
SWEP.MetalPenetrationDepth = 10
SWEP.GlassPenetrationDepth = 10
SWEP.ConcretePenetrationDepth = 10
SWEP.WoodPenetrationDepth = 10
SWEP.OtherPenetrationDepth = 10

SWEP.MetalDamageModifier = 1.25
SWEP.GlassDamageModifier = 1.25
SWEP.ConcreteDamageModifier = 1.25
SWEP.WoodDamageModifier = 1.25
SWEP.OtherDamageModifier = 1.25

// Sound
SWEP.SoundSingleShot = "MCV_Weapon_M202.Single"
SWEP.SoundDoubleShot = ""
SWEP.SoundReload = ""
SWEP.SoundReloadThirdPerson = "MCV_Weapon_Foley_ThirdPerson_M202.Reload"
SWEP.SoundSpecial1 = ""
SWEP.SoundSpecial2 = ""
SWEP.SoundNearlyEmpty = "MCV_Weapon_Generic.NearlyEmptyClick"
SWEP.SoundEmpty = "MCV_Weapon_Generic.ClipEmpty_09"

// Particles
// SWEP.MuzzleParticle = "vietnam_muzzleflash_rifle_type1_fp"
// SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_rifle_type1_fp_smoke"
// SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_rifle_type1_fp_is"
// SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_rifle_type1_fp_is_smoke"

// SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_rifle_type1_tp"

// SWEP.EjectBrassType = 1
// SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
// SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.MuzzleParticle = "vietnam_muzzleflash_rocketlauncher_type1_fp"
SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_rocketlauncher_type1_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_rocketlauncher_type1_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_rocketlauncher_type1_fp_is_smoke"

SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_rocketlauncher_type1_tp"

SWEP.NoEjectOnShoot = true
SWEP.EjectBrassType = 0
SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle = ""
SWEP.TracerParticle2 = ""

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 1
SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "China Lake"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "United States of America"
SWEP.SubCategory = "Anti-Armor"
SWEP.Caliber = "40x46mm Grenade"

SWEP.Slot = 4
SWEP.SprintHoldType = "passive"
SWEP.AimHoldType = "shotgun"
SWEP.HoldType = "shotgun"

SWEP.ViewModel = "models/weapons/mcv/v_chinalake.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_chinalake.mdl"

SWEP.BodyGroups = "000"

SWEP.WeaponSelectIcon = NULL
SWEP.IconOverride = "entities/mcv_china_lake.png"

// Stats

SWEP.Num = 1

SWEP.Firemodes = {
    MCV.FIREMODE_PUMP
}

SWEP.LastShotAnimation = false
SWEP.ShotgunReload = true
SWEP.PlayCycleAnimation = true
SWEP.HasEmptyReload = true

SWEP.ShootEntity = "mcv_proj_40mm"
SWEP.ShootForce = 2500

// View slide from recoil
SWEP.ViewSlideRecoilUp = 3.12
SWEP.ViewSlideRecoilRight = 0.96

SWEP.ViewSlideRecoilIronsightUp = 2.64
SWEP.ViewSlideRecoilIronsightRight = 0.72

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 2.5
SWEP.ShakeFreq = 40
SWEP.ShakeDuration = 0.75

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 0.7
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.MovementPoseWalk = 113
SWEP.MovementPoseSprint = 203
SWEP.MovementPoseSighted = 113

SWEP.HasScope = false
SWEP.ScopeMaterial = NULL
SWEP.ScopeFOV = 8
SWEP.ScopeFOV2 = 4

SWEP.IronsightPos = Vector(0, -0, 0)
SWEP.IronsightAng = Angle(0.5, 0, 0)

SWEP.CustomPos = Vector(0, 0, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 7
SWEP.SpreadIronsighted = 2

SWEP.FireRate = 600 // in rounds per minute
SWEP.CycleSpeed = 0.45
SWEP.CyclePostDelay = 1

SWEP.CrosshairMinDistance = 8
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 7

SWEP.Primary.Ammo = "smg1_grenade"
SWEP.Primary.ClipSize = 3
SWEP.Primary.Chamber = 1
SWEP.Primary.DefaultClip = 6
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 35

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
SWEP.SoundSingleShot = "MCV_Weapon_ChinaLake.Single"
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

SWEP.MuzzleParticle = "vietnam_muzzleflash_flaregun_type1_fp"
SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_flaregun_type1_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_flaregun_type1_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_flaregun_type1_fp_is_smoke"

SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_flaregun_type1_tp"

SWEP.NoEjectOnShoot = true
SWEP.EjectBrassType = 14
SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle = ""
SWEP.TracerParticle2 = ""

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 1
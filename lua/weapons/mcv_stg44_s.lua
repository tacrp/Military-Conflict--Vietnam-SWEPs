SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "StG-44 ZF4"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "Nazi Germany"
SWEP.SubCategory = "Assault Rifles"
SWEP.Caliber = "7.92x33mm"

SWEP.Slot = 3

SWEP.ViewModel = "models/weapons/mcv/v_stg44.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_stg44.mdl"

SWEP.BodyGroups = "001"
SWEP.WorldModelBodyGroups = "001"
SWEP.MagInTime = 1.37
SWEP.MagInTimeEmpty = 1.37
SWEP.MagOutTime = 0
SWEP.MagOutTimeEmpty = 0

SWEP.WeaponSelectIcon = NULL
SWEP.IconOverride = "entities/mcv_stg44s.png"

SWEP.SightedViewModelFOV = 30

// Stats

SWEP.DamageGeneric = 37 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 2.2
SWEP.DamageChestMultiplier = 1.1
SWEP.DamageStomachMultiplier = 1.05
SWEP.DamageLegMultiplier = 0.8
SWEP.DamageArmMultiplier = 0.75

SWEP.ExplosionDamage = 0
SWEP.ExplosionRadius = 0

SWEP.MuzzleVelocity = 810

SWEP.RangeModifier = 0.955

SWEP.Firemodes = {
    MCV.FIREMODE_AUTO,
    MCV.FIREMODE_SEMI,
}

// Weapon must be manually cycled
SWEP.PlayCycleAnimation = false

// View slide from recoil
SWEP.ViewSlideRecoilUp = 1.28
SWEP.ViewSlideRecoilRight = 0.32

SWEP.ViewSlideRecoilIronsightUp = 0.64
SWEP.ViewSlideRecoilIronsightRight = 0.16

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 1
SWEP.ShakeFreq = 50
SWEP.ShakeDuration = 0.3

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 1.0
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.MovementPoseWalk = 131
SWEP.MovementPoseSprint = 225
SWEP.MovementPoseSighted = 130

SWEP.HasScope = true
SWEP.ScopeMaterial = Material("models/weapons/mcv/optics/crosshair_svt40")
SWEP.ScopeFOV = 23.5
SWEP.ScopeFOV2 = 23.5
SWEP.RTScopeMaterialIndex = 3

SWEP.IronsightPos = Vector(0.038, -5.6, -0.97)
SWEP.IronsightAng = Angle(0, 0, 0)

SWEP.CustomPos = Vector(0, 0, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 7.25
SWEP.SpreadIronsighted = 0.75

SWEP.FireRate = 550 // in rounds per minute

SWEP.CrosshairMinDistance = 4
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 4.6

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.ClipSize = 20
SWEP.Primary.Chamber = 1
SWEP.Primary.DefaultClip = 100
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 30

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 0.75
SWEP.ProneSpreadMultiplier = 0.65
SWEP.StandMoveSpreadMultiplier = 1.45
SWEP.SneakMoveSpreadMultiplier = 1.35
SWEP.CrouchMoveSpreadMultiplier = 1.25
SWEP.JumpSpreadMultiplier = 3

SWEP.HasBayonet = false
SWEP.HasBipod = false

// Penetration
SWEP.MetalPenetrationDepth = 7
SWEP.GlassPenetrationDepth = 13
SWEP.ConcretePenetrationDepth = 9
SWEP.WoodPenetrationDepth = 17
SWEP.OtherPenetrationDepth = 11

SWEP.MetalDamageModifier = 1.6
SWEP.GlassDamageModifier = 1.2
SWEP.ConcreteDamageModifier = 1.8
SWEP.WoodDamageModifier = 1.3
SWEP.OtherDamageModifier = 1.3

// Sound
SWEP.SoundSingleShot = "MCV_Weapon_STG44.Single"
SWEP.SoundDoubleShot = ""
SWEP.SoundReload = ""
SWEP.SoundReloadThirdPerson = "MCV_Weapon_Foley_ThirdPerson_STG44.Reload"
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

SWEP.MuzzleParticle = "muzzleflash_ak47"
SWEP.MuzzleParticleSmoke = ""
SWEP.MuzzleParticleIronsighted = "muzzleflash_ak47"
SWEP.MuzzleParticleIronsightedSmoke = ""

SWEP.MuzzleParticle3rdPerson = "muzzleflash_ak47"

SWEP.EjectBrassType = 9
SWEP.EjectBrassTrail = "shellsmoke"
SWEP.EjectBrassParticle = "port_smoke"

SWEP.TracerParticle = "vietnam_tracer_assaultrifle_green_primary"
SWEP.TracerParticle2 = "vietnam_tracer_assaultrifle_green_secondary"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 1

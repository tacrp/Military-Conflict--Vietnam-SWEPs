SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "AKM"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "Soviet Union"
SWEP.SubCategory = "Assault Rifles"
SWEP.Caliber = "7.62x39mm"

SWEP.Slot = 3

SWEP.ViewModel = "models/weapons/mcv/v_akm.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_ak47.mdl"

SWEP.BodyGroups = ""

SWEP.WeaponSelectIcon = NULL

SWEP.BayonetBodygroup = 1

// Stats

SWEP.DamageGeneric = 38 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 2.52
SWEP.DamageChestMultiplier = 1.2
SWEP.DamageStomachMultiplier = 1.15
SWEP.DamageLegMultiplier = 0.8
SWEP.DamageArmMultiplier = 0.75

SWEP.ExplosionDamage = 0
SWEP.ExplosionRadius = 0

SWEP.MuzzleVelocity = 715

SWEP.RangeModifier = 0.94

SWEP.Firemodes = {
    MCV.FIREMODE_AUTO,
    MCV.FIREMODE_SEMI,
}

// Weapon must be manually cycled
SWEP.PlayCycleAnimation = false

// View slide from recoil
SWEP.ViewSlideRecoilUp = 1.36
SWEP.ViewSlideRecoilRight = 0.32

SWEP.ViewSlideRecoilIronsightUp = 0.82
SWEP.ViewSlideRecoilIronsightRight = 0.16

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 0.5
SWEP.ShakeFreq = 50
SWEP.ShakeDuration = 0.3

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 1.0
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25

SWEP.HasScope = false
SWEP.ScopeMaterial = NULL
SWEP.ScopeFOV = 8
SWEP.ScopeFOV2 = 4

SWEP.IronsightPos = Vector(0.05, -4, 0.025)
SWEP.IronsightAng = Angle(0.225, 0, 0)

SWEP.CustomPos = Vector(0, -2, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 7.72
SWEP.SpreadIronsighted = 1.47

SWEP.FireRate = 600 // in rounds per minute

SWEP.CrosshairMinDistance = 8
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 3.85

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.ClipSize = 30
SWEP.Primary.Chamber = 1
SWEP.Primary.DefaultClip = 90
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 40

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 0.75
SWEP.ProneSpreadMultiplier = 0.65
SWEP.StandMoveSpreadMultiplier = 1.35
SWEP.SneakMoveSpreadMultiplier = 1.25
SWEP.CrouchMoveSpreadMultiplier = 1.15
SWEP.JumpSpreadMultiplier = 3.0

SWEP.HasBayonet = true
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
SWEP.WoodDamgaeModifier = 1.25
SWEP.OtherDamageModifier = 1.25

// Sound
SWEP.SoundSingleShot = "MCV_Weapon_AKM.Single"
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

SWEP.MuzzleParticle = "muzzleflash_ak47"
SWEP.MuzzleParticleSmoke = ""
SWEP.MuzzleParticleIronsighted = "muzzleflash_ak47"
SWEP.MuzzleParticleIronsightedSmoke = ""

SWEP.MuzzleParticle3rdPerson = "muzzleflash_ak47"

SWEP.EjectBrassType = 1
SWEP.EjectBrassTrail = "shellsmoke"
SWEP.EjectBrassParticle = "port_smoke"

SWEP.TracerParticle = "tracer"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 1

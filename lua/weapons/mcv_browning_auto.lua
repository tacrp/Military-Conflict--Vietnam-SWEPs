SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "Auto 5" -- no copyright infringe-erino mister artig!!!!!!!!!!!
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "United States of America"
SWEP.SubCategory = "Shotguns"
SWEP.Caliber = "12 Gauge Shell"

SWEP.Slot = 2

SWEP.ViewModel = "models/weapons/mcv/v_browning_auto.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_browning_auto.mdl"

SWEP.BodyGroups = ""

SWEP.WeaponSelectIcon = NULL

// Stats

SWEP.DamageGeneric = 25 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 2.5
SWEP.DamageChestMultiplier = 1.5
SWEP.DamageStomachMultiplier = 1.25
SWEP.DamageLegMultiplier = 0.9
SWEP.DamageArmMultiplier = 0.85

SWEP.Num = 6

SWEP.MuzzleVelocity = 403

SWEP.RangeModifier = 0.8 // Every 500 units the damage is multiplied by rangemodifier

SWEP.Firemodes = {
    MCV.FIREMODE_SEMI
}

SWEP.LastShotAnimation = false
SWEP.ShotgunReload = true
SWEP.HasEmptyReload = true

// View slide from recoil
SWEP.ViewSlideRecoilUp = 3.2
SWEP.ViewSlideRecoilRight = 1.16

SWEP.ViewSlideRecoilIronsightUp = 2.35
SWEP.ViewSlideRecoilIronsightRight = 0.80

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 3
SWEP.ShakeFreq = 30.0
SWEP.ShakeDuration = 0.4

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 0.85
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25

SWEP.HasScope = false
SWEP.ScopeMaterial = NULL
SWEP.ScopeFOV = 8
SWEP.ScopeFOV2 = 4

SWEP.IronsightPos = Vector(0.05, -2, 0.25)
SWEP.IronsightAng = Angle(0.2, -0.25, 0)

SWEP.CustomPos = Vector(0, -2, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 9
SWEP.SpreadIronsighted = 3

SWEP.FireRate = 116 // in rounds per minute

SWEP.WeaponWeight = 3.85

SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.ClipSize = 4
SWEP.Primary.Chamber = 1
SWEP.Primary.DefaultClip = 16
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 40

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 0.85
SWEP.ProneSpreadMultiplier = 0.75
SWEP.StandMoveSpreadMultiplier = 1.5
SWEP.SneakMoveSpreadMultiplier = 1.4
SWEP.CrouchMoveSpreadMultiplier = 1.35
SWEP.JumpSpreadMultiplier = 3.0

SWEP.HasBayonet = false
SWEP.HasRifleGrenade = false

SWEP.BashDamage = 50
SWEP.BayonetDamage = 100

SWEP.HasBipod = false

// Penetration
SWEP.MetalPenetrationDepth = 83
SWEP.GlassPenetrationDepth = 8
SWEP.ConcretePenetrationDepth = 5
SWEP.WoodPenetrationDepth = 13
SWEP.OtherPenetrationDepth = 6

SWEP.MetalDamageModifier = 1.7
SWEP.GlassDamageModifier = 1.3
SWEP.ConcreteDamageModifier = 1.9
SWEP.WoodDamgaeModifier = 1.4
SWEP.OtherDamageModifier = 1.4

// Sound
SWEP.SoundSingleShot = "MCV_Weapon_M1897.Single"
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

SWEP.MuzzleParticle = "muzzleflash_m3"
SWEP.MuzzleParticleSmoke = ""
SWEP.MuzzleParticleIronsighted = "muzzleflash_m3"
SWEP.MuzzleParticleIronsightedSmoke = ""

SWEP.MuzzleParticle3rdPerson = "muzzleflash_m3"

SWEP.EjectBrassType = 2
SWEP.EjectBrassTrail = "shellsmoke"
SWEP.EjectBrassParticle = "port_smoke"

SWEP.TracerParticle = "tracer"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 1
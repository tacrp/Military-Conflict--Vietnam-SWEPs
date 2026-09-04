SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "SKS"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "Soviet Union"
SWEP.SubCategory = "Carbines"
SWEP.Caliber = "7.62x39mm"

SWEP.Slot = 3

SWEP.ViewModel = "models/weapons/mcv/v_sks.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_sks.mdl"

SWEP.BodyGroups = ""

SWEP.WeaponSelectIcon = NULL

SWEP.BayonetBodygroup = 1
SWEP.GrenadeLauncherBodygroup = 2
SWEP.GrenadeBodygroup = 3

// Stats

SWEP.DamageGeneric = 43 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 2.52
SWEP.DamageChestMultiplier = 1.2
SWEP.DamageStomachMultiplier = 1.15
SWEP.DamageLegMultiplier = 0.8
SWEP.DamageArmMultiplier = 0.75

SWEP.Num = 1

SWEP.MuzzleVelocity = 735

SWEP.RangeModifier = 0.950 // Every 500 units the damage is multiplied by rangemodifier

SWEP.Firemodes = {
    MCV.FIREMODE_SEMI
}

SWEP.LastShotAnimation = true
SWEP.MagInClip = true

SWEP.RifleGrenadeEntity = "mcv_proj_riflegrenade_vc"
SWEP.RifleGrenadeForce = 2000

// View slide from recoil
SWEP.ViewSlideRecoilUp = 1.35
SWEP.ViewSlideRecoilRight = 0.48

SWEP.ViewSlideRecoilIronsightUp = 1.35
SWEP.ViewSlideRecoilIronsightRight = 0.48

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 1
SWEP.ShakeFreq = 45.0
SWEP.ShakeDuration = 0.4

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 0.85
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25

SWEP.HasScope = false
SWEP.ScopeMaterial = NULL
SWEP.ScopeFOV = 8
SWEP.ScopeFOV2 = 4

SWEP.IronsightPos = Vector(0.1, -4, 0)
SWEP.IronsightAng = Angle(0.33, 0, 0)

SWEP.CustomPos = Vector(0, -2, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 6.3
SWEP.SpreadIronsighted = 1.15

SWEP.FireRate = 300 // in rounds per minute

SWEP.CrosshairMinDistance = 8
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 3.85

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.ClipSize = 10
SWEP.Primary.Chamber = 0
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 40

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 0.85
SWEP.ProneSpreadMultiplier = 0.75
SWEP.StandMoveSpreadMultiplier = 1.5
SWEP.SneakMoveSpreadMultiplier = 1.4
SWEP.CrouchMoveSpreadMultiplier = 1.35
SWEP.JumpSpreadMultiplier = 3.0

SWEP.HasBayonet = true
SWEP.HasRifleGrenade = true

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
SWEP.SoundSingleShot = "MCV_Weapon_SKS.Single"
SWEP.SoundDoubleShot = ""
SWEP.SoundReload = ""
SWEP.SoundSpecial1 = ""
SWEP.SoundSpecial2 = ""
SWEP.SoundGrenadeShot = "MCV_Weapon_SKS.RifleGrenade"
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

SWEP.MuzzleParticle = "vietnam_muzzleflash_rifle_type1_fp"
SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_rifle_type1_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_rifle_type1_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_rifle_type1_fp_is_smoke"

SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_rifle_type1_tp"

SWEP.EjectBrassType = 1
SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle = "vietnam_tracer_rifle_primary"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 1

SWEP.Secondary.Automatic = true
SWEP.Secondary.ClipSize = 1
SWEP.Secondary.Ammo = "smg1_grenade"
SWEP.Secondary.DefaultClip = 1
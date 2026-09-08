SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "M1 Garand"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "United States of America"
SWEP.SubCategory = "Battle Rifles"
SWEP.Caliber = ".30-06"

SWEP.Slot = 3

SWEP.ViewModel = "models/weapons/mcv/v_m1g_s.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_m1g_s.mdl"

SWEP.BodyGroups = "000100"
SWEP.WorldModelBodyGroups = "00100"

SWEP.WeaponSelectIcon = NULL

SWEP.BayonetBodygroup = 2
SWEP.GrenadeLauncherBodygroup = 4
SWEP.GrenadeBodygroup = 5

// Stats

SWEP.DamageGeneric = 50 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 2.55
SWEP.DamageChestMultiplier = 1.5
SWEP.DamageStomachMultiplier = 1.45
SWEP.DamageLegMultiplier = 0.95
SWEP.DamageArmMultiplier = 0.9

SWEP.Num = 1

SWEP.MuzzleVelocity = 735

SWEP.RangeModifier = 0.965 // Every 500 units the damage is multiplied by rangemodifier

SWEP.Firemodes = {
    MCV.FIREMODE_SEMI
}

SWEP.LastShotAnimation = true
// false: the en-bloc clip goes in whole, so the counter jumps to the loaded magazine at the
// model's NEXTCLIP event (frame 30) rather than counting the rounds on their way in, which
// is how a stripper clip reads. The generator keeps a value set here over its own guess.
SWEP.MagInClip = false

SWEP.RifleGrenadeEntity = "mcv_proj_riflegrenade"
SWEP.RifleGrenadeForce = 2000

// View slide from recoil
SWEP.ViewSlideRecoilUp = 2.4
SWEP.ViewSlideRecoilRight = 0.92

SWEP.ViewSlideRecoilIronsightUp = 1.56
SWEP.ViewSlideRecoilIronsightRight = 0.6

SWEP.RecoilPushbackValue = 1.5

// Camera shake from recoil
SWEP.ShakeScale = 1
SWEP.ShakeFreq = 45
SWEP.ShakeDuration = 0.4

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 0.85
SWEP.IronsightFov = 90 - 15
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.MovementPoseWalk = 134
SWEP.MovementPoseSprint = 228
SWEP.MovementPoseSighted = 130

SWEP.HasScope = false
SWEP.ScopeMaterial = NULL
SWEP.ScopeFOV = 8
SWEP.ScopeFOV2 = 4

SWEP.IronsightPos = Vector(0, -5, 0)
SWEP.IronsightAng = Angle(0, 0, 0)

SWEP.CustomPos = Vector(0, -2, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 8
SWEP.SpreadIronsighted = 0.75

SWEP.FireRate = 330 // in rounds per minute

SWEP.CrosshairMinDistance = 4
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 4.31

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.ClipSize = 8
SWEP.Primary.Chamber = 0
SWEP.Primary.DefaultClip = 56
SWEP.Primary.Automatic = true

SWEP.MagInTime = 1
SWEP.MagInTimeEmpty = 1
SWEP.MagOutTime = 0
SWEP.MagOutTimeEmpty = 0

SWEP.NearwallDistance = 45

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 0.65
SWEP.ProneSpreadMultiplier = 0.55
SWEP.StandMoveSpreadMultiplier = 1.6
SWEP.SneakMoveSpreadMultiplier = 1.5
SWEP.CrouchMoveSpreadMultiplier = 1.4
SWEP.JumpSpreadMultiplier = 4

SWEP.HasBayonet = true
SWEP.HasRifleGrenade = true

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
SWEP.SoundSingleShot = "MCV_Weapon_M1G.Single"
SWEP.SoundDoubleShot = ""
SWEP.SoundReload = ""
SWEP.SoundSpecial1 = ""
SWEP.SoundSpecial2 = ""
SWEP.SoundGrenadeShot = "MCV_Weapon_M1G.RifleGrenade"
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

SWEP.MuzzleParticle = "muzzleflash_1"
SWEP.MuzzleParticleSmoke = ""
SWEP.MuzzleParticleIronsighted = "muzzleflash_1"
SWEP.MuzzleParticleIronsightedSmoke = ""

SWEP.MuzzleParticle3rdPerson = "muzzleflash_1"

SWEP.EjectBrassType = 16
SWEP.EjectBrassTrail = "shellsmoke"
SWEP.EjectBrassParticle = "port_smoke"

SWEP.TracerParticle = "vietnam_tracer_rifle_primary"
SWEP.TracerParticle2 = "vietnam_tracer_rifle_secondary"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 1

SWEP.Secondary.Automatic = true
SWEP.Secondary.ClipSize = 1
SWEP.Secondary.Ammo = "smg1_grenade"
SWEP.Secondary.DefaultClip = 1
SWEP.Base = "mcv_base"
SWEP.Base = "mcv_base"

SWEP.Spawnable = true

AddCSLuaFile()

// Names and basic information
SWEP.PrintName = "M1903A4 Springfield"
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Country = "United States of America"
SWEP.SubCategory = "Sniper Rifles"
SWEP.Caliber = ".30-06"

SWEP.Slot = 3

SWEP.ViewModel = "models/weapons/mcv/v_springfield.mdl"
SWEP.WorldModel = "models/weapons/mcv/w_springfield.mdl"

SWEP.BodyGroups = "00000"

SWEP.WeaponSelectIcon = NULL
SWEP.IconOverride = "entities/mcv_m1903s.png"

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
// A scope sits over the receiver, where the stripper clip would have to go, so a sniper feeds
// one round at a time even where the rifle it is built on takes a clip. The single-round set is
// in the model already (reload_start / reload_insert / reload_end); the clip animations are the
// ones that go unused now. Same as the M40 and the Vz.54 sniper.
SWEP.ShotgunReload = true
SWEP.InsertClipPoseTime = 0.2
SWEP.ShotgunAltReload = true
SWEP.ShotgunReloadEmptyStartAnimation = false
SWEP.PlayCycleAnimation = true
SWEP.HasEmptyReload = true

SWEP.RifleGrenadeEntity = "mcv_proj_riflegrenade"
SWEP.RifleGrenadeForce = 2000

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
SWEP.MovementPoseWalk = 136
SWEP.MovementPoseSprint = 231
SWEP.MovementPoseSighted = 130

SWEP.HasScope = true
SWEP.ScopeMaterial = Material("models/weapons/mcv/optics/crosshair_spring")
SWEP.ScopeFOV = 36.8
SWEP.ScopeFOV2 = 18.9
SWEP.RTScopeMaterialIndex = 2

SWEP.IronsightPos = Vector(0.01, -2.5, -0.435)
SWEP.IronsightAng = Angle(0, 0, 0)

SWEP.CustomPos = Vector(0, 0, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 7
SWEP.SpreadIronsighted = 0.05

SWEP.FireRate = 600 // in rounds per minute
SWEP.CyclePostDelay = 0.9

SWEP.CrosshairMinDistance = 8
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 3.95

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.ClipSize = 5
SWEP.Primary.Chamber = 0
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Automatic = true

SWEP.NearwallDistance = 50

// Bullet spread multiplier according to current stance
SWEP.CrouchSpreadMultiplier = 0.8
SWEP.ProneSpreadMultiplier = 0.75
SWEP.StandMoveSpreadMultiplier = 1.65
SWEP.SneakMoveSpreadMultiplier = 1.55
SWEP.CrouchMoveSpreadMultiplier = 1.45
SWEP.JumpSpreadMultiplier = 5

SWEP.HasBayonet = false
SWEP.HasRifleGrenade = false

SWEP.BashDamage = 50
SWEP.BayonetDamage = 100

SWEP.HasBipod = false
SWEP.AdjustableScopes = true

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
SWEP.SoundSingleShot = "MCV_Weapon_M1903.Single"
SWEP.SoundDoubleShot = ""
SWEP.SoundReload = ""
SWEP.SoundReloadThirdPerson = "MCV_Weapon_Foley_ThirdPerson_M1903.Reload"
SWEP.SoundReloadLoopThirdPerson = "MCV_Weapon_Foley_ThirdPerson_M40.ReloadLoop"
SWEP.SoundCycleThirdPerson = "MCV_Weapon_Foley_ThirdPerson_M1903.Cycle"
SWEP.SoundSpecial1 = ""
SWEP.SoundSpecial2 = ""
SWEP.SoundGrenadeShot = "MCV_Weapon_KAR98K.RifleGrenade"
SWEP.SoundNearlyEmpty = "MCV_Weapon_Generic.NearlyEmptyClick"
SWEP.SoundEmpty = "MCV_Weapon_Generic.ClipEmpty_07"

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
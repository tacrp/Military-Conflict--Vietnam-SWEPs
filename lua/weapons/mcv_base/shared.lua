// Spawnable
SWEP.Spawnable = false
SWEP.AdminOnly = false
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Base = "mcv_base_core"

// Names and basic information
SWEP.PrintName = ""
SWEP.Country = ""
SWEP.SubCategory = ""
SWEP.Caliber = ""

SWEP.ViewModel = "models/weapons/mcv/v_sks.mdl"
SWEP.ViewModelAkimbo = ""
SWEP.WorldModel = "models/weapons/mcv/w_sks.mdl"

SWEP.BodyGroups = ""
SWEP.BayonetBodygroup = 0
SWEP.GrenadeLauncherBodygroup = 0
SWEP.GrenadeBodygroup = 0

SWEP.BulletBodygroups = nil

SWEP.ViewModelFOV = 80
SWEP.SightedViewModelFOV = 40

// Stats

SWEP.DamageGeneric = 43 // damage for other objects (i.e. explosive barrels, breakable walls, or characters with no hitboxes set)
SWEP.DamageHeadMultiplier = 1
SWEP.DamageChestMultiplier = 1
SWEP.DamageStomachMultiplier = 1
SWEP.DamageLegMultiplier = 1
SWEP.DamageArmMultiplier = 1

SWEP.Num = 1
SWEP.AmmoPerShot = 1

SWEP.RangeModifier = 0.950 // Every 500 units the damage is multiplied by rangemodifier

SWEP.Firemodes = {
    MCV.FIREMODE_SEMI
}

SWEP.VolleyCount = 2

SWEP.HoldType = "ar2"
SWEP.SprintHoldType = "passive"
SWEP.AimHoldType = "rpg"

SWEP.ShootGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_AR2
SWEP.BashGesture = ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND

SWEP.AdjustableScopes = false

// Weapon must be manually cycled
SWEP.PlayCycleAnimation = false
SWEP.SlamFire = false // pump with the trigger held and fire as the action closes (M1897, M37)
SWEP.LastShotAnimation = false
SWEP.ShotgunReloadEmptyStartAnimation = false
SWEP.AkimboDualSingleActionReload = false // Halfway between reloading, change hand
SWEP.AnimationHandlesHammer = false
SWEP.InvertAnimationHammer = false

SWEP.RevolverFiremodePose = false // Adds handling for revolver firemode poses

SWEP.TriggerDelayTime = 0.25

SWEP.ShotgunReload = false
SWEP.ShotgunAltReload = false // Clip-loading rifles use this set of anims for bullet loading
SWEP.HybridReload = false
SWEP.HasEmptyReload = true
SWEP.ShotgunReloadRounds = 1

SWEP.MagInTime = 0 // seconds into the reload animation when the new magazine / belt is in (the rounds shown jump to the new count)
SWEP.MagInTimeEmpty = 0
SWEP.MagOutTime = 0 // seconds in when the old one comes out (no rounds shown until MagInTime); 0 = off
SWEP.MagOutTimeEmpty = 0
SWEP.MagInTimeGrenade = 0.5
SWEP.MagInClip = false

SWEP.Silencer = false

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
SWEP.RTScopeMaterialIndex = 1

SWEP.IronsightPos = Vector(0, 0, 0)
SWEP.IronsightAng = Angle(0, 0, 0)

SWEP.CustomPos = Vector(0, 0, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.Spread = 6.3
SWEP.SpreadIronsighted = 1.15

SWEP.FireRate = 300 // in rounds per minute
SWEP.CycleSpeed = 0.75 // how long is the cycle animation
SWEP.CyclePostDelay = 0.65 // how long to wait after cycling before we can fire again

SWEP.CrosshairMinDistance = 8
SWEP.CrosshairDeltaDistance = 4

SWEP.WeaponWeight = 3.85

SWEP.ShootEntity = nil
SWEP.ShootEntityForce = 5000

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.ClipSize = 10
SWEP.Primary.Chamber = 1
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

SWEP.HasBayonet = false
SWEP.HasRifleGrenade = false
SWEP.RifleGrenadeIsUBGL = false
SWEP.HasAkimbo = false

SWEP.RifleGrenadeEntity = "mcv_proj_riflegrenade"
SWEP.RifleGrenadeForce = 5000

SWEP.BashDamage = 50
SWEP.BashRange = 96
SWEP.BayonetDamage = 100
SWEP.BayonetRange = 128

SWEP.HasBipod = false

// Playback rate multiplier for fire animations. Models ported with the 60-frame idle base
// (the default of work/port_qc.py) need 0.5; models ported with --base-len match need 1.
SWEP.ShootAnimRate = 0.5

// Dual wield: drive per-hand recoil through the "recoil_r" / "recoil_l" pose parameters
// instead of switching sequences (models ported with port_qc.py --pose-recoil). Both hands
// recoil independently and the idle, walk and run layers keep playing underneath.
SWEP.AkimboPoseRecoil = false
SWEP.AkimboRecoilTime = 0.8 // seconds; should match the length of the hand's shoot animation

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
SWEP.SoundGrenadeShot = "Weapon_SKS.RifleGrenade"
SWEP.SoundNearlyEmpty = "MCV_Weapon_Generic.NearlyEmptyClick"
SWEP.SoundEmpty = "MCV_Weapon_Generic.ClipEmpty_01"

// Particles
SWEP.MuzzleParticle = "vietnam_muzzleflash_rifle_type1_fp"
SWEP.MuzzleParticleSmoke = "vietnam_muzzleflash_rifle_type1_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_rifle_type1_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_rifle_type1_fp_is_smoke"

SWEP.MuzzleFlashLightTexture = "effects/flashlight_muzzleflash"

SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_rifle_type1_tp"

SWEP.NoEjectOnShoot = false

SWEP.EjectBrassType = 5
SWEP.EjectBrassTrail = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle = "vietnam_tracer_rifle_primary"

SWEP.TracerRandomness = 6
SWEP.TracerFrequency = 1

// Boilerplate

SWEP.DrawCrosshair = true
SWEP.AccurateCrosshair = false
SWEP.DrawWeaponInfoBox = true
SWEP.UseHands = true

SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.Ammo = ""
SWEP.Secondary.DefaultClip = 0

SWEP.MilitaryConflictVietnam = true

SWEP.BobScale = 0
SWEP.SwayScale = 0.1

AddCSLuaFile()

local searchdir = "weapons/mcv_base"

local function autoinclude(dir)
    local files, dirs = file.Find(searchdir .. "/*.lua", "LUA")

    for _, filename in pairs(files) do
        if filename == "shared.lua" then continue end
        local luatype = string.sub(filename, 1, 2)

        if luatype == "sv" then
            if SERVER then
                include(dir .. "/" .. filename)
            end
        elseif luatype == "cl" then
            AddCSLuaFile(dir .. "/" .. filename)
            if CLIENT then
                include(dir .. "/" .. filename)
            end
        else
            AddCSLuaFile(dir .. "/" .. filename)
            include(dir .. "/" .. filename)
        end
    end

    for _, path in pairs(dirs) do
        autoinclude(dir .. "/" .. path)
    end
end

autoinclude(searchdir)

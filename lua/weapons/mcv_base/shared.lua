// Spawnable
SWEP.Spawnable = false
SWEP.AdminOnly = false
SWEP.Category = "Military Conflict: Vietnam"
SWEP.Base = "weapon_base"

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

SWEP.WeaponSelectIcon = NULL

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

SWEP.AdjustableScopes = false

// Weapon must be manually cycled
SWEP.PlayCycleAnimation = false
SWEP.LastShotAnimation = false
SWEP.ShotgunReloadEmptyStartAnimation = false
SWEP.AkimboDualSingleActionReload = false // Halfway between reloading, change hand

SWEP.RevolverFiremodePose = false // Adds handling for revolver firemode poses

SWEP.TriggerDelayTime = 0.25

SWEP.ShotgunReload = false
SWEP.ShotgunAltReload = false // Clip-loading rifles use this set of anims for bullet loading
SWEP.HybridReload = false
SWEP.HasEmptyReload = true

SWEP.MagInTime = 0
SWEP.MagInTimeEmpty = 0
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


function SWEP:SetupDataTables()
    self:NetworkVar("Float", 0, "RecoilAmount")
    self:NetworkVar("Float", 1, "AnimLockTime")
    self:NetworkVar("Float", 2, "NextIdle")
    self:NetworkVar("Float", 3, "LastRecoilTime")
    self:NetworkVar("Float", 4, "RecoilDirection")
    self:NetworkVar("Float", 5, "SprintLockTime")
    self:NetworkVar("Float", 6, "LastScopeTime")
    self:NetworkVar("Float", 7, "LastMeleeTime")
    self:NetworkVar("Float", 8, "LastTriggerTime")
    self:NetworkVar("Float", 9, "SightAmount")
    self:NetworkVar("Float", 10, "HolsterTime")
    self:NetworkVar("Float", 11, "NWHoldBreathAmount")
    self:NetworkVar("Float", 12, "Breath")
    self:NetworkVar("Float", 13, "Speed")

    self:NetworkVar("Int", 0, "BurstCount")
    self:NetworkVar("Int", 1, "ScopeLevel")
    self:NetworkVar("Int", 2, "LastClip")
    self:NetworkVar("Int", 3, "Firemode")

    self:NetworkVar("Bool", 1, "Reloading")
    self:NetworkVar("Bool", 2, "EndReload")
    self:NetworkVar("Bool", 3, "Ready")
    self:NetworkVar("Bool", 4, "Bipod")
    self:NetworkVar("Bool", 5, "OutOfBreath")
    self:NetworkVar("Bool", 6, "HoldingBreath")
    self:NetworkVar("Bool", 7, "LastWasSprinting")
    self:NetworkVar("Bool", 8, "EmptyReload")
    self:NetworkVar("Bool", 9, "NeedTriggerPress")
    self:NetworkVar("Bool", 10, "Ironsight")
    self:NetworkVar("Bool", 11, "Bayonet")
    self:NetworkVar("Bool", 12, "GrenadeLauncher")
    self:NetworkVar("Bool", 13, "NeedCycle")
    self:NetworkVar("Bool", 14, "Akimbo")
    self:NetworkVar("Bool", 15, "PrimedAttack")

    self:NetworkVar("Angle", 0, "BipodAngle")

    self:NetworkVar("Vector", 0, "BipodPos")

    self:NetworkVar("Entity", 0, "HolsterEntity")

    self:SetFiremode(1)
    self:SetScopeLevel(1)
    self:SetNeedCycle(false)
end

function SWEP:SecondaryAttack()
    local owner = self:GetOwner()

    if owner:KeyDown(IN_USE) then
        self:ToggleBayonet()
    end
end

local function clunpredictvar(tbl, name, varname, default)
    local clvar = "CL_" .. name

    tbl[clvar] = default

    tbl["Set" .. name] = function(self, v)
        if (!game.SinglePlayer() and CLIENT and self:GetOwner() == LocalPlayer()) then self[clvar] = v end
        self["Set" .. varname](self, v)
    end

    tbl["Get" .. name] = function(self)
        if (!game.SinglePlayer() and CLIENT and self:GetOwner() == LocalPlayer()) then return self[clvar] end
        return self["Get" .. varname](self)
    end
end

clunpredictvar(SWEP, "HoldBreathAmount", "NWHoldBreathAmount", 0)

function SWEP:GetPingOffsetScale()
    if game.SinglePlayer() then return 0 end

    return (self:GetOwner():Ping() - 5) / 1000
end
// Hand grenades, smoke, gas, incendiaries. Left click winds up an overhand throw, right click
// an underhand lob (a roll when crouched); the throw leaves the hand when the button is
// released. USE + reload cycles the fuse presets, USE + attack bashes.

SWEP.Base = "mcv_base_core"
SWEP.Spawnable = false

SWEP.SubCategory = "Grenades"
SWEP.Slot = 4

SWEP.HoldType = "grenade"
SWEP.SprintHoldType = "normal"
SWEP.AimHoldType = "grenade"

SWEP.ShootGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE

// What leaves the hand
SWEP.ThrowEntity = "mcv_grenade_frag"
SWEP.ThrowModel = nil // defaults to the world model
SWEP.ThrowForceOverhand = 1250
SWEP.ThrowForceUnderhand = 600
SWEP.ThrowForceRoll = 450
SWEP.ThrowSpin = 400
// seconds into the throw animation at which the grenade actually leaves the hand
SWEP.ThrowReleaseTime = 0.22
SWEP.ThrowReleaseTimeUnderhand = 0.3

// Fuse presets in seconds; USE + reload cycles them (the game's FuseTimeMin / FuseTimeMax)
SWEP.FuseModes = {3, 5}
SWEP.FuseImpact = false // explodes on the first touch instead (molotov)

// Passed to the projectile
SWEP.ExplosionDamage = 150
SWEP.ExplosionRadius = 350
SWEP.IgniteRadius = 0
SWEP.SmokeColor = nil // Vector(r, g, b) 0..255 for coloured smoke
SWEP.EffectDuration = 25 // smoke / gas / fire duration

SWEP.HasUnderhand = true
SWEP.RemoveWhenEmpty = true

// Sequence names on the game's grenade viewmodels
SWEP.SequenceWindupHigh = "drawbackhigh"
SWEP.SequenceThrowHigh = "throw"
SWEP.SequenceWindupLow = "drawbacklow"
SWEP.SequenceThrowLow = "lob"
SWEP.SequenceRoll = "roll"
SWEP.SequenceFiremode = "firemode"

SWEP.Primary.Ammo = "mcv_grenade"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 2
SWEP.Primary.Automatic = false

SWEP.BashDamage = 30
SWEP.BashRange = 72

SWEP.DrawCrosshair = true

AddCSLuaFile()

local searchdir = "weapons/mcv_throwable"

for _, filename in pairs(file.Find(searchdir .. "/*.lua", "LUA")) do
    if filename == "shared.lua" then continue end
    local luatype = string.sub(filename, 1, 2)

    if luatype == "sv" then
        if SERVER then include(searchdir .. "/" .. filename) end
    elseif luatype == "cl" then
        AddCSLuaFile(searchdir .. "/" .. filename)
        if CLIENT then include(searchdir .. "/" .. filename) end
    else
        AddCSLuaFile(searchdir .. "/" .. filename)
        include(searchdir .. "/" .. filename)
    end
end

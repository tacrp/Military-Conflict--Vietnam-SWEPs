// Ammo and medic boxes. Left click hands the box to the player you are looking at, right
// click uses it on yourself, USE + attack throws it down for anyone to pick up.

SWEP.Base = "mcv_base_core"
SWEP.Spawnable = false

SWEP.SubCategory = "Equipment"
SWEP.Slot = 4

SWEP.HoldType = "slam"
SWEP.SprintHoldType = "normal"
SWEP.AimHoldType = "slam"

SWEP.BoxKind = "ammo" // "ammo" or "medic"
SWEP.HealAmount = 50
SWEP.AmmoMagazines = 2 // magazines' worth of reserve per gun
SWEP.GiveRange = 96
SWEP.DroppedEntity = "mcv_supply_box"

SWEP.SequenceGive = "give"
SWEP.SequenceSelf = "self"
SWEP.SequenceThrow = "throw"
SWEP.GiveDelay = 0.4
SWEP.ThrowDelay = 0.3

SWEP.Primary.Ammo = "mcv_ammobox"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 3
SWEP.Primary.Automatic = false

AddCSLuaFile()

local searchdir = "weapons/mcv_equipment_box"

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

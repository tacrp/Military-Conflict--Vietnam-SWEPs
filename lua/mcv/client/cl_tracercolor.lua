// Tracer colour, a per-player preference.
//
// The convar is userinfo, so a player's choice travels with them: every other client can read
// it off the shooter and colour that player's tracers the way the shooter asked for, rather
// than the way the person watching did. The effect (effects/mcv_tracer.lua) draws the streak,
// so nothing has to be networked for a shot beyond what the engine already sends.

MCV = MCV or {}

MCV.TRACER_COLOR_GUN = 0     // the colour the gun's own tracer carries in the game
MCV.TRACER_COLOR_PLAYER = 1  // the shooter's player colour
MCV.TRACER_COLOR_WEAPON = 2  // a colour of the weapon's own, one per class

CreateClientConVar("mcv_tracer_color", "0", true, true,
    "Tracer colour: 0 the gun's own, 1 your player colour, 2 one colour per weapon. Other players see the one you pick.")

// What `ply` has chosen. Reading it off the player rather than off our own convar is the whole
// point: a tracer someone else fires is coloured by their setting.
function MCV.TracerColorMode(ply)
    if !IsValid(ply) or !ply:IsPlayer() then return MCV.TRACER_COLOR_GUN end

    return math.Clamp(math.floor(tonumber(ply:GetInfo("mcv_tracer_color")) or 0), 0, 2)
end

// A player colour can be anything down to black, and a dark tracer reads as no tracer at all,
// so the hue is kept and the brightness pushed back up to full.
function MCV.BrightColor(v)
    local m = math.max(v.x, v.y, v.z)
    if m < 0.004 then return Color(255, 255, 255) end

    local s = 255 / m
    return Color(v.x * s, v.y * s, v.z * s)
end

// One hue per weapon class, so a gun is known by the colour of its tracers. The class name is
// hashed onto the wheel; saturation and value are fixed, which keeps every gun's colour equally
// readable against the sky and the ground.
local weaponcolours = {}

function MCV.WeaponColor(class)
    if !class or class == "" then return color_white end

    local c = weaponcolours[class]
    if !c then
        local h = 0
        for i = 1, #class do
            h = (h * 31 + class:byte(i)) % 360
        end

        c = HSVToColor(h, 0.55, 1)
        weaponcolours[class] = c
    end

    return c
end

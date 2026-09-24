// Bullet impacts: the game's own per-surface systems in place of the engine's dust puff.
//
// particles/vietnam_impact_effects.pcf holds impact_<surface>_1 .. _3 for 33 surfaces. Each
// numbered system is a whole impact on its own, pulling in that surface's debris, mist, smoke,
// sparks and glow as children, so one of the three played at the hit point is the entire effect.
//
// The direction comes off the control points, not off the angles the system is created with.
// The children spray along the local X of a control point (Position Within Sphere Random with
// speed_in_local_coordinate_system: 180 of them read point 1 and 86 read point 0), so both
// points have to carry the surface normal as their forward, or every impact sprays the same
// way in world space whatever it hit. Only a clientside particle handle can set point 1, which
// is why this goes out as an effect (effects/mcv_impact.lua) rather than a plain ParticleEffect.
//
// SWEP:DoImpactEffect (mcv_base_core/shared.lua) hands the trace here and returns what this
// returns. Returning true takes the engine's UTIL_ImpactTrace off the shot, and that call is
// what puts the bullet hole down as well, so the hole is put back here by hand.

MCV.RegisterConVar("mcv_surface_impacts", "1",
    "1: the game's own per-surface bullet impacts. 0: the engine's.")

function MCV.SurfaceImpacts()
    return MCV.ConVars.mcv_surface_impacts:GetBool()
end

// The surfaces the impact pcf carries, each with three variants. Ordered, because the effect
// travels as an index into this list. The `_spike` families (dirt_spike, mud_spike,
// puddle_spike, wet_spike) have only two variants and are alternates the numbered systems pull
// in themselves, so nothing here points at them.
MCV.ImpactFamilies = {
    "asphalt", "brick", "cardboard", "carpet", "clay", "cloth", "computer", "concrete",
    "dirt", "glass", "grass", "leaves", "metal", "metalsteam", "metalwater", "mud",
    "paper", "plaster", "plastic", "puddle", "rock", "rubber", "sand", "sandbarrel",
    "sheetrock", "snow", "tile", "upholstery", "water_large", "water_medium", "water_small",
    "wet", "wood",
}

game.AddParticles("particles/mcv_scaled_impacts.pcf")
game.AddParticles("particles/mcv_scaled_impacts_cheap.pcf")

local index = {}
for i, name in ipairs(MCV.ImpactFamilies) do
    index[name] = i
    for v = 1, 3 do
        PrecacheParticleSystem("mcv_scaled_impact_" .. name .. "_" .. v)
    end
end

// Coarse fallback when the surface property's own name is not one of those. Flesh is left out
// on purpose: the engine's blood is better than anything in here, so those shots keep it.
local mattype_to_family = {
    [MAT_CONCRETE] = "concrete",
    [MAT_DEFAULT] = "concrete",
    [MAT_TILE] = "tile",
    [MAT_DIRT] = "dirt",
    [MAT_SAND] = "sand",
    [MAT_GRASS] = "grass",
    [MAT_FOLIAGE] = "leaves",
    [MAT_SLOSH] = "puddle",
    [MAT_METAL] = "metal",
    [MAT_GRATE] = "metal",
    [MAT_VENT] = "metal",
    [MAT_COMPUTER] = "computer",
    [MAT_WOOD] = "wood",
    [MAT_GLASS] = "glass",
    [MAT_PLASTIC] = "plastic",
    [MAT_SNOW] = "snow",
    [MAT_EGGSHELL] = "plaster",
}

// The game's own decal materials are registered by sh_impact_decals.lua.
local decal_alias = {
    metalsteam = "metal", metalwater = "metal", sandbarrel = "sand",
    clay = "dirt", wet = "dirt", paper = "cardboard", cloth = "upholstery",
}

function MCV.ImpactDecalName(family)
    if family == "puddle" or string.StartWith(family, "water_") then return end
    family = decal_alias[family] or family
    if !MCV.SurfaceDecals[family] then family = "concrete" end
    return "MCV.Impact." .. family
end

// The surface's own property name first, since it separates brick, asphalt, rock and carpet
// from the one MAT_CONCRETE the engine reports for all of them; the material type otherwise.
function MCV.ImpactFamily(tr)
    local data = tr.SurfaceProps and util.GetSurfaceData(tr.SurfaceProps)
    local name = data and data.name
    if name and index[name] then return name end

    return mattype_to_family[tr.MatType]
end

// True when the impact was handled here, which is the weapon hook's signal to leave the
// engine's own alone.
// 40 damage is the original size. Square-root growth keeps pellet marks modest
// and caps very powerful/custom-multiplier weapons at twice the particle radius.
function MCV.ImpactScale(damage)
    return math.Clamp(math.sqrt(math.max(damage or 40, 0) / 40), 0.5, 2)
end

function MCV.SurfaceImpact(tr, damage, recipients)
    if !MCV.SurfaceImpacts() then return false end
    if !tr or !tr.Hit or tr.HitSky then return false end

    local family = MCV.ImpactFamily(tr)
    local i = family and index[family]
    if !i then return false end
    // This hook receives authoritative client impacts (including singleplayer),
    // outside user-command prediction. IsFirstTimePredicted can be false here;
    // it is not a replay indicator for this callback. The engine gates the hook.

    local fx = EffectData()
    fx:SetOrigin(tr.HitPos)
    fx:SetNormal(tr.HitNormal)
    fx:SetFlags(i)
    fx:SetScale(MCV.ImpactScale(damage))
    // Authoritative/SP callers run outside prediction. Hitscan supplies its own
    // recipient filter and gates first-predicted dispatch at the firing callback.
    util.Effect("mcv_impact", fx, true, recipients or true)

    return true
end

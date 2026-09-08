// Per-category stat multipliers.
//
// Every weapon carries a SubCategory, the same one the spawn menu groups it under, and each
// category has a multiplier for each stat below: one convar per pair, replicated like the rest
// of the gameplay settings so a server's numbers are the ones everybody plays with. 1 leaves a
// stat as the game has it, which is what they all default to, so an untouched install behaves
// exactly as before.
//
// The Q menu drives them (Options > Military Conflict: Vietnam), a category at a time.
// Adding a stat is an entry in MCV.CategoryStats plus the one line that reads it in the
// weapon code; adding a category is an entry in MCV.Categories.

MCV = MCV or {}

// A rifle grenade and an underbarrel round are their own category, not the host rifle's: the
// rifles that carry one sit across five categories and it is the same grenade out of any of
// them. The launchers that fire on the primary trigger keep their own category.
MCV.CATEGORY_RIFLE_GRENADE = "Rifle Grenades"

// the order the menu lists them in
MCV.Categories = {
    "Pistols", "Machine Pistols", "Revolvers",
    "Submachine Guns", "Assault Rifles", "Carbines", "Battle Rifles",
    "Bolt-Action Rifles", "Sniper Rifles", "Shotguns", "Light-Machine Guns",
    "Anti-Armor", "Explosives", "Grenades", "Flamethrowers",
    "Bows", "Melee", "Equipment",
    MCV.CATEGORY_RIFLE_GRENADE,
}

MCV.CategoryStats = {
    {key = "damage", label = "Damage",
     help = "What a hit takes off, before the hitgroup multipliers."},
    {key = "spread", label = "Hip spread",
     help = "The cone from the hip. In realistic shooting it is how far the barrel wanders instead."},
    {key = "spread_sights", label = "Aimed spread",
     help = "The cone on the sights, and what the hip cone narrows to."},
    {key = "recoil", label = "Recoil",
     help = "How hard a shot kicks the view."},
    {key = "firerate", label = "Fire rate",
     help = "Rounds a minute. Does not touch anything paced by its own animation, a bolt or a pump."},
    {key = "explosion_damage", projectile = true, label = "Explosion damage",
     help = "What a blast takes off at its centre. Rockets, grenades and charges alike."},
    {key = "explosion_radius", projectile = true, label = "Explosion radius",
     help = "How far the blast reaches."},
    {key = "projectile_speed", projectile = true, label = "Projectile speed",
     help = "How fast a rocket, grenade or bolt leaves the weapon."},
}

// mcv_cat_<category>_<stat>: "Light-Machine Guns" damage is mcv_cat_light_machine_guns_damage
function MCV.CategorySlug(category)
    return (tostring(category or ""):lower():gsub("[^%w]+", "_"):gsub("^_+", ""):gsub("_+$", ""))
end

function MCV.CategoryConVarName(category, stat)
    return "mcv_cat_" .. MCV.CategorySlug(category) .. "_" .. stat
end

for _, category in ipairs(MCV.Categories) do
    for _, stat in ipairs(MCV.CategoryStats) do
        MCV.RegisterConVar(MCV.CategoryConVarName(category, stat.key), "1",
            string.format("%s of every %s, times this. 1 is the stat as the game has it.",
                stat.label, category))
    end
end

// The multiplier in force for a category, 1 for anything unlisted (a weapon with no
// SubCategory, or one added to a category the table does not name yet).
function MCV.CategoryMult(category, stat)
    local cv = MCV.ConVars[MCV.CategoryConVarName(category, stat)]
    if !cv then return 1 end

    local v = cv:GetFloat()
    return v >= 0 and v or 1
end

// The Q menu tab: Options > Military Conflict: Vietnam.
//
// Everything the addon can be told to do lives in SETTINGS below, so adding a convar is one
// entry here and nothing else. A `section` entry starts a heading; an entry with `choices` is a
// dropdown, anything else a checkbox. See CLAUDE.md.
//
// The gameplay convars are replicated, so on a server only the host can change them and a
// client's choice is ignored; the ones under Yours are that client's own.

MCV = MCV or {}

local SETTINGS = {
    {section = "Gameplay",
     help = "Shared by everyone on the server. On a server other than your own these are the host's to set."},

    {convar = "mcv_realistic_shooting", label = "Realistic shooting",
     help = "The addon's own recoil and spread: the bullet leaves the barrel where it points, so hip fire misses because the gun is not lined up with your eye rather than through a cone. Off is the game's own numbers."},

    {convar = "mcv_surface_impacts", label = "The game's bullet impacts",
     help = "Impact effects per surface as the game has them. Off falls back to the engine's."},

    {section = "Yours",
     help = "Your own settings. Other players see the tracer colour you pick; the rest are local."},

    {convar = "mcv_tracer_color", label = "Tracer colour",
     help = "Everyone sees your rounds in the colour you choose here.",
     choices = {{"The gun's own", "0"}, {"Your player colour", "1"}, {"Your physgun colour", "2"}}},

    {convar = "mcv_hud_hints", label = "Control hints",
     help = "The line of controls shown when a weapon is drawn.",
     choices = {{"Off", "0"}, {"Every time a weapon is drawn", "1"}, {"The first time each weapon is drawn", "2"}}},
}

// which category the sliders below are showing, an index into MCV.Categories
local cv_category = CreateClientConVar("mcv_cat_menu", "1", true, false,
    "Q menu only: the weapon category whose stat multipliers the settings tab is showing")

// Which categories hold a weapon that launches something. The three projectile stats are
// shown for those only, so a pistol's page is not padded with dials that do nothing. Read off
// the weapons themselves rather than a list to keep, and the rifle grenades are always in.
local function launchingCategories()
    local out = {[MCV.CATEGORY_RIFLE_GRENADE] = true}

    for _, wep in ipairs(weapons.GetList()) do
        if !wep.SubCategory then continue end

        for _, key in ipairs({"ShootEntity", "ThrowEntity", "ThrownEntity", "PlacedEntityClass", "RifleGrenadeEntity"}) do
            if isstring(wep[key]) and wep[key] != "" then
                out[wep.SubCategory] = true
                break
            end
        end
    end

    return out
end

local function categoryBlock(panel, rebuild)
    panel:Help("Category stats")
    panel:ControlHelp("A multiplier per weapon category, shared by everyone on the server. " ..
        "1 is the stat as the game has it. Pick a category, then set its stats below.")

    local idx = math.Clamp(cv_category:GetInt(), 1, #MCV.Categories)
    local category = MCV.Categories[idx]

    local combo = panel:ComboBox("Category")
    for i, name in ipairs(MCV.Categories) do
        combo:AddChoice(name, i)
    end
    combo:SetValue(category)

    combo.OnSelect = function(_, _, _, data)
        cv_category:SetInt(data)

        // out of the callback before the controls it is running from are thrown away
        timer.Simple(0, function()
            if IsValid(panel) then rebuild(panel) end
        end)
    end

    local launches = launchingCategories()[category]

    for _, stat in ipairs(MCV.CategoryStats) do
        if stat.projectile and !launches then continue end

        panel:NumSlider(stat.label, MCV.CategoryConVarName(category, stat.key), 0, 3, 2)
        panel:ControlHelp(stat.help)
    end

    local reset = panel:Button("Reset " .. category)
    reset.DoClick = function()
        for _, stat in ipairs(MCV.CategoryStats) do
            RunConsoleCommand(MCV.CategoryConVarName(category, stat.key), "1")
        end

        timer.Simple(0, function()
            if IsValid(panel) then rebuild(panel) end
        end)
    end
end

local build

build = function(panel)
    panel:ClearControls()

    for _, s in ipairs(SETTINGS) do
        if s.section then
            panel:Help(s.section)

            if s.help then panel:ControlHelp(s.help) end

            continue
        end

        local cv = GetConVar(s.convar)
        if !cv then continue end

        if s.choices then
            local combo = panel:ComboBox(s.label, s.convar)
            local now = cv:GetString()

            for _, c in ipairs(s.choices) do
                combo:AddChoice(c[1], c[2])

                // show what is set without firing the selection back at the convar
                if c[2] == now then combo:SetValue(c[1]) end
            end
        else
            panel:CheckBox(s.label, s.convar)
        end

        if s.help then panel:ControlHelp(s.help) end
    end

    categoryBlock(panel, build)
end

hook.Add("PopulateToolMenu", "MCV_Settings", function()
    spawnmenu.AddToolMenuOption("Options", "Military Conflict: Vietnam", "mcv_settings",
        "Settings", "", "", build)
end)

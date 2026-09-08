// The Q menu tabs: Options > Military Conflict: Vietnam > Server and > Client.
//
// Two pages, because the two kinds of convar answer to different people. The server ones are
// replicated and shared by everyone playing, so on someone else's server they are the host's to
// set and a client changing them is ignored. The client ones are that player's own and reach
// nobody else, with the one exception noted on the tracer colour.
//
// Adding a convar is one entry in SERVER_SETTINGS or CLIENT_SETTINGS and nothing else. A
// `section` entry starts a heading; an entry with `choices` is a dropdown, one with `slider` a
// number, anything else a checkbox. See CLAUDE.md.

MCV = MCV or {}

local SERVER_SETTINGS = {
    {convar = "mcv_realistic_shooting", label = "Realistic shooting",
     help = "Alternate weapon handling schema inspired by Modern Warfare 4"},

    {convar = "mcv_surface_impacts", label = "The game's bullet impacts",
     help = "Use the game's bullet impact particles"},

    {convar = "mcv_sound_foley_self", label = "Hear your own third-person foley",
     help = "The set the people around you hear, played to you as well. Off unless you want to hear it without a second player"},
}

local CLIENT_SETTINGS = {
    {convar = "mcv_tracer_color", label = "Tracer colour",
     help = "Other players see this too",
     choices = {{"Default", "0"}, {"Player colour", "1"}, {"Weapon colour", "2"}}},

    {convar = "mcv_hud_hints", label = "Control hints",
     help = "Show control hints",
     choices = {{"Off", "0"}, {"Always", "1"}, {"First Draw", "2"}}},

    {section = "Effects",},

    {convar = "mcv_muzzle_light", label = "Muzzle flash light",
     choices = {{"Lamp with shadows", "2"}, {"Simple light", "1"}, {"Off", "0"}}},

    {convar = "mcv_shell_smoke", label = "Shell smoke trail"},

    {convar = "mcv_shell_time", label = "Shells stay for", slider = {0, 60, 1}},
}

// which category the sliders below are showing, an index into MCV.Categories
local cv_category = CreateClientConVar("mcv_cat_menu", "1", true, false,
    "Q menu only: the weapon category whose stat multipliers the settings tab is showing")

// Which categories hold a weapon that launches something. The three projectile stats are
// shown for those only, so a pistol's page is not padded with dials that do nothing. Read off
// the weapons themselves rather than a list to keep, and the rifle grenades are always in.
local function launchingCategories()
    local out = {[MCV.CATEGORY_RIFLE_GRENADE] = true, [MCV.CATEGORY_ALL] = true}

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
        if stat.help then
            panel:ControlHelp(stat.help)
        end
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

local function controls(panel, settings)
    for _, s in ipairs(settings) do
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
        elseif s.slider then
            panel:NumSlider(s.label, s.convar, s.slider[1], s.slider[2], s.slider[3] or 2)
        else
            panel:CheckBox(s.label, s.convar)
        end

        if s.help then panel:ControlHelp(s.help) end
    end
end

local buildServer

buildServer = function(panel)
    panel:ClearControls()

    controls(panel, SERVER_SETTINGS)
    categoryBlock(panel, buildServer)
end

local function buildClient(panel)
    panel:ClearControls()

    controls(panel, CLIENT_SETTINGS)
end

hook.Add("PopulateToolMenu", "MCV_Settings", function()
    spawnmenu.AddToolMenuOption("Options", "Military Conflict: Vietnam", "mcv_settings_server",
        "Server", "", "", buildServer)

    spawnmenu.AddToolMenuOption("Options", "Military Conflict: Vietnam", "mcv_settings_client",
        "Client", "", "", buildClient)
end)

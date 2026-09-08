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
     help = "The addon's own recoil and spread: the bullet leaves the barrel where it points, so hip fire misses because the gun is not lined up with your eye rather than through a cone. Off is the game's own numbers."},

    {convar = "mcv_surface_impacts", label = "The game's bullet impacts",
     help = "Impact effects per surface as the game has them. Off falls back to the engine's."},
}

local CLIENT_SETTINGS = {
    {convar = "mcv_tracer_color", label = "Tracer colour",
     help = "The one setting here other people see: everyone watching sees your rounds in the colour you choose.",
     choices = {{"The gun's own", "0"}, {"Your player colour", "1"}, {"Your physgun colour", "2"}}},

    {convar = "mcv_hud_hints", label = "Control hints",
     help = "The line of controls shown when a weapon is drawn.",
     choices = {{"Off", "0"}, {"Every time a weapon is drawn", "1"}, {"The first time each weapon is drawn", "2"}}},

    {section = "Effects",
     help = "What you see of gunfire, yours and everyone else's. Turning these down costs nobody else anything."},

    {convar = "mcv_muzzle_light", label = "Muzzle flash light",
     help = "What a muzzle flash lights up around it. The projected light casts shadows and is the expensive one; the dynamic light is the engine's cheap glow.",
     choices = {{"Full, with shadows", "2"}, {"Dynamic light", "1"}, {"Off", "0"}}},

    {convar = "mcv_shell_smoke", label = "Shell smoke trail",
     help = "The smoke trailing a hot case out of the gun. The puff at the ejection port stays either way."},

    {convar = "mcv_shell_time", label = "Shells stay for", slider = {0, 60, 1},
     help = "How long an ejected case lies where it landed before fading out, in seconds. The count starts once it stops rolling."},
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
    panel:ControlHelp("A multiplier per weapon category, shared by everyone on the server. " ..
        "1 is the stat as the game has it. Pick a category, then set its stats below. " ..
        "All reaches every weapon and multiplies with whatever its own category is set to.")

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
    panel:Help("Shared by everyone on the server. On a server other than your own these are " ..
        "the host's to set, and changing them here does nothing.")

    controls(panel, SERVER_SETTINGS)
    categoryBlock(panel, buildServer)
end

local function buildClient(panel)
    panel:ClearControls()
    panel:Help("Yours alone, saved on this machine.")

    controls(panel, CLIENT_SETTINGS)
end

hook.Add("PopulateToolMenu", "MCV_Settings", function()
    spawnmenu.AddToolMenuOption("Options", "Military Conflict: Vietnam", "mcv_settings_server",
        "Server", "", "", buildServer)

    spawnmenu.AddToolMenuOption("Options", "Military Conflict: Vietnam", "mcv_settings_client",
        "Client", "", "", buildClient)
end)

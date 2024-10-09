
local sizes_to_make = {
    8
}

local function generatefonts()
    local font = "consolas"

    for _, i in pairs(sizes_to_make) do

        surface.CreateFont( "MCV_" .. tostring(i), {
            font = font,
            size = ScreenScale(i),
            weight = i < 16 and 650 or 600,
            antialias = true,
            additive = true,
            extended = true, -- Required for non-latin fonts
        } )

    end
end

surface.CreateFont( "MCV_HudSelectionTitle", {
    font = "Verdana",
    size = 20,
    weight = 700,
    antialias = true,
    extended = true, -- Required for non-latin fonts
})

surface.CreateFont( "MCV_HudSelectionDesc", {
    font = "Verdana",
    size = 14,
    weight = 700,
    antialias = true,
    extended = true, -- Required for non-latin fonts
})



generatefonts()

function MCV.Regen()
    generatefonts()
end

concommand.Add("MCV_font_reload", MCV.Regen)

hook.Add("OnScreenSizeChanged", "MCV.FontRegen", function(oldWidth, oldHeight)
    print("Warning: Resolution was changed. If MCV fonts are too small/big now, try type  MCV_font_reload  in console ")
    timer.Simple(5, MCV.Regen)
end)
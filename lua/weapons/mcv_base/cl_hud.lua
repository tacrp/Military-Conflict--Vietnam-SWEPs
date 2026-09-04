function SWEP:ScaleFOVByWidthRatio( fovDegrees, ratio )
    local halfAngleRadians = fovDegrees * ( 0.5 * math.pi / 180 )
    local t = math.tan( halfAngleRadians )
    t = t * ratio
    local retDegrees = ( 180 / math.pi ) * math.atan( t )
    return retDegrees * 2
end

function SWEP:WidescreenFix(target)
    return self:ScaleFOVByWidthRatio(target, ((ScrW and ScrW() or 4) / (ScrH and ScrH() or 3)) / (4 / 3))
end

local function drawshadowrect(x, y, w, h, col)
    surface.SetDrawColor(col)
    surface.DrawRect(x, y, w, h)
    surface.SetDrawColor(0, 0, 0, col.a * 100 / 150)
    surface.DrawOutlinedRect(x - 1, y - 1, w + 2, h + 2)
end

local cv_developer = GetConVar("developer")
local crosshair_col = Color(255, 255, 255, 100)
local crosshair_shadow = Color(0, 0, 0, 0)
local white = Color(255, 255, 255, 255)

SWEP.TrueFOV = 90

function SWEP:TranslateFOV(fov)
    self.TrueFOV = fov

    return fov
end

function SWEP:DoDrawCrosshair(x, y)
    local a = (1 - self:GetSightAmountVisual()) * 100
    local col = crosshair_col
    col.a = a

    local dot_size = ScreenScale(1)
    local line_size = ScreenScale(4)

    local trueFOV = self:WidescreenFix(self.TrueFOV)

    local gap_size = (ScrH() / trueFOV) * self.Spread

    drawshadowrect(x - (dot_size / 2), y - (dot_size / 2), dot_size, dot_size, col)

    if self.Num > 1 then
        local shadow = crosshair_shadow
        shadow.a = a * 100 / 150

        surface.DrawCircle(x, y, gap_size, col)
        surface.DrawCircle(x, y, gap_size - 1, col)
        surface.DrawCircle(x, y, gap_size + 1, shadow)
        surface.DrawCircle(x, y, gap_size - 2, shadow)
    else
        drawshadowrect(x - (dot_size / 2), y - (dot_size / 2) + gap_size, dot_size, line_size, col)

        drawshadowrect(x - (dot_size / 2), y - (dot_size / 2) - gap_size - line_size, dot_size, line_size, col)

        drawshadowrect(x + gap_size, y - (dot_size / 2), line_size, dot_size, col)
        drawshadowrect(x - gap_size - line_size, y - (dot_size / 2), line_size, dot_size, col)
    end

    if cv_developer:GetBool() then
        drawshadowrect(x - (dot_size / 2), y - (dot_size / 2), dot_size, dot_size, white)

        local vm = self:GetOwner():GetViewModel()
        surface.SetFont("TargetID")

        local txt = "CYCLE: " .. math.Round(vm:GetCycle(), 2)
        local tw = surface.GetTextSize(txt)
        surface.SetTextPos(x - (tw / 2), y + 100)
        surface.SetTextColor(col)
        surface.DrawText(txt)

        local txt2 = vm:GetSequenceActivityName(vm:GetSequence())
        local tw2 = surface.GetTextSize(txt2)
        surface.SetTextPos(x - (tw2 / 2), y + 100 + 16)
        surface.SetTextColor(col)
        surface.DrawText(txt2)

        local tr = self:GetOwner():GetEyeTrace()
        local dist = (tr.HitPos - self:GetOwner():EyePos()):Length()
        local txt3 = "RANGE MULT: " .. math.Round(math.pow(self.RangeModifier, math.max(dist / 500, 0)), 3)
        local tw3 = surface.GetTextSize(txt3)
        surface.SetTextPos(x - (tw3 / 2), y + 100 + 16 * 2)
        surface.SetTextColor(col)
        surface.DrawText(txt3)
    end

    return true
end

local shoulddraw = {
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true,
}

function SWEP:HUDShouldDraw(element)
    if shoulddraw[element] then return false end
end

local oeg_mat = Material("sprites/redglow1")
local hud_col = Color(255, 255, 255, 150)

function SWEP:DrawHUD()
    if self.OEGScope and self:GetSightAmountVisual() > 0.6 then
        surface.SetMaterial(oeg_mat)
        surface.SetDrawColor(255, 255, 255, 255)
        local s = ScreenScale(16)
        surface.DrawTexturedRect((ScrW() - s) / 2, (ScrH() - s) / 2, s, s)
    end

    local firemode_name = MCV.FiremodeNames[self:GetFiremodeValue()]
    local ammocount = self:Clip1()
    local reserve = self:Ammo1()

    if self:GetGrenadeLauncher() then
        firemode_name = "Launcher"
        ammocount = self:Clip2()
        reserve = self:Ammo2()
    end

    local col = hud_col

    surface.SetFont("MCV_8")
    local tw = surface.GetTextSize(firemode_name)
    surface.SetTextPos(ScrW() - tw - ScreenScale(16), ScrH() - ScreenScale(48))
    surface.SetTextColor(col)
    surface.DrawText(firemode_name)

    surface.SetFont("MCV_24")
    local tw3 = surface.GetTextSize(ammocount)
    surface.SetTextPos(ScrW() - tw3 - ScreenScale(12 + 32), ScrH() - ScreenScale(40))
    surface.SetTextColor(col)
    surface.DrawText(ammocount)

    surface.SetFont("MCV_14")
    local tw4 = surface.GetTextSize(reserve)
    surface.SetTextPos(ScrW() - ScreenScale(12 + 22), ScrH() - ScreenScale(32))
    surface.SetTextColor(col)
    surface.DrawText(reserve)
end

local function boxes(f)
    local str = ""
    local boxc = math.Round(f * 10)
    for i = 1, 10 do
        if i <= boxc then
            str = str .. "■"
        else
            str = str .. "□"
        end
    end
    return str
end

SWEP.InfoMarkup = nil
function SWEP:PrintWeaponInfo(x, y, alpha)
    if self.DrawWeaponInfoBox == false then return end

    // Built once per weapon instance; markup.Parse every frame is expensive.
    if self.InfoMarkup == nil then
        local str
        local title_color = "<color=230,230,230,255>"
        local text_color = "<color=150,150,150,255>"
        str = ""

        str = str .. "<font=ACX_HudSelectionTitle>" .. title_color .. self.PrintName .. "</color></font>\n"

        if self.Country ~= "" then
            str = str .. "<font=MCV_HudSelectionDesc>" .. text_color .. self.Country .. "</color></font>\n"
        end

        str = str .. "\n<font=HudSelectionText>"

        if self.AmmoPerShot > 0 then
            str = str .. title_color .. "Ammo:</color>\t" .. text_color .. language.GetPhrase(self.Primary.Ammo .. "_ammo") .. "</color>\n"
        end

        str = str .. title_color .. "Damage:</color>\t" .. text_color .. self.DamageGeneric .. (self.Num > 1 and ("x" .. self.Num) or "") .. "</color>\n"

        str = str .. title_color .. "Fire Rate:</color>\t" .. text_color .. self.FireRate .. " RPM</color>\n"

        if self.Primary.ClipSize > 0 then
            local bonus = self.Primary.Chamber or 0
            str = str .. title_color .. "Capacity:</color>\t" .. text_color .. self.Primary.ClipSize .. (bonus > 0 and " (+" .. bonus .. ")" or "") .. "</color>\n"
        end

        local range = math.floor(-346.571 / math.log(self.RangeModifier))

        str = str .. title_color .. "Range:</color>\t" .. text_color
        str = str .. boxes(Lerp(range / 10000, 0, 1)) .. "</color>\n"

        if self.Caliber ~= "" then
            str = str .. title_color .. "Caliber:</color>\t" .. text_color .. self.Caliber .. "</color>\n"
        end

        local d
        if self.SpreadIronsighted == self.Spread then
            str = str .. title_color .. "Spread:</color>\t" .. text_color
            d = Lerp(math.log(1 + (self.Spread) / 3), 0, 1)
        else
            str = str .. title_color .. "Accuracy:</color>\t" .. text_color
            d = Lerp(math.log(1 + (self.SpreadIronsighted + self.Spread) / 15), 1, 0)
        end
        str = str .. boxes(d) .. "</color>\n"

        local recoil = ((self.ViewSlideRecoilUp + self.ViewSlideRecoilIronsightUp) / 2) + (self.ViewSlideRecoilRight + self.ViewSlideRecoilIronsightRight)

        str = str .. title_color .. "Recoil:</color>\t\t" .. text_color
        str = str .. boxes(Lerp(recoil * 0.5, 0, 1)) .. "</color>\n"

        str = str .. "</font>"
        self.InfoMarkup = markup.Parse(str, 250)
    end

    surface.SetDrawColor(60, 60, 60, alpha)
    surface.SetTexture(self.SpeechBubbleLid)
    surface.DrawTexturedRect(x, y - 64 - 5, 128, 64)
    draw.RoundedBox(8, x - 5, y - 6, 260, self.InfoMarkup:GetHeight() + 18, Color(60, 60, 60, alpha))
    self.InfoMarkup:Draw(x + 5, y + 5, nil, nil, alpha)
end

SWEP.Mat_Select = nil

function SWEP:DrawWeaponSelection(x, y, w, h, a)
    if !self.Mat_Select then
        self.Mat_Select = Material(self.IconOverride or  "entities/" .. self:GetClass() .. ".png", "smooth mips")

    end

    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(self.Mat_Select)
    if self.IconOverride then
        w = w - 128
        x = x + 64
    end
    if w > h then
        y = y - ((w - h) / 2)
    end

    surface.DrawTexturedRect(x, y, w, w)
end
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

function SWEP:DoDrawCrosshair(x, y)
    return false
end

function SWEP:DrawHUD()
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

    self.InfoMarkup = nil
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
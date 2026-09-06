// HUD for every MCV weapon: crosshair, the ammo block bottom right with the weapon's icon
// behind it, control hints that fade out after a deploy, and in / out animations on switching.
//
// Realms: Deploy and Holster do not run on the client in singleplayer, so nothing here relies
// on them. A deploy is detected by DrawHUD being called for a weapon that was not drawn the
// frame before; a holster by the networked HolsterTime running (mcv_base_core/sh_deploy.lua).

MCV.HUD = MCV.HUD or {}
local HUD = MCV.HUD

HUD.Color = Color(255, 255, 255, 150)
HUD.ColorBright = Color(255, 255, 255, 230)
HUD.ColorDim = Color(255, 255, 255, 140)
HUD.ColorIcon = Color(255, 255, 255, 70) // the spawn icon, mirrored to face left, behind the counter
HUD.InTime = 0.35 // seconds the elements take to slide in
HUD.OutTimeDefault = 0.3
HUD.SlideDistance = 24 // ScreenScale units the elements travel while animating
HUD.HintDuration = 6 // seconds the hints stay before fading
HUD.HintFade = 1
HUD.HintStagger = 0.06 // extra delay per hint line

local cv_hints = CreateClientConVar("mcv_hud_hints", "1", true, false, "Control hints on deploy: 0 off, 1 every deploy, 2 first deploy of each weapon")

local function ease(p)
    p = math.Clamp(p, 0, 1)
    return 1 - (1 - p) * (1 - p) * (1 - p) // ease out cubic
end

// ---------------------------------------------------------------------------------------
// Key names
// ---------------------------------------------------------------------------------------

local key_labels = {
    ["mouse1"] = "LMB", ["mouse2"] = "RMB", ["mouse3"] = "MMB",
    ["shift"] = "SHIFT", ["alt"] = "ALT", ["ctrl"] = "CTRL", ["space"] = "SPACE",
}

// "+use" -> "E", "+use +attack" -> "E + LMB"; "hold:+attack" -> "Hold LMB"
function HUD.KeyLabel(spec)
    local hold = false
    if string.sub(spec, 1, 5) == "hold:" then
        hold = true
        spec = string.sub(spec, 6)
    end
    local parts = {}
    for bind in string.gmatch(spec, "%S+") do
        local key = input.LookupBinding(bind, true) or input.LookupBinding(bind) or bind
        key = string.lower(key)
        table.insert(parts, key_labels[key] or string.upper(key))
    end
    local s = table.concat(parts, " + ")
    if hold then s = "Hold " .. s end
    return s
end

// ---------------------------------------------------------------------------------------
// Per-weapon animation state (client side, this weapon instance only)
// ---------------------------------------------------------------------------------------

// 0..1 how far the HUD is "in". Combines the deploy slide-in with the holster slide-out.
function SWEP:GetHUDBlend()
    local now = CurTime()
    local frame = FrameNumber()

    // deploy: first frame this weapon is drawn again
    if self.HUDLastFrame == nil or frame - self.HUDLastFrame > 2 then
        self.HUDDeployTime = now
        self.HUDHolsterStart = nil
        self.HUDHintsStart = now
        self.HUDHintsShown = (self.HUDHintsShown or 0) + 1
        HUD.DeployCount = HUD.DeployCount or {}
        HUD.DeployCount[self:GetClass()] = (HUD.DeployCount[self:GetClass()] or 0) + 1
    end
    self.HUDLastFrame = frame

    local blend = ease((now - (self.HUDDeployTime or now)) / HUD.InTime)

    // holster: HolsterTime is CurTime() + animation length while the holster animation plays
    local ht = self:GetHolsterTime()
    if ht > now then
        if !self.HUDHolsterStart then
            self.HUDHolsterStart = now
            self.HUDHolsterLen = math.max(ht - now, 0.05)
        end
        local out = ease((now - self.HUDHolsterStart) / math.min(self.HUDHolsterLen, HUD.OutTimeDefault * 2))
        blend = blend * (1 - out)
    elseif ht < 0 then
        blend = 0 // switch handed over, gone
    else
        self.HUDHolsterStart = nil
    end

    return blend
end

// ---------------------------------------------------------------------------------------
// Elements
// ---------------------------------------------------------------------------------------

local function textRight(font, text, right, y, col)
    surface.SetFont(font)
    local tw, th = surface.GetTextSize(text)
    surface.SetTextPos(right - tw, y)
    surface.SetTextColor(col)
    surface.DrawText(text)
    return tw, th
end

local function withAlpha(col, mult)
    return Color(col.r, col.g, col.b, col.a * mult)
end

function SWEP:GetHUDIcon()
    if self.Mat_HUDIcon == nil then
        local path = self.IconOverride or ("entities/" .. self:GetClass() .. ".png")
        if file.Exists("materials/" .. path, "GAME") then
            self.Mat_HUDIcon = Material(path, "smooth")
        else
            self.Mat_HUDIcon = false
        end
    end
    return self.Mat_HUDIcon or nil
end

// A weapon icon mirrored (the game's icons face right) and turned so it faces up-left
local function drawIconTilted(mat, cx, cy, size, col)
    local c, s = math.cos(math.rad(45)), math.sin(math.rad(45))
    local h = size / 2
    local corners = {{-h, -h, 1, 0}, {h, -h, 0, 0}, {h, h, 0, 1}, {-h, h, 1, 1}} // u runs 1 -> 0: mirrored
    local poly = {}
    for i, p in ipairs(corners) do
        poly[i] = {x = cx + p[1] * c - p[2] * s, y = cy + p[1] * s + p[2] * c, u = p[3], v = p[4]}
    end
    surface.SetMaterial(mat)
    surface.SetDrawColor(col)
    surface.DrawPoly(poly)
end

// Icons under the ammo counter for what this gun could do right now: dual wield (its own icon,
// once a second one has been picked up) and a bayonet (the carried bayonet's icon)
function SWEP:DrawHUDAvailability(blend, right, y)
    local icons = {}
    if self.HasAkimbo and self.GetHasSecond and self:GetHasSecond() then
        // two of them, one a little behind the other: a pair of pistols
        icons[#icons + 1] = {self:GetHUDIcon(), self:GetAkimbo(), true}
    end
    if self.HasBayonet and self.OwnerHasBayonet and self:OwnerHasBayonet() then
        local owner = self:GetOwner()
        for _, w in ipairs(owner:GetWeapons()) do
            if w.IsBayonet and w.GetHUDIcon then
                icons[#icons + 1] = {w:GetHUDIcon(), self:GetBayonet()}
                break
            end
        end
    end
    local size = ScreenScale(14)
    local x = right - size / 2
    for _, ic in ipairs(icons) do
        if ic[1] then
            // dimmer once it is in use, bright while it is on offer
            local col = withAlpha(HUD.Color, blend * (ic[2] and 0.45 or 1))
            if ic[3] then
                local off = size * 0.22
                drawIconTilted(ic[1], x - off, y - off, size, withAlpha(HUD.Color, blend * (ic[2] and 0.3 or 0.6)))
                drawIconTilted(ic[1], x + off, y + off, size, col)
                x = x - off * 2
            else
                drawIconTilted(ic[1], x, y, size, col)
            end
        end
        x = x - size - ScreenScale(2)
    end
end

// The ammo block: firemode label, big count, reserve, icon behind it all
function SWEP:DrawHUDAmmo(blend)
    local sw, sh = ScrW(), ScrH()
    local slide = HUD.SlideDistance * ScreenScale(1) * (1 - blend)
    local right = sw - ScreenScale(16) + slide

    local firemode_name = self:GetFiremodeName() or ""
    local ammocount, reserve = self:GetHUDAmmo()

    // icon: the spawn icon has its glyph in the middle 256x128 band of a 256x256 image, so
    // a 128 wide box shows the whole band with no dead space
    local icon = self:GetHUDIcon()
    if icon then
        local w = ScreenScale(72)
        local h = w
        local cx = right - ScreenScale(36)
        local cy = sh - ScreenScale(30)
        surface.SetMaterial(icon)
        surface.SetDrawColor(withAlpha(HUD.ColorIcon, blend))
        // the game's icons all point right; mirrored so the muzzle faces the screen centre
        surface.DrawTexturedRectUV(cx - w / 2, cy - h / 2, w, h, 1, 0, 0, 1)
    end

    if firemode_name != "" then
        textRight("MCV_8", firemode_name, right, sh - ScreenScale(48), withAlpha(HUD.Color, blend))
    end

    self:DrawHUDAvailability(blend, right, sh - ScreenScale(10))

    if ammocount == nil then return end

    textRight("MCV_24", tostring(ammocount), right - ScreenScale(28), sh - ScreenScale(40), withAlpha(HUD.Color, blend))

    if reserve == nil then return end

    textRight("MCV_14", tostring(reserve), right + ScreenScale(4), sh - ScreenScale(32), withAlpha(HUD.Color, blend))
end

// Control hints: lines of "KEY  what it does", above the ammo block, fading after a while
function SWEP:DrawHUDHints(blend)
    local mode = cv_hints:GetInt()
    if mode <= 0 then return end
    if mode >= 2 and (HUD.DeployCount[self:GetClass()] or 1) > 1 then return end

    local hints = self:GetControlHints()
    if !hints or #hints == 0 then return end

    local now = CurTime()
    local age = now - (self.HUDHintsStart or now)
    local life = 1 - math.Clamp((age - HUD.HintDuration) / HUD.HintFade, 0, 1)
    if life <= 0 then return end

    local sw, sh = ScrW(), ScrH()
    local right = sw - ScreenScale(16)
    local y = sh - ScreenScale(58)
    local lh = ScreenScale(9)

    // width of the widest key column so the actions line up
    surface.SetFont("MCV_8")
    local keyw = 0
    local labels = {}
    for i, h in ipairs(hints) do
        labels[i] = HUD.KeyLabel(h[1])
        keyw = math.max(keyw, (surface.GetTextSize(labels[i])))
    end
    local gap = ScreenScale(6)

    for i = #hints, 1, -1 do
        local h = hints[i]
        // each line slides in slightly after the one below it
        local p = ease((age - (#hints - i) * HUD.HintStagger) / HUD.InTime) * blend * life
        if p > 0 then
            local slide = HUD.SlideDistance * ScreenScale(1) * (1 - p)
            local ly = y - (#hints - i) * lh
            textRight("MCV_8", h[2], right + slide, ly, withAlpha(HUD.ColorDim, p))
            surface.SetFont("MCV_8")
            local aw = surface.GetTextSize(h[2])
            local kx = right + slide - aw - gap
            surface.SetTextPos(kx - keyw + (keyw - surface.GetTextSize(labels[i])), ly)
            surface.SetTextColor(withAlpha(HUD.ColorBright, p))
            surface.DrawText(labels[i])
        end
    end
end

// Default hints; every base overrides with its own controls (see GetControlHints in each base)
function SWEP:GetControlHints()
    return {
        {"+attack", "Fire"},
        {"+use +attack", "Bash"},
    }
end

function SWEP:DrawHUD()
    local blend = self:GetHUDBlend()

    self:DrawHUDExtra()

    if blend <= 0 then return end

    self:DrawHUDAmmo(blend)
    self:DrawHUDHints(blend)
end

// ---------------------------------------------------------------------------------------
// Crosshair
// ---------------------------------------------------------------------------------------

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

// Crosshair gap follows the weapon's live spread (stance, movement, air, aim), kicks open on
// each shot and settles back, and the whole thing bobs with the walk cycle. Purely visual: the
// spread itself is what GetSpread returns, this only shows it.
HUD.CrosshairSmooth = 12 // how fast the gap follows the target (per second)
HUD.CrosshairKick = 1.6 // extra gap right after a shot, in units of the base spread
HUD.CrosshairKickTime = 0.35
HUD.CrosshairBob = 2.5 // ScreenScale units of sway at a full sprint

function SWEP:GetCrosshairSpread()
    if self.GetSpread then
        return self:GetSpread() * 100
    end
    return self.Spread or 0
end

function SWEP:DoDrawCrosshair(x, y)
    local blend = self:GetHUDBlend()
    local a = (1 - self:GetSightAmountVisual()) * 100 * blend
    if a <= 0 then return true end

    local col = crosshair_col
    col.a = a

    // The crosshair follows the view punch (twice it, as the shot does) but not the hip sway:
    // it stays put and grows by the sway's peak instead, so the shot always lands inside it
    if self.GetAimSway and MCV.RealisticShooting() then
        local owner = self:GetOwner()
        if IsValid(owner) then
            local aim = owner:EyeAngles() + owner:GetViewPunchAngles() * 2
            local scr = (owner:EyePos() + aim:Forward() * 4096):ToScreen()
            if scr.visible and scr.x == scr.x then
                x, y = scr.x, scr.y
            end
        end
    end

    local dot_size = ScreenScale(1)
    local line_size = ScreenScale(4)

    local trueFOV = self:WidescreenFix(self.TrueFOV)
    local scale = ScrH() / trueFOV

    // target gap from the live spread, plus a kick that decays after each shot
    local spread = self:GetCrosshairSpread()
    local since = CurTime() - self:GetLastRecoilTime()
    local kick = math.Clamp(1 - since / HUD.CrosshairKickTime, 0, 1)
    kick = kick * kick
    // the hip sway's peak (degrees, both axes: 1.2 covers the diagonal) widens the gap so the
    // wandering barrel stays inside the crosshair
    local sway = self.GetAimSwayAmplitude and self:GetAimSwayAmplitude(true) * 1.2 or 0
    local target = scale * (spread + sway + math.max(self.Spread or 0, 0.5) * HUD.CrosshairKick * kick)

    local ft = FrameTime()
    if self.CrossGap == nil then self.CrossGap = target end
    // opens instantly, closes smoothly
    if target > self.CrossGap then
        self.CrossGap = Lerp(math.min(ft * HUD.CrosshairSmooth * 3, 1), self.CrossGap, target)
    else
        self.CrossGap = Lerp(math.min(ft * HUD.CrosshairSmooth, 1), self.CrossGap, target)
    end
    local gap_size = math.max(self.CrossGap, dot_size)

    // walk bob: a figure of eight scaled by how fast the player moves
    local speed = self:GetSpeedVisual() / math.max(self.SpeedSprint, 1)
    local owner = self:GetOwner()
    if IsValid(owner) and !owner:IsOnGround() then speed = 0 end
    self.CrossBobPhase = (self.CrossBobPhase or 0) + ft * (6 + speed * 6) * math.min(speed * 3, 1)
    local bob = HUD.CrosshairBob * ScreenScale(1) * speed
    x = x + math.sin(self.CrossBobPhase) * bob
    y = y + math.abs(math.cos(self.CrossBobPhase)) * bob * 0.6

    drawshadowrect(x - (dot_size / 2), y - (dot_size / 2), dot_size, dot_size, col)

    // a grenade being cooked: a ring pulses out every half second, reddening as the fuse runs down
    if self.GetCookPulse then
        local p, frac = self:GetCookPulse()
        if p then
            local r = gap_size + ScreenScale(2) + p * ScreenScale(10)
            local pc = Color(255, 255 - 200 * frac, 60, math.min(a * (1 - p) * 2.5, 255))
            surface.DrawCircle(x, y, r, pc)
            surface.DrawCircle(x, y, r + 1, pc)
            surface.DrawCircle(x, y, r + 2, pc)
        end
    end

    if self.Num > 1 then
        local shadow = crosshair_shadow
        shadow.a = a * 100 / 150

        surface.DrawCircle(x, y, gap_size, col)
        surface.DrawCircle(x, y, gap_size - 1, col)
        surface.DrawCircle(x, y, gap_size + 1, shadow)
        surface.DrawCircle(x, y, gap_size - 2, shadow)
    elseif (self.Spread or 0) > 0 then
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

        local txt2 = vm:GetSequenceActivityName(vm:GetSequence()) .. " / " .. vm:GetSequenceName(vm:GetSequence())
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

// ---------------------------------------------------------------------------------------
// Weapon selection
// ---------------------------------------------------------------------------------------

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

        str = str .. "<font=MCV_HudSelectionTitle>" .. title_color .. self.PrintName .. "</color></font>\n"

        if self.Country ~= "" then
            str = str .. "<font=MCV_HudSelectionDesc>" .. text_color .. self.Country .. "</color></font>\n"
        end

        str = str .. "\n<font=HudSelectionText>"

        if self.AmmoPerShot > 0 and self.Primary.Ammo and self.Primary.Ammo != "none" then
            str = str .. title_color .. "Ammo:</color>\t" .. text_color .. language.GetPhrase(self.Primary.Ammo .. "_ammo") .. "</color>\n"
        end

        if (self.DamageGeneric or 0) > 0 then
            str = str .. title_color .. "Damage:</color>\t" .. text_color .. self.DamageGeneric .. (self.Num > 1 and ("x" .. self.Num) or "") .. "</color>\n"
        end

        if (self.FireRate or 0) > 0 then
            str = str .. title_color .. "Fire Rate:</color>\t" .. text_color .. self.FireRate .. " RPM</color>\n"
        end

        if self.Primary.ClipSize > 0 then
            local bonus = self.Primary.Chamber or 0
            str = str .. title_color .. "Capacity:</color>\t" .. text_color .. self.Primary.ClipSize .. (bonus > 0 and " (+" .. bonus .. ")" or "") .. "</color>\n"
        end

        if (self.FireRate or 0) > 0 then
            local range = math.floor(-346.571 / math.log(self.RangeModifier))

            str = str .. title_color .. "Range:</color>\t" .. text_color
            str = str .. boxes(Lerp(range / 10000, 0, 1)) .. "</color>\n"
        end

        if self.Caliber ~= "" then
            str = str .. title_color .. "Caliber:</color>\t" .. text_color .. self.Caliber .. "</color>\n"
        end

        if (self.FireRate or 0) > 0 then
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
        end

        // the same controls the HUD hints show
        local hints = self:GetControlHints()
        if hints and #hints > 0 then
            str = str .. "\n"
            for _, h in ipairs(hints) do
                str = str .. title_color .. HUD.KeyLabel(h[1]) .. "</color>\t" .. text_color .. h[2] .. "</color>\n"
            end
        end

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

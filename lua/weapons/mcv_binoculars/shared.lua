// Binoculars: right click looks through them (the sight blend of the gun base), USE + reload
// steps the magnification. Nothing to fire.

SWEP.Base = "mcv_base"
SWEP.Spawnable = false

SWEP.SubCategory = "Equipment"
SWEP.Slot = 4

SWEP.HoldType = "slam"
SWEP.SprintHoldType = "normal"
SWEP.AimHoldType = "slam"

SWEP.Ironsight = true
SWEP.IronsightSpeedScale = 0.7
SWEP.ZoomLevels = {4, 8}
SWEP.SightedViewModelFOV = 60

SWEP.HasScope = false
SWEP.Firemodes = {MCV.FIREMODE_SEMI}
SWEP.FireRate = 0
SWEP.DamageGeneric = 0
SWEP.Spread = 0
SWEP.SpreadIronsighted = 0
SWEP.DrawCrosshair = false

SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false

SWEP.SequenceFiremode = "firemode"

AddCSLuaFile()

function SWEP:GetPrecacheParticles() return {} end
function SWEP:GetHUDAmmo() return nil, nil end
function SWEP:GetFiremodeName() return string.format("%dx", self:GetZoomMagnification()) end

function SWEP:GetZoomMagnification()
    local lvl = math.Clamp(self:GetScopeLevel(), 1, #self.ZoomLevels)
    return self.ZoomLevels[lvl]
end

function SWEP:PrimaryAttack()
    local owner = self:GetOwner()
    if owner:KeyDown(IN_USE) and !self:StillWaiting() then
        self:Bash()
        self:SetNextPrimaryFire(CurTime() + 0.6)
    end
end

function SWEP:Reload()
    local owner = self:GetOwner()
    if !owner:KeyPressed(IN_RELOAD) then return end
    if self:StillWaiting() then return end

    local lvl = self:GetScopeLevel() + 1
    if lvl > #self.ZoomLevels then lvl = 1 end
    self:SetScopeLevel(lvl)

    if !self:GetIronsight() and self:HasSequence(self.SequenceFiremode) then
        self:PlaySequence(self.SequenceFiremode, 1, true)
    else
        self:EmitSound("MCV_Weapon_Foley_AK47.DrawMetal")
        self:SetAnimLockTime(CurTime() + 0.2)
    end
end

function SWEP:ThinkWeapon()
    self:Think_Sights()
end

function SWEP:ToggleUBGL() end
function SWEP:ToggleBayonet() end

function SWEP:GetControlHints()
    return {
        {"+attack2", "Look"},
        {"+use +reload", "Magnification"},
        {"+use +attack", "Bash"},
    }
end

// Looking through them: the model would sit in front of the camera, so it fades out and a
// binocular mask takes its place.
function SWEP:PreDrawViewModelBlend(vm, sa)
    if sa > 0.3 then
        render.SetBlend(math.Clamp(1 - (sa - 0.3) / 0.3, 0, 1))
    end
end

if CLIENT then
    local mask_col = Color(0, 0, 0, 255)

    function SWEP:DrawHUDExtra()
        local a = self:GetSightAmountVisual()
        if a < 0.5 then return end
        local alpha = math.Clamp((a - 0.5) / 0.3, 0, 1) * 255
        local w, h = ScrW(), ScrH()
        local r = h * 0.46
        local cx1, cx2, cy = w / 2 - r * 0.55, w / 2 + r * 0.55, h / 2
        mask_col.a = alpha

        // stencil: keep the two eyepieces clear, paint everything else black
        render.ClearStencil()
        render.SetStencilEnable(true)
        render.SetStencilWriteMask(255)
        render.SetStencilTestMask(255)
        render.SetStencilReferenceValue(1)
        render.SetStencilCompareFunction(STENCIL_ALWAYS)
        render.SetStencilPassOperation(STENCIL_REPLACE)
        render.SetStencilFailOperation(STENCIL_KEEP)
        render.SetStencilZFailOperation(STENCIL_KEEP)
        surface.SetDrawColor(255, 255, 255, 1)
        draw.NoTexture()
        for _, cx in ipairs({cx1, cx2}) do
            local poly = {}
            for i = 0, 47 do
                local ang = math.rad(i / 48 * 360)
                poly[#poly + 1] = {x = cx + math.cos(ang) * r, y = cy + math.sin(ang) * r}
            end
            surface.DrawPoly(poly)
        end
        render.SetStencilCompareFunction(STENCIL_NOTEQUAL)
        render.SetStencilPassOperation(STENCIL_KEEP)
        surface.SetDrawColor(mask_col)
        surface.DrawRect(0, 0, w, h)
        render.SetStencilEnable(false)
    end
end

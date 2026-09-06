// Third person: the game's world models are rigged to ValveBiped.weapon_bone for the game's own
// player rig, and on GMod's players they sit tilted. The engine's placement (the weapon entity at
// the right hand attachment) is the base; the model is drawn by hand as a clientside model at
// that place turned up by WorldModelTilt and moved by WorldModelOffset, so the muzzle and the
// shell port are where the drawn gun is (effects attach to these models, not the entity).
// Dual wield draws a second copy on the left hand attachment ("duel" hold type).

SWEP.WorldModelTilt = 7.5                                    // degrees, muzzle up
SWEP.WorldModelOffset = {pos = Vector(0, 0, 0), ang = Angle(0, 0, 0)}       // right hand, on top of the tilt
SWEP.WorldModelOffsetLeft = {pos = Vector(0, 0, 0), ang = Angle(0, 0, 0)}   // left hand (dual wield), on top of the mirrored placement

local cv_tilt = CreateClientConVar("mcv_wm_tilt", "", false, false, "Overrides every weapon's WorldModelTilt (degrees, empty = per weapon)")
local cv_left_ang = CreateClientConVar("mcv_wm_left_ang", "", false, false, "Overrides WorldModelOffsetLeft.ang: 'p y r' (empty = per weapon)")
local cv_left_pos = CreateClientConVar("mcv_wm_left_pos", "", false, false, "Overrides WorldModelOffsetLeft.pos: 'x y z' (empty = per weapon)")

local function readTriple(cv, ctor)
    local s = cv:GetString()
    if s == "" then return nil end
    local a, b, c = s:match("^%s*([-%d.]+)%s+([-%d.]+)%s+([-%d.]+)")
    if !a then return nil end
    return ctor(tonumber(a), tonumber(b), tonumber(c))
end

function SWEP:GetWorldModelTilt()
    local s = cv_tilt:GetString()
    if s != "" and tonumber(s) then return tonumber(s) end
    return self.WorldModelTilt or 0
end

// Where the right-hand gun is drawn: the entity's own place (the player's right hand
// attachment), tilted and offset.
function SWEP:GetWorldModelTransform()
    local pos, ang = self:GetPos(), self:GetAngles()
    ang:RotateAroundAxis(ang:Right(), -self:GetWorldModelTilt())
    local off = self.WorldModelOffset
    if off then
        pos, ang = LocalToWorld(off.pos or vector_origin, off.ang or angle_zero, pos, ang)
    end
    return pos, ang
end

// The left-hand gun: the player's left hand attachment, the same tilt, mirrored across the
// hand (the left hand's attachment is the right one's mirror image), then the left offset.
function SWEP:GetWorldModelTransformLeft()
    local owner = self:GetOwner()
    if !IsValid(owner) then return nil end
    local id = owner:LookupAttachment("anim_attachment_LH")
    local att = id > 0 and owner:GetAttachment(id)
    if !att then return nil end
    local pos, ang = att.Pos, att.Ang
    ang:RotateAroundAxis(ang:Right(), -self:GetWorldModelTilt())
    local offpos = readTriple(cv_left_pos, Vector) or (self.WorldModelOffsetLeft and self.WorldModelOffsetLeft.pos) or vector_origin
    local offang = readTriple(cv_left_ang, Angle) or (self.WorldModelOffsetLeft and self.WorldModelOffsetLeft.ang) or angle_zero
    pos, ang = LocalToWorld(offpos, offang, pos, ang)
    return pos, ang
end

function SWEP:GetWorldModelEntity(left)
    local key = left and "WMLeft" or "WM"
    local mdl = self[key]
    if IsValid(mdl) and mdl:GetModel() == self.WorldModel then return mdl end
    if IsValid(mdl) then mdl:Remove() end
    if !self.WorldModel or self.WorldModel == "" or !util.IsValidModel(self.WorldModel) then return nil end
    mdl = ClientsideModel(self.WorldModel, RENDERGROUP_OPAQUE)
    if !IsValid(mdl) then return nil end
    mdl:SetNoDraw(true)
    self[key] = mdl
    return mdl
end

function SWEP:RemoveWorldModels()
    for _, key in ipairs({"WM", "WMLeft"}) do
        if IsValid(self[key]) then self[key]:Remove() end
        self[key] = nil
    end
end

local function drawAt(self, mdl, pos, ang)
    mdl:SetPos(pos)
    mdl:SetAngles(ang)
    mdl:SetSkin(self:GetSkin())
    for i = 0, self:GetNumBodyGroups() - 1 do
        mdl:SetBodygroup(i, self:GetBodygroup(i))
    end
    mdl:SetupBones()
    mdl:DrawModel()
end

function SWEP:DrawWorldModel(flags)
    local owner = self:GetOwner()
    if !IsValid(owner) then
        // on the ground: the entity as it is
        self:RemoveWorldModels()
        self:DrawModel()
        return
    end
    local right = self:GetWorldModelEntity(false)
    if !right then
        self:DrawModel()
        return
    end
    drawAt(self, right, self:GetWorldModelTransform())
    if self.GetAkimbo and self:GetAkimbo() then
        local left = self:GetWorldModelEntity(true)
        local pos, ang = self:GetWorldModelTransformLeft()
        if left and pos then drawAt(self, left, pos, ang) end
    elseif IsValid(self.WMLeft) then
        self.WMLeft:Remove()
        self.WMLeft = nil
    end
end

// The model the third person effects attach to (right or left gun), and its attachment
function SWEP:GetWorldModelFor(left)
    local mdl = left and self.WMLeft or self.WM
    if IsValid(mdl) then return mdl end
    return self
end

function SWEP:OnRemove()
    if CLIENT then self:RemoveWorldModels() end
end

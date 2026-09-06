// Third person. The game's world models are rigged to ValveBiped.weapon_bone, the bone GMod's
// players carry in the right hand, and the engine places a held weapon by merging its bones onto
// the player's (EF_BONEMERGE). That merge is kept: the weapon draws a clientside copy of its
// world model merged onto the owner, and the difference between the game's player rig and
// GMod's is taken out on the player's weapon_bone itself (one adjustment for every gun, since
// every world model shares the rig convention), plus a per-weapon WorldModelOffset on top.
// Effects attach to the drawn copy, so the muzzle and the shell port are where the gun is.
// A dual draws a second copy on the left hand bone with WorldModelOffsetLeft ("duel" hold type).

// the player's weapon_bone adjustment, shared by every gun (degrees, units, in the bone's frame)
SWEP.WorldModelBoneAng = Angle(0, 0, 0)
SWEP.WorldModelBonePos = Vector(0, 0, 0)
// on top of that, per weapon (the bone's frame as well)
SWEP.WorldModelOffset = {pos = Vector(0, 0, 0), ang = Angle(0, 0, 0)}
// the left-hand copy of a dual: relative to ValveBiped.Bip01_L_Hand
SWEP.WorldModelOffsetLeft = {pos = Vector(0, 0, 0), ang = Angle(0, 0, 0)}

// live tuning: "p y r" / "x y z"; empty means the lua values
local cv_ang = CreateClientConVar("mcv_wm_ang", "", false, false, "Overrides the weapon_bone angle adjustment for every gun: 'p y r'")
local cv_pos = CreateClientConVar("mcv_wm_pos", "", false, false, "Overrides the weapon_bone position adjustment for every gun: 'x y z'")
local cv_left_ang = CreateClientConVar("mcv_wm_left_ang", "", false, false, "Overrides WorldModelOffsetLeft.ang: 'p y r'")
local cv_left_pos = CreateClientConVar("mcv_wm_left_pos", "", false, false, "Overrides WorldModelOffsetLeft.pos: 'x y z'")

local function readTriple(cv, ctor)
    local s = cv:GetString()
    if s == "" then return nil end
    local a, b, c = s:match("^%s*([-%d.]+)%s+([-%d.]+)%s+([-%d.]+)")
    if !a then return nil end
    return ctor(tonumber(a), tonumber(b), tonumber(c))
end

function SWEP:GetWorldModelBoneAdjust()
    local ang = readTriple(cv_ang, Angle) or self.WorldModelBoneAng or angle_zero
    local pos = readTriple(cv_pos, Vector) or self.WorldModelBonePos or vector_origin
    local off = self.WorldModelOffset
    if off then
        pos = pos + (off.pos or vector_origin)
        ang = ang + (off.ang or angle_zero)
    end
    return pos, ang
end

// The player's weapon_bone carries the adjustment while an MCV weapon is out; put back when
// something else is (the engine's own weapon models would inherit it otherwise)
local BONE = "ValveBiped.weapon_bone"

local function adjustOwnerBone(owner, pos, ang)
    local id = owner:LookupBone(BONE)
    if !id then return false end
    if owner.MCVBoneAdjusted != true or owner.MCVBonePos != pos or owner.MCVBoneAng != ang then
        owner:ManipulateBonePosition(id, pos)
        owner:ManipulateBoneAngles(id, ang)
        owner.MCVBoneAdjusted, owner.MCVBonePos, owner.MCVBoneAng = true, pos, ang
    end
    return true
end

local function restoreOwnerBone(owner)
    if !owner.MCVBoneAdjusted then return end
    local id = owner:LookupBone(BONE)
    if id then
        owner:ManipulateBonePosition(id, vector_origin)
        owner:ManipulateBoneAngles(id, angle_zero)
    end
    owner.MCVBoneAdjusted = false
end

hook.Add("Think", "MCV_WorldModelBoneRestore", function()
    for _, ply in ipairs(player.GetAll()) do
        if ply.MCVBoneAdjusted then
            local wep = ply:GetActiveWeapon()
            if !IsValid(wep) or !wep.MilitaryConflictVietnam then restoreOwnerBone(ply) end
        end
    end
end)

function SWEP:GetWorldModelEntity(left)
    local key = left and "WMLeft" or "WM"
    local mdl = self[key]
    if IsValid(mdl) and mdl:GetModel() == self.WorldModel and mdl.MCVOwner == self:GetOwner() then return mdl end
    if IsValid(mdl) then mdl:Remove() end
    if !self.WorldModel or self.WorldModel == "" or !util.IsValidModel(self.WorldModel) then return nil end
    mdl = ClientsideModel(self.WorldModel, RENDERGROUP_OPAQUE)
    if !IsValid(mdl) then return nil end
    mdl:SetNoDraw(true)
    mdl.MCVOwner = self:GetOwner()
    if !left then
        // the engine's own placement: bones merged onto the owner's
        mdl:SetParent(self:GetOwner())
        mdl:AddEffects(EF_BONEMERGE)
    end
    self[key] = mdl
    return mdl
end

function SWEP:RemoveWorldModels()
    for _, key in ipairs({"WM", "WMLeft"}) do
        if IsValid(self[key]) then self[key]:Remove() end
        self[key] = nil
    end
end

local function copyLook(self, mdl)
    mdl:SetSkin(self:GetSkin())
    for i = 0, self:GetNumBodyGroups() - 1 do
        mdl:SetBodygroup(i, self:GetBodygroup(i))
    end
end

// The left-hand gun of a dual: the left hand bone, mirrored placement, then the left offset
function SWEP:GetWorldModelTransformLeft()
    local owner = self:GetOwner()
    local id = owner:LookupBone("ValveBiped.Bip01_L_Hand")
    local m = id and owner:GetBoneMatrix(id)
    if !m then return nil end
    local pos, ang = m:GetTranslation(), m:GetAngles()
    local offpos = readTriple(cv_left_pos, Vector) or (self.WorldModelOffsetLeft and self.WorldModelOffsetLeft.pos) or vector_origin
    local offang = readTriple(cv_left_ang, Angle) or (self.WorldModelOffsetLeft and self.WorldModelOffsetLeft.ang) or angle_zero
    return LocalToWorld(offpos, offang, pos, ang)
end

function SWEP:DrawWorldModel(flags)
    local owner = self:GetOwner()
    if !IsValid(owner) or !(owner:IsPlayer() or owner:IsNPC()) then
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
    adjustOwnerBone(owner, self:GetWorldModelBoneAdjust())
    copyLook(self, right)
    right:SetupBones()
    right:DrawModel()

    if self.GetAkimbo and self:GetAkimbo() then
        local left = self:GetWorldModelEntity(true)
        local pos, ang = self:GetWorldModelTransformLeft()
        if left and pos then
            left:SetPos(pos)
            left:SetAngles(ang)
            copyLook(self, left)
            left:SetupBones()
            left:DrawModel()
        end
    elseif IsValid(self.WMLeft) then
        self.WMLeft:Remove()
        self.WMLeft = nil
    end
end

// The model the third person effects attach to (right or left gun)
function SWEP:GetWorldModelFor(left)
    local mdl = left and self.WMLeft or self.WM
    if IsValid(mdl) then return mdl end
    return self
end

function SWEP:OnRemove()
    if CLIENT then self:RemoveWorldModels() end
end

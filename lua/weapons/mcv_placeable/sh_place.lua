local STATE_IDLE = 0
local STATE_WINDUP = 1
local STATE_BUSY = 2
local STATE_STAKE = 3 // mine placed, waiting for the stake

function SWEP:GetFiremodeName()
    if self.PlaceKind == "mine" and self:GetActionState() == STATE_STAKE then return "Place stake" end
    if self.PlaceKind == "c4" and self:CountPlanted() > 0 then return "Right click: detonate" end
    return ""
end

function SWEP:GetHUDAmmo()
    return self:GetRoundsLeft(), nil
end

// The blank option of a bodygroup is its last one (the mine model: m16m, vc, blank / stick, blank)
local function blank_of(ent, group)
    return math.max(ent:GetBodygroupCount(group) - 1, 0)
end

// The piece's angle on a surface: model up along the normal, facing the way the player looks,
// then the weapon's PlacedAngleOffset (pitch, yaw, roll in the piece's own frame). The stake
// faces the mine its wire runs to instead and takes StakeAngleOffset; the stake mesh has its
// point at the top, so the default rolls it over and StakeRaise lifts it out of the ground.
function SWEP:PlaceAngle(normal, base_yaw, offset)
    local ang = normal:Angle()
    ang:RotateAroundAxis(ang:Right(), -90)
    ang:RotateAroundAxis(ang:Up(), base_yaw or self:GetOwner():EyeAngles().y)
    offset = offset or self.PlacedAngleOffset
    if offset then
        ang:RotateAroundAxis(ang:Up(), offset.y)
        ang:RotateAroundAxis(ang:Right(), offset.p)
        ang:RotateAroundAxis(ang:Forward(), offset.r)
    end
    return ang
end

// Where the piece would go: a surface within reach in front of the player, else the floor.
function SWEP:PlacementTrace()
    local owner = self:GetOwner()
    local src = owner:GetShootPos()
    local dir = self:GetAimVector()

    local tr = util.TraceLine({start = src, endpos = src + dir * self.PlaceRange, filter = owner, mask = MASK_SOLID})
    if !tr.Hit then
        // drop to the ground in front of the player
        local ahead = src + dir * self.PlaceRange * 0.75
        tr = util.TraceLine({start = ahead, endpos = ahead - Vector(0, 0, 96), filter = owner, mask = MASK_SOLID})
    end
    return tr
end

function SWEP:CanPlaceAt(tr)
    if !tr.Hit then return false end
    if self.PlaceKind == "mine" then
        if tr.HitNormal.z < 0.7 then return false end // mines go on the ground
        if self:GetActionState() == STATE_STAKE then
            local mine = self:GetPlacedEntity()
            if !IsValid(mine) then return false end
            local d = (tr.HitPos - mine:GetPos()):Length()
            if d < 24 or d > self.WireLength then return false end
            // the wire must not pass through walls
            local wtr = util.TraceLine({start = mine:GetPos() + Vector(0, 0, 6), endpos = tr.HitPos + Vector(0, 0, 6), mask = MASK_SOLID_BRUSHONLY})
            if wtr.Hit then return false end
        end
    else
        if IsValid(tr.Entity) and (tr.Entity:IsPlayer() or tr.Entity:IsNPC()) then return false end
    end
    return true
end

function SWEP:CountPlanted()
    local owner = self:GetOwner()
    local n = 0
    for _, ent in ipairs(ents.FindByClass(self.PlacedEntityClass)) do
        if ent:GetOwner() == owner and ent.RemoteFuse and !ent.Detonated then n = n + 1 end
    end
    return n
end

// ---------------------------------------------------------------------------------------
// Planting
// ---------------------------------------------------------------------------------------

function SWEP:Plant()
    local tr = self:PlacementTrace()
    if !self:CanPlaceAt(tr) then return false end

    local seq = self.SequencePlant
    if self.PlaceKind == "mine" then
        seq = self:GetActionState() == STATE_STAKE and self.SequencePlaceStick or self.SequencePlaceMine
    end

    local stake = self.PlaceKind == "mine" and self:GetActionState() == STATE_STAKE
    self:SetActionState(STATE_BUSY)
    local t = self:HasSequence(seq) and self:PlaySequence(seq, 1, true) or 0.8
    self:SetNextPrimaryFire(CurTime() + t)
    self:GetOwner():DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM)

    local pos, normal = tr.HitPos, tr.HitNormal
    local parent = IsValid(tr.Entity) and !tr.Entity:IsWorld() and tr.Entity or nil

    self:SetTimer(math.min(self.PlaceDelay, t), function()
        if !IsValid(self) then return end
        if stake then
            self:SpawnStake(pos, normal)
        else
            self:SpawnPlaced(pos, normal, parent)
        end
    end, "mcv_place")

    self:SetTimer(t, function()
        if !IsValid(self) then return end
        if self.PlaceKind == "mine" and !stake then
            self:SetActionState(STATE_STAKE)
        else
            self:SetActionState(STATE_IDLE)
            self:CheckEmpty()
        end
    end, "mcv_place_end")

    return true
end

function SWEP:ConfigurePlaced(ent)
    ent.ExplosionDamage = self.ExplosionDamage
    ent.ExplosionRadius = self.ExplosionRadius
    ent.Attacker = self:GetOwner()
    ent.Inflictor = self
    ent.Model = self.PlacedModel or self.WorldModel
    if self.PlaceKind == "dynamite" then
        ent.Delay = self.FuseTime
    end
end

function SWEP:SpawnPlaced(pos, normal, parent)
    if self.PlaceKind != "mine" then
        self:TakeRound(1)
    end
    if CLIENT then return end

    local owner = self:GetOwner()
    local ent = ents.Create(self.PlacedEntityClass)
    if !IsValid(ent) then return end

    self:ConfigurePlaced(ent)
    ent:SetPos(pos + normal * 0.5)
    ent:SetAngles(self:PlaceAngle(normal))
    ent:SetOwner(owner)
    ent:Spawn()
    ent:Activate()
    ent:PlantOn(parent)

    if self.PlaceKind == "mine" then
        ent.MineBodygroups = self.MineBodygroups
        ent:SetBodygroup(self.MineBodygroups.stick, blank_of(ent, self.MineBodygroups.stick))
        self:SetPlacedEntity(ent)
    end
end

function SWEP:SpawnStake(pos, normal)
    self:TakeRound(1)
    if CLIENT then return end

    local mine = self:GetPlacedEntity()
    if !IsValid(mine) then return end

    local stake = ents.Create(self.StakeEntityClass)
    if !IsValid(stake) then return end
    stake.Model = self.StakeModel or self.WorldModel
    stake.MineBodygroups = self.MineBodygroups
    stake:SetPos(pos + normal * self.StakeRaise)
    stake:SetAngles(self:PlaceAngle(normal, (mine:GetPos() - pos):Angle().y, self.StakeAngleOffset))
    stake:SetOwner(self:GetOwner())
    stake:Spawn()
    stake:Activate()

    mine:SetStakeEntity(stake)
    self:SetPlacedEntity(NULL)
end

// Dynamite can be thrown lit instead of planted
function SWEP:Windup()
    self:SetActionState(STATE_WINDUP)
    if self:HasSequence(self.SequenceWindup) then
        self:PlaySequence(self.SequenceWindup, 1, false, true)
    end
end

function SWEP:ThrowLit()
    self:SetActionState(STATE_BUSY)
    local t = self:HasSequence(self.SequenceThrow) and self:PlaySequence(self.SequenceThrow, 1, true) or 0.5
    self:SetNextPrimaryFire(CurTime() + t)
    self:GetOwner():DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE)

    self:SetTimer(math.min(0.2, t), function()
        if !IsValid(self) then return end
        self:TakeRound(1)
        if CLIENT then return end
        local owner = self:GetOwner()
        local ang = self:GetAimAngle()
        local ent = ents.Create(self.PlacedEntityClass)
        if !IsValid(ent) then return end
        self:ConfigurePlaced(ent)
        ent.Thrown = true
        ent:SetPos(owner:GetShootPos() + ang:Forward() * 12)
        ent:SetAngles(ang)
        ent:SetOwner(owner)
        ent:Spawn()
        ent:Activate()
        ent:Light()
        local phys = ent:GetPhysicsObject()
        if IsValid(phys) then
            phys:SetVelocityInstantaneous((ang:Forward() + ang:Up() * 0.15):GetNormalized() * self.ThrowForce + owner:GetVelocity())
            phys:AddAngleVelocity(VectorRand() * 300)
        end
    end, "mcv_place")

    self:SetTimer(t, function()
        if !IsValid(self) then return end
        self:SetActionState(STATE_IDLE)
        self:CheckEmpty()
    end, "mcv_place_end")
end

function SWEP:Detonate()
    if CLIENT then return end
    local owner = self:GetOwner()
    local any = false
    for _, ent in ipairs(ents.FindByClass(self.PlacedEntityClass)) do
        if ent:GetOwner() == owner and ent.RemoteFuse and !ent.Detonated then
            ent:RemoteDetonate()
            any = true
        end
    end
    if any then
        self:EmitSound("buttons/button17.wav", 60)
    end
end

function SWEP:CheckEmpty()
    if self:GetRoundsLeft() > 0 or !self.RemoveWhenEmpty or CLIENT then return end
    // the C4 stays as the detonator until every charge has gone off
    if self.PlaceKind == "c4" and self:CountPlanted() > 0 then return end

    local owner = self:GetOwner()
    if !IsValid(owner) then return end
    local class = self:GetClass()
    timer.Simple(0, function()
        if !IsValid(owner) then return end
        owner:StripWeapon(class)
        local other = owner:GetWeapons()[1]
        if IsValid(other) then owner:SelectWeapon(other:GetClass()) end
    end)
end

// ---------------------------------------------------------------------------------------
// Input
// ---------------------------------------------------------------------------------------

function SWEP:ThinkWeapon()
    local owner = self:GetOwner()
    local state = self:GetActionState()

    if state == STATE_WINDUP and !owner:KeyDown(IN_ATTACK) then
        self:ThrowLit()
    end

    // detonate check for C4 that is out of charges
    if self.PlaceKind == "c4" and state == STATE_IDLE and self:GetRoundsLeft() <= 0 and self:CountPlanted() == 0 then
        self:CheckEmpty()
    end

    // the mine step is lost if its half disappears
    if state == STATE_STAKE and !IsValid(self:GetPlacedEntity()) then
        self:SetActionState(STATE_IDLE)
    end
end

function SWEP:PrimaryAttack()
    if self:StillWaiting() then return end
    local owner = self:GetOwner()
    local state = self:GetActionState()

    if owner:KeyDown(IN_USE) then
        if state == STATE_IDLE then
            self:Bash()
            self:SetNextPrimaryFire(CurTime() + 0.6)
        end
        return
    end

    if state == STATE_STAKE then
        if !self:Plant() then self:SetNextPrimaryFire(CurTime() + 0.2) end
        return
    end

    if state != STATE_IDLE then return end
    if self:GetRoundsLeft() <= 0 then return end

    if !self:Plant() then
        if self.PlaceKind == "dynamite" and self:HasSequence(self.SequenceWindup) then
            self:Windup()
        else
            self:SetNextPrimaryFire(CurTime() + 0.2)
        end
    end
end

function SWEP:SecondaryAttack()
    if self:StillWaiting() then return end
    local owner = self:GetOwner()
    if !owner:KeyPressed(IN_ATTACK2) then return end

    if self.PlaceKind == "c4" then
        self:Detonate()
        self:SetNextSecondaryFire(CurTime() + 0.5)
    elseif self.PlaceKind == "dynamite" and self:GetActionState() == STATE_IDLE and self:GetRoundsLeft() > 0 then
        if self:HasSequence(self.SequenceWindup) then self:Windup() else self:ThrowLit() end
    end
end

function SWEP:Reload()
end

function SWEP:OnDeploy()
    if self:GetActionState() != STATE_STAKE then
        self:SetActionState(STATE_IDLE)
    end
end

// ---------------------------------------------------------------------------------------
// Ghost preview (client)
// ---------------------------------------------------------------------------------------

if CLIENT then
    local ghost_col = Color(120, 255, 120, 110)
    local bad_col = Color(255, 90, 90, 110)

    function SWEP:GetGhostModel()
        if self:GetActionState() == STATE_STAKE then
            return self.StakeModel or self.WorldModel
        end
        return self.PlacedModel or self.WorldModel
    end

    function SWEP:DrawGhost()
        local owner = self:GetOwner()
        if owner != LocalPlayer() or owner:GetActiveWeapon() != self then return end
        local state = self:GetActionState()
        if state != STATE_IDLE and state != STATE_STAKE then return end
        if self:GetRoundsLeft() <= 0 and state != STATE_STAKE then return end

        local tr = self:PlacementTrace()
        if !tr.Hit then return end
        local ok = self:CanPlaceAt(tr)

        local model = self:GetGhostModel()
        if !IsValid(self.Ghost) or self.GhostModel != model then
            if IsValid(self.Ghost) then self.Ghost:Remove() end
            self.Ghost = ClientsideModel(model, RENDERGROUP_TRANSLUCENT)
            self.Ghost:SetNoDraw(true)
            self.GhostModel = model
        end

        local ang = self:PlaceAngle(tr.HitNormal)
        local raise = 0.5
        if state == STATE_STAKE then
            local mine = self:GetPlacedEntity()
            raise = self.StakeRaise
            ang = self:PlaceAngle(tr.HitNormal, IsValid(mine) and (mine:GetPos() - tr.HitPos):Angle().y or nil, self.StakeAngleOffset)
            if self.MineBodygroups then
                self.Ghost:SetBodygroup(self.MineBodygroups.mine, blank_of(self.Ghost, self.MineBodygroups.mine))
                self.Ghost:SetBodygroup(self.MineBodygroups.stick, 0)
            end
        elseif self.PlaceKind == "mine" and self.MineBodygroups then
            self.Ghost:SetBodygroup(self.MineBodygroups.mine, 0)
            self.Ghost:SetBodygroup(self.MineBodygroups.stick, blank_of(self.Ghost, self.MineBodygroups.stick))
        end

        self.Ghost:SetPos(tr.HitPos + tr.HitNormal * raise)
        self.Ghost:SetAngles(ang)

        local col = ok and ghost_col or bad_col
        render.SetColorModulation(col.r / 255, col.g / 255, col.b / 255)
        render.SetBlend(col.a / 255)
        self.Ghost:DrawModel()
        render.SetBlend(1)
        render.SetColorModulation(1, 1, 1)

        // the wire the stake would give
        if state == STATE_STAKE then
            local mine = self:GetPlacedEntity()
            if IsValid(mine) then
                render.SetMaterial(Material("cable/rope"))
                render.DrawBeam(mine:GetPos() + Vector(0, 0, 4), tr.HitPos + tr.HitNormal * self.StakeRaise, 0.6, 0, 1, col)
            end
        end
    end

    hook.Add("PostDrawTranslucentRenderables", "MCV_PlaceableGhost", function(depth, sky)
        if sky or depth then return end
        local ply = LocalPlayer()
        if !IsValid(ply) then return end
        local wep = ply:GetActiveWeapon()
        if IsValid(wep) and wep.PlaceKind and wep.DrawGhost then
            wep:DrawGhost()
        end
    end)

    function SWEP:OnRemove()
        if IsValid(self.Ghost) then self.Ghost:Remove() end
    end
end

function SWEP:GetControlHints()
    if self.PlaceKind == "mine" then
        return {
            {"+attack", "Place mine, then the stake"},
            {"+use +attack", "Bash"},
        }
    elseif self.PlaceKind == "dynamite" then
        return {
            {"+attack", "Plant lit"},
            {"+attack2", "Throw lit"},
            {"+use +attack", "Bash"},
        }
    end
    return {
        {"+attack", "Plant"},
        {"+attack2", "Detonate"},
        {"+use +attack", "Bash"},
    }
end

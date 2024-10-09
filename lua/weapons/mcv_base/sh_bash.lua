function SWEP:Bash()
    local owner = self:GetOwner()

    self:PlayAnimation(ACT_VM_HITCENTER, 1, true)

    local dir = self:GetAimVector()

    local dim = 32
    local pos = owner:GetShootPos() - dir * (dim * 1.732)
    local tr = util.TraceHull({
        start = pos,
        endpos = pos + dir * self.BashRange,
        filter = {owner},
        mask = MASK_SHOT_HULL,
        mins = Vector(-dim, -dim, -dim),
        maxs = Vector(dim, dim, dim)
    })

    local dmginfo = DamageInfo()
    dmginfo:SetDamage(self.BashDamage)
    dmginfo:SetDamageForce(dir * self.BashDamage * 500)
    dmginfo:SetDamagePosition(tr.HitPos)
    dmginfo:SetDamageType(DMG_CLUB)
    if dmginfo:GetDamageType() == DMG_GENERIC and engine.ActiveGamemode() == "terrortown" then
        dmginfo:SetDamageType(DMG_CLUB) -- use CLUB so TTT can assign DNA (it does not leave DNA on generic damage)
    end

    dmginfo:SetAttacker(owner)
    dmginfo:SetInflictor(self)

    self:FireBullets({
        Attacker = self:GetOwner(),
        Damage = 0,
        Force = 0,
        Distance = self.BashRange + (dim * 1.5),
        HullSize = 0,
        Tracer = 0,
        Dir = (tr.HitPos - pos):GetNormalized(),
        Src = pos,
    })

    if IsValid(tr.Entity) then
        tr.Entity:TakeDamageInfo(dmginfo)
    end

    self:EmitSound("MCV_Weapon_Foley_Bash.Slow")

    if IsValid(tr.Entity) and (tr.Entity:IsNPC() or tr.Entity:IsPlayer() or tr.Entity:IsNextBot() or tr.Entity:IsRagdoll()) then
        self:EmitSound("MCV_Weapon_Fists.PowerPunch")
    else
        if tr.Hit then
            self:EmitSound("MCV_Weapon_Fists.PowerPunchWall")
        end
    end
end

function SWEP:ToggleBayonet()
    if !self.HasBayonet then return end

    if self:GetBayonet() then
        self:PlayAnimation(ACT_VM_DETACH_SILENCER, 1, true)
    else
        self:PlayAnimation(ACT_VM_ATTACH_SILENCER, 1, true)
    end

    self:SetBayonet(!self:GetBayonet())
end
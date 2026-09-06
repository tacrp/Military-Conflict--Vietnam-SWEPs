function SWEP:Bash()
    local owner = self:GetOwner()

    if self:GetBayonet() then
        self:PlayAnimation(ACT_VM_HITLEFT, 1, true)
    else
        self:PlayAnimation(ACT_VM_HITCENTER, 1, true)
    end

    local dir = self:GetAimVector()

    local dim = 32
    local pos = owner:GetShootPos() - dir * (dim * 1.732)
    local range = self.BashRange

    if self:GetBayonet() then
        range = self.BayonetRange
    end

    local tr = util.TraceHull({
        start = pos,
        endpos = pos + dir * range,
        filter = {owner},
        mask = MASK_SHOT_HULL,
        mins = Vector(-dim, -dim, -dim),
        maxs = Vector(dim, dim, dim)
    })

    local dmginfo = DamageInfo()
    if self:GetBayonet() then
        dmginfo:SetDamage(self.BayonetDamage)
        dmginfo:SetDamageForce(dir * self.BayonetDamage * 500)
        dmginfo:SetDamageType(DMG_CLUB)
    else
        dmginfo:SetDamage(self.BashDamage)
        dmginfo:SetDamageForce(dir * self.BashDamage * 500)
        dmginfo:SetDamageType(DMG_CLUB)
    end
    dmginfo:SetDamagePosition(tr.HitPos)
    if dmginfo:GetDamageType() == DMG_GENERIC and engine.ActiveGamemode() == "terrortown" then
        dmginfo:SetDamageType(DMG_CLUB) -- use CLUB so TTT can assign DNA (it does not leave DNA on generic damage)
    end

    dmginfo:SetAttacker(owner)
    dmginfo:SetInflictor(self)

    self:GetOwner():DoAnimationEvent(self.BashGesture)

    self:SetIronsight(false)

    self:FireBullets({
        Attacker = self:GetOwner(),
        Damage = 0,
        Force = 0,
        Distance = range + (dim * 1.5),
        HullSize = 0,
        Tracer = 0,
        Dir = (tr.HitPos - pos):GetNormalized(),
        Src = pos,
    })

    if IsValid(tr.Entity) then
        tr.Entity:TakeDamageInfo(dmginfo)
    end

    owner:ViewPunch(Angle(5, -5, 0))

    if IsValid(tr.Entity) and (tr.Entity:IsNPC() or tr.Entity:IsPlayer() or tr.Entity:IsNextBot() or tr.Entity:IsRagdoll()) then
        if self:GetBayonet() then
            self:EmitSound("MCV_Weapon_AK47_Bayonet.ThrustStab")
        else
            self:EmitSound("MCV_Weapon_Fists.PowerPunch")
        end
    else
        if tr.Hit then
            if self:GetBayonet() then
                self:EmitSound("MCV_Weapon_AK47_Bayonet.ThrustHit")
            else
                self:EmitSound("MCV_Weapon_Fists.PowerPunchWall")
            end
        end
    end
end

// The player has to carry a bayonet (one of the bayonet melee weapons, IsBayonet) to fix one
function SWEP:OwnerHasBayonet()
    local owner = self:GetOwner()
    if !IsValid(owner) or !owner.GetWeapons then return false end
    for _, w in ipairs(owner:GetWeapons()) do
        if w.IsBayonet then return true end
    end
    return false
end

// A fixed bayonet needs the bayonet still to be in the inventory: drop it, or lose it on a
// loadout change, and the one on the gun comes off. Silently, with no animation and no sound,
// because there is nothing in the player's hands to take it off with.
function SWEP:Think_Bayonet()
    if !self:GetBayonet() then return end
    if self:OwnerHasBayonet() then return end

    self:SetBayonet(false)
end

// The bayonet comes off at the end of the animation that takes it off
function SWEP:Deferred_BayonetOff()
    self:SetBayonet(false)
end

function SWEP:ToggleBayonet()
    if !self.HasBayonet then return end
    if self:StillWaiting() then return end
    if self:GetGrenadeLauncher() then return end
    if !self:GetBayonet() and !self:OwnerHasBayonet() then return end

    if self:GetBayonet() then
        local t = self:PlayAnimation(ACT_VM_DETACH_SILENCER, 1, true)
        self:Defer("BayonetOff", t)
    else
        self:PlayAnimation(ACT_VM_ATTACH_SILENCER, 1, true)
        self:SetBayonet(true)
    end
end
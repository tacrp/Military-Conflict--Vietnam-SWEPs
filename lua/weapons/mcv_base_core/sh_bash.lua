local BASH_HULL = 32

// The two swings the game animates for a fixed bayonet: a butt-stroke across and a slash back.
// Which one comes out is a coin toss, drawn from a seed both realms share so the viewmodel the
// player sees and the timing the server keeps agree on it.
SWEP.SequencesBayonetSwing = {"bash_bayonet", "slash_bayonet"}

function SWEP:BayonetSwing()
    local have = {}
    for _, s in ipairs(self.SequencesBayonetSwing) do
        if self:HasSequence(s) then table.insert(have, s) end
    end
    if #have == 0 then return nil end

    local i = math.floor(util.SharedRandom("mcv_bayonet_swing", 1, #have + 1, CurTime()))
    return have[math.Clamp(i, 1, #have)]
end

function SWEP:Bash()
    local bayonet = self:GetBayonet()

    if bayonet then
        local seq = self:BayonetSwing()
        if seq then
            self:PlaySequence(seq, 1, true)
        else
            self:PlayAnimation(ACT_VM_HITLEFT, 1, true)   // models with only the one swing
        end
    else
        self:PlayAnimation(ACT_VM_HITCENTER, 1, true)
    end

    self:GetOwner():DoAnimationEvent(self.BashGesture)
    self:SetIronsight(false)

    self:BashStrike(bayonet and self.BayonetRange or self.BashRange,
                    bayonet and self.BayonetDamage or self.BashDamage)
end

// Where a bash reaches. Its own function because the bayonet charge asks the same question
// every tick to decide whether it has run into someone yet.
function SWEP:BashTrace(range)
    local owner = self:GetOwner()
    local dir = self:GetAimVector()
    local pos = owner:GetShootPos() - dir * (BASH_HULL * 1.732)

    local tr = util.TraceHull({
        start = pos,
        endpos = pos + dir * range,
        filter = {owner},
        mask = MASK_SHOT_HULL,
        mins = Vector(-BASH_HULL, -BASH_HULL, -BASH_HULL),
        maxs = Vector(BASH_HULL, BASH_HULL, BASH_HULL)
    })

    return tr, pos, dir
end

// The damage and the impact of a bash, given its reach. Split from the swing so the bayonet
// charge lands the same hit with its own reach and its own damage.
function SWEP:BashStrike(range, damage, thrust)
    local owner = self:GetOwner()
    local tr, pos, dir = self:BashTrace(range)

    local dmginfo = DamageInfo()
    dmginfo:SetDamage(damage)
    dmginfo:SetDamageForce(dir * damage * 500)
    // a thrust runs the blade in, a swing knocks with it; either way not GENERIC, which TTT
    // leaves no DNA on
    dmginfo:SetDamageType(thrust and DMG_SLASH or DMG_CLUB)
    dmginfo:SetDamagePosition(tr.HitPos)
    dmginfo:SetAttacker(owner)
    dmginfo:SetInflictor(self)

    self:FireBullets({
        Attacker = owner,
        Damage = 0,
        Force = 0,
        Distance = range + (BASH_HULL * 1.5),
        HullSize = 0,
        Tracer = 0,
        Dir = (tr.HitPos - pos):GetNormalized(),
        Src = pos,
    })

    if IsValid(tr.Entity) then
        tr.Entity:TakeDamageInfo(dmginfo)
    end

    owner:ViewPunch(Angle(5, -5, 0))

    local bayonet = self:GetBayonet()
    local ent = tr.Entity

    if IsValid(ent) and (ent:IsNPC() or ent:IsPlayer() or ent:IsNextBot() or ent:IsRagdoll()) then
        self:EmitSound(bayonet and "MCV_Weapon_AK47_Bayonet.ThrustStab" or "MCV_Weapon_Fists.PowerPunch")
    elseif tr.Hit then
        self:EmitSound(bayonet and "MCV_Weapon_AK47_Bayonet.ThrustHit" or "MCV_Weapon_Fists.PowerPunchWall")
    end

    return tr
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
local STATE_IDLE = 0
local STATE_WINDUP_HIGH = 1
local STATE_WINDUP_LOW = 2
local STATE_THROWING = 3

function SWEP:GetFuseTime()
    local fm = math.Clamp(self:GetFiremode(), 1, #self.FuseModes)

    return self.FuseModes[fm]
end

function SWEP:GetFiremodeName()
    if self.FuseImpact then return "Impact" end
    if #self.FuseModes <= 1 then return "" end

    return string.format("Fuse %gs", self:GetFuseTime())
end

function SWEP:GetHUDAmmo()
    return self:GetRoundsLeft(), nil
end

function SWEP:CanStartThrow()
    if self:StillWaiting() then return false end
    if self:GetActionState() != STATE_IDLE then return false end
    if self:GetRoundsLeft() <= 0 then return false end

    return true
end

function SWEP:Windup(low)
    self:SetActionState(low and STATE_WINDUP_LOW or STATE_WINDUP_HIGH)
    self:SetActionStart(CurTime())

    local seq = low and self.SequenceWindupLow or self.SequenceWindupHigh
    if !self:HasSequence(seq) then seq = self.SequenceWindupHigh end

    // hold the last frame until the button is released
    self:PlaySequence(seq, 1, false, true)
end

function SWEP:Throw(low)
    local owner = self:GetOwner()
    local roll = low and owner:Crouching() and self:HasSequence(self.SequenceRoll)

    local seq = self.SequenceThrowHigh
    if low then
        seq = roll and self.SequenceRoll or self.SequenceThrowLow
        if !self:HasSequence(seq) then seq = self.SequenceThrowHigh end
    end

    self:SetActionState(STATE_THROWING)

    local t = self:PlaySequence(seq, 1, true) or 0.5
    local release = math.min(low and self.ThrowReleaseTimeUnderhand or self.ThrowReleaseTime, t)
    local kind = roll and "roll" or (low and "low" or "high")
    local fuse = self:GetFuseTime()

    owner:DoAnimationEvent(self.ShootGesture)

    self:SetTimer(release, function()
        if !IsValid(self) then return end
        self:LaunchThrowable(kind, fuse)
    end, "mcv_throw")

    self:SetTimer(t, function()
        if !IsValid(self) then return end
        self:SetActionState(STATE_IDLE)
        self:AfterThrow()
    end, "mcv_throw_end")

    self:SetNextPrimaryFire(CurTime() + t)
end

// Spawns the projectile. Runs from a predicted timer on both realms; only the server creates.
function SWEP:LaunchThrowable(kind, fuse)
    local owner = self:GetOwner()
    if !IsValid(owner) then return end

    self:TakeRound(1)

    if CLIENT then return end

    local ang = self:GetAimAngle()
    local fwd, right, up = ang:Forward(), ang:Right(), ang:Up()

    local pos = owner:GetShootPos() + fwd * 12 + right * 6
    local force = self.ThrowForceOverhand
    local dir = (fwd + up * 0.12):GetNormalized()

    if kind == "low" then
        pos = pos - up * 12
        force = self.ThrowForceUnderhand
        dir = (fwd + up * 0.25):GetNormalized()
    elseif kind == "roll" then
        pos = pos - up * 20
        force = self.ThrowForceRoll
        dir = (fwd - up * 0.15):GetNormalized()
    end

    // do not spawn inside a wall
    local tr = util.TraceLine({start = owner:GetShootPos(), endpos = pos, filter = owner, mask = MASK_SOLID})
    if tr.Hit then pos = tr.HitPos - fwd * 2 end

    local ent = ents.Create(self.ThrowEntity)
    if !IsValid(ent) then return end

    ent.Model = self.ThrowModel or self.WorldModel
    ent.Delay = fuse
    if self.FuseImpact then
        ent.ImpactFuse = true
        ent.ExplodeOnImpact = true
        ent.TimeFuse = false
    end
    ent.ExplosionDamage = self.ExplosionDamage
    ent.ExplosionRadius = self.ExplosionRadius
    ent.IgniteRadius = self.IgniteRadius
    ent.EffectDuration = self.EffectDuration
    ent.SmokeColor = self.SmokeColor
    ent.Attacker = owner
    ent.Inflictor = self

    ent:SetPos(pos)
    ent:SetAngles(ang)
    ent:SetOwner(owner)
    ent:Spawn()
    ent:Activate()

    local phys = ent:GetPhysicsObject()
    if IsValid(phys) then
        phys:SetVelocityInstantaneous(dir * force + owner:GetVelocity())
        phys:AddAngleVelocity(VectorRand() * self.ThrowSpin)
    end
end

function SWEP:AfterThrow()
    if self:GetRoundsLeft() > 0 or !self.RemoveWhenEmpty then return end
    if CLIENT then return end

    local owner = self:GetOwner()
    if !IsValid(owner) then return end

    // out of grenades: put it away and drop the weapon
    local class = self:GetClass()
    timer.Simple(0, function()
        if !IsValid(owner) then return end
        local wep = owner:GetWeapon(class)
        if !IsValid(wep) then return end
        owner:StripWeapon(class)
        owner:SelectWeapon(owner:GetWeapons()[1] and owner:GetWeapons()[1]:GetClass() or "")
    end)
end

function SWEP:ChangeFuseMode()
    if #self.FuseModes <= 1 then return end
    if self:StillWaiting() or self:GetActionState() != STATE_IDLE then return end

    local fm = self:GetFiremode() + 1
    if fm > #self.FuseModes then fm = 1 end
    self:SetFiremode(fm)

    if self:HasSequence(self.SequenceFiremode) then
        self:PlaySequence(self.SequenceFiremode, 1, true)
    else
        self:SetAnimLockTime(CurTime() + 0.25)
    end
end

function SWEP:ThinkWeapon()
    local owner = self:GetOwner()
    local state = self:GetActionState()

    if state == STATE_IDLE then
        if owner:KeyDown(IN_USE) then return end

        if owner:KeyPressed(IN_ATTACK) and self:CanStartThrow() then
            self:Windup(false)
        elseif owner:KeyPressed(IN_ATTACK2) and self:CanStartThrow() then
            self:Windup(self.HasUnderhand and self:HasSequence(self.SequenceWindupLow))
        end
    elseif state == STATE_WINDUP_HIGH then
        if !owner:KeyDown(IN_ATTACK) then
            self:Throw(false)
        end
    elseif state == STATE_WINDUP_LOW then
        if !owner:KeyDown(IN_ATTACK2) then
            self:Throw(true)
        end
    end
end

function SWEP:PrimaryAttack()
    local owner = self:GetOwner()

    if owner:KeyDown(IN_USE) and self:GetActionState() == STATE_IDLE and !self:StillWaiting() then
        self:Bash()
        self:SetNextPrimaryFire(CurTime() + 0.6)
    end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
    local owner = self:GetOwner()
    if !owner:KeyPressed(IN_RELOAD) then return end

    if owner:KeyDown(IN_USE) then
        self:ChangeFuseMode()
    end
end

function SWEP:OnDeploy()
    self:SetActionState(STATE_IDLE)
end

function SWEP:GetControlHints()
    local h = {{"hold:+attack", "Overhand throw"}}
    if self.HasUnderhand then
        table.insert(h, {"hold:+attack2", "Underhand throw (roll when crouched)"})
    end
    if #self.FuseModes > 1 then
        table.insert(h, {"+use +reload", "Fuse time"})
    end
    table.insert(h, {"+use +attack", "Bash"})
    return h
end

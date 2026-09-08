// Bayonet charge: sprint with the blade levelled and run it into someone, the way the melee
// weapons charge. The rifles animate it themselves (ChargeStart / ChargeLoop / ChargeStab on 41
// of the 50 viewmodels that take a bayonet), and it only exists with one fixed.

local STATE_IDLE = 0
local STATE_CHARGE = 1

SWEP.SequenceBayonetChargeStart = "ChargeStart"
SWEP.SequenceBayonetChargeLoop = "ChargeLoop"
SWEP.SequencesBayonetChargeAttack = {"ChargeStab", "bash_bayonet"}

// what the thrust lands over an ordinary bayonet swing
SWEP.BayonetChargeDamageMultiplier = 2

// how long before the blade is far enough forward to hit anything, and how long a charge can
// be held before it gives up on finding a target
SWEP.BayonetChargeWindup = 0.3
SWEP.BayonetChargeMaxTime = 4

function SWEP:IsBayonetCharging()
    return self:GetActionState() == STATE_CHARGE
end

function SWEP:CanBayonetCharge()
    if !self:GetBayonet() then return false end
    if self:GetBipod() or self:GetReloading() then return false end

    return self:HasSequence(self.SequenceBayonetChargeStart)
end

function SWEP:StartBayonetCharge()
    self:SetActionState(STATE_CHARGE)
    self:SetActionStart(CurTime())
    self:SetIronsight(false)

    local t = self:PlaySequence(self.SequenceBayonetChargeStart, 1, true) or 0.4

    self:SetTimer(t, function()
        if !IsValid(self) or self:GetActionState() != STATE_CHARGE then return end
        if self:HasSequence(self.SequenceBayonetChargeLoop) then
            self:PlaySequence(self.SequenceBayonetChargeLoop, 1, false, true)
        end
    end, "mcv_bayonet_charge_loop")
end

function SWEP:BayonetChargeAttack()
    self:SetActionState(STATE_IDLE)

    local seq
    for _, s in ipairs(self.SequencesBayonetChargeAttack) do
        if self:HasSequence(s) then seq = s break end
    end

    local t = seq and self:PlaySequence(seq, 1, true) or 0.6
    self:GetOwner():DoAnimationEvent(self.BashGesture)

    self:BashStrike(self.BayonetRange, self.BayonetDamage * self.BayonetChargeDamageMultiplier)

    self:SetNextPrimaryFire(CurTime() + t)
end

function SWEP:EndBayonetCharge()
    self:SetActionState(STATE_IDLE)
    self:SetNextIdle(CurTime())
    self:SetNextPrimaryFire(CurTime() + 0.3)
end

// the loop holds the pose for as long as the charge is up
function SWEP:IdleSequence()
    if self:GetActionState() == STATE_CHARGE then return self.SequenceBayonetChargeLoop end

    return nil
end

function SWEP:Think_BayonetCharge()
    if self:GetActionState() != STATE_CHARGE then return end

    local owner = self:GetOwner()

    // the charge is over the moment anything holding it up stops being true: the trigger, the
    // sprint, the bayonet itself (dropped, or taken off mid-run), or a reload started over it
    if !owner:KeyDown(IN_ATTACK) or !self:GetIsSprinting() or !self:GetBayonet()
       or self:GetReloading() then
        self:EndBayonetCharge()
        return
    end

    if CurTime() < self:GetActionStart() + self.BayonetChargeWindup then return end

    local tr = self:BashTrace(self.BayonetRange)

    if tr.Hit and IsValid(tr.Entity) then
        self:BayonetChargeAttack()
    elseif CurTime() > self:GetActionStart() + self.BayonetChargeMaxTime then
        self:EndBayonetCharge()
    end
end

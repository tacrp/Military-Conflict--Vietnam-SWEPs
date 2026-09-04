function SWEP:Think()
    // In singleplayer this hook also runs on the client, but the client is NOT predicting
    // there: anything it writes to a NetworkVar is overwritten by the next server update.
    // If the client stamped its own sight/speed transitions here they would be re-stamped
    // every frame until the server's state arrived, which visibly jerks the viewmodel.
    // Everything the client needs in singleplayer is driven from the server's values via
    // PreDrawViewModel / CalcView, so the client has nothing to do in Think.
    if CLIENT and game.SinglePlayer() then return end

    local owner = self:GetOwner()

    self:Think_Sights()
    self:Think_Reload()
    self:Think_Speed()
    self:Think_Bipod()
    self:Think_HoldType()

    // Keep the networked viewmodel state in step with what the client draws (see sh_vm.lua).
    self:DoBodygroups(nil, false)

    self:ProcessTimers()

    if self:GetNextIdle() <= CurTime() then
        self:Idle()
    end

    if owner:KeyReleased(IN_ATTACK) then
        self:SetNeedTriggerPress(false)

        if self:GetPrimedAttack() then
            self:PlayAnimation(ACT_VM_IDLE)
            self:SetPrimedAttack(false)
        end
    elseif self:GetReloading() and self.ShotgunReload and owner:KeyPressed(IN_ATTACK) and self:Clip1() > 0 then
        self:SetEndReload(true)
    end

    if owner:KeyPressed(IN_USE) and owner:KeyDown(IN_WALK) then
        self:ToggleUBGL()
    end

    if owner:KeyDown(IN_ATTACK) and self:GetPrimedAttack() and self:GetLastTriggerTime() + self.TriggerDelayTime < CurTime() then
        if SERVER or !game.SinglePlayer() then
            self:AttackEffects()
            if self.ShootEntity then
                self:RocketAttack()
            else
                self:BulletAttack()
            end
            self:SetPrimedAttack(false)
            if self:GetAkimbo() and self:Clip1() % 2 == 0 then
                self:PlayAnimation(ACT_VM_PRIMARYATTACK_3, 0.5)
            else
                self:PlayAnimation(ACT_VM_PRIMARYATTACK_2, 0.5)
            end
        end
    end

    if !self:StillWaiting() and !owner:KeyDown(IN_ATTACK) and self:GetNeedCycle() and IsFirstTimePredicted() then
        local t = self:PlayAnimation(ACT_VM_RELOAD_INSERT_PULL, self.CycleSpeed, false)
        self:SetNextPrimaryFire(CurTime() + t * self.CyclePostDelay)

        if !self.AnimationHandlesHammer then
            self:SetNeedCycle(false)
        end
    end
end

local function wantsMove(owner)
    return owner:KeyDown(IN_FORWARD) or owner:KeyDown(IN_MOVERIGHT) or owner:KeyDown(IN_MOVELEFT) or owner:KeyDown(IN_BACK)
end

function SWEP:GetIsSprinting()
    local owner = self:GetOwner()

    return wantsMove(owner) and owner:KeyDown(IN_SPEED)
end

// Movement blend targets (drive the "player_movement" pose parameter and hold types).
SWEP.SpeedSprint = 273
SWEP.SpeedRun = 100
SWEP.SpeedWalk = 25
SWEP.SpeedSprintThreshold = 150
SWEP.SpeedAcceleration = 750 // units per second the blend moves at

function SWEP:GetTargetSpeed()
    local owner = self:GetOwner()

    if !owner:IsOnGround() then return 0 end
    if !wantsMove(owner) then return 0 end

    if owner:KeyDown(IN_SPEED) then
        return self.SpeedSprint
    elseif owner:KeyDown(IN_WALK) then
        return self.SpeedWalk
    end

    return self.SpeedRun
end

// Smoothed movement blend. Like GetSightAmount, this is derived from CurTime() and
// transition stamps rather than integrated per tick, so it is prediction-safe and
// frame-smooth.
function SWEP:GetSpeed()
    local target = self:GetSpeedTarget()
    local from = self:GetSpeedTransitionFrom()

    if from == target then return target end

    local elapsed = CurTime() - self:GetSpeedTransitionTime()

    if elapsed <= 0 then return from end

    return math.Approach(from, target, elapsed * self.SpeedAcceleration)
end

if CLIENT then
    // Per-frame visual copy of GetSpeed(), for the same reason as GetSightAmountRawVisual:
    // sampling the stamped curve pops when the movement target flips mid-transition.
    SWEP.VisualSpeedResyncThreshold = 60

    function SWEP:GetSpeedVisual()
        local frame = FrameNumber()

        if self.VisualSpeedFrame == frame then return self.VisualSpeed end

        local speed = self:GetSpeed()
        local cur = self.VisualSpeed

        if cur == nil or math.abs(cur - speed) > self.VisualSpeedResyncThreshold then
            cur = speed
        end

        self.VisualSpeed = math.Approach(cur, self:GetSpeedTarget(), FrameTime() * self.SpeedAcceleration)
        self.VisualSpeedFrame = frame

        return self.VisualSpeed
    end
else
    SWEP.GetSpeedVisual = SWEP.GetSpeed
end

function SWEP:Think_Speed()
    local target = self:GetTargetSpeed()

    if target == self:GetSpeedTarget() then return end

    self:SetSpeedTransitionFrom(self:GetSpeed())
    self:SetSpeedTransitionTime(CurTime())
    self:SetSpeedTarget(target)
end

function SWEP:Think_HoldType()
    local holdtype = self.HoldType

    if self:GetSpeed() >= self.SpeedSprintThreshold then
        holdtype = self.SprintHoldType
    elseif self:GetSightAmount() >= 1 then
        holdtype = self.AimHoldType
    end

    // SetHoldType is networked; only call it when something changed.
    if self.CurrentHoldType == holdtype then return end

    self.CurrentHoldType = holdtype
    self:SetHoldType(holdtype)
end

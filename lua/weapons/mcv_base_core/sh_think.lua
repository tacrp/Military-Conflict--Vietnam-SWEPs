function SWEP:Think()
    // In singleplayer this hook also runs on the client, but the client is NOT predicting
    // there: anything it writes to a NetworkVar is overwritten by the next server update.
    // If the client stamped its own sight/speed transitions here they would be re-stamped
    // every frame until the server's state arrived, which visibly jerks the viewmodel.
    // Everything the client needs in singleplayer is driven from the server's values via
    // PreDrawViewModel / CalcView, so the client has nothing to do in Think.
    if CLIENT and game.SinglePlayer() then return end

    self:Think_Speed()
    self:Think_HoldType()

    // Keep the networked viewmodel state in step with what the client draws (see sh_vm.lua).
    self:DoBodygroups(nil, false)

    self:ProcessTimers()

    if self:GetNextIdle() <= CurTime() then
        self:Idle()
    end

    self:ThinkWeapon()
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

// The game's walk / run layers blend on "player_movement" in the game's own speed units, and
// the range differs per weapon class: the run layer (the sprint carry, gun swung across the
// body) starts at that class's walk speed and is full at its sprint speed: 148-245 on rifles,
// 106-195 on the M60, 80-160 on the LPO-50. Driving it with one fixed speed put walking LMGs
// and flamethrowers into their sprint pose (the gun points left). The generator reads the
// model's run layer range into these two (port_weapon.anim_timing) and the blend is mapped
// onto it: walking sits a little into the run layer (the game jogs), sprinting at its top.
SWEP.MovementPoseWalk = 148
SWEP.MovementPoseSprint = 245
SWEP.MovementRunBlend = 0.25 // how far into the run layer plain walking goes
// aiming slows the game down: the sighted walk sits well inside the walk layer, so every gun
// sways a little and none of them jog
SWEP.SightedMovementFraction = 0.55

function SWEP:GetMovementPose(speed, sa)
    local lo, hi = self.MovementPoseWalk, self.MovementPoseSprint
    local run = lo + (hi - lo) * self.MovementRunBlend
    local pose

    if speed <= self.SpeedRun then
        pose = speed / self.SpeedRun * run
    else
        pose = Lerp((speed - self.SpeedRun) / math.max(self.SpeedSprint - self.SpeedRun, 1), run, hi)
    end

    local sighted = math.min(speed / self.SpeedRun, 1) * lo * self.SightedMovementFraction

    return Lerp(sa, pose, sighted)
end

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

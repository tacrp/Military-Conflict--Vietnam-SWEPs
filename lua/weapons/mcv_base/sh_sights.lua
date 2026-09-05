// How long a full hip <-> sight transition takes, in seconds.
function SWEP:GetSightTime()
    return 0.2 / self.IronsightSpeedScale
end

// Easing applied to the sight transition. Any function mapping [0, 1] -> [0, 1] with
// f(0) = 0 and f(1) = 1 works; names from GMod's math.ease library are accepted too.
SWEP.SightEase = "InOutSine"

local function smoothstep(p)
    return p * p * (3 - 2 * p)
end

function SWEP:GetSightEase()
    local ease = self.SightEase

    if isfunction(ease) then return ease end
    if isstring(ease) and math.ease and math.ease[ease] then return math.ease[ease] end

    return smoothstep
end

// Linear sight progress: 0 = hip, 1 = fully aimed.
// Derived purely from CurTime() and the transition stamps written in Think_Sights, so
// client and server always agree, no per-tick network traffic is generated, and on the
// client it advances every rendered frame rather than stepping once per tick.
// This is the value stored in SightTransitionFrom so interrupted transitions stay continuous.
function SWEP:GetSightAmountRaw()
    local target = self:GetSighted() and 1 or 0
    local from = self:GetSightTransitionFrom()

    if from == target then return target end

    local elapsed = CurTime() - self:GetSightTransitionTime()

    if elapsed <= 0 then return from end

    return math.Approach(from, target, elapsed / self:GetSightTime())
end

local function applyEase(self, raw)
    if raw <= 0 then return 0 end
    if raw >= 1 then return 1 end

    return self:GetSightEase()(raw)
end

// Eased sight blend for GAMEPLAY (spread, recoil, hold type). Deterministic on both
// realms so predicted results match the server. Still exactly 0 at hip and 1 when aimed.
function SWEP:GetSightAmount()
    return applyEase(self, self:GetSightAmountRaw())
end

if CLIENT then
    // Visual copy of the sight progress, advanced once per rendered frame at the same
    // speed the gameplay value moves at.
    //
    // Why this exists: the transition stamp is written at the predicted command's tick
    // time, but the previous frame was rendered up to a tick later than that. When a
    // transition is reversed mid-way the new curve has already advanced for that
    // fraction while the old one kept going the other way, so sampling the stamped
    // curve directly pops the viewmodel by up to two ticks of travel in one frame.
    // Integrating per frame toward the target instead is continuous by construction.
    // It stays within a tick of the gameplay value and is resynced if it ever drifts.
    SWEP.VisualSightResyncThreshold = 0.3

    function SWEP:GetSightAmountRawVisual()
        local frame = FrameNumber()

        if self.VisualSightFrame == frame then return self.VisualSightRaw end

        local raw = self:GetSightAmountRaw()
        local cur = self.VisualSightRaw

        if cur == nil or math.abs(cur - raw) > self.VisualSightResyncThreshold then
            cur = raw
        end

        local target = self:GetSighted() and 1 or 0

        self.VisualSightRaw = math.Approach(cur, target, FrameTime() / self:GetSightTime())
        self.VisualSightFrame = frame

        return self.VisualSightRaw
    end

    // Eased sight blend for VISUALS (viewmodel offset, FOV, pose parameters, HUD).
    function SWEP:GetSightAmountVisual()
        return applyEase(self, self:GetSightAmountRawVisual())
    end
else
    SWEP.GetSightAmountRawVisual = SWEP.GetSightAmountRaw
    SWEP.GetSightAmountVisual = SWEP.GetSightAmount
end

// Sets the aim *intent*. Whether the sights actually come up is resolved in Think_Sights
// (sprinting keeps them down).
function SWEP:ScopeToggle(on)
    if on == nil then on = !self:GetIronsight() end

    if on and !self.Ironsight then return end
    if on and self:GetReloading() then return end
    // the PTRD only fires deployed; it does not aim off the bipod either
    if on and self.MustBipod and !self:GetBipod() then return end

    self:SetIronsight(on)
end

function SWEP:Think_Sights()
    local owner = self:GetOwner()

    if owner:KeyDown(IN_ATTACK2) then
        if !self:GetIronsight() and !owner:KeyDown(IN_USE) and !self:StillWaiting() then
            self:ScopeToggle(true)
        end
    elseif self:GetIronsight() then
        self:ScopeToggle(false)
    end

    local sighted = self:GetIronsight() and !self:GetIsSprinting() and (!self.MustBipod or self:GetBipod())

    if sighted != self:GetSighted() then
        // Stamp the transition. The raw amount must be read before Sighted changes.
        self:SetSightTransitionFrom(self:GetSightAmountRaw())
        self:SetSightTransitionTime(CurTime())
        self:SetSighted(sighted)

        self:EmitSound(sighted and "MCV_Weapon_Foley_Ironsights.In" or "MCV_Weapon_Foley_Ironsights.Out")
    end
end

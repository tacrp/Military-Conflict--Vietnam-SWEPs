// Simple predicted timers. Callbacks run from Think, so they execute in a predicted
// context on the client and on the server. Timers are only *registered* on the first
// prediction of a command so that re-predicted commands do not queue duplicates.
// Note: the per-instance table is created in SWEP:Initialize (sh_deploy.lua).
SWEP.ActiveTimers = {}

function SWEP:SetTimer(time, callback, id)
    if !IsFirstTimePredicted() then return end

    table.insert(self.ActiveTimers, { time + CurTime(), id or "", callback })
end

function SWEP:TimerExists(id)
    for _, v in ipairs(self.ActiveTimers) do
        if v[2] == id then return true end
    end

    return false
end

function SWEP:KillTimer(id)
    local keeptimers = {}

    for _, v in ipairs(self.ActiveTimers) do
        if v[2] != id then table.insert(keeptimers, v) end
    end

    self.ActiveTimers = keeptimers
end

function SWEP:KillTimers()
    self.ActiveTimers = {}
end

function SWEP:ProcessTimers()
    local timers = self.ActiveTimers
    if #timers == 0 then return end

    local ct = CurTime()
    local keeptimers = {}

    for _, v in ipairs(timers) do
        if v[1] <= ct then
            v[3]()
        else
            table.insert(keeptimers, v)
        end
    end

    self.ActiveTimers = keeptimers
end

function SWEP:PlayAnimation(act, mult, lock, doidle)
    mult = mult or 1
    lock = lock or false
    doidle = doidle or false
    local reverse = false

    if mult < 0 then
        reverse = true
        mult = -mult
    end

    local vm = self:GetVM()

    if !IsValid(vm) then return end

    if act == -1 then return end

    local time = vm:SequenceDuration(act)

    time = time * mult

    vm:SendViewModelMatchingSequence(act)

    if reverse then
        vm:SetCycle(1)
        vm:SetPlaybackRate(-1 / mult)
    else
        vm:SetCycle(0)
        vm:SetPlaybackRate(1 / mult)
    end

    if lock then
        self:SetAnimLockTime(CurTime() + time)
        -- self:SetNextSecondaryFire(CurTime() + time)
    else
        self:SetAnimLockTime(0)
        -- self:SetNextSecondaryFire(0)
    end

    if doidle and !self.NoIdle then
        self:SetNextIdle(CurTime() + time)
    else
        self:SetNextIdle(math.huge)
    end

    return time
end

function SWEP:IdleAtEndOfAnimation()
    local vm = self:GetVM()
    local cyc = vm:GetCycle()
    local duration = vm:SequenceDuration()
    local rate = vm:GetPlaybackRate()

    local time = (1 - cyc) * (duration / rate)

    self:SetNextIdle(CurTime() + time)
end

function SWEP:Idle()
    if self:Clip1() == 0 then
        self:PlayAnimation(ACT_VM_IDLE_EMPTY)
    else
        self:PlayAnimation(ACT_VM_IDLE)
    end

    self:SetReady(true)
end
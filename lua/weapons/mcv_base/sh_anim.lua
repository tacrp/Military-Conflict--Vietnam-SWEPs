function SWEP:PlayAnimation(act, lock, doidle)
    mult = mult or 1
    lock = lock or false
    doidle = doidle or false

    local vm = self:GetOwner():GetViewModel()

    if !IsValid(vm) then return end

    if act == -1 then return end

    local time = vm:SequenceDuration(act)

    time = time * mult

    self:SendWeaponAnim(act)

    if lock then
        self:SetAnimLockTime(CurTime() + time)
    else
        self:SetAnimLockTime(0)
    end

    return time
end

function SWEP:IdleAtEndOfAnimation()
    local vm = self:GetOwner():GetViewModel()
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
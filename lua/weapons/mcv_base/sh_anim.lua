function SWEP:PlayAnimation(act, mult, lock)
    mult = mult or 1
    lock = lock or false
    local reverse = false

    if mult < 0 then
        reverse = true
        mult = -mult
    end

    local vm = self:GetOwner():GetViewModel()

    if !IsValid(vm) then return end

    if act == -1 then return end

    local seq = vm:SelectWeightedSequence(act)

    local time = vm:SequenceDuration(seq)

    time = time * mult

    vm:SendViewModelMatchingSequence(seq)

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

    self:SetNextIdle(CurTime() + time)

    return time
end

function SWEP:Idle()
    self:PlayAnimation(ACT_VM_IDLE)

    self:SetReady(true)
end
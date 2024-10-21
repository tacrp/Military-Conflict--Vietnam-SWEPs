function SWEP:PlayAnimation(act, mult, lock, noidle)
    mult = mult or 1
    lock = lock or false
    noidle = noidle or false
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

    if !noidle then
        self:SetNextIdle(CurTime() + time)
    else
        self:SetNextIdle(math.huge)
    end

    return time
end

function SWEP:Idle()
    if self:GetGrenadeLauncher() and self.RifleGrenadeIsUBGL then
        self:PlayAnimation(ACT_VM_IIDLE_M203, 1, false, false)
    else
        if self:GetBipod() then
            self:PlayAnimation(ACT_VM_DEPLOY, 1, false, false)
        else
            self:PlayAnimation(ACT_VM_IDLE, 1, false, false)
        end
    end

    self:SetReady(true)
end

function SWEP:HasAnimation(act)
    local vm = self:GetOwner():GetViewModel()
    return vm:SelectWeightedSequence(act) != -1
end
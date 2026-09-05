local function applySequence(self, vm, seq, mult, lock, noidle)
    local reverse = false

    if mult < 0 then
        reverse = true
        mult = -mult
    end

    local time = vm:SequenceDuration(seq) * mult

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
    else
        self:SetAnimLockTime(0)
    end

    if !noidle then
        self:SetNextIdle(CurTime() + time)
    else
        self:SetNextIdle(math.huge)
    end

    return time
end

// Play the sequence registered for an activity. mult scales the duration (negative plays
// backwards), lock blocks input for the duration, noidle keeps the last frame instead of
// returning to the idle.
function SWEP:PlayAnimation(act, mult, lock, noidle)
    mult = mult or 1
    lock = lock or false
    noidle = noidle or false

    local vm = self:GetOwner():GetViewModel()

    if !IsValid(vm) then return end

    local seq = vm:SelectWeightedSequence(act)

    if seq == -1 then print("INVALID ACT " .. act) return end

    return applySequence(self, vm, seq, mult, lock, noidle)
end

// Same, by sequence name. The game's equipment models use activities GMod does not define
// (ACT_VM_SLASH, ACT_VM_PLANT, ACT_VM_GIVE...), but their sequence names are consistent
// per weapon type, so the equipment bases address them directly.
function SWEP:PlaySequence(name, mult, lock, noidle)
    mult = mult or 1
    lock = lock or false
    noidle = noidle or false

    local vm = self:GetOwner():GetViewModel()

    if !IsValid(vm) then return end

    local seq = vm:LookupSequence(name)

    if seq == -1 then print("INVALID SEQUENCE " .. name) return end

    return applySequence(self, vm, seq, mult, lock, noidle)
end

function SWEP:Idle()
    self:PlayAnimation(self:IdleActivity(), 1, false, false)

    self:SetReady(true)
end

function SWEP:HasAnimation(act)
    local vm = self:GetOwner():GetViewModel()
    return IsValid(vm) and vm:SelectWeightedSequence(act) != -1
end

function SWEP:HasSequence(name)
    local vm = self:GetOwner():GetViewModel()
    return IsValid(vm) and vm:LookupSequence(name) != -1
end

// Duration of a named sequence at playback rate 1 (0 if missing)
function SWEP:SequenceLength(name)
    local vm = self:GetOwner():GetViewModel()
    if !IsValid(vm) then return 0 end

    local seq = vm:LookupSequence(name)
    if seq == -1 then return 0 end

    return vm:SequenceDuration(seq)
end

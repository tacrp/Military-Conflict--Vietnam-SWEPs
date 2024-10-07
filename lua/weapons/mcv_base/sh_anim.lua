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

    local time = vm:SequenceDuration(vm:SelectWeightedSequence(act))

    time = time * mult

    self:SendWeaponAnim(act)

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

    return time
end
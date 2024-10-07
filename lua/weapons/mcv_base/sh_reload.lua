function SWEP:Reload()
    self:PlayAnimation(ACT_VM_RELOADEMPTY)

    self:RestoreClip(self.Primary.ClipSize)
end

function SWEP:RestoreClip(amt)
    local reserve = self:GetInfiniteAmmo() and math.huge or (self:Clip1() + self:Ammo1())

    local lastclip1 = self:Clip1()

    self:SetClip1(math.min(math.min(self:Clip1() + amt, self:GetMaxClip1()), reserve))

    if !self:GetInfiniteAmmo() then
        reserve = reserve - self:Clip1()
        self:GetOwner():SetAmmo(reserve, self.Primary.Ammo)
    end

    return self:Clip1() - lastclip1
end

function SWEP:GetMaxClip1()
    return self.Primary.ClipSize + self.Primary.Chamber
end

function SWEP:GetInfiniteAmmo()
    return false
end
function SWEP:Reload()
    if self:StillWaiting() then return end

    if self:GetOwner():KeyDown(IN_USE) then
        self:ChangeFiremode()
        return
    end

    if self:Ammo1() == 0 then return end
    if self:Clip1() >= self:GetClip1Capacity() then return end

    if self.ShotgunReload then
        self:PlayAnimation(ACT_SHOTGUN_RELOAD_START, 1, true)

        self:SetEmptyReload(self:Clip1() == 0)
    else
        if self:Clip1() == 0 then
            self:PlayAnimation(ACT_VM_RELOADEMPTY, 1, true)
        else
            self:PlayAnimation(ACT_VM_RELOAD, 1, true)
        end
    end

    self:ScopeToggle(false)

    self:SetReloading(true)
    self:SetEndReload(false)
end

function SWEP:GetClip1Capacity()
    return self.Primary.ClipSize + self.Primary.Chamber
end

function SWEP:RestoreClip(amt)
    local reserve = self:GetInfiniteAmmo() and math.huge or (self:Clip1() + self:Ammo1())

    local lastclip1 = self:Clip1()

    self:SetClip1(math.min(self:Clip1() + amt, self:GetClip1Capacity(), reserve))

    if !self:GetInfiniteAmmo() then
        reserve = reserve - self:Clip1()
        self:GetOwner():SetAmmo(reserve, self.Primary.Ammo)
    end

    return self:Clip1() - lastclip1
end

function SWEP:GetInfiniteAmmo()
    return false
end

function SWEP:Think_Reload()
    if self:GetReloading() and !self:StillWaiting() then
        if self.ShotgunReload then
            if self:GetEndReload() or self:Clip1() >= (self:GetEmptyReload() and self.Primary.ClipSize or self:GetClip1Capacity()) or (!self:GetInfiniteAmmo() and self:Ammo1() == 0) or self:GetEndReload() then

                if (self:Clip1() == self:GetLoadedRounds() or !self:GetEmptyReload()) then
                    self:PlayAnimation(ACT_SHOTGUN_RELOAD_FINISH, 1, true)
                else
                    self:PlayAnimation(ACT_SHOTGUN_PUMP, 1, true)
                end

                self:SetReloading(false)
            else
                local t = self:PlayAnimation(ACT_VM_RELOAD, mult, true)

                self:RestoreClip(1)

                self:SetReloadFinishTime(CurTime() + t - 0.05)
            end
        else
            self:SetReloading(false)
            self:RestoreClip(self.Primary.ClipSize)
        end
    end
end
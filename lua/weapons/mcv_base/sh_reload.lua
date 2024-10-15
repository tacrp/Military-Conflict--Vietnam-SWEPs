function SWEP:Reload()
    if self:StillWaiting() then return end
    if !self:GetOwner():KeyPressed(IN_RELOAD) then return end

    if self:GetOwner():KeyDown(IN_USE) then
        self:ChangeFiremode()
        return
    end

    if self:GetGrenadeLauncher() then
        self:Reload2()
        return
    end

    if self:Ammo1() == 0 then return end
    if self:Clip1() >= self:GetClip1Capacity() then return end

    if self.ShotgunReload or (self.HybridReload and self:Clip1() > 0) then
        if self.ShotgunReloadEmptyStartAnimation and self:Clip1() == 0 then
            self:PlayAnimation(ACT_VM_RELOAD_INSERT_EMPTY)
        else
            self:PlayAnimation(ACT_SHOTGUN_RELOAD_START, 1, true)
        end

        self:SetEmptyReload(self:Clip1() == 0)
    else
        if self:Clip1() == 0 and self.HasEmptyReload then
            self:PlayAnimation(ACT_VM_RELOADEMPTY, 1, true)
        else
            self:PlayAnimation(ACT_VM_RELOAD, 1, true)
        end
    end

    self:ScopeToggle(false)

    self:SetReloading(true)
    self:SetEndReload(false)
end

function SWEP:Reload2()
    if self:Ammo2() == 0 then return end
    if self:Clip2() >= self:GetClip2Capacity() then return end

    self:PlayAnimation(ACT_VM_RELOAD_M203, 1, true)

    self:ScopeToggle(false)

    self:SetReloading(true)
    self:SetEndReload(false)
end

function SWEP:GetClip2Capacity()
    return self.Secondary.ClipSize
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

function SWEP:RestoreClip2(amt)
    local reserve = self:GetInfiniteAmmo() and math.huge or (self:Clip2() + self:Ammo2())

    local lastclip2 = self:Clip2()

    self:SetClip2(math.min(self:Clip2() + amt, self:GetClip2Capacity(), reserve))

    if !self:GetInfiniteAmmo() then
        reserve = reserve - self:Clip2()
        self:GetOwner():SetAmmo(reserve, self.Secondary.Ammo)
    end

    return self:Clip2() - lastclip2
end

function SWEP:GetInfiniteAmmo()
    return false
end

function SWEP:Think_Reload()
    if self:GetReloading() and !self:StillWaiting() then
        if self:GetGrenadeLauncher() then
            self:SetReloading(false)
            self:RestoreClip2(self.Secondary.ClipSize)
        else
            if self.ShotgunReload or (self.HybridReload and self:Clip1() > 0) then
                if self:GetEndReload() or self:Clip1() >= (self:GetEmptyReload() and self.Primary.ClipSize or self:GetClip1Capacity()) or (!self:GetInfiniteAmmo() and self:Ammo1() == 0) or self:GetEndReload() then

                    if !self.HasEmptyReload or (self:Clip1() == self:GetLoadedRounds() or !self:GetEmptyReload()) then
                        self:PlayAnimation(ACT_SHOTGUN_RELOAD_FINISH, 1, true)
                    else
                        self:PlayAnimation(ACT_SHOTGUN_PUMP, 1, true)
                    end

                    self:SetReloading(false)
                    self:SetEmptyReload(false)
                else
                    local t = self:PlayAnimation((self.HybridReload or self.ShotgunAltReload) and ACT_VM_RELOAD_INSERT or ACT_VM_RELOAD, mult, true, true)

                    self:RestoreClip(1)

                    self:SetReloadFinishTime(CurTime() + t - 0.05)
                end
            else
                self:SetReloading(false)
                self:RestoreClip(self.Primary.ClipSize)
            end
        end
    end
end
function SWEP:ToggleUBGL()
    if !self.HasRifleGrenade then return end
    if self:StillWaiting() then return end

    if self:GetBayonet() then return end

    if !self.RifleGrenadeIsUBGL then
        local t = self:PlayAnimation(ACT_VM_HOLSTER, 0.75, true, true)

        self:SetTimer(t + 0.5, function()
            if !IsValid(self) then return end
            if !self:GetGrenadeLauncher() then
                self:RestoreClip2(self.Secondary.ClipSize)

                if self:Clip2() > 0 then
                    self:PlayAnimation(ACT_VM_DRAWFULL_M203, 1, true)
                else
                    self:PlayAnimation(ACT_VM_DRAW_M203, 1, true)
                end
                self:SetGrenadeLauncher(true)
            else
                self:PlayAnimation(ACT_VM_READY, 1, true)
                self:SetGrenadeLauncher(false)
            end
        end)
    else
        if !self:GetGrenadeLauncher() then
            self:PlayAnimation(ACT_VM_IIN_M203, 1, true)
            self:SetGrenadeLauncher(true)
        else
            self:PlayAnimation(ACT_VM_IOUT_M203, 1, true)
            self:SetGrenadeLauncher(false)
        end
    end
end


function SWEP:RifleGrenadeAttack()
    local owner = self:GetOwner()

    if self:Clip2() < 1 then self:Reload() return end
    if self:GetSpeed() > 150 then return end

    if self:GetNeedTriggerPress() then return end

    self:PlayAnimation(ACT_VM_ISHOOT_M203, 0.5)

    self:RocketAttack(true)

    self:TakeSecondaryAmmo(1)

    self:SetNextPrimaryFire(CurTime() + 1)
    self:SetLastRecoilTime(CurTime())

    self:EmitSound(self.SoundGrenadeShot)

    owner:SetVelocity(self:GetAimVector() * -self.RecoilPushbackValue)

    local recoilup = Lerp(self:GetSightAmount(), self.ViewSlideRecoilUp, self.ViewSlideRecoilIronsightUp) * 3
    local recoilright = Lerp(self:GetSightAmount(), self.ViewSlideRecoilRight, self.ViewSlideRecoilIronsightRight) * 3

    owner:ViewPunch(Angle(-recoilup, recoilright * util.SharedRandom("MCVRecoilLeftRight", -1, 1), 0))

    if IsFirstTimePredicted() then
        if !self.NoEjectOnShoot then
            self:DoEject()
        end
        self:DoMuzzle()
    end

    self:SetNeedTriggerPress(true)

    if self.PlayCycleAnimation then
        self:SetNeedCycle(true)
    end
end
function SWEP:ToggleUBGL()
    if !self.HasRifleGrenade then return end
    if self:StillWaiting() then return end

    if self:GetBayonet() then return end

    if !self.RifleGrenadeIsUBGL then
        local t = self:PlayAnimation(ACT_VM_HOLSTER, 1, true, true)

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
            self:PlayAnimation(ACT_VM_IIN_M203, 1, false)
            self:SetGrenadeLauncher(true)
        else
            self:PlayAnimation(ACT_VM_IOUT_M203, 1, false)
            self:SetGrenadeLauncher(false)
        end
    end
end
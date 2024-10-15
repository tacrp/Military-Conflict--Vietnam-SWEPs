function SWEP:ToggleAkimbo()
    if self:StillWaiting() then return end

    self:ScopeToggle(false)

    local t = self:PlayAnimation(ACT_VM_HOLSTER, 1, true, true)
    self:SetAnimLockTime(CurTime() + t + 0.75)

    self:SetTimer(t + 0.5, function()
        if !IsValid(self) then return end
        local vm = self:GetOwner():GetViewModel()
        if !self:GetAkimbo() then
            self.ViewModel = self.ViewModelAkimbo
            vm:SetModel(self.ViewModel)
            self:SetAkimbo(true)
        else
            local original = weapons.Get(self:GetClass()).ViewModel
            self.ViewModel = original
            vm:SetModel(self.ViewModel)
            self:SetAkimbo(false)

            self:RestoreClip(0)
        end

        if self:Clip1() > 0 then
            self:PlayAnimation(ACT_VM_READY, 1, true)
        elseif self:Clip1() == 1 and !self:GetAkimbo() then
            self:PlayAnimation(ACT_VM_DRAW, 1, true)
        else
            self:PlayAnimation(ACT_VM_DRAW, 1, true)
        end
    end)
end
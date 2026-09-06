// Picking up another copy of a weapon the player already carries (a second pistol) is what
// allows dual wielding; the engine calls this instead of giving the weapon.
function SWEP:EquipAmmo(ply)
    if self.HasAkimbo and !self:GetHasSecond() then
        self:SetHasSecond(true)
    end
end

function SWEP:ToggleAkimbo()
    if self:StillWaiting() then return end
    if !self:GetHasSecond() and !self:GetAkimbo() then return end // one pistol only

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

            if self.Firemodes[self:GetFiremode()] == MCV.FIREMODE_FAN then
                self:ChangeFiremode()
            end
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
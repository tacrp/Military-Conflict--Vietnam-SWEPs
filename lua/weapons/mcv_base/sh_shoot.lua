function SWEP:StillWaiting()
    if self:GetNextPrimaryFire() > CurTime() then return true end
    if self:GetAnimLockTime() > CurTime() then return true end

    return false
end

function SWEP:PrimaryAttack()
    if self:StillWaiting() then return end
    if self:Clip1() < 1 then return end

    self:PlayAnimation(ACT_VM_PRIMARYATTACK)

    self:TakePrimaryAmmo(1)

    self:SetNextPrimaryFire(CurTime() + (60 / self.FireRate))

    self:EmitSound(self.SoundSingleShot)
end
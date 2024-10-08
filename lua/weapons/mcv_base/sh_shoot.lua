function SWEP:StillWaiting()
    if self:GetNextPrimaryFire() > CurTime() then return true end
    if self:GetAnimLockTime() > CurTime() then return true end

    return false
end

function SWEP:PrimaryAttack()
    if self:StillWaiting() then return end
    if self:Clip1() < 1 then return end

    if self:GetNeedTriggerPress() then return end

    if self:Clip1() == 1 then
        self:PlayAnimation(ACT_VM_SHOOTLAST, 0.5)
    else
        self:PlayAnimation(ACT_VM_PRIMARYATTACK, 0.5)
    end

    local owner = self:GetOwner()

    self:TakePrimaryAmmo(1)

    self:SetNextPrimaryFire(CurTime() + (60 / self.FireRate))
    self:SetLastRecoilTime(CurTime())

    self:BulletAttack()

    self:EmitSound(self.SoundSingleShot)

    owner:SetVelocity(owner:GetAimVector() * -self.RecoilPushbackValue)

    local firemode = self:GetFiremode()

    if firemode == MCV.FIREMODE_SEMI then
        self:SetNeedTriggerPress(true)
    end
end

function SWEP:GetSpread()
    local spread = Lerp(self:GetSightAmount(), self.Spread, self.SpreadIronsighted)

    local owner = self:GetOwner()
    local move = math.min(owner:GetVelocity():Length() / 273, 1)

    if !owner:IsOnGround() then
        spread = spread * Lerp(move, 1, self.JumpSpreadMultiplier)
    elseif owner:Crouching() then
        spread = spread * Lerp(move, self.CrouchSpreadMultiplier, self.CrouchMoveSpreadMultiplier)
    else
        spread = spread * Lerp(move, 1, self.StandMoveSpreadMultiplier)
    end

    return spread / 100
end

function SWEP:BulletAttack()
    local owner = self:GetOwner()

    local spread = self:GetSpread()

    owner:LagCompensation(true)

    owner:FireBullets({
        Damage = self.DamageGeneric,
        Num = self.Num,
        Src = owner:GetShootPos(),
        Dir = owner:GetAimVector(),
        Spread = Vector(spread, spread, spread),
        Attacker = owner,
        Callback = function(attacker, tr, dmginfo)

        end
    })

    owner:LagCompensation(false)
end

function SWEP:GetFiremode()
    return self.Firemodes[1]
end
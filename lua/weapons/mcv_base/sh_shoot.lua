function SWEP:StillWaiting()
    if self:GetNextPrimaryFire() > CurTime() then return true end
    if self:GetAnimLockTime() > CurTime() then return true end

    return false
end

function SWEP:GetAimAngle()
    local owner = self:GetOwner()

    return owner:EyeAngles() + owner:GetViewPunchAngles()
end

function SWEP:GetAimVector()
    return self:GetAimAngle():Forward()
end

function SWEP:PrimaryAttack()
    if self:StillWaiting() then return end
    if self:GetNeedCycle() then return end

    local owner = self:GetOwner()

    if owner:KeyDown(IN_USE) then
        self:Bash()
        return
    end

    if self:Clip1() < 1 then self:Reload() return end
    if self:GetSpeed() > 150 then return end

    if self:GetNeedTriggerPress() then return end

    if self.LastShotAnimation and self:Clip1() == 1 then
        self:PlayAnimation(ACT_VM_SHOOTLAST, 0.5)
    else
        self:PlayAnimation(ACT_VM_PRIMARYATTACK, 0.5)
    end

    self:TakePrimaryAmmo(1)
	
	if self:GetFiremodeValue() == MCV.FIREMODE_FAST then
		self:SetNextPrimaryFire(CurTime() + (60 / self.FireRate_Fast))
	elseif self:GetFiremodeValue() == MCV.FIREMODE_SLOW then
		self:SetNextPrimaryFire(CurTime() + (60 / self.FireRate_Slow))
	else
		self:SetNextPrimaryFire(CurTime() + (60 / self.FireRate))
	end
    self:SetLastRecoilTime(CurTime())

    self:BulletAttack()

    self:EmitSound(self.SoundSingleShot)

    owner:SetVelocity(self:GetAimVector() * -self.RecoilPushbackValue)

    local recoilup = Lerp(self:GetSightAmount(), self.ViewSlideRecoilUp, self.ViewSlideRecoilIronsightUp)
    local recoilright = Lerp(self:GetSightAmount(), self.ViewSlideRecoilRight, self.ViewSlideRecoilIronsightRight)

    owner:ViewPunch(Angle(-recoilup, recoilright * util.SharedRandom("MCVRecoilLeftRight", -1, 1), 0))

    if IsFirstTimePredicted() then
        if !self.NoEjectOnShoot then
            self:DoEject()
        end
        self:DoMuzzle()
    end

    local firemode = self:GetFiremodeValue()

    if firemode == MCV.FIREMODE_SEMI then
        self:SetNeedTriggerPress(true)
    end

    if self.PlayCycleAnimation and self:Clip1() > 0 then
        self:SetNeedCycle(true)
    end
end

function SWEP:FireAnimationEvent( pos, ang, event, name )
    if name == "eject" and IsFirstTimePredicted() then
        self:DoEject()
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
        Dir = self:GetAimVector(),
        Spread = Vector(spread, spread, spread),
        Attacker = owner,
        TracerNum = self.TracerFrequency,
        Callback = function(attacker, tr, dmginfo)
            local dmg = dmginfo:GetDamage()
            local range = (tr.HitPos - tr.StartPos):Length()

            dmg = dmg * math.pow(self.RangeModifier, math.max(range / 500, 0))

            if IsValid(tr.Entity) then
                MCV.CancelBodyDamage(tr.Entity, dmginfo, tr.HitGroup)

                local hitgroup = tr.HitGroup

                if hitgroup == HITGROUP_HEAD then
                    dmginfo:ScaleDamage(self.DamageHeadMultiplier)
                elseif hitgroup == HITGROUP_CHEST then
                    dmginfo:ScaleDamage(self.DamageChestMultiplier)
                elseif hitgroup == HITGROUP_STOMACH then
                    dmginfo:ScaleDamage(self.DamageStomachMultiplier)
                elseif hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM then
                    dmginfo:ScaleDamage(self.DamageArmMultiplier)
                elseif hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG then
                    dmginfo:ScaleDamage(self.DamageLegMultiplier)
                end
            end
        end
    })

    owner:LagCompensation(false)
end

function SWEP:GetFiremodeValue()
    return self.Firemodes[self:GetFiremode()]
end

function SWEP:ChangeFiremode()
    if self.AdjustableScopes then
        local scopelevel = self:GetScopeLevel()

        if scopelevel == 2 then
            self:PlayAnimation(ACT_VM_FIDGET, -1, true)
        else
            self:PlayAnimation(ACT_VM_FIDGET, 1, true)
        end

        scopelevel = scopelevel + 1

        if scopelevel > 2 then
            scopelevel = 1
        end

        self:SetScopeLevel(scopelevel)
        return
    end

    if #self.Firemodes <= 1 then return end

    local fm = self:GetFiremode()

    fm = fm + 1

    if fm > #self.Firemodes then
        fm = 1
    end

    self:SetFiremode(fm)

    if fm == 1 then
        self:PlayAnimation(ACT_VM_FIREMODE, -1, true)
    else
        self:PlayAnimation(ACT_VM_FIREMODE, 1, true)
    end
end
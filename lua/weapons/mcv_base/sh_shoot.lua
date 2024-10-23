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

    if self:GetGrenadeLauncher() then
        self:RifleGrenadeAttack()
        return
    end

    if self:Clip1() < 1 then self:Reload() return end
    if self:GetSpeed() > 150 then return end

    if self:GetNeedTriggerPress() then return end

    local fm = self:GetFiremodeValue()
    local fmmult = 1

    if self:GetAkimbo() then
        fmmult = 0.5
    end

    local t = 0

    if self:GetAkimbo() then
        if fm == MCV.FIREMODE_VOLLEY then
            t = self:PlayAnimation(ACT_VM_RECOIL1, 0.5)
        else
            if self.LastShotAnimation and self:Clip1() == 1 then
                t = self:PlayAnimation(ACT_VM_SHOOTLAST, 0.5)
            elseif self.LastShotAnimation and self:Clip1() == 2 then
                t = self:PlayAnimation(ACT_VM_PRIMARYATTACK_EMPTY, 0.5)
            elseif self:Clip1() % 2 == 0 then
                t = self:PlayAnimation(ACT_VM_PRIMARYATTACK, 0.5)
            else
                t = self:PlayAnimation(ACT_VM_SECONDARYATTACK, 0.5)
            end
        end
    else
        if fm == MCV.FIREMODE_VOLLEY then
            t = self:PlayAnimation(ACT_VM_RECOIL1, 0.5)
        elseif fm == MCV.FIREMODE_DA then
            if self:GetAkimbo() and self:Clip1() % 2 == 0 then
                t = self:PlayAnimation(ACT_VM_PULLPIN, 0.5, true)
            else
                t = self:PlayAnimation(ACT_VM_HAULBACK, 0.5, true)
            end
        elseif fm == MCV.FIREMODE_FAN then
            t = self:PlayAnimation(ACT_VM_PRIMARYATTACK_1, 0.5, false)
        else
            if self.LastShotAnimation and self:Clip1() == 1 then
                t = self:PlayAnimation(ACT_VM_SHOOTLAST, 0.5)
            else
                if self:GetBipod() then
                    t = self:PlayAnimation(ACT_VM_PRIMARYATTACK_DEPLOYED, 0.5)
                else
                    t = self:PlayAnimation(ACT_VM_PRIMARYATTACK, 0.5)
                end
            end
        end
    end

    if fm == MCV.FIREMODE_FAST then
        self:SetNextPrimaryFire(CurTime() + (60 / self.FireRate_Fast) * fmmult)
    elseif fm == MCV.FIREMODE_SLOW then
        self:SetNextPrimaryFire(CurTime() + (60 / self.FireRate_Slow) * fmmult)
    elseif fm == MCV.FIREMODE_SA then
        self:SetNextPrimaryFire(CurTime() + t * 0.8)
    else
        self:SetNextPrimaryFire(CurTime() + (60 / self.FireRate) * fmmult)
    end

    if fm != MCV.FIREMODE_DA then
        if self.ShootEntity then
            self:RocketAttack()
        else
            self:BulletAttack()
        end
        self:AttackEffects()
    else
        self:SetLastTriggerTime(CurTime())
        self:SetPrimedAttack(true)
    end

    local firemode = self:GetFiremodeValue()

    if firemode == MCV.FIREMODE_SEMI or firemode == MCV.FIREMODE_SA or firemode == MCV.FIREMODE_DA then
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

function SWEP:RandomSpread(spread, seed)
    seed = (seed or 0) + self:EntIndex() + engine.TickCount()
    local a = util.SharedRandom("mcv_randomspread", 0, 360, seed)
    local angleRand = Angle(math.sin(a), math.cos(a), 0)
    angleRand:Mul(spread * util.SharedRandom("mcv_randomspread2", 0, 45, seed) * 1.4142135623730)

    return angleRand
end

function SWEP:GetSpread()
    local sa = self:GetSightAmount()
    local spread = self.Spread

    local owner = self:GetOwner()
    local move = math.min(owner:GetVelocity():Length() / 273, 1)

    if !owner:IsOnGround() then
        spread = spread * Lerp(move, 1, self.JumpSpreadMultiplier)
    elseif owner:Crouching() then
        spread = spread * Lerp(move, self.CrouchSpreadMultiplier, self.CrouchMoveSpreadMultiplier)
    else
        spread = spread * Lerp(move, 1, self.StandMoveSpreadMultiplier)
    end

    spread = Lerp(sa, spread, self.SpreadIronsighted)

    local fm = self:GetFiremodeValue()

    if fm == MCV.FIREMODE_SA then
        spread = spread * 0.5
    elseif fm == MCV.FIREMODE_DA then
        spread = spread * 0.75
    end

    return spread / 100
end

function SWEP:AttackEffects()
    local owner = self:GetOwner()

    local recoilmult = 1

    local fm = self:GetFiremodeValue()

    if fm == MCV.FIREMODE_VOLLEY then
        recoilmult = math.min(self:Clip1(), self.VolleyCount)
    end

    if self:GetAkimbo() then
        recoilmult = recoilmult * 1.25
    end

    if self:GetBipod() then
        recoilmult = recoilmult * 0
    end

    self:SetLastRecoilTime(CurTime())

    local recoilup = Lerp(self:GetSightAmount(), self.ViewSlideRecoilUp, self.ViewSlideRecoilIronsightUp) * recoilmult
    local recoilright = Lerp(self:GetSightAmount(), self.ViewSlideRecoilRight, self.ViewSlideRecoilIronsightRight) * recoilmult

    owner:ViewPunch(Angle(-recoilup, recoilright * util.SharedRandom("MCVRecoilLeftRight", -1, 1), 0))

    if IsFirstTimePredicted() then
        if !self.NoEjectOnShoot then
            self:DoEject()
        end
        self:DoMuzzle()
    end

    if fm == MCV.FIREMODE_VOLLEY then
        self:TakePrimaryAmmo(math.min(self:Clip1(), self.VolleyCount))
    else
        self:TakePrimaryAmmo(1)
    end

    if fm == MCV.FIREMODE_VOLLEY and self:Clip1() > 1 then
        self:EmitSound(self.SoundDoubleShot)
    else
        self:EmitSound(self.SoundSingleShot)
    end

    local clip_percentage = self:Clip1() / self.Primary.ClipSize

    if clip_percentage < 0.334 then
        self:EmitSound(self.SoundNearlyEmpty, 100, 100, 1 - (clip_percentage * 3), CHAN_VOICE)
    end

    owner:SetVelocity(self:GetAimVector() * -self.RecoilPushbackValue)
end

function SWEP:BulletAttack()
    local owner = self:GetOwner()

    local spread = self:GetSpread()

    owner:LagCompensation(true)

    local num = self.Num

    if self:GetFiremodeValue() == MCV.FIREMODE_VOLLEY then
        num = num * math.min(self:Clip1(), self.VolleyCount)
    end

    owner:FireBullets({
        Damage = self.DamageGeneric,
        Num = num,
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

function SWEP:RocketAttack(secondary)
    if CLIENT then return end
    local owner = self:GetOwner()
    local spread = self:RandomSpread(self:GetSpread())

    local src = owner:GetShootPos()
    dir = self:GetAimAngle()

    dir = dir + spread

    local ent = self.ShootEntity
    local force = self.ShootEntityForce

    if secondary then
        ent = self.RifleGrenadeEntity
        force = self.RifleGrenadeForce
    end

    local rocket = ents.Create(ent)
    if !IsValid(rocket) then return end

    rocket:SetPos(src)
    rocket:SetOwner(owner)
    rocket.Inflictor = self
    rocket:SetAngles(dir)
    if isfunction(rocket.SetWeapon) then
        rocket:SetWeapon(self)
    end
    rocket:Spawn()

    local phys = rocket:GetPhysicsObject()

    if phys:IsValid() and force > 0 then
        phys:SetVelocityInstantaneous(dir:Forward() * force)
    end
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

    if self:GetAkimbo() and self.Firemodes[fm] == MCV.FIREMODE_FAN then
        fm = fm + 1
    end

    if fm > #self.Firemodes then
        fm = 1
    end

    self:SetFiremode(fm)

    local anim = ACT_VM_FIREMODE

    if self:GetBipod() then
        anim = ACT_VM_DFIREMODE
    end

    if self:HasAnimation(anim) then
        if fm == 1 then
            self:PlayAnimation(anim, -1, false)
        else
            self:PlayAnimation(anim, 1, false)
        end
    else
        self:SetAnimLockTime(CurTime() + 0.25)
        self:EmitSound("MCV_Weapon_Foley_AK47.DrawMetal")
    end
end
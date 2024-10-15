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

    if self.LastShotAnimation and self:Clip1() == 1 then
        self:PlayAnimation(ACT_VM_SHOOTLAST, 0.5)
    else
        self:PlayAnimation(ACT_VM_PRIMARYATTACK, 0.5)
    end

    local fm = self:GetFiremodeValue()

    if fm == MCV.FIREMODE_FAST then
        self:SetNextPrimaryFire(CurTime() + (60 / self.FireRate_Fast))
    elseif fm == MCV.FIREMODE_SLOW then
        self:SetNextPrimaryFire(CurTime() + (60 / self.FireRate_Slow))
    else
        self:SetNextPrimaryFire(CurTime() + (60 / self.FireRate))
    end

    self:SetLastRecoilTime(CurTime())

    self:BulletAttack()

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

    local recoilmult = 1

    if fm == MCV.FIREMODE_VOLLEY then
        recoilmult = self:Clip1()
    end

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
        self:TakePrimaryAmmo(self:Clip1())
    else
        self:TakePrimaryAmmo(1)
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

    local num = self.Num

    if self:GetFiremodeValue() == MCV.FIREMODE_VOLLEY then
        num = num * self:Clip1()
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
    local spread = self:GetSpread() / 360

    local src = owner:GetShootPos()
    dir = self:GetAimAngle()

    dir = dir + (AngleRand() * spread)

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

    if fm > #self.Firemodes then
        fm = 1
    end

    self:SetFiremode(fm)

    if self:HasAnimation(ACT_VM_FIREMODE) then
        if fm == 1 then
            self:PlayAnimation(ACT_VM_FIREMODE, -1, false)
        else
            self:PlayAnimation(ACT_VM_FIREMODE, 1, false)
        end
    else
        self:SetAnimLockTime(CurTime() + 0.25)
        self:EmitSound("MCV_Weapon_Foley_AK47.DrawMetal")
    end
end
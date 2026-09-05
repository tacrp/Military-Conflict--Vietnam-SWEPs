function SWEP:PrimaryAttack()
    if self:StillWaiting() then return end
    if self:GetNeedCycle() then return end

    local owner = self:GetOwner()

    // bash with USE + fire; not while deployed on the bipod (the PTRD can bash undeployed
    // even though it only fires deployed)
    if owner:KeyDown(IN_USE) then
        if !self:GetBipod() then
            self:Bash()
        end
        return
    end

    if self.MustBipod and !self:GetBipod() then return end

    if self:GetGrenadeLauncher() then
        self:RifleGrenadeAttack()
        return
    end

    if self:Clip1() < 1 then
        self:SetBurstCount(0)
        self:Reload()
        return
    end
    if self:GetSpeed() > 150 then return end

    if self:GetNeedTriggerPress() then self:SetBurstCount(0) return end

    local fm = self:GetFiremodeValue()
    local fmmult = 1

    if self:GetAkimbo() then
        fmmult = 0.5
    end

    local t = 0
    local rate = self.ShootAnimRate

    if self:GetAkimbo() then
        if fm == MCV.FIREMODE_VOLLEY and self:Clip1() >= self.VolleyCount then
            t = self:PlayAnimation(ACT_VM_RECOIL1, rate)
        elseif fm == MCV.FIREMODE_DA then
            if self:Clip1() % 2 == 0 then
                t = self:PlayAnimation(ACT_VM_PRIMARYATTACK_2, rate)
            else
                t = self:PlayAnimation(ACT_VM_PRIMARYATTACK_3, rate)
            end
        else
            local right = self:Clip1() % 2 == 0

            if self.LastShotAnimation and self:Clip1() == 1 then
                t = self:PlayAnimation(ACT_VM_SHOOTLAST, rate)
            elseif self.LastShotAnimation and self:Clip1() == 2 then
                t = self:PlayAnimation(ACT_VM_PRIMARYATTACK_EMPTY, rate)
            elseif self:HasPoseRecoil() then
                // Pose-driven recoil: no sequence change, the hand's recoil layer is scrubbed
                // from DoBodygroups. See work/PORTING.md.
                if right then
                    self:SetLastShotTimeR(CurTime())
                else
                    self:SetLastShotTimeL(CurTime())
                end
                t = self.AkimboRecoilTime
            elseif right then
                t = self:PlayAnimation(ACT_VM_PRIMARYATTACK, rate)
            else
                t = self:PlayAnimation(ACT_VM_SECONDARYATTACK, rate)
            end
        end
    else
        if fm == MCV.FIREMODE_VOLLEY and self:Clip1() >= self.VolleyCount then
            t = self:PlayAnimation(ACT_VM_RECOIL1, rate)
        elseif fm == MCV.FIREMODE_DA then
            t = self:PlayAnimation(ACT_VM_HAULBACK, rate, true)
        elseif fm == MCV.FIREMODE_FAN then
            t = self:PlayAnimation(ACT_VM_PRIMARYATTACK_1, rate, false)
        else
            if self.LastShotAnimation and self:Clip1() == 1 then
                t = self:PlayAnimation(ACT_VM_SHOOTLAST, rate)
            else
                if self:GetBipod() then
                    t = self:PlayAnimation(ACT_VM_PRIMARYATTACK_DEPLOYED, rate)
                else
                    t = self:PlayAnimation(ACT_VM_PRIMARYATTACK, rate)
                end
            end
        end
    end

    // PlayAnimation returns nothing when the model lacks the activity; never let that stall
    // or error the fire loop
    t = t or (60 / self.FireRate)

    if fm == MCV.FIREMODE_FAST then
        self:SetNextPrimaryFire(CurTime() + (60 / self.FireRate_Fast) * fmmult)
    elseif fm == MCV.FIREMODE_SLOW then
        self:SetNextPrimaryFire(CurTime() + (60 / self.FireRate_Slow) * fmmult)
    elseif fm == MCV.FIREMODE_SA then
        if self:GetAkimbo() then
            self:SetNextPrimaryFire(CurTime() + t * 0.4)
        else
            self:SetNextPrimaryFire(CurTime() + t * 0.8)
        end
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

// True when the current viewmodel was compiled with the recoil_r / recoil_l pose parameters
// (port_qc.py --pose-recoil) and the weapon opts in with AkimboPoseRecoil.
function SWEP:HasPoseRecoil()
    if !self.AkimboPoseRecoil then return false end

    local owner = self:GetOwner()
    if !IsValid(owner) or !owner:IsPlayer() then return false end

    local vm = owner:GetViewModel()
    if !IsValid(vm) then return false end

    local model = vm:GetModel()

    if self.PoseRecoilModel != model then
        self.PoseRecoilModel = model
        self.PoseRecoilAvailable = false

        for i = 0, vm:GetNumPoseParameters() - 1 do
            if vm:GetPoseParameterName(i) == "recoil_r" then
                self.PoseRecoilAvailable = true
                break
            end
        end
    end

    return self.PoseRecoilAvailable
end

function SWEP:FireAnimationEvent( pos, ang, event, name )
    if name == "eject" and IsFirstTimePredicted() then
        self:DoEject()
    elseif name == "hammerpos 1" and !self.InvertAnimationHammer then
        self:SetNeedCycle(false)
        self:SetEmptyReload(false)
    elseif name == "hammerpos 0" and self.InvertAnimationHammer then
        self:SetNeedCycle(false)
        self:SetEmptyReload(false)
    end
end

function SWEP:GetAimVector()
    return (self:GetOwner():EyeAngles() + self:GetOwner():GetViewPunchAngles() * 2):Forward()
end

function SWEP:GetSpread()
    local sa = self:GetSightAmount()
    local spread = self.Spread
    local sighted = self.SpreadIronsighted

    // a deployed bipod uses the game's bipod spreads (BulletSpreadDegreesBipod*)
    if self:GetBipod() and self.SpreadBipod then
        spread = self.SpreadBipod
        sighted = self.SpreadBipodIronsighted or self.SpreadBipod
    end

    local owner = self:GetOwner()
    local move = math.min(owner:GetVelocity():Length() / 273, 1)

    if !owner:IsOnGround() then
        spread = spread * Lerp(move, 1, self.JumpSpreadMultiplier)
    elseif owner:Crouching() then
        spread = spread * Lerp(move, self.CrouchSpreadMultiplier, self.CrouchMoveSpreadMultiplier)
    else
        spread = spread * Lerp(move, 1, self.StandMoveSpreadMultiplier)
    end

    // spread = Lerp(sa, spread, sighted)
    spread = sighted

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

    local sa = self:GetSightAmount()
    local recoilup = Lerp(sa, self.ViewSlideRecoilUp, self.ViewSlideRecoilIronsightUp) * recoilmult
    local recoilright = Lerp(sa, self.ViewSlideRecoilRight, self.ViewSlideRecoilIronsightRight) * recoilmult

    owner:ViewPunch((2 - (sa * 1.5)) * Angle(((sa * recoilup) + ((1 - sa) * recoilright)) * (-sa + (util.SharedRandom("MCVRecoilUpDown", -1, 1) * (1 - sa))), recoilright * util.SharedRandom("MCVRecoilLeftRight", -1, 1), 0))

    if IsFirstTimePredicted() then
        if !self.NoEjectOnShoot then
            self:DoEject()
        end
        self:DoMuzzle()
    end

    owner:DoAnimationEvent(self.ShootGesture)

    self:SetBurstCount(self:GetBurstCount() + 1)

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

    // The game's tracer particles instead of the stock tracer. Drawn by the shooter's own client
    // from the viewmodel muzzle; the server sends everyone else the world model's.
    local tracer = self.TracerParticle
    local freq = math.max(self.TracerFrequency or 1, 1)
    local shot = 0

    owner:FireBullets({
        Damage = self.DamageGeneric,
        Num = num,
        Src = owner:GetShootPos(),
        Dir = self:GetAimVector(),
        Spread = Vector(spread, spread, spread),
        Attacker = owner,
        Tracer = 0,
        Callback = function(attacker, tr, dmginfo)
            shot = shot + 1
            if tracer and tracer != "" and shot % freq == 0 and !tr.StartSolid then
                if CLIENT then
                    if IsFirstTimePredicted() then
                        util.ParticleTracerEx(tracer, self:GetTracerOrigin(), tr.HitPos, false, self:EntIndex(), 0)
                    end
                elseif !game.SinglePlayer() then
                    SuppressHostEvents(owner)
                    util.ParticleTracerEx(tracer, self:GetTracerOrigin(), tr.HitPos, false, self:EntIndex(), 0)
                    SuppressHostEvents(NULL)
                end
            end
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

    local count = 1

    if !secondary and self:GetFiremodeValue() == MCV.FIREMODE_VOLLEY then
        // every rocket left in the clip leaves at once, each with its own spread
        count = math.max(1, math.min(self:Clip1(), self.VolleyCount))
    end

    for i = 1, count do
        self:LaunchProjectile(secondary, i)
    end
end

function SWEP:LaunchProjectile(secondary, seed)
    local owner = self:GetOwner()
    local spread = self:RandomSpread(self:GetSpread(), seed)

    local src = owner:GetShootPos()
    local dir = self:GetAimAngle() + spread

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
    local mult = 1

    if fm == 1 then
        mult = -1
    end

    if self:GetBipod() then
        anim = ACT_VM_DFIREMODE
    end

    if self.Firemodes[fm] == MCV.FIREMODE_DA then
        anim = ACT_VM_IFIREMODE
        mult = 1
    elseif self.Firemodes[fm] == MCV.FIREMODE_SA then
        anim = ACT_VM_IFIREMODE
        mult = -1
    end

    if self:HasAnimation(anim) then
        self:PlayAnimation(anim, mult, false)
    else
        self:SetAnimLockTime(CurTime() + 0.25)
        self:EmitSound("MCV_Weapon_Foley_AK47.DrawMetal")
    end
end
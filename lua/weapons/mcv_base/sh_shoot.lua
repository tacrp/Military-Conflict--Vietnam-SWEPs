function SWEP:PrimaryAttack()
    if self:StillWaiting() then return end
    if self:GetNeedCycle() then return end

    local owner = self:GetOwner()
    local bursting = self:IsBursting() // a runaway burst finishing itself (ThinkWeapon)

    // bash with USE + fire; not while deployed on the bipod (the PTRD can bash undeployed
    // even though it only fires deployed)
    if owner:KeyDown(IN_USE) and !bursting then
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
    if self:GetSpeed() > 150 and !bursting then return end

    if self:GetNeedTriggerPress() and !bursting then self:SetBurstCount(0) return end

    local fm = self:GetFiremodeValue()
    local fmmult = 1

    // three-round burst: a fresh pull starts counting from this round; ThinkWeapon fires the
    // rest off BurstCount whether the trigger is held or not
    if fm == MCV.FIREMODE_BURST and !bursting then
        self:SetBurstCount(0)
    end

    if self:GetAkimbo() then
        fmmult = 0.5
    end

    local t = 0
    local rate = self.ShootAnimRate

    if self:GetAkimbo() then
        if fm == MCV.FIREMODE_VOLLEY and self:Clip1() >= self.VolleyCount then
            t = self:PlayAnimation(ACT_VM_RECOIL1, rate)
        elseif fm == MCV.FIREMODE_DA then
            // pulling the trigger cocks the hammer of the hand that is up next (right on an even
            // count: prepare_delayed_right is ACT_VM_HAULBACK, _left is ACT_VM_PULLPIN); the shot
            // itself (shoot_delayed_*, ACT_VM_PRIMARYATTACK_2 / _3) plays on release in ThinkWeapon
            if self:Clip1() % 2 == 0 then
                t = self:PlayAnimation(ACT_VM_HAULBACK, rate, true)
            else
                t = self:PlayAnimation(ACT_VM_PULLPIN, rate, true)
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

    if fm == MCV.FIREMODE_BURST then
        t = 60 / (self.FireRate * 1.25)
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

    if firemode == MCV.FIREMODE_BURST and self:GetBurstCount() >= self.BurstRounds then
        // burst over: a short recovery, and a pull still held has to be let go first (a
        // trigger released mid-burst already counts as let go)
        self:SetNextPrimaryFire(self:GetNextPrimaryFire() + self.BurstRecovery)
        if owner:KeyDown(IN_ATTACK) then
            self:SetNeedTriggerPress(true)
        end
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
    if (name == "eject" or name == "eject2") and IsFirstTimePredicted() then
        self:DoEject(name)
    elseif name == "hammerpos 1" and !self.InvertAnimationHammer then
        self:SetNeedCycle(false)
        self:SetEmptyReload(false)
    elseif name == "hammerpos 0" and self.InvertAnimationHammer then
        self:SetNeedCycle(false)
        self:SetEmptyReload(false)
    end
end

// Realistic mode (mcv_realistic_shooting 1): hip fire is barrel-accurate, so the inaccuracy is
// the barrel wandering off the screen centre. A slow two-tone drift in pitch and yaw with a peak
// of HipSwayScale times the gun's hip spread (degrees), halved on shotguns, damped to nothing by
// the sight amount. Deterministic in CurTime, so client and server agree; `visual` uses the
// frame-smoothed sight amount for drawing.
SWEP.HipSwayScale = 0.25

// peak of the sway in degrees (each axis), 0 when the mode is off or the sights are up
function SWEP:GetAimSwayAmplitude(visual)
    if !MCV.RealisticShooting() then return 0 end
    local sa = visual and self:GetSightAmountVisual() or self:GetSightAmount()
    local amp = (self.Spread or 0) * self.HipSwayScale * (1 - sa)
    if (self.Num or 1) > 1 then amp = amp * 0.5 end // shotguns
    return amp
end

function SWEP:GetAimSway(visual)
    local amp = self:GetAimSwayAmplitude(visual)
    if amp <= 0.0001 then return angle_zero end
    local t = CurTime() + self:EntIndex() * 7.3
    local p = (math.sin(t * 1.1) * 0.6 + math.sin(t * 2.3 + 1.7) * 0.4) * amp
    local y = (math.sin(t * 0.8 + 0.9) * 0.6 + math.sin(t * 1.9 + 3.1) * 0.4) * amp
    return Angle(p, y, 0)
end

// The direction a shot leaves along: eye angles, twice the view punch the recoil put on the gun,
// and the hip sway. Bullets, projectiles, the crosshair, the scope reticle and the viewmodel all
// read this.
function SWEP:GetAimAngle(visual)
    local owner = self:GetOwner()
    if !MCV.RealisticShooting() then
        // the game: the shot goes where the view points. The camera carries the whole punch
        // (cl_camera.lua takes none of it out in this mode), so this is the screen centre
        return owner:EyeAngles() + owner:GetViewPunchAngles()
    end
    return owner:EyeAngles() + owner:GetViewPunchAngles() * 2 + self:GetAimSway(visual)
end

function SWEP:GetAimVector(visual)
    return self:GetAimAngle(visual):Forward()
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

    // the game's stance and movement multipliers (script StandMoveSpreadMultiplier & co)
    local stance
    if !owner:IsOnGround() then
        stance = Lerp(move, 1, self.JumpSpreadMultiplier)
    elseif owner:Crouching() then
        stance = Lerp(move, self.CrouchSpreadMultiplier, self.CrouchMoveSpreadMultiplier)
    else
        stance = Lerp(move, 1, self.StandMoveSpreadMultiplier)
    end

    if MCV.RealisticShooting() then
        // realistic (mcv_realistic_shooting 1): the bullet leaves the barrel wherever it points.
        // Hip fire misses because the gun is not lined up with the eye, not through a cone, so
        // the gun's own dispersion is all there is from the hip, and on the sights a rifle or
        // pistol puts every round where it points: no spread at all. Shotguns keep their
        // pattern whatever the stance.
        if (self.Num or 1) > 1 then
            spread = sighted
        else
            spread = Lerp(sa, sighted, 0)
        end
    else
        // the game: a hip fire cone that narrows to the sighted spread as the sights come up,
        // widened by stance and movement
        spread = Lerp(sa, spread, sighted) * stance
    end

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

    if MCV.RealisticShooting() then
        // realistic: from the hip the gun jumps in a random direction and harder; on the sights
        // it climbs by the script's slide. CalcView takes most of the punch back out of the
        // view so the kick moves the aim more than the picture.
        owner:ViewPunch((1 - (sa * 0.5)) * Angle(((sa * recoilup) + ((1 - sa) * recoilright)) * (-sa + (util.SharedRandom("MCVRecoilUpDown", -1, 1) * (util.SharedRandom("MCVRecoilUpDown", 0.5, 1) - sa))), recoilright * util.SharedRandom("MCVRecoilLeftRight", -1, 1), 0))
    else
        // the game's fixed view slide: up by ViewSlideRecoil.Up, sideways by .Right (side at
        // random), the ironsight pair when aiming
        owner:ViewPunch(Angle(-recoilup, recoilright * util.SharedRandom("MCVRecoilLeftRight", -1, 1), 0))
    end

    if IsFirstTimePredicted() then
        if !self.NoEjectOnShoot then
            self:DoEject()
        end
        self:DoMuzzle()
    end

    owner:DoAnimationEvent(self:GetShootGesture())

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

    // The game's tracer particles instead of the stock tracer: the `_smoke` trail on every round
    // and the bright `_primary` every TracerFrequency-th. Sent by the server (in singleplayer the
    // client never runs FireBullets, which is why nothing showed) with the weapon and its muzzle
    // attachment as the origin: the client's weapon entity redirects that to the viewmodel's
    // attachment for the local player, so the trail leaves the gun on screen and everyone else
    // sees it leave the world model.
    local tracer = self.TracerParticle
    local smoke = (tracer and tracer != "") and (self.TracerSmokeParticle or string.gsub(tracer, "_primary$", "_smoke")) or nil
    local freq = math.max(self.TracerFrequency or 1, 1)
    local shot = 0
    local tracer_att = 0
    if SERVER and tracer and tracer != "" then
        if game.SinglePlayer() and IsValid(owner:GetViewModel()) then
            tracer_att = owner:GetViewModel():LookupAttachment("muzzle")
        else
            tracer_att = self:LookupAttachment("muzzle")
        end
        if tracer_att < 0 then tracer_att = 0 end
    end

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
            if SERVER and tracer and tracer != "" and !tr.StartSolid then
                local from = self:GetTracerOrigin()
                if smoke and smoke != tracer then
                    util.ParticleTracerEx(smoke, from, tr.HitPos, false, self:EntIndex(), tracer_att)
                end
                if shot % freq == 0 then
                    util.ParticleTracerEx(tracer, from, tr.HitPos, false, self:EntIndex(), tracer_att)
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

// A three-round burst that has started and not finished: BurstCount is only reset once it has
// reached BurstRounds (or the trigger is pulled afresh), so the burst survives a released trigger
function SWEP:IsBursting()
    if self:GetFiremodeValue() != MCV.FIREMODE_BURST then return false end
    local n = self:GetBurstCount()
    return n > 0 and n < self.BurstRounds
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

    self:SetBurstCount(0)

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

    // revolvers: the game has one animation per target mode. changefiremode_towestern (fan)
    // is ACT_VM_FIREMODE, _todelayed (double action) ACT_VM_IFIREMODE, _tohammer (single
    // action) ACT_VM_FIREMODE2; the dual models have no western
    local target = self.Firemodes[fm]
    if target == MCV.FIREMODE_FAN then
        anim = ACT_VM_FIREMODE
        mult = 1
    elseif target == MCV.FIREMODE_DA then
        anim = ACT_VM_IFIREMODE
        mult = 1
    elseif target == MCV.FIREMODE_SA then
        // ACT_VM_FIREMODE2 is not an activity GMod knows, so the sequence is played by name
        if self:HasSequence("changefiremode_tohammer") then
            self:PlaySequence("changefiremode_tohammer", 1, false)
            return
        end
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
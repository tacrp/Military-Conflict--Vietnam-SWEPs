function SWEP:GetPrecacheParticles()
    return {self.FlameParticle, self.PilotParticle, "Vietnam_Explosion_Flamethrower_BackPack"}
end

function SWEP:GetHUDAmmo()
    return self:Ammo1(), nil
end

function SWEP:GetFiremodeName()
    return "Fuel"
end

// fuel lives in the reserve; nothing to reload
function SWEP:Reload()
    local owner = self:GetOwner()
    if owner:KeyPressed(IN_RELOAD) and owner:KeyDown(IN_USE) then
        self:ChangeFiremode()
    end
end

function SWEP:Think_Reload() end

function SWEP:IsFlaming()
    return self:GetPrimedAttack()
end

function SWEP:StartFlame()
    self:SetPrimedAttack(true)
    self:SetLastTriggerTime(CurTime())
    self:PlayAnimation(ACT_VM_PRIMARYATTACK, 1, false, true)
    self:EmitSound(self.SoundFireStart)
    self:EmitSound(self.SoundFireLoop)
end

function SWEP:StopFlame()
    if !self:IsFlaming() then return end
    self:SetPrimedAttack(false)
    self:StopSound(self.SoundFireLoop)
    self:EmitSound(self.SoundFireStop)
    if self:HasAnimation(ACT_VM_RECOIL1) then
        self:PlayAnimation(ACT_VM_RECOIL1, 1, false)
    else
        self:SetNextIdle(CurTime())
    end
end

// One tick of fire: a hull trace along the stream, damage and ignition on what it reaches.
function SWEP:FlameTick()
    local owner = self:GetOwner()
    self:TakeRound(self.FuelPerTick)
    self:SetNextPrimaryFire(CurTime() + 60 / self.FireRate)

    if CLIENT then return end

    local src = owner:GetShootPos()
    local dir = self:GetAimVector()
    local hull = self.FlameHull
    local hit = {}

    // a few staggered hull traces so the whole stream width burns
    for i = 0, 2 do
        local off = (i - 1) * hull * 0.8
        local right = self:GetAimAngle():Right() * off
        local tr = util.TraceHull({
            start = src + right,
            endpos = src + right + dir * self.FlameRange,
            filter = owner,
            mask = MASK_SHOT_HULL,
            mins = Vector(-hull, -hull, -hull),
            maxs = Vector(hull, hull, hull),
        })
        local ent = tr.Entity
        if IsValid(ent) and !hit[ent] then
            hit[ent] = true
            local dmg = DamageInfo()
            dmg:SetDamage(self.DamageGeneric)
            dmg:SetDamageType(DMG_BURN)
            dmg:SetAttacker(owner)
            dmg:SetInflictor(self)
            dmg:SetDamagePosition(tr.HitPos)
            dmg:SetDamageForce(dir * 200)
            ent:TakeDamageInfo(dmg)
            if ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot() or ent:GetClass() == "prop_physics" then
                ent:Ignite(self.IgniteTime)
            end
        end
    end

    // things standing in the cloud where the stream lands also catch fire
    local tr = util.TraceLine({start = src, endpos = src + dir * self.FlameRange, filter = owner, mask = MASK_SHOT})
    for _, ent in ipairs(ents.FindInSphere(tr.HitPos, hull * 3)) do
        if !hit[ent] and (ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot()) and ent != owner then
            hit[ent] = true
            local dmg = DamageInfo()
            dmg:SetDamage(self.DamageGeneric * 0.5)
            dmg:SetDamageType(DMG_BURN)
            dmg:SetAttacker(owner)
            dmg:SetInflictor(self)
            ent:TakeDamageInfo(dmg)
            ent:Ignite(self.IgniteTime * 0.5)
        end
    end
end

function SWEP:PrimaryAttack()
    // handled in ThinkWeapon so the stream starts and stops with the key
end

function SWEP:ThinkWeapon()
    local owner = self:GetOwner()

    self:Think_Sights()

    local wants = owner:KeyDown(IN_ATTACK) and !owner:KeyDown(IN_USE) and self:GetRoundsLeft() > 0
        and self:GetAnimLockTime() <= CurTime() and self:GetHolsterTime() == 0

    if wants and !self:IsFlaming() then
        self:StartFlame()
    elseif !wants and self:IsFlaming() then
        self:StopFlame()
    end

    if self:IsFlaming() and self:GetNextPrimaryFire() <= CurTime() then
        self:FlameTick()
        self:SetLastRecoilTime(CurTime())
    end

    if owner:KeyPressed(IN_ATTACK) and owner:KeyDown(IN_USE) and !self:StillWaiting() then
        self:Bash()
        self:SetNextPrimaryFire(CurTime() + 0.6)
    end
end

function SWEP:Holster(wep)
    if self:IsFlaming() then
        self:StopFlame()
    end
    // Not self.BaseClass: for an LPO-50 (Base = mcv_flamethrower) that is this very class, so
    // the tail call looped forever and froze the game on every weapon switch after firing.
    return baseclass.Get("mcv_base").Holster(self, wep)
end

function SWEP:OnRemove()
    if CLIENT then self:StopFlameEffect() end
    self:StopSound(self.SoundFireLoop)
end

if CLIENT then
    // The stream is a particle system attached to the muzzle attachment: the viewmodel for
    // the player holding it, the world model for everyone else.
    function SWEP:FlameEmitter()
        local owner = self:GetOwner()
        if owner == LocalPlayer() and !owner:ShouldDrawLocalPlayer() then
            return owner:GetViewModel()
        end
        return self
    end

    function SWEP:StartFlameEffect()
        self:StopFlameEffect()
        local ent = self:FlameEmitter()
        if !IsValid(ent) then return end
        local att = ent:LookupAttachment("muzzle")
        if att <= 0 then att = 1 end
        local ps = CreateParticleSystem(ent, self.FlameParticle, PATTACH_POINT_FOLLOW, att)
        if IsValid(ps) and ent != self then
            // viewmodel particles are drawn from PostDrawViewModel in the viewmodel camera
            ps:StartEmission()
            ps:SetShouldDraw(false)
            table.insert(self.PCFs, ps)
        end
        self.FlamePS = ps
        self.FlamePSEnt = ent
    end

    function SWEP:StopFlameEffect()
        if IsValid(self.FlamePS) then
            self.FlamePS:StopEmission(false, false, true)
        end
        self.FlamePS = nil
    end

    // The game's stream systems aim at control point 1 (where the fuel lands); keep it on the
    // surface the player is pointing at, every frame, for both the viewmodel and world streams.
    function SWEP:UpdateFlameControlPoints()
        local ps = self.FlamePS
        if !IsValid(ps) then return end
        local owner = self:GetOwner()
        if !IsValid(owner) then return end
        local src = owner:GetShootPos()
        local dir = owner:GetAimVector()
        local tr = util.TraceLine({start = src, endpos = src + dir * self.FlameRange, filter = owner, mask = MASK_SHOT})
        ps:SetControlPoint(1, tr.HitPos)
        ps:SetControlPointOrientation(1, tr.HitNormal, dir, dir:Cross(tr.HitNormal))
        ps:SetControlPoint(2, src + dir * self.FlameRange)
    end

    function SWEP:PreDrawViewModelWeapon(vm)
        self.RenderingRTScope = false
        if self:GetHolsterTime() < CurTime() then
            self:DoRTScope()
        end
        self:UpdateMuzzleLight(vm)
        self:Think_ClientFlame()
        self:UpdateFlameControlPoints()
    end

    // The stream follows the networked flag: Think does not run on the client in singleplayer
    // and other players' weapons never think here, so this is the one place that starts and
    // stops the client effect for everyone.
    function SWEP:Think_ClientFlame()
        local flaming = self:GetPrimedAttack() and IsValid(self:GetOwner()) and self:GetOwner():GetActiveWeapon() == self
        if flaming and !IsValid(self.FlamePS) then
            self:StartFlameEffect()
        elseif !flaming and IsValid(self.FlamePS) then
            self:StopFlameEffect()
        end
    end

    function SWEP:DrawWorldModel()
        self:DrawModel()
        self:Think_ClientFlame()
        if self:GetOwner() != LocalPlayer() then self:UpdateFlameControlPoints() end
    end
end

// The tank on the back: a burst hits the wearer's back and the pack goes up.
if SERVER then
    hook.Add("EntityTakeDamage", "MCV_FlamethrowerTank", function(ent, dmginfo)
        if !ent:IsPlayer() then return end
        local wep = ent:GetActiveWeapon()
        if !IsValid(wep) or !wep.TankExplodes or !wep.MilitaryConflictVietnam then return end
        if !dmginfo:IsBulletDamage() then return end
        if (wep.NextTankCheck or 0) > CurTime() then return end
        wep.NextTankCheck = CurTime() + 0.1

        // shot from behind, into the pack
        local from = dmginfo:GetDamagePosition()
        local back = -ent:GetAimVector()
        back.z = 0
        if (from - ent:GetPos()):GetNormalized():Dot(back) < 0.55 then return end
        if math.random() > 0.35 then return end

        local pos = ent:GetPos() + Vector(0, 0, 48) + back * 10
        ParticleEffect("Vietnam_Explosion_Flamethrower_BackPack", pos, angle_zero)
        util.BlastDamage(wep, dmginfo:GetAttacker(), pos, wep.TankExplosionRadius, wep.TankExplosionDamage)
        ent:EmitSound("MCV_BaseGrenade.Explode")
        ent:Ignite(10)
        ent:SetAmmo(0, wep:GetPrimaryAmmoType())
    end)
end

function SWEP:GetControlHints()
    return {
        {"hold:+attack", "Flame"},
        {"+attack2", "Aim"},
        {"+use +attack", "Bash"},
    }
end

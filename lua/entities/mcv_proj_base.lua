AddCSLuaFile()

ENT.Type                     = "anim"
ENT.Base                     = "base_entity"
ENT.RenderGroup              = RENDERGROUP_TRANSLUCENT

ENT.PrintName                = "Base Projectile"
ENT.Category                 = ""

ENT.Spawnable                = false
ENT.Model                    = ""

local smokeimages = {"particle/smokesprites_0001", "particle/smokesprites_0002", "particle/smokesprites_0003", "particle/smokesprites_0004", "particle/smokesprites_0005", "particle/smokesprites_0006", "particle/smokesprites_0007", "particle/smokesprites_0008", "particle/smokesprites_0009", "particle/smokesprites_0010", "particle/smokesprites_0011", "particle/smokesprites_0012", "particle/smokesprites_0013", "particle/smokesprites_0014", "particle/smokesprites_0015", "particle/smokesprites_0016"}
local function GetSmokeImage()
    return smokeimages[math.random(#smokeimages)]
end

ENT.Material = false // custom material

ENT.IsRocket = false // projectile has a booster and will not drop.

ENT.Sticky = false // projectile sticks on impact

ENT.InstantFuse = true // projectile is armed immediately after firing.
ENT.TimeFuse = false // projectile will arm after this amount of time
ENT.RemoteFuse = false // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = false // projectile explodes on impact.
ENT.StickyFuse = false // projectile becomes timed after sticking.

ENT.RemoveOnImpact = false
ENT.ExplodeOnImpact = false
ENT.ExplodeOnDamage = false // projectile explodes when it takes damage.
ENT.ExplodeUnderwater = false // projectile explodes when it enters water

ENT.Defusable = false // press E on the projectile to defuse it
ENT.DefuseOnDamage = false

ENT.ImpactDamage = 25
ENT.ImpactDamageSpeed = 1000

ENT.Delay = 5 // after being triggered and this amount of time has passed, the projectile will explode.

ENT.Armed = false

ENT.SmokeTrail = false // leaves trail of smoke (old sprite emitter; unused when TrailParticle is set)
ENT.TrailParticle = nil // game particle system attached to the projectile in flight (rpg_missile_trail...)
ENT.FlareColor = nil
ENT.FlareSizeMin = 200
ENT.FlareSizeMax = 250

ENT.AudioLoop = nil

ENT.BounceSounds = nil

ENT.CollisionSphere = nil

ENT.GunshipWorkaround = true

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "Weapon")
    self:NetworkVar("Entity", 1, "Planter") // who planted a charge (its owner is cleared once planted)
end

// A planted charge is shot to set it off, and a bullet passes through anything its shooter
// owns (the engine's trace filter skips entities owned by the pass entity), so a charge cannot
// keep its planter as the owner: the planter moves to Planter (the remote and the pickup look
// at it) and to Attacker (the damage credit) and the owner is cleared.
function ENT:ReleaseOwner()
    local o = self:GetOwner()
    if !IsValid(o) then return end
    self:SetPlanter(o)
    if !IsValid(self.Attacker) then self.Attacker = o end
    self:SetOwner(NULL)
end

function ENT:Initialize()
    if SERVER then
        self:SetModel(self.Model)
        self:SetMaterial(self.Material or "")
        if self.CollisionSphere then
            self:PhysicsInitSphere(self.CollisionSphere)
        else
            self:PhysicsInit(SOLID_VPHYSICS)
            // the game's rocket / bolt models ship without a .phy: a small sphere then
            if !IsValid(self:GetPhysicsObject()) then
                self:PhysicsInitSphere(self.FallbackRadius or 2)
            end
        end
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)

        self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
        if self.Defusable then
            self:SetUseType(SIMPLE_USE)
        end

        local phys = self:GetPhysicsObject()
        if !phys:IsValid() then
            self:Remove()
            return
        end

        phys:EnableDrag(false)
        phys:SetDragCoefficient(0)
        phys:SetBuoyancyRatio(0)
        phys:Wake()

        if self.IsRocket then
            phys:EnableGravity(false)
        end
    end

    self.SpawnTime = CurTime()

    self.NPCDamage = IsValid(self:GetOwner()) and self:GetOwner():IsNPC()

    if self.AudioLoop then
        self.LoopSound = CreateSound(self, self.AudioLoop)
        self.LoopSound:Play()
    end

    if self.InstantFuse then
        self.ArmTime = CurTime()
        self.Armed = true
    end

    if CLIENT then
        self:StartTrail()
    end

    self:OnInitialize()
end

// In-flight effect: the game's own trail particle, following the projectile origin.
function ENT:StartTrail()
    if !CLIENT or self.TrailStarted or !self.TrailParticle then return end

    self.TrailStarted = true
    ParticleEffectAttach(self.TrailParticle, PATTACH_ABSORIGIN_FOLLOW, self, 0)
end

// Surface normal at the point of impact, for orienting the explosion effect. Filled in by
// PhysicsCollide; timed detonations in the air fall back to a short trace along the velocity,
// then to straight up.
function ENT:GetImpactNormal()
    if self.ImpactNormal then return self.ImpactNormal end

    local vel = self:GetVelocity()
    if vel:LengthSqr() > 1 then
        local tr = util.TraceLine({
            start = self:GetPos(),
            endpos = self:GetPos() + vel:GetNormalized() * 96,
            filter = self,
            mask = MASK_SOLID,
        })

        if tr.Hit then return -tr.HitNormal end
    end

    return vector_up
end

function ENT:GetImpactPos()
    if self.ImpactPos then
        return self.ImpactPos + (self.ImpactNormal or vector_up) * 2
    end

    return self:GetPos()
end

function ENT:OnRemove()
    if self.LoopSound then
        self.LoopSound:Stop()
    end

    if CLIENT and self.TrailStarted then
        self:StopParticles()
    end
end

function ENT:OnTakeDamage(dmg)
    if self.Detonated then return end

    if self.ExplodeOnDamage then
        if IsValid(self:GetOwner()) and IsValid(dmg:GetAttacker()) then self:SetOwner(dmg:GetAttacker())
        else self.Attacker = dmg:GetAttacker() or self.Attacker end
        self:PreDetonate()
    elseif self.DefuseOnDamage and dmg:GetDamageType() != DMG_BLAST then
        self:EmitSound("physics/plastic/plastic_box_break" .. math.random(1, 2) .. ".wav", 70, math.Rand(95, 105))
        local fx = EffectData()
        fx:SetOrigin(self:GetPos())
        fx:SetNormal(self:GetAngles():Forward())
        fx:SetAngles(self:GetAngles())
        util.Effect("ManhackSparks", fx)
        self.Detonated = true
        self:Remove()
    end
end

function ENT:PhysicsCollide(data, collider)
    // remember where and at what angle we hit, for the explosion effect
    self.ImpactNormal = -data.HitNormal
    self.ImpactPos = data.HitPos

    if IsValid(data.HitEntity) and data.HitEntity:GetClass() == "func_breakable_surf" then
        self:FireBullets({
            Attacker = self:GetOwner(),
            Inflictor = self,
            Damage = 0,
            Distance = 32,
            Tracer = 0,
            Src = self:GetPos(),
            Dir = data.OurOldVelocity:GetNormalized(),
        })
        local pos, ang, vel = self:GetPos(), self:GetAngles(), data.OurOldVelocity
        self:SetAngles(ang)
        self:SetPos(pos)
        self:GetPhysicsObject():SetVelocityInstantaneous(vel * 0.5)
        return
    end

    if self.ImpactFuse and !self.Armed then
        self.ArmTime = CurTime()
        self.Armed = true

        if self:Impact(data, collider) then
            return
        end

        if self.Delay == 0 or self.ExplodeOnImpact then
            self:PreDetonate()
        end
    elseif self.ImpactDamage > 0 and IsValid(data.HitEntity) and (engine.ActiveGamemode() != "terrortown" or !data.HitEntity:IsPlayer()) then
        local dmg = DamageInfo()
        dmg:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self.Attacker)
        dmg:SetInflictor(self)
        dmg:SetDamage(Lerp((data.OurOldVelocity:Length() - 0.6 * self.ImpactDamageSpeed) / 0.4 * self.ImpactDamageSpeed, self.ImpactDamage / 5, self.ImpactDamage))
        dmg:SetDamageType(DMG_CRUSH + DMG_CLUB)
        dmg:SetDamageForce(data.OurOldVelocity)
        dmg:SetDamagePosition(data.HitPos)
        data.HitEntity:TakeDamageInfo(dmg)
    elseif !self.ImpactFuse then
        self:Impact(data, collider)
    end

    if self.Sticky then
        self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
        self:SetPos(data.HitPos)

        self:SetAngles((-data.HitNormal):Angle())

        if data.HitEntity:IsWorld() or data.HitEntity:GetSolid() == SOLID_BSP then
            self:SetMoveType(MOVETYPE_NONE)
            self:SetPos(data.HitPos)
        else
            self:SetPos(data.HitPos)
            self:SetParent(data.HitEntity)
        end

        self.Attacker = self:GetOwner()
        self:SetOwner(NULL)

        if self.StickyFuse and !self.Armed then
            self.ArmTime = CurTime()
            self.Armed = true
        end

        self:Stuck()
    else
        if !self.Bounced then
            self.Bounced = true
            local dot = data.HitNormal:Dot(Vector(0, 0, 1))
            if dot < 0 then
                self:GetPhysicsObject():SetVelocityInstantaneous(data.OurNewVelocity * (1 + dot * 0.5))
            end
        end
    end

    if data.DeltaTime < 0.1 then return end
    if !self.BounceSounds then return end

    local s = self.BounceSounds[math.random(#self.BounceSounds)]
    if istable(s) then s = s[1] end
    if isstring(s) then self:EmitSound(s) end
end

function ENT:OnThink()
end

function ENT:OnInitialize()
end

function ENT:DoSmokeTrail()
    if CLIENT and self.SmokeTrail then
        local emitter = ParticleEmitter(self:GetPos())

        local smoke = emitter:Add(GetSmokeImage(), self:GetPos())

        smoke:SetStartAlpha(50)
        smoke:SetEndAlpha(0)

        smoke:SetStartSize(10)
        smoke:SetEndSize(math.Rand(50, 75))

        smoke:SetRoll(math.Rand(-180, 180))
        smoke:SetRollDelta(math.Rand(-1, 1))

        smoke:SetPos(self:GetPos())
        smoke:SetVelocity(-self:GetAngles():Forward() * 400 + (VectorRand() * 10))

        smoke:SetColor(200, 200, 200)
        smoke:SetLighting(true)

        smoke:SetDieTime(math.Rand(0.75, 1.25))

        smoke:SetGravity(Vector(0, 0, 0))

        emitter:Finish()
    end
end

function ENT:Think()
    if !IsValid(self) or self:GetNoDraw() then return end

    if !self.SpawnTime then
        self.SpawnTime = CurTime()
    end

    if !self.Armed and isnumber(self.TimeFuse) and self.SpawnTime + self.TimeFuse < CurTime() then
        self.ArmTime = CurTime()
        self.Armed = true
    end

    if self.Armed and self.ArmTime + self.Delay < CurTime() then
        self:PreDetonate()
    end

    if self.ExplodeUnderwater and self:WaterLevel() > 0 then
        self:PreDetonate()
    end

    self:DoSmokeTrail()

    self:OnThink()
end

function ENT:Use(ply)
    if !self.Defusable then return end

    if self.PickupAmmo then
        ply:GiveAmmo(1, self.PickupAmmo, true)
    end

    self:Remove()
end

function ENT:RemoteDetonate()
    self.ArmTime = CurTime()
    self.Armed = true
end

function ENT:PreDetonate()
    if CLIENT then return end

    if !self.Detonated then
        self.Detonated = true

        if !IsValid(self.Attacker) and !IsValid(self:GetOwner()) then self.Attacker = game.GetWorld() end

        self:Detonate()
    end
end

function ENT:Detonate()
    // fill this in :)
end

function ENT:Impact()
end

function ENT:Stuck()

end

function ENT:DrawTranslucent()
    self:Draw()
end

local mat = Material("effects/ar2_altfire1b")

function ENT:Draw()
    if self.Detonated then return end

    self:StartTrail()
    self:DrawModel()

    if self.FlareColor then
        render.SetMaterial(mat)
        render.DrawSprite(self:GetPos() + (self:GetAngles():Forward() * -16), math.Rand(self.FlareSizeMin, self.FlareSizeMax), math.Rand(self.FlareSizeMin, self.FlareSizeMax), self.FlareColor)
    end
end
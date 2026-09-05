AddCSLuaFile()

ENT.Base                     = "mcv_proj_base"
ENT.PrintName                = "Grenade"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/mcv/w_m26.mdl"

// armed the moment it leaves the hand; Delay is the fuse (set by the weapon)
ENT.InstantFuse = false
ENT.TimeFuse = 0
ENT.Delay = 4
ENT.ImpactFuse = false
ENT.ExplodeOnDamage = false
ENT.ExplodeUnderwater = false

ENT.ImpactDamage = 5
ENT.ImpactDamageSpeed = 600

ENT.ExplosionDamage = 150
ENT.ExplosionRadius = 350
ENT.IgniteRadius = 0
ENT.BurnDuration = 3 // incendiaries: how long the ground burns (the M34's fire does not linger)
ENT.BurnDamagePerSecond = 30
ENT.BurnParticle = nil // the explosion effect carries its own embers
ENT.ExplosionFamily = "grenade"
ENT.ExplosionSound = "MCV_BaseGrenade.Explode"

ENT.BounceSounds = {"MCV_HEGrenade.Bounce"}

function ENT:GetAttacker()
    local a = self.Attacker
    if IsValid(a) then return a end
    if IsValid(self:GetOwner()) then return self:GetOwner() end
    return game.GetWorld()
end

function ENT:GetInflictor()
    return IsValid(self.Inflictor) and self.Inflictor or self
end

function ENT:Detonate()
    local attacker = self:GetAttacker()

    util.BlastDamage(self:GetInflictor(), attacker, self:GetPos(), self.ExplosionRadius, self.ExplosionDamage)

    // incendiary (the game's IgniteRadius extends ExplosionRadius): a short patch of fire like
    // the M202's, damage ticking in sh_burn style, no Ignite()
    if self.IgniteRadius > 0 and SERVER then
        local pool = ents.Create("mcv_firepool")
        if IsValid(pool) then
            pool:SetPos(self:GetImpactPos() + self:GetImpactNormal() * 4)
            pool:SetAngles(self:GetImpactNormal():Angle())
            pool.Attacker = attacker
            pool.Inflictor = self:GetInflictor()
            pool.Radius = self.ExplosionRadius + self.IgniteRadius
            pool.DamagePerSecond = self.BurnDamagePerSecond
            pool.Duration = self.BurnDuration
            pool.Particle = self.BurnParticle
            pool:Spawn()
        end
    end

    MCV.ExplosionEffect(self.ExplosionFamily, self:GetImpactPos(), self:GetImpactNormal(), self:WaterLevel() > 0)

    if self.ExplosionSound then
        self:EmitSound(self.ExplosionSound)
    end

    self:Remove()
end

AddCSLuaFile()

ENT.Base                     = "mcv_grenade_base"
ENT.PrintName                = "Molotov Cocktail"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/mcv/w_molotov.mdl"

ENT.TimeFuse = false
ENT.ImpactFuse = true
ENT.ExplodeOnImpact = true
ENT.Delay = 0
ENT.BounceSounds = nil

ENT.ExplosionDamage = 35
ENT.ExplosionRadius = 200
ENT.FireParticle = "Molotov_GroundFire"

function ENT:Detonate()
    local attacker = self:GetAttacker()
    local pos = self:GetImpactPos()
    local normal = self:GetImpactNormal()

    util.BlastDamage(self:GetInflictor(), attacker, pos, self.ExplosionRadius * 0.5, self.ExplosionDamage)

    ParticleEffect("Molotov_Explosion", pos, normal:Angle())

    local pool = ents.Create("mcv_firepool")
    if IsValid(pool) then
        pool:SetPos(pos + normal * 4)
        pool:SetAngles(normal:Angle())
        pool.Attacker = attacker
        pool.Inflictor = self:GetInflictor()
        pool.Radius = self.ExplosionRadius
        pool.DamagePerSecond = 20
        pool.Duration = self.EffectDuration or 12
        pool.Particle = self.FireParticle
        pool:Spawn()
    end

    self:EmitSound("physics/glass/glass_bottle_break2.wav", 85)

    self:Remove()
end

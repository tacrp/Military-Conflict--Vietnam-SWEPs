AddCSLuaFile()

ENT.Base                     = "mcv_grenade_base"
ENT.PrintName                = "White Phosphorus Grenade"
ENT.Spawnable                = false

ENT.ExplosionFamily = "m34"
ENT.IgniteRadius = 200

function ENT:Detonate()
    // burning patch where it went off, on top of the blast
    if SERVER then
        local pool = ents.Create("mcv_firepool")
        if IsValid(pool) then
            pool:SetPos(self:GetImpactPos() + self:GetImpactNormal() * 4)
            pool.Attacker = self:GetAttacker()
            pool.Inflictor = self:GetInflictor()
            pool.Radius = self.ExplosionRadius * 0.6
            pool.DamagePerSecond = 12
            pool.Duration = math.max(self.EffectDuration or 10, 8)
            pool.Particle = nil // the M34 explosion effect carries its own burning embers
            pool:Spawn()
        end
    end

    self.BaseClass.Detonate(self)
end

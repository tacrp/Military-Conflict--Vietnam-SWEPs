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

    if self.IgniteRadius > 0 then
        for _, ent in ipairs(ents.FindInSphere(self:GetPos(), self.IgniteRadius)) do
            if ent != self and (ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot() or ent:GetClass() == "prop_physics") then
                ent:Ignite(8)
            end
        end
    end

    MCV.ExplosionEffect(self.ExplosionFamily, self:GetImpactPos(), self:GetImpactNormal(), self:WaterLevel() > 0)

    if self.ExplosionSound then
        self:EmitSound(self.ExplosionSound)
    end

    self:Remove()
end

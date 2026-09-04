AddCSLuaFile()

ENT.Base                     = "mcv_proj_base"
ENT.PrintName                = "Rocket (RPG)"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/shells/rpg7_rocket.mdl"

ENT.IsRocket = true // projectile has a booster and will not drop.

ENT.InstantFuse = false // projectile is armed immediately after firing.
ENT.RemoteFuse = false // allow this projectile to be triggered by remote detonator.
ENT.ImpactFuse = true // projectile explodes on impact.

ENT.ExplodeOnDamage = false // projectile explodes when it takes damage.
ENT.ExplodeUnderwater = true

ENT.SmokeTrail = true
ENT.FlareColor = Color(255, 255, 255)

ENT.Delay = 0

function ENT:Detonate()
    local attacker = self.Attacker or self:GetOwner() or self
    local mult = 1
    local dmg = 125

    util.BlastDamage(self, attacker, self:GetPos(), 300, dmg * mult)
    self:FireBullets({
        Attacker = attacker,
        Damage = dmg * mult,
        Tracer = 0,
        Src = self:GetPos(),
        Dir = self:GetForward(),
        HullSize = 0,
        Distance = 32,
        IgnoreEntity = self,
        Callback = function(atk, btr, dmginfo)
            dmginfo:SetDamageType(DMG_AIRBOAT + DMG_BLAST) // airboat damage for helicopters and LVS vehicles
            dmginfo:SetDamageForce(self:GetForward() * 4000) // LVS uses this to calculate penetration!
        end,
    })

    // Game explosion effect, picked per surface (see lua/mcv/shared/sh_explosions.lua)
    MCV.ExplosionEffect("rpg", self:GetPos(), -self:GetForward(), self:WaterLevel() > 0)

    self:EmitSound("MCV_BaseGrenade.Explode")

    self:Remove()
end
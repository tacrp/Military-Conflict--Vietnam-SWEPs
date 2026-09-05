AddCSLuaFile()

ENT.Base                     = "mcv_grenade_base"
ENT.PrintName                = "Dynamite"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/mcv/w_dynamite.mdl"

ENT.TimeFuse = false // lit explicitly
ENT.Delay = 6
ENT.ImpactFuse = false
ENT.ExplodeOnDamage = true
ENT.BounceSounds = {"MCV_HEGrenade.Bounce"}
ENT.ExplosionFamily = "grenade"
ENT.ExplosionDamage = 500
ENT.ExplosionRadius = 550
ENT.FuseParticle = "vietnam_weaponeffect_dynamite_fuse"

function ENT:PlantOn(parent)
    if CLIENT then return end
    self:SetMoveType(MOVETYPE_NONE)
    local phys = self:GetPhysicsObject()
    if IsValid(phys) then phys:EnableMotion(false) end
    if IsValid(parent) then self:SetParent(parent) end
    self:EmitSound("MCV_Weapon_Dynamite_Demolition.Plant")
    self:Light()
end

function ENT:Light()
    if self.Lit then return end
    self.Lit = true
    self.ArmTime = CurTime()
    self.Armed = true
    if SERVER then
        if self.FuseParticle then
            ParticleEffectAttach(self.FuseParticle, PATTACH_ABSORIGIN_FOLLOW, self, 0)
        end
        self:EmitSound("MCV_Weapon_C4.FuseBurningLoop")
    end
end

function ENT:OnRemove()
    if SERVER then self:StopSound("MCV_Weapon_C4.FuseBurningLoop") end
    self.BaseClass.OnRemove(self)
end

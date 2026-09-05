AddCSLuaFile()

ENT.Base                     = "mcv_grenade_base"
ENT.PrintName                = "Smoke Grenade"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/mcv/w_css.mdl"

ENT.ExplosionDamage = 0
ENT.ExplosionRadius = 0
ENT.EffectDuration = 25

ENT.SmokeParticle = "vietnam_smokegrenade_attached"
ENT.SmokeParticleColored = "vietnam_smokegrenade_colorcoded"
ENT.SmokeSound = "MCV_Weapon_M18.Sound"
ENT.SmokeLoop = "MCV_Weapon_M18.SoundLoop"
ENT.Hurts = false
ENT.BounceSounds = {"MCV_SmokeGrenade.Bounce"}

function ENT:SetupDataTables()
    self.BaseClass.SetupDataTables(self)
    self:NetworkVar("Bool", 0, "Popped")
    self:NetworkVar("Vector", 0, "SmokeColorVec")
end

function ENT:Detonate()
    // the canister keeps lying there and pours smoke for EffectDuration
    self.Detonated = true
    self:SetPopped(true)
    if self.SmokeColor then
        self:SetSmokeColorVec(self.SmokeColor)
    end

    self:EmitSound(self.SmokeSound)
    self:EmitSound(self.SmokeLoop)
    self.PopTime = CurTime()
    self.StopTime = CurTime() + self.EffectDuration

    self:OnPop()
end

function ENT:OnPop()
end

function ENT:OnThink()
    if CLIENT then
        if self:GetPopped() and !self.ClientSmoke then
            self.ClientSmoke = true
            local col = self:GetSmokeColorVec()
            local ps
            if col != vector_origin then
                ps = CreateParticleSystem(self, self.SmokeParticleColored, PATTACH_ABSORIGIN_FOLLOW)
                if IsValid(ps) then
                    ps:SetControlPoint(1, col / 255)
                end
            else
                ps = CreateParticleSystem(self, self.SmokeParticle, PATTACH_ABSORIGIN_FOLLOW)
            end
            self.ClientSmokePS = ps
        end
        return
    end

    if !self.StopTime then return end

    if CurTime() > self.StopTime then
        self:StopSound(self.SmokeLoop)
        self:Remove()
        return
    end

    if self.Hurts then
        self:HurtTick()
    end
end

function ENT:HurtTick()
end

function ENT:OnRemove()
    if SERVER then
        self:StopSound(self.SmokeLoop)
    end
    if CLIENT and IsValid(self.ClientSmokePS) then
        self.ClientSmokePS:StopEmissionAndDestroyImmediately()
    end
    self.BaseClass.OnRemove(self)
end

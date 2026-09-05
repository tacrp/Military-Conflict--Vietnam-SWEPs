AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Supply Box"
ENT.Spawnable = false

ENT.Model = "models/weapons/mcv/w_box.mdl"
ENT.BoxKind = "ammo"
ENT.HealAmount = 50
ENT.AmmoMagazines = 2
ENT.Uses = 3
ENT.Lifetime = 120

function ENT:Initialize()
    if SERVER then
        self:SetModel(self.Model)
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)
        self.DieTime = CurTime() + self.Lifetime
        local phys = self:GetPhysicsObject()
        if IsValid(phys) then phys:Wake() end
    end
end

function ENT:Use(ply)
    if !IsValid(ply) or !ply:IsPlayer() then return end
    if (self.NextUse or 0) > CurTime() then return end
    self.NextUse = CurTime() + 0.5

    if MCV_ApplySupply(self.BoxKind, ply, self.HealAmount, self.AmmoMagazines) then
        self:EmitSound(self.BoxKind == "medic" and "items/medshot4.wav" or "items/ammocrate_close.wav", 70)
        self.Uses = self.Uses - 1
        if self.Uses <= 0 then self:Remove() end
    else
        self:EmitSound("items/medshotno1.wav", 60)
    end
end

function ENT:Think()
    if SERVER and CurTime() > self.DieTime then
        self:Remove()
        return
    end
    self:NextThink(CurTime() + 1)
    return true
end

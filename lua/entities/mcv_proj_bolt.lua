AddCSLuaFile()

ENT.Base                     = "mcv_proj_base"
ENT.PrintName                = "Crossbow Bolt"
ENT.Spawnable                = false

ENT.Model                    = "models/weapons/mcv/crossbow_bolt.mdl"

ENT.IsRocket = false
ENT.InstantFuse = false
ENT.TimeFuse = false
ENT.Delay = 0
ENT.Sticky = true
ENT.ImpactDamage = 0
ENT.ImpactFuse = false

ENT.Damage = 55
ENT.HeadMultiplier = 4
ENT.ChestMultiplier = 3
ENT.PickupAmmo = "mcv_crossbowbolt"
ENT.Lifetime = 60

function ENT:OnInitialize()
    if SERVER then
        self:SetUseType(SIMPLE_USE)
        self.DieTime = CurTime() + self.Lifetime
        local phys = self:GetPhysicsObject()
        if IsValid(phys) then
            phys:EnableDrag(false)
            phys:SetMass(2)
        end
    end
end

function ENT:OnThink()
    if SERVER then
        // fly point first
        local phys = self:GetPhysicsObject()
        if IsValid(phys) and self:GetMoveType() == MOVETYPE_VPHYSICS then
            local vel = phys:GetVelocity()
            if vel:LengthSqr() > 100 then
                self:SetAngles(vel:Angle())
            end
        end
        if CurTime() > self.DieTime then self:Remove() end
    end
end

function ENT:Impact(data, collider)
    if self.HitDone then return end
    self.HitDone = true

    local ent = data.HitEntity
    if IsValid(ent) and (ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot() or ent:Health() > 0) then
        local owner = IsValid(self:GetOwner()) and self:GetOwner() or self.Attacker
        // let FireBullets resolve the hitgroup for the multipliers
        local wep = self:GetWeapon()
        self:FireBullets({
            Attacker = IsValid(owner) and owner or self,
            Inflictor = IsValid(wep) and wep or self,
            Damage = self.Damage,
            Force = 4,
            Tracer = 0,
            Num = 1,
            Distance = 48,
            Src = data.HitPos - data.OurOldVelocity:GetNormalized() * 16,
            Dir = data.OurOldVelocity:GetNormalized(),
            IgnoreEntity = self,
            Callback = function(atk, tr, dmginfo)
                dmginfo:SetDamageType(DMG_SLASH + DMG_NEVERGIB)
                if tr.HitGroup == HITGROUP_HEAD then
                    dmginfo:ScaleDamage(self.HeadMultiplier)
                elseif tr.HitGroup == HITGROUP_CHEST or tr.HitGroup == HITGROUP_STOMACH then
                    dmginfo:ScaleDamage(self.ChestMultiplier)
                end
            end,
        })
        self:EmitSound("MCV_Weapon_Crossbow.BoltHitBody")
        if ent:IsPlayer() or ent:IsNPC() then
            // no bolt to pick up out of a body
            timer.Simple(0.05, function() if IsValid(self) then self:Remove() end end)
        end
    else
        self:EmitSound("MCV_Weapon_Crossbow.BoltHitWorld")
    end
end

function ENT:Use(ply)
    if !IsValid(ply) or !ply:IsPlayer() then return end
    ply:GiveAmmo(1, self.PickupAmmo, false)
    self:Remove()
end

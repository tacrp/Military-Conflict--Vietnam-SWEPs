function SWEP:Deploy()
    if !self:GetReady() then
        self:PlayAnimation(ACT_VM_READY, 1, true)
        self:SetReady(true)
    else
        self:PlayAnimation(ACT_VM_DRAW, 1, true)
    end

    self:SetIronsight(false)

    return true
end

function SWEP:Holster(wep)
    if game.SinglePlayer() and CLIENT then return end

    if CLIENT and self:GetOwner() != LocalPlayer() then return end

    if self:GetOwner():IsNPC() then
        return
    end

    if self:GetReloading() then
        self:SetReloading(false)
    end

    if self:GetHolsterTime() > CurTime() then return false end -- or self:GetPrimedGrenade()

    if (self:GetHolsterTime() != 0 and self:GetHolsterTime() <= CurTime()) or !IsValid(wep) then
        -- Do the final holster request
        -- Picking up props try to switch to NULL, by the way
        self:SetHolsterTime(0)
        self:SetHolsterEntity(NULL)
        self:SetReloadFinishTime(0)

        return true
    else
        local t = self:PlayAnimation(ACT_VM_HOLSTER, 1, true, true)
        self:SetHolsterTime(CurTime() + (t or 0))
        self:SetHolsterEntity(wep)

        self:SetIronsight(false)

        self:GetOwner():DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM)
    end
end

local holsteranticrash = false

hook.Add("StartCommand", "MCV_Holster", function(ply, ucmd)
    local wep = ply:GetActiveWeapon()

    if IsValid(wep) and wep.ArcticMCV and wep:GetHolsterTime() != 0 and wep:GetHolsterTime() - wep:GetPingOffsetScale() <= CurTime() and IsValid(wep:GetHolsterEntity()) then
        wep:SetHolsterTime(-math.huge) -- Pretty much force it to work
        if !holsteranticrash then
            holsteranticrash = true
            ucmd:SelectWeapon(wep:GetHolsterEntity()) -- Call the final holster request
            holsteranticrash = false
        end
    end
end)

function SWEP:Initialize()
    // Precache particles
    PrecacheParticleSystem( self.MuzzleParticle )
    PrecacheParticleSystem( self.MuzzleParticleSmoke )
    PrecacheParticleSystem( self.MuzzleParticleIronsighted )
    PrecacheParticleSystem( self.MuzzleParticleIronsightedSmoke )
    PrecacheParticleSystem( self.MuzzleParticle3rdPerson )
    PrecacheParticleSystem( self.EjectBrassTrail )
    PrecacheParticleSystem( self.EjectBrassParticle )
    PrecacheParticleSystem( self.TracerParticle )
end
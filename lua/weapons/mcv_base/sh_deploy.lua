function SWEP:Deploy()
    if !self:GetReady() then
        self:PlayAnimation(ACT_VM_READY, 1, true)
        self:SetReady(true)
    else
        if self:GetGrenadeLauncher() and !self.RifleGrenadeIsUBGL then
            self:PlayAnimation(ACT_VM_DRAW_M203, 1, true)
        else
            self:SetGrenadeLauncher(false)
            self:PlayAnimation(ACT_VM_DRAW, 1, true)
        end
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

        local vm = self:GetOwner():GetViewModel()

        vm:SetBodyGroups("000000000000000000000")

        return true
    else
        local t = self:PlayAnimation(ACT_VM_HOLSTER, 1, true, true)
        self:SetHolsterTime(CurTime() + (t or 0))
        self:SetHolsterEntity(wep)

        self:SetIronsight(false)

        self:GetOwner():DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM)
    end
end

hook.Add("StartCommand", "MCV_Holster", function(ply, ucmd)
    local wep = ply:GetActiveWeapon()

    if IsValid(wep) and wep.MilitaryConflictVietnam then
        if wep:GetHolsterTime() != 0 and wep:GetHolsterTime() - wep:GetPingOffsetScale() <= CurTime() then
            if IsValid(wep:GetHolsterEntity()) then
                wep:SetHolsterTime(-1)
                ucmd:SelectWeapon(wep:GetHolsterEntity()) -- Call the final holster request
            end
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
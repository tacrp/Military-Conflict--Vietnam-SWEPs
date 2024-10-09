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

function SWEP:Holster()

    self:SetIronsight(false)

    return true
end

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
SWEP.ActiveEffects = {}
SWEP.PCFs = {}

function SWEP:GetTracerOrigin()
    local vm = self:GetOwner():GetViewModel()
    local att = vm:GetAttachment(1)
    return att.Pos
end

function SWEP:DoMuzzle(alt)
    if !IsFirstTimePredicted() then return end
    local muzz_qca, muzz_qca_wm = 1, 1

    if self:GetGrenadeLauncher() and self.RifleGrenadeIsUBGL then
        muzz_qca = 4
    end

    local data = EffectData()
    data:SetEntity(self)
    data:SetAttachment(muzz_qca)
    data:SetHitBox(muzz_qca_wm or muzz_qca) // unused field (integer between 0-2047)

    util.Effect( "mcv_muzzleeffect", data )

    if CLIENT and self:GetOwner() == LocalPlayer() then
        self:DoMuzzleLight()
    elseif game.SinglePlayer() then
        self:CallOnClient("DoMuzzleLight")
    end
end

function SWEP:DoEject(alt)
    if !IsFirstTimePredicted() then return end
    if self.EjectBrassType == 0 then return end

    local eject_qca, eject_qca_wm = 2, 2

    local data = EffectData()
    data:SetEntity(self)
    data:SetFlags(self.EjectBrassType)
    data:SetAttachment(eject_qca)
    data:SetHitBox(eject_qca_wm or eject_qca) // unused field (integer between 0-2047)

    util.Effect( "mcv_shelleffect", data )
end

function SWEP:DoMuzzleLight()
    if !IsFirstTimePredicted() and !game.SinglePlayer() then return end

    if IsValid(self.MuzzleLight) then self.MuzzleLight:Remove() end

    local lamp = ProjectedTexture()
    lamp:SetTexture("effects/flashlight_muzzleflash")
    local val1, val2
    if self.Silencer then
        val1, val2 = math.Rand(0.2, 0.4), math.Rand(100, 105)
        lamp:SetBrightness(val1)
        lamp:SetFOV(val2)
    else
        val1, val2 = math.Rand(2, 3), math.Rand(115, 120)
        lamp:SetBrightness(val1)
        lamp:SetFOV(val2)
    end

    lamp:SetFarZ(600)
    lamp:SetPos(self:GetTracerOrigin())
    lamp:SetAngles(self:GetAimAngle())
    lamp:Update()

    self.MuzzleLight = lamp
    self.MuzzleLightStart = UnPredictedCurTime()
    self.MuzzleLightEnd = UnPredictedCurTime() + 0.06
    self.MuzzleLightBrightness = val1
    self.MuzzleLightFOV = val2

    -- In multiplayer the timer will last longer than intended - sh_think should kill the light first.
    -- This is a failsafe for when the weapon stops thinking before light is killed (holstered, removed etc.).
    timer.Simple(0.06, function()
        if IsValid(lamp) then lamp:Remove() end
    end)
end
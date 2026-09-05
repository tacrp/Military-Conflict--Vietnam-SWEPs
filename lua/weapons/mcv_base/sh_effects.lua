// Class-level defaults only; SWEP:Initialize creates per-instance tables.
SWEP.ActiveEffects = {}
SWEP.PCFs = {}

function SWEP:GetTracerOrigin()
    local vm = self:GetOwner():GetViewModel()
    local muzz_qca = vm:LookupAttachment("muzzle")
    if self:GetAkimbo() and self:Clip1() % 2 == 0 then
        muzz_qca = vm:LookupAttachment("muzzleleft") > 0 and vm:LookupAttachment("muzzleleft") or vm:LookupAttachment("muzzle2")
    end
    local att = muzz_qca > 0 and vm:GetAttachment(muzz_qca)
    if !att then
        // no muzzle attachment on this model (single model forced into akimbo, equipment)
        return self:GetOwner():GetShootPos()
    end
    return att.Pos
end

function SWEP:DoMuzzle(alt)
    if !IsFirstTimePredicted() then return end
    local vm = self:GetOwner():GetViewModel()
    local muzz_qca = vm:LookupAttachment("muzzle")

    if self:GetGrenadeLauncher() and self.RifleGrenadeIsUBGL then
        muzz_qca = vm:LookupAttachment("muzzle2")
    end

    local is_volley = self:GetFiremodeValue() == MCV.FIREMODE_VOLLEY and self:Clip1() >= self.VolleyCount

    if self:GetAkimbo() and self:Clip1() % 2 == 1 and !is_volley then
        muzz_qca = vm:LookupAttachment("muzzleleft") > 0 and vm:LookupAttachment("muzzleleft") or vm:LookupAttachment("muzzle2")
    end

    local data = EffectData()
    data:SetEntity(self)
    data:SetAttachment(muzz_qca)

    util.Effect( "mcv_muzzleeffect", data )

    if self:GetAkimbo() and is_volley then
        local data2 = EffectData()
        data2:SetEntity(self)
        data2:SetAttachment(4)

        util.Effect( "mcv_muzzleeffect", data2 )
    end

    if CLIENT and self:GetOwner() == LocalPlayer() then
        self:DoMuzzleLight()
    elseif game.SinglePlayer() then
        self:CallOnClient("DoMuzzleLight")
    end
end

function SWEP:DoEject(alt)
    if !IsFirstTimePredicted() then return end
    if self.EjectBrassType == 0 then return end
    local vm = self:GetOwner():GetViewModel()

    local eject_qca = vm:LookupAttachment("eject")

    local data = EffectData()
    data:SetEntity(self)
    data:SetFlags(self.EjectBrassType)
    data:SetAttachment(eject_qca)

    util.Effect( "mcv_shelleffect", data )
end

function SWEP:DoMuzzleLight()
    if !IsFirstTimePredicted() and !game.SinglePlayer() then return end

    if IsValid(self.MuzzleLight) then self.MuzzleLight:Remove() end

    local lamp = ProjectedTexture()
    lamp:SetTexture(self.MuzzleFlashLightTexture)
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
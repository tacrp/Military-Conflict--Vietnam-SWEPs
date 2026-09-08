// Class-level defaults only; SWEP:Initialize creates per-instance tables.
SWEP.ActiveEffects = {}
SWEP.PCFs = {}

function SWEP:GetTracerOrigin()
    local owner = self:GetOwner()
    if SERVER or owner != LocalPlayer() or owner:ShouldDrawLocalPlayer() then
        // world model muzzle
        local id = self:LookupAttachment("muzzle")
        local att = id > 0 and self:GetAttachment(id)
        return att and att.Pos or owner:GetShootPos()
    end
    local vm = owner:GetViewModel()
    local muzz_qca = vm:LookupAttachment("muzzle")
    if self:GetAkimbo() and self:Clip1() % 2 == 1 then // the left gun fires on an odd count (DoMuzzle, DoEject)
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
    data:SetMagnitude((self:GetAkimbo() and self:Clip1() % 2 == 1 and !is_volley) and 1 or 0) // third person: left gun

    util.Effect( "mcv_muzzleeffect", data )

    if self:GetAkimbo() and is_volley then
        local data2 = EffectData()
        data2:SetEntity(self)
        data2:SetAttachment(4)
        data2:SetMagnitude(1)

        util.Effect( "mcv_muzzleeffect", data2 )
    end

    if CLIENT and self:GetOwner() == LocalPlayer() then
        self:DoMuzzleLight()
    elseif game.SinglePlayer() then
        self:CallOnClient("DoMuzzleLight")
    end
end

// `attachment` names the port the shell leaves from: an animation event carries its own
// ("eject2" on the duals' left-hand shots); the shot itself picks the gun that just fired by the
// same parity DoMuzzle uses (odd count left, "eject2"), both guns on a volley.
function SWEP:DoEject(attachment)
    if !IsFirstTimePredicted() then return end
    if self.EjectBrassType == 0 then return end
    local vm = self:GetOwner():GetViewModel()

    local names = {attachment or "eject"}
    if !attachment and self:GetAkimbo() then
        local is_volley = self:GetFiremodeValue() == MCV.FIREMODE_VOLLEY and self:Clip1() >= self.VolleyCount
        if is_volley then
            names = {"eject", "eject2"}
        elseif self:Clip1() % 2 == 1 then
            names = {"eject2"}
        end
    end

    for _, name in ipairs(names) do
        local eject_qca = vm:LookupAttachment(name)
        if eject_qca <= 0 then eject_qca = vm:LookupAttachment("eject") end

        local data = EffectData()
        data:SetEntity(self)
        data:SetFlags(self.EjectBrassType)
        data:SetAttachment(eject_qca)
        data:SetMagnitude(name == "eject2" and 1 or 0) // third person: left gun

        util.Effect( "mcv_shelleffect", data )
    end
end

function SWEP:DoMuzzleLight()
    if !IsFirstTimePredicted() and !game.SinglePlayer() then return end

    // Nothing burns at the muzzle of a weapon that carries no muzzle particle, so it lights
    // nothing either: the crossbow is the only one, and a gun that flashes always has one.
    if (self.MuzzleParticle or "") == "" and (self.MuzzleParticleIronsighted or "") == "" then return end

    local mode = MCV.MuzzleLightMode()
    if mode == MCV.MUZZLE_LIGHT_OFF then return end

    // The cheap one: the engine's round glow, no shadows and nothing to follow the muzzle
    // frame by frame, so it is fired and forgotten.
    if mode == MCV.MUZZLE_LIGHT_DYNAMIC then
        local dl = DynamicLight(self:EntIndex())
        if dl then
            dl.pos = self:GetTracerOrigin()
            dl.r, dl.g, dl.b = 255, 226, 170
            dl.brightness = self.Silencer and 1 or 3
            dl.size = self.Silencer and 128 or 300
            dl.decay = 3000
            dl.dietime = CurTime() + 0.06
        end
        return
    end

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
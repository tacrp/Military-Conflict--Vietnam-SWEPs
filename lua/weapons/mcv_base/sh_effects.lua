SWEP.ActiveEffects = {}
SWEP.PCFs = {}

function SWEP:DoMuzzle(alt)
    if !IsFirstTimePredicted() then return end
    local muzz_qca, muzz_qca_wm = 1, 1

    local data = EffectData()
    data:SetEntity(self)
    data:SetAttachment(muzz_qca)
    data:SetHitBox(muzz_qca_wm or muzz_qca) // unused field (integer between 0-2047)

    util.Effect( "mcv_muzzleeffect", data )
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

function SWEP:ViewModelDrawn()
    local newactiveeffects = {}
    for _, effect in ipairs(self.ActiveEffects) do
        if !IsValid(effect) then continue end
        if !effect.VMContext then continue end

        effect:DrawModel()

        table.insert(newactiveeffects, effect)
    end

    self.ActiveEffects = newactiveeffects
end

function SWEP:PostDrawViewModel()
    cam.IgnoreZ(false)

    // cam.Start3D()
    //     cam.IgnoreZ(false)
    //     local newpcfs = {}

    //     for _, pcf in ipairs(self.PCFs) do
    //         if pcf and IsValid(pcf) and pcf.Render then
    //             pcf:Render()
    //             table.insert(newpcfs, pcf)
    //         end
    //     end

    //     if !inrt then self.PCFs = newpcfs end
    // cam.End3D()
end
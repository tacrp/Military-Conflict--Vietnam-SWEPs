SWEP.ActiveEffects = {}
SWEP.PCFs = {}

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
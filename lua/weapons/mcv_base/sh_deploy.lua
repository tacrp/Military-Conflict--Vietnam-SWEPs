function SWEP:Deploy()
    if !self:GetReady() then
        self:PlayAnimation(ACT_VM_READY, 1, true)
        self:SetReady(true)
    else
        self:PlayAnimation(ACT_VM_DRAW, 1, true)
    end

    return true
end

function SWEP:Holster()
    return true
end

function SWEP:Initialize()
end
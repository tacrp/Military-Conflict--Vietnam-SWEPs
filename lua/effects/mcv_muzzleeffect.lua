function EFFECT:Init(data)
    local wpn = data:GetEntity()

    if !IsValid(wpn) then self:Remove() return end

    local muzzle = {wpn.MuzzleParticle, wpn.MuzzleParticleSmoke}

    local att = data:GetAttachment() or 1

    local wm = false

    if (LocalPlayer():ShouldDrawLocalPlayer() or wpn.Owner != LocalPlayer()) then
        wm = true
        att = data:GetHitBox()
    end

    local parent = wpn

    if !wm then
        parent = LocalPlayer():GetViewModel()

        if wpn:GetSightAmount() >= 1 then
            muzzle = {wpn.MuzzleParticleIronsighted, wpn.MuzzleParticleIronsightedSmoke}
        end
    else
        parent = self
        muzzle = wpn.MuzzleParticle3rdPerson
    end

    -- if !IsValid(parent) then return end

    if muzzle then
        if !istable(muzzle) then
            muzzle = {muzzle}
        end

        for _, muzzleeffect in ipairs(muzzle) do
            local pcf = CreateParticleSystem(muz or parent, muzzleeffect, PATTACH_POINT_FOLLOW, att)

            if IsValid(pcf) then
                pcf:StartEmission()

                if (muz or parent) != vm and !wm then
                    pcf:SetShouldDraw(false)
                    table.insert(wpn.PCFs, pcf)
                end
            end
        end
    end
end

function EFFECT:Think()
    return false
end

function EFFECT:Render()
    return false
end
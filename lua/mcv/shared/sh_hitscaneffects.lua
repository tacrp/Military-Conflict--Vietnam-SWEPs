// Hitscan effects belong to the firing callback, not a second engine impact hook.
function MCV.HitscanEffects(wep, tr, damage, tracer)
    if CLIENT and !game.SinglePlayer() and !IsFirstTimePredicted() then return end
    local owner = wep:GetOwner()
    local recipients = true
    if SERVER then
        recipients = RecipientFilter()
        recipients:AddPVS(tr.StartPos)
        recipients:AddPVS(tr.HitPos)
        // The shooter already emitted the first predicted command's effects.
        // NPCs and singleplayer have no such client firing callback.
        if !game.SinglePlayer() and IsValid(owner) and owner:IsPlayer() then
            recipients:RemovePlayer(owner)
        end
    end
    if tracer > 0 then
        local fx = EffectData()
        fx:SetEntity(wep)
        fx:SetStart(tr.StartPos)
        fx:SetOrigin(tr.HitPos)
        util.Effect("mcv_tracer", fx, true, recipients)
    end
    if !tr.Hit or tr.HitSky or tr.StartSolid or tr.AllSolid then return end
    if MCV.SurfaceImpact(tr, damage, recipients) then return end
    local fx = EffectData()
    fx:SetOrigin(tr.HitPos)
    fx:SetStart(tr.StartPos)
    fx:SetNormal(tr.HitNormal)
    fx:SetSurfaceProp(tr.SurfaceProps or 0)
    fx:SetDamageType(DMG_BULLET)
    fx:SetHitBox(tr.HitBox or 0)
    if IsValid(tr.Entity) then fx:SetEntity(tr.Entity) end
    util.Effect("Impact", fx, true, recipients)
end

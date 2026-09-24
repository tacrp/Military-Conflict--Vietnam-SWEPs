local contacts = {}

// Flight runs outside command prediction. Deduplicate actual contacts, not Think calls.
function MCV.PhysicalBulletImpact(key, layer, tr, damage)
    if !tr.Hit or tr.HitSky or tr.StartSolid or tr.AllSolid then return end
    local id = key .. ":" .. layer
    local old = contacts[id]
    if old and (old.pos - tr.HitPos):Length() <= 32 then return end
    contacts[id] = {pos = tr.HitPos, expires = UnPredictedCurTime() + 15}
    if MCV.SurfaceImpact(tr, damage) then return end
    // Stock mode/flesh fallback, without firing a second damaging bullet.
    local fx = EffectData()
    fx:SetOrigin(tr.HitPos)
    fx:SetStart(tr.StartPos)
    fx:SetNormal(tr.HitNormal)
    fx:SetSurfaceProp(tr.SurfaceProps or 0)
    fx:SetDamageType(DMG_BULLET)
    fx:SetHitBox(tr.HitBox or 0)
    if IsValid(tr.Entity) then fx:SetEntity(tr.Entity) end
    util.Effect("Impact", fx, true, true)
end

net.Receive("MCV_PhysicalImpact", function()
    local key, layer = net.ReadString(), net.ReadUInt(8)
    local function vector() return Vector(net.ReadFloat(), net.ReadFloat(), net.ReadFloat()) end
    local tr = {Hit = true, HitPos = vector(), StartPos = vector(), HitNormal = vector(),
        Entity = net.ReadEntity(), SurfaceProps = net.ReadUInt(16),
        MatType = net.ReadUInt(8), HitBox = net.ReadUInt(16)}
    MCV.PhysicalBulletImpact(key, layer, tr, net.ReadFloat())
end)

local lastTime = UnPredictedCurTime()
hook.Add("Think", "MCV_PhysicalImpactCleanup", function()
    local now = UnPredictedCurTime()
    if now < lastTime then contacts = {} end
    lastTime = now
    for id, hit in pairs(contacts) do
        if now > hit.expires then contacts[id] = nil end
    end
end)
hook.Add("PostCleanupMap", "MCV_PhysicalImpactCleanup", function() contacts = {} end)

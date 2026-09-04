EFFECT.Type = 1

EFFECT.Pitch = 100

EFFECT.Model = "models/shells/shell_57.mdl"

EFFECT.AlreadyPlayedSound = false
EFFECT.ShellTime = 0.5
EFFECT.SpawnTime = 0

EFFECT.VMContext = true

function EFFECT:Init(data)

    local att = data:GetAttachment()
    local ent = data:GetEntity()

    self.Type = data:GetFlags() or self.Type

    local typetbl = MCV.ShellTypes[self.Type]

    if !IsValid(ent) then self:Remove() return end
    if !IsValid(ent:GetOwner()) then self:Remove() return end

    local origin, ang, dir, mdl

    if LocalPlayer():ShouldDrawLocalPlayer() or ent:GetOwner() != LocalPlayer() then
        mdl = ent
        att = data:GetHitBox()
        self.VMContext = false
    else
        mdl = LocalPlayer():GetViewModel()
        table.insert(ent.ActiveEffects, self)
    end

    if !IsValid(mdl) then self:Remove() return end
    if !typetbl then self:Remove() return end

    local attdata = mdl:GetAttachment(att)
    if !attdata then self:Remove() return end

    origin = attdata.Pos
    ang = attdata.Ang

    dir = ang:Forward()

    ang:RotateAroundAxis(ang:Forward(), 0)
    ang:RotateAroundAxis(ang:Up(), 90)

    self:SetPos(origin)
    self:SetModel(typetbl.Model)
    self:DrawShadow(true)
    self:SetAngles(ang)

    self:SetNoDraw(true)

    self.Sound = typetbl.Sound

    local pb_vert = 2
    local pb_hor = 0.25

    local mag = 150

    self:PhysicsInitBox(Vector(-pb_vert,-pb_hor,-pb_hor), Vector(pb_vert,pb_hor,pb_hor))

    self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

    local phys = self:GetPhysicsObject()

    local plyvel = Vector(0, 0, 0)

    if IsValid(ent.Owner) then
        plyvel = ent.Owner:GetAbsVelocity()
    end

    phys:Wake()
    phys:SetDamping(0, 0)
    phys:SetMass(1)
    phys:SetMaterial("gmod_silent")

    phys:SetVelocity((dir * mag * math.Rand(1, 2)) + plyvel)

    phys:AddAngleVelocity(VectorRand() * 100)
    phys:AddAngleVelocity(ang:Up() * -2500 * math.Rand(0.75, 1.25))

    local smoke = true

    if smoke and IsValid(mdl) then
        local pcf = CreateParticleSystem(mdl, ent.EjectBrassParticle, PATTACH_POINT_FOLLOW, att)

        if IsValid(pcf) then
            pcf:StartEmission()
        end

        local smkpcf = CreateParticleSystem(self, ent.EjectBrassTrail, PATTACH_ABSORIGIN_FOLLOW, 0)

        if IsValid(smkpcf) then
            smkpcf:StartEmission()
        end

        if self.VMContext then
            if pcf then
                table.insert(ent.PCFs, pcf)
                pcf:SetShouldDraw(false)
            end
            if smkpcf then
                table.insert(ent.PCFs, smkpcf)
                smkpcf:SetShouldDraw(false)
            end
        end
    end

    self.SpawnTime = CurTime()
end

function EFFECT:PhysicsCollide(colData)
    if self.AlreadyPlayedSound then return end
    local phys = self:GetPhysicsObject()
    phys:SetVelocityInstantaneous(colData.HitNormal * -150)

    sound.Play(self.Sound, self:GetPos())
    self:StopSound("Default.ImpactHard")
    self.VMContext = false
    self:SetNoDraw(false)

    self.AlreadyPlayedSound = true
end

function EFFECT:Think()
    if self:GetVelocity():Length() > 0 then self.SpawnTime = CurTime() end
    self:StopSound("Default.ScrapeRough")

    if (self.SpawnTime + self.ShellTime) <= CurTime() then
        if !IsValid(self) then return end
        self:SetRenderFX( kRenderFxFadeFast )
        if (self.SpawnTime + self.ShellTime + 0.25) <= CurTime() then
            if !IsValid(self:GetPhysicsObject()) then return end
            self:GetPhysicsObject():EnableMotion(false)
            if (self.SpawnTime + self.ShellTime + 0.5) <= CurTime() then
                self:Remove()
                return
            end
        end
    end
    return true
end

function EFFECT:Render()
    if !IsValid(self) then return end

    self:DrawModel()
end

function EFFECT:DrawTranslucent()
    if !IsValid(self) then return end

    self:DrawModel()
end
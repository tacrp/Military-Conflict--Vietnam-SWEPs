// One bullet impact, in the game's own art for the surface that was hit. The family travels as
// an index into MCV.ImpactFamilies (mcv/shared/sh_impacts.lua) and the variant is picked here,
// since which of the three plays is nobody's business but the viewer's.
//
// Getting these to face the right way is the whole job. The children put their debris, mist,
// smoke and sparks out along the local X of a control point, nearly all of them reading point 1
// and a few reading point 0, so both points have to be turned to face along the surface normal.
// Two things get in the way of that:
//
//   * the angle handed to ParticleEffect only ever reaches point 0, so point 1 keeps the world
//     axes and almost everything sprays the same way whatever was hit, and
//   * the control point calls are dropped on a system with no valid owner entity, which is
//     exactly what CreateParticleSystemNoEntity leaves you holding.
//
// So the effect itself stands in as the owner. It is an entity, it sits at the hit turned to
// face along the normal, and the system is created on it the way the muzzle flash is created on
// the viewmodel (mcv_base/sh_effects.lua), which is the one oriented particle in this addon
// that has always come out right.

// long enough for the slowest child to finish: the 3d debris lives up to 2.5 seconds
local LIFETIME = 4

function EFFECT:Init(data)
    local family = MCV.ImpactFamilies[data:GetFlags()]
    if !family then return end

    local pos = data:GetOrigin()
    local normal = data:GetNormal()
    if !normal or normal:LengthSqr() < 0.5 then normal = vector_up end

    local ang = normal:Angle()

    self:SetPos(pos)
    self:SetAngles(ang)

    local ps = CreateParticleSystem(self, "impact_" .. family .. "_" .. math.random(3),
                                    PATTACH_ABSORIGIN_FOLLOW, 0)
    if !IsValid(ps) then return end

    local forward, right, up = ang:Forward(), ang:Right(), ang:Up()
    for cp = 0, 1 do
        ps:SetControlPoint(cp, pos)
        ps:SetControlPointOrientation(cp, forward, right, up)
    end

    ps:StartEmission()

    self.DieTime = CurTime() + LIFETIME
end

// the owner has to outlive the particles it carries
function EFFECT:Think()
    return self.DieTime != nil and CurTime() < self.DieTime
end

function EFFECT:Render() end

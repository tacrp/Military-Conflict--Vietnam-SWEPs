// Scope picture.
//
// The world is rendered a second time from the scope's own camera - the viewmodel's "cam"
// attachment, which the game's animations drive and which sways with the gun - at the game's
// ScopeLensFov, into a square render target that the lens submaterial displays. The screen
// itself keeps the ironsight FOV, so the picture is rigid relative to the scope body (the old
// version copied a crop of the zoomed screen onto the lens and slid around whenever the gun
// moved). The reticle is drawn over the picture, then a scope shadow whose position follows
// the eye's misalignment against the scope axis.
local rtsize = math.min(1024, ScrW(), ScrH())

// scene at the scope FOV plus the reticle. With its own depth/stencil buffer: the nested view
// needs depth, and the Lua shadow fallback masks with the stencil.
local CLAMP_ST = 4 + 8 // TEXTUREFLAGS_CLAMPS + TEXTUREFLAGS_CLAMPT (no globals for these)
local rtmat = GetRenderTargetEx("mcv_pipscope", rtsize, rtsize, RT_SIZE_NO_CHANGE, MATERIAL_RT_DEPTH_SEPARATE,
    CLAMP_ST, 0, IMAGE_FORMAT_BGRA8888)
// the same after the lens shader pass; this is what the lens shows
local rtlens = GetRenderTargetEx("mcv_pipscope_lens", rtsize, rtsize, RT_SIZE_NO_CHANGE, MATERIAL_RT_DEPTH_NONE,
    CLAMP_ST, 0, IMAGE_FORMAT_BGRA8888)

// Lens pass: custom pixel shader (work/shaders/mcv_lens_ps2x.hlsl, materials/mcv/lens_pass.vmt)
// that turns the flat picture into what an eye sees through an eyepiece: barrel distortion,
// chromatic aberration and blur towards the edge, a bright exit pupil that slides against the
// sway, the dark rim of the tube. When the shader is missing (Linux without DXVK, an
// uncompiled checkout) the picture is used as is and the Lua stencil shadow stands in.
SWEP.ScopePassMaterial = "mcv/lens_pass"

local pass_cache = {}
local function passMaterial(name)
    local m = pass_cache[name]
    if m == nil then
        m = Material(name)
        if m:IsError() then m = false else m:SetTexture("$basetexture", rtmat) end
        pass_cache[name] = m
    end
    return m
end

// Lens material fed by the render target. SetSubMaterial takes the "!" prefixed name of a
// material made with CreateMaterial.
// A faint cubemap reflection over the picture reads as glass instead of a screen.
local lensmat = CreateMaterial("mcv_pipscope_lens", "UnlitGeneric", {
    ["$basetexture"] = rtlens:GetName(),
    ["$nolod"] = "1",
    ["$envmap"] = "env_cubemap",
    ["$envmaptint"] = "[0.12 0.12 0.12]",
})
lensmat:SetTexture("$basetexture", rtlens)
local LENS_NAME = "!" .. lensmat:GetName()

// Render target orientation relative to the lens mesh; flip per weapon if a model needs it.
SWEP.RTScopeFlipV = false
SWEP.RTScopeFlipH = false
// Reticle textures in materials/models/weapons/mcv/optics have their alpha inverted on disk
// (work/vtf_invert_alpha.py, applied by the rip step): opaque on the crosshair lines, which is
// what the plain draw below paints black. Leave this false unless a texture was dropped in
// straight from the game.
SWEP.ReticleInvertAlpha = false

// Scope shadow: the bright exit pupil and the dark ring around it. Diameter of the clear
// picture as a fraction of the lens when the scope is on the eye line, how far the pupil
// slides per radian the sway turns the scope off that line (fraction of the lens), softness of
// its edge. 0 strength disables it.
SWEP.ScopeShadowStrength = 1
SWEP.ScopeShadowSize = 0.84
SWEP.ScopeShadowScale = 14
SWEP.ScopeShadowSoftness = 0.1
// Lens shader look: barrel distortion (negative pulls the edge in), chromatic aberration and
// edge blur in lens widths, picture brightness.
SWEP.ScopeDistortion = -0.12
SWEP.ScopeAberration = 0.006
SWEP.ScopeEdgeBlur = 0.02
SWEP.ScopeBrightness = 1

// The reticle texture behind a ScopeMaterial. The game's crosshair_* VMTs are model materials
// (some of them Refract lens shaders that paint black when drawn in 2D), so the render target
// gets its own plain translucent material on the same texture.
local function reticleTexture(mat)
    local tex = mat:GetString("$refracttinttexture")
    if !tex or tex == "" or tex:find("_rt_") then tex = mat:GetString("$basetexture") end
    return tex
end

local reticle_cache = {}

local function reticleDraw(mat)
    local name = mat:GetName()
    if reticle_cache[name] then return reticle_cache[name] end

    local m = CreateMaterial("mcv_reticle_" .. name:gsub("[^%w]", "_"), "UnlitGeneric", {
        ["$basetexture"] = reticleTexture(mat),
        ["$translucent"] = "1",
        ["$vertexcolor"] = "1",
        ["$vertexalpha"] = "1",
    })
    reticle_cache[name] = m

    return m
end

// Alpha-tested copy, so it can mask the stencil buffer
local mask_cache = {}

local function reticleMask(mat)
    local name = mat:GetName()
    if mask_cache[name] then return mask_cache[name] end

    local m = CreateMaterial("mcv_reticle_mask_" .. name:gsub("[^%w]", "_"), "UnlitGeneric", {
        ["$basetexture"] = reticleTexture(mat),
        ["$alphatest"] = "1",
        ["$alphatestreference"] = "0.5",
        ["$vertexcolor"] = "1",
        ["$vertexalpha"] = "1",
    })
    mask_cache[name] = m

    return m
end

function SWEP:GetScopeFOV()
    if self:GetScopeLevel() == 2 and self.ScopeFOV2 then
        return self.ScopeFOV2
    end
    return self.ScopeFOV
end

function SWEP:ShouldDoScope()
    return self:GetIronsight() and self.HasScope
end

// Where the scope looks from: the eye, turned by the gun's sway. The sway is the muzzle
// attachment's rotation against the eye, read while the viewmodel is set up for drawing
// (PreDrawViewModel, see CaptureScopeSway - outside the viewmodel pass attachments come back
// in an undefined frame). In the aimed rest pose the gun's axis coincides with the eye's, so
// walking, recoil and idle motion all read as a small angle.
function SWEP:CaptureScopeSway(vm)
    if !self.HasScope then return end
    local owner = self:GetOwner()
    local id = vm:LookupAttachment("muzzle")
    if id <= 0 then self.ScopeSway = nil return end
    local att = vm:GetAttachment(id)
    if !att then self.ScopeSway = nil return end

    local eyeang = owner:EyeAngles()
    // the attachment's axes are the bone's (rotated 180 around up and a little pitched on
    // most models): pick the ones closest to the eye's forward and up
    local axes = {att.Ang:Forward(), att.Ang:Right(), att.Ang:Up()}
    local function closest(to)
        local best, bestdot = to, 0
        for _, a in ipairs(axes) do
            local d = a:Dot(to)
            if math.abs(d) > math.abs(bestdot) then
                best, bestdot = a, d
            end
        end
        return bestdot < 0 and -best or best
    end
    local fwd = closest(eyeang:Forward())
    local up = closest(eyeang:Up())
    local swayang = fwd:AngleEx(up)

    // relative to the eye, so it survives the eye turning before the next PreRender
    local _, rel = WorldToLocal(vector_origin, swayang, vector_origin, eyeang)
    rel:Normalize()

    // The attachment's own fixed tilt (e.g. the M16 muzzle's "rotate -0.3") and the aimed pose
    // read as a constant; only fast motion (walk bob, recoil, idle breathing) should show.
    // The rest pose follows the reading slowly, so the sway is the reading minus that.
    if self:GetSightAmountVisual() < 0.99 then
        self.ScopeSwayRest = rel
        self.ScopeSway = angle_zero
        return
    end
    local rest = self.ScopeSwayRest or rel
    local t = math.Clamp(FrameTime() * 1.5, 0, 1)
    rest = Angle(rest.p + math.NormalizeAngle(rel.p - rest.p) * t, rest.y + math.NormalizeAngle(rel.y - rest.y) * t, 0)
    self.ScopeSwayRest = rest
    self.ScopeSway = Angle(math.NormalizeAngle(rel.p - rest.p), math.NormalizeAngle(rel.y - rest.y), 0)
end

function SWEP:GetScopeCamera(vm)
    local owner = self:GetOwner()
    local eyepos, eyeang = owner:EyePos(), owner:EyeAngles()
    if !self.ScopeSway then return eyepos, eyeang end
    local _, ang = LocalToWorld(vector_origin, self.ScopeSway, vector_origin, eyeang)
    return eyepos, ang
end

local circle = {}
local function drawCircle(x, y, r)
    local n = 48
    for i = 1, n do
        local a = (i - 1) / n * math.pi * 2
        circle[i] = circle[i] or {}
        circle[i].x = x + math.cos(a) * r
        circle[i].y = y + math.sin(a) * r
    end
    for i = n + 1, #circle do circle[i] = nil end
    surface.DrawPoly(circle)
end

// Soft black ring outside a circle at (cx, cy) with radius r, drawn in the current 2D context.
local function drawShadow(cx, cy, r, strength)
    local steps = 6
    local alpha = 1 - (1 - strength) ^ (1 / steps)

    render.ClearStencil()
    render.SetStencilEnable(true)
    render.SetStencilWriteMask(255)
    render.SetStencilTestMask(255)
    render.SetStencilFailOperation(STENCIL_KEEP)
    render.SetStencilZFailOperation(STENCIL_KEEP)

    for i = 1, steps do
        render.SetStencilReferenceValue(i)
        render.SetStencilCompareFunction(STENCIL_ALWAYS)
        render.SetStencilPassOperation(STENCIL_REPLACE)
        render.OverrideColorWriteEnable(true, false)
        draw.NoTexture()
        surface.SetDrawColor(255, 255, 255, 255)
        drawCircle(cx, cy, r * (1 + (i - 1) * 0.08))
        render.OverrideColorWriteEnable(false)

        // black outside this circle; every step darkens the ring beyond its own radius
        render.SetStencilCompareFunction(STENCIL_NOTEQUAL)
        render.SetStencilPassOperation(STENCIL_KEEP)
        surface.SetDrawColor(0, 0, 0, alpha * 255)
        surface.DrawRect(-rtsize, -rtsize, rtsize * 3, rtsize * 3)
    end

    render.SetStencilEnable(false)
end

// Runs from PreRender (lua/mcv/client/cl_rendertarget.lua), before the frame's own scene. The
// viewmodel's bones are those of the previous frame at that point; one frame of lag on the
// sway is not visible.
function SWEP:RenderScopeView()
    if self.RenderingScopeView then return end
    if !self:ShouldDoScope() or !self.ScopeMaterial then return end

    local owner = self:GetOwner()
    local vm = IsValid(owner) and owner:GetViewModel()
    if !IsValid(vm) then return end

    local campos, camang = self:GetScopeCamera(vm)

    self.RenderingScopeView = true
    // HDR maps scale everything drawn through a material by the tone map scale; the picture
    // is meant as it is
    local tonemap = render.GetToneMappingScaleLinear()
    render.SetToneMappingScaleLinear(Vector(1, 1, 1))
    render.PushRenderTarget(rtmat, 0, 0, rtsize, rtsize)
        render.Clear(0, 0, 0, 255, true, true)
        render.RenderView({
            origin = campos,
            angles = camang,
            x = 0, y = 0, w = rtsize, h = rtsize,
            aspectratio = 1,
            fov = self:GetScopeFOV(),
            drawviewmodel = false,
            drawhud = false,
            drawmonitors = false,
            dopostprocess = false,
        })

        cam.Start2D()
            local reticle = self.ScopeMaterial
            local u0, v0, u1, v1 = 0, 0, 1, 1
            if self.RTScopeFlipV then v0, v1 = 1, 0 end
            if self.RTScopeFlipH then u0, u1 = 1, 0 end

            if self.ReticleInvertAlpha then
                // Mark the opaque part of the texture (the glass) in the stencil, then paint
                // black everywhere else inside the lens: the crosshair lines.
                render.ClearStencil()
                render.SetStencilEnable(true)
                render.SetStencilWriteMask(255)
                render.SetStencilTestMask(255)
                render.SetStencilReferenceValue(1)
                render.SetStencilCompareFunction(STENCIL_ALWAYS)
                render.SetStencilPassOperation(STENCIL_REPLACE)
                render.SetStencilFailOperation(STENCIL_KEEP)
                render.SetStencilZFailOperation(STENCIL_KEEP)

                render.OverrideColorWriteEnable(true, false)
                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(reticleMask(reticle))
                surface.DrawTexturedRectUV(0, 0, rtsize, rtsize, u0, v0, u1, v1)
                render.OverrideColorWriteEnable(false)

                render.SetStencilCompareFunction(STENCIL_NOTEQUAL)
                render.SetStencilPassOperation(STENCIL_KEEP)
                surface.SetDrawColor(0, 0, 0, 255)
                surface.DrawRect(0, 0, rtsize, rtsize)

                render.SetStencilEnable(false)
            else
                surface.SetDrawColor(0, 0, 0, 255)
                surface.SetMaterial(reticleDraw(reticle))
                surface.DrawTexturedRectUV(0, 0, rtsize, rtsize, u0, v0, u1, v1)
            end

            // the sway turns the scope away from the eye line; the bright exit pupil slides
            // against that turn (scope yaws left, picture moves right). In lens widths.
            local sway = self.ScopeSway or angle_zero
            local dx = -math.rad(math.NormalizeAngle(sway.y)) * self.ScopeShadowScale * (self.RTScopeFlipH and -1 or 1)
            local dy = -math.rad(math.NormalizeAngle(sway.p)) * self.ScopeShadowScale * (self.RTScopeFlipV and -1 or 1)

            local passmat = passMaterial(self.ScopePassMaterial)
            if !passmat and self.ScopeShadowStrength > 0 then
                drawShadow(rtsize * (0.5 + dx), rtsize * (0.5 + dy), rtsize / 2 * self.ScopeShadowSize, self.ScopeShadowStrength)
            end
        cam.End2D()
    render.PopRenderTarget()

    if passmat then
        local strength = self.ScopeShadowStrength
        // pupil radius past the lens when the shadow is off
        local radius = strength > 0 and self.ScopeShadowSize / 2 or 2
        passmat:SetFloat("$c0_x", 0.5 + dx)
        passmat:SetFloat("$c0_y", 0.5 + dy)
        passmat:SetFloat("$c0_z", radius)
        passmat:SetFloat("$c0_w", self.ScopeShadowSoftness)
        passmat:SetFloat("$c1_x", self.ScopeDistortion)
        passmat:SetFloat("$c1_y", self.ScopeAberration)
        passmat:SetFloat("$c1_z", self.ScopeEdgeBlur)
        passmat:SetFloat("$c1_w", strength > 0 and 0.49 or 2)
        // the tube rim follows a third of the sway
        passmat:SetFloat("$c2_x", 0.5 + dx * 0.3)
        passmat:SetFloat("$c2_y", 0.5 + dy * 0.3)
        passmat:SetFloat("$c2_z", 0.05)
        passmat:SetFloat("$c2_w", self.ScopeBrightness)

        // The one draw that reaches the pixel shader with the quad's texture coordinates:
        // render.DrawScreenQuad through a material with $vertextransform 1 and the addon's own
        // vertex shader (mcv_pass_vs20). surface draws hand the shader a constant coordinate,
        // and the stock vertex shader hands it zero.
        render.PushRenderTarget(rtlens, 0, 0, rtsize, rtsize)
            render.SetMaterial(passmat)
            render.DrawScreenQuad()
        render.PopRenderTarget()
    else
        // no shader: the lens shows the picture as drawn
        render.CopyTexture(rtmat, rtlens)
    end
    render.SetToneMappingScaleLinear(tonemap)
    self.RenderingScopeView = false
end

// Swaps the lens submaterial for the render target while aiming; runs from PreDrawViewModel.
function SWEP:DoRTScope()
    if !self.HasScope then return end

    local active = self:GetSightAmountVisual() > 0.5
    local model = self:GetOwner():GetViewModel()
    self:CaptureScopeSway(model)

    if active and self:ShouldDoScope() then
        self.RenderingRTScope = true
        render.SetToneMappingScaleLinear(Vector(1, 1, 1))
        model:SetSubMaterial(self.RTScopeMaterialIndex, LENS_NAME)
    else
        // Not aiming: the model's own lens material (the game's glass with its reflections)
        model:SetSubMaterial(self.RTScopeMaterialIndex)
    end
end

// Kept for callers that still poke the old screen-copy path.
function SWEP:DoCheapScope() end

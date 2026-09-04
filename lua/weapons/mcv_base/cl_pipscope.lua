local rtsize = math.min(1024, ScrW(), ScrH())

local rtmat = GetRenderTarget("mcv_pipscope", rtsize, rtsize, false)

// Lens material fed by the render target (no ARC9 dependency). SetSubMaterial takes the
// "!" prefixed name of a material made with CreateMaterial.
local lensmat = CreateMaterial("mcv_pipscope_lens", "UnlitGeneric", {
    ["$basetexture"] = rtmat:GetName(),
    ["$nolod"] = "1",
})
lensmat:SetTexture("$basetexture", rtmat)
local LENS_NAME = "!" .. lensmat:GetName()

// The screen, as a material, so it can be drawn into the RT with flipped UVs
local screenmat = CreateMaterial("mcv_pipscope_screen", "UnlitGeneric", {
    ["$basetexture"] = "_rt_FullFrameFB",
})

// Render target orientation relative to the lens mesh; flip per weapon if a model needs it.
SWEP.RTScopeFlipV = false
SWEP.RTScopeFlipH = false
// Reticle textures in materials/models/weapons/mcv/optics have their alpha inverted on disk
// (work/vtf_invert_alpha.py, applied by the rip step): opaque on the crosshair lines, which is
// what the plain draw below paints black. Leave this false unless a texture was dropped in
// straight from the game.
SWEP.ReticleInvertAlpha = false

// Alpha-tested copy of the reticle material, so it can mask the stencil buffer
local reticle_cache = {}

local function reticleMask(mat)
    local name = mat:GetName()
    if reticle_cache[name] then return reticle_cache[name] end

    local m = CreateMaterial("mcv_reticle_mask_" .. name:gsub("[^%w]", "_"), "UnlitGeneric", {
        ["$basetexture"] = mat:GetString("$basetexture"),
        ["$alphatest"] = "1",
        ["$alphatestreference"] = "0.5",
        ["$vertexcolor"] = "1",
        ["$vertexalpha"] = "1",
    })
    reticle_cache[name] = m

    return m
end
// Magnification of the picture-in-picture image relative to the screen
SWEP.RTScopeZoom = 2.5

function SWEP:GetScopeFOV()
    return self.ScopeFOV
end

function SWEP:ShouldDoScope()
    return self:GetIronsight() and self.HasScope
end

local rt_cleared = false

function SWEP:DoCheapScope()
    if !self:ShouldDoScope() then
        // Only clear once after leaving the scope instead of every frame.
        if !rt_cleared then
            render.PushRenderTarget(rtmat, 0, 0, rtsize, rtsize)
            render.Clear(0, 0, 0, 255, true, true)
            render.PopRenderTarget()
            rt_cleared = true
        end

        return
    end

    rt_cleared = false

    render.UpdateScreenEffectTexture()
    screenmat:SetTexture("$basetexture", render.GetScreenEffectTexture())

    // Draw the screen into the square RT so that a *square* crop of the screen (side
    // ScrH / zoom, centred) fills it. Circles on screen stay circles on the lens.
    local scrw, scrh = ScrW(), ScrH()
    local scale = rtsize * self.RTScopeZoom / scrh
    local w, h = scrw * scale, scrh * scale
    local x, y = (rtsize - w) / 2, (rtsize - h) / 2

    local u0, v0, u1, v1 = 0, 0, 1, 1
    if self.RTScopeFlipV then v0, v1 = 1, 0 end
    if self.RTScopeFlipH then u0, u1 = 1, 0 end

    render.PushRenderTarget(rtmat, 0, 0, rtsize, rtsize)
    cam.Start2D()
        surface.SetMaterial(screenmat)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.DrawTexturedRectUV(x, y, w, h, u0, v0, u1, v1)
    cam.End2D()
    render.PopRenderTarget()
end

function SWEP:DoRTScope()
    if !self.HasScope then return end

    local active = self:GetSightAmountVisual() > 0.5
    local model = self:GetOwner():GetViewModel()

    if active then
        if self:ShouldDoScope() then
            self.RenderingRTScope = true

            local reticle = self.ScopeMaterial

            if reticle then
                render.PushRenderTarget(rtmat)
                cam.Start2D()
                    local size = rtsize
                    local rtr_x = (rtsize - size) / 2
                    local rtr_y = (rtsize - size) / 2

                    surface.SetDrawColor(0, 0, 0)
                    surface.DrawRect(rtr_x - size * 4, rtr_y - size * 8, size * 8, size * 8) -- top
                    surface.DrawRect(rtr_x - size * 8, rtr_y - size * 4, size * 8, size * 8) -- left
                    surface.DrawRect(rtr_x - size * 4, rtr_y + size - 1, size * 8, size * 8) -- bottom
                    surface.DrawRect(rtr_x + size - 1, rtr_y - size * 4, size * 8, size * 8) -- right

                    if self.ReticleInvertAlpha then
                        // Mark the opaque part of the texture (the glass) in the stencil, then
                        // paint black everywhere else inside the lens: the crosshair lines.
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
                        surface.DrawTexturedRect(rtr_x, rtr_y, size, size)
                        render.OverrideColorWriteEnable(false)

                        render.SetStencilCompareFunction(STENCIL_NOTEQUAL)
                        render.SetStencilPassOperation(STENCIL_KEEP)
                        surface.SetDrawColor(0, 0, 0, 255)
                        surface.DrawRect(rtr_x, rtr_y, size, size)

                        render.SetStencilEnable(false)
                    else
                        surface.SetDrawColor(0, 0, 0)
                        surface.SetMaterial(reticle)
                        surface.DrawTexturedRect(rtr_x, rtr_y, size, size)
                    end
                cam.End2D()
                render.PopRenderTarget()
            end
        end

        render.SetToneMappingScaleLinear(Vector(1, 1, 1))

        model:SetSubMaterial(self.RTScopeMaterialIndex, LENS_NAME)
    else
        // Not aiming: the model's own lens material (the game's glass with its reflections)
        model:SetSubMaterial(self.RTScopeMaterialIndex)
    end
end

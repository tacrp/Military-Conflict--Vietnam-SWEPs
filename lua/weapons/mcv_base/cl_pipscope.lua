local rtsize = math.min(1024, ScrW(), ScrH())

local rtmat = GetRenderTarget("mcv_pipscope", rtsize, rtsize, false)
local rtmat_spare = GetRenderTarget("mcv_rtmat_spare", ScrW(), ScrH(), false)
local rtsurf = Material("effects/arc9/rt")

function SWEP:GetScopeFOV()
    return self.ScopeFOV
end

function SWEP:ShouldDoScope()
    return self:GetIronsight() and self.HasScope
end

function SWEP:DoCheapScope(fov, atttbl)
    if !self:ShouldDoScope() then
        render.PushRenderTarget(rtmat, 0, 0, rtsize, rtsize)
        render.Clear(0, 0, 0, 255, true, true)
        render.PopRenderTarget()

        return
    end

    render.UpdateScreenEffectTexture()
    render.UpdateFullScreenDepthTexture()
    local screen = render.GetScreenEffectTexture()

    render.CopyTexture( screen, rtmat_spare )

    local scrw = ScrW()
    local scrh = ScrH()

    scrw = scrw
    scrh = scrh * scrh / scrw

    local s = 2.5

    local scrx = (ScrW() - scrw * s) / 2
    local scry = (ScrH() - scrh * s) / 2

    render.PushRenderTarget(rtmat, 0, 0, rtsize, rtsize)

    render.DrawTextureToScreenRect(screen, scrx, scry, scrw * s, scrh * s)

    render.PopRenderTarget()

    render.DrawTextureToScreen(rtmat_spare)
    render.UpdateFullScreenDepthTexture()
end

function SWEP:DoRTScope()
    if !self.HasScope then return end

    local active = self:GetSightAmount() > 0.5
    local model = self:GetOwner():GetViewModel()

    if active then
        if self:ShouldDoScope() then
            self.RenderingRTScope = true
            render.PushRenderTarget(rtmat)
            cam.Start2D()

            local reticle = self.ScopeMaterial
            local color = Color(0, 0, 0)

            local size = rtsize
            if reticle then
                local rtr_x = (rtsize - size) / 2
                local rtr_y = (rtsize - size) / 2

                surface.SetDrawColor(0, 0, 0)
                surface.DrawRect(rtr_x - size * 4, rtr_y - size * 8, size * 8, size * 8) -- top
                surface.DrawRect(rtr_x - size * 8, rtr_y - size * 4, size * 8, size * 8) -- left
                surface.DrawRect(rtr_x - size * 4, rtr_y + size - 1, size * 8, size * 8) -- bottom
                surface.DrawRect(rtr_x + size - 1, rtr_y - size * 4, size * 8, size * 8) -- right

                surface.SetDrawColor(color)
                surface.SetMaterial(reticle)
                surface.DrawTexturedRect(rtr_x, rtr_y, size, size)
            end
        else
            render.PushRenderTarget(rtmat)
            cam.Start2D()
        end

        cam.End2D()

        render.PopRenderTarget()

        render.SetToneMappingScaleLinear(Vector(1, 1, 1))

        rtsurf:SetTexture("$basetexture", rtmat)

        model:SetSubMaterial()

        model:SetSubMaterial(self.RTScopeMaterialIndex, "effects/arc9/rt")
    else
        rtsurf:SetTexture("$basetexture", "vgui/black")
        model:SetSubMaterial(self.RTScopeMaterialIndex, "vgui/black")
    end
end
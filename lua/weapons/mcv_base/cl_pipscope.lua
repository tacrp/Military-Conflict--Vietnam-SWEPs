local rtsize = math.min(1024, ScrW(), ScrH())

local rtmat = GetRenderTarget("mcv_pipscope", rtsize, rtsize, false)
local rtmat_spare = GetRenderTarget("mcv_rtmat_spare", ScrW(), ScrH(), false)


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

    local s = 0.8

    local scrx = (ScrW() - scrw * s) / 2
    local scry = (ScrH() - scrh * s) / 2

    render.PushRenderTarget(rtmat, 0, 0, rtsize, rtsize)

    -- cam.Start2D()

    render.DrawTextureToScreenRect(screen, scrx, scry, scrw * s, scrh * s)
    -- render.DrawTextureToScreenRect(ITexture tex, number x, number y, number width, number height)
    -- cam.End2D()

    render.PopRenderTarget()

    render.DrawTextureToScreen(rtmat_spare)
    render.UpdateFullScreenDepthTexture()
end
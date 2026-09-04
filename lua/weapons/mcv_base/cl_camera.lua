SWEP.SmoothedMagnification = 1

function SWEP:CalcView(ply, pos, ang, fov)
    local rec = (self:GetLastRecoilTime() + self.ShakeDuration) - CurTime()

    rec = math.max(rec, 0) * self.ShakeScale

    if rec > 0 then
        ang.r = ang.r + (math.sin(CurTime() * self.ShakeFreq) * rec)
    end

    local mag = Lerp(self:GetSightAmountVisual() ^ 3, 1, 90 / self:GetZoomMagnification())

    local diff = math.abs(self.SmoothedMagnification - mag)

    self.SmoothedMagnification = math.Approach(self.SmoothedMagnification, mag, FrameTime() * diff * (self.SmoothedMagnification > mag and 10 or 5))

    fov = fov / self.SmoothedMagnification

    self.LastFOV = fov

    fov = fov - rec

    return pos, ang, fov
end

function SWEP:GetZoomMagnification()
    if self.HasScope then
        if self:GetScopeLevel() == 2 then
            return self.ScopeFOV2
        else
            return self.ScopeFOV
        end
    else
        return self.IronsightFov
    end
end

function SWEP:AdjustMouseSensitivity()
    return 1 / self.SmoothedMagnification
end
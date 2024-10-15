function SWEP:Think()
    local owner = self:GetOwner()
    local vm = owner:GetViewModel()

    self:Think_Sights()
    self:Think_Reload()
    self:Think_Speed()

    self:ProcessTimers()

    self:DoBodygroups()

    if self:GetNextIdle() <= CurTime() then
        self:Idle()
    end

    if owner:KeyReleased(IN_ATTACK) then
        self:SetNeedTriggerPress(false)
    elseif self:GetReloading() and self.ShotgunReload and owner:KeyPressed(IN_ATTACK) and self:Clip1() > 0 then
        self:SetEndReload(true)
    end

    if owner:KeyPressed(IN_USE) and owner:KeyDown(IN_WALK) then
        self:ToggleUBGL()
    end

    if !owner:KeyDown(IN_ATTACK) and self:GetNeedCycle() and IsFirstTimePredicted() then
        local cyclespeed = self.CycleSpeed
        local cycledelay = self.CyclePostDelay
        local t = self:PlayAnimation(ACT_VM_RELOAD_INSERT_PULL, cyclespeed, false)
        self:SetNextPrimaryFire(CurTime() + t * cycledelay)
        self:SetNeedCycle(false)
    end

    if IsValid(self.MuzzleLight) then
        if (self.MuzzleLightEnd or 0) < UnPredictedCurTime() then
            self.MuzzleLight:Remove()
            self.MuzzleLight = nil
        else
            local att = vm:GetAttachment(1)
            self.MuzzleLight:SetPos(att.Pos)
            self.MuzzleLight:SetAngles(att.Ang)
            self.MuzzleLight:Update()
        end
    end
end

function SWEP:GetIsSprinting()
    local owner = self:GetOwner()

    if (owner:KeyDown(IN_FORWARD) or owner:KeyDown(IN_MOVERIGHT) or owner:KeyDown(IN_MOVELEFT) or owner:KeyDown(IN_BACK)) and owner:KeyDown(IN_SPEED) then
        return true
    else
        return false
    end
end

function SWEP:Think_Speed()
    local target_speed = 0

    local speed = self:GetSpeed()

    local owner = self:GetOwner()

    if !owner:IsOnGround() then
        target_speed = 0
    else
        if owner:KeyDown(IN_FORWARD) or owner:KeyDown(IN_MOVERIGHT) or owner:KeyDown(IN_MOVELEFT) or owner:KeyDown(IN_BACK) then
            if owner:KeyDown(IN_SPEED) then
                target_speed = 273
            elseif owner:KeyDown(IN_WALK) then
                target_speed = 25
            else
                target_speed = 100
            end
        end
    end

    speed = math.Approach(speed, target_speed, FrameTime() * 750)

    self:SetSpeed(speed)
end
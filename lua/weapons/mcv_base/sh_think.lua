// Gun-specific per-tick work; the shared part (movement, hold type, timers, idle) runs in
// mcv_base_core/sh_think.lua before this.
function SWEP:ThinkWeapon()
    local owner = self:GetOwner()

    self:Think_Sights()
    self:Think_Reload()
    self:Think_Bipod()

    // runaway burst: the remaining rounds go out on their own, trigger or not
    if self:GetBurstLeft() > 0 and !self:StillWaiting() then
        if self:GetFiremodeValue() == MCV.FIREMODE_BURST and self:Clip1() > 0 and !self:GetReloading() then
            self:PrimaryAttack()
        else
            self:SetBurstLeft(0)
        end
    end

    if owner:KeyReleased(IN_ATTACK) then
        // the trigger-press flag clears, but not a burst in progress
        self:SetNeedTriggerPress(false)
        self:SetBurstCount(0)

        if self:GetPrimedAttack() then
            self:PlayAnimation(ACT_VM_IDLE)
            self:SetPrimedAttack(false)
        end
    elseif self:GetReloading() and self.ShotgunReload and owner:KeyPressed(IN_ATTACK) and self:Clip1() > 0 then
        self:SetEndReload(true)
    end

    if owner:KeyPressed(IN_USE) and owner:KeyDown(IN_WALK) then
        self:ToggleUBGL()
    end

    if owner:KeyDown(IN_ATTACK) and self:GetPrimedAttack() and self:GetLastTriggerTime() + self.TriggerDelayTime < CurTime() then
        if SERVER or !game.SinglePlayer() then
            self:AttackEffects()
            if self.ShootEntity then
                self:RocketAttack()
            else
                self:BulletAttack()
            end
            self:SetPrimedAttack(false)
            if self:GetAkimbo() and self:Clip1() % 2 == 0 then
                self:PlayAnimation(ACT_VM_PRIMARYATTACK_3, 0.5)
            else
                self:PlayAnimation(ACT_VM_PRIMARYATTACK_2, 0.5)
            end
        end
    end

    // the cycle waits for the trigger to be released, except on slam-firing shotguns (M1897,
    // M37): they pump with the trigger held and fire the moment the action closes
    if !self:StillWaiting() and (!owner:KeyDown(IN_ATTACK) or self.SlamFire) and self:GetNeedCycle() and IsFirstTimePredicted() then
        local t = self:PlayAnimation(ACT_VM_RELOAD_INSERT_PULL, self.CycleSpeed, false)
        self:SetNextPrimaryFire(CurTime() + t * self.CyclePostDelay)

        if !self.AnimationHandlesHammer then
            self:SetNeedCycle(false)
        end
    end
end

function SWEP:Deploy()
    self:GetOwner():SetSaveValue("m_flNextAttack", 0)

    if !self:GetReady() and self:HasAnimation(ACT_VM_READY) then
        self:PlayAnimation(ACT_VM_READY, 1, true)
        self:SetReady(true)
    else
        self:DeployAnimation()
        self:SetReady(true)
    end

    self:SetIronsight(false)
    self:SetActionState(0)
    self:SetActionStart(0)

    self:OnDeploy()

    return true
end

function SWEP:ClientHolster()
    if game.SinglePlayer() then
        self:CallOnClient("ClientHolster")
    end

    if SERVER then return end

    local vm = self:GetOwner():GetViewModel()

    vm:SetSubMaterial()
    vm:SetMaterial()
end

function SWEP:Holster(wep)
    if game.SinglePlayer() and CLIENT then return end

    if CLIENT and self:GetOwner() != LocalPlayer() then return end

    if self:GetOwner():IsNPC() then
        return
    end

    if self:GetReloading() then
        self:SetReloading(false)
    end

    if self:GetHolsterTime() > CurTime() then return false end

    if (self:GetHolsterTime() != 0 and self:GetHolsterTime() <= CurTime()) or !IsValid(wep) then
        -- Do the final holster request
        -- Picking up props try to switch to NULL, by the way
        self:SetHolsterTime(0)
        self:SetHolsterEntity(NULL)

        local vm = self:GetOwner():GetViewModel()

        vm:SetBodyGroups("000000000000000000000")

        self:ClientHolster()

        return true
    else
        local t = self:PlayAnimation(ACT_VM_HOLSTER, 1, true, true)
        self:SetHolsterTime(CurTime() + (t or 0))
        self:SetHolsterEntity(wep)

        self:SetIronsight(false)
        self:SetActionState(0)

        self:GetOwner():DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM)
    end
end

hook.Add("StartCommand", "MCV_Holster", function(ply, ucmd)
    local wep = ply:GetActiveWeapon()

    if IsValid(wep) and wep.MilitaryConflictVietnam then
        if wep:GetHolsterTime() != 0 and wep:GetHolsterTime() - wep:GetPingOffsetScale() <= CurTime() then
            if IsValid(wep:GetHolsterEntity()) then
                wep:SetHolsterTime(-1)
                ucmd:SelectWeapon(wep:GetHolsterEntity()) -- Call the final holster request
            end
        end
    end
end)

function SWEP:Initialize()
    // Per-instance state. The class-level defaults in sh_timers / sh_vm are tables shared
    // by every weapon of the class, so they must not be mutated directly.
    self.ActiveTimers = {}
    self.PCFs = {}
    self.ActiveEffects = {}

    for _, p in ipairs(self:GetPrecacheParticles()) do
        if p and p != "" then
            PrecacheParticleSystem(p)
        end
    end
end

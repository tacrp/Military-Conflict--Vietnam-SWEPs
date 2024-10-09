function SWEP:Deploy()
    if !self:GetReady() then
        self:PlayAnimation(ACT_VM_READY, 1, true)
        self:SetReady(true)
    else
        self:PlayAnimation(ACT_VM_DRAW, 1, true)
    end

    self:SetIronsight(false)

    return true
end


local v0 = Vector(0, 0, 0)
local v1 = Vector(1, 1, 1)
local a0 = Angle(0, 0, 0)

function SWEP:ClientHolster()
    if game.SinglePlayer() then
        self:CallOnClient("ClientHolster")
    end

    local vm = self:GetVM()
    if IsValid(vm) then
        vm:SetSubMaterial()
        vm:SetMaterial()

        for i = 0, vm:GetBoneCount() do
            vm:ManipulateBoneScale(i, v1)
            vm:ManipulateBoneAngles(i, a0)
            vm:ManipulateBonePosition(i, v0)
        end
    end
end

function SWEP:Holster(wep)
    if game.SinglePlayer() and CLIENT then return end

    if CLIENT and self:GetOwner() != LocalPlayer() then return end

    if self:GetOwner():IsNPC() then
        return
    end

    self:SetCustomize(false)

    if self:GetReloading() then
        if self:GetValue("ShotgunReload") then
            self:SetEndReload(false)
            self:SetReloading(false)
            self:KillTimer("ShotgunRestoreClip")
        else
            self:CancelReload(false)
        end
    end


    if self:GetHolsterTime() > CurTime() then return false end -- or self:GetPrimedGrenade()

    if !MCV.ConVars["holster"]:GetBool() or (self:GetHolsterTime() != 0 and self:GetHolsterTime() <= CurTime()) or !IsValid(wep) then
        -- Do the final holster request
        -- Picking up props try to switch to NULL, by the way
        self:SetHolsterTime(0)
        self:SetHolsterEntity(NULL)
        self:SetReloadFinishTime(0)

        local holster = self:GetValue("HolsterVisible")
        if SERVER and holster then
            net.Start("MCV_updateholster")
                net.WriteEntity(self:GetOwner())
                net.WriteEntity(self)
            net.Broadcast()
        end

        if game.SinglePlayer() then
            self:CallOnClient("KillModel")
        else
            if CLIENT then
                self:RemoveCustomizeHUD()
                self:KillModel()
            end
        end

        if self.PreviousZoom then
            self:GetOwner():SetCanZoom(true)
        end

        self:ClientHolster()

        return true
    else
        local reverse = 1
        local anim = "holster"

        if self:GetValue("NoHolsterAnimation") then
            anim = "deploy"
            reverse = -1
        end

        local animation = self:PlayAnimation(anim, self:GetValue("HolsterTimeMult") * reverse, true, true)
        self:SetHolsterTime(CurTime() + (animation or 0))
        self:SetHolsterEntity(wep)

        self:SetIronsight(false)

        self:GetOwner():DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM)
        self:SetShouldHoldType()

    end
end

local holsteranticrash = false

hook.Add("StartCommand", "MCV_Holster", function(ply, ucmd)
    local wep = ply:GetActiveWeapon()

    if IsValid(wep) and wep.ArcticMCV and wep:GetHolsterTime() != 0 and wep:GetHolsterTime() - wep:GetPingOffsetScale() <= CurTime() and IsValid(wep:GetHolsterEntity()) then
        wep:SetHolsterTime(-math.huge) -- Pretty much force it to work
        if !holsteranticrash then
            holsteranticrash = true
            ucmd:SelectWeapon(wep:GetHolsterEntity()) -- Call the final holster request
            holsteranticrash = false
        end
    end
end)

function SWEP:Initialize()
    // Precache particles
    PrecacheParticleSystem( self.MuzzleParticle )
    PrecacheParticleSystem( self.MuzzleParticleSmoke )
    PrecacheParticleSystem( self.MuzzleParticleIronsighted )
    PrecacheParticleSystem( self.MuzzleParticleIronsightedSmoke )
    PrecacheParticleSystem( self.MuzzleParticle3rdPerson )
    PrecacheParticleSystem( self.EjectBrassTrail )
    PrecacheParticleSystem( self.EjectBrassParticle )
    PrecacheParticleSystem( self.TracerParticle )
end
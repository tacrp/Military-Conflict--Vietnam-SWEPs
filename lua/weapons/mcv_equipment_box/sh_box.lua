function SWEP:GetFiremodeName()
    return self.BoxKind == "medic" and "Medic Box" or "Ammo Box"
end

function SWEP:GetHUDAmmo()
    return self:GetRoundsLeft(), nil
end

// Give ammo for every MCV gun the target carries, or heal. Returns true when something was given.
function MCV_ApplySupply(kind, target, amount_heal, magazines)
    if !IsValid(target) or !target:IsPlayer() or !target:Alive() then return false end

    if kind == "medic" then
        if target:Health() >= target:GetMaxHealth() then return false end
        target:SetHealth(math.min(target:Health() + amount_heal, target:GetMaxHealth()))
        target:Extinguish()
        return true
    end

    local gave = false
    for _, wep in ipairs(target:GetWeapons()) do
        if !wep.MilitaryConflictVietnam then continue end
        // boxes do not refill boxes (it used to hand itself three more)
        if wep.BoxKind then continue end
        local clip = wep.Primary and wep.Primary.ClipSize or -1
        local ammo = wep:GetPrimaryAmmoType()
        if ammo <= 0 then continue end
        local per = clip > 0 and clip or (wep.Primary.DefaultClip or 1)
        // up to what the gun spawns with (its DefaultClip is clip + reserve), at least a few
        // magazines: with only the magazine rule a fresh gun (M16: 320 in reserve) was always
        // "full" and the box did nothing for it
        local cap = math.max(per * math.max(magazines, 1) * 3, (wep.Primary.DefaultClip or 0) - math.max(clip, 0))
        local have = target:GetAmmoCount(ammo)
        if have < cap then
            target:GiveAmmo(math.min(per * magazines, cap - have), ammo, true)
            gave = true
        end
        if wep.Secondary and wep.Secondary.ClipSize and wep.Secondary.ClipSize > 0 then
            local ammo2 = wep:GetSecondaryAmmoType()
            if ammo2 > 0 and target:GetAmmoCount(ammo2) < 4 then
                target:GiveAmmo(2, ammo2, true)
                gave = true
            end
        end
    end
    return gave
end

function SWEP:GetGiveTarget()
    local owner = self:GetOwner()
    local tr = util.TraceLine({start = owner:GetShootPos(), endpos = owner:GetShootPos() + self:GetAimVector() * self.GiveRange, filter = owner})
    if IsValid(tr.Entity) and tr.Entity:IsPlayer() and tr.Entity:Alive() then
        return tr.Entity
    end
    return nil
end

function SWEP:UseBox(target, seq, delay)
    local t = self:HasSequence(seq) and self:PlaySequence(seq, 1, true) or 0.6
    self:SetNextPrimaryFire(CurTime() + t)
    self:SetNextSecondaryFire(CurTime() + t)

    self:SetTimer(math.min(delay, t), function()
        if !IsValid(self) or !IsValid(target) then return end
        if SERVER then
            if MCV_ApplySupply(self.BoxKind, target, self.HealAmount, self.AmmoMagazines) then
                self:EmitSound(self.BoxKind == "medic" and "items/medshot4.wav" or "items/ammocrate_close.wav", 70)
            else
                self:EmitSound("items/medshotno1.wav", 60)
                return
            end
        end
        self:TakeRound(1)
    end, "mcv_box_use")

    self:SetTimer(t, function()
        if !IsValid(self) then return end
        // the self animation takes the box out of view and ends there: bring it back with the
        // draw animation instead of snapping to the idle
        if seq == self.SequenceSelf and self:HasSequence(self.SequenceDraw) and self:GetRoundsLeft() > 0 then
            self:PlaySequence(self.SequenceDraw, 1, true)
        end
        self:CheckEmpty()
    end, "mcv_box_end")
end

function SWEP:DropBox()
    local owner = self:GetOwner()
    local t = self:HasSequence(self.SequenceThrow) and self:PlaySequence(self.SequenceThrow, 1, true) or 0.6
    self:SetNextPrimaryFire(CurTime() + t)
    owner:DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE)

    self:SetTimer(math.min(self.ThrowDelay, t), function()
        if !IsValid(self) then return end
        self:TakeRound(1)
        if CLIENT then return end
        local ang = self:GetAimAngle()
        local ent = ents.Create(self.DroppedEntity)
        if !IsValid(ent) then return end
        ent.Model = self.WorldModel
        ent.BoxKind = self.BoxKind
        ent.HealAmount = self.HealAmount
        ent.AmmoMagazines = self.AmmoMagazines
        ent:SetPos(owner:GetShootPos() + ang:Forward() * 16)
        ent:SetAngles(Angle(0, ang.y, 0))
        ent:SetOwner(owner)
        ent:Spawn()
        local phys = ent:GetPhysicsObject()
        if IsValid(phys) then
            phys:SetVelocityInstantaneous(ang:Forward() * 350 + Vector(0, 0, 80) + owner:GetVelocity())
        end
    end, "mcv_box_drop")

    self:SetTimer(t, function()
        if IsValid(self) then self:CheckEmpty() end
    end, "mcv_box_end")
end

function SWEP:CheckEmpty()
    if self:GetRoundsLeft() > 0 or CLIENT then return end
    local owner = self:GetOwner()
    if !IsValid(owner) then return end
    local class = self:GetClass()
    timer.Simple(0, function()
        if !IsValid(owner) then return end
        owner:StripWeapon(class)
        local other = owner:GetWeapons()[1]
        if IsValid(other) then owner:SelectWeapon(other:GetClass()) end
    end)
end

function SWEP:PrimaryAttack()
    if self:StillWaiting() then return end
    if self:GetRoundsLeft() <= 0 then return end

    local owner = self:GetOwner()

    if owner:KeyDown(IN_USE) then
        self:DropBox()
        return
    end

    local target = self:GetGiveTarget()
    if !target then
        self:SetNextPrimaryFire(CurTime() + 0.3)
        return
    end

    self:UseBox(target, self.SequenceGive, self.GiveDelay)
end

function SWEP:SecondaryAttack()
    if self:StillWaiting() then return end
    if self:GetRoundsLeft() <= 0 then return end
    if !self:GetOwner():KeyPressed(IN_ATTACK2) then return end

    self:UseBox(self:GetOwner(), self.SequenceSelf, self.GiveDelay)
end

function SWEP:Reload()
end

function SWEP:GetControlHints()
    return {
        {"+attack", self.BoxKind == "medic" and "Heal the player you look at" or "Resupply the player you look at"},
        {"+attack2", "Use on yourself"},
        {"+use +attack", "Drop the box"},
    }
end

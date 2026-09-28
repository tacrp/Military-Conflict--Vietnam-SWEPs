"""Exercise new flame/mine Lua offline; no engine or game launch."""
from pathlib import Path
from test_prediction_replay import realm
from glua_check import to_lua

ROOT = Path(__file__).resolve().parents[1]

for client in (True, False):
    lua = realm('lua/mcv/weapon_common/sh_timers.lua')
    lua.globals().CLIENT = client
    lua.globals().SERVER = not client
    lua.execute('function AddCSLuaFile() end; baseclass={Get=function() return {} end}')
    lua.execute(to_lua((ROOT/'lua/weapons/mcv_underbarrel_flame/shared.lua').read_text()))
    lua.execute('''
        function owner:GetActiveWeapon() return w end
        function SWEP:Clip2() return self.dt.Clip2 end
        function SWEP:TakeSecondaryAmmo(n) self.dt.Clip2=self.dt.Clip2-n end
        function SWEP:Reload() self.didReload=true end
        ACT_VM_ISHOOT_M203=1
        function SWEP:PlayAnimation(act) assert(act==ACT_VM_ISHOOT_M203); self:SetAnimLockTime(0); return 1 end
        w=make(); w:SetClip2(2); w:SetGrenadeLauncher(true); w:SetNeedTriggerPress(false)
        w:SetSpeed(0); pulses=0
        -- Count real scheduling callbacks without simulating the engine's collision/damage API.
        local pulse=SWEP.Deferred_FlamePulse
        function SWEP:Deferred_FlamePulse()
            local server=SERVER; SERVER=false; pulse(self); SERVER=server
            if self:IsFlaming() then pulses=pulses+1 end
        end
        before=copy(w.dt); w:RifleGrenadeAttack(); after=copy(w.dt)
        assert(w:Clip2()==1 and w:GetAnimLockTime()==w:GetActionEnd())
        assert(w:GetNextPrimaryFire()>w:GetActionEnd() and w:DeferPending('FlamePulse'))
        w.dt=copy(before); first=false; w:RifleGrenadeAttack()
        for k,v in pairs(after) do assert(w.dt[k]==v,k) end
        w:RifleGrenadeAttack(); assert(w:Clip2()==1) -- held trigger cannot consume another cartridge
        for i=1,10 do clock=10+i*0.101; w:ProcessDeferred() end
        assert(not w:IsFlaming() and not w:DeferPending() and w:GetNextIdle()<=clock)
        assert(pulses>=8 and pulses<=10)
        w:SetNeedTriggerPress(false); w:SetClip2(0); w:RifleGrenadeAttack()
        assert(w.didReload and w:Clip2()==0)
    ''')

lua = realm('lua/mcv/weapon_common/sh_timers.lua')
lua.execute('''
    CLIENT=true; SERVER=false
    function AddCSLuaFile() end
    ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2=1
''')
lua.execute(to_lua((ROOT/'lua/weapons/mcv_lunge_mine.lua').read_text()))
lua.execute('''
    w=make(); hit=false
    function SWEP:MeleeTrace() return {Hit=hit,HitSky=false} end
    assert(not w:MeleeHit(100)); assert(w:GetActionState()~=5)
    hit=true; before=copy(w.dt); assert(w:MeleeHit(100)); assert(w:GetActionState()==5)
    assert(not w:MeleeHit(100)) -- repeated impact is blocked
    w.dt=copy(before); first=false; assert(w:MeleeHit(100)); assert(w:GetActionState()==5)
    w:LaunchBlade(); assert(w:GetActionState()==5) -- throwing consumes the predicted weapon too
''')
print('Flame ammo, scheduling, locks, replay, empty reload and mine miss/contact/consumption checks passed.')

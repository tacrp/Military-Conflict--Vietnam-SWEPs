"""Offline M79 cartridge selection, reload conservation and prediction replay checks."""
from lupa import LuaRuntime
from glua_check import to_lua
from pack_paths import ROOT, PART2

lua = LuaRuntime()
lua.execute('''
MCV={}; SWEP={}; function AddCSLuaFile() end
function IsValid(v) return v~=nil end
now=10; function CurTime() return now end
function Vector(...) return {} end
function Angle(...) return {} end
game={GetAmmoID=function(s) return s=="buckshot" and 7 or 10 end}
ACT_VM_RELOAD=1; PLAYERANIMEVENT_RELOAD=2
''')
common = (ROOT / 'lua/mcv/shared/sh_common.lua').read_text()
lua.execute(to_lua(common[:common.index('MCV.CancelMultipliers')]))
lua.execute(to_lua((ROOT / 'lua/weapons/mcv_base/sh_reload.lua').read_text()))
lua.execute('''
gun=SWEP; SWEP={}
function gun:DoBodygroupsWeapon(vm) vm.body=-1 end
function gun:DoEject() self.ejected=(self.ejected or 0)+1 end
baseclass={Get=function() return gun end}
''')
lua.execute(to_lua((ROOT / 'lua/weapons/mcv_m79_base/shared.lua').read_text()))
lua.execute('''
base=SWEP
function base:GetFiremode() return self.mode end
function base:SetFiremode(n) self.mode=n end
function base:GetFiremodeValue() return self.Firemodes[self.mode] end
function base:GetOwner() return self.owner end
function base:Clip1() return self.clip end
function base:SetClip1(n) self.clip=n end
function base:GetClip1Capacity() return 1 end
function base:GetInfiniteAmmo() return self.infinite end
function base:StillWaiting() return self.waiting end
function base:GetReloading() return self.reloading end
function base:SetReloading(v) self.reloading=v end
function base:SetEmptyReload(v) self.empty=v end
function base:SetEndReload(v) self.ending=v end
function base:GetGrenadeLauncher() return false end
function base:GetAkimbo() return false end
function base:GetAmmoSwitchFrom() return self.previous or 0 end
function base:SetAmmoSwitchFrom(v) self.previous=v end
function base:GetAnimationStart() return self.start end
function base:GetViewModelTime() return now end
function base:ScopeToggle(v) self.scope=v end
function base:PlayAnimation(act,mult,lock)
    assert(act==ACT_VM_RELOAD and mult==1 and lock)
    self.start=now; self.animation=act; return 3
end
function base:PlaySequence(name,mult,lock)
    assert(name=="reload_live" and mult==1 and lock)
    self.start=now; self.animation=name; return 3
end
function base:EmitThirdPersonSound() end
function base:PlayReloadGesture(t,event) assert(t==3 and event==PLAYERANIMEVENT_RELOAD) end
function base:SetLastClip(n) self.lastclip=n end
function base:GetLastClip() return self.lastclip end
function base:SetBurstCount(n) self.burst=n end
function base:SetAnimLockTime(n) self.lock=n end
function base:EmitSound() end
function check(def, initial)
    setmetatable(def,{__index=base})
    -- Include inherited table metadata, as the engine does.
    def.Firemodes.BaseClass={}
    for _,client in ipairs({false,true}) do
        CLIENT=client; SERVER=not client
        local owner={ammo={buckshot=3,smg1_grenade=4}}
        function owner:GetAmmoCount(a) return self.ammo[a] end
        function owner:SetAmmo(n,a) self.ammo[a]=n end
        local w=setmetatable({mode=1,clip=1,owner=owner},{__index=def})
        assert(w:GetSelectedAmmo()==initial)
        local alternate=initial=="buckshot" and "smg1_grenade" or "buckshot"
        local old=owner.ammo[initial]
        for _,blocked in ipairs({"waiting","reloading"}) do
            w[blocked]=true; w:ChangeFiremode()
            assert(w.mode==1 and w.clip==1 and owner.ammo[initial]==old)
            w[blocked]=false
        end
        -- Replay the same switch from restored predicted state, not accumulated Lua state.
        for pass=1,2 do
            w.mode=1; w.clip=1; w.reloading=false; owner.ammo[initial]=old
            w:ChangeFiremode()
            assert(w.mode==2 and w.clip==0 and owner.ammo[initial]==old+1)
            assert(w:GetSelectedAmmo()==alternate)
            assert(w:GetPrimaryAmmoType()==game.GetAmmoID(alternate))
            assert(w.reloading and w.animation=="reload_live" and not w.empty)
            w:DoEject("eject"); assert(not w.ejected)
        end
        local vm={FindBodygroupByName=function() return 1 end,
            SetPoseParameter=function(self,k,v) self.pose=v end,
            SetBodygroup=function(self,i,v) assert(i==1); self.body=v end}
        for _,visual in ipairs({false,true}) do
            now=w.start+49/30; w:DoBodygroupsWeapon(vm,visual,0,0)
            assert(vm.body==(initial=="buckshot" and 1 or 0))
            assert(vm.pose==1)
            now=w.start+50/30; w:DoBodygroupsWeapon(vm,visual,0,0)
            assert(vm.body==(alternate=="buckshot" and 1 or 0))
        end
        local reserve=owner.ammo[alternate]
        w:Think_Reload()
        assert(not w.reloading and w.previous==0)
        assert(w.clip==1 and owner.ammo[alternate]==reserve-1)
        assert(owner.ammo[initial]==old+1)
        assert(w:RestoreClip(1)==0 and owner.ammo[alternate]==reserve-1)
        w.clip=0 -- fired round is not returned by selection
        w:ChangeFiremode()
        assert(w.mode==1 and owner.ammo[alternate]==reserve-1)
        assert(w.animation==ACT_VM_RELOAD and w.empty)
        w:DoEject("eject"); assert(w.ejected==1)
        owner.ammo[initial]=0
        assert(w:RestoreClip(1)==0 and w.clip==0)
        w.infinite=true
        assert(w:RestoreClip(1)==1 and owner.ammo[initial]==0)
        for index,mode in ipairs(w.Firemodes) do
            w.mode=index
            local buck=mode==MCV.FIREMODE_BUCKSHOT
            assert(w:GetBulletCount()==(buck and 12 or 1))
            assert((w:GetProjectileClass()==nil)==buck)
        end
    end
end
''')
for name, initial in [('m79', 'smg1_grenade'), ('m79_sog', 'buckshot')]:
    lua.execute('SWEP={Primary={}}')
    lua.execute(to_lua((PART2 / f'lua/weapons/mcv_{name}.lua').read_text()))
    lua.globals().check(lua.globals().SWEP, initial)
print('PASS: both M79s, both realms, enum order, ammo conservation, replay, reload locks and cartridge routing')

"""Offline checks of actual reload/deferred Lua; no game launch."""
import unittest

from test_prediction_replay import ROOT, realm
from glua_check import to_lua


class InsertTests(unittest.TestCase):
    def test_cancel_requires_ammo_added_in_this_reload(self):
        for client in (True, False):
            lua = realm("lua/weapons/mcv_base/sh_reload.lua")
            lua.globals().CLIENT = client
            lua.globals().SERVER = not client
            lua.execute(to_lua((ROOT/'lua/weapons/mcv_base/sh_think.lua').read_text()))
            lua.execute('''
                IN_ATTACK=1; IN_RELOAD=2; IN_USE=3; IN_WALK=4
                ACT_SHOTGUN_RELOAD_START=10; ACT_VM_RELOAD=11
                ACT_SHOTGUN_RELOAD_FINISH=12; ACT_SHOTGUN_PUMP=13
                PLAYERANIMEVENT_RELOAD=1; PLAYERANIMEVENT_RELOAD_LOOP=2; PLAYERANIMEVENT_RELOAD_END=3
                SWEP.Primary={ClipSize=10,Chamber=0,Ammo='buckshot'}
                SWEP.ShotgunReload=true; SWEP.DeferredActions={'ReloadInsert'}
                function owner:IsNPC() return false end
                function owner:IsPlayer() return true end
                function owner:KeyPressed(k) return k==IN_RELOAD or (k==IN_ATTACK and attack) end
                function owner:KeyReleased() return false end
                function owner:KeyDown() return false end
                function owner:SetAmmo(n) w.dt.Reserve=n end
                function owner:DoCustomAnimEvent() end
                function SWEP:Clip1() return self.dt.Clip1 end
                function SWEP:Ammo1() return self.dt.Reserve end
                function SWEP:StillWaiting() return self:GetAnimLockTime()>clock end
                function SWEP:HasAnimation(act) return act==ACT_SHOTGUN_PUMP end
                function SWEP:PlayAnimation(act) self.act=act; self:SetAnimLockTime(clock+1); return 1 end
                function SWEP:ScopeToggle() end
                function SWEP:EmitThirdPersonSound() end
                function SWEP:IsBursting() return false end
                for _,name in ipairs({'Think_HammerRelease','Think_Sights','Think_Bipod',
                    'Think_BayonetCharge','Think_WorldBodygroups'}) do SWEP[name]=function() end end
                for _,initial in ipairs({0,2}) do
                    for _,delayed in ipairs({false,true}) do
                        for _,amount in ipairs({1,5}) do
                            SWEP.ReloadInsertTime=delayed and 0.5 or nil
                            SWEP.ShotgunReloadRounds=amount
                            w=make(); w.dt={Clip1=initial,Reserve=20,Reloading=false,EndReload=false,
                                Akimbo=false,GrenadeLauncher=false,PrimedAttack=false,NeedCycle=false}
                            clock=10; first=true; attack=false; w:Reload()
                            assert(w:GetLastClip()==initial and w:GetReloading())
                            clock=10.25; attack=true; w:ThinkWeapon()
                            assert(not w:GetEndReload() and w:Clip1()==initial)
                            clock=11; attack=false; w:ThinkWeapon() -- first insertion begins
                            clock=11.25; attack=true; w:ThinkWeapon()
                            assert(w:GetEndReload()==not delayed)
                            if delayed then
                                assert(w:Clip1()==initial)
                                local before=copy(w.dt)
                                clock=11.5; w:ProcessDeferred(); w:ThinkWeapon()
                                local after=copy(w.dt)
                                w.dt=copy(before); first=false; w:ProcessDeferred(); w:ThinkWeapon()
                                for k,v in pairs(after) do assert(w.dt[k]==v,k) end
                            end
                            assert(w:GetEndReload() and w:Clip1()==initial+amount)
                            assert(w:Ammo1()==20-amount and w:GetReloading())
                            clock=11.75; attack=false; w:ThinkWeapon()
                            assert(w:GetReloading()) -- cancellation still finishes the insert animation
                            clock=12; w:ThinkWeapon()
                            assert(not w:GetReloading() and w:Clip1()==initial+amount)
                            assert(w.act==(initial==0 and ACT_SHOTGUN_PUMP or ACT_SHOTGUN_RELOAD_FINISH))
                            clock=14; w:Reload(); attack=true; w:ThinkWeapon()
                            assert(w:GetLastClip()==initial+amount and not w:GetEndReload())
                        end
                    end
                end
            ''')

    def test_timing_replay_partial_reserve_and_cancellation(self):
        for client in (True, False):
            lua = realm("lua/weapons/mcv_base/sh_reload.lua")
            lua.globals().CLIENT = client
            lua.globals().SERVER = not client
            lua.execute('''
                SWEP.DeferredActions = {"ReloadInsert"}
                SWEP.ReloadInsertTime = 14 / 30
                SWEP.ShotgunReloadRounds = 5
                SWEP.Primary = {ClipSize=10, Chamber=0, Ammo="pistol"}
                function SWEP:Clip1() return self.dt.Clip1 end
                function SWEP:Ammo1() return self.dt.Reserve end
                function owner:SetAmmo(n) w.dt.Reserve=n end
                w=make(); w.dt={Clip1=0,Reserve=12,Reloading=true,Akimbo=false}
                w:RestoreReloadInsert()
                assert(w:Clip1()==0 and w:Ammo1()==12)
                snapshot=copy(w.dt)
                clock=10+14/30-0.001; w:ProcessDeferred()
                assert(w:Clip1()==0 and w:Ammo1()==12)
                clock=10+14/30; w:ProcessDeferred()
                assert(w:Clip1()==5 and w:Ammo1()==7)
                w:ProcessDeferred(); assert(w:Clip1()==5)
                w.dt=copy(snapshot); first=false; w:ProcessDeferred()
                assert(w:Clip1()==5 and w:Ammo1()==7)
                w:RestoreReloadInsert(); clock=clock+14/30; w:ProcessDeferred()
                assert(w:Clip1()==10 and w:Ammo1()==2)
                w.dt.Clip1=0; w:RestoreReloadInsert()
                clock=clock+14/30; w:ProcessDeferred()
                assert(w:Clip1()==2 and w:Ammo1()==0)
                w.dt.Clip1=0; w.dt.Reserve=10; w:RestoreReloadInsert()
                w:CancelDeferred(); clock=clock+1; w:ProcessDeferred()
                assert(w:Clip1()==0 and w:Ammo1()==10)
                w:RestoreReloadInsert(); w.dt.Reloading=false
                clock=clock+1; w:ProcessDeferred()
                assert(w:Clip1()==0 and w:Ammo1()==10)
                SWEP.ReloadInsertTime=nil; w:RestoreReloadInsert()
                assert(w:Clip1()==5 and w:Ammo1()==5)
            ''')


if __name__ == "__main__":
    unittest.main()

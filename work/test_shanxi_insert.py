"""Offline checks of actual reload/deferred Lua; no game launch."""
import unittest

from test_prediction_replay import realm


class InsertTests(unittest.TestCase):
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

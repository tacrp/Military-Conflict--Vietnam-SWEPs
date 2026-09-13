"""Exercise animation rollback boundaries and the shared ammo budget using actual Lua."""
import unittest
from test_prediction_replay import ROOT, realm
from glua_check import to_lua


class AnimationTests(unittest.TestCase):
    def test_render_recovers_timeline_after_engine_timestamp_changes(self):
        lua = realm('lua/weapons/mcv_base_core/sh_anim.lua')
        lua.execute('''
            game={SinglePlayer=function() return false end}
            engine={TickInterval=function() return 0.015 end}
            bit={band=function(a,b) return a & b end}
            function GetPredictionPlayer() return nil end
            function LocalPlayer() return owner end
            function owner:GetInternalVariable() return 807 end
            vm={cycle=0.08,animtime=12.03,flags=0}
            function vm:GetSequence() return 7 end
            function vm:GetSequenceInfo() return {flags=self.flags} end
            function vm:SetCycle(v) self.cycle=v end
            function vm:SetSaveValue(_,v) self.animtime=v end
            w=make(); w:SetAnimationStart(12.09); w:SetAnimationDuration(1)
            clock=12.0336; w:UpdateViewModelAnimation(vm)
            assert(math.abs(vm.cycle-0.0186)<1e-6 and vm.animtime==12.09)
            function owner:GetInternalVariable() return 801 end
            w:UpdateViewModelAnimation(vm)
            assert(math.abs(vm.cycle-0.0186)<1e-6) -- tick-base correction cannot rewind a shown frame
            local visual=w.VisualAnimation
            function GetPredictionPlayer() return owner end
            w:UpdateViewModelAnimation(vm); assert(w.VisualAnimation==visual)
            function GetPredictionPlayer() return nil end
            function owner:GetInternalVariable() return 807 end
            -- Negative duration runs backwards; a loop wraps instead of clamping.
            w:SetAnimationDuration(-1); w:UpdateViewModelAnimation(vm)
            assert(math.abs(vm.cycle-0.9814)<1e-6)
            w:SetAnimationStart(10.09); w:SetAnimationDuration(1)
            w:UpdateViewModelAnimation(vm); assert(vm.cycle==0.999)
            vm.flags=1; w:UpdateViewModelAnimation(vm)
            assert(math.abs(vm.cycle-0.0186)<1e-6)
            w:SetNextIdle(math.huge); w:UpdateViewModelAnimation(vm)
            assert(vm.cycle==0.999) -- an insert must not wrap before its next command
            function LocalPlayer() return {} end
            vm.cycle=0.4; w:UpdateViewModelAnimation(vm)
            assert(vm.cycle==0.4 and w:GetViewModelTime()==clock)
            game.SinglePlayer=function() return true end
            function LocalPlayer() return owner end
            w:UpdateViewModelAnimation(vm); assert(vm.cycle==0.4)
        ''')

    def test_replay_reconstructs_animation_state_and_its_render_timeline(self):
        lua = realm('lua/weapons/mcv_base_core/sh_anim.lua')
        lua.execute('''
            vm={seq=0,parity=0,cycle=0.6,animtime=9,rate=1}
            function owner:GetViewModel() return vm end
            function vm:SelectWeightedSequence(act) return act end
            function vm:SequenceDuration() return 2 end
            function vm:GetCycle() return self.cycle end
            function vm:SetCycle(v) self.cycle=v end
            function vm:GetInternalVariable(k) return self.animtime end
            function vm:SetSaveValue(k,v) assert(k=="m_flAnimTime"); self.animtime=v end
            function vm:SendViewModelMatchingSequence(seq)
                self.seq=seq; self.parity=self.parity+1; self.cycle=0; self.animtime=clock
            end
            function vm:SetPlaybackRate(rate) self.rate=rate end
            function SWEP:ScheduleHammerRelease(_,_,duration) self:SetHammerReleaseTime(clock+duration/2) end
            w=make(); w:PlayAnimation(7,0.5,true,true)
            assert(vm.seq==7 and vm.parity==1 and vm.animtime==10 and vm.cycle==0)
            assert(w:GetAnimLockTime()==11 and w:GetNextIdle()==math.huge)
            -- Reconstruct all state for the command being replayed. Rendering
            -- recovers the final timeline separately, after sequence receive proxies.
            vm.seq=0; vm.parity=0; vm.rate=1; vm.cycle=0.8; vm.animtime=10.5
            first=false; w:PlayAnimation(7,0.5,true,true)
            assert(vm.seq==7 and vm.parity==1 and vm.rate==2)
            assert(vm.cycle==0 and vm.animtime==10)
            assert(w:GetAnimationStart()==10 and w:GetAnimationDuration()==1)
            assert(w:GetAnimLockTime()==11 and w:GetHammerReleaseTime()==10.5)
            first=true; clock=12; w:PlayAnimation(8,-2,true)
            assert(vm.seq==8 and vm.cycle==1 and vm.rate==-0.5)
            assert(w:GetNextIdle()==16 and w:GetAnimLockTime()==16)
        ''')

    def test_launcher_deploy_keeps_deployed_mode(self):
        lua = realm('lua/weapons/mcv_base/sh_gun.lua')
        lua.execute('''
            ACT_VM_IIN_M203=20; ACT_VM_DRAW_M203=21
            function SWEP:PlayAnimation(act) self.act=act end
            w=make(); w:SetGrenadeLauncher(true); w.RifleGrenadeIsUBGL=true
            w:DeployAnimation(); assert(w.act==20 and w:GetGrenadeLauncher())
            w.RifleGrenadeIsUBGL=false; w:DeployAnimation()
            assert(w.act==21 and w:GetGrenadeLauncher())
            w:SetGrenadeLauncher(false); w:DeployAnimation(); assert(w.act==ACT_VM_DRAW)
        ''')


def supply_realm():
    lua = realm('lua/weapons/mcv_equipment_box/sh_box.lua')
    lua.execute('''
        game={GetAmmoName=function(a) return a==99 and "mcv_ammobox" or "ammo"..a end,
              GetAmmoMax=function() return 999 end}
        function weapon(ammo,clip,starting,secondary,secondclip)
            return {GetPrimaryAmmoType=function() return ammo end,
                GetMaxClip1=function() return clip end,Primary={DefaultClip=starting},
                GetSecondaryAmmoType=function() return secondary or -1 end,
                GetMaxClip2=function() return secondclip or -1 end}
        end
        inventory={}; ammo={}
        function owner:GetWeapons() return inventory end
        function owner:GetAmmoCount(a) return ammo[a] or 0 end
        function owner:SetAmmo(n,a) ammo[a]=n end
        function owner:IsPlayer() return true end
        function owner:Alive() return true end
        function LocalPlayer() return owner end
        function totals(plan)
            local cost,amount=0,{}
            for _,p in ipairs(plan) do
                assert(p.amount>=0 and p.amount==math.floor(p.amount))
                assert(p.have+p.amount<=p.cap)
                cost=cost+p.amount/p.per; amount[p.ammo]=p.amount
            end
            assert(cost<=1+1e-8)
            return amount,cost
        end
    ''')
    return lua


class SupplyTests(unittest.TestCase):
    def test_inventory_shares_budget_and_duplicates_do_not_multiply_it(self):
        lua=supply_realm()
        lua.execute('''
            inventory={weapon(1,30,120),weapon(2,12,36)}
            local a,cost=totals(MCV_AmmoSupplyPlan(owner,1,0))
            assert(a[1]==15 and a[2]==6 and math.abs(cost-1)<1e-8)
            inventory={inventory[2],inventory[1],weapon(1,30,120)}
            local b=totals(MCV_AmmoSupplyPlan(owner,1,0))
            assert(b[1]==a[1] and b[2]==a[2])
        ''')

    def test_rockets_grenades_and_secondary_ammo_receive_rotating_turns(self):
        lua=supply_realm()
        lua.execute('''
            inventory={weapon(1,30,120,3,1),weapon(2,1,3),weapon(4,-1,4)}
            local received={}
            for cursor=0,3 do
                local a=totals(MCV_AmmoSupplyPlan(owner,1,cursor))
                for id,n in pairs(a) do received[id]=(received[id] or 0)+n end
            end
            assert(received[1]>0 and received[2]>0 and received[3]>0 and received[4]>0)
        ''')

    def test_caps_exclude_supply_ammo_and_failed_use_preserves_cursor(self):
        lua=supply_realm()
        lua.execute('''
            inventory={weapon(1,30,120),weapon(99,-1,5),weapon(2,12,36)}
            ammo={[1]=89,[2]=24}
            local a=totals(MCV_AmmoSupplyPlan(owner,1,0))
            assert(a[1]==1 and a[2]==nil and a[99]==nil)
            local gave,cursor=MCV_ApplySupply("ammo",owner,0,1,10)
            assert(gave and cursor==11 and ammo[1]==90)
            gave,cursor=MCV_ApplySupply("ammo",owner,0,1,cursor)
            assert(not gave and cursor==11 and ammo[99]==nil)
        ''')

    def test_replay_from_restored_reserve_repeats_same_grant(self):
        lua=supply_realm()
        lua.execute('''
            inventory={weapon(1,30,120),weapon(2,1,3)}
            local before=copy(ammo)
            local gave,cursor=MCV_ApplySupply("ammo",owner,0,1,1)
            local once=copy(ammo)
            ammo=copy(before); first=false
            local gave2,cursor2=MCV_ApplySupply("ammo",owner,0,1,1)
            assert(gave and gave2 and cursor==cursor2)
            for a,n in pairs(once) do assert(ammo[a]==n) end
        ''')

    def test_budget_and_caps_over_mixed_inventory_sizes(self):
        lua=supply_realm()
        lua.execute('''
            for size=1,12 do
                inventory={}; ammo={}
                for i=1,size do inventory[i]=weapon(i,i%4==0 and 1 or i*7,i*30) end
                for cursor=0,size-1 do
                    totals(MCV_AmmoSupplyPlan(owner,1,cursor))
                end
                for i=1,size do ammo[i]=i*10 end
                for cursor=0,size-1 do totals(MCV_AmmoSupplyPlan(owner,1,cursor)) end
            end
        ''')


if __name__=='__main__':
    unittest.main()

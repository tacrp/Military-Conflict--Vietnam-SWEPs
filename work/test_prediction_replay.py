"""Replay actual deferred-action Lua after restoring only its engine-owned state.

This complements the live MP tests; it does not emulate Source prediction or count
engine errors. It catches dependencies on Lua fields that survive a rollback.
"""
from pathlib import Path
import unittest
from lupa import LuaRuntime
from glua_check import to_lua

ROOT = Path(__file__).resolve().parents[1]


def realm(module):
    lua = LuaRuntime()
    lua.execute('''
        CLIENT = true; SERVER = false; SWEP = {}; clock = 10; first = true
        ACT_VM_DRAW = 1
        function CurTime() return clock end
        function IsFirstTimePredicted() return first end
        function IsValid(v) return v ~= nil end
        function math.Clamp(v, lo, hi) return math.min(math.max(v, lo), hi) end
        owner = {Crouching = function() return false end, DoAnimationEvent = function() end}
        function copy(t) local r={} for k,v in pairs(t) do r[k]=v end return r end
        function SWEP:GetOwner() return owner end
        function SWEP:HasSequence() return true end
        function SWEP:PlaySequence(seq) self.lastSequence=seq; return 1 end
        function SWEP:PlayAnimation() return 0.5 end
        function SWEP:EmitSound() end
        function SWEP:StatMult() return 1 end
        function SWEP:TakeRound(n) self.dt.Rounds = self.dt.Rounds - n end
        function SWEP:GetRoundsLeft() return self.dt.Rounds end
        function SWEP:MeleeTrace() return {Hit=false} end
        function make()
            return setmetatable({dt={Rounds=5}}, {__index=function(self,k)
                if SWEP[k] then return SWEP[k] end
                local prefix, field = string.sub(k,1,3), string.sub(k,4)
                if prefix == "Get" then return function(s) if s.dt[field] ~= nil then return s.dt[field] end return 0 end end
                if prefix == "Set" then return function(s,v) s.dt[field]=v end end
            end})
        end
    ''')
    for f in ("lua/weapons/mcv_base_core/sh_timers.lua", module):
        lua.execute(to_lua((ROOT / f).read_text()))
    lua.execute('function SWEP:MeleeTrace() return {Hit=false} end')
    return lua


class ReplayTests(unittest.TestCase):
    def test_toggle_aim_replays_and_respects_other_controls(self):
        for client in (True, False):
            lua = realm("lua/weapons/mcv_base/sh_sights.lua")
            lua.globals().CLIENT = client
            lua.globals().SERVER = not client
            lua.execute('''
                IN_ATTACK2=1; IN_USE=2
                engine={TickInterval=function() return 0.015 end}
                function math.Approach(cur,target,step)
                    if cur < target then return math.min(cur+step,target) end
                    return math.max(cur-step,target)
                end
                function owner:IsPlayer() return true end
                mode=1; down=false; pressed=false; use=false; waiting=false; sprint=false
                function owner:GetInfoNum(name,default)
                    assert(name=="mcv_toggle_aim" and default==0); return mode
                end
                function owner:KeyDown(key) return (key==IN_USE and use) or (key==IN_ATTACK2 and down) end
                function owner:KeyPressed(key) return key==IN_ATTACK2 and pressed end
                function SWEP:StillWaiting() return waiting end
                function SWEP:GetIsSprinting() return sprint end
                SWEP.Ironsight=true; SWEP.IronsightSpeedScale=1
                w=make(); w:SetIronsight(false); w:SetSighted(false); w:SetSafe(false)
                w:SetReloading(false); w:SetBipod(false); w:SetSightAmountRaw(0)
                -- A replay restores only DT state; the same press must raise sights again.
                before=copy(w.dt); pressed=true; down=true; w:Think_Sights()
                assert(w:GetIronsight() and w:GetSighted()); after=copy(w.dt)
                w.dt=copy(before); first=false; w:Think_Sights()
                for k,v in pairs(after) do assert(w.dt[k]==v,k) end
                -- Holding or releasing must not undo the toggle.
                pressed=false; w:Think_Sights(); assert(w:GetIronsight())
                down=false; w:Think_Sights(); assert(w:GetIronsight())
                sprint=true; w:Think_Sights(); assert(w:GetIronsight() and not w:GetSighted())
                sprint=false; w:Think_Sights(); assert(w:GetSighted())
                -- Use + aim belongs to the bayonet control, not the toggle.
                use=true; pressed=true; down=true; w:Think_Sights(); assert(w:GetIronsight())
                use=false; before=copy(w.dt); w:Think_Sights(); assert(not w:GetIronsight())
                w.dt=copy(before); w:Think_Sights(); assert(not w:GetIronsight())
                waiting=true; w:Think_Sights(); assert(not w:GetIronsight())
                waiting=false; w:SetReloading(true); w:Think_Sights(); assert(not w:GetIronsight())
                w:SetReloading(false); w.MustBipod=true; w:Think_Sights(); assert(not w:GetIronsight())
                w:SetBipod(true); w:Think_Sights(); assert(w:GetIronsight())
                w.MustBipod=false; pressed=false
                w:SetSafe(true); w:Think_Sights(); assert(not w:GetIronsight())
                w:SetSafe(false); w:Think_Sights(); assert(not w:GetIronsight())
                -- Returning to hold mode obeys the current button without a fresh press.
                mode=0; w:Think_Sights(); assert(w:GetIronsight())
                down=false; w:Think_Sights(); assert(not w:GetIronsight())
            ''')

    def test_movement_samples_match_across_hook_order_and_rollback(self):
        lua=realm("lua/weapons/mcv_base_core/sh_timers.lua")
        lua.execute('''
            hook={Add=function() end}
            predicting=true
            function GetPredictionPlayer() return predicting and owner or nil end
            function owner:IsPlayer() return true end
            function owner:GetVelocity() error("read live velocity instead of command history") end
            cmd={number=99,CommandNumber=function(s) return s.number end}
            function owner:GetCurrentCommand() return cmd end
        ''')
        lua.execute(to_lua((ROOT / "lua/weapons/mcv_base_core/sh_movement.lua").read_text()))
        lua.execute('''
            w=make(); w:CaptureMovement(99,100,true,false); before=copy(w.dt)
            cmd.number=100
            -- Client Think is before movement: completed command 99.
            local speed,ground,duck=w:GetWeaponMovement()
            assert(speed==100 and ground and not duck)
            w:CaptureMovement(100,273,false,true)
            -- Server Think is after movement: still completed command 99.
            speed,ground,duck=w:GetWeaponMovement()
            assert(speed==100 and ground and not duck)
            cmd.number=101
            speed,ground,duck=w:GetWeaponMovement()
            assert(speed==273 and not ground and duck)
            -- Rollback restores the samples, unlike an ordinary Lua last-velocity field.
            w.dt=copy(before); first=false; cmd.number=100
            w:CaptureMovement(100,120,true,false)
            assert(w:GetWeaponMovement()==100)
            w:CaptureMovement(100,121,true,false)
            assert(w:GetWeaponMovement()==100) -- do not shift twice in one command
            predicting=false
            assert(w:GetWeaponMovement()==121) -- drawing sees the latest completed move
        ''')

    def test_prediction_cannot_consume_the_render_frame_blends(self):
        lua = realm("lua/weapons/mcv_base/sh_sights.lua")
        lua.execute('''
            frame=100; frameStep=0.05; predicting=true
            function FrameNumber() return frame end
            function FrameTime() return predicting and 0.015 or frameStep end
            function GetPredictionPlayer() return predicting and owner or nil end
            function math.Approach(cur,target,step)
                if cur < target then return math.min(cur+step,target) end
                return math.max(cur-step,target)
            end
            SWEP.IronsightSpeedScale=1
            w=make(); w:SetSightAmountRaw(0)
            w:GetSightAmountRawVisual()
            assert(w.VisualSightFrame==nil and w.VisualSightRaw==nil)
            w:SetSightAmountRaw(0.8); w:GetSightAmountRawVisual()
            assert(w.VisualSightFrame==nil)
            predicting=false; assert(w:GetSightAmountRawVisual()==0.8)
            frame=101; predicting=true; w:SetSightAmountRaw(0)
            assert(w:GetSightAmountRawVisual()==0.8 and w.VisualSightFrame==100)
            w:SetSightAmountRaw(0.4); w:GetSightAmountRawVisual()
            predicting=false
            local once=w:GetSightAmountRawVisual()
            assert(once < 0.8 and once >= 0.4)
            assert(w.VisualSightFrame==101 and w:GetSightAmountRawVisual()==once)
        ''')
        for module in ('lua/weapons/mcv_base_core/sh_think.lua','lua/weapons/mcv_base/sh_shoot.lua'):
            lua.execute(to_lua((ROOT / module).read_text()))
        lua.execute('''
            function SWEP:GetStanceSpreadMultiplier() return 3 end
            function SWEP:GetSwaySteady() return 0 end
            frame=102; predicting=true; w:SetSpeed(273)
            w.VisualSpeed=0; w.VisualSpeedFrame=101
            w.VisualStance=1; w.VisualStanceFrame=101
            w.VisualSteady=1; w.VisualSteadyFrame=101
            assert(w:GetSpeedVisual()==0 and w.VisualSpeedFrame==101)
            assert(w:GetStanceSpreadMultiplierVisual()==1 and w.VisualStanceFrame==101)
            assert(w:GetSwaySteadyVisual()==1 and w.VisualSteadyFrame==101)
            predicting=false
            assert(w:GetSpeedVisual()>0 and w.VisualSpeedFrame==102)
            assert(w:GetStanceSpreadMultiplierVisual()>1 and w.VisualStanceFrame==102)
            assert(w:GetSwaySteadyVisual()<1 and w.VisualSteadyFrame==102)
        ''')

    def test_recoil_applies_once_on_following_command_after_rollback(self):
        lua = realm("lua/weapons/mcv_base_core/sh_timers.lua")
        lua.execute('''
            local mt={}
            function V(x,y,z) return setmetatable({x=x,y=y,z=z},mt) end
            mt.__add=function(a,b) return V(a.x+b.x,a.y+b.y,a.z+b.z) end
            mt.__mul=function(a,b) return V(a.x*b,a.y*b,a.z*b) end
            mt.__index={IsZero=function(a) return a.x==0 and a.y==0 and a.z==0 end}
            vector_origin=V(0,0,0)
            hook={Add=function(event,_,fn) if event=="SetupMove" then moveHook=fn end end}
            function GetPredictionPlayer() return owner end
            function owner:IsPlayer() return true end
            cmd={number=100, CommandNumber=function(s) return s.number end,
                GetViewAngles=function() return {Forward=function() return V(1,0,0) end} end}
            function owner:GetCurrentCommand() return cmd end
            function owner:GetActiveWeapon() return w end
            SWEP.MilitaryConflictVietnam=true
            function SWEP:GetAimVector() error("recoil used view punch instead of input") end
            mv={velocity=vector_origin, GetVelocity=function(s) return s.velocity end,
                SetVelocity=function(s,v) s.velocity=v end}
        ''')
        lua.execute(to_lua((ROOT / "lua/weapons/mcv_base_core/sh_movement.lua").read_text()))
        lua.execute('''
            w=make(); w:SetRecoilImpulse(vector_origin); before=copy(w.dt)
            w:QueueRecoilImpulse(1.5); moveHook(owner,mv,cmd)
            assert(mv.velocity:IsZero())
            cmd.number=101; moveHook(owner,mv,cmd); moveHook(owner,mv,cmd)
            assert(mv.velocity.x==-1.5 and w:GetRecoilImpulse():IsZero())
            w.dt=copy(before); first=false; cmd.number=100; mv.velocity=vector_origin
            w:QueueRecoilImpulse(1.5); cmd.number=101; moveHook(owner,mv,cmd)
            assert(mv.velocity.x==-1.5 and mv.velocity.y==0 and mv.velocity.z==0)
        ''')

    def test_hammer_timing_ignores_stale_viewmodel_name(self):
        lua = realm("lua/weapons/mcv_base/sh_shoot.lua")
        lua.execute('''
            SWEP.ViewModel="rifle"
            MCV={HammerEvents={rifle={pump={[1]=0.5}}}}
            vm={GetModel=function() return "previous_pistol" end,
                GetSequenceName=function() return "pump" end}
            w=make(); w:SetAkimbo(false); w:SetNeedCycle(true)
            w:ScheduleHammerRelease(vm,1,2,false)
            assert(w:GetHammerReleaseTime()==11)
            before=copy(w.dt); clock=11; w:Think_HammerRelease()
            assert(w:GetNeedCycle()==false)
            w.dt=copy(before); first=false; w:Think_HammerRelease()
            assert(w:GetNeedCycle()==false and w:GetHammerReleaseTime()==0)
        ''')

    def test_model_alias_and_engine_cache_follow_restored_mode(self):
        lua = realm("lua/weapons/mcv_base_core/sh_timers.lua")
        lua.execute('hook={Add=function() end}')
        lua.execute(to_lua((ROOT / "lua/weapons/mcv_base_core/sh_deploy.lua").read_text()))
        lua.execute('''
            SWEP.HasAkimbo=true; SWEP.ViewModelAkimbo="dual"
            weapons={Get=function() return {ViewModel="single"} end}
            vm={model="single", mins=-8, maxs=8}
            function vm:GetModel() return self.model end
            function vm:SetModel(v) self.model=v; self.mins=-100; self.maxs=100 end
            function vm:GetCollisionBounds() return self.mins,self.maxs end
            function vm:SetCollisionBounds(a,b) self.mins=a; self.maxs=b end
            function vm:GetInternalVariable() return self.model=="single" and 1 or 2 end
            function owner:GetViewModel() return vm end
            function owner:IsPlayer() return true end
            function SWEP:SetSaveValue(k,v) self.dt[k]=v end
            w=make(); w:SetAkimbo(false); w:SyncViewModel(true); w:SyncViewModel(); before=copy(w.dt)
            w:SetAkimbo(true); w:SyncViewModel(true)
            assert(w.dt.m_iViewModelIndex==1) -- the engine cache changes next command
            w:SyncViewModel()
            assert(w.ViewModel=="dual" and w.dt.m_iViewModelIndex==2)
            -- Restore engine state, but leave the ordinary Lua ViewModel alias alone.
            w.dt=copy(before); vm.model="single"
            -- The engine can have read that stale alias before calling Lua Think.
            w.dt.m_iViewModelIndex=2
            w:SyncViewModel()
            assert(w.ViewModel=="single" and w.dt.m_iViewModelIndex==1)
            assert(vm.mins==-8 and vm.maxs==8)
            SWEP.HasAkimbo=false; vm.model="old_gun"; w.ViewModel="old_gun"
            w:SyncViewModel(true)
            assert(vm.model=="single" and w.ViewModel=="single")
        ''')

    def test_delayed_switch_uses_commands_and_survives_rollback(self):
        lua = realm("lua/weapons/mcv_throwable/sh_throw.lua")
        lua.execute('''
            hook={Add=function(_,_,fn) selectHook=fn end}
            game={SinglePlayer=function() return false end}
            engine={TickInterval=function() return 0.01 end}
            function LocalPlayer() return owner end
            predicting=true
            function GetPredictionPlayer() return predicting and owner or nil end
            cmd={number=1000, CommandNumber=function(s) return s.number end,
                 SelectWeapon=function(s, w) s.selected=w end}
            function owner:GetCurrentCommand() return cmd end
            function owner:IsNPC() return false end
            function owner:GetActiveWeapon() return w end
            function owner:GetViewModel() return {SetBodyGroups=function() end} end
            function owner:SetSaveValue(k,v) self[k]=v end
            SWEP.MilitaryConflictVietnam=true
        ''')
        lua.execute(to_lua((ROOT / "lua/weapons/mcv_base_core/sh_deploy.lua").read_text()))
        lua.execute('''
            function SWEP:ClientHolster() end
            w=make(); target={}; before=copy(w.dt)
            assert(w:Holster(target)==false and w:GetHolsterCommand()==1050)
            w.dt=copy(before); first=false
            assert(w:Holster(target)==false and w:GetHolsterCommand()==1050)
            -- StartCommand sees different wall times; selection must stay on command 1050.
            clock=100; cmd.number=1049; selectHook(owner,cmd); assert(cmd.selected==nil)
            clock=9; cmd.number=1050; selectHook(owner,cmd); assert(cmd.selected==target)
            assert(w:GetHolsterTime()==10.5)
            -- The extra non-predicted callback must leave the pending state alone.
            predicting=false; assert(w:Holster(target)==true)
            assert(w:GetHolsterCommand()==1050 and w:GetHolsterTime()==10.5)
            predicting=true; clock=10.5; assert(w:Holster(target)==true)
            assert(w:GetHolsterCommand()==0 and w:GetHolsterTime()==0)
            vector_origin={}
            function SWEP:ViewModelHidden() return true end
            function SWEP:SyncViewModel() end -- animation/model behavior tested separately
            function SWEP:OnDeploy() end
            w:Deploy(); assert(owner.m_flNextAttack==clock)
            SERVER=true; CLIENT=false
            w:Deploy(); assert(owner.m_flNextAttack==0)
            game.SinglePlayer=function() return true end
            w:Deploy(); assert(owner.m_flNextAttack==0)
        ''')

    def test_grenade_holdtypes_follow_pull_and_restore(self):
        lua = realm("lua/weapons/mcv_throwable/sh_throw.lua")
        lua.execute('''
            SWEP.FuseModes={3}; SWEP.ThrowReleaseTime=0.22; SWEP.ThrowReleaseTimeUnderhand=0.3
            SWEP.ShootGesture=123
            SWEP.SequenceWindupHigh="drawbackhigh"; SWEP.SequenceWindupLow="drawbacklow"
            SWEP.SequenceThrowHigh="throw"; SWEP.SequenceThrowLow="lob"; SWEP.SequenceRoll="roll"
            function SWEP:LaunchThrowable() end
            owner.DoAnimationEvent=function(_,gesture)
                assert(gesture==123 and w:GetHoldType()=="grenade")
            end
            for _,server in ipairs({false,true}) do
                SERVER=server; CLIENT=not server
                for _,low in ipairs({false,true}) do
                    for _,crouched in ipairs({false,true}) do
                        owner.Crouching=function() return crouched end
                        w=make(); w:SetFiremode(1); w:SetSpeed(999)
                        w:OnDeploy(); assert(w:GetHoldType()=="slam")
                        w:Windup(low)
                        assert(w:GetHoldType()==(low and "melee2" or "grenade"))
                        local pulled=copy(w.dt)
                        w:Throw(low,false); assert(w:GetHoldType()=="grenade")
                        assert(w.lastSequence==(low and (crouched and "roll" or "lob") or "throw"))
                        w:Deferred_ThrowEnd(); assert(w:GetHoldType()=="slam")
                        -- Replayed/received action state corrects a stale holdtype without Lua flags.
                        w.dt=copy(pulled); w:SetHoldType("slam"); first=false
                        w:Think_HoldType()
                        assert(w:GetHoldType()==(low and "melee2" or "grenade"))
                        w:Throw(low,true); assert(w:GetHoldType()=="grenade")
                        w:OnDeploy(); assert(w:GetHoldType()=="slam")
                    end
                end
            end
        ''')

    def test_throw_replayed_from_before_input_consumes_once(self):
        lua = realm("lua/weapons/mcv_throwable/sh_throw.lua")
        lua.execute('''
            SWEP.FuseModes={3,5}; SWEP.ThrowReleaseTime=0.3; SWEP.ThrowReleaseTimeUnderhand=0.3
            w=make(); w:SetFiremode(1); w:SetActionStart(10)
            before=copy(w.dt)
            w:Throw(false, false)
            clock=10.31; w:ProcessDeferred()
            clock=11.01; w:ProcessDeferred()
            assert(w:GetRoundsLeft()==4 and w:GetActionState()==0)
            -- Roll back only NetworkVars, leaving all ordinary Lua fields untouched.
            w.dt=copy(before); clock=10; first=false
            w:Throw(false, false)
            clock=10.31; w:ProcessDeferred()
            clock=11.01; w:ProcessDeferred(); w:ProcessDeferred()
            assert(w:GetRoundsLeft()==4 and w:GetActionState()==0)
            assert(not w:DeferPending())
        ''')

    def test_throw_replayed_from_between_release_and_finish(self):
        lua = realm("lua/weapons/mcv_throwable/sh_throw.lua")
        lua.execute('''
            SWEP.FuseModes={3}; SWEP.ThrowReleaseTime=0.3; SWEP.ThrowReleaseTimeUnderhand=0.3
            w=make(); w:SetFiremode(1); w:SetActionStart(10); w:Throw(true, false)
            clock=10.31; w:ProcessDeferred(); middle=copy(w.dt)
            clock=11.01; w:ProcessDeferred()
            w.dt=copy(middle); first=false; w:ProcessDeferred()
            assert(w:GetRoundsLeft()==4 and w:GetActionState()==0)
        ''')

    def test_slash_chooses_same_sequence_after_rollback(self):
        lua = realm("lua/weapons/mcv_melee/sh_melee.lua")
        lua.execute('''
            SWEP.SequencesSlash={"slash1","slash2"}; SWEP.SequencesMiss={"miss1","miss2"}
            SWEP.SoundSwing=""; SWEP.MeleeRange=60; SWEP.SlashRate=150
            w=make(); before=copy(w.dt); w:Slash(); sequence=w.lastSequence
            w.dt=copy(before); first=false; w:Slash()
            assert(w:GetSlashCount()==1 and w.lastSequence==sequence)
            w:Slash(); assert(w:GetSlashCount()==2 and w.lastSequence~=sequence)
        ''')

    def test_cancelled_action_cannot_run_later(self):
        lua = realm("lua/weapons/mcv_throwable/sh_throw.lua")
        lua.execute('''
            w=make(); w:Defer("ThrowRelease", 0.3); w:CancelDeferred()
            clock=20; w:ProcessDeferred(); assert(w:GetRoundsLeft()==5)
        ''')


if __name__ == "__main__":
    unittest.main()

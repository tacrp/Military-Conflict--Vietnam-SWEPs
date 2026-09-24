"""Offline bipod/safety transitions, including replay on both realms."""
from test_prediction_replay import realm, ROOT
from glua_check import to_lua

for client in (True, False):
    lua = realm('lua/weapons/mcv_base/sh_gun.lua')
    lua.globals().CLIENT = client
    lua.globals().SERVER = not client
    lua.execute(to_lua((ROOT/'lua/weapons/mcv_base/sh_bipod.lua').read_text()))
    lua.execute('''
        IN_USE=1; IN_WALK=2; IN_FORWARD=3; IN_BACK=4
        IN_MOVELEFT=5; IN_MOVERIGHT=6; IN_JUMP=7
        ACT_VM_DEPLOYED_IN=10; ACT_VM_DEPLOYED_OUT=11
        ACT_VM_IDLE_TO_LOWERED=12; ACT_VM_LOWERED_TO_IDLE=13
        pressed=true; walk=false; moving=false; supported=true; waiting=false
        function owner:KeyPressed(k) return k==IN_USE and pressed end
        function owner:KeyDown(k) return (k==IN_WALK and walk) or (k==IN_FORWARD and moving) end
        function SWEP:CanBipod() return supported end
        function SWEP:StillWaiting() return waiting end
        function SWEP:PlayAnimation(act) self.anim=act; self.calls=(self.calls or 0)+1 end
        SWEP.HasBipod=true
        w=make(); w:SetSafe(true); w:SetBipod(false)
        -- A modifier chord must not deploy, nor should unavailable support/locks clear safety.
        walk=true; w:Think_Bipod(); assert(w:GetSafe() and not w:GetBipod())
        walk=false; supported=false; w:Think_Bipod(); assert(w:GetSafe() and not w:GetBipod())
        supported=true; waiting=true; w:Think_Bipod(); assert(w:GetSafe() and not w:GetBipod())
        waiting=false; before=copy(w.dt); w:Think_Bipod(); after=copy(w.dt)
        assert(w:GetBipod() and not w:GetSafe() and w.anim==ACT_VM_DEPLOYED_IN and w.calls==1)
        w.dt=copy(before); first=false; w:Think_Bipod()
        for k,v in pairs(after) do assert(w.dt[k]==v,k) end
        -- Safety input while supported must not change state, deadlines or animation.
        count=w.calls; w:ToggleSafe()
        assert(w.calls==count and not w:GetSafe() and w:GetBipod())
        for k,v in pairs(after) do assert(w.dt[k]==v,k) end
        pressed=false; moving=true; w:Think_Bipod()
        assert(not w:GetBipod() and not w:GetSafe() and w.anim==ACT_VM_DEPLOYED_OUT)
        -- Normal safety and fire-to-ready still work after folding the bipod.
        w:ToggleSafe(); assert(w:GetSafe() and w.anim==ACT_VM_IDLE_TO_LOWERED)
        w:ToggleSafe(true); assert(not w:GetSafe() and w.anim==ACT_VM_LOWERED_TO_IDLE)
        count=w.calls; w:ToggleSafe(true); assert(not w:GetSafe() and w.calls==count)
    ''')
print('PASS: bipod/safety exclusion, input chord, blocked deployment and client/server replay')

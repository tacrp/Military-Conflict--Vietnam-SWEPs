"""Offline model lifetime and NPC draw-order regressions; no game launched."""
from pathlib import Path
from lupa import LuaRuntime
from glua_check import to_lua

root = Path(__file__).resolve().parents[1]
lua = LuaRuntime()
lua.execute('''
MCV={}; SWEP={}; hooks={}; timers={}; models={}; CLIENT=true; order={}
function IsValid(v) return type(v)=='table' and not v.invalid end
hook={Add=function(e,n,f) hooks[e]=hooks[e] or {}; hooks[e][n]=f end}
timer={Create=function(n,times,reps,f) assert(times==1 and reps==0); timers[n]=f end}
local V={}; V.__index=V
function Vector(x,y,z) return setmetatable({x=x or 0,y=y or 0,z=z or 0},V) end
function V.__add(a,b) return Vector(a.x+b.x,a.y+b.y,a.z+b.z) end
function V.__eq(a,b) return a.x==b.x and a.y==b.y and a.z==b.z end
Angle=Vector; vector_origin=Vector(); angle_zero=Angle()
function Matrix() return {Scale=function() end} end
function CreateClientConVar() return {GetString=function() return '' end} end
util={IsValidModel=function() return true end}
function ClientsideModel(model)
    local m={model=model, removes=0}
    function m:Remove() self.removes=self.removes+1; self.invalid=true end
    function m:GetModel() return self.model end
    function m:GetParent() return self.parent end
    function m:SetParent(p) self.parent=p; self.parentChanges=(self.parentChanges or 0)+1 end
    function m:SetLocalPos(p) self.pos=p end
    function m:SetLocalAngles(a) self.ang=a end
    m.SetPos=m.SetLocalPos; m.SetAngles=m.SetLocalAngles
    function m:AddEffects() end
    function m:InvalidateBoneCache() end
    function m:SetNoDraw() end
    function m:SetSkin() end
    function m:SetBodygroup() end
    function m:SetupBones() order[#order+1]='gun' end
    function m:DrawModel() self.drawn=(self.drawn or 0)+1 end
    models[#models+1]=m; return m
end
function owner(npc)
    return {npc=npc,model='owner1',GetModel=function(s) return s.model end,
        IsPlayer=function(s) return not s.npc end,IsNPC=function(s) return s.npc end,
        IsDormant=function(s) return s.dormant end,GetActiveWeapon=function(s) return s.active end,
        LookupBone=function(s,n) if n=='ValveBiped.Bip01_R_Hand' and not s.noHand then return 0 end end,
        GetBoneMatrix=function(s) if not s.noMatrix then return {} end end,
        SetupBones=function() order[#order+1]='owner' end}
end
function weapon(o)
    local w=setmetatable({WorldModel='gun',owner=o}, {__index=SWEP}); o.active=w
    function w:GetOwner() return self.owner end
    function w:IsDormant() return self.dormant end
    function w:GetSkin() return 0 end
    function w:GetNumBodyGroups() return 0 end
    return w
end
''')
def load(path):
    lua.execute(to_lua((root/path).read_text(encoding='utf-8')))
load('lua/mcv/client/cl_modelgc.lua')
load('lua/mcv/shared/sh_modelcache.lua')
load('lua/mcv/weapon_common/cl_worldmodel.lua')
lua.execute('''
local o=owner(true); w=weapon(o)
local right=w:UpdateWorldModels(true)
assert(order[1]=='owner' and order[2]=='gun') -- NPC pose prepared even on draw path
assert(right.parent==o and right==w.WM)
local count=#models; w:UpdateWorldModels(true); assert(#models==count)
right.parent=nil; w:UpdateWorldModels(true); assert(right.parent==o)
o.model='owner2'; w:UpdateWorldModels(true); assert(right.parentChanges==3)
timers.MCV_ClientModels(); assert(IsValid(right))
-- Failed dual transform never returns/draws the previous left pose.
w.GetAkimbo=function() return true end
w.GetWorldModelTransformLeft=function() return nil end
local _,left=w:UpdateWorldModels(true); assert(left==nil and IsValid(w.WMLeft))
local stale=w.WMLeft
w:DrawWorldModel(); assert(stale.drawn==nil)
-- A lost slot is still reachable by the independent collector.
w.WM=nil; timers.MCV_ClientModels(); assert(right.removes==1)
assert(IsValid(stale))
o.dormant=true; timers.MCV_ClientModels(); assert(stale.removes==1 and w.WMLeft==nil)
o.dormant=false; w:UpdateWorldModels(true); right=w.WM
hooks.NotifyShouldTransmit.MCV_ClientModels(o,false)
assert(right.removes==1 and w.WM==nil)
w:UpdateWorldModels(true); right=w.WM
w.owner=owner(true); w.owner.active=w; timers.MCV_ClientModels()
assert(right.removes==1)
-- Invalid owner/weapon and holstering clean up even without their OnRemove.
for _,mode in ipairs({'owner','weapon','holster','dormant'}) do
    local o=owner(true); local w=weapon(o)
    local m=MCV.TrackClientModel(w,'Ghost',ClientsideModel('preview'))
    if mode=='owner' then o.invalid=true elseif mode=='weapon' then w.invalid=true
    elseif mode=='holster' then o.active={} else w.dormant=true end
    timers.MCV_ClientModels(); assert(m.removes==1)
end
-- Entity hooks are immediate, replacement and explicit cleanup are idempotent.
local o=owner(false); local w=weapon(o)
local a=MCV.TrackClientModel(w,'Ghost',ClientsideModel('a'))
local b=MCV.TrackClientModel(w,'Ghost',ClientsideModel('b'))
assert(a.removes==1 and w.Ghost==b)
hooks.EntityRemoved.MCV_ClientModels(o); assert(b.removes==1)
MCV.RemoveClientModel(w,'Ghost'); assert(b.removes==1)
-- Unsupported NPC rig never gets a root-position client copy.
o.noHand=true; assert(w:UpdateWorldModels(true)==nil and w.WM==nil)
o.noHand=false; o.noMatrix=true; assert(w:UpdateWorldModels(true)==nil)
o.noMatrix=false
for _,event in ipairs({'PostCleanupMap','ShutDown'}) do
    local m=MCV.TrackClientModel(w,'Ghost',ClientsideModel('preview'))
    hooks[event].MCV_ClientModels(); assert(m.removes==1)
end
reloadModel=MCV.TrackClientModel(w,'Ghost',ClientsideModel('preview'))
''')
load('lua/mcv/client/cl_modelgc.lua')
lua.execute('assert(reloadModel.removes==1)')
print('PASS: independent strong-reference cleanup, missed callbacks, owner/PVS/slot changes, reloads; NPC pose order and stale dual suppression')

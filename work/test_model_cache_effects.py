"""Model cache lifetime, immutable metadata, and live shell dispatch behavior."""
from pathlib import Path
from lupa import LuaRuntime
from glua_check import to_lua
root=Path(__file__).resolve().parents[1]
lua=LuaRuntime()
lua.execute('''
MCV={FIREMODE_VOLLEY=5}; SWEP={}; SERVER=true; CLIENT=false
bit={band=function(a,b) return a & b end}
calls={attachment=0,bone=0,sequence=0,info=0}
vm={model='single',ready=true}
function vm:GetModel() return self.model end
function vm:LookupAttachment(name)
    calls.attachment=calls.attachment+1
    if not self.ready then return 0 end
    return ({muzzle=1,eject=2,eject2=3})[name] or 0
end
function vm:LookupBone(name) calls.bone=calls.bone+1; return self.ready and 0 or nil end
function vm:LookupSequence(name) calls.sequence=calls.sequence+1; return self.ready and 0 or -1 end
function vm:GetSequenceInfo(id) calls.info=calls.info+1; if self.ready then return {flags=id} end end
''')
lua.execute(to_lua((root/'lua/mcv/shared/sh_modelcache.lua').read_text()))
lua.execute('''
for i=1,10000 do
    assert(MCV.CachedAttachment(vm,'muzzle')==1)
    assert(MCV.CachedBone(vm,'hand')==0)
    assert(MCV.CachedSequence(vm,'idle')==0)
    assert(not MCV.SequenceLoops(vm,0)); assert(MCV.SequenceLoops(vm,1))
end
assert(calls.attachment==1 and calls.bone==1 and calls.sequence==1 and calls.info==2)
vm.model='dual'
assert(MCV.CachedAttachment(vm,'muzzle')==1 and calls.attachment==2)
assert(MCV.CachedSequence(vm,'idle')==0 and calls.sequence==2)
assert(not MCV.SequenceLoops(vm,0) and calls.info==3)
vm.model='loading'; vm.ready=false
assert(MCV.CachedAttachment(vm,'muzzle')==0)
assert(MCV.CachedBone(vm,'hand')==nil)
assert(MCV.CachedSequence(vm,'idle')==-1)
assert(not MCV.SequenceLoops(vm,1))
vm.ready=true
assert(MCV.CachedAttachment(vm,'muzzle')==1)
assert(MCV.CachedBone(vm,'hand')==0)
assert(MCV.CachedSequence(vm,'idle')==0)
assert(MCV.SequenceLoops(vm,1))
local other=setmetatable({model=vm.model},{__index=vm})
local previous=calls.attachment
assert(MCV.CachedAttachment(other,'muzzle')==1 and calls.attachment==previous+1)
''')
lua.execute('''
function IsValid(v) return v~=nil end
function IsFirstTimePredicted() return first~=false end
game={SinglePlayer=function() return false end}
shots=0; events={}
owner={IsPlayer=function() return true end,GetViewModel=function() return vm end,
    GetShootPos=function() shots=shots+1; return 99 end}
function RecipientFilter() return {AddPVS=function() end,RemovePlayer=function() end} end
function EffectData()
    return {SetEntity=function() end,SetFlags=function() end,SetOrigin=function() end,
        SetAttachment=function(self,v) self.attachment=v end,
        SetMagnitude=function(self,v) self.left=v end}
end
util={Effect=function(name,data) events[#events+1]={name=name,id=data.attachment,left=data.left} end}
function SWEP:GetOwner() return owner end
function SWEP:GetAkimbo() return dual end
function SWEP:GetFiremodeValue() return mode end
function SWEP:Clip1() return clip end
SWEP.EjectBrassType=1; SWEP.VolleyCount=2
''')
lua.execute(to_lua((root/'lua/weapons/mcv_base/sh_effects.lua').read_text()))
lua.execute('''
dual=false; mode=1; clip=5; SWEP:DoEject()
assert(#events==1 and events[1].id==2 and events[1].left==0)
dual=true; SWEP:DoEject(); assert(events[2].id==3 and events[2].left==1)
mode=5; clip=4; SWEP:DoEject()
assert(#events==4 and events[3].id==2 and events[4].id==3)
SWEP:DoEject('missing'); assert(events[5].id==2 and events[5].left==0)
assert(shots==5) -- one engine position read for each dispatched effect
first=false; SWEP:DoEject(); assert(#events==5)
''')
print('PASS: 10,000 cached model queries; entity/model invalidation, delayed metadata, sequence zero/non-loop flags, single/dual/volley/fallback/replay shell routing')

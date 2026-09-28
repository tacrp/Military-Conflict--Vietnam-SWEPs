"""Impact history pruning must scale with expirations rather than frame count."""
from pathlib import Path
from lupa import LuaRuntime
from glua_check import to_lua
root=Path(__file__).resolve().parents[1]
lua=LuaRuntime()
lua.execute('''
now=0; effects=0; hooks={}; MCV={BulletImpact=function() effects=effects+1 end}
function UnPredictedCurTime() return now end
hook={Add=function(event,name,fn) hooks[event]=fn end}; net={Receive=function() end}
local V={}; V.__index=V
function Vector(x) return setmetatable({x=x},V) end
function V.__sub(a,b) return Vector(a.x-b.x) end
function V:Length() return math.abs(self.x) end
function hit(key,pos) MCV.PhysicalBulletImpact(key,0,{Hit=true,HitPos=Vector(pos or 0)},40) end
function upvalue(fn,key)
    for i=1,100 do local name,v=debug.getupvalue(fn,i); if name==key then return v,i end end
    error('missing upvalue '..key)
end
''')
lua.execute(to_lua((root/'lua/mcv/client/cl_physbullet_impacts.lua').read_text()))
lua.execute('''
for i=1,1000 do hit('quiet'..i) end
local queue,slot=upvalue(hooks.Think,'expirations')
local reads=0
debug.setupvalue(hooks.Think,slot,setmetatable({}, {
    __index=function(_,k) reads=reads+1; return queue[k] end,
    __newindex=function(_,k,v) queue[k]=v end}))
now=1
for frame=1,10000 do hooks.Think() end
assert(reads==10000) -- one oldest-entry read, not 1,000 per frame
hit('quiet1'); assert(effects==1000)
now=15; hooks.Think(); hit('quiet1'); assert(effects==1000) -- strict expiry boundary
now=15.01; hooks.Think(); hit('quiet1'); assert(effects==1001)
hooks.PostCleanupMap(); now=0
for i=1,1500 do hit('a'..i) end
now=5
for i=1,1500 do hit('b'..i) end
hit('a1',100) -- corrected contact with a later expiry
now=16; hooks.Think()
local contacts=upvalue(hooks.Think,'contacts')
assert(contacts['a1:0'] and contacts['b1500:0'] and not contacts['a2:0'])
assert(upvalue(hooks.Think,'head')==1) -- compaction retained ordered live entries
local before=effects; hit('a1',100); assert(effects==before)
now=20.01; hooks.Think()
contacts=upvalue(hooks.Think,'contacts'); assert(next(contacts)==nil)
hit('rollback'); now=1; hit('rollback'); assert(effects==before+2)
hooks.PostCleanupMap(); hit('rollback'); assert(effects==before+3)
''')
print('PASS: 10,000 oldest-entry checks instead of 10 million history visits; strict expiry, corrected contacts, queue compaction, rollback and cleanup')

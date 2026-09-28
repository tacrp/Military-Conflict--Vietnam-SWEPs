"""LuaJIT operation counts and numeric equivalence, not an engine/FPS benchmark."""
from pathlib import Path
import subprocess
from lupa.luajit21 import LuaRuntime
from glua_check import to_lua

root=Path(__file__).resolve().parents[1]
old=subprocess.check_output(['git','show','e9b2e0895:lua/mcv/shared/sh_physbullets.lua'],cwd=root).decode()
new=(root/'lua/mcv/shared/sh_physbullets.lua').read_text()
def function(source, name):
    text=source[source.index('function MCV.'+name+'('):]
    return text[:text.index('\nend')+4]
lua=LuaRuntime()
lua.execute('''
MCV={}; allocations=0; MASK_SHOT=1
local V={}; V.__index=V
function Vector(x,y,z)
    allocations=allocations+1
    return setmetatable({x=x,y=y,z=z},V)
end
function V.__add(a,b) return Vector(a.x+b.x,a.y+b.y,a.z+b.z) end
function V.__mul(a,b) return Vector(a.x*b,a.y*b,a.z*b) end
''')
lua.execute(to_lua(function(old,'BulletFlightStep')))
lua.execute('oldStep=MCV.BulletFlightStep')
lua.execute(to_lua(function(new,'BulletFlightStep')))
lua.execute(to_lua(function(new,'TracePhysicalBullet')))
lua.execute('''
local p,v=Vector(300,600,900),Vector(5000,-2000,700)
for _,drag in ipairs({0,0.2,2}) do
    for _,dt in ipairs({0,1/120,1/66,0.1}) do
        local a,b=oldStep(p,v,dt,386,drag)
        local c,d=MCV.BulletFlightStep(p,v,dt,386,drag)
        for _,k in ipairs({'x','y','z'}) do
            assert(math.abs(a[k]-c[k])<1e-8 and math.abs(b[k]-d[k])<1e-8)
        end
    end
    allocations=0
    for i=1,10000 do oldStep(p,v,1/120,386,drag) end
    local before=allocations; allocations=0
    for i=1,10000 do MCV.BulletFlightStep(p,v,1/120,386,drag) end
    assert(allocations==20000 and before>allocations)
    print('10,000 steps, drag '..drag..': '..before..' -> '..allocations..' vector constructions')
end
local requests={}; util={TraceLine=function(t) requests[t]=true; return {} end}
local a={owner={},wep={}}; local b={owner={},wep={}}
for i=1,10000 do MCV.TracePhysicalBullet(a,p,v); MCV.TracePhysicalBullet(b,v,p) end
local count=0; for _ in pairs(requests) do count=count+1 end
assert(count==2 and a.traceRequest.filter~=b.traceRequest.filter)
assert(a.traceRequest.filter[1]==a.owner and a.traceRequest.filter[2]==a.wep)
assert(a.traceRequest.start==p and b.traceRequest.start==v)
''')
print('PASS: analytic parity; two trace requests/filters reused across 20,000 calls; per-bullet isolation')

hud=(root/'lua/mcv/weapon_common/cl_hud.lua').read_text()
hints=hud[hud.index('function SWEP:DrawHUDHints('):hud.index('// Default hints;')]
lua.execute('''
SWEP={HUDHintsStart=0}; now=10; hintCalls=0; mode=1
function CurTime() return now end
function math.Clamp(v,a,b) return math.max(a,math.min(b,v)) end
function SWEP:GetControlHints() hintCalls=hintCalls+1; return {} end
''')
lua.execute('local cv_hints={GetInt=function() return mode end}; local HUD={HintDuration=6,HintFade=1}\n'+to_lua(hints))
lua.execute('''
for i=1,10000 do SWEP:DrawHUDHints(1) end
assert(hintCalls==0)
now=0; SWEP:DrawHUDHints(1); assert(hintCalls==1)
now=10; mode=3; SWEP:DrawHUDHints(1); assert(hintCalls==2)
''')
print('PASS: expired HUD hints skip 10,000 hint-table builds; deploy and always-on hints preserved')

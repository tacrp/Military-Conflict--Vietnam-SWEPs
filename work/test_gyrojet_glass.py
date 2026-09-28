"""Powered flight/range math and trigger-glass routing, outside the game."""
from pathlib import Path
from lupa import LuaRuntime
from glua_check import to_lua

root=Path(__file__).resolve().parents[1]
lua=LuaRuntime()
lua.execute('''
MCV={}; hooks={}; candidates={}; searches=0; shots=0; FSOLID_TRIGGER=8
bit={band=function(a,b) return a & b end}
function IsValid(v) return type(v)=='table' and not v.invalid end
function math.Clamp(v,a,b) return math.min(b,math.max(a,v)) end
math.pow=function(a,b) return a^b end
function near(a,b) assert(math.abs(a-b)<0.00001,tostring(a)..' != '..tostring(b)) end
local V={}; V.__index=V
function Vector(x,y,z) return setmetatable({x=x or 0,y=y or 0,z=z or 0},V) end
function V.__add(a,b) return Vector(a.x+b.x,a.y+b.y,a.z+b.z) end
function V.__sub(a,b) return Vector(a.x-b.x,a.y-b.y,a.z-b.z) end
function V.__mul(a,b) return Vector(a.x*b,a.y*b,a.z*b) end
function V:Length() return math.sqrt(self.x^2+self.y^2+self.z^2) end
function V:GetNormalized() return self*(1/self:Length()) end
vector_origin=Vector()
hook={Add=function(e,n,f) hooks[e]=f end}
ents={FindByClass=function() return {} end,FindAlongRay=function(a,b)
    searches=searches+1; searchFrom=a; searchTo=b; return candidates end}
''')
lua.execute(to_lua((root/'lua/mcv/shared/sh_physbullets.lua').read_text()))
lua.execute(to_lua((root/'lua/mcv/server/sv_physbullet_glass.lua').read_text()))
lua.execute('''
-- The analytic powered/coasting split agrees across tick rates and drag values.
local boost=Vector(1815/0.0254,0,0); local initial=Vector(40/0.0254,0,0)
for _,drag in ipairs({0,0.5,2}) do
    for _,time in ipairs({0.1,0.2,0.3,2}) do
        local p,v=MCV.BulletFlightStep(Vector(),initial,time,386,drag,boost,0.2)
        for _,steps in ipairs({30,66,120,144}) do
            local pp,vv=Vector(),initial; local dt=time/steps
            for i=1,steps do pp,vv=MCV.BulletFlightStep(pp,vv,dt,386,drag,boost,0.2-(i-1)*dt) end
            near(p.x,pp.x); near(p.z,pp.z); near(v.x,vv.x); near(v.z,vv.z)
        end
    end
end
local _,v=MCV.BulletFlightStep(Vector(),initial,0.2,0,0,boost,0.2); near(v.x,403/0.0254)
local p2,v2=MCV.BulletFlightStep(Vector(),v,1,0,0,boost,0); near(v2.x,v.x)
-- Deliberate, capped distance ramp; penetration damage is a separate input.
gyro={DamageRampStart=0.25,DamageRampEnd=1.5,DamageRampDistance=2000,RangeModifier=1}
near(MCV.BulletRangeMultiplier(gyro,0),0.25)
near(MCV.BulletRangeMultiplier(gyro,1000),0.875)
near(MCV.BulletRangeMultiplier(gyro,2000),1.5)
near(MCV.BulletRangeMultiplier(gyro,56756),1.5)
near(MCV.BulletRangeMultiplier({RangeModifier=0.9},1000),0.81)
-- Cold maps do not perform a spatial query per bullet substep.
local owner={FireBullets=function(s,t)
    shots=shots+1; shot=t; assert(t.Num==1 and t.Tracer==0)
    local result=t.Callback(); assert(result.damage==false and result.effects==false)
end}
local b={owner=owner,wep=gyro,damage=15,distance=1000}
MCV.PhysicalBulletGlass(b,Vector(0,0,0),Vector(10,0,0)); assert(searches==0)
local glass={GetClass=function() return 'func_breakable_surf' end,
    GetSolidFlags=function(s) return s.flags or 0 end}
hooks.OnEntityCreated(glass); candidates={glass}
MCV.PhysicalBulletGlass(b,Vector(),Vector(10,0,0)); assert(shots==0) -- solid contact uses ordinary hit path
glass.flags=4 -- FSOLID_NOT_SOLID alone is not a trigger
MCV.PhysicalBulletGlass(b,Vector(),Vector(10,0,0)); assert(shots==0)
glass.flags=FSOLID_TRIGGER+4 -- flags are a bitmask, not an equality comparison
MCV.PhysicalBulletGlass(b,Vector(),Vector(10,0,0)); assert(shots==1)
near(shot.Distance,10); near(shot.Damage,15*0.875)
assert(shot.Src==searchFrom and shot.Attacker==owner and shot.Inflictor==gyro)
-- Multiple trigger panes use one native segment, and removal/map cleanup retire tracking.
candidates={glass,glass}; MCV.PhysicalBulletGlass(b,Vector(),Vector(20,0,0)); assert(shots==2)
hooks.EntityRemoved(glass); local count=searches
MCV.PhysicalBulletGlass(b,Vector(),Vector(20,0,0)); assert(searches==count)
hooks.OnEntityCreated(glass); hooks.PostCleanupMap()
MCV.PhysicalBulletGlass(b,Vector(),Vector(20,0,0)); assert(searches==count)
''')
print('PASS: powered flight tick/drag parity, bounded increasing damage, trigger-only glass routing and cleanup')
lua.execute('''
SWEP={GetBulletCount=function() return 1 end}
MAT_METAL=1; MAT_GRATE=2; MAT_VENT=3; MAT_GLASS=4; MAT_CONCRETE=5; MAT_TILE=6; MAT_WOOD=7
''')
lua.execute(to_lua((root/'lua/weapons/mcv_base/sh_penetration.lua').read_text()))
lua.execute('''
setmetatable(gyro,{__index=SWEP})
local damage={GetDamage=function(s) return s.value end,SetDamage=function(s,n) s.value=n end}
for _,base in ipairs({15,7.5}) do -- cover reduces the base, not the range already applied
    local previous=0
    for _,distance in ipairs({0,500,1000,2000,10000}) do
        damage.value=base; gyro:ApplyBulletDamage({},damage,distance,1)
        near(damage.value,base*MCV.BulletRangeMultiplier(gyro,distance))
        assert(damage.value>=previous); previous=damage.value
    end
end
''')
print('PASS: actual shared damage callback preserves increasing range response after cover attenuation')

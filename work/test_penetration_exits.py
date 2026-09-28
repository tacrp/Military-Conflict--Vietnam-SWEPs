"""Actual exit probing, impact routing and decal projection with offline engine stubs."""
import re
from pathlib import Path
from lupa import LuaRuntime
from glua_check import to_lua

ROOT = Path(__file__).resolve().parents[1]
lua = LuaRuntime()
impact = (ROOT/'lua/mcv/shared/sh_impacts.lua').read_text()
penetration = (ROOT/'lua/weapons/mcv_base/sh_penetration.lua').read_text()
for i, name in enumerate(sorted(set(re.findall(r'\bMAT_\w+', impact+penetration))), 1):
    lua.globals()[name] = i
lua.execute('''
MCV={ConVars={},SurfaceDecals={wood=true,metal=true,concrete=true}}; SWEP={}; EFFECT={}
DMG_BULLET=2; PATTACH_ABSORIGIN_FOLLOW=1; MASK_SHOT=1; enabled=true; custom=true
function MCV.RegisterConVar(name) MCV.ConVars[name]={GetBool=function() return custom end} end
function MCV.BulletPenetration() return enabled end
function IsValid(v) return type(v)=='table' and not v.invalid end
function math.Clamp(v,a,b) return math.max(a,math.min(b,v)) end
math.pow=function(a,b) return a^b end
function string.StartWith(s,prefix) return s:sub(1,#prefix)==prefix end
function CurTime() return 0 end
function PrecacheParticleSystem() end
game={AddParticles=function() end}
local V={}; V.__index=V
function Vector(x,y,z) return setmetatable({x=x or 0,y=y or 0,z=z or 0},V) end
function V.__add(a,b) return Vector(a.x+b.x,a.y+b.y,a.z+b.z) end
function V.__sub(a,b) return Vector(a.x-b.x,a.y-b.y,a.z-b.z) end
function V.__mul(a,b) return Vector(a.x*b,a.y*b,a.z*b) end
function V:Dot(b) return self.x*b.x+self.y*b.y+self.z*b.z end
function V:LengthSqr() return self:Dot(self) end
function V:Length() return math.sqrt(self:LengthSqr()) end
function V:GetNormalized() return self*(1/self:Length()) end
function V:Angle() return {Forward=function() return self end,Right=function() return Vector(0,1,0) end,Up=function() return Vector(0,0,1) end} end
vector_up=Vector(0,0,1)
function near(a,b) assert(math.abs(a-b)<1e-6,tostring(a)..' != '..tostring(b)) end
function EffectData() return setmetatable({}, {__index=function(_,key)
    local name=key:sub(4)
    if key:sub(1,3)=='Set' then return function(s,v) s[name]=v end end
    return function(s) return s[name] end
end}) end
decals={}; particles={}; stock={}
util={GetSurfaceData=function(id) return {name=id==1 and 'wood' or 'metal'} end}
function util.Decal(name,from,to) decals[#decals+1]={name=name,from=from,to=to} end
function EFFECT:SetPos(v) self.pos=v end
function EFFECT:SetAngles(v) self.ang=v end
function CreateParticleSystem(ent,name)
    local p={ent=ent,name=name,points={}}
    function p:SetControlPoint(i,v) self.points[i]=v end
    function p:SetControlPointOrientation(i,f) if i==1 then self.normal=f end end
    function p:StartEmission() end
    particles[#particles+1]=p; return p
end
function util.Effect(name,data)
    if name=='mcv_impact' then setmetatable({}, {__index=EFFECT}):Init(data)
    else assert(name=='Impact'); stock[#stock+1]=data end
end
owner={}
function SWEP:GetOwner() return owner end
function SWEP:StatMult() return 1 end
SWEP.WoodPenetrationDepth=4; SWEP.WoodDamageModifier=1; SWEP.RangeModifier=0.8
function queueHit(state)
    local queue={}; SWEP:QueuePenetration(entry,state or {damage=40,distance=0,budget=1,layers=0},queue)
    return queue
end
''')
lua.execute(to_lua((ROOT/'lua/mcv/shared/sh_physbullets.lua').read_text()))
lua.execute(to_lua(penetration))
lua.execute(to_lua(impact))
lua.execute(to_lua((ROOT/'lua/effects/mcv_impact.lua').read_text()))
lua.execute('''
for _,world in ipairs({false,true}) do
    cover={invalid=world,IsPlayer=function() return false end,IsNPC=function() return false end,IsNextBot=function() return false end}
    entry={Hit=true,HitWorld=world,Entity=cover,HitPos=Vector(10,0,0),StartPos=Vector(),HitNormal=Vector(-1,0,0),MatType=MAT_WOOD,SurfaceProps=1}
    local back
    util.TraceLine=function(t)
        assert(t.mask==MASK_SHOT)
        if world then assert(t.filter==owner and not t.whitelist)
        else assert(t.whitelist and t.filter[1]==cover) end
        if t.start.x<=12 then return {Hit=true,StartSolid=true} end
        back={Hit=true,HitWorld=world,Entity=cover,HitPos=Vector(12,0,0),StartPos=t.start,
            HitNormal=Vector(1,0,0),MatType=MAT_METAL,SurfaceProps=2}
        return back
    end
    local q=queueHit(); assert(#q==1 and q[1].exitTrace==back)
    near(q[1].damage,20); near(q[1].distance,12.03125)
    near(q[1].exitDamage,20*0.8^(12/500))
    assert(q[1].layers==1 and entry.HitNormal.x==-1)
    custom=true; decals={}; particles={}
    MCV.BulletImpact(entry,40)
    MCV.BulletImpact(q[1].exitTrace,q[1].exitDamage)
    assert(#decals==2 and #particles==2)
    assert(decals[1].name=='MCV.Impact.wood' and decals[2].name=='MCV.Impact.metal')
    near(decals[1].from.x,6); near(decals[1].to.x,14)
    near(decals[2].from.x,16); near(decals[2].to.x,8)
    assert(particles[2].name:find('mcv_scaled_impact_metal_',1,true)==1)
    assert(particles[2].normal.x==1 and particles[2].points[1].x==12)
    near(particles[2].points[2].x,MCV.ImpactScale(q[1].exitDamage))
    custom=false; stock={}
    MCV.BulletImpact(q[1].exitTrace,q[1].exitDamage)
    assert(#stock==1 and stock[1].Origin.x==12 and stock[1].Normal.x==1 and stock[1].SurfaceProp==2)
    assert(#decals==2) -- stock effect owns its own decal; no extra custom mark
    enabled=false; assert(#queueHit()==0); enabled=true
    assert(#queueHit({damage=40,distance=0,budget=1,layers=4})==0)
    assert(#queueHit({damage=40,distance=0,budget=0.1,layers=0})==0)
    assert(#queueHit({damage=1,distance=0,budget=1,layers=0})==0)
    assert(#queueHit({damage=40,distance=56750,budget=1,layers=0})==0)
    entry.HitSky=true; assert(#queueHit()==0); entry.HitSky=false
    entry.StartSolid=true; assert(#queueHit()==0); entry.StartSolid=false
    entry.MatType=MAT_FLESH; assert(#queueHit()==0); entry.MatType=MAT_WOOD
    if not world then cover.IsNPC=function() return true end; assert(#queueHit()==0) end
end
''')
print('PASS: world/prop exit trace, far-face material/normal, attenuated scale, native decal+particle and stock fallback')
print('PASS: disabled/stopped/insufficient-budget/sky/solid/body hits create no exit; damage state stays separate')

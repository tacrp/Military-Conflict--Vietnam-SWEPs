"""Exercise real cosmetic-impact Lua: probability, reflection and contact ownership."""
from pathlib import Path
import re
import struct
import itertools
from lupa import LuaRuntime
from glua_check import to_lua
from dmxlib import DMX
from build_ricochet import build, references, neutral_texture

ROOT = Path(__file__).resolve().parents[1]
# A valid material and live particles do not prove that a renderer can draw them.
# Live A/B testing found SpriteCard invisible with this render_sprite_trail asset.
spark_material = (ROOT / 'materials/effects/vietnam/vietnam_sparktrails_1.vmt').read_text()
assert re.match(r'\s*"UnlitGeneric"', spark_material, re.I), 'spark trails require the original UnlitGeneric shader'
lua = LuaRuntime()
shared = (ROOT / 'lua/mcv/shared/sh_impacts.lua').read_text()
for i, name in enumerate(sorted(set(re.findall(r'\bMAT_\w+', shared)) | {'MAT_FLESH'}), 1):
    lua.globals()[name] = i
lua.execute('''
MCV={ConVars={},SurfaceDecals={metal=true,concrete=true}}; EFFECT={}
CLIENT=true; SERVER=false; DMG_BULLET=2; PATTACH_ABSORIGIN=0; PATTACH_ABSORIGIN_FOLLOW=1
clock=1; custom=true; roll=0; first=true; sp=false
function CurTime() return clock end
function UnPredictedCurTime() return clock end
function IsFirstTimePredicted() return first end
function IsValid(v) return type(v)=='table' and not v.invalid end
function Color(r,g,b) return {r=r,g=g,b=b} end
function math.Clamp(v,a,b) return math.min(math.max(v,a),b) end
function math.Rand() return roll end
math.random=function() return 1 end
function string.StartWith(s,prefix) return s:sub(1,#prefix)==prefix end
game={AddParticles=function() end,SinglePlayer=function() return sp end}
function MCV.RegisterConVar(name) MCV.ConVars[name]={GetBool=function() return custom end} end
function PrecacheParticleSystem() end
local V={}; V.__index=V
function Vector(x,y,z) return setmetatable({x=x or 0,y=y or 0,z=z or 0},V) end
function V.__add(a,b) return Vector(a.x+b.x,a.y+b.y,a.z+b.z) end
function V.__sub(a,b) return Vector(a.x-b.x,a.y-b.y,a.z-b.z) end
function V.__mul(a,b) return Vector(a.x*b,a.y*b,a.z*b) end
function V:Dot(b) return self.x*b.x+self.y*b.y+self.z*b.z end
function V:LengthSqr() return self:Dot(self) end
function V:Length() return math.sqrt(self:LengthSqr()) end
function V:Normalize() local n=self:Length(); self.x=self.x/n;self.y=self.y/n;self.z=self.z/n end
function V:Cross(b) return Vector(self.y*b.z-self.z*b.y,self.z*b.x-self.x*b.z,self.x*b.y-self.y*b.x) end
function V:AngleEx(up)
    local f=self*1;f:Normalize()
    local u=up-f*f:Dot(up);u:Normalize()
    local r=f:Cross(u)
    return {Forward=function() return f end,Right=function() return r end,Up=function() return u end}
end
function V:Angle()
    return {Forward=function() return self end,Right=function() return Vector(0,1,0) end,
        Up=function() return Vector(0,0,1) end}
end
vector_up=Vector(0,0,1)
function near(a,b) assert(math.abs(a-b)<1e-5,tostring(a)..' != '..tostring(b)) end
function vecnear(a,b) near(a.x,b.x);near(a.y,b.y);near(a.z,b.z) end
function EffectData() return setmetatable({}, {__index=function(_,key)
    local field=key:sub(4)
    if key:sub(1,3)=='Set' then return function(s,v) s[field]=v end end
    return function(s) return s[field] or 0 end
end}) end
particles={}; sounds={}; decals={}; events={}; owners={}
util={GetSurfaceData=function() return {name=surface or 'metal'} end}
function util.Decal(name,a,b) decals[#decals+1]={name=name,a=a,b=b} end
local function forbidden() error('cosmetic ricochet performed gameplay work') end
util.TraceLine=forbidden; util.TraceHull=forbidden; util.BlastDamage=forbidden
function EFFECT:FireBullets() forbidden() end
function EFFECT:SetPos(p) self.pos=p end
function EFFECT:SetAngles(a) self.angles=a end
function CreateParticleSystem(ent,name,attach)
    if failRicochet and name=='mcv_ricochet' then return nil end
    local p={name=name,owner=ent,attach=attach,points={},directions={},rights={},ups={},
        bornPos=ent.pos,bornForward=ent.angles:Forward(),bornUp=ent.angles:Up()}
    function p:SetControlPoint(i,v) self.points[i]=v end
    function p:SetControlPointOrientation(i,f,r,u) self.directions[i]=f;self.rights[i]=r;self.ups[i]=u end
    function p:StartEmission()
        assert(self.points[0] and self.points[1] and self.points[2])
        assert(self.directions[0] and self.directions[1]); self.started=true
    end
    function p:UpdateAttachment()
        if self.attach==PATTACH_ABSORIGIN_FOLLOW then
            self.points[0]=ent.pos
            self.directions[0]=ent.angles:Forward()
            self.rights[0]=ent.angles:Right()
            self.ups[0]=ent.angles:Up()
        end
    end
    particles[#particles+1]=p; return p
end
sound={Play=function(path,pos,level,pitch,volume)
    assert(level==87 and pitch==100 and volume==0.7)
    sounds[#sounds+1]={path=path,pos=pos}
end}
function util.Effect(name,data,allow,recipients)
    events[#events+1]={name=name,data=data,recipients=recipients}
    if name=='mcv_impact' then
        local e=setmetatable({}, {__index=EFFECT}); owners[#owners+1]=e; e:Init(data)
    else assert(name=='Impact') end
end
function clear() particles={};sounds={};decals={};events={};owners={} end
function contact(angle)
    local a=math.rad(angle); local pos=Vector(100,200,300)
    return {Hit=true,StartPos=pos-Vector(math.cos(a),0,-math.sin(a))*100,
        HitPos=pos,HitNormal=vector_up,SurfaceProps=1,MatType=MAT_METAL}
end
function fire(angle,kind)
    clock=clock+1;surface=kind or 'metal';clear()
    local tr=contact(angle); MCV.BulletImpact(tr,40,nil,true);return tr
end
net={Receive=function() end}; hook={Add=function() end}
''')
for path in ('lua/mcv/shared/sh_tracercolor.lua', 'lua/mcv/shared/sh_impacts.lua', 'lua/effects/mcv_impact.lua',
             'lua/mcv/client/cl_physbullet_impacts.lua'):
    lua.execute(to_lua((ROOT / path).read_text()))
lua.execute('''
-- Actual sender payload and reflected direction; ordinary surface/decal preserved.
local tr=fire(10)
assert(#events==1 and #particles==2 and #sounds==1 and #decals==1)
assert(events[1].data.Start==tr.StartPos and events[1].data.DamageType==DMG_BULLET)
local p=particles[2];assert(p.name=='mcv_ricochet')
vecnear(p.bornPos,p.points[0]);vecnear(p.bornForward,p.directions[0])
vecnear(p.bornUp,p.ups[0])
vecnear(p.points[1],Vector(100,200,300.25));vecnear(p.points[2],Vector(1,1,1))
vecnear(p.directions[1],Vector(math.cos(math.rad(10)),0,math.sin(math.rad(10))))
vecnear(particles[1].directions[1],tr.HitNormal)
-- Source's attachment update runs after Init. Normal and reflected systems
-- share a Lua effect owner; neither CP0 may follow the other's launch pose.
local first=particles[1]
first:UpdateAttachment();p:UpdateAttachment()
vecnear(first.points[0],tr.HitPos);vecnear(first.directions[0],tr.HitNormal)
vecnear(p.points[0],p.bornPos);vecnear(p.directions[0],p.bornForward)
local savedPos,savedDir=p.points[0],p.directions[0]
p.owner:SetPos(Vector(9,8,7));p.owner:SetAngles(vector_up:Angle())
first:UpdateAttachment();p:UpdateAttachment()
vecnear(first.points[0],tr.HitPos);vecnear(first.directions[0],tr.HitNormal)
vecnear(p.points[0],savedPos);vecnear(p.directions[0],savedDir)
assert(sounds[1].path=='mcv/weapons/fx/rics/vietnam_rics_metal_1.wav')
local owner=owners[1];local begin=clock;clock=begin+4.9;assert(owner:Think())
clock=begin+5;assert(not owner:Think())

-- Reflection works against a wall and a ceiling, without changing source data.
for _,normal in ipairs({Vector(-1,0,0),Vector(0,0,-1)}) do
    clock=clock+1;clear();local hit=contact(10);hit.HitNormal=normal
    local incoming=normal*-0.1+Vector(0,math.sqrt(0.99),0)
    hit.StartPos=hit.HitPos-incoming*100
    local start=hit.StartPos;MCV.BulletImpact(hit,40,nil,true)
    assert(#particles==2 and hit.StartPos==start and hit.HitNormal==normal)
    vecnear(particles[2].directions[1],normal*0.1+Vector(0,math.sqrt(0.99),0))
end

-- A uniform deterministic sample measures the real random decision, not just
-- a duplicate probability helper. Expected acceptance bands are percentages.
for _,case in ipairs({{'metal',5,810,830},{'concrete',5,560,580},{'brick',5,460,470},
    {'metal',20,575,590},{'metal',40,390,405},{'metal',45,365,380},{'metal',90,315,330},
    {'wood',5,245,255},{'dirt',5,245,255},{'glass',5,245,255},{'grass',5,245,255}}) do
    local accepted=0
    for i=1,1000 do
        roll=(i-0.5)/1000;fire(case[2],case[1]);accepted=accepted+#sounds
        assert(#decals==1 and #events==1 and #particles==1+#sounds)
    end
    assert(accepted>=case[3] and accepted<=case[4],case[1]..' '..case[2]..': '..accepted)
end
roll=0
fire(0);assert(#particles==1 and #sounds==0) -- tangent/back-facing contact is not incoming
fire(-10);assert(#particles==1 and #sounds==0)

-- Rate limit only applies after an accepted addition. All pellets retain marks.
clock=clock+1;surface='metal';clear();local hit=contact(5)
roll=1;MCV.BulletImpact(hit,40,nil,true);assert(#sounds==0)
roll=0
for i=1,100 do MCV.BulletImpact(hit,40,nil,true) end
assert(#sounds==1 and #decals==101 and #particles==102)
clock=clock+0.124;MCV.BulletImpact(hit,40,nil,true);assert(#sounds==1)
clock=clock+0.002;MCV.BulletImpact(hit,40,nil,true);assert(#sounds==2)
clock=1;MCV.BulletImpact(hit,40,nil,true);assert(#sounds==3) -- map-clock rollback

-- Melee, chainsaw, bolts, exit traces and malformed/no-direction callers don't opt in.
clock=clock+1;clear()
MCV.SurfaceImpact(hit,40);MCV.BulletImpact(hit,40);MCV.BulletImpact(hit,40,nil,false)
assert(#particles==3 and #decals==3 and #sounds==0)
hit.StartPos=hit.HitPos;MCV.BulletImpact(hit,40,nil,true);assert(#sounds==0)
hit.StartPos=nil;MCV.BulletImpact(hit,40,nil,true);assert(#sounds==0)
for _,flag in ipairs({'HitSky','StartSolid','AllSolid'}) do
    local bad=contact(5);bad[flag]=true;local n=#events
    MCV.BulletImpact(bad,40,nil,true);assert(#events==n)
end
custom=false;fire(5);assert(#particles==0 and #sounds==0 and #events==1 and events[1].name=='Impact')
custom=true;failRicochet=true;fire(5);assert(#sounds==0 and #particles==1 and #decals==1)
failRicochet=false

-- Physical contact confirmation cannot replay the extra sound/particle, even
-- after the rate limiter becomes available. Odd contact IDs are exit faces.
clock=clock+1;clear();local hit=contact(5)
MCV.PhysicalBulletImpact('predicted',0,hit,40,true)
assert(#sounds==1 and #particles==2)
clock=clock+1;MCV.PhysicalBulletImpact('predicted',0,hit,40,true)
assert(#sounds==1 and #particles==2)
MCV.PhysicalBulletImpact('predicted',1,hit,40)
assert(#sounds==1 and #particles==3 and #decals==2)
MCV.PhysicalBulletImpact('remote',0,hit,40,true)
assert(#sounds==2 and #particles==5 and #decals==3)
''')
print('PASS: hardness/angle probability (11,000 samples), reflection, original decals, bounded emission and rollback')
print('PASS: cosmetic-only dispatch, invalid/stock/melee/exit exclusion, particle failure and physical confirmation dedup')
lua.execute('''
local shooter={mode='0',IsPlayer=function() return true end,
    GetInfo=function(s) return s.mode end,
    GetPlayerColor=function() return Vector(0,0.5,1) end,
    GetWeaponColor=function() return Vector(1,0,0.5) end}
for _,mode in ipairs({'0','1','2'}) do
    shooter.mode=mode
    local c=MCV.TracerColor(shooter,'vietnam_tracer_rifle_green_primary')
    local expected=mode=='0' and Vector(96,235,51) or (mode=='1' and Vector(0,127.5,255) or Vector(255,0,127.5))
    vecnear(Vector(c.r,c.g,c.b),expected)
    for _,damage in ipairs({10,40,160}) do
        clock=clock+1;clear();surface='wood'
        MCV.BulletImpact(contact(90),damage,nil,true,c)
        local p=particles[2];assert(p)
        -- The network payload quantizes blue to a byte.
        vecnear(p.points[3],Vector(c.r,c.g,math.floor(c.b+0.5))*(1/255))
        local scale=math.sqrt(damage/40)
        vecnear(p.points[2],Vector(scale,scale,scale))
    end
end
assert(not MCV.HasTracerStreak('vietnam_tracer_silenced_primary'))
assert(not MCV.HasTracerStreak('vietnam_tracer_shotgun_dots_primary'))
assert(not MCV.HasTracerStreak(''))
clock=clock+1;clear()
MCV.PhysicalBulletImpact('no-tracer',0,contact(90),40,false)
assert(#sounds==0)
-- Unknown/flesh surfaces retain the stock effect and can add a terminal tracer.
clock=clock+1;clear();surface='flesh'
local tr=contact(90);tr.MatType=MAT_FLESH
MCV.BulletImpact(tr,40,nil,true)
assert(#particles==1 and #sounds==1 and #events==2 and events[2].name=='Impact')
''')
print('PASS: native/player/physgun colour, power scaling, direct soft/body hits and no-tracer suppression')

asset = (ROOT / 'particles/mcv_ricochet.pcf').read_bytes()
assert (ROOT / 'materials/effects/mcv/ricochet.vtf').read_bytes() == neutral_texture()
from vtf_invert_alpha import _image_data_offset
original_texture = (ROOT / 'materials/effects/vietnam/vietnam_sparktrails_1.vtf').read_bytes()
neutral = neutral_texture()
offset = _image_data_offset(neutral)
assert original_texture[:offset] == neutral[:offset]
for at in range(offset, len(neutral), 8):
    old = struct.unpack_from('<HH', original_texture, at)
    new = struct.unpack_from('<HH', neutral, at)
    assert (old[0] > old[1]) == (new[0] > new[1])
    assert original_texture[at+4:at+8] == neutral[at+4:at+8]
assert build() == asset == build(), 'rebuild must be deterministic and match installed PCF'
dmx = DMX(asset)
systems = {e.name: e for _, e in dmx.by_type('DmeParticleSystemDefinition')}
assert set(systems) == {'mcv_ricochet', 'mcv_ricochet_trail'}
assert all(0 <= ref < len(dmx.elements) for e in dmx.elements for ref in references(e))
parent = systems['mcv_ricochet']
children = [dmx.elements[dmx.elements[i].get('child')].name for i in parent.get('children')]
assert children == ['mcv_ricochet_trail']
emitter, = (dmx.elements[i] for i in parent.get('emitters'))
assert struct.unpack('<i', emitter.get('num_to_emit_minimum')) == (1,)
assert struct.unpack('<i', emitter.get('num_to_emit')) == (1,)
assert 'game.AddParticles("particles/mcv_ricochet.pcf")' in shared
assert 'PrecacheParticleSystem("mcv_ricochet")' in shared

# Prove the original failure from real assets, not from a particle-handle mock:
# the donor accepts zero parent particles and the trail requires a parent.
donor = DMX((ROOT / 'particles/mcv_scaled_impacts.pcf').read_bytes())
original = {e.name: e for _, e in donor.by_type('DmeParticleSystemDefinition')}
old_parent = original['mcv_scaled_impact_metal_flying']
old_emitter = donor.elements[old_parent.get('emitters')[0]]
assert struct.unpack('<i', old_emitter.get('num_to_emit_minimum')) == (0,)
trail = systems['mcv_ricochet_trail']
assert any(dmx.elements[i].get('functionName') == 'Position From Parent Particles'
           for i in trail.get('initializers'))

# Preserve the donor art/physics/scaling except these two deliberate changes.
for name, system in systems.items():
    assert system.get('material') == 'effects/mcv/ricochet.vmt'
    tint = dmx.elements[system.get('operators')[-1]]
    assert tint.get('functionName') == 'Remap Control Point to Vector'
    assert struct.unpack('<i', tint.get('input control point number')) == (3,)
    assert struct.unpack('<i', tint.get('output field')) == (6,)
    old = original['mcv_scaled_impact_metal_flying' + ('_trail' if name.endswith('_trail') else '')]
    for group in ('initializers', 'operators', 'emitters', 'renderers', 'constraints', 'forces'):
        assert len(system.get(group)) == len(old.get(group)) + (group == 'operators')
        for new_id, old_id in zip(system.get(group), old.get(group)):
            new_attrs = {k: v for k, _, v in dmx.elements[new_id].attrs}
            old_attrs = {k: v for k, _, v in donor.elements[old_id].attrs}
            if name == 'mcv_ricochet':
                if new_attrs['functionName'] == 'emit_instantaneously':
                    old_attrs['num_to_emit_minimum'] = struct.pack('<i', 1)
                if new_attrs['functionName'] == 'Position Within Sphere Random':
                    old_attrs['control_point_number'] = struct.pack('<i', 0)
                    x, y, _ = struct.unpack('<3f', old_attrs['speed_in_local_coordinate_system_min'])
                    old_attrs['speed_in_local_coordinate_system_min'] = struct.pack('<3f', x, y, 25)
            assert new_attrs == old_attrs, (name, group)

# Read velocity ranges from the shipped PCF and combine with the actual Lua
# control-point basis. Even its extreme velocities must leave every tested face.
position = next(dmx.elements[i] for i in parent.get('initializers')
                if dmx.elements[i].get('functionName') == 'Position Within Sphere Random')
lo = struct.unpack('<3f', position.get('speed_in_local_coordinate_system_min'))
hi = struct.unpack('<3f', position.get('speed_in_local_coordinate_system_max'))
launch_cp, = struct.unpack('<i', position.get('control_point_number'))
assert launch_cp == 0
lua.globals().launch_cp = launch_cp
lua.globals().velocity_corners = lua.table_from([
    lua.globals().Vector(*v) for v in itertools.product(*zip(lo, hi))])
lua.execute('''
for _,normal in ipairs({vector_up,Vector(0,0,-1),Vector(1,0,0),Vector(0,-1,0),Vector(1,2,3)}) do
    normal:Normalize()
    local tangent=normal:Cross(Vector(0.7,0.3,0.2));tangent:Normalize()
    for _,angle in ipairs({0.01,1,5,20,44.99}) do
        clock=clock+1;clear();local hit=contact(angle);hit.HitNormal=normal
        local a=math.rad(angle)
        local incoming=tangent*math.cos(a)-normal*math.sin(a)
        hit.StartPos=hit.HitPos-incoming*100
        MCV.BulletImpact(hit,40,nil,true)
        local p=particles[2];assert(p and #sounds==1)
        p:UpdateAttachment()
        vecnear(p.bornForward,tangent*math.cos(a)+normal*math.sin(a))
        vecnear(p.bornPos,hit.HitPos+normal*0.25)
        vecnear(p.directions[launch_cp],p.bornForward)
        near(p.rights[launch_cp]:Dot(normal),0)
        for _,v in ipairs(velocity_corners) do
            local vel=p.directions[launch_cp]*v.x+p.rights[launch_cp]*v.y+p.ups[launch_cp]*v.z
            assert(vel:Dot(normal)>0, 'spark launched into the hit surface')
        end
    end
end
''')
print('PASS: original zero-spark emission reproduced; dedicated graph emits exactly one with outward launch (200 cases)')
print('PASS: engine CP0 starts at reflected launch pose; attachment updates preserve ordinary and ricochet directions')
for family in ('metal', 'concrete'):
    for variant in range(1, 5):
        assert (ROOT / f'sound/mcv/weapons/fx/rics/vietnam_rics_{family}_{variant}.wav').is_file()
for name in ('mcv_ricochet', *children):
    material = systems[name].get('material').replace('\\', '/')
    assert (ROOT / 'materials' / material).is_file(), material
print('PASS: reproducible isolated graph, preserved art/trail/physics, materials and all eight selected sounds')

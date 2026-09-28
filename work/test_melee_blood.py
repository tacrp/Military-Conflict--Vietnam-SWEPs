"""Verify native blood art/dependencies and the client effect lifecycle offline."""
import struct
from pathlib import Path
from lupa import LuaRuntime
from dmxlib import DMX, AT_ELEMENT, AT_ARRAY_BASE
from glua_check import to_lua
from build_melee_blood import DONORS, OUTPUT, PREFIX, ROOT

blood = DMX(OUTPUT.read_bytes())
assert len({e.guid for e in blood.elements}) == len(blood.elements), 'duplicate particle GUIDs'
named = {e.name: i for i, e in blood.by_type('DmeParticleSystemDefinition')}
visited = {0}
for filename, root_name in DONORS:
    original = DMX((ROOT/'particles'/filename).read_bytes())
    source_names = {e.name: i for i, e in original.by_type('DmeParticleSystemDefinition')}
    pending = [(source_names[root_name], named[PREFIX+root_name])]
    pairs = set()
    while pending:
        old, new = pending.pop()
        if (old, new) in pairs:
            continue
        pairs.add((old, new))
        visited.add(new)
        a, b = original.elements[old], blood.elements[new]
        assert a.type == b.type and a.guid != b.guid
        assert b.name == (PREFIX+a.name if a.type == 'DmeParticleSystemDefinition' else a.name)
        assert len(a.attrs) == len(b.attrs)
        for (key, kind, value), (key2, kind2, copied) in zip(a.attrs, b.attrs):
            assert (key, kind) == (key2, kind2)
            if kind == AT_ELEMENT and isinstance(value, int) and value >= 0:
                pending.append((value, copied))
            elif kind == AT_ELEMENT + AT_ARRAY_BASE:
                assert len(value) == len(copied)
                for x, y in zip(value, copied):
                    if isinstance(x, int) and x >= 0:
                        pending.append((x, y))
                    else:
                        assert x == y
            elif key == 'fallback replacement definition' and value:
                assert copied == PREFIX+value
                pending.append((source_names[value], named[copied]))
            else:
                assert value == copied, (a.name, key)
        material = b.get('material')
        if material:
            assert (ROOT/'materials'/material).with_suffix('.vmt').is_file(), material
        if b.get('functionName') == 'Lifetime Random':
            assert struct.unpack('<f', b.get('lifetime_max'))[0] <= 2
        if b.get('functionName') == 'Velocity Set from Control Point':
            assert struct.unpack('<i', b.get('control point number'))[0] == 2
assert visited == set(range(len(blood.elements))), 'unreachable particle content'
assert set(blood.elements[0].get('particleSystemDefinitions')) == set(named.values())
print('PASS: private red/green/orange blood and children preserve original art byte-for-byte; unique IDs and shipped materials')

lua = LuaRuntime()
lua.execute('''
MCV={}; EFFECT={}; now=5; PATTACH_ABSORIGIN_FOLLOW=1
BLOOD_COLOR_RED=0; BLOOD_COLOR_YELLOW=1; BLOOD_COLOR_GREEN=2; BLOOD_COLOR_MECH=3
BLOOD_COLOR_ANTLION=4; BLOOD_COLOR_ZOMBIE=5; BLOOD_COLOR_ANTLION_WORKER=6; DONT_BLEED=-1
game={AddParticles=function(path) assert(path=='particles/mcv_melee_blood.pcf') end}
function PrecacheParticleSystem(name) assert(name:sub(1,10)=='mcv_melee_') end
function AddCSLuaFile() end
function IsValid(v) return type(v)=='table' and not v.invalid end
function CurTime() return now end
local V={}; V.__index=V
function Vector(x,y,z) return setmetatable({x=x or 0,y=y or 0,z=z or 0},V) end
function V:LengthSqr() return self.x^2+self.y^2+self.z^2 end
function V:Angle() return {Forward=function() return self end,Right=function() return self end,Up=function() return self end} end
vector_origin=Vector(); vector_up=Vector(0,0,1)
particles={}
function CreateParticleSystem(ent,name,attachment,id)
    assert(ent.pos and ent.ang and attachment==PATTACH_ABSORIGIN_FOLLOW and id==0)
    if fail then return end
    local p={ent=ent,name=name,points={},orientations={}}
    function p:SetControlPoint(i,v) self.points[i]=v end
    function p:SetControlPointOrientation(i,f,r,u) self.orientations[i]={f,r,u} end
    function p:StartEmission()
        assert(self.points[0]==ent.pos and self.points[1]==ent.pos and self.points[2]==vector_origin)
        assert(self.orientations[0] and self.orientations[1])
    end
    particles[#particles+1]=p
    return p
end
function EFFECT:SetPos(v) self.pos=v end
function EFFECT:SetAngles(v) self.ang=v end
''')
lua.execute(to_lua((ROOT/'lua/mcv/shared/sh_melee_effects.lua').read_text()))
lua.execute(to_lua((ROOT/'lua/effects/mcv_melee_blood.lua').read_text()))
lua.execute('''
for _,color in ipairs({0,1,2,4,5,6}) do
    for _,normal in ipairs({Vector(1,0,0),vector_origin}) do
        local effect=setmetatable({}, {__index=EFFECT})
        local origin=Vector(5000,3000,800)
        effect:Init({GetOrigin=function() return origin end,GetNormal=function() return normal end,
            GetColor=function() return color end})
        assert(particles[#particles].name==MCV.MeleeBloodParticles[color])
        assert(effect:Think() and effect.DieTime==now+4)
        now=now+4; assert(not effect:Think())
    end
end
local n=#particles
local unknown=setmetatable({}, {__index=EFFECT})
unknown:Init({GetColor=function() return BLOOD_COLOR_MECH end})
assert(not unknown:Think() and #particles==n)
fail=true
local failed=setmetatable({}, {__index=EFFECT})
failed:Init({GetOrigin=function() return Vector(4000,20,50) end,GetNormal=function() return vector_up end,
    GetColor=function() return BLOOD_COLOR_RED end})
assert(not failed:Think() and #particles==n)
''')
print('PASS: blood colour selection, CP positions/directions/velocity, failed creation and finite client lifetime')

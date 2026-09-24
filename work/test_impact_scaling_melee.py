"""Check particle scale plumbing and authoritative melee impact ownership offline."""
from pathlib import Path
import struct
from lupa import LuaRuntime
from glua_check import to_lua
from dmxlib import DMX

ROOT = Path(__file__).resolve().parents[1]

for suffix in ('', '_cheap'):
    original = DMX((ROOT/'particles'/('vietnam_impact_effects'+suffix+'.pcf')).read_bytes())
    scaled = DMX((ROOT/'particles'/('mcv_scaled_impacts'+suffix+'.pcf')).read_bytes())
    for i, source in original.by_type('DmeParticleSystemDefinition'):
        target = scaled.elements[i]
        assert target.name == 'mcv_scaled_'+source.name
        assert target.get('emitters') == source.get('emitters')
        for emitter in source.get('emitters'):
            assert original.elements[emitter].attrs == scaled.elements[emitter].attrs
        assert target.get('initializers')[:-1] == source.get('initializers')
        op = scaled.elements[target.get('initializers')[-1]]
        assert op.get('functionName') == 'Remap Control Point to Scalar'
        assert struct.unpack('<i', op.get('input control point number'))[0] == 2
        assert struct.unpack('<i', op.get('output field'))[0] == 3
        assert op.get('output is scalar of initial random range') == b'\1'
    assert not set(e.guid for e in original.elements).intersection(e.guid for e in scaled.elements)
print('PASS: all full/cheap systems scale radius from CP2, distinct IDs, emission counts preserved')

for module, method in [('lua/weapons/mcv_melee/sh_melee.lua', 'MeleeHit'),
                       ('lua/weapons/mcv_base_core/sh_bash.lua', 'BashStrike')]:
    lua = LuaRuntime()
    lua.execute('''
        SWEP={}; MCV={}; effects=0; bullets=0
        local mt={__add=function(a,b) return a end,__sub=function(a,b) return a end,
                  __mul=function(a,b) return a end}
        vec=setmetatable({GetNormalized=function(s) return s end},mt)
        function Vector() return vec end
        function Angle() return {} end
        function IsValid(x) return x~=nil end
        function DamageInfo() return setmetatable({},{__index=function() return function() end end}) end
        DMG_SLASH=1; DMG_CLUB=2
        owner={GetShootPos=function() return vec end,ViewPunch=function() end}
        function SWEP:GetOwner() return owner end
        function SWEP:GetAimVector() return vec end
        function SWEP:GetBayonet() return false end
        function SWEP:EmitSound() end
        function SWEP:FireBullets() bullets=bullets+1 end
        function MCV.SurfaceImpact(tr,damage)
            assert(SERVER and damage==63)
            if enabled then effects=effects+1 end
            return enabled
        end
    ''')
    lua.execute(to_lua((ROOT/module).read_text()))
    lua.execute('''
        function SWEP:MeleeTrace() return {Hit=hit,HitPos=vec} end
        function SWEP:BashTrace() return {Hit=hit,HitPos=vec},vec,vec end
    ''')
    lua.globals().method = method
    lua.execute('''
        for _,server in ipairs({false,true}) do
            SERVER=server; CLIENT=not server
            for _,setting in ipairs({false,true}) do
                enabled=setting
                for _,contact in ipairs({false,true}) do
                    hit=contact; effects=0; bullets=0
                    SWEP[method](SWEP,56,63,false)
                    assert(effects==((server and contact and setting) and 1 or 0))
                    assert(bullets==((server and contact and not setting) and 1 or 0))
                end
            end
        end
    ''')
print('PASS: melee and bash, both realms, hit/miss, custom/stock: one server impact, no client duplicate')

lua = LuaRuntime()
lua.execute('''
    EFFECT={}; MCV={ImpactFamilies={[13]='metal'},ImpactDecalName=function() return nil end}
    function math.Clamp(x,a,b) return math.min(math.max(x,a),b) end
    function Vector(x,y,z) return {x=x,y=y,z=z} end
    function IsValid(x) return x~=nil end
    function CurTime() return 10 end
    local ang={Forward=function() return {} end,Right=function() return {} end,Up=function() return {} end}
    normal={LengthSqr=function() return 1 end,Angle=function() return ang end}
    function EFFECT:SetPos() end
    function EFFECT:SetAngles() end
    ps={SetControlPoint=function(s,id,v) s[id]=v end,SetControlPointOrientation=function() end,
        StartEmission=function(s) assert(s[2].x==1.5); s.started=true end}
    function CreateParticleSystem(ent,name)
        assert(name:find('mcv_scaled_impact_metal_')==1); return ps
    end
    data={GetFlags=function() return 13 end,GetOrigin=function() return {} end,
          GetNormal=function() return normal end,GetScale=function() return 1.5 end}
''')
lua.execute(to_lua((ROOT/'lua/effects/mcv_impact.lua').read_text()))
lua.execute('EFFECT:Init(data); assert(ps.started and EFFECT.DieTime==14)')
print('PASS: client effect sets CP2 scale before emission')

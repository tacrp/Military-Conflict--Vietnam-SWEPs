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
                       ('lua/mcv/weapon_common/sh_bash.lua', 'BashStrike')]:
    lua = LuaRuntime()
    lua.execute('''
        SWEP={}; MCV={}; effects=0; bullets=0
        BLOOD_COLOR_RED=0; BLOOD_COLOR_YELLOW=1; BLOOD_COLOR_GREEN=2; BLOOD_COLOR_MECH=3
        BLOOD_COLOR_ANTLION=4; BLOOD_COLOR_ZOMBIE=5; BLOOD_COLOR_ANTLION_WORKER=6; DONT_BLEED=-1
        game={AddParticles=function() end}
        function PrecacheParticleSystem() end
        function AddCSLuaFile() end
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
    lua.execute(to_lua((ROOT/'lua/mcv/shared/sh_melee_effects.lua').read_text()))
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
    EFFECT={}; DMG_BULLET=2; MCV={ImpactFamilies={[13]='metal'},ImpactDecalName=function() return nil end}
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
          GetNormal=function() return normal end,GetScale=function() return 1.5 end,
          GetDamageType=function() return 0 end}
''')
lua.execute(to_lua((ROOT/'lua/effects/mcv_impact.lua').read_text()))
lua.execute('EFFECT:Init(data); assert(ps.started and EFFECT.DieTime==14)')
print('PASS: client effect sets CP2 scale before emission')

# A bolt owns its terminal impact once, in the server realm. Exercise both the
# shared custom/stock dispatcher and damage callback, including stale prop traces.
lua = LuaRuntime()
lua.execute('''
ENT={}; MCV={}; DMG_SLASH=4; DMG_NEVERGIB=4096; DMG_BULLET=2; MASK_SHOT=1
HITGROUP_HEAD=1; HITGROUP_CHEST=2; HITGROUP_STOMACH=3
function AddCSLuaFile() end
function IsValid(v) return type(v)=='table' and not v.invalid end
local V={}; V.__index=V
function Vector(x,y,z) return setmetatable({x=x,y=y,z=z},V) end
function V.__add(a,b) return Vector(a.x+b.x,a.y+b.y,a.z+b.z) end
function V.__sub(a,b) return Vector(a.x-b.x,a.y-b.y,a.z-b.z) end
function V.__mul(a,b) return Vector(a.x*b,a.y*b,a.z*b) end
function V.__unm(a) return a*-1 end
function V:GetNormalized() return Vector(1,0,0) end
timer={Simple=function() end}; stock=0; custom=0; shots=0
function MCV.SurfaceImpact(tr,damage,recipients)
    assert(recipients==true); lastTrace=tr; lastDamage=damage
    if enabled then custom=custom+1 end
    return enabled
end
function EffectData() return setmetatable({}, {__index=function() return function() end end}) end
util={TraceLine=function(t)
    assert(t.mask==MASK_SHOT and t.start.x==6 and t.endpos.x==14)
    return probe
end,Effect=function(name,fx,allow,recipients)
    assert(name=='Impact' and recipients==true); stock=stock+1
end}
function target(kind)
    return {IsPlayer=function() return kind=='player' end,IsNPC=function() return kind=='npc' end,
        IsNextBot=function() return false end,Health=function() return kind=='breakable' and 10 or 0 end}
end
function bolt()
    local b=setmetatable({}, {__index=ENT})
    function b:GetOwner() return nil end
    function b:GetWeapon() return nil end
    function b:EmitSound(name) self.sound=name end
    function b:FireBullets(t)
        shots=shots+1; assert(t.Damage==55 and t.Tracer==0 and t.Num==1 and t.Force==4)
        local dmg={value=t.Damage,SetDamageType=function(s,k) s.kind=k end,
            GetDamage=function(s) return s.value end,ScaleDamage=function(s,m) s.value=s.value*m end}
        local result=t.Callback(self,bodyTrace,dmg)
        assert(result.effects==false and result.damage~=false and dmg.kind==4100)
        dealt=dmg.value
    end
    return b
end
''')
shared = (ROOT/'lua/mcv/shared/sh_impacts.lua').read_text()
dispatch = shared[shared.index('function MCV.BulletImpact('):]
lua.execute(to_lua(dispatch[:dispatch.index('\nend')+4]))
lua.execute(to_lua((ROOT/'lua/entities/mcv_proj_bolt.lua').read_text()))
lua.execute('''
for _,server in ipairs({false,true}) do
    SERVER=server; CLIENT=not server
    for _,setting in ipairs({false,true}) do
        enabled=setting
        for _,kind in ipairs({'world','prop','moving','player','npc','breakable','sky'}) do
            local ent=target(kind)
            local data={HitEntity=ent,HitPos=Vector(10,20,30),HitNormal=Vector(1,0,0),
                OurOldVelocity=Vector(1000,0,0),TheirSurfaceProps=41}
            probe={Hit=true,Entity=ent,HitPos=data.HitPos,StartPos=Vector(6,20,30),
                HitNormal=Vector(-1,0,0),SurfaceProps=41,HitSky=kind=='sky'}
            bodyTrace=probe; bodyTrace.HitGroup=HITGROUP_HEAD
            if kind=='moving' then probe={Hit=false} end
            stock=0; custom=0; shots=0
            local b=bolt(); b:Impact(data); b:Impact(data)
            local want=(server and kind~='sky') and 1 or 0
            assert(stock+custom==want,kind)
            assert(custom==(setting and want or 0))
            local body=kind=='player' or kind=='npc' or kind=='breakable'
            assert(shots==((server and body) and 1 or 0))
            if server and kind~='sky' then
                assert(lastTrace.HitPos==data.HitPos and lastTrace.HitNormal.x==-1)
                assert(lastTrace.SurfaceProps==41)
                assert(lastDamage==(body and 220 or 55))
                if body then assert(dealt==220) end
            end
        end
    end
end
''')
print('PASS: bolt world/prop/body/sky contacts, moving-prop fallback, custom/stock effects, unchanged damage and no client/repeated impact')

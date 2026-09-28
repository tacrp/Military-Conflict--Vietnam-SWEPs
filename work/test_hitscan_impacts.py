"""Actual hitscan callback/effect routing; no game launch."""
from pathlib import Path
import re
from lupa import LuaRuntime
from glua_check import to_lua
from dmxlib import DMX
import port_weapon

root = Path(__file__).resolve().parents[1]
shoot = (root/'lua/weapons/mcv_base/sh_shoot.lua').read_text()
attack = shoot[shoot.index('function SWEP:BulletAttack('):shoot.index('function SWEP:RocketAttack(')]
for client in (False, True):
    for sp in (False, True):
        for first in (False, True):
            for custom in (False, True):
                lua = LuaRuntime()
                lua.globals().CLIENT = client
                lua.globals().SERVER = not client
                lua.globals().sp = sp
                lua.globals().first = first
                lua.globals().custom = custom
                lua.execute('''
SWEP={DamageGeneric=40}; MCV={PhysicalBulletsEnabled=function() return false end}
function Color(r,g,b) return {r=r,g=g,b=b} end
function math.Clamp(v,a,b) return math.min(math.max(v,a),b) end
SWEP.TracerParticle='vietnam_tracer_rifle_primary'
function SWEP:Clip1() return 10 end
game={SinglePlayer=function() return sp end}
function IsFirstTimePredicted() return first end
function IsValid(v) return type(v)=='table' and not v.invalid end
DMG_BULLET=2; events={}; traces=0; applied=0
world={invalid=true} -- worldspawn deliberately fails GMod's IsValid
local V={};V.__index=V
function Vector(x,y,z) return setmetatable({x=x or 0,y=y or 0,z=z or 0},V) end
function V.__sub(a,b) return Vector(a.x-b.x,a.y-b.y,a.z-b.z) end
function V:Length() return math.sqrt(self.x^2+self.y^2+self.z^2) end
vector_origin=Vector()
function EffectData() return setmetatable({}, {__index=function(_,k) return function(s,v) s[k]=v end end}) end
function RecipientFilter()
    return {AddPVS=function(s) s.pvs=true end,RemovePlayer=function(s,p) s.excluded=p end,
        AddPlayer=function(s,p) s.included=p end}
end
util={Effect=function(name,data,a,recipients) events[#events+1]={name=name,data=data,recipients=recipients} end}
MCV.SurfaceImpact=function(tr,damage,recipients,ricochet)
    if not custom then return false end
    util.Effect('mcv_impact',{SetOrigin=tr.HitPos,SetNormal=tr.HitNormal,damage=damage,ricochet=ricochet},true,recipients); return true
end
owner={GetInfo=function() return '0' end,IsPlayer=function() return not npc end,LagCompensation=function() end,
    GetShootPos=function() return Vector() end}
localShooter=owner
function LocalPlayer() return localShooter end
function SWEP:GetOwner() return owner end
function SWEP:GetSpread() return 0 end
function SWEP:GetBulletCount() return 1 end
function SWEP:GetFiremodeValue() return 1 end
function SWEP:GetAimVector() return Vector(1,0,0) end
function SWEP:StatMult() return 1 end
function SWEP:ApplyBulletDamage() applied=applied+1 end
function SWEP:QueuePenetration(tr,state,queue)
    if state.layers==0 then
        queue[#queue+1]={src=tr.HitPos,dir=Vector(1,0,0),damage=20,distance=10,budget=.5,layers=1,
            exitTrace={Hit=true,Entity=world,StartPos=Vector(16,0,0),HitPos=Vector(15,0,0),HitNormal=Vector(1,0,0)},exitDamage=15}
    end
end
function owner:FireBullets(data)
    traces=traces+1
    assert(data.Tracer==0) -- callback owns tracer and impacts
    local tr={Hit=true,Entity=world,StartPos=data.Src,HitPos=Vector(traces*10,0,0),HitNormal=Vector(-1,0,0)}
    local result=data.Callback(self,tr,{GetDamage=function() return data.Damage end})
    assert(result.effects==false) -- no extra engine impact/DoImpactEffect path
end
''')
                impact_source = (root/'lua/mcv/shared/sh_impacts.lua').read_text()
                impact_source = impact_source[impact_source.index('function MCV.BulletImpact('):]
                lua.execute(to_lua(impact_source[:impact_source.index(chr(10)+'end')+4]))
                lua.execute(to_lua((root/'lua/mcv/shared/sh_tracercolor.lua').read_text()))
                lua.execute(to_lua((root/'lua/mcv/shared/sh_hitscaneffects.lua').read_text()))
                lua.execute(to_lua(attack))
                lua.execute('''
SWEP:BulletAttack()
if CLIENT and (sp or not first) then
    assert(traces==0 and #events==0)
else
    assert(traces==2 and applied==2 and #events==4) -- exit is cosmetic, not another damage bullet
    assert(events[1].name=='mcv_tracer')
    assert(events[2].name==(custom and 'mcv_impact' or 'Impact'))
    assert(events[3].name==events[2].name)
    assert(events[3].data.SetOrigin.x==15 and events[3].data.SetNormal.x==1)
    assert(events[4].name==events[2].name and events[4].data.SetOrigin.x==20)
    if not custom then
        for i=2,4 do assert(events[i].data.SetEntity==world) end
    end
    if custom then
        assert(events[3].data.damage==15 and not events[3].data.ricochet)
        assert(not events[2].data.ricochet and not events[4].data.ricochet)
    end
    for _,event in ipairs(events) do
        if SERVER then assert((event.recipients.excluded==owner)==(not sp))
        else assert(event.recipients==true) end
    end
end
if SERVER then
    npc=true; events={}; traces=0; SWEP:BulletAttack()
    for _,event in ipairs(events) do assert(not event.recipients.excluded) end
end
-- Silenced smoke is local to the firing player; impact visibility is independent.
if (SERVER or (not sp and first)) and custom then
    local queue=SWEP.QueuePenetration
    SWEP.QueuePenetration=function() end
    events={};traces=0;SWEP:BulletAttack()
    assert(#events==2 and events[2].data.ricochet)
    SWEP.TracerFrequency=3
    events={};traces=0;SWEP:BulletAttack()
    assert(#events==2 and not events[2].data.ricochet)
    SWEP.TracerFrequency=nil;SWEP.QueuePenetration=queue
end
npc=false; SWEP.TracerParticle='vietnam_tracer_silenced_primary'
events={}; traces=0; SWEP:BulletAttack()
if CLIENT and (sp or not first) then
    assert(traces==0 and #events==0)
else
    local trail=CLIENT or sp
    assert(traces==2 and #events==(trail and 4 or 3))
    if trail then
        assert(events[1].name=='mcv_tracer')
        if SERVER then
            assert(events[1].recipients.included==owner and not events[1].recipients.pvs)
        end
    end
    for i=(trail and 2 or 1),#events do
        assert(events[i].name==(custom and 'mcv_impact' or 'Impact'))
        if SERVER then assert(events[i].recipients.pvs) end
    end
end
if SERVER then
    npc=true; events={}; SWEP:BulletAttack()
    assert(#events==3)
    for _,event in ipairs(events) do
        assert(event.name~='mcv_tracer' and not event.recipients.excluded)
    end
else
    localShooter={}; events={}
    MCV.HitscanEffects(SWEP,{Hit=true,StartPos=Vector(),HitPos=Vector(10,0,0),
        HitNormal=Vector(-1,0,0)},40,1)
    assert(#events==((sp or first) and 1 or 0)) -- observer can only receive the impact
    if #events>0 then assert(events[1].name~='mcv_tracer') end
end
''')
print('PASS: hitscan prediction, penetration, custom/stock impacts and shooter-only silenced trails in MP/SP/NPC routing')

# Exercise the actual client effect too: reject observers before touching models,
# and keep native smoke/no glow at both first- and third-person muzzle positions.
lua.execute('''
EFFECT={}; smoke={}
function Color() return {} end
function CreateMaterial() return {} end
function Material() return {} end
function UnPredictedCurTime() return 0 end
function CreateParticleSystem(ent,name,attach,id)
    smoke[#smoke+1]={ent=ent,name=name,id=id}
    return {SetControlPoint=function() end,StartEmission=function() end}
end
localShooter=owner; npc=false
local vm={LookupAttachment=function(s,name) return name=='muzzleleft' and 2 or 1 end,
    GetAttachment=function() return {Pos=Vector(20,0,0)} end,SetupBones=function() end}
function owner:GetViewModel() return vm end
function owner:ShouldDrawLocalPlayer() return third end
function SWEP:GetWorldModelAttachment() return vm,3 end
function SWEP:GetAkimbo() return dual end
function SWEP:Clip1() return 4 end
data={GetEntity=function() return SWEP end,GetOrigin=function() return Vector(100,0,0) end}
''')
lua.execute(to_lua((root/'lua/effects/mcv_tracer.lua').read_text()))
lua.execute('''
for _,thirdPerson in ipairs({false,true}) do
    third=thirdPerson
    for _,akimbo in ipairs({false,true}) do
        dual=akimbo
        local effect=setmetatable({}, {__index=EFFECT})
        effect:Init(data)
        local p=smoke[#smoke]
        assert(p.name=='vietnam_tracer_silenced_primary')
        assert(p.id==(third and 3 or (dual and 2 or 1)))
        assert(not effect.Dir and not effect:Think()) -- smoke only, no manual glow
    end
end
assert(#smoke==4)
function SWEP:GetWorldModelAttachment() error('observer should not touch muzzle bones') end
localShooter={}; EFFECT:Init(data); assert(#smoke==4)
owner.invalid=true; EFFECT:Init(data); assert(#smoke==4)
''')
print('PASS: silenced native tracer effect, local view/world/dual muzzle, no glow and observer/absent-owner rejection')

# Audit both packs against original suppressed flags/tracers, including renamed
# ports and the custom suppressed rifle. Never run a generator over hand tuning.
names = {'xm16super'}
aliases = {'vz61e_sog': 'vz61_sog', 'stenmk2_sog': 'sten_sog'}
for script in (root/'work/cscripts').glob('weapon_*.txt'):
    name = script.stem.removeprefix('weapon_')
    if name.startswith('dual_'):
        continue
    source = port_weapon.flat(port_weapon.parse_kv(script.read_text(encoding='utf-8', errors='replace')).get('WeaponData', {}))
    if source.get('isSupressed') == '1' or 'silenced' in source.get('TracerParticle', ''):
        names.add(aliases.get(name, name))
for name in sorted(names):
    path = root/'lua/weapons'/f'mcv_{name}.lua'
    if not path.exists():
        path = root.parent/'mcv-2/lua/weapons'/path.name
    assert re.search(r'^SWEP\.TracerParticle = "vietnam_tracer_silenced_primary"$',
                     path.read_text(encoding='utf-8'), re.M), path
assert 'TracerParticle' not in port_weapon.sight_offsets({'isSupressed': '1', 'ironsightforward': '1'})
for asset, effect in [('vietnam_tracer_effects.pcf', 'vietnam_tracer_silenced_primary'),
                      ('mcv_physical_smoke.pcf', 'mcv_phys_vietnam_tracer_silenced_smoke')]:
    definitions = DMX((root/'particles'/asset).read_bytes())
    assert effect in {e.name for _, e in definitions.by_type('DmeParticleSystemDefinition')}
print(f'PASS: all {len(names)} silent weapons across both packs use an available smoke-only tracer; sight tool preserves it')

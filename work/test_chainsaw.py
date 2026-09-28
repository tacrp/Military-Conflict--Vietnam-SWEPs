"""Offline chainsaw prediction, damage, audio lifecycle and compiled-asset checks."""
from pathlib import Path
import re
import struct
import tempfile

from lupa import LuaRuntime
from glua_check import to_lua
from build_chainsaw import prepare, sequence_flags
from pack_paths import ROOT, asset_path


def load(lua, relative):
    lua.execute(to_lua((ROOT / relative).read_text(encoding='utf-8')))


lua = LuaRuntime()
lua.execute('''
SERVER=true; CLIENT=false; SWEP={Primary={}}; MCV={}; now=100
IN_ATTACK=1; IN_USE=2; DMG_SLASH=4; MASK_SHOT=1; MASK_SHOT_HULL=2
BLOOD_COLOR_RED=0; BLOOD_COLOR_YELLOW=1; BLOOD_COLOR_MECH=3; DONT_BLEED=-1
BLOOD_COLOR_GREEN=2; BLOOD_COLOR_ANTLION=4; BLOOD_COLOR_ZOMBIE=5; BLOOD_COLOR_ANTLION_WORKER=6
function AddCSLuaFile() end
function CurTime() return now end
function IsValid(e) return type(e)=='table' and not e.removed end
function near(a,b) assert(math.abs(a-b)<1e-6, tostring(a)..' ~= '..tostring(b)) end
local V={}; V.__index=V
function Vector(x,y,z) return setmetatable({x=x,y=y,z=z},V) end
function V.__mul(v,n) return Vector(v.x*n,v.y*n,v.z*n) end
function V.__add(a,b) return Vector(a.x+b.x,a.y+b.y,a.z+b.z) end
local durations={idle=2,shootloop=2/3,shootend=0.5,holster=0.7}
vm={}
function vm:SequenceDuration(s) return assert(durations[s],s) end
function vm:SendViewModelMatchingSequence(s) self.sequence=s; self.sends=(self.sends or 0)+1 end
function vm:SetPlaybackRate(n) self.rate=n end
function vm:SetCycle(n) self.cycle=n end
MCV.CachedSequence=function(_,s) return durations[s] and s or -1 end
owner={keys={},alive=true}
function owner:KeyDown(key) return self.keys[key] or false end
function owner:Alive() return self.alive end
function owner:IsPlayer() return true end
function owner:GetViewModel() return vm end
function owner:GetActiveWeapon() return self.active end
function owner:GetShootPos() return Vector(10,20,30) end
function owner:LagCompensation(enable) self.lagged=enable; self.lagCalls=(self.lagCalls or 0)+1 end
function GetPredictionPlayer() return owner end
game={SinglePlayer=function() return false end,AddParticles=function() end}
function PrecacheParticleSystem() end
customBlood=true
MCV.SurfaceImpacts=function() return customBlood end
util={}
lineCalls=0; hullCalls=0; impacts=0; bloodEffects=0; hits=0; totalDamage=0
target={TakeDamageInfo=function(self,d)
    assert(not owner.lagged and d.kind==DMG_SLASH and d.attacker==owner and d.inflictor==w)
    near(d.force.x,d.damage*30); hits=hits+1; totalDamage=totalDamage+d.damage
    if self.lethal then self.removed=true end
end}
function target:IsPlayer() return self.kind=='player' end
function target:IsNPC() return self.kind=='npc' end
function target:IsNextBot() return self.kind=='nextbot' end
function target:GetClass() return self.kind or 'prop_physics' end
function target:GetBloodColor() assert(not self.removed); return self.blood end
contact={Hit=true,Entity=target,HitPos=Vector(120,20,30),HitNormal=Vector(-1,0,0)}
function util.TraceLine(t)
    assert(owner.lagged and t.filter==owner and t.mask==MASK_SHOT)
    near(t.endpos.x,10+128); lineCalls=lineCalls+1
    return lineMiss and {Hit=false} or contact
end
function util.TraceHull(t)
    assert(owner.lagged and t.filter==owner and t.mask==MASK_SHOT_HULL)
    near(t.endpos.x,10+128)
    near(t.mins.x,-6); near(t.maxs.x,6); hullCalls=hullCalls+1
    return contact
end
function DamageInfo()
    local d={}
    for _,field in ipairs({'Damage','DamageType','DamageForce','DamagePosition','Attacker','Inflictor'}) do
        local key=({Damage='damage',DamageType='kind',DamageForce='force',DamagePosition='pos',Attacker='attacker',Inflictor='inflictor'})[field]
        d['Set'..field]=function(self,value) self[key]=value end
    end
    return d
end
MCV.BulletImpact=function(tr,damage,recipients)
    assert(tr==contact and recipients==true and not owner.lagged)
    impacts=impacts+1
end
function EffectData()
    return {SetOrigin=function(s,v) s.pos=v end,SetNormal=function(s,v) s.normal=v end,
        SetColor=function(s,v) s.color=v end,SetScale=function(s,v) s.scale=v end}
end
function util.Effect(name,fx,override,ignorePrediction)
    assert(SERVER and not owner.lagged and name==(customBlood and 'mcv_melee_blood' or 'BloodImpact'))
    assert(override==true and ignorePrediction==true, 'Shooter must receive server blood in MP')
    assert(fx.pos==contact.HitPos and fx.normal==contact.HitNormal and fx.scale>0)
    assert(fx.color==(target.blood or BLOOD_COLOR_RED))
    bloodEffects=bloodEffects+1
end
''')
dependency_loads = []
def include_dependency(path):
    assert path == 'mcv/shared/sh_melee_effects.lua', path
    dependency_loads.append(path)
    load(lua, 'lua/'+path)
lua.globals().include = include_dependency
load(lua, 'lua/mcv/weapon_common/sh_anim.lua')
load(lua, 'lua/weapons/mcv_melee/sh_melee.lua')
lua.execute('assert(MCV.MeleeBloodColor and MCV.MeleeBloodImpact, "melee loaded without its blood dependency")')
lua.execute('''
melee=SWEP
function melee:Holster() self:SetHolsterTime(now+0.7); self:PlaySequence('holster',1,true,true); return false end
baseclass={Get=function(name) assert(name=='mcv_melee'); return melee end}
SWEP=setmetatable({Primary={}}, {__index=melee})
-- Simulate refreshing the leaf weapon on a server which has not run the new shared loader.
MCV.MeleeBloodColor=nil; MCV.MeleeBloodImpact=nil
''')
load(lua, 'lua/weapons/mcv_chainsaw.lua')
assert len(dependency_loads) == 2
load(lua, 'lua/weapons/mcv_chainsaw.lua')
assert len(dependency_loads) == 2, 'reloading an already-ready weapon reloaded the particle library'
lua.execute('''
for _,name in ipairs({'PrimedAttack','ActionState','ActionStart','NextPrimaryFire','AnimLockTime',
    'NextIdle','AnimationStart','AnimationDuration','Safe','HolsterTime','Skin','Ready'}) do
    SWEP['Get'..name]=function(self) return self.dt[name] end
    SWEP['Set'..name]=function(self,value) self.dt[name]=value end
end
function SWEP:GetOwner() return owner end
function SWEP:GetAimVector() return Vector(1,0,0) end
function SWEP:GetIsSprinting() return self.sprinting end
function SWEP:StatMult(name) return self.mult[name] or 1 end
function newWeapon()
    w=setmetatable({dt={PrimedAttack=false,Safe=false,NextPrimaryFire=0,AnimLockTime=0,HolsterTime=0},mult={}}, {__index=SWEP})
    owner.active=w; owner.alive=true; owner.keys={}; w:OnDeploy()
    return w
end
function copy(t) local r={} for k,v in pairs(t) do r[k]=v end return r end
function step(t) now=t; w:ThinkWeapon() end
newWeapon(); owner.keys[IN_ATTACK]=true
step(100); assert(w:GetPrimedAttack() and vm.sequence=='shootloop' and w:GetSkin()==2)
step(100.14); assert(hits==0)
-- Commands at the configured cadence: sustained contact causes one hit/effect per tick.
for i=0,9 do step(100.150001+i*0.100001) end
assert(hits==10 and impacts==10 and lineCalls==10 and hullCalls==0)
near(totalDamage,120); assert(owner.lagCalls==20 and vm.sends==1)
-- The real animation helper can service idle without returning to the idle pose.
w:Idle(); assert(vm.sequence=='shootloop' and w:GetAnimationDuration()==2/3)
owner.keys[IN_ATTACK]=false; step(101.2)
assert(not w:GetPrimedAttack() and vm.sequence=='shootend' and w:GetSkin()==1)
owner.keys[IN_ATTACK]=true; step(101.3); assert(not w:GetPrimedAttack())
step(101.700001); assert(w:GetPrimedAttack()); near(w:GetNextPrimaryFire(),now+0.15)
-- Multipliers, fallback hull, misses and sky never bypass hit/cooldown rules.
w.mult.damage=2; w.mult.firerate=2; lineMiss=true
step(w:GetNextPrimaryFire()+1e-6); near(totalDamage,144); near(w:GetNextPrimaryFire(),now+0.05)
assert(hullCalls==1)
for _,flag in ipairs({'HitSky','StartSolid'}) do
    contact[flag]=true; local count=hits; local fx=impacts
    step(w:GetNextPrimaryFire()+1e-6); assert(hits==count and impacts==fx and not owner.lagged)
    contact[flag]=nil
end
contact.Hit=false; local count=hits; step(w:GetNextPrimaryFire()+1e-6); assert(hits==count)
contact.Hit=true; lineMiss=false
-- Replay actual client state from the same snapshot: timers, skin and sequence agree.
CLIENT=true; SERVER=false; newWeapon(); owner.keys[IN_ATTACK]=true
local before=copy(w.dt); step(200); local first=copy(w.dt); local sends=vm.sends
w.dt=copy(before); step(200)
for key,value in pairs(first) do assert(w.dt[key]==value,key) end
assert(vm.sends==sends+1 and hits==count)
step(201); assert(hits==count and bloodEffects==0 and w:GetPrimedAttack())
-- Every blocked input interrupts cutting, and cannot tick damage while blocked.
CLIENT=false; SERVER=true
for _,reason in ipairs({'sprint','use','safe','death','holster','inactive','rate'}) do
    newWeapon(); owner.keys[IN_ATTACK]=true; step(300)
    if reason=='sprint' then w.sprinting=true
    elseif reason=='use' then owner.keys[IN_USE]=true
    elseif reason=='safe' then w:SetSafe(true)
    elseif reason=='death' then owner.alive=false
    elseif reason=='holster' then w:SetHolsterTime(302)
    elseif reason=='inactive' then owner.active=nil
    elseif reason=='rate' then w.mult.firerate=0 end
    step(301); assert(not w:GetPrimedAttack() and hits==count,reason)
end
newWeapon(); owner.keys[IN_ATTACK]=true; step(400)
assert(w:Holster({})==false and not w:GetPrimedAttack() and vm.sequence=='holster' and w:GetSkin()==0)
newWeapon(); owner.keys[IN_ATTACK]=true; step(500); w:OnDrop()
assert(not w:GetPrimedAttack() and w:GetSkin()==0)
assert(w:GetControlHints()[1][2]=='Hold to saw' and w.Primary.Ammo=='none')
-- Flesh contacts own blood effects, not another surface impact, including lethal hits.
local surfaceCount=impacts
for _,kind in ipairs({'player','npc','nextbot','prop_ragdoll'}) do
    target.kind=kind
    for _,color in ipairs({BLOOD_COLOR_RED,BLOOD_COLOR_YELLOW}) do
        target.blood=color
        local before=bloodEffects
        w:SawTick(); assert(bloodEffects==before+1 and impacts==surfaceCount)
    end
end
target.kind='npc'; target.blood=nil
local before=bloodEffects; w:SawTick(); assert(bloodEffects==before+1)
target.lethal=true; before=bloodEffects; w:SawTick()
assert(target.removed and bloodEffects==before+1 and impacts==surfaceCount)
target.removed=false; target.lethal=false
for _,color in ipairs({DONT_BLEED,BLOOD_COLOR_MECH}) do
    target.blood=color; before=bloodEffects; surfaceCount=impacts
    w:SawTick(); assert(bloodEffects==before and impacts==surfaceCount+1)
end
target.blood=BLOOD_COLOR_RED; before=bloodEffects; surfaceCount=impacts
customBlood=false; w:SawTick(); assert(bloodEffects==before+1 and impacts==surfaceCount)
customBlood=true; before=bloodEffects
CLIENT=true; SERVER=false
for i=1,10 do w:SawTick() end
assert(bloodEffects==before and impacts==surfaceCount)
CLIENT=false; SERVER=true
for _,flag in ipairs({'HitSky','StartSolid'}) do
    contact[flag]=true; w:SawTick(); assert(bloodEffects==before and impacts==surfaceCount)
    contact[flag]=nil
end
-- The world is not a valid ordinary entity. Ground contact still gets its
-- surface effect, without asking it for blood or attempting entity damage.
contact.Entity={removed=true}
local groundHits,groundEffects,groundBlood=hits,impacts,bloodEffects
w:SawTick()
assert(hits==groundHits and impacts==groundEffects+1 and bloodEffects==groundBlood)
contact.Entity=target
''')
print('PASS: missing-helper/weapon-refresh recovery, ground contact, reach, cadence, blood routing, lethal hits and prediction')

# Run the independent audio manager with realistic per-event hooks and sound handles.
audio = LuaRuntime()
audio.execute('''
MCV={}; CLIENT=true; SERVER=false; hook={events={}}; patches={}; weapons={}
function IsValid(v) return type(v)=='table' and not v.removed end
function hook.GetTable() return hook.events end
function hook.Add(event,id,fn) hook.events[event]=hook.events[event] or {}; hook.events[event][id]=fn end
function run(event,...) for _,fn in pairs(hook.events[event] or {}) do fn(...) end end
ents={FindByClass=function() return weapons end}
function owner()
    return {alive=true,Alive=function(s) return s.alive end,IsPlayer=function() return true end,
        IsDormant=function(s) return s.dormant end,GetActiveWeapon=function(s) return s.active end}
end
function weapon(p)
    local w={owner=p,ready=true,holster=0,cutting=false,SoundSawIdle='idle.wav',SoundSawCut='cut.wav'}
    function w:GetOwner() return self.owner end
    function w:GetReady() return self.ready end
    function w:GetHolsterTime() return self.holster end
    function w:IsDormant() return self.dormant end
    function w:GetPrimedAttack() return self.cutting end
    weapons[#weapons+1]=w; p.active=w; return w
end
function CreateSound(p,file)
    -- Source permits only one patch of this file on the same entity.
    for _,s in ipairs(patches) do assert(s.stopped or s.owner~=p or s.file~=file) end
    local s={owner=p,file=file,plays=0,changes=0}
    function s:SetSoundLevel(n) self.level=n end
    function s:PlayEx(volume,pitch) self.volume=volume; self.pitch=pitch; self.plays=self.plays+1 end
    function s:Stop() self.stopped=true end
    function s:ChangeVolume(n) self.volume=n; self.changes=self.changes+1 end
    function s:ChangePitch(n) self.pitch=n end
    patches[#patches+1]=s; return s
end
p=owner(); w=weapon(p)
''')
load(audio, 'lua/mcv/client/cl_chainsaw.lua')
audio.execute('''
run('Think'); assert(#patches==1 and patches[1].volume==0.35 and patches[1].pitch==100 and patches[1].file=='idle.wav')
w.cutting=true; run('Think'); local s=patches[2]
assert(patches[1].stopped and s.volume==0.7 and s.pitch==100 and s.file=='cut.wav')
for i=1,10000 do run('Think') end
assert(#patches==2 and s.plays==1 and s.changes==0)
-- Missed removal callbacks and PVS/owner/death/holster changes are handled outside SWEP Think.
for _,field in ipairs({'dormant','holster','ready','death','ownerPVS'}) do
    local before=patches[#patches]
    if field=='dormant' then w.dormant=true
    elseif field=='holster' then w.holster=10
    elseif field=='ready' then w.ready=false
    elseif field=='death' then p.alive=false
    else p.dormant=true end
    run('Think'); assert(before.stopped,field)
    w.dormant=false; w.holster=0; w.ready=true; p.alive=true; p.dormant=false
    run('Think'); assert(not patches[#patches].stopped)
end
-- Same-owner switch and transfers stop all obsolete patches before creating replacements.
w2=weapon(p); MCV.TrackChainsaw(w2); run('Think')
assert(patches[#patches-1].stopped and not patches[#patches].stopped)
q=owner(); w2.owner=q; q.active=w2; p.active=w; run('Think')
local a,b=patches[#patches-1],patches[#patches]; assert(a.owner~=b.owner)
w.removed=true; run('Think'); assert(a.stopped or b.stopped)
run('EntityRemoved',w2); assert(a.stopped and b.stopped)
w.removed=false; p.active=w; MCV.TrackChainsaw(w); run('Think')
run('PostCleanupMap'); assert(patches[#patches].stopped)
run('Think'); assert(not patches[#patches].stopped)
-- Full autorun refresh replaces MCV before the module runs its previous cleanup.
MCV={}
''')
load(audio, 'lua/mcv/client/cl_chainsaw.lua')
audio.execute('''
assert(patches[#patches].stopped)
run('Think'); run('ShutDown')
for _,s in ipairs(patches) do assert(s.stopped) end
''')
print('PASS: continuous audio, PVS/death/holster/removal, ownership transfers, cleanup and Lua reload')
audio.execute('''
w.SoundSawStart='start.wav'; w.SoundSawStop='stop.wav'; w.cutting=false
local n=#patches
run('Think')
local startup,idle=patches[n+1],patches[n+2]
assert(startup.file=='start.wav' and idle.file=='idle.wav')
w.cutting=true;run('Think')
assert(startup.stopped and idle.stopped and patches[#patches].file=='cut.wav')
w.cutting=false;run('Think')
assert(patches[#patches].file=='idle.wav')
n=#patches; w.holster=10;run('Think')
local shutdown=patches[#patches]
assert(#patches==n+1 and shutdown.file=='stop.wav')
for i=1,100 do run('Think') end
assert(#patches==n+1 and not shutdown.stopped)
w.dormant=true;run('Think');assert(shutdown.stopped)
w.dormant=false;w.holster=0;run('Think')
run('ShutDown')
for _,s in ipairs(patches) do assert(s.stopped) end
''')
print('PASS: startup interruption, idle return, one-shot holster shutdown and PVS cleanup')

# Native asset checks, independent of the Lua fixtures.
model = asset_path('models/weapons/mcv/v_chainsaw.mdl')
flags = sequence_flags(model)
assert flags['shootloop'] & 1 and not flags['shootend'] & 1
data = model.read_bytes()
count, offset = struct.unpack_from('<ii', data, 180)
durations = {}
for i in range(count):
    at = offset + 100 * i
    label = at + struct.unpack_from('<i', data, at + 4)[0]
    name = data[label:data.index(b'\0', label)].decode()
    fps = struct.unpack_from('<f', data, at + 8)[0]
    frames = struct.unpack_from('<i', data, at + 16)[0]
    durations[name] = (frames - 1) / fps
assert abs(durations['@shootloop'] - durations['shootloop_a']) < 1e-6
assert abs(durations['@shootend'] - durations['shootend_a']) < 1e-6
qc = ROOT / 'work/MCV_SMD_PORT/weapons/v_chainsaw/v_chainsaw.qc'
with tempfile.TemporaryDirectory() as folder:
    copy = Path(folder) / qc.name
    copy.write_bytes(qc.read_bytes())
    prepare(copy)
    first = copy.read_text()
    prepare(copy)
    assert copy.read_text() == first == qc.read_text(), 'QC preparation must be idempotent'
for model_name in ('v_chainsaw', 'w_chainsaw'):
    for ext in ('.mdl', '.vvd', '.dx90.vtx', '.dx80.vtx'):
        assert asset_path(f'models/weapons/mcv/{model_name}{ext}').is_file()
    for material in (ROOT / f'materials/models/weapons/mcv/{model_name}').glob('*.vmt'):
        for texture in re.findall(r'"\$(?:basetexture|bumpmap|phongexponenttexture)"\s*"([^\"]+)"', material.read_text(), re.I):
            assert asset_path('materials/' + texture.replace('\\', '/') + '.vtf').exists(), texture
from PIL import Image
image = Image.open(asset_path('materials/entities/mcv_chainsaw.png'))
assert image.size == (512, 512) and image.mode == 'RGBA' and image.getextrema()[3] == (0, 255)
import wave
for name in ('idle_lp_01', 'high_speed_lp_01', 'start_02', 'die_01'):
    path = ROOT / f'sound/mcv/weapons/weapon_l4d2_chainsaw/chainsaw_{name}.wav'
    sound = path.read_bytes()
    with wave.open(str(path)) as wav:
        assert wav.getframerate() in (11025, 22050, 44100) and wav.getnframes() > 0
    if '_lp_' in name:
        assert b'cue ' in sound or b'smpl' in sound, 'Engine loop must carry loop markers'
print('PASS: compiled loops/durations, retained source, materials, icon and L4D2 audio assets')

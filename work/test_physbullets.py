"""Offline flight integration and authoritative hit dispatch; does not emulate GMod."""
from pathlib import Path
from lupa import LuaRuntime
from glua_check import to_lua

root = Path(__file__).resolve().parents[1]
lua = LuaRuntime()
lua.execute('''
MCV={ConVars={}}; SERVER=true; CLIENT=false; MASK_SHOT=1
function Color(r,g,b) return {r=r,g=g,b=b} end
MASK_WATER=2; CONTENTS_SLIME=16; bit={band=function(a,b) return a & b end}
local V={}; V.__index=V
function Vector(x,y,z) return setmetatable({x=x or 0,y=y or 0,z=z or 0},V) end
function V.__add(a,b) return Vector(a.x+b.x,a.y+b.y,a.z+b.z) end
function V.__sub(a,b) return Vector(a.x-b.x,a.y-b.y,a.z-b.z) end
function V.__mul(a,b) return Vector(a.x*b,a.y*b,a.z*b) end
function V:Length() return math.sqrt(self.x^2+self.y^2+self.z^2) end
function V:Dot(b) return self.x*b.x+self.y*b.y+self.z*b.z end
function V:GetNormalized() local n=self:Length(); if n==0 then return Vector() end; return self*(1/n) end
function V:Angle() return {Forward=function() return self:GetNormalized() end,Right=function() return Vector(0,1,0) end,Up=function() return Vector(0,0,1) end} end
vector_origin=Vector()
function IsValid(v) return type(v)=='table' and not v.invalid end
function math.Clamp(v,a,b) return math.max(a,math.min(b,v)) end
function math.Rand(a,b) return (a+b)/2 end
math.pow=function(a,b) return a^b end
local defaults={mcv_physbullets=1,mcv_physbullets_npcs=0,mcv_physbullets_pellets=0,
    mcv_physbullets_velocity=1,mcv_physbullets_gravity=1,mcv_physbullets_drag=0,mcv_physbullets_lifetime=5}
for k,v in pairs(defaults) do
    MCV.ConVars[k]={value=v,GetFloat=function(s) return s.value end,GetBool=function(s) return s.value~=0 end}
end
function near(a,b) assert(math.abs(a-b)<0.00001,tostring(a)..' != '..tostring(b)) end
hooks={}; hook={Add=function(event,name,fn) hooks[event]=fn end}
engine={TickInterval=function() return 1/60 end}
impactIDs={}
net={Start=function(name) messageName=name; contactID=nil end,
    WriteUInt=function(v) if messageName=='MCV_PhysicalImpact' and contactID==nil then contactID=v end end,WriteVector=function() end,
    WriteEntity=function() end,WriteString=function() end,WriteBool=function() end,WriteColor=function() end,
    WriteFloat=function() end,Broadcast=function() if messageName=='MCV_PhysicalImpact' then
        impactCount=impactCount+1; impactIDs[#impactIDs+1]=contactID end end}
wall=1000; hitCount=0; applied=0; impactCount=0; penetrated=false
util={AddNetworkString=function() end}
splashes=0
function EffectData()
    return {SetOrigin=function() end,SetNormal=function() end,SetScale=function() end,SetFlags=function() end}
end
util.PointContents=function() return 0 end
util.Effect=function(name) assert(name=='watersplash'); splashes=splashes+1 end
function util.TraceLine(t)
    if t.mask==MASK_WATER then
        if water and t.start.x < water and t.endpos.x >= water then
            return {Hit=true,HitPos=Vector(water,0,0),HitNormal=Vector(-1,0,0)}
        elseif water and t.start.x >= water then
            return {Hit=true,StartSolid=true,HitPos=t.start}
        end
        return {Hit=false}
    end
    if t.start.x < wall and t.endpos.x >= wall then
        return {Hit=true,HitPos=Vector(wall,0,0),StartPos=t.start,HitNormal=Vector(-1,0,0),HitSky=sky or false}
    end
    return {Hit=false,HitPos=t.endpos,StartPos=t.start}
end
MCV.SurfaceImpact=function() impactCount=impactCount+1; return true end
owner={EntIndex=function() return 1 end,IsPlayer=function() return false end,IsNPC=function(s) return s.npc or false end,GetShootPos=function() return Vector() end}
function owner:FireBullets(t)
    hitCount=hitCount+1; assert(t.Tracer==0 and t.Num==1)
    local damage={GetDamage=function() return t.Damage end}
    local result=t.Callback(self,{Hit=true,HitPos=Vector(wall,0,0),StartPos=t.Src,HitNormal=Vector(-1,0,0)},damage)
    assert(result.effects==false)
end
wep={MuzzleVelocity=25.4,DamageGeneric=40,VolleyCount=3,TracerParticle='vietnam_tracer_rifle_primary',TracerFrequency=1}
function wep:GetProjectileClass() return self.projectile end
function wep:GetBulletCount() return self.pellets or 1 end
function wep:GetOwner() return owner end
function wep:GetFiremodeValue() return 1 end
function wep:Clip1() return 10 end
function wep:GetAimVector() return Vector(1,0,0) end
function wep:GetSpread() return 0 end
function wep:GetNPCSpread() return 0 end
function wep:StatMult() return 1 end
function wep:ApplyBulletDamage(tr,dmg,distance,count) applied=applied+1; near(distance,wall); assert(count==1) end
function wep:QueuePenetration(tr,state,queue)
    if penetrated then
        penetrated=false
        queue[1]={src=Vector(wall+1,0,0),dir=Vector(1,0,0),distance=wall+1,
            damage=20,budget=0.5,layers=1,exitDamage=20,
            exitTrace={Hit=true,HitPos=Vector(wall+0.5,0,0),StartPos=Vector(wall+1,0,0),HitNormal=Vector(1,0,0)}}
        wall=2000
    end
end
MCV.FIREMODE_VOLLEY=10
''')
lua.execute(to_lua((root/'lua/mcv/shared/sh_tracercolor.lua').read_text()))
lua.execute(to_lua((root/'lua/mcv/shared/sh_physbullets.lua').read_text()))
lua.execute('''
local speed,g,drag,life=MCV.PhysicalBulletParameters(wep)
near(speed,1000); near(g,9.80665/0.0254)
for _,d in ipairs({0,0.5,2}) do
    local p,v=MCV.BulletFlightStep(Vector(),Vector(1000,0,0),1,g,d)
    local p2,v2=Vector(),Vector(1000,0,0)
    for i=1,120 do p2,v2=MCV.BulletFlightStep(p2,v2,1/120,g,d) end
    near(p.x,p2.x); near(p.z,p2.z); near(v.z,v2.z)
end
assert(MCV.PhysicalBulletsEnabled(wep))
wep.projectile='rocket'; assert(not MCV.PhysicalBulletsEnabled(wep)); wep.projectile=nil
wep.pellets=12; assert(not MCV.PhysicalBulletsEnabled(wep)); wep.pellets=nil
owner.npc=true; assert(not MCV.PhysicalBulletsEnabled(wep)); owner.npc=false
local old=wep.MuzzleVelocity; wep.MuzzleVelocity=nil
assert(not MCV.PhysicalBulletsEnabled(wep)); wep.MuzzleVelocity=old
MCV.ConVars.mcv_physbullets_gravity.value=0
''')
lua.execute('ents={FindByClass=function() return {} end}')
lua.execute(to_lua((root/'lua/mcv/server/sv_physbullet_glass.lua').read_text()))
lua.execute(to_lua((root/'lua/mcv/server/sv_physbullets.lua').read_text()))
lua.execute('''
MCV.LaunchPhysicalBullets(wep)
assert(hitCount==0)
for i=1,30 do hooks.Tick() end
assert(hitCount==0) -- target is one second away
for i=1,35 do hooks.Tick() end
assert(hitCount==1 and applied==1 and impactCount==1)
for i=1,30 do hooks.Tick() end
assert(hitCount==1)
hooks.PostCleanupMap(); wall=1000; penetrated=true
MCV.LaunchPhysicalBullets(wep)
for i=1,130 do hooks.Tick() end
assert(hitCount==3 and applied==3) -- entry plus second wall
assert(impactCount==4 and #impactIDs==4) -- original hit, entry, exit, next entry
assert(impactIDs[2]==0 and impactIDs[3]==1 and impactIDs[4]==2)
hooks.PostCleanupMap(); wall=1; sky=true
MCV.LaunchPhysicalBullets(wep); hooks.Tick(); assert(hitCount==3)
sky=false; wall=100000; MCV.ConVars.mcv_physbullets_lifetime.value=0.1
MCV.LaunchPhysicalBullets(wep)
for i=1,20 do hooks.Tick() end
wall=1; hooks.Tick(); assert(hitCount==3)
hooks.PostCleanupMap()
wall=1000; water=500; MCV.ConVars.mcv_physbullets_lifetime.value=5
MCV.LaunchPhysicalBullets(wep)
for i=1,65 do hooks.Tick() end
assert(splashes==1) -- crossing, not one splash per underwater tick
hooks.PostCleanupMap(); wall=100000
MCV.LaunchPhysicalBullets(wep,Vector(1000,0,0),Vector(-1,0,0))
for i=1,65 do hooks.Tick() end
assert(splashes==2) -- exactly one exit splash
water=nil; hooks.PostCleanupMap()
-- Powered flight reaches 1000 HU after ~0.15 s, not immediately at top speed.
wep.BulletLaunchVelocity=40; wep.BulletBoostTime=0.2; wep.MuzzleVelocity=403
wall=1000; local hits=hitCount
MCV.LaunchPhysicalBullets(wep)
for i=1,6 do hooks.Tick() end
assert(hitCount==hits)
for i=1,3 do hooks.Tick() end
assert(hitCount==hits+1)
wep.BulletLaunchVelocity=nil; wep.BulletBoostTime=nil; wep.MuzzleVelocity=25.4
hooks.PostCleanupMap()
''')
print('PASS: weapon velocity units, gravity/drag tick independence, routing, flight delay, one hit, penetration, sky, expiry and cleanup')

# At contact range the shot source can overlap a character's hitboxes. Source
# FireBullets handles startsolid hits; the flight loop must not discard them.
lua.execute('''
local trace,fire,apply,queue=util.TraceLine,owner.FireBullets,wep.ApplyBulletDamage,wep.QueuePenetration
local target={}; local contact,inside,world,allSolid
local damaged=0
util.TraceLine=function(t)
    if t.mask==MASK_WATER then return {Hit=false} end
    if inside then
        return {Hit=true,StartSolid=true,AllSolid=allSolid,HitWorld=world,Entity=world and nil or target,
            HitPos=t.start,StartPos=t.start,HitNormal=Vector(-1,0,0)}
    elseif t.start.x < contact and t.endpos.x >= contact then
        return {Hit=true,Entity=target,HitPos=Vector(contact,0,0),StartPos=t.start,HitNormal=Vector(-1,0,0)}
    end
    return {Hit=false,HitPos=t.endpos,StartPos=t.start}
end
owner.FireBullets=function(self,t)
    assert(t.Num==1 and t.Tracer==0 and t.Damage==40 and t.IgnoreEntity==wep)
    local tr=util.TraceLine({start=t.Src,endpos=t.Src+t.Dir*t.Distance,mask=MASK_SHOT})
    assert(tr.Hit and tr.Entity==target, 'damage retrace lost its target')
    local result=t.Callback(self,tr,{GetDamage=function() return t.Damage end})
    assert(result.effects==false and result.damage~=false)
    damaged=damaged+1
end
wep.ApplyBulletDamage=function(self,tr,damage,distance,count)
    assert(tr.Entity==target and count==6)
    near(distance,inside and 0 or contact)
end
wep.QueuePenetration=function() end -- characters are terminal contacts
wep.pellets=6; wep.MuzzleVelocity=403
for _,range in ipairs({0,0.01,1,16,64,1000}) do
    for _,solid in ipairs({false,true}) do
        hooks.PostCleanupMap(); contact=range; inside=range==0; allSolid=solid; world=false
        local before=damaged
        MCV.LaunchPhysicalBullets(wep)
        for i=1,15 do hooks.Tick() end
        assert(damaged==before+6, 'lost point-blank pellets at '..range..' HU')
        for i=1,15 do hooks.Tick() end
        assert(damaged==before+6, 'pellets damaged the target more than once')
    end
end
hooks.PostCleanupMap(); inside=true; world=true
local before=damaged
MCV.LaunchPhysicalBullets(wep)
for i=1,15 do hooks.Tick() end
assert(damaged==before, 'solid-world start fired through the wall')
hooks.PostCleanupMap()
util.TraceLine,owner.FireBullets,wep.ApplyBulletDamage,wep.QueuePenetration=trace,fire,apply,queue
wep.pellets=nil; wep.MuzzleVelocity=25.4; wall=1000
''')
print('PASS: six-pellet contact/overlap hits, normal ranges, terminal damage once and solid-world rejection')

# Exercise the actual client receiver and cleanup with particle/render stand-ins.
lua.execute('''
now=0; function CurTime() return now end
function UnPredictedCurTime() return now end
function FrameNumber() return math.floor(now*60+0.001) end
function LocalPlayer() return owner end
first=true; function IsFirstTimePredicted() return first end
function CreateMaterial() return {} end
function Material() return {} end
game={AddParticles=function() end,SinglePlayer=function() return false end}; function PrecacheParticleSystem() end
visualContacts={}
MCV.PhysicalBulletImpact=function(key,layer,tr,damage)
    if tr.Hit and not tr.HitSky then
        impactCount=impactCount+1
        visualContacts[#visualContacts+1]={id=layer,trace=tr,damage=damage}
    end
end
function Color(r,g,b) return {r=r,g=g,b=b} end
MCV.TracerColorMode=function() return 0 end
MCV.TRACER_COLOR_PLAYER=1; MCV.TRACER_COLOR_WEAPON=2
particles={}; beams={}
function CreateParticleSystemNoEntity(name,pos)
    local p={points={},name=name}
    function p:SetControlPoint(i,v) self.points[i]=v; self.updates=(self.updates or 0)+1 end
    function p:SetControlPointOrientation() end
    function p:SetShouldSimulate() end
    function p:SetSortOrigin(v) self.sort=v end
    function p:StartEmission()
        assert(self.points[0] and self.points[1] and self.sort)
        self.stopped=false; self.started=true
    end
    function p:StopEmissionAndDestroyImmediately() self.invalid=true end
    function p:StopEmission() self.stopped=true end
    particles[#particles+1]=p; return p
end
render={SetMaterial=function() end,DrawSprite=function() end,
    DrawBeam=function(a,b) beams[#beams+1]={a,b} end}
function net.Receive(name,fn) receiver=fn end
local packet
local function read() return table.remove(packet,1) end
net.ReadUInt=read; net.ReadVector=read; net.ReadEntity=read
net.ReadString=read; net.ReadBool=read; net.ReadFloat=read
function receive(t)
    if t[1] == 0 and #t == 15 then t[#t+1]=false end -- unpowered flight
    if t[1] ~= 2 then table.insert(t,6,t[1]==1 and 1 or 0) end
    if t[1] == 1 then
        table.insert(t,7,t[3].x); table.insert(t,8,20); table.insert(t,9,0.5)
    end
    packet={}
    for _,v in ipairs(t) do
        if type(v)=='table' and v.x then
            packet[#packet+1]=v.x; packet[#packet+1]=v.y; packet[#packet+1]=v.z
        else packet[#packet+1]=v end
    end
    receiver()
end
function spawn(id)
    receive({0,id,Vector(),Vector(1000,0,0),0,{invalid=true},{invalid=true},false,'',1,
        'vietnam_tracer_rifle_primary',true,0,0,5})
end
''')
lua.execute(to_lua((root/'lua/mcv/shared/sh_modelcache.lua').read_text()))
client = (root/'lua/mcv/client/cl_physbullets.lua').read_text()
# The syntax checker intentionally erases continue. Preserve its semantics here.
client = client.replace('if pending[token] then continue end', 'if pending[token] then goto next_prediction end')
client = client.replace('pending[token] = {bullet = b, expires = clock() + lifetime + 2}',
    'pending[token] = {bullet = b, expires = clock() + lifetime + 2}\n        ::next_prediction::')
client = client.replace('continue', 'goto next_visual')
client = client.replace('if !b.hidden then updateVisual(b, b.pos, b.vel, b.travelled) end\n        end',
    'if !b.hidden then updateVisual(b, b.pos, b.vel, b.travelled) end\n        end\n        ::next_visual::')
client = client.replace('render.DrawSprite(b.visualPos, b.width * 3, b.width * 3, b.color)',
    'render.DrawSprite(b.visualPos, b.width * 3, b.width * 3, b.color)\n        ::next_visual::')
lua.execute(to_lua(client))
lua.execute('''
spawn(1); particles[#particles].updates=0
now=0.1; hooks.Think(); hooks.PostDrawTranslucentRenderables(false,false)
assert(particles[#particles].updates==2) -- 12 collision substeps, one pair of CP writes
near(beams[#beams][2].x,100)
now=0.2; receive({1,1,Vector(500,0,0),Vector(1000,0,0),0})
hooks.Think(); near(particles[#particles].points[1].x,500)
now=0.3; hooks.Think(); near(particles[#particles].points[1].x,600)
receive({2,1,Vector(600,0,0)}); assert(particles[#particles].stopped and not particles[#particles].invalid)
spawn(2); local previous=particles[#particles]; spawn(2); assert(previous.stopped)
hooks.PostCleanupMap(); assert(particles[#particles].invalid)
spawn(3); now=10; hooks.Think(); assert(particles[#particles].stopped)
spawn(4); now=0; hooks.Think(); assert(particles[#particles].stopped)
spawn(5); hooks.ShutDown(); assert(particles[#particles].invalid)
spawn(6); receive({1,6,Vector(20000,0,0),Vector(40000,0,0),0})
now=0.1; hooks.Think(); near(particles[#particles].points[1].x,24000)
hooks.ShutDown()
''')
print('PASS: client flight, absent shooter, penetration correction, replacement, impact, expiry, clock rollback and cleanup')

lua.execute("""
hooks.PostCleanupMap(); now=0; wall=100000
MCV.ConVars.mcv_physbullets_lifetime.value=5
owner.IsPlayer=function() return true end
local command=123
owner.GetCurrentCommand=function() return {CommandNumber=function() return command end} end
owner.ShouldDrawLocalPlayer=function() return false end
local vm={GetModel=function() return 'test-model' end,SetupBones=function() end,LookupAttachment=function() return 1 end,
    GetAttachment=function() return {Pos=Vector(20,10,-5)} end}
owner.GetViewModel=function() return vm end
wep.EntIndex=function() return 8 end
wep.GetBurstCount=function() return 0 end
util.SharedRandom=function(name,a,b,seed) return (a+b)/2 end
local offset=Vector(20,10,-5)
near(MCV.PhysicalBulletVisualPosition(Vector(),offset,0).y,10)
near(MCV.PhysicalBulletVisualPosition(Vector(),offset,500).y,5)
near(MCV.PhysicalBulletVisualPosition(Vector(),offset,1000).y,0)
near(MCV.PhysicalBulletVisualPosition(Vector(),offset,2000).y,0)
local n=#particles
MCV.PredictPhysicalBullets(wep)
assert(#particles==n+1) -- no network delivery required
near(particles[#particles].points[0].y,10)
assert(particles[#particles].name=='mcv_phys_vietnam_tracer_rifle_smoke')
assert(particles[#particles].started) -- PCF delays actual emission until CP history is primed
MCV.PredictPhysicalBullets(wep); assert(#particles==n+1)
first=false; MCV.PredictPhysicalBullets(wep); first=true; assert(#particles==n+1)
now=0.5; hooks.Think()
assert(particles[#particles].started)
near(particles[#particles].points[1].x,510)
near(particles[#particles].points[1].y,5)
near(particles[#particles].points[0].x,510) -- emission follows the head, not the tail
receive({0,900,Vector(0,2,0),Vector(1000,0,0),0,owner,wep,false,'8:123:10:0',1,
    'vietnam_tracer_rifle_primary',true,0,0,5})
assert(#particles==n+1) -- adopted, no second smoke/streak
near(particles[#particles].points[0].y,7) -- correction updates smoke before the next Think
hooks.PostDrawTranslucentRenderables(false,false)
near(beams[#beams][2].x,particles[#particles].points[0].x)
near(beams[#beams][2].y,particles[#particles].points[0].y)
now=0.6; hooks.Think(); near(particles[#particles].points[1].x,608)
receive({2,900,Vector(600,0,0)}); assert(particles[#particles].stopped)
-- Retain a tombstone, so a repeated spawn cannot replay a completed shot.
receive({0,900,Vector(),Vector(1000,0,0),0,owner,wep,false,'8:123:10:0',1,
    'vietnam_tracer_rifle_primary',true,0,0,5})
assert(#particles==n+1)
command=124; wall=1; MCV.PredictPhysicalBullets(wep)
local beforeContact=impactCount
now=0.7; hooks.Think(); assert(particles[#particles].stopped)
assert(impactCount==beforeContact+1) -- immediate client impact, no server message
near(particles[#particles].points[0].x,20.98) -- contact at x=1 still includes muzzle blend
local hits=hitCount; hooks.Think(); assert(hitCount==hits)
hooks.PostCleanupMap()
-- Predicted penetration emits a distinct far-face contact immediately, without damage.
command=126; wall=1; penetrated=true
local contactsBefore=#visualContacts
MCV.PredictPhysicalBullets(wep)
now=0.8; hooks.Think()
assert(#visualContacts==contactsBefore+2 and hitCount==hits)
local entry,exit=visualContacts[contactsBefore+1],visualContacts[contactsBefore+2]
assert(entry.id==0 and exit.id==1 and exit.trace.HitNormal.x==1 and exit.damage==20)
near(exit.trace.HitPos.x,1.5)
hooks.PostCleanupMap()
-- Independent pellet identities survive the same command's confirmation.
wall=100000; command=125; wep.pellets=3
local count=#particles
MCV.PredictPhysicalBullets(wep); assert(#particles==count+3)
MCV.PredictPhysicalBullets(wep); assert(#particles==count+3)
for i=1,3 do
    receive({0,1000+i,Vector(),Vector(1000,0,0),0,owner,wep,false,'8:125:10:0',i,
        'vietnam_tracer_rifle_primary',true,0,0,5})
end
assert(#particles==count+3)
hooks.PostCleanupMap(); wep.pellets=nil
-- Render-captured muzzle survives prediction moving the live attachment to origin.
local renderEye=Vector(5000,0,0)
function EyePos() return renderEye end
function EyeAngles() return Vector(1,0,0):Angle() end
function Lerp(t,a,b) return a+(b-a)*t end
wep.ViewModelFOV=60; wep.SightedViewModelFOV=40
wep.GetSightAmountVisual=function() return 0 end
owner.GetFOV=function() return 90 end
vm.GetModel=function() return 'test-model' end
vm.GetAttachment=function() error('disabled muzzle capture touched attachments') end
MCV.ConVars.mcv_physbullets.value=0
MCV.CapturePhysicalMuzzles(wep,vm)
MCV.ConVars.mcv_physbullets.value=1
local velocity=wep.MuzzleVelocity; wep.MuzzleVelocity=0
MCV.CapturePhysicalMuzzles(wep,vm)
wep.MuzzleVelocity=velocity
vm.GetAttachment=function() return {Pos=Vector(5020,10,-5)} end
now=10; MCV.CapturePhysicalMuzzles(wep,vm)
vm.GetAttachment=function() return {Pos=Vector()} end
command=998
MCV.PredictPhysicalBullets(wep,renderEye)
near(particles[#particles].points[0].x,5020)
near(particles[#particles].points[0].y,10*math.sqrt(3))
near(particles[#particles].points[0].z,-5*math.sqrt(3))
hooks.PostCleanupMap()
-- First shot after cleanup, far from origin, with a stale muzzle attachment.
owner.GetCurrentCommand=function() return {CommandNumber=function() return 999 end} end
now=20; wall=5001
MCV.PredictPhysicalBullets(wep,Vector(5000,0,0))
near(particles[#particles].points[0].x,5000)
near(particles[#particles].points[1].x,5000)
now=20.1; hooks.Think(); assert(particles[#particles].stopped)
receive({0,2000,Vector(5000,0,0),Vector(1000,0,0),0,owner,wep,false,'8:999:10:0',1,
    'vietnam_tracer_rifle_primary',true,0,0,5})
receive({1,2000,Vector(6000,0,0),Vector(1000,0,0),0.2})
near(particles[#particles].points[0].x,6000)
near(particles[#particles].points[1].x,6000)
assert(particles[#particles].started)
hooks.PostCleanupMap()
""")
print('PASS: immediate prediction, replay deduplication, server adoption, tombstones, cosmetic collision and 1000-HU muzzle blend')

lua.execute('''
hooks.PostCleanupMap(); now=0; wall=100000
local tracer=wep.TracerParticle
wep.TracerParticle='vietnam_tracer_silenced_primary'
local count,beamCount=#particles,#beams
MCV.PredictPhysicalBullets(wep)
assert(#particles==count+1 and particles[#particles].name=='mcv_phys_vietnam_tracer_silenced_smoke')
MCV.PredictPhysicalBullets(wep); assert(#particles==count+1)
first=false; MCV.PredictPhysicalBullets(wep); first=true; assert(#particles==count+1)
receive({0,8000,Vector(),Vector(1000,0,0),0,owner,wep,false,'8:999:10:0',1,
    wep.TracerParticle,true,0,0,5})
assert(#particles==count+1) -- local confirmation adopts, never duplicates smoke
now=0.1; hooks.Think(); hooks.PostDrawTranslucentRenderables(false,false)
assert(#beams==beamCount) -- no glow even when the frequency bit is true
receive({1,8000,Vector(500,0,0),Vector(1000,0,0),0.1})
assert(#particles==count+2) -- local penetration/correction retains smoke
hooks.PostCleanupMap()
count=#particles
for i,shooter in ipairs({{IsPlayer=function() return true end},
        {IsPlayer=function() return false end},{invalid=true}}) do
    -- The weapon may be out of PVS; privacy comes from the networked tracer family.
    receive({0,8100+i,Vector(),Vector(1000,0,0),0,shooter,{invalid=true},false,'',1,
        wep.TracerParticle,true,0,0,5})
    receive({1,8100+i,Vector(500,0,0),Vector(1000,0,0),0.1})
end
now=0.2; hooks.Think(); hooks.PostDrawTranslucentRenderables(false,false)
assert(#particles==count and #beams==beamCount)
-- SP/out-of-command authoritative spawns still create the local player's smoke.
receive({0,8200,Vector(),Vector(1000,0,0),0,owner,wep,false,'',1,
    wep.TracerParticle,true,0,0,5})
assert(#particles==count+1)
hooks.PostCleanupMap(); wep.TracerParticle=tracer
''')
print('PASS: physical silenced trails, immediate local prediction/adoption, SP spawn, observer/NPC/PVS privacy and correction restarts')

lua.execute('''
hooks.PostCleanupMap(); now=0; wall=100000
wep.BulletLaunchVelocity=40; wep.BulletBoostTime=0.2; wep.MuzzleVelocity=403
local acceleration=Vector(1815/0.0254,0,0)
local count=#particles
MCV.PredictPhysicalBullets(wep)
now=0.1; hooks.Think(); near(particles[#particles].points[0].x,13.075/0.0254)
receive({0,9001,Vector(),Vector(40/0.0254,0,0),0,owner,wep,false,'8:999:10:0',1,
    'vietnam_tracer_gyrojet_primary',true,0,0,5,true,acceleration,0.2})
assert(#particles==count+1) -- adoption keeps the predicted motor, no second tracer
near(particles[#particles].points[0].x,13.075/0.0254)
now=0.15
receive({1,9001,Vector(13.075/0.0254,0,0),Vector(221.5/0.0254,0,0),0.1})
near(particles[#particles].points[0].x,26.41875/0.0254) -- catch-up during burn
now=0.3; hooks.Think(); near(particles[#particles].points[0].x,84.6/0.0254)
hooks.PostCleanupMap()
-- Remote flight still accelerates when weapon/shooter entities are absent from PVS.
now=1
receive({0,9002,Vector(),Vector(40/0.0254,0,0),0,{invalid=true},{invalid=true},false,'',1,
    'vietnam_tracer_gyrojet_primary',true,0,0,5,true,acceleration,0.2})
now=1.1; hooks.Think(); near(particles[#particles].points[0].x,13.075/0.0254)
now=1.3; hooks.Think(); near(particles[#particles].points[0].x,84.6/0.0254)
hooks.PostCleanupMap()
wep.BulletLaunchVelocity=nil; wep.BulletBoostTime=nil; wep.MuzzleVelocity=25.4
''')
print('PASS: accelerated authoritative contact, predicted motor adoption, mid-burn correction, burnout and absent-shooter networking')

lua.execute('''
custom=true; customHits=0; stockHits=0; DMG_BULLET=2
ricochetFlags={}
MCV.SurfaceImpact=function(tr,damage,recipients,ricochet)
    ricochetFlags[#ricochetFlags+1]=ricochet
    if custom then customHits=customHits+1; return true end return false
end
function EffectData() return setmetatable({}, {__index=function() return function() end end}) end
util.Effect=function(name) assert(name=='Impact'); stockHits=stockHits+1 end
function net.Receive(name,fn) impactReceiver=fn end
local packet
local function read() return table.remove(packet,1) end
net.ReadString=read; net.ReadUInt=read; net.ReadFloat=read; net.ReadEntity=read; net.ReadBool=read; net.ReadColor=read
function confirm(key,layer,x)
    packet={key,layer,x,0,0,0,0,0,-1,0,0,{invalid=true},0,0,0,40,true,Color(235,175,51)}
    impactReceiver()
end
function contact(x)
    return {Hit=true,HitPos=Vector(x,0,0),StartPos=Vector(),HitNormal=Vector(-1,0,0)}
end
''')
impact_source = (root/'lua/mcv/shared/sh_impacts.lua').read_text()
impact_source = impact_source[impact_source.index('function MCV.BulletImpact('):]
lua.execute(to_lua(impact_source[:impact_source.index(chr(10)+'end')+4]))
lua.execute(to_lua((root/'lua/mcv/client/cl_physbullet_impacts.lua').read_text()))
lua.execute('''
first=false -- Think/network delivery must not rely on IsFirstTimePredicted.
MCV.PhysicalBulletImpact('shot',0,contact(100),40,true)
assert(customHits==1)
confirm('shot',0,100); confirm('shot',0,100); assert(customHits==1)
MCV.PhysicalBulletImpact('shot',1,contact(101),20); confirm('shot',1,101)
assert(customHits==2) -- 1-HU wall: exit must survive the 32-HU confirmation tolerance
MCV.PhysicalBulletImpact('shot',2,contact(102),20,true); confirm('shot',2,102)
assert(customHits==3) -- next wall's entry is distinct from the preceding exit
confirm('remote',0,100); confirm('remote',1,101); assert(customHits==5)
assert(ricochetFlags[1] and not ricochetFlags[2] and ricochetFlags[3])
assert(ricochetFlags[4] and not ricochetFlags[5]) -- server-only and predicted exits both opt out
MCV.PhysicalBulletImpact('remote',0,contact(100),40); assert(customHits==5)
confirm('correction',0,100); confirm('correction',0,500); assert(customHits==7)
custom=false; MCV.PhysicalBulletImpact('stock',0,contact(100),40)
confirm('stock',0,100); assert(stockHits==1)
game.SinglePlayer=function() return true end
confirm('singleplayer',0,100); assert(stockHits==2)
local sky=contact(100); sky.HitSky=true
MCV.PhysicalBulletImpact('sky',0,sky,40); assert(stockHits==2)
hooks.PostCleanupMap(); confirm('stock',0,100); assert(stockHits==3)
''')
print('PASS: one custom/stock impact, immediate contact, server echo suppression, distinct layers, remote/SP, correction and cleanup')

lua.execute('''
CLIENT=true; SERVER=false; SWEP={}
local names={'METAL','GRATE','VENT','GLASS','CONCRETE','TILE','WOOD','FLESH','BLOODYFLESH','ALIENFLESH'}
for i,name in ipairs(names) do _G['MAT_'..name]=i end
local V=getmetatable(Vector()); function V:LengthSqr() return self:Dot(self) end
MCV.BulletPenetration=function() return true end
cover={invalid=true}
util.TraceLine=function(t)
    if t.start.x > 12 then
        return {Hit=true,HitPos=Vector(12,0,0),HitNormal=Vector(1,0,0),Entity=cover}
    end
    return {Hit=false,StartSolid=true}
end
''')
lua.execute(to_lua((root/'lua/weapons/mcv_base/sh_penetration.lua').read_text()))
lua.execute('''
SWEP.WoodPenetrationDepth=4; SWEP.WoodDamageModifier=1
SWEP.StatMult=function() return 1 end; SWEP.GetOwner=function() return owner end
local queue={}
SWEP:QueuePenetration({Hit=true,HitWorld=true,Entity=cover,MatType=MAT_WOOD,
    HitPos=Vector(10,0,0),StartPos=Vector()},
    {damage=40,distance=0,budget=1,layers=0},queue)
assert(#queue==1); near(queue[1].damage,20); near(queue[1].distance,12.03125)
assert(queue[1].layers==1)
''')
print('PASS: actual shared client penetration probes, damage attenuation and continuation state')

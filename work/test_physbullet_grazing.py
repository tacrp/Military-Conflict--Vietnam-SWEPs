"""Offline grazing contacts with Source-style plane tolerance, not an engine test.

Source's collisionutils.cpp rejects rays wholly in front of a face, but reports
crossing contacts a tolerance in front of it. Retracing to that reported point
plus a fixed forward epsilon can therefore miss the same face at shallow angles.
"""
from pathlib import Path
from lupa import LuaRuntime
from glua_check import to_lua

ROOT = Path(__file__).resolve().parents[1]
lua = LuaRuntime()
lua.execute('''
SERVER=true; CLIENT=false; MCV={ConVars={}}; MASK_SHOT=1; MASK_WATER=2
CONTENTS_SLIME=16; bit={band=function(a,b) return a & b end}
local V={}; V.__index=V
function Vector(x,y,z) return setmetatable({x=x or 0,y=y or 0,z=z or 0},V) end
function V.__add(a,b) return Vector(a.x+b.x,a.y+b.y,a.z+b.z) end
function V.__sub(a,b) return Vector(a.x-b.x,a.y-b.y,a.z-b.z) end
function V.__mul(a,b) return Vector(a.x*b,a.y*b,a.z*b) end
function V:Dot(b) return self.x*b.x+self.y*b.y+self.z*b.z end
function V:Length() return math.sqrt(self:Dot(self)) end
function V:GetNormalized() return self*(1/self:Length()) end
function V:Angle() return {Forward=function() return self end,Right=function() return Vector(0,1,0) end,Up=function() return Vector(0,0,1) end} end
vector_origin=Vector()
function IsValid(e) return type(e)=='table' and not e.invalid end
function math.Clamp(v,a,b) return math.max(a,math.min(b,v)) end
math.pow=function(a,b) return a^b end
function near(a,b) assert(math.abs(a-b)<0.00001, tostring(a)..' != '..tostring(b)) end
function math.Rand(a,b) return (a+b)/2 end
for name,value in pairs({velocity=1,gravity=0,drag=0,lifetime=5}) do
    MCV.ConVars['mcv_physbullets_'..name]={GetFloat=function() return value end}
end
hooks={}; hook={Add=function(event,name,fn) hooks[event]=fn end}
engine={TickInterval=function() return dt end}
util={AddNetworkString=function() end,PointContents=function() return 0 end}
MCV.PhysicalBulletGlass=function() end
packets={}
local packet
net={Start=function(name) packet={name=name,floats={},uints={}} end,
    WriteFloat=function(v) packet.floats[#packet.floats+1]=v end,
    WriteUInt=function(v) packet.uints[#packet.uints+1]=v end,
    WriteEntity=function(e) end,WriteString=function(s) end,WriteBool=function(v) end,
    Broadcast=function() if packet.name=='MCV_PhysicalImpact' then packets[#packets+1]=packet end end}
owner={IsPlayer=function() return false end,IsNPC=function() return false end,EntIndex=function() return 1 end,
    GetShootPos=function() return origin end}
wep={MuzzleVelocity=609.6,DamageGeneric=40,RangeModifier=0.9}
function wep:GetOwner() return owner end
function wep:GetBulletCount() return pellets end
function wep:GetFiremodeValue() return 1 end
function wep:GetAimVector() return direction end
function wep:GetNPCSpread() return 0 end
function wep:GetSpread() return 0 end
function wep:Clip1() return 10 end
function wep:StatMult() return 1 end
function wep:ApplyBulletDamage(tr,damage,distance,count)
    assert(count==pellets)
    damage.value=damage.value*MCV.BulletRangeMultiplier(self,distance)
end
function wep:QueuePenetration(tr)
    if tr.Hit then penetrationContacts=penetrationContacts+1 end
end

function planeTrace(from,to)
    local d1=(from-plane):Dot(normal)
    local d2=(to-plane):Dot(normal)
    if d1>0 and d2>0 then return {Hit=false,StartPos=from,HitPos=to} end
    assert(d1>0 and d2<=0)
    local fraction=math.max(0,d1-tolerance)/(d1-d2)
    return {Hit=true,HitPos=from+(to-from)*fraction,StartPos=from,HitNormal=normal,
        Entity=surface,HitWorld=world,SurfaceProps=7,MatType=8}
end
function util.TraceLine(t)
    if t.mask==MASK_WATER then return {Hit=false} end
    assert(t.mask==MASK_SHOT and t.filter[1]==owner and t.filter[2]==wep)
    sweptEnd=t.endpos; sweptStart=t.start
    swept=planeTrace(t.start,t.endpos)
    return swept
end
function owner:FireBullets(t)
    calls=calls+1
    assert(t.Num==1 and t.Tracer==0 and t.IgnoreEntity==wep)
    local endpoint=t.Src+t.Dir*t.Distance
    -- No extending the damage ray beyond the simulated step to force contact.
    assert(t.Distance<=(sweptEnd-sweptStart):Length()+0.00001)
    local tr=planeTrace(t.Src,endpoint)
    local dmg={value=t.Damage,GetDamage=function(s) return s.value end}
    local result=t.Callback(self,tr,dmg)
    assert(result.effects==false)
    if tr.Hit and result.damage~=false then damaged=damaged+1 end
end
''')
lua.execute(to_lua((ROOT/'lua/mcv/shared/sh_physbullets.lua').read_text()))
lua.execute(to_lua((ROOT/'lua/mcv/server/sv_physbullets.lua').read_text()))
lua.execute('''
local cases=0
for _,tickrate in ipairs({30,66,120}) do
    dt=1/tickrate
    local step=dt/math.ceil(dt/(1/120))
    for _,count in ipairs({1,6}) do
        pellets=count
        for _,isWorld in ipairs({true,false}) do
            world=isWorld; surface={invalid=world}
            for _,axis in ipairs({1,3}) do
                normal=axis==1 and Vector(1,0,0) or Vector(0,0,1)
                local tangent=axis==1 and Vector(0,0,1) or Vector(1,0,0)
                for _,angle in ipairs({90,45,20,10,5,1,0.1}) do
                    for _,epsilon in ipairs({1/32,1/16}) do
                        hooks.PostCleanupMap()
                        tolerance=epsilon
                        local sine=math.sin(math.rad(angle))
                        direction=tangent*math.cos(math.rad(angle))-normal*sine
                        plane=Vector(12000,-8000,6000)
                        origin=plane+normal*(24000*step*0.5*sine)
                        packets={}; calls=0; damaged=0; penetrationContacts=0
                        MCV.LaunchPhysicalBullets(wep)
                        hooks.Tick()
                        assert(#packets==count, 'Missing grazing impact: '..angle..' degrees, '..tickrate..' Hz')
                        assert(calls==count and damaged==count and penetrationContacts==count)
                        for _,p in ipairs(packets) do
                            assert(p.uints[1]==0 and p.uints[2]==7 and p.uints[3]==8)
                            local pos=Vector(p.floats[1],p.floats[2],p.floats[3])
                            near((pos-plane):Dot(normal),tolerance)
                            near(p.floats[7],normal.x); near(p.floats[8],normal.y); near(p.floats[9],normal.z)
                            near(p.floats[10],40*0.9^((pos-origin):Length()/500))
                        end
                        for i=1,4 do hooks.Tick() end
                        assert(calls==count and #packets==count, 'duplicate contact on a later tick')
                        cases=cases+1
                    end
                end
            end
        end
    end
end
assert(cases==336)
''')
print('PASS: 336 tolerance/angle/tickrate/world/prop/pellet cases, one damage+impact, correct contact data and no overshoot')

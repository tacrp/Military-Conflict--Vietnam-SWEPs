"""Actual hitscan callback/effect routing; no game launch."""
from pathlib import Path
from lupa import LuaRuntime
from glua_check import to_lua

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
game={SinglePlayer=function() return sp end}
function IsFirstTimePredicted() return first end
function IsValid(v) return type(v)=='table' and not v.invalid end
DMG_BULLET=2; events={}; traces=0; applied=0
local V={};V.__index=V
function Vector(x,y,z) return setmetatable({x=x or 0,y=y or 0,z=z or 0},V) end
function V.__sub(a,b) return Vector(a.x-b.x,a.y-b.y,a.z-b.z) end
function V:Length() return math.sqrt(self.x^2+self.y^2+self.z^2) end
vector_origin=Vector()
function EffectData() return setmetatable({}, {__index=function() return function() end end}) end
function RecipientFilter()
    return {AddPVS=function() end,RemovePlayer=function(s,p) s.excluded=p end}
end
util={Effect=function(name,data,a,recipients) events[#events+1]={name=name,recipients=recipients} end}
MCV.SurfaceImpact=function(tr,damage,recipients)
    if not custom then return false end
    util.Effect('mcv_impact',{},true,recipients); return true
end
owner={IsPlayer=function() return not npc end,LagCompensation=function() end,
    GetShootPos=function() return Vector() end}
function SWEP:GetOwner() return owner end
function SWEP:GetSpread() return 0 end
function SWEP:GetBulletCount() return 1 end
function SWEP:GetFiremodeValue() return 1 end
function SWEP:GetAimVector() return Vector(1,0,0) end
function SWEP:StatMult() return 1 end
function SWEP:ApplyBulletDamage() applied=applied+1 end
function SWEP:QueuePenetration(tr,state,queue)
    if state.layers==0 then
        queue[#queue+1]={src=tr.HitPos,dir=Vector(1,0,0),damage=20,distance=10,budget=.5,layers=1}
    end
end
function owner:FireBullets(data)
    traces=traces+1
    assert(data.Tracer==0) -- callback owns tracer and impacts
    local tr={Hit=true,StartPos=data.Src,HitPos=Vector(traces*10,0,0),HitNormal=Vector(-1,0,0)}
    local result=data.Callback(self,tr,{GetDamage=function() return data.Damage end})
    assert(result.effects==false) -- no extra engine impact/DoImpactEffect path
end
''')
                lua.execute(to_lua((root/'lua/mcv/shared/sh_hitscaneffects.lua').read_text()))
                lua.execute(to_lua(attack))
                lua.execute('''
SWEP:BulletAttack()
if CLIENT and (sp or not first) then
    assert(traces==0 and #events==0)
else
    assert(traces==2 and applied==2 and #events==3)
    assert(events[1].name=='mcv_tracer')
    assert(events[2].name==(custom and 'mcv_impact' or 'Impact'))
    assert(events[3].name==events[2].name)
    for _,event in ipairs(events) do
        if SERVER then assert((event.recipients.excluded==owner)==(not sp))
        else assert(event.recipients==true) end
    end
end
if SERVER then
    npc=true; events={}; traces=0; SWEP:BulletAttack()
    for _,event in ipairs(events) do assert(not event.recipients.excluded) end
end
''')
print('PASS: hitscan MP local prediction, replay suppression, server recipients, SP/NPC, custom/stock, tracers and client penetration')

"""Offline mine surface geometry, placement routing and detonation lifecycle."""
from pathlib import Path
from lupa import LuaRuntime
from glua_check import to_lua

ROOT = Path(__file__).resolve().parents[1]
lua = LuaRuntime()
lua.execute('''
SERVER=true; CLIENT=false; now=100; ENT={}; SWEP={}; MCV={}
function AddCSLuaFile() end
function Material() return {} end
function CurTime() return now end
function IsValid(v) return type(v)=='table' and not v.removed end
math.atan2=math.atan
local V={}; V.__index=V
function Vector(x,y,z) return setmetatable({x=x,y=y,z=z},V) end
function isvector(v) return getmetatable(v)==V end
function V.__add(a,b) return Vector(a.x+b.x,a.y+b.y,a.z+b.z) end
function V.__sub(a,b) return Vector(a.x-b.x,a.y-b.y,a.z-b.z) end
function V.__mul(a,b) return Vector(a.x*b,a.y*b,a.z*b) end
function V:Dot(b) return self.x*b.x+self.y*b.y+self.z*b.z end
function V:Cross(b) return Vector(self.y*b.z-self.z*b.y,self.z*b.x-self.x*b.z,self.x*b.y-self.y*b.x) end
function V:Length() return math.sqrt(self:Dot(self)) end
function V:GetNormalized() return self*(1/self:Length()) end
function near(a,b) assert(math.abs(a-b)<1e-6,tostring(a)..' ~= '..tostring(b)) end
function same(a,b) near(a.x,b.x); near(a.y,b.y); near(a.z,b.z) end
-- Source's angle basis and right-handed axis rotation, independent of placement code.
local A={}; A.__index=A
function Angle(p,y,r)
    local sp,cp=math.sin(math.rad(p)),math.cos(math.rad(p))
    local sy,cy=math.sin(math.rad(y)),math.cos(math.rad(y))
    local sr,cr=math.sin(math.rad(r)),math.cos(math.rad(r))
    return setmetatable({p=p,y=y,r=r,f=Vector(cp*cy,cp*sy,-sp),
        right=Vector(-sr*sp*cy+cr*sy,-sr*sp*sy-cr*cy,-sr*cp),
        up=Vector(cr*sp*cy+sr*sy,cr*sp*sy-sr*cy,cr*cp)},A)
end
function A:Forward() return self.f end
function A:Right() return self.right end
function A:Up() return self.up end
function A:RotateAroundAxis(axis,degrees)
    local c,s=math.cos(math.rad(degrees)),math.sin(math.rad(degrees))
    local function rotate(v) return v*c+axis:Cross(v)*s+axis*(axis:Dot(v)*(1-c)) end
    self.f,self.right,self.up=rotate(self.f),rotate(self.right),rotate(self.up)
end
function V:Angle() return Angle(math.deg(math.atan(-self.z,math.sqrt(self.x^2+self.y^2))),math.deg(math.atan(self.y,self.x)),0) end
vector_up=Vector(0,0,1)
owner={EyeAngles=function() return Angle(0,37,0) end}
game={GetWorld=function() return {} end}
util={}; blasts=0; effects=0
util.BlastDamage=function() blasts=blasts+1 end
MCV.ExplosionEffect=function() effects=effects+1 end
util.TraceLine=function(t) checkedWire=t; return {Hit=blocked,StartSolid=solid} end
util.TraceHull=function(t) liveWire=t; return {Entity=crossing} end
''')
lua.execute(to_lua((ROOT/'lua/entities/mcv_proj_base.lua').read_text()))
lua.execute('projectile=ENT; ENT=setmetatable({}, {__index=projectile})')
lua.execute(to_lua((ROOT/'lua/entities/mcv_grenade_base.lua').read_text()))
lua.execute('''
grenade=ENT; ENT=setmetatable({}, {__index=grenade})
baseclass={Get=function(name) return name=='mcv_grenade_base' and grenade or projectile end}
''')
lua.execute(to_lua((ROOT/'lua/entities/mcv_placed_mine.lua').read_text()))
lua.execute(to_lua((ROOT/'lua/weapons/mcv_placeable/sh_place.lua').read_text()))
lua.execute('''
function ENT:GetPos() return self.pos end
function ENT:GetUp() return self.up end
function ENT:GetStake() return self.stake end
function ENT:SetStake(stake) self.stake=stake end
function ENT:GetOwner() return owner end
function ENT:NextThink(t) self.nextThink=t end
function ENT:EmitSound() end
function ENT:WaterLevel() return 0 end
function ENT:Remove() self.removed=true end
function mineAt(pos,normal) return setmetatable({pos=pos,up=normal,SpawnTime=now}, {__index=ENT}) end
function SWEP:GetOwner() return owner end
function SWEP:GetActionState() return state end
function SWEP:GetActionVariant() return variant end
function SWEP:GetPlacedMine() return mine end
function SWEP:SetNWEntity(key,value) self[key]=value end
function SWEP:TakeRound(n) rounds=(rounds or 0)+n end
SWEP.PlaceKind='mine'; SWEP.WireLength=256; SWEP.StakeRaise=6
SWEP.StakeAngleOffset=Angle(0,0,180)
SWEP.StakeEntityClass='mcv_mine_stake'; SWEP.MineBodygroups={mine=0,stick=1}
SWEP.WorldModel='mine'
ents={Create=function(class)
    assert(class=='mcv_mine_stake')
    local s={}
    function s:SetPos(v) self.pos=v end
    function s:GetPos() return self.pos end
    function s:SetAngles(v) self.ang=v end
    function s:SetOwner(v) self.owner=v end
    function s:Spawn() end
    function s:Activate() end
    function s:SetParent(v) self.parent=v end
    function s:Remove() self.removed=true end
    return s
end}
-- Floor, vertical walls, slopes and ceilings share normal-relative attachment geometry.
for _,normal in ipairs({Vector(0,0,1),Vector(1,0,0),Vector(0,-1,0),
        Vector(0,0,-1),Vector(1,2,3):GetNormalized()}) do
    local angle=SWEP:PlaceAngle(normal)
    same(angle:Up(),normal)
    local tangent=angle:Forward()
    local origin=Vector(10,20,30)
    mine=mineAt(origin+normal*0.5,normal)
    local tr={Hit=true,HitPos=origin+tangent*100,HitNormal=normal}
    state=0; assert(SWEP:CanPlaceAt(tr))
    state=3; assert(SWEP:CanPlaceAt(tr))
    local start,finish=checkedWire.start,checkedWire.endpos
    same(start,origin+normal*4.5); same(finish,tr.HitPos+normal*6)
    local parent={}
    SWEP:SpawnStake(tr.HitPos,normal,parent)
    assert(mine.stake.parent==parent and mine.stake.Mine==mine)
    same(mine.stake.ang:Up(),normal*-1) -- stake's pointed end enters the surface
    local direction=mine:GetPos()-tr.HitPos
    local projected=(direction-normal*direction:Dot(normal)):GetNormalized()
    same(mine.stake.ang:Forward(),projected)
    local a,b=mine:WireEnds(); same(a,start); same(b,finish)
    now=now+3; mine:Think()
    same(liveWire.start,start); same(liveWire.endpos,finish)
    assert(not mine.Detonated)
    blocked=true; assert(not SWEP:CanPlaceAt(tr)); blocked=false
    solid=true; assert(not SWEP:CanPlaceAt(tr)); solid=false
    tr.HitPos=origin+tangent*10; assert(not SWEP:CanPlaceAt(tr))
    tr.HitPos=origin+tangent*300; assert(not SWEP:CanPlaceAt(tr))
end
-- A vertical run up one wall must face the mine vertically, not use world yaw.
same(SWEP:PlaceAngle(Vector(1,0,0),Vector(0,0,100),SWEP.StakeAngleOffset):Forward(),Vector(0,0,1))
state=0
assert(not SWEP:CanPlaceAt({Hit=true,HitSky=true}))
assert(not SWEP:CanPlaceAt({Hit=true,StartSolid=true}))
for _,kind in ipairs({'player','npc','nextbot'}) do
    local entity={IsPlayer=function() return kind=='player' end,
        IsNPC=function() return kind=='npc' end,IsNextBot=function() return kind=='nextbot' end}
    assert(not SWEP:CanPlaceAt({Hit=true,Entity=entity}))
end
-- Both unfinished and armed mines expire; arming late must not restart the timer.
for _,armed in ipairs({false,true}) do
    now=100; mine=mineAt(Vector(0,0,0),vector_up)
    local count=blasts
    now=399.95; mine:Think(); assert(blasts==count and not mine.Detonated)
    local stake
    if armed then
        stake=ents.Create('mcv_mine_stake'); stake.pos=Vector(100,0,6)
        mine:SetStakeEntity(stake)
    end
    now=400; mine:Think()
    assert(mine.Detonated and mine.removed and blasts==count+1 and effects==blasts)
    if armed then assert(stake.removed) end
    mine:Think(); assert(blasts==count+1)
end
-- A normal early trigger still detonates once, and clients never run the timer.
now=0; mine=mineAt(Vector(0,0,0),vector_up)
local stake=ents.Create('mcv_mine_stake'); stake.pos=Vector(100,0,6)
mine:SetStakeEntity(stake); now=3
crossing={IsPlayer=function() return true end}; mine:Think(); crossing=nil
assert(mine.Detonated and stake.removed)
local count=blasts; now=300; mine:Think(); assert(blasts==count)
now=0; mine=mineAt(Vector(0,0,0),vector_up)
SERVER=false; CLIENT=true; now=300; mine:Think()
assert(not mine.Detonated and blasts==count)
-- The displayed action follows the stage, including the stake placement animation.
state=0; assert(SWEP:GetControlHints()[1][2]=='Place mine')
state=3; assert(SWEP:GetControlHints()[1][2]=='Place stake')
state=2; variant=1; assert(SWEP:GetControlHints()[1][2]=='Place stake')
variant=0; assert(SWEP:GetControlHints()[1][2]=='Place mine')
''')
print('PASS: mine surface alignment, stake facing/parent, shared wire endpoints, obstruction/reach checks, timed/early detonation and staged hints')

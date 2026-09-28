"""Offline tests of the actual rocket flight and launch Lua; no game launch."""
from pathlib import Path
import unittest
import re
from lupa import LuaRuntime
from glua_check import to_lua

ROOT = Path(__file__).resolve().parents[1]

def runtime():
    lua = LuaRuntime()
    lua.execute('''
        MCV={}; ENT={}; SWEP={}; SERVER=true; CLIENT=false; now=0
        function AddCSLuaFile() end
        function Material() return {} end
        function CurTime() return now end
        function IsValid(x) return x~=nil and not x.removed end
        function isfunction(x) return type(x)=="function" end
        function math.Clamp(x,a,b) return math.min(math.max(x,a),b) end
        local mt={}; mt.__index=mt
        function Vector(x,y,z) return setmetatable({x=x,y=y,z=z},mt) end
        function mt.__add(a,b) return Vector(a.x+b.x,a.y+b.y,a.z+b.z) end
        function mt.__sub(a,b) return Vector(a.x-b.x,a.y-b.y,a.z-b.z) end
        function mt.__unm(a) return Vector(-a.x,-a.y,-a.z) end
        function mt.__mul(a,b) return Vector(a.x*b,a.y*b,a.z*b) end
        function mt:LengthSqr() return self.x^2+self.y^2+self.z^2 end
        function mt:Angle() return self end
        function mt:Forward() return self end
        function near(a,b) assert(math.abs(a-b)<0.00001,tostring(a).." != "..tostring(b)) end
        MOVETYPE_NONE=0; SOLID_NONE=0; SOLID_VPHYSICS=6; MASK_SHOT=1; COLLISION_GROUP_PROJECTILE=2
        phys={EnableMotion=function(s,v) s.motion=v end}
        util={TraceEntity=function(t,ent)
            assert(ent.solid==SOLID_VPHYSICS and ent.notsolid)
            assert(ent.sphere==2 and t.mins==nil and t.maxs==nil)
            trace=t; return {Hit=hit,HitSky=sky,
            HitPos=t.endpos,HitNormal=Vector(0,0,1),Entity=target} end}
        function ENT:GetPhysicsObject() return phys end
        function ENT:SetMoveType(v) self.movetype=v end
        function ENT:SetSolid(v) self.solid=v end
        function ENT:SetNotSolid(v) self.notsolid=v end
        function ENT:PhysicsInitSphere(radius) self.sphere=radius end
        function ENT:GetPos() return self.pos end
        function ENT:SetPos(v) self.pos=v end
        function ENT:SetAngles(v) self.angles=v end
        function ENT:GetOwner() return owner end
        function ENT:NextThink(t) self.nextthink=t end
        function ENT:Remove() self.removed=true end
        function make()
            local r=setmetatable({pos=Vector(0,0,0),CollisionSphere=2}, {__index=ENT})
            r:InitProjectilePhysics()
            return r
        end
        owner={}; target={}; hit=false; sky=false
    ''')
    for path in ('lua/mcv/shared/sh_rocketflight.lua', 'lua/entities/mcv_proj_base.lua'):
        lua.execute(to_lua((ROOT/path).read_text()))
    lua.execute('''
        function ENT:PreDetonate() self.Detonated=true; self.blasts=(self.blasts or 0)+1 end
        function ENT:Impact(data) self.impact=data end
    ''')
    return lua

class RocketTests(unittest.TestCase):
    def test_rpg7_and_kolos_drop_before_during_and_after_boost(self):
        for name in ('rpg7', 'kolos'):
            lua = runtime()
            source = (ROOT/f'lua/weapons/mcv_{name}.lua').read_text()
            fields = re.findall(r'^SWEP\.(?:ShootEntityForce|Rocket\w+)\s*=.*$', source, re.M)
            lua.execute(to_lua('\n'.join(fields)))
            lua.execute('''
                local gravity=SWEP.RocketGravity
                assert(gravity>0)
                now=0; r=make()
                r:StartRocketFlight(Vector(1,0,0),SWEP.ShootEntityForce,gravity,
                    SWEP.RocketBoostSpeed,SWEP.RocketBoostDelay,SWEP.RocketBoostDuration)
                for _,t in ipairs({SWEP.RocketBoostDelay/2,
                    SWEP.RocketBoostDelay+SWEP.RocketBoostDuration/2,
                    SWEP.RocketBoostDelay+SWEP.RocketBoostDuration+1}) do
                    now=t; r:Think_RocketFlight()
                    assert(r.pos.z<0 and r.angles.z<0)
                    near(r.pos.z,-0.5*gravity*t*t)
                    near(r.angles.z,-gravity*t)
                end
            ''')

    def test_curve_and_real_scale_drop(self):
        lua=runtime()
        lua.execute('''
            local d,v=MCV.RocketFlightDistance(1,100,300,0.1,0.4)
            near(d,240); near(v,300)
            d,v=MCV.RocketFlightDistance(0.1,100,300,0.1,0.4)
            near(d,10); near(v,100)
            local expected={82,84,110,114,144.8}
            local last=math.huge
            for _,speed in ipairs(expected) do
                now=0; local r=make()
                r:StartRocketFlight(Vector(1,0,0),speed/0.0254,9.80665/0.0254)
                now=100/speed; r:Think_RocketFlight()
                near(r.pos.x,100/0.0254)
                local drop=-r.pos.z*0.0254
                near(drop,0.5*9.80665*(100/speed)^2)
                assert(drop<last); last=drop
                assert(trace.mask==MASK_SHOT and trace.filter[2]==owner)
            end
            -- Absolute-time sampling gives identical trajectories at differing tick rates.
            for _,hz in ipairs({33,66,128}) do
                now=0; local r=make()
                r:StartRocketFlight(Vector(1,0,0),100,10,300,0.1,0.4)
                for i=1,hz do now=i/hz; r:Think_RocketFlight() end
                near(r.pos.x,240); near(r.pos.z,-5)
            end
        ''')

    def test_hit_sky_lifetime_and_client(self):
        lua=runtime()
        lua.execute('''
            r=make(); r:StartRocketFlight(Vector(1,0,0),22000,386)
            now=0.015; hit=true; r:Think_RocketFlight()
            assert(r.Detonated and r.blasts==1 and r.RocketFlight==nil)
            assert(r.ImpactNormal.z==1 and r.impact.HitNormal.z==-1)
            assert(r.impact.HitEntity==target and r.impact.OurOldVelocity.x==22000)
            r:Think_RocketFlight(); assert(r.blasts==1)
            r=make(); r:StartRocketFlight(Vector(1,0,0),22000,386)
            sky=true; now=0.03; r:Think_RocketFlight()
            assert(r.Detonated and r.blasts==1 and r.RocketFlight==nil)
            assert(r.ImpactPos==trace.endpos and r.ImpactNormal.z==1)
            r:Think_RocketFlight(); assert(r.blasts==1)
            sky=false; hit=false; now=0; r=make()
            r:StartRocketFlight(Vector(1,0,0),22000,386)
            now=31; r:Think_RocketFlight(); assert(r.removed)
            SERVER=false; r=make(); r:StartRocketFlight(Vector(1,0,0),100,10)
            assert(r.RocketFlight==nil)
        ''')

    def test_launch_multipliers_and_secondary_isolation(self):
        lua=runtime()
        common=(ROOT/'lua/mcv/weapon_common/shared.lua').read_text()
        lua.execute(to_lua(next(line for line in common.splitlines()
                               if line.startswith('function SWEP:GetProjectileClass()'))))
        lua.execute(to_lua((ROOT/'lua/weapons/mcv_base/sh_shoot.lua').read_text()))
        lua.execute('''
            function SWEP:GetOwner() return owner end
            function SWEP:RandomSpread() return Vector(0,0,0) end
            function SWEP:GetSpread() return 0 end
            function SWEP:StatMult(key,category) return key=="projectile_speed" and mult or 1 end
            function SWEP:GetAimAngle() return Vector(1,0,0) end
            function owner:GetShootPos() return Vector(0,0,0) end
            function ENT:SetOwner(o) end
            function ENT:Spawn() end
            function phys:IsValid() return true end
            function phys:SetVelocityInstantaneous(v) self.velocity=v end
            ents={Create=function(class) created=make(); return created end}
            w=setmetatable({ShootEntity="rocket",ShootEntityForce=100,RocketGravity=10,
                RocketBoostSpeed=300,RocketBoostDelay=0.1,RocketBoostDuration=0.4,
                RifleGrenadeEntity="grenade",RifleGrenadeForce=50}, {__index=SWEP})
            mult=2; w:LaunchProjectile(false,1)
            assert(created.RocketFlight.speed==200 and created.RocketFlight.boostSpeed==600)
            assert(created.RocketFlight.gravity==10)
            -- NPC-provided origin/direction use the same settings.
            w:LaunchProjectile(false,1,Vector(5,6,7),Vector(0,1,0))
            assert(created.RocketFlight.origin.x==5 and created.RocketFlight.direction.y==1)
            w:LaunchProjectile(true,1)
            assert(created.RocketFlight==nil and phys.velocity.x==100)
            w.RocketGravity=nil; w:LaunchProjectile(false,1)
            assert(created.RocketFlight==nil and phys.velocity.x==200)
        ''')

if __name__ == '__main__': unittest.main()

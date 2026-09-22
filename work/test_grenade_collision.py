"""Offline hull/launch checks against the actual grenade Lua and mounted MDL bounds.

Does not simulate VPhysics contacts or replace an in-game rolling check.
"""
import math
import re
import struct
import unittest
from lupa import LuaRuntime
from glua_check import to_lua
from pack_paths import ROOT, asset_path, mounted_files


def runtime():
    lua = LuaRuntime(unpack_returned_tuples=True)
    lua.execute('''
        ENT={}; SWEP={}; SERVER=true; CLIENT=false
        function AddCSLuaFile() end
        function IsValid(v) return v ~= nil end
        function CurTime() return 10 end
        local V={}; V.__index=V
        function Vector(x,y,z) return setmetatable({x=x,y=y,z=z},V) end
        function V.__add(a,b) return Vector(a.x+b.x,a.y+b.y,a.z+b.z) end
        function V.__sub(a,b) return Vector(a.x-b.x,a.y-b.y,a.z-b.z) end
        function V.__mul(a,b) return Vector(a.x*b,a.y*b,a.z*b) end
        function V:Dot(b) return self.x*b.x+self.y*b.y+self.z*b.z end
        function V:GetNormalized() return self*(1/math.sqrt(self:Dot(self))) end
        vector_up=Vector(0,0,1)
        function VectorRand() return Vector(1,2,3) end
        function Angle(p,y,r)
            local a={p=p,y=y,r=r}
            local sp,cp=math.sin(math.rad(p)),math.cos(math.rad(p))
            local sy,cy=math.sin(math.rad(y)),math.cos(math.rad(y))
            local sr,cr=math.sin(math.rad(r)),math.cos(math.rad(r))
            function a:Forward() return Vector(cp*cy,cp*sy,-sp) end
            function a:Right() return Vector(-sr*sp*cy+cr*sy,-sr*sp*sy-cr*cy,-sr*cp) end
            function a:Up() return Vector(cr*sp*cy+sr*sy,cr*sp*sy-sr*cy,cr*cp) end
            return a
        end
        baseclass={Get=function() return {InitProjectilePhysics=function(s) s.original=true end} end}
    ''')
    lua.execute(to_lua((ROOT/'lua/entities/mcv_grenade_base.lua').read_text()))
    lua.execute('''
        function ENT:GetModel() return self.model end
        function ENT:GetModelBounds() return self.mins,self.maxs end
        function ENT:PhysicsInitConvex(points) self.points=points end
        function ENT:PhysicsInitSphere(radius) self.sphere=radius end
        function ENT:EnableCustomCollisions() self.custom=true end
        function grenade(model,mins,maxs)
            return setmetatable({model=model,mins=mins,maxs=maxs},{__index=ENT})
        end
    ''')
    return lua


class GrenadeCollisionTests(unittest.TestCase):
    def test_all_mounted_throwable_hulls(self):
        lua = runtime()
        g = lua.globals()
        count = 0
        for path in mounted_files('lua/weapons', '*.lua'):
            src = path.read_text(encoding='utf-8-sig')
            if not re.search(r'SWEP.Base\s*=\s*"mcv_throwable"', src):
                continue
            model = re.search(r'SWEP.ThrowModel\s*=\s*"([^"]+)"', src)
            model = model or re.search(r'SWEP.WorldModel\s*=\s*"([^"]+)"', src)
            model = model[1]
            bounds = struct.unpack_from('<6f', asset_path(model).read_bytes(), 104)
            ent = g.grenade(model, g.Vector(*bounds[:3]), g.Vector(*bounds[3:]))
            ent.InitProjectilePhysics(ent)
            self.assertTrue(ent.custom)
            if model.endswith('/w_v40.mdl'):
                self.assertEqual(ent.sphere, 1.5)
                self.assertIsNone(ent.points)
            else:
                self.assertEqual(len(ent.points), 128)
                cx, cy = (bounds[0]+bounds[3])/2, (bounds[1]+bounds[4])/2
                for i in range(1,129):
                    point = ent.points[i]
                    self.assertAlmostEqual(math.hypot(point.x-cx,point.y-cy),ent.RollRadius)
                    self.assertEqual(point.z,bounds[2] if i%2 else bounds[5])
                self.assertGreater(bounds[5],bounds[2])
            count += 1
        self.assertGreaterEqual(count, 15)
        for name in ('c4','mine','dynamite'):
            lua.execute(to_lua((ROOT/f'lua/entities/mcv_placed_{name}.lua').read_text()))
            ent = g.grenade('placed', None, None)
            ent.InitProjectilePhysics(ent)
            self.assertTrue(ent.original)

    def test_actual_launch_roll_and_ordinary_toss(self):
        lua = runtime()
        lua.execute(to_lua((ROOT/'lua/weapons/mcv_throwable/sh_throw.lua').read_text()))
        lua.execute('''
            owner={GetShootPos=function() return Vector(0,0,30) end,
                   GetVelocity=function() return Vector(50,0,0) end}
            util={TraceLine=function() return {Hit=false} end}
            phys={SetVelocityInstantaneous=function(s,v) s.velocity=v end,
                  GetAngleVelocity=function() return Vector(0,0,0) end,
                  AddAngleVelocity=function(s,v) s.spin=v end}
            ents={Create=function()
                return {SetPos=function(s,v) s.pos=v end,SetAngles=function(s,v) s.ang=v end,
                    SetOwner=function() end,SetSkin=function() end,Activate=function() end,
                    Spawn=function(s) s.RollRadius=1.5; spawned=s end,
                    GetPhysicsObject=function() return phys end}
            end}
            function SWEP:GetOwner() return owner end
            function SWEP:GetAimAngle() return aim end
            function SWEP:TakeRound(n) consumed=(consumed or 0)+n end
            function SWEP:GetSkin() return 0 end
            function SWEP:StatMult() return 1 end
            SWEP.ThrowForceRoll=450; SWEP.ThrowForceUnderhand=600; SWEP.ThrowForceOverhand=1250
            SWEP.ThrowSpin=400; SWEP.ExplosionDamage=0; SWEP.ExplosionRadius=500
            for _,pitch in ipairs({-89,0,89}) do
                for _,yaw in ipairs({0,90,180,270}) do
                    aim=Angle(pitch,yaw,0)
                    SWEP:LaunchThrowable('roll',3)
                    assert(math.abs(spawned.ang:Up().z)<1e-10)
                    assert(math.abs(spawned.ang:Up():Dot(phys.velocity))<51)
                    assert(phys.spin.x==0 and phys.spin.y==0 and phys.spin.z>0)
                    local speed=phys.velocity:Dot(spawned.ang:Forward())
                    assert(math.abs(math.rad(phys.spin.z)*1.5-speed)<1e-8)
                    assert(phys.velocity.z<0 and phys.velocity.z>-70)
                end
            end
            for _,kind in ipairs({'low','high'}) do
                aim=Angle(35,60,0); SWEP:LaunchThrowable(kind,3)
                assert(spawned.ang==aim and phys.spin.x==400 and phys.spin.y==800)
            end
            assert(consumed==14)
        ''')


if __name__ == '__main__':
    unittest.main()

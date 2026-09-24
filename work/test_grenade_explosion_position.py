"""Regression: a grenade leaves its last contact, then detonates in mid-air."""
from pathlib import Path
from test_rocket_ballistics import runtime
from glua_check import to_lua

ROOT = Path(__file__).resolve().parents[1]
lua = runtime()
lua.execute('''
    vector_up=Vector(0,0,1)
    local timed=make()
    timed.ImpactFuse=false; timed.Delay=4
    timed.ImpactPos=Vector(100,200,500); timed.ImpactNormal=Vector(1,0,0)
    timed.pos=Vector(150,210,350)
    assert(timed:GetImpactPos()==timed.pos)
    assert(timed:GetImpactNormal()==vector_up)
    -- Rolling along the ledge and falling are both independent of the old contact.
    timed.pos=Vector(170,230,500); assert(timed:GetImpactPos()==timed.pos)
    timed.pos=Vector(190,240,200); assert(timed:GetImpactPos()==timed.pos)
    -- A delayed impact fuse also moves after its arming collision.
    timed.ImpactFuse=true; assert(timed:GetImpactPos()==timed.pos)
    -- Immediate impact explosives retain the surface offset and outward normal.
    timed.Delay=0
    near(timed:GetImpactPos().x,102); near(timed:GetImpactPos().z,500)
    assert(timed:GetImpactNormal()==timed.ImpactNormal)
    timed.Delay=4; timed.ExplodeOnImpact=true
    near(timed:GetImpactPos().x,102)
    -- Remote/planted charges use their current position and explicit orientation.
    timed.ImpactFuse=false; timed.PlacedNormal=Vector(0,1,0)
    assert(timed:GetImpactPos()==timed.pos)
    assert(timed:GetImpactNormal()==timed.PlacedNormal)
    base=ENT; ENT=setmetatable({}, {__index=base})
''')
lua.execute(to_lua((ROOT/'lua/entities/mcv_grenade_base.lua').read_text()))
lua.execute('''
    function ENT:GetAttacker() return owner end
    function ENT:GetInflictor() return self end
    function ENT:WaterLevel() return 0 end
    function ENT:EmitSound() end
    util.BlastDamage=function(inflictor,attacker,pos) damagePos=pos end
    MCV.ExplosionEffect=function(family,pos,normal) effectPos=pos; effectNormal=normal end
    local grenade=setmetatable({pos=Vector(200,300,400),
        ImpactPos=Vector(100,100,600),ImpactNormal=Vector(1,0,0)}, {__index=ENT})
    grenade:Detonate()
    assert(effectPos==grenade.pos and damagePos==grenade.pos)
    assert(effectNormal==vector_up and grenade.removed)
''')
print('PASS: rolling/falling/timed/delayed/remote explosions use current position; immediate impacts retain contact')
print('PASS: actual grenade Detonate places effect and blast damage at the same mid-air location')

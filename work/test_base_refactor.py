"""Offline checks of live stat reads and stable render-list compaction."""
from pathlib import Path
from lupa import LuaRuntime
from glua_check import to_lua

root = Path(__file__).resolve().parents[1]
lua = LuaRuntime()
lua.execute('''
MCV={ConVars={}}
function MCV.RegisterConVar(name)
    MCV.ConVars[name]={value=1,GetFloat=function(self) return self.value end}
end
''')
lua.execute(to_lua((root/'lua/mcv/shared/sh_categories.lua').read_text()))
lua.execute('''
local slug=MCV.CategorySlug
local calls=0
MCV.CategorySlug=function(...) calls=calls+1; return slug(...) end
for i=1,10000 do assert(MCV.CategoryMult('Pistols','damage')==1) end
assert(calls==0)
MCV.ConVars.mcv_cat_all_damage.value=2
MCV.ConVars.mcv_cat_pistols_damage.value=3
assert(MCV.CategoryMult('Pistols','damage')==6)
assert(MCV.CategoryMult('All','damage')==2)
assert(MCV.CategoryMult(nil,'damage')==2)
assert(MCV.CategoryMult('Unlisted','damage')==2)
MCV.RegisterConVar('mcv_cat_unlisted_damage')
MCV.ConVars.mcv_cat_unlisted_damage.value=4
assert(MCV.CategoryMult('Unlisted','damage')==8)
MCV.ConVars.mcv_cat_pistols_damage.value=-1
assert(MCV.CategoryMult('Pistols','damage')==2)
''')
source=(root/'lua/mcv/weapon_common/sh_vm.lua').read_text()
draw=source[source.index('function SWEP:ViewModelDrawn'):source.index('// the lit flame')]
# Preserve the two continue guards in executable Lua (the syntax checker doesn't).
draw=draw.replace('if !IsValid(effect) then continue end',
                  'if !IsValid(effect) then goto skip_effect end')
draw=draw.replace('if !effect.VMContext then continue end',
                  'if !effect.VMContext then goto skip_effect end')
draw=draw.replace('effects[kept] = effect', 'effects[kept] = effect\n        ::skip_effect::')
post=source[source.index('function SWEP:PostDrawViewModel'):source.index('function SWEP:GetViewModelPosition')]
lua.execute('''
SWEP={IsDepthPass=function(self,flags) return flags==1 end,
PostDrawViewModelWeapon=function() end}
function IsValid(v) return v and not v.invalid end
cam={End3D=function() end,IgnoreZ=function() end,Start3D=function() end}
render={SetBlend=function() end,UpdateRefractTexture=function() end}
drawn={}
function effect(id,valid,context)
    return {invalid=not valid,VMContext=context,
        DrawModel=function() drawn[#drawn+1]=id end,
        Render=function() drawn[#drawn+1]=id end}
end
''')
lua.execute(to_lua(draw+post))
lua.execute('''
local a,b,c=effect(1,true,true),effect(2,false,true),effect(3,true,false)
local d=effect(4,true,true)
SWEP.ActiveEffects={a,b,c,d}
local list=SWEP.ActiveEffects
SWEP:ViewModelDrawn({},1)
assert(#list==4 and #drawn==0)
SWEP:ViewModelDrawn({})
assert(SWEP.ActiveEffects==list and #list==2 and list[1]==a and list[2]==d)
assert(#drawn==2 and drawn[1]==1 and drawn[2]==4)
drawn={}; SWEP.PCFs={a,b,d}; SWEP.WorldPCFs={[d]=true}
list=SWEP.PCFs; SWEP.VMCamOpen=true
SWEP:PostDrawViewModel({})
assert(SWEP.PCFs==list and #list==2 and list[1]==a and list[2]==d)
assert(#drawn==2 and drawn[1]==1 and drawn[2]==4)
a.invalid=true; d.invalid=true; SWEP.VMCamOpen=true
SWEP:PostDrawViewModel({})
assert(#list==0)
''')
print('PASS: 10,000 stat reads without name rebuilding; live convars, late registration, render order, depth passes, in-place cleanup')

source=(root/'lua/weapons/mcv_base/sh_think.lua').read_text()
lua.execute(to_lua(source[:source.index('function SWEP:ThinkWeapon()')]))
lua.execute('''
lookups=0; writes=0; model='one'; clip=5; bipod=false
values={[0]=0,[1]=0,[2]=0,[3]=0}
function SWEP:GetModel() return model end
function SWEP:FindBodygroupByName(name)
    lookups=lookups+1
    return ({bayonet=0,grenade=1,bipod=2,belt=3})[name]
end
function SWEP:GetBodygroup(id) return values[id] end
function SWEP:SetBodygroup(id,v) values[id]=v; writes=writes+1 end
function SWEP:GetBayonet() return true end
function SWEP:GetGrenadeLauncher() return false end
function SWEP:GetBipod() return bipod end
function SWEP:Clip1() return clip end
SWEP.HasBayonet=true; SWEP.HasRifleGrenade=true
for i=1,10000 do SWEP:Think_WorldBodygroups() end
assert(lookups==4 and writes==1)
-- State is always re-read: replayed network state must not be cached.
values[0]=0; clip=0; bipod=true
SWEP:Think_WorldBodygroups()
assert(values[0]==1 and values[2]==1 and values[3]==1 and writes==4)
model='two'; SWEP:Think_WorldBodygroups(); assert(lookups==8)
''')
source=(root/'lua/mcv/weapon_common/sh_deploy.lua').read_text()
lua.execute(to_lua(source[:source.index('function SWEP:Deploy()')]))
lua.execute('''
CLIENT=false; resets=0; modelSets=0
vm={SetBodyGroups=function() resets=resets+1 end,
    GetCollisionBounds=function() return {},{} end,
    SetModel=function() modelSets=modelSets+1 end,SetCollisionBounds=function() end}
owner={IsPlayer=function() return true end,GetViewModel=function() return vm end}
function SWEP:GetOwner() return owner end
function SWEP:GetAkimbo() return dual end
SWEP.SingleViewModel='single'; SWEP.ViewModelAkimbo='dual'; SWEP.HasAkimbo=true
for i=1,10000 do SWEP:SyncViewModel() end
assert(resets==1)
dual=true; SWEP:SyncViewModel(); assert(resets==2)
dual=false; SWEP:SyncViewModel(); assert(resets==3)
SWEP:SyncViewModel(true); assert(resets==4 and modelSets==1)
vm=table.Copy and table.Copy(vm) or {SetBodyGroups=function() resets=resets+1 end}
SWEP:SyncViewModel(); assert(resets==5)
''')
source=(root/'lua/mcv/weapon_common/cl_hud.lua').read_text()
poly=source[source.index('local iconPoly'):source.index('// Icons under the ammo counter')]
lua.execute('surface={SetMaterial=function() end,SetDrawColor=function() end,DrawPoly=function(p) polygon=p end}')
lua.execute(to_lua(poly)+'\nDrawIcon=drawIconTilted')
lua.execute('''
DrawIcon({},100,100,20,{})
local first=polygon; local vertex=polygon[1]
assert(math.abs(vertex.y-(100-20/math.sqrt(2)))<0.00001)
assert(polygon[2].u==0 and polygon[3].v==1)
DrawIcon({},50,50,10,{})
assert(polygon==first and polygon[1]==vertex)
assert(math.abs(vertex.y-(50-10/math.sqrt(2)))<0.00001)
''')
print('PASS: 10,000 ticks use 4 bodygroup searches and 1 full reset; model/mode/deploy invalidation, replayed bodygroups, reused HUD geometry')

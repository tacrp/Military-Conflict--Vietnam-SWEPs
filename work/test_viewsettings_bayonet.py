"""Offline view preferences and missing bayonet animation regression checks."""
from pathlib import Path
from lupa import LuaRuntime
from glua_check import to_lua

ROOT = Path(__file__).resolve().parents[1]
lua = LuaRuntime()
lua.execute('''
MCV={}; SWEP={}; CLIENT=true; cv={}
math.Clamp=function(v,a,b) return math.max(a,math.min(b,v)) end
math.atan2=math.atan2 or function(y,x) return math.atan(y,x) end
function Lerp(t,a,b) return a+(b-a)*t end
function CreateClientConVar(name,default)
    local c={value=tonumber(default)}; cv[name]=c
    c.GetFloat=function(self) return self.value end
    c.GetBool=function(self) return self.value~=0 end
    return c
end
''')
for file in ['lua/mcv/client/cl_viewsettings.lua', 'lua/weapons/mcv_base/sh_gun.lua',
             'lua/mcv/weapon_common/sh_bash.lua']:
    lua.execute(to_lua((ROOT/file).read_text()))
lua.execute('''
w=setmetatable({ViewModelFOV=80,SightedViewModelFOV=40,IronsightFov=75}, {__index=SWEP})
local x,y,z=MCV.ViewmodelPositionOffset(0)
assert(x==0 and y==0 and z==0)
cv.mcv_viewmodel_offset_x.value=4; cv.mcv_viewmodel_offset_y.value=-6
cv.mcv_viewmodel_offset_z.value=8
x,y,z=MCV.ViewmodelPositionOffset(0.5); assert(x==2 and y==-3 and z==4)
x,y,z=MCV.ViewmodelPositionOffset(1); assert(x==0 and y==0 and z==0)
assert(MCV.ViewmodelFOV(w,0)==80 and MCV.ViewmodelFOV(w,1)==40)
cv.mcv_viewmodel_fov_offset.value=25; cv.mcv_viewmodel_sighted_fov_offset.value=-25
assert(MCV.ViewmodelFOV(w,0)==105 and MCV.ViewmodelFOV(w,1)==15)
assert(MCV.ViewmodelFOV(w,0.5)==60)
-- A world aim direction and corrected viewmodel direction must project to the
-- same screen point, including diagonal recoil, different zooms and FOV sliders.
local function screen(p,y,fov)
    p,y=math.rad(p),math.rad(y)
    local denominator=math.cos(p)*math.cos(y)*math.tan(math.rad(fov)*0.5)
    return math.cos(p)*math.sin(y)/denominator, math.sin(p)/denominator
end
for _,world in ipairs({30,60,75,90,110}) do
    for _,vm in ipairs({15,40,65,105}) do
        for _,angles in ipairs({{0,0},{-8,0},{0,6},{-12,9},{5,-7}}) do
            local p,y=MCV.ViewmodelRecoilProjection(angles[1],angles[2],vm,world)
            local x1,y1=screen(angles[1],angles[2],world)
            local x2,y2=screen(p,y,vm)
            assert(math.abs(x1-x2)<1e-9 and math.abs(y1-y2)<1e-9)
            p,y=MCV.ViewmodelRecoilProjection(angles[1],angles[2],vm,world,1.5)
            x2,y2=screen(p,y,vm)
            assert(math.abs(x1-x2)<1e-9 and math.abs(y1*1.5-y2)<1e-9)
        end
    end
end
local p,y=MCV.ViewmodelRecoilProjection(-8,6,75,75)
assert(math.abs(p+8)<1e-9 and math.abs(y-6)<1e-9)
assert(w:GetScopeWorldFov()==75 and w:GetLookMagnification()==90/75)
cv.mcv_ironsight_nozoom.value=1
assert(w:GetScopeWorldFov()==90 and w:GetLookMagnification()==1)
w.HasScope=true; function w:GetScopeFOV() return 8 end
assert(w:GetScopeWorldFov()==30 and w:GetLookMagnification()==90/8)
CLIENT=false; w.HasScope=false
assert(w:GetScopeWorldFov()==75) -- no client preference leaks to gameplay

ACT_VM_HITCENTER=1; ACT_VM_HITLEFT=2
local played, hits=0,0
function w:GetBayonet() return true end
function w:HasSequence() return false end
function w:HasAnimation() return false end
function w:PlayAnimation(act,mult,lock)
    assert(act==ACT_VM_HITCENTER and mult==1 and lock)
    played=played+1; return 0.8
end
function w:GetOwner() return {DoAnimationEvent=function() end} end
function w:SetIronsight() end
function w:BashStrike() hits=hits+1 end
w:Bash(); assert(played==1 and hits==1)
function w:PlayAnimation() return nil end
w:Bash(); assert(hits==1) -- invalid models do not deal unlocked damage
''')
lua.execute(to_lua((ROOT/'lua/weapons/mcv_base/sh_shoot.lua').read_text()))
lua.execute('''
IN_USE=1; IN_ATTACK=2; pressed=true; swings=0
function IsValid(v) return v~=nil end
local owner={IsNPC=function() return false end,KeyDown=function() return true end,
             KeyPressed=function(_,key) assert(key==IN_ATTACK); return pressed end}
function w:GetOwner() return owner end
function w:StillWaiting() return false end
function w:GetNeedCycle() return false end
function w:GetSafe() return false end
function w:IsBursting() return false end
function w:GetBipod() return false end
function w:Bash() swings=swings+1 end
w:PrimaryAttack(); pressed=false
w:PrimaryAttack(); w:PrimaryAttack(); assert(swings==1)
pressed=true; w:PrimaryAttack(); assert(swings==2)
''')
lua.execute('''
ACT_VM_ATTACH_SILENCER=211; ACT_VM_DETACH_SILENCER=212
w.HasBayonet=true; w.bayonet=false; available=false; duration=0.9; animations=0; deferred=0
function w:GetGrenadeLauncher() return false end
function w:OwnerHasBayonet() return true end
function w:GetBayonet() return self.bayonet end
function w:SetBayonet(v) self.bayonet=v end
function w:HasAnimation() return available end
function w:PlayAnimation(act)
    assert(available); animations=animations+1; return duration
end
function w:Defer(name,t)
    assert(name=="BayonetOff" and t==0.9); deferred=deferred+1
end
w:ToggleBayonet(); assert(w.bayonet)
w:ToggleBayonet(); assert(not w.bayonet and animations==0 and deferred==0)
available=true
w:ToggleBayonet(); assert(w.bayonet and animations==1)
w:ToggleBayonet(); assert(w.bayonet and deferred==1 and animations==2)
w:Deferred_BayonetOff(); assert(not w.bayonet)
w.bayonet=true; duration=nil
w:ToggleBayonet(); assert(not w.bayonet and deferred==1)
w.bayonet=true; w.HasBayonet=false
w:Think_Bayonet(); assert(not w.bayonet)
''')
print('View settings and bayonet fallback/input/toggle checks passed')

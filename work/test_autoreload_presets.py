"""Offline automatic reload guards and native preset coverage."""
from pathlib import Path
from lupa import LuaRuntime
from glua_check import to_lua
ROOT = Path(__file__).resolve().parents[1]
lua = LuaRuntime()
lua.execute('''
SWEP={}; IN_RELOAD=1; IN_USE=2
function IsValid(v) return v~=nil end
owner={IsPlayer=function() return true end,IsNPC=function() return false end,
       GetInfoNum=function() return enabled end,
       KeyPressed=function() return pressed end,KeyDown=function() return use end}
function SWEP:GetOwner() return owner end
function SWEP:GetReloading() return reloading end
function SWEP:StillWaiting() return waiting end
function SWEP:GetHolsterTime() return holster end
function SWEP:GetSafe() return safe end
function SWEP:GetNeedCycle() return cycling end
function SWEP:GetPrimedAttack() return primed end
function SWEP:IsBayonetCharging() return charging end
function SWEP:GetGrenadeLauncher() return launcher end
function SWEP:Clip1() return clip end
function SWEP:Clip2() return clip end
function SWEP:Ammo1() return ammo end
function SWEP:Ammo2() return ammo end
''')
lua.execute(to_lua((ROOT/'lua/weapons/mcv_base/sh_reload.lua').read_text()))
lua.execute('''
function SWEP:GetClip1Capacity() return capacity end
function SWEP:GetClip2Capacity() return capacity end
local reload=SWEP.Reload
function SWEP:Reload(auto) assert(auto==true); calls=calls+1 end
enabled=1; pressed=false; use=true; holster=0; clip=0; ammo=20; capacity=30; calls=0
SWEP:Think_AutoReload(); assert(calls==1)
for _,name in ipairs({"reloading","waiting","safe","cycling","primed","charging"}) do
    _G[name]=true; SWEP:Think_AutoReload(); _G[name]=false; assert(calls==1)
end
holster=1; SWEP:Think_AutoReload(); holster=0; assert(calls==1)
enabled=0; SWEP:Think_AutoReload(); enabled=1; assert(calls==1)
clip=1; SWEP:Think_AutoReload(); clip=0; assert(calls==1)
clip=-1; SWEP:Think_AutoReload(); clip=0; assert(calls==1)
ammo=0; SWEP:Think_AutoReload(); ammo=20; assert(calls==1)
capacity=0; SWEP:Think_AutoReload(); capacity=30; assert(calls==1)
launcher=true; SWEP:Think_AutoReload(); assert(calls==2)
-- Exercise real Reload routing: automatic reload bypasses key checks, never the
-- firemode shortcut, and does not restart an already active reload.
SWEP.Reload=reload; calls=0; changes=0
function SWEP:Reload2() calls=calls+1; reloading=true end
function SWEP:ChangeFiremode() changes=changes+1 end
SWEP:Reload(); assert(calls==0)
SWEP:Reload(true); assert(calls==1 and changes==0)
SWEP:Reload(true); assert(calls==1)
reloading=false; pressed=true
SWEP:Reload(); assert(changes==1 and calls==1)
''')
lua = LuaRuntime()
lua.execute('''
MCV={Categories={"All","Rifles"},CategoryStats={{key="damage",label="Damage"},{key="blast",label="Blast",projectile=true}},CATEGORY_ALL="All",CATEGORY_RIFLE_GRENADE="RG"}
function MCV.CategoryConVarName(c,s) return "cat_"..c.."_"..s end
math.Clamp=function(v,a,b) return math.max(a,math.min(b,v)) end
local cv={GetDefault=function() return "registered_default" end,GetInt=function() return 1 end,GetString=function() return "0" end}
function GetConVar() return cv end
function CreateClientConVar() return cv end
hooks={}; pages={}; hook={Add=function(e,n,fn) hooks[e]=fn end}
spawnmenu={AddToolMenuOption=function(a,b,id,label,c,d,fn) pages[id]=fn end}
weapons={GetList=function() return {} end}
function isstring(v) return type(v)=="string" end
panel={ClearControls=function(self) self.controls={} end,
 ToolPresets=function(self,g,d) self.group=g; self.defaults=d end,
 Help=function() end,ControlHelp=function() end,
 ComboBox=function(self,label,name)
    if name then assert(not self.controls[name]); self.controls[name]=true end
    return {AddChoice=function() end,SetValue=function() end}
 end,
 NumSlider=function(self,label,name) assert(not self.controls[name]); self.controls[name]=true end,
 CheckBox=function(self,label,name) assert(not self.controls[name]); self.controls[name]=true end,
 Button=function() return {} end}
''')
source = (ROOT/'lua/mcv/client/cl_settings.lua').read_text()
# The syntax checker intentionally turns GLua continue into a no-op. Preserve
# its semantics in the controls loop for this executable menu test.
start = source.index('local function controls(')
end = source.index('local buildServer', start)
controls = source[start:end].replace('continue', 'goto next_setting')
controls = controls.replace('if s.help then panel:ControlHelp(s.help) end\n    end',
                            'if s.help then panel:ControlHelp(s.help) end\n        ::next_setting::\n    end')
source = source[:start] + controls + source[end:]
lua.execute(to_lua(source))
lua.execute('''
hooks.PopulateToolMenu()
local count=0
for id,build in pairs(pages) do
    count=count+1; build(panel); assert(panel.group and panel.defaults)
    for name in pairs(panel.controls) do assert(panel.defaults[name]=="registered_default") end
    if id=="mcv_settings_server" then
        assert(panel.defaults.cat_Rifles_damage and panel.defaults.cat_Rifles_blast)
    elseif id=="mcv_settings_client" then
        assert(panel.defaults.mcv_auto_reload and panel.defaults.mcv_viewmodel_offset_z)
    end
end
assert(count==3)
''')
print('Automatic reload guards/routing and all three preset pages passed')

"""Regression: PreDrawEffects follows viewmodels and must not overwrite scope input."""
from pathlib import Path
from lupa import LuaRuntime
from glua_check import to_lua

ROOT = Path(__file__).resolve().parents[1]
lua = LuaRuntime()
lua.execute('''
SWEP={}; MCV={}; hooks={}; copies=0; framebuffer="world"
bit={bor=function(...) return 0 end}
function ScrW() return 1920 end
function ScrH() return 1080 end
function Vector() return {} end
function IsValid(v) return v~=nil end
lens={IsError=function() return false end,
    SetTexture=function(self,k,t) self.texture=t end}
function Material() return lens end
function CreateMaterial() return {} end
function GetRenderTargetEx() return {} end
render={CopyRenderTargetToTexture=function(t) copies=copies+1; t.pixels=framebuffer end,
    GetViewSetup=function() return {id=viewid} end}
hook={GetTable=function() return hooks end,
    Add=function(e,k,f) hooks[e]=hooks[e] or {}; hooks[e][k]=f end,
    Remove=function(e,k) if hooks[e] then hooks[e][k]=nil end end}
function LocalPlayer() return player end
''')
lua.execute(to_lua((ROOT/'lua/weapons/mcv_base/cl_pipscope.lua').read_text()))
lua.execute('''
function SWEP:GetSightAmountVisual() return self.aim end
function SWEP:GetIronsight() return self.aim>0 end
w=setmetatable({MilitaryConflictVietnam=true,HasScope=true,aim=1},{__index=SWEP})
player={GetActiveWeapon=function() return w end}
function contact() framebuffer=framebuffer.." + contact shadows"; return 123 end
function oldWrapper() w:CaptureScopeScreen(); return contact() end
MCV.ContactScopeHook={original=contact,wrapper=oldWrapper}
hook.Add("PreDrawEffects","ContactShadows",oldWrapper)
hook.Add("PreRender","MCV_ContactScopeCapture",function() error("obsolete wrapper") end)
''')
source=to_lua((ROOT/'lua/mcv/client/cl_rendertarget.lua').read_text())
lua.execute(source)
lua.execute('''
assert(hooks.PreDrawEffects.ContactShadows==contact)
assert(hooks.PreRender.MCV_ContactScopeCapture==nil)
hooks.PreDrawViewModels.MCV_CaptureScopeScreen()
assert(copies==1 and lens.texture.pixels=="world")
framebuffer="world + gun + scope"
assert(hooks.PreDrawEffects.ContactShadows()==123)
assert(copies==1 and lens.texture.pixels=="world")
framebuffer="next world"; hooks.PreDrawViewModels.MCV_CaptureScopeScreen()
assert(copies==2 and lens.texture.pixels=="next world")
viewid=1; hooks.PreDrawViewModels.MCV_CaptureScopeScreen(); assert(copies==2)
viewid=0; w.aim=0; hooks.PreDrawViewModels.MCV_CaptureScopeScreen(); assert(copies==2)
''')
lua.execute(source)
lua.execute('assert(hooks.PreDrawEffects.ContactShadows==contact)')
print('Scope capture order and obsolete-wrapper migration passed')

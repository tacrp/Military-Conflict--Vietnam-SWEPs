"""Offline lifecycle checks; GPU coverage is work/tests/scope_contact.txt."""
from pathlib import Path
from lupa import LuaRuntime
from glua_check import to_lua

lua=LuaRuntime()
lua.execute('''
MCV={}; hooks={}; frame=1; stack=0; composites=0; draws=0; created=0; inVM=false
STENCIL_ALWAYS=8; STENCIL_EQUAL=3; STENCIL_KEEP=1; STENCIL_REPLACE=3
function IsValid(v) return v~=nil and not v.invalid end
function isnumber(v) return type(v)=="number" end
function FrameNumber() return frame end
function ScrW() return 1920 end
function ScrH() return 1080 end
function CreateMaterial(name,t,kv) return {name=name} end
function Material(name) return {GetInt=function() return name=="glass" and 2097152 or 0 end} end
function GetRenderTargetEx(name) return {GetName=function() return name end} end
function ErrorNoHalt(e) errorLogged=e end
bit={bor=function(...) return 0 end,band=function(a,b) return a & b end}
hook={Add=function(e,k,f) hooks[e]=f end}
render={GetViewSetup=function() return {id=0} end,GetRenderTarget=function() return target end,
 PushRenderTarget=function() stack=stack+1 end,PopRenderTarget=function() stack=stack-1 end,
 CopyRenderTargetToTexture=function() end,Clear=function() assert(stack==1) end,
 SetStencilEnable=function(on) stencilOn=on end,
 SetStencilWriteMask=function() end,SetStencilTestMask=function() end,
 SetStencilReferenceValue=function() end,SetStencilCompareFunction=function(v) compare=v end,
 SetStencilPassOperation=function() end,SetStencilFailOperation=function() end,
 SetStencilZFailOperation=function() end,OverrideDepthEnable=function() end,
 OverrideColorWriteEnable=function(on,v) colourBlocked=on and not v end,
 OverrideAlphaWriteEnable=function(on,v)
    assert(not (inVM and on and v),"alpha must be filled outside the VM pass")
    alphaBlocked=on and not v
 end,
 SetWriteDepthToDestAlpha=function(v) depthAlpha=v end,
 MaterialOverrideByIndex=function(i,mat) if i then overrides[i]=mat else overrides={} end end,
 OverrideBlend=function(on) blend=on end}
overrides={}
cam={Start2D=function() end,End2D=function() end}
surface={SetMaterial=function() end,SetDrawColor=function() end,
 DrawRect=function() assert(stack==1 and stencilOn and compare==STENCIL_EQUAL and not alphaBlocked) end,
 DrawTexturedRect=function()
    if stack==0 then composites=composites+1 else assert(alphaBlocked) end
 end}
ply={GetViewModel=function() return vm end,GetActiveWeapon=function() return wep end,
 ShouldDrawLocalPlayer=function() return false end}
function LocalPlayer() return ply end
vm={GetMaterials=function() return {"gun","lens","glass"} end,
 GetModel=function() return "gun.mdl" end,GetSkin=function() return 0 end,
 GetNumBodyGroups=function() return 0 end,GetSubMaterial=function() return "" end,
 DrawModel=function() error("must not redraw the engine viewmodel") end}
function ClientsideModel(model)
 created=created+1
 return {GetModel=function() return model end,SetNoDraw=function() end,
 GetParent=function(self) return self.parent end,SetParent=function(self,v) self.parent=v end,
 SetLocalPos=function() end,SetLocalAngles=function() end,AddEffects=function() end,
 SetSkin=function() end,SetBodygroup=function() end,SetSubMaterial=function() end,
 InvalidateBoneCache=function() end,SetupBones=function() assert(inVM) end,
 DrawModel=function()
    draws=draws+1
    assert(inVM and colourBlocked and alphaBlocked)
    assert(overrides[2],"transparent cover must not occlude the lens")
    if fail then error("forced failure") end
    if stencilOn then
      assert(compare==STENCIL_ALWAYS and overrides[0] and not overrides[1] and overrides[2])
    end
 end}
end
function MCV.TrackClientModel(w,slot,p) w[slot]=p; return p end
wep={RenderingRTScope=true,RTScopeMaterialIndex=1,GetOwner=function() return ply end,
 ViewModelHidden=function() return false end,ShouldDoScope=function() return true end}
''')
root=Path(__file__).resolve().parents[1]
lua.execute(to_lua((root/'lua/mcv/client/cl_scopeoverlay.lua').read_text()))
lua.execute('''
inVM=true; MCV.CaptureScopeOverlay(wep,vm); inVM=false
assert(draws==2 and stack==0 and not next(overrides))
hooks.PreDrawHUD(); assert(composites==0)
MCV.CaptureScopeOverlayPixels(wep)
hooks.PreDrawHUD(); assert(composites==1 and not stencilOn and not alphaBlocked)
frame=2; hooks.PreDrawHUD(); assert(composites==1)
wep.OEGScope=true
function wep:DrawOEGSceneComposite() error("must save completed OEG pixels, not replay blend") end
inVM=true; MCV.CaptureScopeOverlay(wep,vm); inVM=false
MCV.CaptureScopeOverlayPixels(wep)
hooks.PreDrawHUD(); assert(composites==2 and created==1)
target={}; hooks.PreDrawHUD(); assert(composites==2); target=nil
fail=true; inVM=true; MCV.CaptureScopeOverlay(wep,vm); inVM=false
assert(errorLogged and stack==0 and not next(overrides) and not stencilOn)
hooks.PreDrawHUD(); assert(composites==2)
''')
print('Scope mask timing, proxy lifecycle, OEG and cleanup checks passed')

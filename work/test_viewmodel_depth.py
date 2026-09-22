"""Offline colour/depth projection parity and render-state lifecycle checks."""
from pathlib import Path
import unittest
from lupa import LuaRuntime
from glua_check import to_lua

ROOT = Path(__file__).resolve().parents[1]


class ViewmodelDepthTests(unittest.TestCase):
    def test_screen_depth_matches_colour_without_composites(self):
        lua = LuaRuntime()
        lua.execute('''
            SWEP={}; STUDIO_SSAODEPTHTEXTURE=2; STUDIO_SHADOWDEPTHTEXTURE=4
            bit={band=function(a,b) return a & b end}
            function Lerp(t,a,b) return a+(b-a)*t end
            function ScrW() return 1920 end
            function ScrH() return 1080 end
            function IsValid(v) return v~=nil end
            calls={}; cameras={}; stack=0; ignore=false
            function log(s) table.insert(calls,s) end
            cam={Start3D=function(...)
                stack=stack+1; table.insert(cameras,table.pack(...))
            end,End3D=function() stack=stack-1; assert(stack>=0) end,
            IgnoreZ=function(v) ignore=v end}
            render={SetBlend=function(v) assert(v==1) end,
                UpdateRefractTexture=function() log("refract") end}
        ''')
        lua.execute(to_lua((ROOT / "lua/weapons/mcv_base_core/sh_vm.lua").read_text()))
        lua.execute('''
            function SWEP:ViewModelHidden() return self.hidden end
            function SWEP:GetSightAmountVisual() return self.aim end
            function SWEP:PreDrawViewModelWeapon() log("scope/light") end
            function SWEP:UpdateLitParticle() log("lit") end
            function SWEP:PreDrawViewModelBlend() log("oeg") end
            function SWEP:PostDrawViewModelWeapon() log("composite/reset") end
            w=setmetatable({ViewModelFOV=80,SightedViewModelFOV=55,PCFs={},ActiveEffects={}}, {__index=SWEP})
            for _,near in ipairs({false,0.1}) do
                w.ViewModelZNear=near or nil
                for _,aim in ipairs({0,0.5,1}) do
                    w.aim=aim; cameras={}; calls={}
                    w:PreDrawViewModel({},nil,nil,0)
                    assert(stack==1 and ignore and w.VMCamOpen)
                    w:PostDrawViewModel({},nil,nil,0)
                    assert(stack==0 and not ignore and not w.VMCamOpen)
                    local colour=cameras[1]
                    assert(colour[3]==Lerp(aim^3,80,55))
                    assert(#calls==4)
                    calls={}
                    w:PreDrawViewModel({},nil,nil,2)
                    assert(stack==1 and ignore and w.VMCamOpen)
                    w:ViewModelDrawn({},2)
                    w:PostDrawViewModel({},nil,nil,2)
                    assert(stack==0 and not ignore and not w.VMCamOpen and #calls==0)
                    local depth=cameras[2]
                    assert(colour.n==depth.n)
                    for i=1,colour.n do assert(colour[i]==depth[i],i) end
                    w:PostDrawViewModel({},nil,nil,2) -- no unmatched camera pop
                    assert(stack==0)
                end
            end
            cameras={}; calls={}
            w:PreDrawViewModel({},nil,nil,4)
            w:PostDrawViewModel({},nil,nil,4)
            assert(#cameras==0 and #calls==0 and stack==0)
            w.hidden=true
            assert(w:PreDrawViewModel({},nil,nil,2)==true)
            w:PostDrawViewModel({},nil,nil,2)
            assert(stack==0 and #cameras==0)
        ''')


if __name__ == "__main__":
    unittest.main()

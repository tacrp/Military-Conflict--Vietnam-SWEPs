"""Exercise real scope Lua with a mutable framebuffer and competing shader captures."""
from pathlib import Path
import unittest
from lupa import LuaRuntime
from glua_check import to_lua

ROOT = Path(__file__).resolve().parents[1]


class ScopeCaptureTests(unittest.TestCase):
    def test_capture_lifetime(self):
        lua = LuaRuntime()
        lua.execute('''
            SWEP={}; frame=1; framebuffer="world"; copies=0; allocations=0
            RT_SIZE_FULL_FRAME_BUFFER=4; MATERIAL_RT_DEPTH_NONE=2; IMAGE_FORMAT_RGB888=2
            bit={bor=function(...) return 0 end}
            function ScrW() return 1920 end
            function ScrH() return 1080 end
            function FrameNumber() return frame end
            lens={IsError=function() return false end,
                  SetTexture=function(self,key,texture) self.texture=texture end}
            function Material() return lens end
            function CreateMaterial() return {} end
            function GetRenderTargetEx(...)
                allocations=allocations+1; return {}
            end
            render={CopyRenderTargetToTexture=function(target)
                copies=copies+1; target.pixels=framebuffer
            end}
        ''')
        lua.execute(to_lua((ROOT / 'lua/weapons/mcv_base/cl_pipscope.lua').read_text()))
        lua.execute('''
            function SWEP:GetSightAmountVisual() return self.aim end
            function SWEP:GetIronsight() return self.aim>0 end
            w=setmetatable({HasScope=true,aim=1},{__index=SWEP})
            -- Early shader hook takes the uncontaminated world picture.
            w:CaptureScopeScreen(true)
            assert(lens.texture.pixels=="world" and copies==1)
            framebuffer="world + gun occlusion"
            w:CaptureScopeScreen(false)
            assert(lens.texture.pixels=="world" and copies==1)
            -- Further shader copies do not alias our private texture.
            shared={}; render.CopyRenderTargetToTexture(shared)
            assert(shared.pixels~=lens.texture.pixels)
            -- Disabling gShader falls back immediately, without stale pictures.
            frame=2; framebuffer="new world"
            w:CaptureScopeScreen(false)
            assert(lens.texture.pixels=="new world" and allocations==1)
            frame=3; w.aim=0; framebuffer="hip view"
            w:CaptureScopeScreen(true)
            assert(lens.texture.pixels=="new world")
            w.aim=1; w.HasScope=false; w:CaptureScopeScreen(false)
            assert(lens.texture.pixels=="new world")
        ''')


if __name__ == '__main__':
    unittest.main()

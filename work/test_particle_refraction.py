"""Offline draw-order checks; does not emulate the GPU or reproduce the reported artifact."""
from pathlib import Path
import unittest

from lupa import LuaRuntime
from glua_check import to_lua

ROOT = Path(__file__).resolve().parents[1]


class ParticleRefractionTests(unittest.TestCase):
    def test_each_colour_batch_refreshes_before_particles(self):
        lua = LuaRuntime()
        lua.execute('''
            SWEP={}; calls={}; context="vm"
            function log(s) table.insert(calls,s) end
            function IsValid(v) return v and not v.invalid end
            cam={IgnoreZ=function() end, End3D=function() context="outside" end,
                 Start3D=function() context="world" end}
            render={SetBlend=function() end,
                    UpdateRefractTexture=function() log("copy:"..context) end}
            function particle(name)
                return {Render=function() log("draw:"..name..":"..context) end}
            end
        ''')
        lua.execute(to_lua((ROOT / "lua/mcv/weapon_common/sh_vm.lua").read_text()))
        lua.execute('''
            function SWEP:IsDepthPass(flags) return flags==1 end
            function SWEP:PostDrawViewModelWeapon() end
            w=setmetatable({}, {__index=SWEP})
            a=particle("a"); b=particle("b"); jet=particle("jet"); dead=particle("dead"); dead.invalid=true
            function draw(list,flags,open)
                calls={}; context="vm"; w.PCFs=list; w.VMCamOpen=open
                w.WorldPCFs={[jet]=true}
                w:PostDrawViewModel({},nil,nil,flags)
                return table.concat(calls,",")
            end
            local expected="copy:vm,draw:a:vm,draw:b:vm,copy:world,draw:jet:world"
            assert(draw({a,dead,jet,b},0,true)==expected)
            assert(#w.PCFs==3)
            -- A second view in the same frame needs its own source, not a global frame guard.
            assert(draw({a,jet,b},0,true)==expected)
            assert(draw({jet},0,true)=="copy:world,draw:jet:world")
            assert(draw({a,b},0,true)=="copy:vm,draw:a:vm,draw:b:vm")
            assert(draw({},0,true)=="")
            assert(draw({dead},0,true)=="")
            assert(draw({a,jet},1,true)=="")
            assert(draw({a,jet},0,false)=="")

            -- The Contact Shadows mask must survive both refraction batches.
            shaderlib={}; enabled=true; allocations=0
            function GetConVar() return {GetBool=function() return enabled end} end
            local function texture(name)
                return {name=name, Width=function() return 1024 end,
                        Height=function() return 1024 end}
            end
            source=texture("source"); source.value="weapon mask"
            function GetRenderTargetEx()
                allocations=allocations+1
                return texture("backup")
            end
            render.GetRefractTexture=function() return source end
            render.CopyTexture=function(a,b)
                b.value=a.value
                log(a==source and "save" or "restore")
            end
            render.UpdateRefractTexture=function()
                source.value="fresh scene"
                log("copy:"..context)
            end
            local renderA=a.Render
            a.Render=function()
                assert(source.value=="fresh scene")
                renderA()
            end
            assert(draw({a,jet,b},0,true)=="save,"..expected..",restore")
            assert(source.value=="weapon mask")
            assert(draw({jet},0,true)=="save,copy:world,draw:jet:world,restore")
            assert(draw({a},0,true)=="save,copy:vm,draw:a:vm,restore")
            assert(allocations==1)
            assert(draw({},0,true)=="")
            assert(draw({a},1,true)=="")
            assert(draw({a},0,false)=="")
            enabled=false
            assert(draw({a},0,true)=="copy:vm,draw:a:vm")
        ''')


if __name__ == "__main__":
    unittest.main()

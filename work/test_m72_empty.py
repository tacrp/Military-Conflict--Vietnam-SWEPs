"""Exercise the M72's empty-inventory policy without running GMod."""
from pathlib import Path
from lupa import LuaRuntime
from glua_check import to_lua

root = Path(__file__).resolve().parents[1]
lua = LuaRuntime()
lua.execute('''
    SWEP={Primary={}}; MCV={FIREMODE_SEMI=1}; CLIENT=false
    function AddCSLuaFile() end
    function Vector(...) return {} end
    function Angle(...) return {} end
    baseclass={Get=function(name)
        assert(name=="mcv_base")
        return {ThinkWeapon=function(self) self.baseRan=true end}
    end}
''')
lua.execute(to_lua((root.parent/'mcv-2/lua/weapons/mcv_m72.lua').read_text()))
lua.execute('''
    function SWEP:GetInfiniteAmmo() return self.infinite end
    function SWEP:Clip1() return self.clip end
    function SWEP:Ammo1() return self.reserve end
    function SWEP:GetReloading() return self.reloading end
    function SWEP:StillWaiting() return self.waiting end
    function SWEP:Remove() self.removed=true end
    for _,client in ipairs({false,true}) do
        CLIENT=client
        for mask=0,31 do
            local w=setmetatable({clip=mask&1,reserve=(mask>>1)&1,
                infinite=(mask&4)~=0,reloading=(mask&8)~=0,waiting=(mask&16)~=0},
                {__index=SWEP})
            w:ThinkWeapon()
            assert(w.baseRan)
            assert((w.removed or false)==(not client and mask==0))
        end
    end
''')
print('PASS: 64 empty/loaded/reserve/infinite/reloading/recovery/client combinations')

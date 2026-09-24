"""Exercise real initialization with GMod-style merged firemode tables."""
from pathlib import Path
from lupa import LuaRuntime
from glua_check import to_lua

root = Path(__file__).resolve().parents[1]
source = (root/'lua/weapons/mcv_base_core/sh_deploy.lua').read_text()
lua = LuaRuntime()
lua.execute('''
SWEP={}; SERVER=false
function isnumber(v) return type(v)=='number' end
function SWEP:GetFiremode() return self.mode end
function SWEP:SetFiremode(v) self.mode=v end
function SWEP:SetHoldType() end
function SWEP:GetPrecacheParticles() return {} end
''')
lua.execute(to_lua(source[source.index('function SWEP:Initialize()'):]))
lua.execute('''
for _,input in ipairs({{1,1,BaseClass={0,1}},{0,1,BaseClass={}},{11,12,BaseClass={}}}) do
    local w=setmetatable({Firemodes=input,mode=2},{__index=SWEP})
    w:Initialize()
    assert(w.Firemodes~=input and w.Firemodes.BaseClass==nil and input[2]~=nil)
    assert(#w.Firemodes==(input[1]==input[2] and 1 or 2))
    assert(w.Firemodes[w.mode]==input[2])
end
''')
print('PASS: duplicate semi modes removed, source tables intact, distinct modes/order/selection preserved')

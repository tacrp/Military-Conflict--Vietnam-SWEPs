"""Compare HUD draw output with checkpoint; check worldmodel tuning invalidation."""
from pathlib import Path
import subprocess
from lupa import LuaRuntime
from glua_check import to_lua
root=Path(__file__).resolve().parents[1]
old=subprocess.check_output(['git','show','e9b2e0895:lua/weapons/mcv_base_core/cl_hud.lua'],cwd=root).decode()
new=(root/'lua/mcv/weapon_common/cl_hud.lua').read_text()

def render(source, dual, bayonet):
    lua=LuaRuntime()
    lua.execute('''
    SWEP={}; HUD={Color={r=255,g=255,b=255,a=150}}; calls=0; drawn={}
    function Color(r,g,b,a) return {r=r,g=g,b=b,a=a} end
    function ScreenScale(v) return v end
    function IsValid(v) return v~=nil end
    function SWEP:GetHUDIcon() return 'pistol' end
    function SWEP:GetHasSecond() return true end
    function SWEP:GetAkimbo() return true end
    function SWEP:GetBayonet() return false end
    owner={GetWeapons=function() calls=calls+1; return {{IsBayonet=true,GetHUDIcon=function() return 'bayonet' end}} end}
    function SWEP:GetOwner() return owner end
    function SWEP:OwnerHasBayonet()
        for _,v in ipairs(owner:GetWeapons()) do if v.IsBayonet then return true end end
    end
    surface={SetMaterial=function(m) material=m end,SetDrawColor=function(c) alpha=c.a end,
        DrawPoly=function(p)
            local parts={material,string.format('%.6f',alpha)}
            for _,v in ipairs(p) do parts[#parts+1]=string.format('%.6f,%.6f,%d,%d',v.x,v.y,v.u,v.v) end
            drawn[#drawn+1]=table.concat(parts,':')
        end}
    ''')
    # Keep the fixture's icon accessor, while executing actual geometry/availability.
    segment=source[source.index('local function withAlpha'):source.index('// A count that changes')]
    a,b=segment.index('function SWEP:GetHUDIcon()'),segment.index('// A weapon icon mirrored')
    segment=segment[:a]+segment[b:]
    lua.execute(to_lua(segment))
    lua.globals().SWEP.HasAkimbo=dual
    lua.globals().SWEP.HasBayonet=bayonet
    lua.execute('SWEP:DrawHUDAvailability(0.7,300,600)')
    return list(lua.globals().drawn.values()),lua.globals().calls

for dual in (False,True):
    for bayonet in (False,True):
        a,oldcalls=render(old,dual,bayonet)
        b,newcalls=render(new,dual,bayonet)
        assert a==b,(dual,bayonet,a,b)
        assert newcalls==(1 if bayonet else 0)
        if bayonet: assert oldcalls==2

source=(root/'lua/mcv/weapon_common/cl_worldmodel.lua').read_text()
triple=source[source.index('local tuningValues'):source.index('function SWEP:GetWorldModelBoneAdjust')]
mirror=source[source.index('local mirrorAxis'):source.index('function SWEP:GetWorldModelTransformLeft')]
lua=LuaRuntime()
lua.execute('''
allocations=0; matrices=0; text='1 2 3'; axis='z'
cv={GetString=function() return text end}; cv_mirror={GetString=function() return axis end}
function Vector(x,y,z) allocations=allocations+1; return {x=x,y=y,z=z} end
function Matrix() matrices=matrices+1; return {Scale=function(self,v) self.scale=v end} end
''')
lua.execute(to_lua(triple+mirror)+'\nReadTriple=readTriple; HandMirror=handMirror')
lua.execute('''
for i=1,10000 do
    assert(ReadTriple(cv,Vector).x==1)
    assert(HandMirror().scale.z==-1)
end
assert(allocations==2 and matrices==1)
text='4 5 6'; assert(ReadTriple(cv,Vector).z==6)
text=''; assert(ReadTriple(cv,Vector)==nil)
text='invalid'; assert(ReadTriple(cv,Vector)==nil)
axis='x'; assert(HandMirror().scale.x==-1 and matrices==2)
''')
print('PASS: identical HUD geometry/alpha/order for four capability combinations; one inventory scan instead of two; 10,000 cached tuning/mirror reads and live changes')

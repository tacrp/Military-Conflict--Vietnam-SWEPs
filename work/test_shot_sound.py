"""Exercise the real shot-layer dispatcher without launching GMod."""
from pathlib import Path
from lupa import LuaRuntime
from glua_check import to_lua

source=(Path(__file__).resolve().parents[1]/'lua/weapons/mcv_base/sh_shoot.lua').read_text()
source=source[source.index('local distant_of = {}'):source.index('function SWEP:GetFiremodeRate')]
lua=LuaRuntime()
lua.execute('''
    SWEP={}; MCV={CHAN_SHOT=1,CHAN_SHOT_DISTANT=136}; first=true; calls={}; active={}
    function IsFirstTimePredicted() return first end
    function istable(x) return type(x)=='table' end
    function IsValid(x) return x~=nil end
    math.Clamp=function(x,a,b) return math.min(b,math.max(a,x)) end
    math.Round=function(x) return math.floor(x+0.5) end
    math.Rand=function(a,b) return (a+b)/2 end
    util={SharedRandom=function(key,a,b) return (a+b)/2 end}
    local scripts={near={sound={'near1.wav','near2.wav'},channel=1,level=110,pitch={98,102},volume=0.8},
                   nearDistant={sound='far.wav',channel=1,level=149,pitch=100,volume=1}}
    sound={GetProperties=function(name) return scripts[name] end}
    function SWEP:GetOwner() return {IsPlayer=function() return true end} end
    function SWEP:EmitSound(name,level,pitch,volume,channel)
        calls[#calls+1]={name,level,pitch,volume,channel}
        active[self]=active[self] or {}
        active[self][channel]=name
    end
''')
lua.execute(to_lua(source))
lua.execute('''
    for i=1,1000 do SWEP:EmitShotSound('near') end
    assert(#calls==2000)
    for i=1,2000,2 do
        assert(calls[i][1]=='near2.wav' and calls[i][2]==110 and calls[i][4]==0.8)
        assert(calls[i+1][1]=='far.wav' and calls[i+1][2]==149)
        assert(calls[i][5]==MCV.CHAN_SHOT and calls[i+1][5]==MCV.CHAN_SHOT_DISTANT)
    end
    local count=0; for _ in pairs(active[SWEP]) do count=count+1 end
    assert(count==2 and active[SWEP][1]=='near2.wav' and active[SWEP][136]=='far.wav')
    first=false; SWEP:EmitShotSound('near'); assert(#calls==2000)
    first=true; SWEP:EmitShotSound(''); assert(#calls==2000)
    SWEP:EmitShotSound('custom.wav'); assert(#calls==2001 and calls[2001][5]==MCV.CHAN_SHOT)
    other=setmetatable({}, {__index=SWEP}); other:EmitShotSound('near')
    assert(active[SWEP][1]=='custom.wav' and active[other][1]=='near2.wav')
''')
print('PASS: 1000-shot channel reuse, separate layers/weapons, preserved mix, replay suppression and raw-file fallback.')

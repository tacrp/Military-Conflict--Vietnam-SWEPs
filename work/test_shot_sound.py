"""Exercise the real shot-layer dispatcher without launching GMod."""
from pathlib import Path
import wave

import numpy as np
from lupa import LuaRuntime
from glua_check import to_lua
from pack_paths import asset_path
from audit_shot_audio import scripts

root=Path(__file__).resolve().parents[1]
source=(root/'lua/weapons/mcv_base/sh_shoot.lua').read_text()
source=source[source.index('local distant_of = {}'):source.index('function SWEP:GetFiremodeRate')]
common=(root/'lua/mcv/shared/sh_common.lua').read_text()
channels=common[common.index('MCV.SHOT_SOUND_SLOTS ='):common.index('MCV.FiremodeAmmo =')]
lua=LuaRuntime()
lua.execute('''
    SWEP={}; MCV={}; CHAN_USER_BASE=136; first=true; calls={}; active={}
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
    owners=0
    function SWEP:GetOwner() owners=owners+1; return {IsPlayer=function() return true end} end
    function SWEP:EmitSound(name,level,pitch,volume,channel)
        calls[#calls+1]={name,level,pitch,volume,channel}
        active[self]=active[self] or {}
        active[self][channel]=name
    end
''')
lua.execute(to_lua(channels))
lua.execute(to_lua(source))
lua.execute('''
    w=setmetatable({}, {__index=SWEP})
    for i=1,1000 do w:EmitShotSound('near') end
    assert(#calls==2000)
    assert(owners==1000) -- ranged sample/pitch share one owner read; scalar far layer reads none
    for i=1,2000,2 do
        assert(calls[i][1]=='near2.wav' and calls[i][2]==110 and calls[i][4]==0.8)
        assert(calls[i+1][1]=='far.wav' and calls[i+1][2]==149)
        assert(calls[i][5]>=MCV.CHAN_SHOT and calls[i][5]<MCV.CHAN_SHOT_DISTANT)
        assert(calls[i+1][5]>=MCV.CHAN_SHOT_DISTANT)
        assert(calls[i+1][5]<MCV.CHAN_SHOT_DISTANT+MCV.SHOT_SOUND_SLOTS)
        if i>1 then assert(calls[i][5]~=calls[i-2][5]) end -- adjacent reports survive
    end
    local count=0; for _ in pairs(active[w]) do count=count+1 end
    assert(count==8 and count==MCV.SHOT_SOUND_SLOTS*2)
    local slot=w.MCVShotSoundSlot
    first=false; w:EmitShotSound('near'); assert(#calls==2000 and w.MCVShotSoundSlot==slot)
    first=true; w:EmitShotSound(''); assert(#calls==2000 and w.MCVShotSoundSlot==slot)
    w:EmitShotSound('custom.wav'); assert(#calls==2001 and calls[2001][5]==MCV.CHAN_SHOT)
    other=setmetatable({}, {__index=SWEP}); other:EmitShotSound('near')
    assert(active[w][MCV.CHAN_SHOT]=='custom.wav' and active[other][MCV.CHAN_SHOT]=='near2.wav')
    -- Releasing the trigger, changing firemode, or switching the clock backwards
    -- cannot reset the cosmetic cursor and overwrite a just-started report.
    local prior=calls[#calls-1][5]
    other.GetBurstCount=function() return 0 end
    other:EmitShotSound('near'); assert(calls[#calls-1][5]~=prior)
    -- NPCs use the same bounded pool without any predicted BurstCount dependency.
    npc=setmetatable({GetOwner=function() return {IsPlayer=function() return false end} end}, {__index=SWEP})
    for i=1,1000 do npc:EmitShotSound('near') end
    count=0; for _ in pairs(active[npc]) do count=count+1 end; assert(count==8)
    -- Return real selected channels for the PCM replacement simulation below.
    function burstChannels(shots)
        local gun=setmetatable({}, {__index=SWEP}); local result={}
        for i=1,shots do
            gun:EmitShotSound('near'); result[i]=calls[#calls-1][5]
        end
        return result
    end
''')
print('PASS: 1000-shot bounded overlap, isolated layers/weapons/NPCs, preserved mix, replay/tap handling and raw-file fallback.')

# Measure real attack energy retained before each channel replacement, instead of
# assuming that every WAV starts with the gunshot. RPK is the reported good control.
bank=scripts()
for name,rpm in [('MG43',800),('PK',750),('M60',600),('RPK',600)]:
    retained_before=[]
    retained_after=[]
    for sample in bank[f'MCV_Weapon_{name}.Single']:
        with wave.open(str(asset_path('sound/'+sample))) as wav:
            rate=wav.getframerate()
            pcm=np.frombuffer(wav.readframes(wav.getnframes()),dtype='<i2').reshape(-1,wav.getnchannels()).astype(float)/32768
        energy=np.mean(pcm**2,axis=1)
        peak=np.max(np.abs(pcm),axis=1)
        attack=int(np.flatnonzero(peak>0.5)[0])
        end=min(len(pcm),attack+int(rate*.08)) # the report's first 80 ms, excluding mechanism lead-in
        total=float(energy[attack:end].sum())
        assert total>0
        for shots in (2,1000):
            selected=list(lua.globals().burstChannels(shots).values())
            for i,channel in enumerate(selected):
                replacement=next((j-i for j in range(i+1,min(i+9,shots)) if selected[j]==channel), None)
                stop=len(pcm) if replacement is None else int(rate*60/rpm*replacement)
                after=float(energy[attack:min(end,stop)].sum())/total
                assert after>0.999, (sample,shots,i,'attack truncated',after)
                if i==0 and shots==1000:
                    before=float(energy[attack:min(end,int(rate*60/rpm))].sum())/total
                    retained_before.append(before)
                    retained_after.append(after)
    old=sum(retained_before)/len(retained_before)
    new=sum(retained_after)/len(retained_after)
    if name in ('MG43','PK'):
        assert old<0.01, (name,'fixture no longer reproduces missing report',old)
    elif name=='M60':
        assert old<0.8, (name,'fixture no longer reproduces truncated body',old)
    else:
        assert old>0.99, (name,'control should already retain the attack',old)
    print(f'PASS: {name} report energy retained in repeated fire: {old:.1%} -> {new:.1%}; two-shot and 1000-shot checks')

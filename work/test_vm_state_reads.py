"""Compare every pose/bodygroup write against the checkpoint across reload states."""
from pathlib import Path
import subprocess
from lupa import LuaRuntime
from glua_check import to_lua
root=Path(__file__).resolve().parents[1]
old=subprocess.check_output(['git','show','e9b2e0895:lua/weapons/mcv_base/sh_vm.lua'],cwd=root).decode()
new=(root/'lua/weapons/mcv_base/sh_vm.lua').read_text()
lua=LuaRuntime()
lua.execute('''
function math.Clamp(v,a,b) return math.max(a,math.min(b,v)) end
function isnumber(v) return type(v)=='number' end
function CurTime() return 10 end
MCV={FIREMODE_DA=2,FIREMODE_FAN=3}
ACT_VM_RELOAD_INSERT=1; ACT_VM_RELOAD=2
''')
for name,source in [('before',old),('after',new)]:
    lua.execute('SWEP={}')
    lua.execute(to_lua(source[:source.index('// Keeps the muzzle flash light')]))
    lua.execute(name+'=SWEP')
lua.execute('''
local defaults={Primary={ClipSize=10,Chamber=1},MagInTime=0.7,MagOutTime=0.3,
    MagInTimeEmpty=0.9,MagOutTimeEmpty=0.2,ShotgunReloadRounds=3,ReloadInsertTime=0.2,
    CycleClipPoseTime=0.3,InsertClipPoseTime=0.4,CycleAmmoPose2=true,
    BulletBodygroups={[1]={1,1},[4]={2,1},[9]={3,1},BaseClass={}},
    BeltBodygroups={4,5,BaseClass={}},BayonetBodygroup=6,GrenadeLauncherBodygroup=7,
    GrenadeBodygroup=8,MagInTimeGrenade=0.5,RevolverFiremodePose=true,AkimboRecoilTime=0.1,
    AkimboMagInTimes={[1]={0.4,0.9},[2]={0.5,1.2}}}
local function run(base,c)
    local reads={clip=0,reloading=0,akimbo=0}
    local w=setmetatable({}, {__index=function(_,k) return base[k] or defaults[k] end})
    w.ShotgunReload=c.shotgun; w.ShotgunAltReload=c.shotgun
    w.MagInClip=c.magclip; w.InvertAnimationHammer=c.invert
    function w:Clip1() reads.clip=reads.clip+1; return c.clip end
    function w:GetReloading() reads.reloading=reads.reloading+1; return c.reload end
    function w:GetAkimbo() reads.akimbo=reads.akimbo+1; return c.dual end
    function w:Ammo1() return 7 end
    function w:GetViewModelTime() return 10.01 end
    function w:GetAnimLockTime() return 12-c.progress end
    function w:DeferPending() return c.pending end
    function w:GetInfiniteAmmo() return c.infinite end
    function w:GetClip1Capacity() return c.dual and 22 or 11 end
    function w:GetNeedCycle() return c.cycle end
    function w:GetActionStart() return 9.8 end
    function w:GetEmptyReload() return c.clip==0 and c.reload end
    function w:HasPoseRecoil() return true end
    function w:GetLastShotTimeR() return 9.97 end
    function w:GetLastShotTimeL() return 9.94 end
    function w:GetBayonet() return true end
    function w:GetGrenadeLauncher() return c.launcher end
    function w:Clip2() return c.clip>0 and 1 or 0 end
    function w:GetFiremodeValue() return c.clip==0 and 2 or 3 end
    local writes={}
    local vm={SequenceDuration=function() return 2 end,GetSequence=function() return 1 end,
        GetSequenceActivity=function() return c.shotgun and 1 or 2 end,
        SetPoseParameter=function(_,k,v) writes[#writes+1]='p'..k..':'..v end,
        SetBodygroup=function(_,k,v) writes[#writes+1]='b'..k..':'..v end}
    w:DoBodygroupsWeapon(vm,c.visual,0.7,200)
    return table.concat(writes,';'),reads
end
local cases,totalBefore,totalAfter=0,0,0
for bits=0,255 do
    local function flag(n) return math.floor(bits/2^n)%2==1 end
    for _,clip in ipairs({0,1,7}) do
        for _,progress in ipairs({0.1,0.5,1.5}) do
            local c={shotgun=flag(0),reload=flag(1),dual=flag(2),magclip=flag(3),
                pending=flag(4),infinite=flag(5),launcher=flag(6),cycle=flag(7),
                invert=flag(7),visual=flag(6),clip=clip,progress=progress}
            local a,oldReads=run(before,c)
            local b,newReads=run(after,c)
            assert(a==b,'pose mismatch in case '..bits..' clip '..clip..' progress '..progress)
            assert(newReads.clip==1 and newReads.reloading==1 and newReads.akimbo==1)
            for _,v in pairs(oldReads) do totalBefore=totalBefore+v end
            for _,v in pairs(newReads) do totalAfter=totalAfter+v end
            cases=cases+1
        end
    end
end
print('PASS: '..cases..' identical pose/bodygroup write sequences; repeated state reads '..totalBefore..' -> '..totalAfter)
''')

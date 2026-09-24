"""Exercise the real AttackEffects recoil calculation without launching GMod."""
from pathlib import Path
from lupa import LuaRuntime
from glua_check import to_lua

root = Path(__file__).resolve().parents[1]
lua = LuaRuntime()
lua.execute('''
SWEP={}; MCV={}; CLIENT=false; SERVER=true
function CurTime() return 10 end
function IsFirstTimePredicted() return false end
function Lerp(t,a,b) return a+(b-a)*t end
function Angle(p,y,r) return {p=p,y=y,r=r} end
util={SharedRandom=function() return 1 end}
''')
common = (root/'lua/mcv/shared/sh_common.lua').read_text()
lua.execute(to_lua(common[:common.index('MCV.CancelMultipliers')]))
lua.execute(to_lua((root/'lua/weapons/mcv_base/sh_shoot.lua').read_text()))
lua.execute('''
MCV.RealisticShooting=function() return false end
owner={ViewPunch=function(self,a) self.punch=a end,DoAnimationEvent=function() end}
function SWEP:GetOwner() return owner end
function SWEP:GetFiremodeValue() return self.mode end
function SWEP:GetAkimbo() return self.dual end
function SWEP:GetBipod() return self.bipod end
function SWEP:StatMult() return self.mult end
function SWEP:SetLastRecoilTime() end
function SWEP:GetSightAmount() return self.sights end
function SWEP:GetBurstCount() return self.burst end
function SWEP:SetBurstCount(n) self.burst=n end
function SWEP:GetShootGesture() return 0 end
function SWEP:Clip1() return self.clip end
function SWEP:TakePrimaryAmmo(n) self.clip=self.clip-n end
function SWEP:EmitShotSound() end
function SWEP:QueueRecoilImpulse() end
function near(a,b) assert(math.abs(a-b)<0.000001, tostring(a).." != "..tostring(b)) end
w=setmetatable({ViewSlideRecoilUp=2,ViewSlideRecoilRight=1,
    ViewSlideRecoilIronsightUp=1,ViewSlideRecoilIronsightRight=0.5,
    Primary={ClipSize=30},VolleyCount=3,RecoilPushbackValue=1}, {__index=SWEP})
for _,mode in ipairs({MCV.FIREMODE_AUTO,MCV.FIREMODE_BURST,MCV.FIREMODE_VOLLEY}) do
    w.mode=mode
    for _,sights in ipairs({0,0.5,1}) do
        w.sights=sights
        for mask=0,3 do
            w.dual=(mask%2)==1; w.bipod=mask>=2; w.mult=1.7
            local scale=1.7*(w.dual and 1.25 or 1)*(w.bipod and 0.25 or 1)
                *(mode==MCV.FIREMODE_VOLLEY and 3 or 1)
            for _,increment in ipairs({0,0.2}) do
                w.ProgressiveRecoilUp=increment; w.ProgressiveRecoilRight=increment/2
                for _,count in ipairs({0,1,2,10,0}) do
                    for replay=1,2 do
                        -- Engine rollback restores these fields before replay.
                        w.burst=count; w.clip=30
                        w:AttackEffects()
                        near(owner.punch.p,-(Lerp(sights,2,1)+count*increment)*scale)
                        near(owner.punch.y,(Lerp(sights,1,0.5)+count*increment/2)*scale)
                        assert(w.burst==count+1)
                    end
                end
            end
        end
    end
end
''')
print('PASS: zero defaults, linear growth, first shot/reset, hip/ADS, recoil multipliers and replay')

"""Check actual pickup Lua without the engine or an in-game session."""
from pathlib import Path
from lupa import LuaRuntime
from glua_check import to_lua

root=Path(__file__).resolve().parents[1]
lua=LuaRuntime()
lua.execute('''
    SWEP={}; SERVER=true; CLIENT=false; MCV={}
    WEAPON_PROFICIENCY_POOR=0; WEAPON_PROFICIENCY_AVERAGE=1
    WEAPON_PROFICIENCY_GOOD=2; WEAPON_PROFICIENCY_VERY_GOOD=3; WEAPON_PROFICIENCY_PERFECT=4
    function IsValid(v) return v~=nil end
    hooks={}; hook={Add=function(name,id,fn) hooks[name]=fn end}
''')
for path in ('lua/weapons/mcv_base/sh_reload.lua','lua/weapons/mcv_base/sh_npc.lua',
             'lua/mcv/server/sv_second_weapon.lua'):
    lua.execute(to_lua((root/path).read_text()))
lua.execute('''
    function SWEP:GetAkimbo() return self.dual end
    function SWEP:Clip1() return self.clip1 end
    function SWEP:Clip2() return self.clip2 end
    function SWEP:SetClip1(n) self.clip1=n end
    function SWEP:SetClip2(n) self.clip2=n end
    player={IsPlayer=function() return true end,HasWeapon=function() return true end}
    npc={IsPlayer=function() return false end,IsNPC=function() return true end,
        SelectWeightedSequence=function() return 1 end}
    ACT_RANGE_ATTACK1=1
    function math.Clamp(v,lo,hi) return math.min(math.max(v,lo),hi) end
    function SWEP:GetOwner() return self.owner end
    function SWEP:CancelDeferred() end
    function SWEP:SetReloading() end
    function SWEP:SetNeedCycle() end
    function SWEP:SetNeedTriggerPress() end
    function SWEP:SetPrimedAttack() end
    function SWEP:SetGrenadeLauncher() end
    function SWEP:SetAkimbo(v) self.dual=v end
    function SWEP:GetFiremode() return 1 end
    function SWEP:SetFiremode() end
    function SWEP:SetHoldType() end
    function SWEP:Think_WorldBodygroups() end
    SWEP.NPCUsable=true; SWEP.Firemodes={1}; SWEP.ActivityTranslateAI={[1]=1}
    function make(size,chamber,dual,clip,secondary)
        return setmetatable({Primary={ClipSize=size,Chamber=chamber},Secondary={ClipSize=secondary},
            dual=dual,clip1=clip,clip2=999,MilitaryConflictVietnam=true},{__index=SWEP})
    end
    local w=make(30,1,false,999,1); w:Equip(player)
    assert(w.clip1==999 and w.clip2==999) -- fresh-player starting reserves survive
    w:OnDrop(); assert(w.clip1==999)
    w=make(30,1,false,7,0); w:Equip(player); assert(w.clip1==7)
    w=make(30,1,false,999,1)
    hooks.PlayerCanPickupWeapon(player,w) -- before duplicate pickup consumes the entity
    assert(w.clip1==999 and w.clip2==999) -- fresh duplicate spawn retains its ammo
    w.owner=npc; w:Equip(npc)
    assert(w.clip1==31 and w.clip2==1 and w.MCVWasNPCWeapon)
    w.clip1=500; w.clip2=500; w:OnDrop() -- NPC reload excess is removed before pickup
    assert(w.clip1==31 and w.clip2==1 and not w.MCVWasNPCWeapon)
    hooks.PlayerCanPickupWeapon(player,w); w:Equip(player)
    assert(w.clip1==31 and w.clip2==1)
    w=make(30,1,false,7,0); w.owner=npc; w:Equip(npc); assert(w.clip1==7)
    w=make(7,1,true,999,0); w.owner=npc; w:Equip(npc); assert(w.clip1==8 and not w.dual)
    w=make(1,0,false,999,0); w.owner=npc; w:Equip(npc); assert(w.clip1==1)
    w=make(-1,0,false,-1,-1); w.owner=npc; w:Equip(npc); assert(w.clip1==-1 and w.clip2==999)
''')
print('Ammo checks passed: player reserves/duplicates preserved, NPC equip/drop capped, partial/chamber/dual/clipless cases.')

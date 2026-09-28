"""Offline info-row, AP damage routing and country metadata checks."""
import re
import unittest
from pathlib import Path
from lupa import LuaRuntime
from glua_check import to_lua
from weapon_countries import ALIASES, CORRECTIONS
from pack_paths import PART2

ROOT = Path(__file__).resolve().parents[1]


class WeaponInfoTests(unittest.TestCase):
    def test_rows_and_tags(self):
        lua = LuaRuntime()
        lua.execute('''
            SWEP={}; MCV={CATEGORY_RIFLE_GRENADE="grenade"}
            function SWEP:GetProjectileClass() return self.ShootEntity end
            function SWEP:GetBulletCount() return self.Num or 1 end
            math.Round=function(v,n) local k=10^(n or 0) return math.floor(v*k+0.5)/k end
            math.Clamp=function(v,a,b) return math.min(math.max(v,a),b) end
            language={GetPhrase=function(s) return s end}
            baseclass={Get=function(s) return {ExplosionDamage=125,ExplosionRadius=300} end}
        ''')
        source = (ROOT / "lua/mcv/weapon_common/cl_hud.lua").read_text()
        lua.execute(to_lua((ROOT / "lua/mcv/shared/sh_physbullets.lua").read_text()))
        lua.execute(to_lua(source[source.index("local function boxes"):source.index("SWEP.Mat_Select = nil")]))
        lua.execute('''
            w=setmetatable({AmmoPerShot=1, Primary={Ammo="rpg",ClipSize=1}, ShootEntity="rocket",
                ExplosionDamage=0,ExplosionRadius=0,FireRate=0}, {__index=SWEP})
            function w:StatMult(stat) return stat=="explosion_damage" and 2 or 1 end
            function rows() local r={} for _,v in ipairs(w:GetWeaponInfoRows()) do r[v[1]]=v[2] end return r end
            r=rows(); assert(tonumber(r["Blast damage:"])==250)
            assert(r["Blast radius:"]=="7.6 m")
            w.ShootEntity=nil; w.ThrowEntity="grenade"; w.ExplosionDamage=180; w.ExplosionRadius=200
            r=rows(); assert(tonumber(r["Blast damage:"])==360 and r["Blast radius:"]=="5.1 m")
            w.ExplosionDamage=0; assert(rows()["Blast damage:"]==nil)
            w.HasAkimbo=true; w.HasRifleGrenade=true; w.Silencer=true; w.HasBipod=true
            w.HasBayonet=true; w.HasScope=true; w.AdjustableScopes=true; w.ArmorPiercing=true
            assert(w:GetWeaponInfoTags()=="[DUAL] [RG] [SD] [BI] [BAYO] [VS] [AP]")
            w.RifleGrenadeIsUBGL=true
            assert(w:GetWeaponInfoTags()=="[DUAL] [GL] [SD] [BI] [BAYO] [VS] [AP]")
            w.ThrowEntity=nil; w.DamageGeneric=15
            w.DamageRampStart=0.25; w.DamageRampEnd=1.5; w.DamageRampDistance=2000
            r=rows(); assert(r["Damage:"]=="3.8 - 22.5" and r["Full power:"]=="50.8 m")
        ''')

    def test_ap_direct_hits(self):
        lua = LuaRuntime()
        lua.execute('''
            SWEP={}; CLIENT=true; MAT_METAL=1; MAT_GRATE=2; MAT_VENT=3; MAT_GLASS=4
            function SWEP:GetBulletCount() return self.Num or 1 end
            MAT_CONCRETE=5; MAT_TILE=6; MAT_WOOD=7
            DMG_BULLET=2; DMG_BLAST=64; DMG_AIRBOAT=33554432
            function IsValid(v) return v~=nil end
            MCV={CancelBodyDamage=function() end}
            math.pow=function(a,b) return a^b end
            HITGROUP_HEAD=1; HITGROUP_CHEST=2; HITGROUP_STOMACH=3
            HITGROUP_LEFTARM=4; HITGROUP_RIGHTARM=5; HITGROUP_LEFTLEG=6; HITGROUP_RIGHTLEG=7
        ''')
        lua.execute(to_lua((ROOT / "lua/mcv/shared/sh_physbullets.lua").read_text()))
        lua.execute(to_lua((ROOT / "lua/weapons/mcv_base/sh_penetration.lua").read_text()))
        lua.execute('''
            w=setmetatable({ArmorPiercing=true,Num=1,RangeModifier=0.995}, {__index=SWEP})
            d={value=150,kind=DMG_BULLET}
            function d:GetDamage() return self.value end
            function d:SetDamage(v) self.value=v end
            function d:SetDamageType(v) self.kind=v end
            function entity(class,owner) return {GetClass=function() return class end,GetOwner=function() return owner end} end
            for _,v in ipairs({{"npc_helicopter",DMG_AIRBOAT},{"npc_strider",DMG_BLAST},
                {"npc_combinegunship",DMG_BLAST},{"npc_combine_s",DMG_BULLET},{"prop_vehicle_airboat",DMG_BULLET}}) do
                d.value=150; d.kind=DMG_BULLET
                w:ApplyBulletDamage({Entity=entity(v[1]),HitGroup=0},d,500)
                assert(d.kind==v[2] and math.abs(d.value-149.25)<0.0001)
            end
            d.kind=DMG_BULLET
            w:ApplyBulletDamage({Entity=entity("phys_bone_follower",entity("npc_strider")),HitGroup=0},d,0)
            assert(d.kind==DMG_BLAST)
            w.ArmorPiercing=false; d.kind=DMG_BULLET
            w:ApplyBulletDamage({Entity=entity("npc_helicopter"),HitGroup=0},d,0)
            assert(d.kind==DMG_BULLET)
        ''')

    def test_countries(self):
        countries = {}
        for pack in (ROOT, PART2):
            for path in (pack / "lua/weapons").glob("*.lua"):
                match = re.search(r'^SWEP.Country = "([^"]*)"', path.read_text(encoding="utf-8"), re.M)
                if match:
                    countries[path.stem.removeprefix("mcv_")] = match[1]
                    self.assertNotIn(match[1], ALIASES, path.name)
        for name, expected in CORRECTIONS.items():
            self.assertEqual(countries[name], expected)
        pools = (ROOT / "lua/mcv/shared/sh_random_weapons.lua").read_text()
        for country in set(countries.values()) - {"", "Black Mesa"}:
            self.assertIn('"' + country + '"', pools)


if __name__ == "__main__":
    unittest.main()

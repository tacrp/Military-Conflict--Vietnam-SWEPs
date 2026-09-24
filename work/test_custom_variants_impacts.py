"""Offline asset, dual-draw and impact dispatch checks; no game is launched."""
from pathlib import Path
import re
import struct
from lupa import LuaRuntime
from glua_check import to_lua
from split_packs import Audit
from fix_gyrojet_sprint import model_metadata

ROOT = Path(__file__).resolve().parents[1]


def assets():
    audit = Audit()
    for name in ('svd_irons', 'type56_drum'):
        fields = audit.fields('mcv_'+name)
        audit.closure([fields['ViewModel'], fields['WorldModel'], 'materials/'+fields['IconOverride']], name)
        folder = ROOT/'work/MCV_SMD/weapons'/('v_'+name)
        for qc in folder.glob('*.qc'):
            for ref in re.findall(r'"([^"\n]+\.(?:smd|qci))"', qc.read_text(), re.I):
                assert (folder/ref.replace('\\', '/')).exists(), ref
    decal_source = (ROOT/'lua/mcv/shared/sh_impact_decals.lua').read_text()
    decals = sorted(set(re.findall(r'"(mcv/decals/[^"\n]+)"', decal_source)))
    assert len(decals) == 62
    audit.closure(['materials/'+p+'.vmt' for p in decals], 'MCV bullet decals')
    assert not any(audit.missing.values()), dict(audit.missing)
    for prefix in ('v', 'w'):
        data = (ROOT/'models/weapons/mcv'/(prefix+'_svd_irons.mdl')).read_bytes()
        count, start = struct.unpack_from('<ii', data, 204)
        slots = []
        for i in range(count):
            record = start+i*64
            offset = record+struct.unpack_from('<i', data, record)[0]
            slots.append(data[offset:data.index(b'\0', offset)].decode())
        assert not {'optics_pso_1', 'lens_svd', 'w_svd_scope'}.intersection(slots), slots
    def metadata(name):
        return model_metadata(ROOT/'models/weapons/mcv'/('v_'+name+'.mdl'))
    # SVD animations untouched; Type 56 keeps every sequence except the requested reloads.
    assert metadata('svd')['animations'] == metadata('svd_irons')['animations']
    base, custom, donor = [metadata(n) for n in ('type56', 'type56_drum', 'rpk')]
    for seq in custom['sequences']:
        expected = donor if seq[0] in ('reload', 'reload_empty') else base
        assert seq == next(s for s in expected['sequences'] if s[0] == seq[0]), seq[0]
    print('PASS: scope-free compiled materials, reload events, preserved sequences, editable sources and dependencies')


def dual_draw():
    lua = LuaRuntime()
    lua.execute('''
        SWEP={Firemodes={1}}; ACT_VM_READY=1; ACT_VM_DRAW=2
        function IsValid(x) return x~=nil end
        function SWEP:GetOwner() return {GetViewModel=function() return {} end} end
        function SWEP:GetAkimbo() return self.dual end
        function SWEP:SetAkimbo(x) self.dual=x end
        function SWEP:SyncViewModel() end
        function SWEP:FiremodeAvailable() return true end
        function SWEP:GetFiremode() return 1 end
        function SWEP:Clip1() return self.clip end
        function SWEP:RestoreClip() end
        function SWEP:PlayAnimation(act) self.act=act end
    ''')
    lua.execute(to_lua((ROOT/'lua/weapons/mcv_base/sh_akimbo.lua').read_text()))
    lua.execute('''
        for _,dual in ipairs({false,true}) do
            for _,slide in ipairs({false,true}) do
                for clip=0,2 do
                    local w=setmetatable({dual=dual,LastShotAnimation=slide,clip=clip},{__index=SWEP})
                    w:Deferred_AkimboSwap()
                    local draw=clip==0 or (not dual and slide and clip==1)
                    assert(w.act==(draw and ACT_VM_DRAW or ACT_VM_READY))
                end
            end
        end
    ''')
    print('PASS: dual draw choice for empty/one/two rounds, slide-lock and non-slide weapons, both directions')


def impacts():
    lua = LuaRuntime()
    src = (ROOT/'lua/mcv/shared/sh_impacts.lua').read_text()
    for i, const in enumerate(sorted(set(re.findall(r'\bMAT_\w+', src)) | {'MAT_FLESH'}), 1):
        lua.globals()[const] = i
    lua.execute('''
        MCV={ConVars={}}; enabled=true; first=true; effects={}
        function MCV.RegisterConVar(n) MCV.ConVars[n]={GetBool=function() return enabled end} end
        function PrecacheParticleSystem() end
        function math.Clamp(x,a,b) return math.min(math.max(x,a),b) end
        function IsFirstTimePredicted() error('Impact hook is outside client prediction') end
        util={GetSurfaceData=function() return {name='unmapped'} end,
            Effect=function(name,data,override,ignore)
                assert(name=='mcv_impact' and override and ignore==true)
                assert(data.flags==13)
                effects[#effects+1]=data
            end}
        function EffectData() return {
            SetOrigin=function(s,x) s.pos=x end, SetNormal=function(s,x) s.normal=x end,
            SetFlags=function(s,x) s.flags=x end, SetScale=function(s,x) s.scale=x end}
        end
        registered={}
        game={AddDecal=function(name,mats) registered[name]=mats end,AddParticles=function() end}
        function string.StartWith(s,prefix) return s:sub(1,#prefix)==prefix end
    ''')
    lua.execute(to_lua((ROOT/'lua/mcv/shared/sh_impact_decals.lua').read_text()))
    lua.execute(to_lua(src))
    lua.execute('''
        for _,server in ipairs({false,true}) do
            SERVER=server; effects={}; first=true; enabled=true
            local tr={Hit=true,HitPos=1,HitNormal=2,MatType=MAT_METAL,SurfaceProps=0}
            assert(MCV.SurfaceImpact(tr)==true and #effects==1)
            assert(effects[1].scale==1)
            first=false
            assert(MCV.SurfaceImpact(tr)==true and #effects==2)
            first=true; enabled=false
            assert(MCV.SurfaceImpact(tr)==false and #effects==2)
            enabled=true; tr.HitSky=true
            assert(MCV.SurfaceImpact(tr)==false)
            tr.HitSky=false; tr.MatType=MAT_FLESH
            assert(MCV.SurfaceImpact(tr)==false and #effects==2)
        end
        for _,family in ipairs(MCV.ImpactFamilies) do
            local decal=MCV.ImpactDecalName(family)
            assert(decal==nil or registered[decal]~=nil)
        end
        assert(MCV.ImpactDecalName('water_small')==nil)
        assert(MCV.ImpactDecalName('puddle')==nil)
        assert(MCV.ImpactDecalName('brick')=='MCV.Impact.brick')
        assert(MCV.ImpactScale(10)==0.5)
        assert(MCV.ImpactScale(40)==1)
        assert(MCV.ImpactScale(160)==2)
        assert(MCV.ImpactScale(99999)==2)
    ''')
    # Run the real effect's decal path even if particle creation fails.
    lua.execute('''
        EFFECT={}; vector_up={}; holeCount=0
        local mt={__add=function(a,b) return a end,__sub=function(a,b) return a end,
                  __mul=function(a,b) return a end}
        pos=setmetatable({},mt)
        normal=setmetatable({LengthSqr=function() return 1 end,Angle=function() return {} end},mt)
        util.Decal=function(name,a,b,filter)
            assert(name=='MCV.Impact.metal' and filter==nil); holeCount=holeCount+1
        end
        function EFFECT:SetPos() end
        function EFFECT:SetAngles() end
        function CreateParticleSystem() return nil end
        function IsValid(x) return x~=nil end
        data={GetFlags=function() return 13 end,GetMaterialIndex=function() return MAT_METAL end,
              GetOrigin=function() return pos end,GetNormal=function() return normal end}
    ''')
    lua.execute(to_lua((ROOT/'lua/effects/mcv_impact.lua').read_text()))
    lua.execute('EFFECT:Init(data); assert(holeCount==1)')
    print('PASS: impacts outside prediction, host delivery argument, flesh/sky/disabled fallback and original-game prop decals')


if __name__ == '__main__':
    assets()
    dual_draw()
    impacts()

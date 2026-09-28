"""Compare composed base definitions with the checkpoint's inherited definitions."""
from pathlib import Path
import re
import subprocess
from lupa import LuaRuntime
from glua_check import to_lua

ROOT = Path(__file__).resolve().parents[1]
BASES = ['mcv_base', 'mcv_throwable', 'mcv_melee', 'mcv_placeable', 'mcv_equipment_box']
BASELINE = 'e9b2e0895'

def runtime(old, client):
    lua = LuaRuntime(unpack_returned_tuples=True)
    lua.execute('''
    SERVER=false; CLIENT=false; MCV={}; hooks={}; hookCount=0
    local dummy={}
    setmetatable(dummy,{__index=function() return dummy end,__call=function() return dummy end})
    hook={Add=function(event,name,fn) hooks[event..name]=fn; hookCount=hookCount+1 end}
    function AddCSLuaFile() end
    function istable(v) return type(v)=='table' end
    function table.Copy(t)
        local out={}; for k,v in pairs(t) do out[k]=type(v)=='table' and table.Copy(v) or v end
        return out
    end
    function Vector(x,y,z) return {x=x or 0,y=y or 0,z=z or 0} end
    Angle=Vector; Color=Vector
    function CurTime() return 0 end
    function UnPredictedCurTime() return 0 end
    setmetatable(_G,{__index=function(t,k)
        if k:match('^[A-Z][A-Z0-9_]+$') then
            local v=0; for i=1,#k do v=(v*31+k:byte(i))%1000000 end
            rawset(t,k,v); return v
        end
        return dummy
    end})
    ''')
    lua.globals().CLIENT = client
    lua.globals().SERVER = not client
    cache = {}
    def read(path):
        if path not in cache:
            cache[path] = (subprocess.check_output(['git','show',BASELINE+':lua/'+path],cwd=ROOT).decode('utf-8')
                           if old else (ROOT/'lua'/path).read_text(encoding='utf-8'))
        return cache[path]
    def modules(directory):
        if old:
            names=subprocess.check_output(['git','ls-tree','--name-only',BASELINE+':lua/'+directory],cwd=ROOT).decode().splitlines()
        else:
            names=[p.name for p in (ROOT/'lua'/directory).glob('*.lua')]
        for name in sorted(names):
            if name in ('shared.lua','load.lua'): continue
            if name.startswith('cl') and not client: continue
            if name.startswith('sv') and client: continue
            include(directory+'/'+name)
    def include(path):
        s=read(path)
        # Replace filesystem-loader boilerplate only; execute actual defaults and methods.
        if 'local searchdir =' in s:
            directory=re.search(r'local searchdir = "([^"]+)"',s)[1]
            start=s.index('local searchdir =')
            if 'autoinclude(searchdir)' in s:
                end=s.index('autoinclude(searchdir)')+len('autoinclude(searchdir)')
            else:
                end=len(s)
            s=s[:start]+f'loadmodules("{directory}")\n'+s[end:]
        lua.execute(to_lua(s), name=path)
    lua.globals().include=include
    lua.globals().loadmodules=modules
    def find(pattern, realm):
        directory=ROOT/'lua'/pattern.removesuffix('/*.lua')
        return (lua.table_from(sorted(p.name for p in directory.glob('*.lua'))),
                lua.table_from(sorted(p.name for p in directory.iterdir() if p.is_dir())))
    lua.globals().file=lua.table_from({'Find':find})
    tables={}
    if old:
        lua.execute('SWEP={Primary={},Secondary={}}')
        include('weapons/mcv_base_core/shared.lua')
        core=lua.globals().SWEP
    for base in BASES:
        if old:
            lua.globals().core=core
            lua.execute('SWEP=table.Copy(core)')
        else:
            lua.execute('SWEP={Primary={},Secondary={}}')
        include('weapons/'+base+'/shared.lua')
        tables[base]=lua.globals().SWEP
    return lua,tables

def snapshot(lua, table):
    result={}
    for key,value in table.items():
        kind=lua.eval('type')(value)
        if kind=='function': result[key]='<function>'
        elif kind=='table': result[key]=snapshot(lua,value)
        else: result[key]=value
    return result

for client in (False,True):
    old, before=runtime(True,client)
    new, after=runtime(False,client)
    for base in BASES:
        a,b=snapshot(old,before[base]),snapshot(new,after[base])
        a['Base']='weapon_base'
        assert a==b, (client,base, {k:(a.get(k),b.get(k)) for k in a.keys()|b.keys() if a.get(k)!=b.get(k)})
    assert new.globals().hookCount==old.globals().hookCount, 'common hooks loaded more than once'
    assert after['mcv_base']['Primary']['Ammo'] != after['mcv_throwable']['Primary']['Ammo']
    after['mcv_base']['Primary']['Ammo']='test'
    assert after['mcv_throwable']['Primary']['Ammo']=='mcv_grenade'
print('PASS: server/client defaults and method sets match all five old bases; hooks load once; default tables isolated')

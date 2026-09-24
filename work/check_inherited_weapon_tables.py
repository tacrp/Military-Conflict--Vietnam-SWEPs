"""Audit bullet thresholds and exercise the real bodygroup loops with inheritance metadata."""
import re
from lupa import LuaRuntime
from pack_paths import ROOT, mounted_files
from glua_check import to_lua

lua = LuaRuntime()
audited = []
for path in mounted_files('lua/weapons', '*.lua'):
    raw = path.read_text(encoding='utf-8-sig')
    match = re.search(r'SWEP\.BulletBodygroups\s*=\s*\{', raw)
    if not match:
        continue
    end, depth = match.end(), 1
    while depth:
        depth += (raw[end] == '{') - (raw[end] == '}')
        end += 1
    declaration = raw[match.start():end]
    # The belt variant constructs its contiguous thresholds with a simple for loop.
    loop = re.match(r'\s*(for i = .*? do SWEP\.BulletBodygroups\[i\] = .*? end)', raw[end:])
    if loop:
        declaration += '\n' + loop[1]
    lua.execute('SWEP={}')
    lua.execute(to_lua(declaration))
    keys = sorted(lua.globals().SWEP.BulletBodygroups.keys())
    assert keys == list(range(1, len(keys)+1)), (path, keys)
    audited.append(path.stem)
print(f'{len(audited)} BulletBodygroups definitions: all contiguous from 1; no existing gaps.')

source = (ROOT/'lua/weapons/mcv_base/sh_vm.lua').read_text(encoding='utf-8')
block = source.split('    if self.BulletBodygroups then', 1)[1].split('    local shouldhammer', 1)[0]
lua.execute('''
    function isnumber(v) return type(v)=='number' end
    self={BulletBodygroups={ [1]={4,1}, [5]={8,1}, [12]={9,2}, BaseClass={bad=true}},
          BeltBodygroups={22,23,BaseClass={bad=true}}}
    vm={}
    function vm:SetBodygroup(index,value)
        assert(type(index)=='number' and type(value)=='number')
        self[index]=value
    end
''')
for count in (0, 1, 4, 5, 11, 12):
    lua.globals().bodygroupbulletscount = count
    lua.execute(to_lua('if self.BulletBodygroups then'+block))
    vm = lua.globals().vm
    for threshold, index, hidden in ((1,4,1), (5,8,1), (12,9,2)):
        assert vm[index] == (hidden if count < threshold else 0)
    assert vm[22] == vm[23] == (0 if count > 0 else 1)
print('Actual bullet/belt loops passed BaseClass metadata, sparse thresholds and boundary counts.')

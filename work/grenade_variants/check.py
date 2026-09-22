"""Check the mounted compiled skin tables and all three weapon variants offline."""
import re
import struct
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from pack_paths import asset_path

for model in ('v_m18', 'w_m18'):
    data = asset_path(f'models/weapons/mcv/{model}.mdl').read_bytes()
    count, offset = struct.unpack_from('<2i', data, 204)
    def string(at):
        return data[at:data.index(b'\0', at)].decode()
    textures = [string(offset+i*64+struct.unpack_from('<i',data,offset+i*64)[0]) for i in range(count)]
    refs, families, skin_offset = struct.unpack_from('<3i', data, 220)
    assert families >= 8
    for skin, material in ((0,'m18_red'),(4,'m18'),(7,'riot')):
        indices=struct.unpack_from(f'<{refs}H',data,skin_offset+skin*refs*2)
        expected=('w_' if model.startswith('w_') else '')+material
        assert textures[indices[0]]==expected, (model,skin,textures[indices[0]])
        vmt=asset_path(f'materials/models/weapons/mcv/{model}/{expected}.vmt')
        assert vmt.is_file()
        base=re.search(r'"\$basetexture"\s*"([^"]+)"',vmt.read_text(),re.I)[1]
        assert asset_path('materials/'+base.replace('\\','/')+'.vtf').is_file()
        print(model, 'skin',skin, '->',expected)

for name, skin, entity in (('anm8',4,'smoke'),('m18',0,'smoke'),('m6a1',7,'gas')):
    src=asset_path(f'lua/weapons/mcv_{name}.lua').read_text()
    assert re.search(rf'SWEP.ModelSkin\s*=\s*{skin}\b',src)
    assert f'mcv_grenade_{entity}' in src
    assert asset_path(f'materials/entities/mcv_{name}.png').is_file()
    if name=='m18':
        color=re.search(r'SWEP.SmokeColor\s*=\s*Vector\((\d+),\s*(\d+),\s*(\d+)\)',src)
        assert color
        red,green,blue=map(int,color.groups())
        assert 0 <= green < red <= 255 and 0 <= blue < red  # allow tuned red shades
    elif name=='anm8':
        assert 'SWEP.SmokeColor' not in src  # default white particle system
print('All three variants and their compiled skin/material/icon dependencies passed.')

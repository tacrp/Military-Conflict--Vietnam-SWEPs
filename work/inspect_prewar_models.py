"""Inspect compiled material slots for the prewar variants (no game launch)."""
import struct
import argparse
import json
from pathlib import Path

from split_packs import Audit

ROOT = Path(__file__).resolve().parent.parent
PART2 = ROOT.parent / 'mcv-2'
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--move-models', action='store_true', help='Move only the prewar model companions into Part 2')
args = parser.parse_args()
if args.move_models:
    for stem in ('v_kar98_dov', 'w_kar98_dov'):
        for source in (ROOT/'models/weapons/mcv').glob(stem+'.*'):
            target = PART2/source.relative_to(ROOT)
            assert source.resolve().is_relative_to((ROOT/'models/weapons/mcv').resolve())
            assert target.resolve().is_relative_to((PART2/'models/weapons/mcv').resolve())
            assert not target.exists(), target
            source.rename(target)

audit = Audit()
slots = {}
for stem in ('v_kar98_dov', 'v_kar98_s', 'w_kar98_dov', 'w_kar98_s'):
    path = audit.files['models/weapons/mcv/'+stem+'.mdl']
    data = path.read_bytes()
    count, start = struct.unpack_from('<ii', data, 204)
    slots[stem] = []
    for index in range(count):
        record = start + index * 64
        offset = record + struct.unpack_from('<i', data, record)[0]
        slots[stem].append(data[offset:data.index(b'\0', offset)].decode())
assert slots['v_kar98_dov'][0] == 'kar98_s'
assert slots['v_kar98_s'][0] == 'kar98_postwar'
assert slots['w_kar98_dov'][0] == 'w_kar98s'
assert slots['w_kar98_s'][0] == 'w_kar98s_postwar'
assert slots['v_kar98_dov'][4] == 'lens_zf39'
assert slots['v_kar98_dov'][7] == 'crosshair_zf41a'
for name in ('mcv_kar98_prewar', 'mcv_kar98_prewar_s', 'mcv_kar98_prewar_zf41'):
    fields = audit.fields(name)
    assert audit.weapons[name].is_relative_to(PART2)
    assert fields['ViewModel'].endswith('/v_kar98_dov.mdl')
    assert fields['WorldModel'].endswith('/w_kar98_dov.mdl')
    audit.closure([fields['ViewModel'], fields['WorldModel'],
                   'materials/'+fields['IconOverride']], name)
audit.closure(['models/weapons/shells/shell_rg_ger.mdl'], 'German grenade')
assert not any(audit.missing.values()), dict(audit.missing)
print(json.dumps(slots, indent=2))
print('PASS: distinct pre/postwar materials, scope slots, three weapons and asset dependencies')

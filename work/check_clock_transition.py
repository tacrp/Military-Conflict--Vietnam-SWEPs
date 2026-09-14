"""Verify real retained entity transition records and subsequent input."""
import json
import shutil
from pathlib import Path

root = Path(__file__).resolve().parents[1]
src = root / '../../data/mcv_harness/p27016/results'
dst = root / 'work/validation'
names = ['clock_map_before.json', 'clock_map_return.json', 'clock_post_input.json']
before, after, fired = [json.loads((src / n).read_text()) for n in names]
assert before['map'] != after['map']
assert before['singleplayer'] and len(before['weapons']) == len(after['weapons']) == 3
by_class = {w['class']: w for w in before['weapons']}
for w in after['weapons']:
    b = by_class[w['class']]
    assert w['marker'] == b['marker'] and w['clip'] == b['clip'] and w['mode'] == b['mode'], w
    assert w['serial'] > b['serial'] and w['fire'] < before['time'] and w['lock'] == 0 and not w['reload'], w
assert fired['ok'] and fired['before'] == 7 and fired['mode'] == by_class[fired['class']]['mode']
for n in names:
    shutil.copy2(src / n, dst / n)
print('PASS: 3 retained weapon Lua tables, ammo/modes preserved, clock reset, subsequent fire and reload')

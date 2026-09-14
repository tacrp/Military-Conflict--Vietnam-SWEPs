"""Check the captured, real HUD frames (run tests/hud_transitions.txt first)."""
import json
from pathlib import Path

root = Path(__file__).resolve().parents[1]
data = json.loads((root / '../../data/mcv_harness/p27016/results/hud_transitions.json').read_text())
rows = data['samples']
assert len(data['switches']) >= 4
assert all(r['blend'] == 0 for r in data['switches']), 'Incoming HUD flashed'
previous = None
reload_start = None
holstering = False
reload_hidden = ending_hidden = holster_frames = 0
for r in rows:
    same = previous and r['class'] == previous['class'] and r['frame'] == previous['frame'] + 1
    if not same:
        reload_start = None
        holstering = False
    if r['holster'] > r['time'] or r['holster'] < 0:
        holstering = True
    if holstering and same:
        assert r['blend'] <= previous['blend'] + 0.0001, ('Outgoing HUD flashed', previous, r)
        holster_frames += 1
    if r['reloading']:
        reload_start = reload_start if reload_start is not None else r['time']
        if r['time'] - reload_start > 0.16:
            assert r['crosshair'] <= 0.001, ('Crosshair visible during reload', r)
            reload_hidden += 1
    elif same and reload_start is not None and r['lock'] > r['time']:
        assert r['crosshair'] <= 0.001, ('Crosshair returned before reload animation ended', r)
        ending_hidden += 1
    else:
        reload_start = None
    previous = r
assert reload_hidden and ending_hidden and holster_frames
assert rows[-1]['crosshair'] == 1, 'Crosshair never returned'
result = dict(ok=True, frames=len(rows), incoming_switches=len(data['switches']),
              holster_frames=holster_frames, reload_hidden_frames=reload_hidden,
              reload_ending_hidden_frames=ending_hidden)
out = root / 'work/validation/hud_transitions.json'
out.parent.mkdir(exist_ok=True)
out.write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps(result, indent=2))

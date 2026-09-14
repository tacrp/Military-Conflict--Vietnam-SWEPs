"""Verify the applied QC lines, preserved angles, finger anchor and installed MDLs."""
import json
from pathlib import Path
import numpy as np
from world_model_contact import HAND_RE
from derive_hand_offsets import def_from
from measure_world_model_pitch import parse

root = Path(__file__).resolve().parents[1]
folder = root / 'work/world_model_contact'
changes = json.loads((folder / 'changes.json').read_text())
builds = json.loads((folder / 'build.json').read_text())
assert len(changes) == len(builds) == 181
assert all(b['ok'] and b['installed'] for b in builds)
worst_anchor = worst_compiled = 0
for name, record in changes.items():
    qc = root / 'work/MCV_SMD_PORT/weapons' / name / (name + '.qc')
    assert HAND_RE.search(qc.read_text())[0] == record['after'], name
    before = list(map(float, HAND_RE.match(record['before'])[2].split()[:6]))
    after = list(map(float, HAND_RE.match(record['after'])[2].split()[:6]))
    assert before[3:] == after[3:], name + ' angle changed'
    before[3] = record['original_pitch']
    pivot = np.r_[record['finger_pivot'], 1]
    error = np.max(np.abs(np.asarray(def_from(before)) @ pivot - np.asarray(def_from(after)) @ pivot))
    assert error < 2e-6, (name, error)
    worst_anchor = max(worst_anchor, float(error))
    bones, _ = parse((root / 'models/weapons/mcv' / (name + '.mdl')).read_bytes())
    bind_inverse = next(b[1] for b in bones if b[0] == 'ValveBiped.Bip01_R_Hand')
    error = np.max(np.abs(np.asarray(bind_inverse) - np.linalg.inv(def_from(after))[:3]))
    assert error < 0.0001, (name, error)
    worst_compiled = max(worst_compiled, float(error))
result = dict(ok=True, models=len(changes), max_anchor_error=worst_anchor,
              max_compiled_transform_error=worst_compiled)
(folder / 'validation.json').write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps(result, indent=2))

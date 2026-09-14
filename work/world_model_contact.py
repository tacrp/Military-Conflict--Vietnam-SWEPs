"""Pitch a bonemerged world model while preserving its index-finger contact."""
import json
import re
from pathlib import Path
import numpy as np
from derive_hand_offsets import def_from

HERE = Path(__file__).resolve().parent
HAND_RE = re.compile(r'^(\$definebone\s+"ValveBiped\.Bip01_R_Hand"\s+""\s+)([^\r\n]+)', re.M)
_pivots = None


def contact_pivot(hold):
    global _pivots
    if _pivots is None:
        _pivots = json.loads((HERE/'world_model_contact_pivots.json').read_text())['holdtypes']
    return _pivots.get(hold, _pivots['ar2'])


def pitch_about_finger(off, target, pivot):
    before = np.asarray(def_from(off))
    after_values = list(off)
    after_values[3] = target
    after = np.asarray(def_from(after_values))
    # H maps hand coordinates into model space; the rendered gun uses inverse H.
    # Keep H_before * finger == H_after * finger. Rotation alone loses that anchor.
    after_values[:3] = (before[:3, 3] + (before[:3, :3]-after[:3, :3]) @ pivot).tolist()
    a = np.asarray(def_from(after_values)) @ np.r_[pivot, 1]
    b = before @ np.r_[pivot, 1]
    assert np.max(np.abs(a-b)) < 1e-6, 'finger anchor moved'
    return after_values


def pitch_hand_line(line, target, hold):
    m = HAND_RE.match(line)
    if not m:
        return line
    values = m[2].split()
    off = list(map(float, values[:6]))
    if abs(off[3]-target) < .001:
        return line
    after = pitch_about_finger(off, target, contact_pivot(hold))
    return m[1] + ' '.join([*(f'{v:.6f}' for v in after), *values[6:]])

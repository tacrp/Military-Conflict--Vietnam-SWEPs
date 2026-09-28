"""Offline inspection of resolved firing source tracks."""
from pathlib import Path
import numpy as np
from bake_ik import load_smd, rmat
from port_qc import QC

ROOT = Path(__file__).resolve().parents[1]

def inspect(model):
    path = ROOT / f'work/MCV_SMD_PORT/weapons/{model}/{model}.qc'
    qc = QC(path.read_text())
    for b in qc.blocks('animation'):
        if not b.name.startswith('shoot') or 'corrective' in b.name:
            continue
        source = (path.parent / b.path.replace('\\', '/')).resolve()
        nodes, frames, _ = load_smd(source)
        x = np.array([[f[i] for i in nodes] for f in frames])
        print(model, b.name, 'frames', len(frames), 'path', str(source.relative_to(ROOT)))
        changes = []
        for i, (name, _) in nodes.items():
            d = np.linalg.norm(np.diff(x[:, i, :3], axis=0), axis=1)
            angles = []
            for a, z in zip(x[:-1, i, 3:], x[1:, i, 3:]):
                angles.append(np.degrees(np.arccos(np.clip((np.trace(rmat(a).T @ rmat(z))-1)/2,-1,1))))
            if len(d) and (max(d) > .1 or max(angles) > 1):
                changes.append((round(max(d),3), round(max(angles),3), name, int(np.argmax(d))+1, int(np.argmax(angles))+1))
        print(sorted(changes, reverse=True)[:8])

if __name__ == '__main__':
    inspect('v_m1911')

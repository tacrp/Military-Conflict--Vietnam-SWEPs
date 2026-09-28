"""Offline regression for old hand-edited reloads with a missing BaseRoot."""
from pathlib import Path
import hashlib
from tempfile import TemporaryDirectory
from types import SimpleNamespace
import numpy as np

from bake_ik import load_smd, fk
from model_pose_fixes import prepare_pose_fixes
from port_qc import Ctx

WORK = Path(__file__).resolve().parent
cases = {'v_cobra': ('reload',), 'v_m21': ('reload_empty', 'reload_empty_2')}
for model, names in cases.items():
    with TemporaryDirectory(prefix='mcv-reload-rigs-') as temporary:
        ctx = Ctx(SimpleNamespace(fixed_root=str(WORK / 'MCV_SMD')),
                  str(WORK / 'MCV_SMD_OG/weapons' / model), temporary)
        sources = [WORK / f'MCV_SMD/weapons/{model}/anims/{name}.smd' for name in names]
        unchanged = [hashlib.sha256(p.read_bytes()).hexdigest() for p in sources]
        prepare_pose_fixes(ctx)
        for name, source in zip(names, sources):
            original = WORK / f'MCV_SMD_OG/weapons/{model}/{model}_anims/{name}.smd'
            fixed = Path(ctx.resolve_smd(f'{model}_anims/{name}.smd'))
            assert fixed == Path(temporary) / f'fixed_anims/{name}.smd'
            nodes, frames, _ = load_smd(source)
            target_nodes, target_frames, _ = load_smd(original)
            fixed_nodes, fixed_frames, _ = load_smd(fixed)
            assert fixed_nodes == target_nodes
            assert len(frames) == len(fixed_frames) == len(target_frames)
            byname = {name: i for i, (name, _) in fixed_nodes.items()}
            maximum = 0
            for before, after in zip(frames, fixed_frames):
                old_world, new_world = fk(nodes, before), fk(fixed_nodes, after)
                for i, (bone, _) in nodes.items():
                    maximum = max(maximum, float(np.max(np.abs(old_world[i] - new_world[byname[bone]]))))
            assert maximum < 1e-5, (model, name, maximum)
            if nodes == target_nodes:
                assert source.read_bytes() == fixed.read_bytes(), 'already-compatible edit changed'
            if model == 'v_cobra':
                idle_nodes, idle_frames, _ = load_smd(original.with_name('basePose_a.smd'))
                assert idle_nodes == fixed_nodes
                root, gun = byname['BaseRoot'], byname['Base']
                for endpoint in (0, -1):
                    assert np.array_equal(fixed_frames[endpoint][root], idle_frames[0][root])
                # The authored return pose is already at idle: no motion smoothing
                # or new frames are needed to repair the hierarchy transition.
                gun_end = fk(fixed_nodes, fixed_frames[-1])[gun]
                gun_idle = fk(idle_nodes, idle_frames[0])[gun]
                gap = float(np.linalg.norm(gun_end[:3, 3] - gun_idle[:3, 3]))
                assert gap < 0.01, gap
            old_digest = hashlib.sha256(fixed.read_bytes()).hexdigest()
            prepare_pose_fixes(ctx)
            assert hashlib.sha256(fixed.read_bytes()).hexdigest() == old_digest
            print(f'PASS: {model}/{name}: {len(frames)} frames, hierarchy restored, '
                  f'maximum world-pose matrix error {maximum:.9g}')
        assert [hashlib.sha256(p.read_bytes()).hexdigest() for p in sources] == unchanged
print('PASS: source edits unchanged, repeatable build inputs, Cobra idle root/return and M21 compatibility')

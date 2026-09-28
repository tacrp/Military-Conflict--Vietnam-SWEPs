"""Verify the repaired firing tails and the porter's regression guard offline."""
from pathlib import Path
from types import SimpleNamespace
import hashlib
import json
import numpy as np
from bake_ik import load_smd
from fix_firing_tails import prepare
from model_pose_fixes import FIRING_TAIL_FIXES, validate_firing_tails
from port_qc import Ctx, QC, FIRE_ACTS
from pack_paths import ROOT

WORK=ROOT/'work'
build=json.loads((WORK/'firing_audit/build.json').read_text())
assert set(build)==set(FIRING_TAIL_FIXES)
for model,names in FIRING_TAIL_FIXES.items():
    qcpath=WORK/f'MCV_SMD_PORT/weapons/{model}/{model}.qc'
    before=qcpath.read_bytes()
    prepare(model)
    assert before==qcpath.read_bytes(), 'repair must be idempotent'
    ctx=Ctx(SimpleNamespace(fixed_root=str(WORK/'MCV_SMD')),
            str(WORK/'MCV_SMD_OG/weapons'/model), str(qcpath.parent))
    validate_firing_tails(QC(qcpath.read_text()),ctx,FIRE_ACTS)
    for name in names:
        info=build[model]['tracks'][name]
        original=ROOT/info['source']
        assert hashlib.sha256(original.read_bytes()).hexdigest()==info['source_sha256']
        nodes,frames,_=load_smd(original)
        newnodes,fixed,_=load_smd(qcpath.parent/'fixed_anims'/name)
        assert nodes==newnodes and len(frames)==len(fixed)==info['frames']
        for a,b in zip(frames[:-1],fixed[:-1]):
            assert all(np.array_equal(a[i],b[i]) for i in nodes)
        assert all(np.array_equal(fixed[-1][i],fixed[-2][i]) for i in nodes)
    for path,sha in build[model]['installed'].items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest()==sha
    # The actual old QC must fail the new compiler guard.
    old=QC((WORK/'firing_audit/before_qc'/qcpath.name).read_text())
    try:
        validate_firing_tails(old,ctx,FIRE_ACTS)
    except ValueError as error:
        assert 'firing tail leaves settled pose' in str(error)
    else:
        raise AssertionError('old defect escaped guard: '+model)
    print('PASS:',model,'all earlier frames and source files preserved; build hashes and guard checked')
audit=json.loads((WORK/'firing_audit/audit.json').read_text())
assert not audit['rig_mismatches']
assert [(x['model'],x['track']) for x in audit['tail_jumps']]==[('v_dp28','NotEmptyMove')]
print('PASS: full audit has no unresolved firing-tail defects; intended DP-28 open-bolt state retained')

"""Offline inventory/dependency audit for the five unused weapon variants."""
import json
from pathlib import Path
from split_packs import Audit
from fix_gyrojet_sprint import model_metadata

audit = Audit()
models = {
    'X2F2A2 FAL': ['v_x2f2a2', 'w_x2f2a2'],
    'vz. 59 Belt': ['v_vz59b'],
    'M16 Flamer': ['v_m16_flamer', 'w_m16_flamer'],
    'Type 56 XM148': ['v_type56xm148', 'w_type56xm148'],
    'Lunge Mine': ['v_lunge_mine', 'w_lunge_mine'],
}
report = {}
for name, stems in models.items():
    paths = [f'models/weapons/mcv/{s}.mdl' for s in stems]
    deps = audit.closure(paths, name)
    report[name] = {'models': paths, 'dependency_count': len(deps),
                    'missing': {k: sorted(v) for k,v in audit.missing.items() if k in deps or k == name}}
    assert not report[name]['missing'], report[name]
    stem = stems[0]
    class_name = 'mcv_' + stem.removeprefix('v_')
    assert class_name in audit.weapons, class_name
    fields = audit.fields(class_name)
    assert fields['ViewModel'] == paths[0]
    assert f'materials/entities/{class_name}.png' in audit.files
    world_deps = audit.closure([fields['WorldModel']], class_name)
    assert not audit.missing[class_name]
    required = {'idle', 'draw', 'reload', 'reload_empty'}
    if stem == 'v_lunge_mine': required = {'idle', 'draw', 'slash', 'stab', 'throw', 'throw_start', 'throw_loop'}
    if stem in ('v_m16_flamer', 'v_type56xm148'): required |= {'gl', 'gl_shoot', 'reload_secondary'}
    metadata = model_metadata(audit.files[paths[0]])
    assert required <= {s[0] for s in metadata['sequences']}, (name, required)
    if stem in ('v_m16_flamer', 'v_type56xm148'):
        assert b'ACT_VM_ISHOOT_M203\0' in audit.files[paths[0]].read_bytes()
    report[name]['class'] = class_name
    report[name]['required_sequences_present'] = sorted(required)
out = Path(__file__).with_suffix('.json')
out.write_text(json.dumps(report, indent=2)+'\n')
print(out.read_text())

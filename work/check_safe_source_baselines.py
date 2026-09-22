"""Confirm known pre-existing source timing differences with untouched-QC compiles."""
import json
import tempfile
from pathlib import Path
from types import SimpleNamespace
from build_safe_movement import WORK, OUT, PORT, ACTS, digest
from fix_gyrojet_sprint import model_metadata
from pack_paths import asset_path
import port_qc as p

NAMES = ('v_dp28', 'v_pk', 'v_pk_belt', 'v_vz61', 'v_vz61_silencer',
         'v_lacoste', 'v_luger', 'v_m14e2_sog', 'v_m7188', 'v_mg43b')


def main():
    rows = []
    for name in NAMES:
        backup = OUT / 'before_qc' / (name + '.qc')
        with tempfile.NamedTemporaryFile(mode='w', suffix='.qc', prefix='safety_baseline_',
                                         dir=PORT / name, encoding='utf8', delete=False) as file:
            file.write(backup.read_text())
            temporary = Path(file.name)
        game = WORK / 'compile_test_game/safety_baseline'
        try:
            result = p.compile_qc(SimpleNamespace(game=str(game), studiomdl=None), str(temporary))
            assert result['ok'], (name, result)
        finally:
            temporary.unlink()
        baseline = model_metadata(game / 'models/weapons/mcv' / (name + '.mdl'))
        installed = model_metadata(asset_path('models/weapons/mcv/' + name + '.mdl'))
        safety = {'@' + s.name for s in p.QC(backup.read_text()).blocks('sequence') if s.activity() in ACTS}
        current = {a[0]: a[1:] for a in installed['animations']}
        checked = {a[0]: a[1:] for a in baseline['animations'] if a[0] not in safety}
        assert all(current.get(k) == v for k, v in checked.items()), name
        assert installed['sequences'] == baseline['sequences'], name
        rows.append({'model': name, 'baseline_qc_sha256': digest(backup),
                     'original_animation_timings': checked, 'passed': True})
        print(name, 'untouched-QC timing/event baseline matched', flush=True)
    (OUT / 'source_baselines.json').write_text(json.dumps(rows, indent=2) + '\n')


if __name__ == '__main__':
    main()

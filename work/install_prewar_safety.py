"""Install only the validated prewar Kar 98K safety bake; never touch other models.

First run: python work/build_safe_movement.py --models v_kar98_dov --jobs 1 --compile --dense
"""
import json
import shutil
from build_safe_movement import WORK, OUT, PORT, digest, verify_timings
from fix_gyrojet_sprint import model_metadata
from pack_paths import asset_path

name = 'v_kar98_dov'
report = json.loads((OUT/'models'/f'{name}.json').read_text())
assert report.get('safe') and report.get('compile', {}).get('ok') and not report.get('error')
assert report['qc_sha256'] == digest(PORT/name/f'{name}.qc')
compiled = WORK/'compile_test_game/models/weapons/mcv'/f'{name}.mdl'
installed = asset_path(f'models/weapons/mcv/{name}.mdl')
before, after = model_metadata(installed), model_metadata(compiled)
assert before['sequences'] == after['sequences'], 'activities or events changed'
timing = verify_timings(name, before, after)
pending = []
for ext in ('.mdl', '.vvd', '.dx80.vtx', '.dx90.vtx'):
    source = compiled.with_name(name+ext)
    target = asset_path(f'models/weapons/mcv/{name}{ext}')
    assert source.is_file() and source.stat().st_size
    pending.append((source, target))
for source, target in pending:
    shutil.copy2(source, target)
    assert digest(source) == digest(target)
manifest = WORK.parent/'lua/mcv/shared/sh_safe_movement.lua'
text = manifest.read_text()
entry = f'    ["models/weapons/mcv/{name}.mdl"] = true,\n'
if entry.strip() not in text:
    text = text.replace('MCV.SafeMovementModels = {\n', 'MCV.SafeMovementModels = {\n'+entry, 1)
    manifest.write_text(text)
(OUT/'prewar_installed.json').write_text(json.dumps({
    'model': name, 'timing_check': timing,
    'files': {str(target): digest(target) for _, target in pending},
}, indent=2)+'\n')
print('Installed prewar safety animations and runtime opt-in; all three variants share this model.')

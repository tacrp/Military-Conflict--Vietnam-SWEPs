"""Surgically replace the prewar K98 launcher aim pose and compile its viewmodel."""
from pathlib import Path
import re
import shutil
import subprocess
from port_qc import QC, step_mode_idles
from pack_paths import asset_path
from fix_gyrojet_sprint import model_metadata

ROOT = Path(__file__).resolve().parents[1]
qcpath = ROOT/'work/MCV_SMD_PORT/weapons/v_kar98_dov/v_kar98_dov.qc'
source = qcpath.read_text()
pattern = r'(\$animation "grenade_ironsight(?:__f\d+)?" "[^"\n]*[\\/])grenade_ironsight\.smd"'
patched, count = re.subn(pattern, r'\1ironsight.smd"', source)
assert count in (0, 2), count
parsed = QC(patched)
aimed = parsed.find('animation', 'ironsight')
for name in ('grenade_ironsight', 'grenade_ironsight__f60'):
    anim = parsed.find('animation', name)
    assert anim.path == aimed.path
    assert anim.get('frame') == aimed.get('frame')
    assert anim.get('numframes') == aimed.get('numframes')
regenerated = QC(source)
ctx = type('Context', (), {'name':'v_kar98_dov', 'note':lambda *args: None})()
step_mode_idles(regenerated, ctx)
assert regenerated.render() == parsed.render()
qcpath.write_text(patched)

installed = asset_path('models/weapons/mcv/v_kar98_dov.mdl')
before = model_metadata(installed)
game = ROOT/'work/compile_test_game'
compiler = ROOT.parents[2]/'bin/studiomdl.exe'
run = subprocess.run([str(compiler), '-game', str(game), '-nop4', str(qcpath)],
                     cwd=compiler.parent, capture_output=True, text=True, timeout=300)
log = run.stdout+run.stderr
(qcpath.parent/'launcher_sights_compile.log').write_text(log)
assert run.returncode == 0 and 'Completed' in log and 'ERROR:' not in log, log[-5000:]
built = game/'models/weapons/mcv/v_kar98_dov.mdl'
assert model_metadata(built) == before, 'Sequence/event/frame metadata changed'
for file in built.parent.glob('v_kar98_dov.*'):
    shutil.copy2(file, asset_path('models/weapons/mcv/'+file.name))
print('PASS: standard irons in launcher idle/firing, generator parity, unchanged sequence/event/frame metadata')
print('Installed prewar viewmodel in Part 2. Fully restart GMod.')

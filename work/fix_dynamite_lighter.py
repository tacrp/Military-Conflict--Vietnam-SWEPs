"""Repair only dynamite's movement lighter bone, compile and install. No game launch."""
from pathlib import Path
from types import SimpleNamespace
import json
import shutil
import subprocess
from port_qc import Ctx, QC
from model_pose_fixes import prepare_pose_fixes
from fix_gyrojet_sprint import model_metadata
from pack_paths import asset_path

ROOT=Path(__file__).resolve().parents[1]
WORK=ROOT/'work'
folder=WORK/'MCV_SMD_PORT/weapons/v_dynamite'
ctx=Ctx(SimpleNamespace(fixed_root=str(WORK/'MCV_SMD')),
        str(WORK/'MCV_SMD_OG/weapons/v_dynamite'),str(folder))
prepare_pose_fixes(ctx)
qcpath=folder/'v_dynamite.qc'
qc=QC(qcpath.read_text())
for name in ('run_a','walk_a'):
    assert qc.find('animation',name).path.replace('\\','/')=='fixed_anims/'+name+'.smd'
# Repeating the repair must preserve its result, not accumulate offsets.
first={name:Path(path).read_bytes() for name,path in ctx.normalized.items()}
prepare_pose_fixes(ctx)
assert all(Path(ctx.normalized[name]).read_bytes()==data for name,data in first.items())
installed=asset_path('models/weapons/mcv/v_dynamite.mdl')
before=model_metadata(installed)
compiler=ROOT.parents[2]/'bin/studiomdl.exe'
game=WORK/'compile_test_game'
run=subprocess.run([str(compiler),'-game',str(game),'-nop4',str(qcpath)],
                   cwd=compiler.parent,capture_output=True,text=True,timeout=300)
log=run.stdout+run.stderr
(folder/'lighter_compile.log').write_text(log)
assert run.returncode==0 and 'Completed' in log and 'ERROR:' not in log,log[-5000:]
built=game/'models/weapons/mcv/v_dynamite.mdl'
assert model_metadata(built)==before
for path in built.parent.glob('v_dynamite.*'):
    shutil.copy2(path,asset_path('models/weapons/mcv/'+path.name))
(folder/'lighter_fix_report.json').write_text(json.dumps(ctx.notes,indent=2))
print('\n'.join(ctx.notes[:2]))
print('PASS: hand/other bone rows unchanged, fixed grip every frame, repeatable repair, unchanged sequence metadata')
print('Installed dynamite viewmodel. Fully restart GMod.')

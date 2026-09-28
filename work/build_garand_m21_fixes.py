"""Patch only the affected sequence references, then compile the two models."""
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import json
import shutil
import subprocess
import sys
from model_pose_fixes import restore_reload_rig

here=Path(__file__).resolve().parent
addon=here.parent
out=here/'garand_m21_fix'
out.mkdir(exist_ok=True)
models=['w_m1g_s','v_m21']
for model in models:
    if model == 'w_m1g_s':
        # The later complete hand-rig correction supersedes the angle-only patch.
        subprocess.run([sys.executable, str(here/'port_qc.py'),
            str(here/'MCV_SMD_OG/weapons'/model)], check=True)
        continue
    folder=here/'MCV_SMD_PORT/weapons'/model
    qc=folder/(model+'.qc')
    backup=out/(model+'.before.qc')
    if not backup.exists(): shutil.copy2(qc,backup)
    text=qc.read_text()
    names=['reload_empty','reload_empty_2']
    for name in names:
        original=here/'MCV_SMD_OG/weapons'/model/(model+'_anims')/(name+'.smd')
        dest=folder/'fixed_anims'/(name+'.smd')
        source=here/'MCV_SMD/weapons/v_m21/anims'/(name+'.smd')
        restore_reload_rig(source,original,dest)
        old='../../../MCV_SMD/weapons/v_m21/anims/'+name+'.smd'
        new='fixed_anims/'+name+'.smd'
        assert old.replace('/','\\') in text or new.replace('/','\\') in text
        text=text.replace(old.replace('/','\\'),new.replace('/','\\'))
    qc.write_text(text)

compiler=addon.parents[2]/'bin/studiomdl.exe'
scratch=here/'compile_test_game'
def build(model):
    qc=here/'MCV_SMD_PORT/weapons'/model/(model+'.qc')
    run=subprocess.run([str(compiler),'-game',str(scratch),'-nop4',str(qc)],cwd=compiler.parent,capture_output=True,text=True,timeout=240)
    output=run.stdout+run.stderr
    (out/(model+'.log')).write_text(output)
    assert run.returncode==0 and 'Completed' in output and 'ERROR:' not in output, output[-4000:]
    outputs=[]
    for path in (scratch/'models/weapons/mcv').glob(model+'.*'):
        destination=addon/'models/weapons/mcv'/path.name
        backup=out/'before_models'/path.name
        backup.parent.mkdir(exist_ok=True)
        if not backup.exists(): shutil.copy2(destination,backup)
        shutil.copy2(path,destination)
        outputs.append(path.name)
    print(model,'compiled and installed',flush=True)
    return dict(model=model,ok=True,outputs=outputs)
with ThreadPoolExecutor(max_workers=2) as pool:
    result=list(pool.map(build,models))
(out/'build.json').write_text(json.dumps(result,indent=2)+'\n')

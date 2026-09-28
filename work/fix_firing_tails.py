"""Repair reviewed firing tails without regenerating QCs; --compile installs both packs."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
from types import SimpleNamespace
import numpy as np
from bake_ik import load_smd
from model_pose_fixes import FIRING_TAIL_FIXES, prepare_pose_fixes, firing_tail_source
from port_qc import Ctx, QC
from pack_paths import ROOT, asset_path
from fix_gyrojet_sprint import model_metadata
from check_deploy_layers import sequences

WORK=ROOT/'work'
OUT=WORK/'firing_audit'
def digest(p): return hashlib.sha256(p.read_bytes()).hexdigest()

def prepare(model):
    path=WORK/f'MCV_SMD_PORT/weapons/{model}/{model}.qc'
    backup=OUT/'before_qc'/path.name
    backup.parent.mkdir(parents=True,exist_ok=True)
    if not backup.exists(): shutil.copy2(path,backup)
    raw=path.read_text()
    qc=QC(raw)
    ctx=Ctx(SimpleNamespace(fixed_root=str(WORK/'MCV_SMD')),
            str(WORK/'MCV_SMD_OG/weapons'/model), str(path.parent))
    sources={name:firing_tail_source(ctx,name) for name in FIRING_TAIL_FIXES[model]}
    hashes={name:digest(source) for name,source in sources.items()}
    prepare_pose_fixes(ctx)
    report={}
    for name, source in sources.items():
        fixed=Path(ctx.resolve_smd(model+'_anims/'+name))
        assert fixed != source and digest(source)==hashes[name]
        nodes, frames, _=load_smd(source)
        newnodes, newframes, _=load_smd(fixed)
        assert nodes==newnodes and len(frames)==len(newframes)
        for old,new in zip(frames[:-1],newframes[:-1]):
            assert all(np.array_equal(old[i],new[i]) for i in old)
        assert all(np.array_equal(newframes[-1][i],newframes[-2][i]) for i in nodes)
        block=qc.find('animation',name[:-4])
        assert block
        oldpath=block.path
        newpath='fixed_anims\\'+name
        if oldpath != newpath:
            token='"'+oldpath+'"'
            assert raw.count(token)==1, (model,name)
            raw=raw.replace(token,'"'+newpath+'"',1)
        report[name]={'frames':len(frames),'source':str(source.relative_to(ROOT)),
                      'source_sha256':hashes[name],'fixed_sha256':digest(fixed)}
    path.write_text(raw,encoding='utf-8',newline='\n')
    return path,report

def compile_install(model,path):
    installed=asset_path(f'models/weapons/mcv/{model}.mdl')
    before=model_metadata(installed)
    layers=sequences(installed)
    compiler=ROOT.parents[2]/'bin/studiomdl.exe'
    run=subprocess.run([str(compiler),'-game',str(WORK/'compile_test_game'),'-nop4',str(path)],
                       cwd=compiler.parent,capture_output=True,text=True,timeout=180)
    log=run.stdout+run.stderr
    (OUT/(model+'.log')).write_text(log)
    assert run.returncode==0 and 'Completed' in log and 'ERROR:' not in log, log[-3000:]
    built=WORK/f'compile_test_game/models/weapons/mcv/{model}.mdl'
    assert model_metadata(built)==before, (model,'timings/activities/events changed')
    assert sequences(built)==layers, (model,'layers changed')
    files=[built.with_suffix(ext) for ext in ('.mdl','.vvd','.dx80.vtx','.dx90.vtx')]
    assert all(p.is_file() and p.stat().st_size for p in files)
    installed_hashes={}
    for file in files:
        dest=asset_path('models/weapons/mcv/'+file.name)
        shutil.copy2(file,dest)
        assert digest(file)==digest(dest)
        installed_hashes[str(dest)]=digest(dest)
    return installed_hashes

if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compile',action='store_true')
    args=parser.parse_args()
    OUT.mkdir(exist_ok=True)
    results={}
    for model in FIRING_TAIL_FIXES:
        path,tracks=prepare(model)
        results[model]={'tracks':tracks}
        if args.compile: results[model]['installed']=compile_install(model,path)
        print(model, 'compiled/installed' if args.compile else 'prepared',flush=True)
        (OUT/'build.json').write_text(json.dumps(results,indent=2)+'\n')

"""Compile the user's M635 with standard-grip CAR-15 / 30-round animations."""
import argparse
import json
from pathlib import Path
import re
import shutil
import subprocess
import numpy as np
from bake_ik import load_smd, fk
from pack_paths import asset_path
from build_xm16super import HERE, ROOT, PORT, SCRATCH, relative, rebase, worldmodel, icon

SOURCE = HERE / 'MCV_SMD/weapons/v_m635/m635.smd'

def viewmodel():
    source_nodes, source_frames, _ = load_smd(SOURCE)
    dn, df, _ = load_smd(HERE/'MCV_SMD_OG/weapons/v_car15/RefCAR15_new.smd')
    actual, expected = fk(source_nodes,source_frames[0]), fk(dn,df[0])
    names = {name:i for i,(name,_) in dn.items()}
    for i,(name,_) in source_nodes.items():
        if name in names:
            assert np.max(np.abs(actual[i]-expected[names[name]])) < .001, 'changed bind: '+name
    out = PORT/'v_m635'
    out.mkdir(parents=True,exist_ok=True)
    donor=PORT/'v_car15'
    text=rebase((donor/'v_car15.qc').read_text(),donor,out)
    text=re.sub(r'^// Generated[^\n]*','// KEEP: M635; rebuild with work/build_m635.py',text,count=1)
    text=text.replace('weapons/mcv/v_car15.mdl','weapons/mcv/v_m635.mdl')
    text=re.sub(r'\$bodygroup\s+"[^"\n]+"\s*\{[^}]*\}\s*','',text)
    text=text.replace('$surfaceprop','$bodygroup "studio"\n{\n\tstudio "'+relative(SOURCE,out)+'"\n}\n\n$surfaceprop',1)
    # Both XM177/CAR-15 QCs have Base -23.5, 0, 1; shorten by seven units.
    text=text.replace('$attachment "muzzle" "Base" -23.5','$attachment "muzzle" "Base" -16.5')
    text=text.replace('$cdmaterials "models\\weapons\\mcv\\shells\\"', '$cdmaterials "models\\weapons\\mcv\\shells\\"\n$cdmaterials "models\\weapons\\mcv\\v_uzi\\"')
    text=text.replace('$surfaceprop', '$cdmaterials "models/weapons/mcv/v_m601/"\n\n$surfaceprop',1)
    # Keep the 30-round animation's event timing, using M76 recordings.
    text=text.replace('MCV_Weapon_Foley_M16A1','MCV_Weapon_Foley_SWM76')
    text=text.replace('MCV_Weapon_Foley_SWM76.DrawMetalStart','MCV_Weapon_Foley_SWM76_Reload.Metal')
    text=text.replace('MCV_Weapon_Foley_SWM76.DrawMetalEnd','MCV_Weapon_Foley_SWM76_Reload.HandEnd')
    text=text.replace('MCV_Weapon_Foley_SWM76_Reload.MetalStart','MCV_Weapon_Foley_SWM76_Reload.Metal')
    text=text.replace('MCV_Weapon_Foley_SWM76_Reload.MetalEnd','MCV_Weapon_Foley_SWM76_Reload.HandEnd')
    # The Uzi magazine seats sooner: sound only, 15 frames at 30 FPS.
    text=text.replace('event 5004 44 "MCV_Weapon_Foley_SWM76_Reload.MagIn"',
                      'event 5004 29 "MCV_Weapon_Foley_SWM76_Reload.MagIn"')
    qc=out/'v_m635.qc'
    qc.write_text(text)
    return qc

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--install',action='store_true')
    args=parser.parse_args()
    compiler=ROOT.parents[2]/'bin/studiomdl.exe'
    logs=HERE/'m635_build'; logs.mkdir(exist_ok=True)
    qcs=[viewmodel(),worldmodel(SOURCE,'m635',-16.5,False)]
    # Give this compact gun a compact collision mesh as well.
    qc=qcs[1]; text=qc.read_text()
    text=text.replace('$surfaceprop', '$cdmaterials "models/weapons/mcv/v_m601/"\n\n$surfaceprop',1)
    model=qc.parent/'m635_world.smd'
    header,mesh=model.read_text().split('triangles\n',1)
    lines=mesh.splitlines()
    xyz=np.array([list(map(float,lines[i+j].split()[1:4])) for i in range(0,len(lines)-1,4) for j in (1,2,3)])
    lo,hi=xyz.min(axis=0),xyz.max(axis=0)
    corners=np.array([[a,b,c] for a in (lo[0],hi[0]) for b in (lo[1],hi[1]) for c in (lo[2],hi[2])])
    faces=[(0,2,3),(0,3,1),(4,5,7),(4,7,6),(0,1,5),(0,5,4),(2,6,7),(2,7,3),(0,4,6),(0,6,2),(1,3,7),(1,7,5)]
    collision=[header.rstrip(),'triangles']
    for face in faces:
        normal=np.cross(corners[face[1]]-corners[face[0]],corners[face[2]]-corners[face[0]])
        normal/=np.linalg.norm(normal)
        collision.append('m16a1')
        for i in face: collision.append('0 '+' '.join(f'{v:.7f}' for v in [*corners[i],*normal,0,0])+' 1 0 1')
    collision.append('end')
    (qc.parent/'m635_collision.smd').write_text('\n'.join(collision)+'\n')
    text=re.sub(r'\$collisionmodel "[^"]+"','$collisionmodel "m635_collision.smd"',text)
    text=re.sub(r'^\s*\$concave\s*$', '', text, flags=re.M)
    text=re.sub(r'^\s*\$maxconvexpieces[^\n]*$', '', text, flags=re.M)
    text=text.replace('$mass 8', '$mass 2.61')
    text=re.sub(r'\$bbox[^\n]*','$bbox '+' '.join(f'{v:.6f}' for v in [*lo,*hi]),text)
    qc.write_text(text)
    results=[]
    for qc in qcs:
        result=subprocess.run([str(compiler),'-game',str(SCRATCH),'-nop4',str(qc)],cwd=compiler.parent,capture_output=True,text=True,timeout=300)
        output=result.stdout+result.stderr
        (logs/(qc.stem+'.log')).write_text(output)
        if result.returncode or 'Completed' not in output: raise RuntimeError(output[-6000:])
        files=sorted((SCRATCH/'models/weapons/mcv').glob(qc.stem+'.*'))
        if args.install:
            for p in files: shutil.copy2(p,asset_path('models/weapons/mcv/'+p.name))
        results.append({'model':qc.stem,'files':[p.name for p in files],'installed':args.install})
        print(qc.stem,'compiled',len(files),'files',flush=True)
    if args.install: icon(SOURCE,'m635')
    (logs/'build.json').write_text(json.dumps(results,indent=2)+'\n')

if __name__=='__main__': main()

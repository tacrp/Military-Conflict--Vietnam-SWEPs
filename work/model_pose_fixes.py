"""Targeted animation-rig corrections; original and hand-edited SMDs stay intact."""
from pathlib import Path
import shutil
import numpy as np
from bake_ik import load_smd, fk, euler


def m21_reload_rig(source, original, output):
    nodes, frames, _ = load_smd(source)
    target_nodes, reference, _ = load_smd(original)
    if nodes == target_nodes:
        output=Path(output)
        output.parent.mkdir(parents=True,exist_ok=True)
        shutil.copy2(source,output)
        return str(output)
    byname = {name:i for i,(name,_) in nodes.items()}
    assert set(name for name,_ in target_nodes.values())-set(byname)=={'BaseRoot'}
    assert len(frames)==len(reference)
    lines=['version 1','nodes']
    lines += [f'{i} "{name}" {parent}' for i,(name,parent) in target_nodes.items()]
    lines += ['end','skeleton']
    for index, pose in enumerate(frames):
        old_world=fk(nodes,pose)
        ref_world=fk(target_nodes,reference[index])
        world={i:old_world[byname[name]] if name in byname else ref_world[i]
               for i,(name,_) in target_nodes.items()}
        lines.append(f'time {index}')
        rebuilt={}
        for i,(name,parent) in target_nodes.items():
            matrix=np.linalg.inv(world[parent])@world[i] if parent!=-1 else world[i]
            row=np.r_[matrix[:3,3],euler(matrix[:3,:3])]
            rebuilt[i]=row
            lines.append(f'{i} '+' '.join(f'{v:.9f}' for v in row))
        actual=fk(target_nodes,rebuilt)
        assert max(np.max(np.abs(actual[i]-world[i])) for i in world)<1e-5
    lines += ['end']
    output=Path(output)
    output.parent.mkdir(parents=True,exist_ok=True)
    output.write_text('\n'.join(lines)+'\n')
    return str(output)


def prepare_pose_fixes(ctx):
    """Register fixed paths before the port writes sequence paths into the QC."""
    original=Path(ctx.og_dir)
    fixed=Path(ctx.fixed_dir)
    if ctx.name=='v_m21':
        for name in ['reload_empty.smd','reload_empty_2.smd']:
            source=Path(ctx.override_dir)/name
            if source.exists():
                ctx.normalized[name]=m21_reload_rig(source,original/'v_m21_anims'/name,fixed/name)
        ctx.note('M21 empty reload: restore BaseRoot hierarchy without moving the edited poses')

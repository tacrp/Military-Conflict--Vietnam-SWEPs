"""Targeted animation-rig corrections; original and hand-edited SMDs stay intact."""
from pathlib import Path
import shutil
import numpy as np
from bake_ik import load_smd, fk, euler, final_pose, rmat, write_rows


def dynamite_lighter(source, idle, corrective, output):
    """Keep the lighter in the authored left-hand grip; don't re-solve the arms."""
    nodes, frames, lines = load_smd(source)
    base_nodes, bases, _ = load_smd(idle)
    assert nodes == base_nodes
    ids = {name:i for i,(name,_) in nodes.items()}
    lighter, hand = ids['Object001'], ids['hand_l']
    assert nodes[lighter][1] == -1
    base = bases[0]
    ref = {i:np.zeros(6) for i in nodes}
    ref.update(load_smd(corrective)[1][0])
    wb = fk(nodes, base)
    grip = np.linalg.inv(wb[hand]) @ wb[lighter]
    rows = {}
    before = []
    for fi, frame in enumerate(frames):
        world = fk(nodes, final_pose(nodes, base, ref, frame))
        held = np.linalg.inv(world[hand]) @ world[lighter]
        before.append(float(np.linalg.norm(held[:3,3]-grip[:3,3])))
        want = world[hand] @ grip
        rotation = rmat(ref[lighter][3:]) @ (rmat(base[lighter][3:]).T @ want[:3,:3])
        position = ref[lighter][:3] + want[:3,3] - base[lighter][:3]
        rows[fi,lighter] = np.r_[position,euler(rotation)]
    Path(output).parent.mkdir(parents=True, exist_ok=True)
    write_rows(lines, rows, str(output))
    _, repaired, _ = load_smd(output)
    errors = []
    for old, new in zip(frames, repaired):
        assert all(np.array_equal(old[i], new[i]) for i in nodes if i != lighter)
        world = fk(nodes, final_pose(nodes, base, ref, new))
        held = np.linalg.inv(world[hand]) @ world[lighter]
        errors.append(float(np.max(np.abs(held-grip))))
    assert max(errors) < 0.0001
    return {'frames':len(frames), 'before_max_grip_distance':max(before),
            'after_max_grip_matrix_error':max(errors)}


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
    if ctx.name=='v_dynamite':
        animdir=original/'v_dynamite_anims'
        for name in ('run_a', 'walk_a'):
            source=Path(ctx.resolve_smd('v_dynamite_anims/'+name+'.smd'))
            corrective=Path(ctx.resolve_smd('v_dynamite_anims/'+name+'_corrective_animation.smd'))
            result=dynamite_lighter(source,animdir/'basePose_a.smd',corrective,fixed/(name+'.smd'))
            ctx.normalized[name+'.smd']=str(fixed/(name+'.smd'))
            ctx.note('Dynamite '+name+': lighter follows left hand; '+str(result))
    if ctx.name=='v_m21':
        for name in ['reload_empty.smd','reload_empty_2.smd']:
            source=Path(ctx.override_dir)/name
            if source.exists():
                ctx.normalized[name]=m21_reload_rig(source,original/'v_m21_anims'/name,fixed/name)
        ctx.note('M21 empty reload: restore BaseRoot hierarchy without moving the edited poses')

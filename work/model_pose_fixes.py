"""Targeted animation-rig corrections; original and hand-edited SMDs stay intact."""
from pathlib import Path
import shutil
import re
import numpy as np
from bake_ik import load_smd, fk, euler, final_pose, rmat, write_rows

# Reviewed rest-then-jump tails, found by audit_firing_tails.py. Preserve the
# original track length/timing, holding the already-settled penultimate pose.
FIRING_TAIL_FIXES = {
    **{name: ('shoot3_a.smd',) for name in (
        'v_hdm', 'v_highpower', 'v_m1911', 'v_mamba', 'v_mk22',
        'v_mle1935', 'v_tt33', 'v_vcpistol2')},
    'v_bar_l': ('shoot1d_ironsight_a.smd', 'shoot2d_ironsight_a.smd'),
}

def firing_tail_source(ctx, name):
    override = Path(ctx.override_dir)/name
    return override if override.exists() else Path(ctx.og_dir)/(ctx.name+'_anims')/name

def validate_firing_tails(qc, ctx, fire_acts):
    """Fail a port on a new firing track that leaves rest again on its last frame."""
    visited = set()
    def visit(name):
        if name in visited: return
        visited.add(name)
        block = qc.find('sequence',name) or qc.find('animation',name)
        if block and block.kind == 'sequence':
            for child in block.anims()+block.layers(): visit(child)
    for block in qc.blocks('sequence'):
        if block.activity() in fire_acts: visit(block.name)
    for block in qc.blocks('animation'):
        if block.name not in visited or not block.get('subtract'): continue
        # Counter/bolt-state and movement layers need not return to rest.
        if not block.name.startswith(('shoot','gren_shoot','gl_shoot')): continue
        if block.get('frame'): continue # pose-recoil samples intentionally hold a frame
        path = Path(ctx.out_dir)/block.path.replace('\\','/')
        corrective = qc.find('animation',re.search(r'"([^"]+)"',block.get('subtract')).group(1))
        refpath = Path(ctx.out_dir)/corrective.path.replace('\\','/') if corrective else None
        if not path.exists() or not refpath or not refpath.exists(): continue
        nodes, frames, _ = load_smd(path)
        if len(frames)<3: continue
        cnodes, refs, _ = load_smd(refpath)
        byname = {cnodes[i][0]:row for i,row in refs[0].items()}
        errors=[]
        for frame in frames[-2:]:
            pos=rot=0.
            for i,row in frame.items():
                base=byname.get(nodes[i][0],np.zeros(6))
                pos=max(pos,float(np.linalg.norm(row[:3]-base[:3])))
                rot=max(rot,float(np.degrees(np.arccos(np.clip((np.trace(rmat(row[3:]).T@rmat(base[3:]))-1)/2,-1,1)))))
            errors.append((pos,rot))
        if errors[0][0]<.01 and errors[0][1]<.1 and (errors[1][0]>.05 or errors[1][1]>1):
            raise ValueError(f'{ctx.name}/{block.name}: firing tail leaves settled pose; inspect {path}')


def restore_firing_tail(source, corrective, output):
    nodes, frames, lines = load_smd(source)
    cnodes, refs, _ = load_smd(corrective)
    reference = {cnodes[i][0]: row for i,row in refs[0].items()}
    assert len(frames) >= 3
    # Refuse to silently flatten newly authored motion if the source changes.
    for i, row in frames[-2].items():
        rest = reference.get(nodes[i][0], np.zeros(6))
        assert np.linalg.norm(row[:3]-rest[:3]) < .01, source
        angle = np.degrees(np.arccos(np.clip((np.trace(rmat(row[3:]).T@rmat(rest[3:]))-1)/2,-1,1)))
        assert angle < .1, (source, nodes[i][0], angle)
    rows = {(len(frames)-1, i): row for i,row in frames[-2].items()}
    Path(output).parent.mkdir(parents=True, exist_ok=True)
    write_rows(lines, rows, str(output))
    return str(output)


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


def restore_reload_rig(source, original, output):
    """Restore BaseRoot to an older hand edit without changing any existing pose."""
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
    for name in FIRING_TAIL_FIXES.get(ctx.name, ()):
        source = firing_tail_source(ctx, name)
        corrective = Path(ctx.resolve_smd(ctx.name + '_anims/' + name.replace('.smd', '_corrective_animation.smd')))
        ctx.normalized[name] = restore_firing_tail(source, corrective, fixed/name)
        ctx.note(ctx.name + '/' + name + ': hold settled firing tail; retain all frames and timing')
    if ctx.name=='v_dynamite':
        animdir=original/'v_dynamite_anims'
        for name in ('run_a', 'walk_a'):
            source=Path(ctx.resolve_smd('v_dynamite_anims/'+name+'.smd'))
            corrective=Path(ctx.resolve_smd('v_dynamite_anims/'+name+'_corrective_animation.smd'))
            result=dynamite_lighter(source,animdir/'basePose_a.smd',corrective,fixed/(name+'.smd'))
            ctx.normalized[name+'.smd']=str(fixed/(name+'.smd'))
            ctx.note('Dynamite '+name+': lighter follows left hand; '+str(result))
    reloads = {'v_m21': ('reload_empty.smd', 'reload_empty_2.smd'),
               'v_cobra': ('reload.smd',)}
    if ctx.name in reloads:
        for name in reloads[ctx.name]:
            source=Path(ctx.override_dir)/name
            if source.exists():
                ctx.normalized[name]=restore_reload_rig(source,original/(ctx.name+'_anims')/name,fixed/name)
        ctx.note(ctx.name+' reload: restore BaseRoot hierarchy without moving the edited poses')

"""Normalize the three world rigs which already contain an MCV player hand.

Keep the original world meshes, all LODs, materials, bodygroups and attachments.
Rebase their vertices into the same weapon frame as the other ports, then supply
a GMod hand root. Original/decompiled files are never edited.
"""
from pathlib import Path
import json
import re
import numpy as np
from bake_ik import load_smd, fk, local_mat, euler
from derive_hand_offsets import load_prefixes, def_from, def_to, HAND_AK
from world_model_contact import pitch_about_finger, contact_pivot

HERE = Path(__file__).resolve().parent
PREFIXES = {'w_m1g_s': 'sksm1g', 'w_lpo50': 'lpo50', 'w_m9a1': 'm9a1'}
CANONICAL = local_mat(np.array([0, 0, -0.064417, np.pi / 2, 0, 0]))
GUN = 'MCV.weapon_bone'


def prepare_nested_world(qc, ctx):
    if ctx.name not in PREFIXES:
        return
    original = Path(ctx.og_dir)
    text = (original / (ctx.name + '.qc')).read_text()
    paths = list(dict.fromkeys(re.findall(r'"([^"\n]+\.smd)"', text, re.I)))
    reference = original / paths[0].replace('\\', '/')
    nodes, frames, _ = load_smd(reference)
    gun = next(i for i, (n, _) in nodes.items() if n.lower() == 'valvebiped.weapon_bone')
    keep = [gun] + [i for i, (_, p) in nodes.items() if p == gun]
    assert all(i in keep or i < gun for i in nodes)
    remap = {old: new for new, old in enumerate(keep)}
    names = {i: GUN if i == gun else nodes[i][0].replace('ValveBiped.', 'MCV.') for i in keep}
    bind = fk(nodes, frames[0])
    transform = CANONICAL @ np.linalg.inv(bind[gun])
    _, idle, _ = load_smd(original / (ctx.name + '_anims/idle.smd'))
    idle_gun = local_mat(idle[0][gun])
    out = Path(ctx.fixed_dir) / 'world_rig'
    out.mkdir(parents=True, exist_ok=True)
    metrics, bounds = [], []
    for relative in paths:
        source = original / relative.replace('\\', '/')
        ns, poses, lines = load_smd(source)
        assert ns == nodes, source
        mesh = 'triangles' in lines
        result = ['version 1', 'nodes']
        for old in keep:
            result.append(f'{remap[old]} "{names[old]}" {remap[nodes[old][1]] if old != gun else -1}')
        result += ['end', 'skeleton']
        for t, pose in enumerate(poses):
            result.append(f'time {t}')
            for old in keep:
                if old == gun:
                    matrix = CANONICAL if mesh else CANONICAL @ np.linalg.inv(idle_gun) @ local_mat(pose[old])
                    row = np.r_[matrix[:3, 3], euler(matrix[:3, :3])]
                else:
                    row = pose[old]
                result.append(f'{remap[old]} ' + ' '.join(f'{v:.9f}' for v in row))
        result.append('end')
        count = 0
        if mesh:
            result.append('triangles')
            for line in lines[lines.index('triangles') + 1:]:
                parts = line.split()
                if not parts or parts[0] == 'end':
                    continue
                if len(parts) < 9:
                    result.append(line) # material
                    continue
                point = np.array([float(x) for x in parts[1:4]])
                normal = np.array([float(x) for x in parts[4:7]])
                new_point = (transform @ np.r_[point, 1])[:3]
                new_normal = transform[:3, :3] @ normal
                assert np.max(np.abs(np.linalg.inv(CANONICAL) @ np.r_[new_point, 1] - np.linalg.inv(bind[gun]) @ np.r_[point, 1])) < 1e-5
                is_physics = source.stem.endswith('_physics')
                old = int(parts[0])
                assert old in remap or is_physics, (source, old)
                parts[0] = str(remap.get(old, 0))
                parts[1:7] = [f'{v:.9f}' for v in np.r_[new_point, new_normal]]
                if len(parts) > 9:
                    for index in range(10, 10 + int(parts[9]) * 2, 2):
                        assert int(parts[index]) in remap or is_physics
                        parts[index] = str(remap.get(int(parts[index]), 0))
                result.append(' '.join(parts))
                if not is_physics: bounds.append(new_point)
                count += 1
            result.append('end')
        destination = out / source.name
        destination.write_text('\n'.join(result) + '\n')
        ctx.normalized[source.name] = str(destination)
        metrics.append({'file': relative, 'triangles': count // 3, 'frames': len(poses)})

    prefixes = load_prefixes(str(HERE / 'rip/player_rig'))
    calibration = np.asarray(def_from(HAND_AK)) @ np.asarray(prefixes['rifle'][0])
    hand = def_to((calibration @ np.linalg.inv(np.asarray(prefixes[PREFIXES[ctx.name]][0]))).tolist())
    # Same barrel pitch and measured finger-preserving adjustment as other rifles.
    hand = pitch_about_finger(hand, 12.956, contact_pivot('ar2'))
    definitions = ['$definebone "ValveBiped.Bip01_R_Hand" "" ' + ' '.join(f'{x:.9f}' for x in hand) + ' 0 0 0 0 0 0']
    for old in keep:
        parent = 'ValveBiped.Bip01_R_Hand' if old == gun else names[nodes[old][1]]
        matrix = CANONICAL if old == gun else local_mat(frames[0][old])
        definitions.append(f'$definebone "{names[old]}" "{parent}" ' + ' '.join(f'{x:.9f}' for x in def_to(matrix.tolist())) + ' 0 0 0 0 0 0')
    first = True
    def replace_definition(match):
        nonlocal first
        if not first: return ''
        first = False
        return '\n'.join(definitions)
    qc.raw_sub(r'^\$definebone[^\n]*', replace_definition, flags=re.M)
    for old in keep:
        qc.raw_sub(re.escape('"' + nodes[old][0] + '"'), '"' + names[old] + '"')
    if bounds:
        points = np.array(bounds)
        qc.raw_sub(r'^\$bbox[^\n]*', '$bbox ' + ' '.join(f'{x:.6f}' for x in np.r_[points.min(0), points.max(0)]), flags=re.M)
    (out / 'manifest.json').write_text(json.dumps({'model': ctx.name, 'prefix': PREFIXES[ctx.name], 'hand': hand, 'sources': metrics}, indent=2) + '\n')
    ctx.note('Normalized original world mesh/LODs to a GMod hand; private gun bone prevents NPC bonemerge overrides')

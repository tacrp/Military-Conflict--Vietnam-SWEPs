"""Restore X2F2A2's missing ADS empty reload; never launches the game.

python work/fix_x2f2a2_reload.py --compile
The retained override is automatically preferred by future port_qc.py runs.
"""
import argparse
import hashlib
import json
from pathlib import Path
import re
import shutil
import subprocess

import numpy as np
from bake_ik import load_smd, rmat, euler
from fix_gyrojet_sprint import model_metadata
from check_deploy_layers import sequences
from pack_paths import ROOT, asset_path
import port_qc

WORK = ROOT / 'work'
MODEL = 'v_x2f2a2'
OUT = WORK / 'x2f2a2_reload'
QC = WORK / f'MCV_SMD_PORT/weapons/{MODEL}/{MODEL}.qc'
OVERRIDE = WORK / f'MCV_SMD/weapons/{MODEL}/anims/reload_empty_2.smd'


def original(model, name):
    return WORK / f'MCV_SMD_OG/weapons/{model}/{model}_anims/{name}.smd'


def fractional_rotation(matrix, weight):
    """Shortest-axis interpolation of the small resting-grip correction."""
    angle = np.arccos(np.clip((np.trace(matrix) - 1) / 2, -1, 1))
    if angle < 1e-8:
        return np.eye(3)
    assert angle < np.pi - 0.001
    skew = (matrix - matrix.T) / (2 * np.sin(angle))
    return np.eye(3) + np.sin(angle * weight) * skew + (1 - np.cos(angle * weight)) * (skew @ skew)


def prepare():
    nodes, hip, _ = load_smd(original(MODEL, 'reload_empty'))
    donor_nodes, donor_hip, _ = load_smd(original('v_l1a1', 'reload_empty'))
    donor_ids = {name: i for i, (name, _) in donor_nodes.items()}
    mapping = {i: donor_ids[name] for i, (name, _) in nodes.items()}
    for i, j in mapping.items():
        parent = nodes[i][1]
        assert donor_nodes[j][1] == (-1 if parent == -1 else mapping[parent])
    assert len(hip) == len(donor_hip) == 115
    assert all(np.array_equal(a[i], b[j]) for a, b in zip(hip, donor_hip) for i, j in mapping.items())
    _, donor, _ = load_smd(original('v_l1a1', 'reload_empty_2'))
    target_nodes, target_rest, _ = load_smd(original(MODEL, 'reload_2'))
    _, donor_rest, _ = load_smd(original('v_l1a1', 'reload_2'))
    assert nodes == target_nodes and len(donor) == len(hip)

    # Both rifles share the complete hip reload and compatible bone parents.
    # Retarget the complete donor ADS motion by NAME (L1A1 has an extra Bayonet).
    # Ease from/to X2F2A2's authored aiming grip over the first/last 15 frames;
    # leave the magazine insertion and charging-handle motion untouched.
    # Derive the correction from loaded reloads so the empty round stays hidden.
    frames = []
    for index, pose in enumerate(donor):
        edge = min(index, len(donor) - 1 - index)
        t = min(edge / 15, 1)
        weight = 1 - t * t * (3 - 2 * t)
        endpoint = 0 if index < len(donor) / 2 else -1
        result = {}
        for i, j in mapping.items():
            row = pose[j].copy()
            if weight > 0:
                target, reference = target_rest[endpoint][i], donor_rest[endpoint][j]
                row[:3] += (target[:3] - reference[:3]) * weight
                delta = rmat(target[3:]) @ rmat(reference[3:]).T
                row[3:] = euler(fractional_rotation(delta, weight) @ rmat(row[3:]))
            result[i] = row
        frames.append(result)

    lines = ['version 1', 'nodes']
    lines += [f'{i} "{name}" {parent}' for i, (name, parent) in nodes.items()]
    lines += ['end', 'skeleton']
    for index, pose in enumerate(frames):
        lines.append(f'time {index}')
        lines.extend(f'{i} ' + ' '.join(f'{v:.9f}' for v in pose[i]) for i in nodes)
    OVERRIDE.parent.mkdir(parents=True, exist_ok=True)
    OVERRIDE.write_text('\n'.join(lines) + '\nend\n', encoding='utf-8')
    written_nodes, written, _ = load_smd(OVERRIDE)
    assert written_nodes == nodes and len(written) == 115
    for i, (name, _) in nodes.items():
        for endpoint in (0, -1):
            if endpoint == 0 and name == 'Bullet':
                continue  # Empty magazine, unlike the tactical reload reference.
            assert np.max(np.abs(written[endpoint][i][:3] - target_rest[endpoint][i][:3])) < 1e-4
            assert np.max(np.abs(rmat(written[endpoint][i][3:]) - rmat(target_rest[endpoint][i][3:]))) < 1e-4
        for index in range(15, 100):
            assert np.max(np.abs(written[index][i] - donor[index][mapping[i]])) < 1e-8

    text = QC.read_text(encoding='utf-8')
    old = f'../../../MCV_SMD_OG/weapons/{MODEL}/{MODEL}_anims/reload_empty_2.smd'.replace('/', '\\')
    new = f'../../../MCV_SMD/weapons/{MODEL}/anims/reload_empty_2.smd'.replace('/', '\\')
    assert text.count(old) + text.count(new) == 1
    if old in text:
        QC.write_text(text.replace(old, new, 1), encoding='utf-8', newline='\n')
    return {'frames': len(written), 'bones': len(nodes), 'duration_seconds': 114 / 30,
            'donor': 'v_l1a1/reload_empty_2', 'grip_transition_frames': 15}


def compile_install(report):
    installed = asset_path(f'models/weapons/mcv/{MODEL}.mdl')
    before = model_metadata(installed)
    layers = sequences(installed)
    text = QC.read_text(encoding='utf-8')
    if not any(a[0].startswith('mcv_safe_') for a in before['animations']):
        # This rifle's safety bake exists in the source QC but has not shipped.
        # Build a copy with its installed safety sequences, preserving the pending
        # source work and avoiding an unrelated movement change in this repair.
        backup = port_qc.QC((WORK / f'safety_rollout/before_qc/{MODEL}.qc').read_text())
        parsed = port_qc.QC(text)
        for block in parsed.blocks('animation'):
            if block.name.startswith('mcv_safe_'):
                assert block.render() in text
                text = text.replace(block.render(), '', 1)
        for name in ('idletonearwall', 'nearwall', 'nearwalltoidle'):
            block = parsed.find('sequence', name)
            assert block.render() in text
            text = text.replace(block.render(), backup.find('sequence', name).render(), 1)
    # Retain the exact build QC beside the report, with paths anchored to source.
    def absolute_source(match):
        path = (QC.parent / match.group(1).replace('\\', '/')).resolve()
        assert path.is_file(), path
        return '"' + path.as_posix() + '"'
    text = re.sub(r'"([^"\r\n]+\.(?:smd|qci))"', absolute_source, text, flags=re.I)
    compile_qc = OUT / (MODEL + '.qc')
    compile_qc.write_text(text, encoding='utf-8', newline='\n')
    compiler = ROOT.parents[2] / 'bin/studiomdl.exe'
    run = subprocess.run([str(compiler), '-game', str(WORK / 'compile_test_game'), '-nop4', str(compile_qc)],
                         cwd=compiler.parent, capture_output=True, text=True, timeout=180)
    log = run.stdout + run.stderr
    (OUT / 'compile.log').write_text(log, encoding='utf-8')
    assert run.returncode == 0 and 'Completed' in log and 'ERROR:' not in log, log[-4000:]
    built = WORK / f'compile_test_game/models/weapons/mcv/{MODEL}.mdl'
    after = model_metadata(built)
    assert before['sequences'] == after['sequences'], 'sequence/activity/event changed'
    assert layers == sequences(built), 'animation layers changed'
    assert len(before['animations']) == len(after['animations'])
    for a, b in zip(before['animations'], after['animations']):
        if a[0] == '@reload_empty':
            assert a[:3] == b[:3] and b[3] == 115 and a[3] in (1, 115)
        else:
            assert a == b, (a, b)
    empty = [a for a in after['animations'] if a[0] == '@reload_empty']
    assert len(empty) == 2 and all(a[1] == 30 and a[3] == 115 for a in empty)
    report['compiled_reload_before'] = [a for a in before['animations'] if 'reload' in a[0]]
    report['compiled_reload_after'] = [a for a in after['animations'] if 'reload' in a[0]]

    companions = [built.with_suffix(ext) for ext in ('.mdl', '.vvd', '.dx90.vtx', '.dx80.vtx')]
    assert all(p.is_file() and p.stat().st_size for p in companions)
    report['installed'] = {}
    for source in companions:
        destination = asset_path('models/weapons/mcv/' + source.name)
        assert destination.parent == installed.parent
        shutil.copy2(source, destination)
        digest = hashlib.sha256(source.read_bytes()).hexdigest()
        assert hashlib.sha256(destination.read_bytes()).hexdigest() == digest
        report['installed'][source.name] = digest


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compile', action='store_true')
    args = parser.parse_args()
    OUT.mkdir(exist_ok=True)
    report = prepare()
    if args.compile:
        compile_install(report)
        (OUT / 'build.json').write_text(json.dumps(report, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(report, indent=2))


if __name__ == '__main__':
    main()

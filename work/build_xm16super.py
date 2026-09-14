"""Build the user's XM16 Super mesh with the ported M203 animation rig.

Leaves the input mesh and donor models untouched. --install copies only this
weapon's compiled outputs from the scratch game into the addon.
"""
import argparse
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import numpy as np
from bake_ik import load_smd, fk

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
SOURCE = HERE / 'MCV_SMD/weapons/v_xm16super/xm16super.smd'
PORT = HERE / 'MCV_SMD_PORT/weapons'
SCRATCH = HERE / 'compile_test_game'


def relative(path, directory):
    return os.path.relpath(path, directory).replace('\\', '/')


def rebase(text, source, destination):
    def replace(m):
        return '"' + relative((source / m[1].replace('\\', '/')).resolve(), destination) + '"'
    return re.sub(r'"([^"\n]+\.(?:smd|qci))"', replace, text, flags=re.I)


def viewmodel():
    out = PORT / 'v_xm16super'
    out.mkdir(parents=True, exist_ok=True)
    donor = PORT / 'v_m203'
    text = rebase((donor / 'v_m203.qc').read_text(), donor, out)
    text = re.sub(r'^// Generated[^\n]*', '// KEEP: XM16 Super kitbash; rebuild with work/build_xm16super.py', text, count=1)
    text = text.replace('weapons/mcv/v_m203.mdl', 'weapons/mcv/v_xm16super.mdl')
    text = re.sub(r'\$bodygroup\s+"[^"\n]+"\s*\{[^}]*\}\s*', '', text)
    body = '$bodygroup "studio"\n{\n\tstudio "' + relative(SOURCE, out) + '"\n}\n\n'
    text = text.replace('$surfaceprop', body + '$surfaceprop', 1)
    text = text.replace('$attachment "muzzle" "Base" -26.5', '$attachment "muzzle" "Base" -33.5')
    text = text.replace('$cdmaterials "models\\weapons\\mcv\\shells\\"',
                        '$cdmaterials "models\\weapons\\mcv\\shells\\"\n$cdmaterials "models\\weapons\\mcv\\optics\\"')
    # Keep the M16-M203 donor's rifle-shot deltas and matching correctives.
    # Keep the original hip-fire sequence, and supply a separate deployed shot.
    # Its base is the same gl_a / irongl pair as the launcher idle, so the shot
    # cannot snap back to the rifle's sight pose.
    text += '''
// The deployed launcher shot has its own base pose and activity.
$sequence "gl_shoot_deployed" {
    "gl_a"
    "irongl"
    activity "ACT_VM_ISHOOT_M203" 1
    blend "ironsight" 0 1
    blendwidth 2
    snap
    addlayer "walklayer_grenade"
    addlayer "runlayer"
    addlayer "gl_shoot_pose"
    node "0"
}
'''
    qc = out / 'v_xm16super.qc'
    qc.write_text(text)
    return qc


def worldmodel(source=SOURCE, name='xm16super', muzzle=-33.5, launcher=True):
    out = PORT / ('w_' + name)
    out.mkdir(parents=True, exist_ok=True)
    nodes, frames, _ = load_smd(source)
    transforms = fk(nodes, frames[0])
    base = next(i for i, (name, _) in nodes.items() if name == 'Base')
    # VM Base: -X forward, Z up. World weapon_bone: Z forward, Y up.
    # Scale and origin put the copied Mk.4 muzzle at its existing world-model
    # attachment (0, 0.7, 29), retaining the complete kitbash silhouette.
    mapping = np.eye(4)
    mapping[:3, :3] = np.array([[0, -.85, 0], [0, 0, .85], [-.85, 0, 0]])
    mapping[:3, 3] = [0, -.15, .525]
    wn, wf, _ = load_smd(HERE / 'MCV_SMD_OG/weapons/w_m203/w_m203_anims/idle.smd')
    bone = fk(wn, wf[0])[0]
    transform = bone @ mapping @ np.linalg.inv(transforms[base])
    normal = transform[:3, :3] / .85
    mesh = source.read_text().split('triangles\n', 1)[1].splitlines()
    header = (HERE / 'MCV_SMD_OG/weapons/w_m203/w_m203_anims/idle.smd').read_text()
    lines = [header.rstrip(), 'triangles']
    for i in range(0, len(mesh) - 1, 4):
        material = mesh[i].strip()
        lines.append(material)
        corners = [np.array(list(map(float, line.split()[1:4]))) for line in mesh[i + 1:i + 4]]
        face = normal @ np.cross(corners[1] - corners[0], corners[2] - corners[0])
        face_len = np.linalg.norm(face)
        face = face / face_len if face_len > 1e-12 else np.array([0., 0., 1.])
        for line in mesh[i + 1:i + 4]:
            parts = line.split()
            position = transform @ np.array([*map(float, parts[1:4]), 1])
            direction = normal @ np.array(list(map(float, parts[4:7])))
            length = np.linalg.norm(direction)
            direction = direction / length if length > 1e-12 else face
            values = [*position[:3], *direction, *map(float, parts[7:9])]
            lines.append('0 ' + ' '.join(f'{v:.7f}' for v in values) + ' 1 0 1')
    lines.append('end')
    smd = out / (name + '_world.smd')
    smd.write_text('\n'.join(lines) + '\n')
    donor = PORT / 'w_mk4mod0'
    text = rebase((donor / 'w_mk4mod0.qc').read_text(), donor, out)
    text = re.sub(r'^// Generated[^\n]*', '// KEEP: kitbash world mesh; rebuild with work/build_' + name + '.py', text, count=1)
    text = text.replace('w_mk4mod0.mdl', 'w_' + name + '.mdl')
    text = re.sub(r'\$bodygroup\s+"[^"\n]+"\s*\{[^}]*\}\s*', '', text)
    text = re.sub(r'\$lod\s+[^\n]+\s*\{[^}]*\}\s*', '', text)
    text = re.sub(r'^\$cdmaterials[^\n]*\n', '', text, flags=re.M)
    materials = ''.join('$cdmaterials "models/weapons/mcv/' + d + '/"\n' for d in ['v_m16a1', 'v_uzi', 'shells', 'optics'])
    text = text.replace('$surfaceprop', '$bodygroup "Body"\n{\n\tstudio "' + smd.name + '"\n}\n\n' + materials + '\n$surfaceprop', 1)
    muzzlepos = mapping @ np.array([muzzle, 0, 1, 1])
    text = re.sub(r'^\$attachment "muzzle"[^\n]*', '$attachment "muzzle" "ValveBiped.weapon_bone" ' + ' '.join(f'{v:.6f}' for v in muzzlepos[:3]) + ' rotate -90 -90 0', text, flags=re.M)
    # Use the same transform for the launcher and ejection attachments as its mesh.
    attachments = [('shell_eject', [.5, .4, 1], '0 180 90')]
    if launcher:
        attachments.insert(0, ('muzzle_equipment', [-19.6, 0, -1.9], '-90 -90 0'))
    for attachment, xyz, rotation in attachments:
        pos = mapping @ np.array([*xyz, 1])
        text = re.sub(r'^\$attachment "' + attachment + '"[^\n]*\n', '', text, flags=re.M)
        text += '\n$attachment "' + attachment + '" "ValveBiped.weapon_bone" ' + ' '.join(f'{v:.6f}' for v in pos[:3]) + ' rotate ' + rotation + '\n'
    qc = out / ('w_' + name + '.qc')
    qc.write_text(text)
    return qc


def icon(source=SOURCE, name='xm16super'):
    """Use the same outlined mesh renderer as the standalone icon command."""
    from build_spawn_icons import make
    return make(name, source)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--install', action='store_true')
    parser.add_argument('--icon-only', action='store_true')
    a = parser.parse_args()
    if a.icon_only:
        icon()
        return
    # The exported Euler representations differ, but the actual bind transforms match.
    nodes, frames, _ = load_smd(SOURCE)
    dn, df, _ = load_smd(HERE / 'MCV_SMD_OG/weapons/v_m203/RefM203_new.smd')
    assert nodes == dn, 'kitbash skeleton no longer matches the M203 donor'
    actual, expected = fk(nodes, frames[0]), fk(dn, df[0])
    assert max(np.max(np.abs(actual[i] - expected[i])) for i in nodes) < .001, 'bind pose changed'
    logdir = HERE / 'xm16super_build'
    logdir.mkdir(exist_ok=True)
    compiler = ROOT.parents[2] / 'bin/studiomdl.exe'
    assert (SCRATCH / 'gameinfo.txt').exists(), 'initialize the documented compile_test_game first'
    results = []
    for qc in [viewmodel(), worldmodel()]:
        result = subprocess.run([str(compiler), '-game', str(SCRATCH), '-nop4', str(qc)],
                                cwd=compiler.parent, capture_output=True, text=True, timeout=300)
        output = result.stdout + result.stderr
        (logdir / (qc.stem + '.log')).write_text(output)
        if result.returncode or 'Completed' not in output:
            print(output[-7000:])
            raise RuntimeError('compile failed: ' + qc.name)
        files = sorted((SCRATCH / 'models/weapons/mcv').glob(qc.stem + '.*'))
        assert any(p.suffix == '.mdl' for p in files)
        if a.install:
            for p in files:
                shutil.copy2(p, ROOT / 'models/weapons/mcv' / p.name)
        results.append({'qc': str(qc), 'outputs': [str(p) for p in files], 'installed': a.install,
                        'warnings': [line for line in output.splitlines() if 'WARNING' in line]})
        print(qc.stem, 'compiled', len(files), 'files', flush=True)
    (logdir / 'build.json').write_text(json.dumps(results, indent=2) + '\n')
    if a.install:
        icon()


if __name__ == '__main__':
    main()

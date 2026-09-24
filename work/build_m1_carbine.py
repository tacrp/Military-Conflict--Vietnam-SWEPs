"""Build a fixed-stock M1 from the M2 and Para magazine; preserve donor animations.

Run with --install to compile/install into Part 2 and export editable sources.
"""
import argparse
from pathlib import Path
import re
import shutil
import subprocess
import numpy as np
from bake_ik import load_smd, fk
from build_xm16super import HERE, ROOT, PORT, SCRATCH, relative, rebase
from export_custom_compile_files import export
from build_spawn_icons import make

OG = HERE / 'MCV_SMD_OG/weapons'
BUNDLE = HERE / 'MCV_SMD/weapons/v_m1_carbine'
PART2 = ROOT.parent / 'mcv-2'


def swap(receiver, donor, output, bone):
    rn, rf, _ = load_smd(receiver)
    dn, df, _ = load_smd(donor)
    rid = next(i for i, v in rn.items() if v[0] == bone)
    did = next(i for i, v in dn.items() if v[0] == bone)
    # These models share the same magazine pivot and bind pose. Never silently
    # transplant geometry if a later source revision changes that contract.
    assert np.max(np.abs(fk(rn, rf[0])[rid] - fk(dn, df[0])[did])) < .001

    def read(path, mag):
        header, mesh = path.read_text().split('triangles\n', 1)
        lines = mesh.splitlines()
        faces = []
        for i in range(0, len(lines)-1, 4):
            face = lines[i:i+4]
            verts = [v.split() for v in face[1:]]
            weights = [{int(v[j]) for j in range(10, len(v), 2)
                        if float(v[j+1]) > 0} for v in verts]
            belongs = [mag in w for w in weights]
            assert not any(belongs) or all(w == {mag} for w in weights), 'mixed magazine triangle'
            faces.append((all(belongs), face))
        return header, faces

    header, base = read(receiver, rid)
    _, replacement = read(donor, did)
    retained = [f for m, f in base if not m]
    added = [f for m, f in replacement if m]
    assert added and len(retained) < len(base)
    for face in added:
        for i in range(1, 4):
            v = face[i].split()
            v[0] = str(rid)
            v[10] = str(rid)
            face[i] = ' '.join(v)
    output.write_text(header + 'triangles\n' + '\n'.join(l for f in retained+added for l in f) + '\nend\n')
    print(output.name, 'replaced', len(base)-len(retained), 'magazine faces with', len(added), flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--install', action='store_true')
    args = parser.parse_args()
    BUNDLE.mkdir(parents=True, exist_ok=True)
    qcs = []
    for prefix in ('v', 'w'):
        source = PORT / (prefix+'_m2c')
        target = PORT / (prefix+'_m1_carbine')
        target.mkdir(parents=True, exist_ok=True)
        text = rebase((source/(prefix+'_m2c.qc')).read_text(), source, target)
        text = text.replace(prefix+'_m2c.mdl', prefix+'_m1_carbine.mdl')
        text = re.sub(r'^// Generated[^\n]*', '// Custom M1 Carbine; work/build_m1_carbine.py', text, count=1)
        meshes = [('ref_new.smd', 'm1a1c_ref.smd')] if prefix == 'v' else [
            ('w_m2c_lod0'+suffix+'.smd', 'w_m1c_lod0'+suffix+'.smd')
            for suffix in ('', '_lod1', '_lod2')]
        for index, (base, donor) in enumerate(meshes):
            original = OG/(prefix+'_m2c')/base
            output = BUNDLE/(prefix+'_m1_carbine_mesh'+str(index)+'.smd')
            swap(original, OG/(prefix+'_m1c')/donor, output,
                 'Mag' if prefix == 'v' else 'ValveBiped.weapon_bone2')
            old = relative(original, target)
            assert old in text
            text = text.replace(old, relative(output, target))
        qc = target/(prefix+'_m1_carbine.qc')
        qc.write_text(text)
        qcs.append(qc)
    compiler = ROOT.parents[2]/'bin/studiomdl.exe'
    for qc in qcs:
        result = subprocess.run([str(compiler), '-game', str(SCRATCH), '-nop4', str(qc)],
                                cwd=compiler.parent, capture_output=True, text=True, timeout=300)
        output = result.stdout+result.stderr
        (BUNDLE/(qc.stem+'.log')).write_text(output)
        assert result.returncode == 0 and 'Completed' in output and 'ERROR:' not in output, output[-6000:]
        if args.install:
            for model in (SCRATCH/'models/weapons/mcv').glob(qc.stem+'.*'):
                shutil.copy2(model, PART2/'models/weapons/mcv'/model.name)
        print('Compiled', qc.stem, flush=True)
    if args.install:
        make('m1_carbine', BUNDLE/'v_m1_carbine_mesh0.smd', out=BUNDLE)
        shutil.copy2(BUNDLE/'mcv_m1_carbine.png', PART2/'materials/entities/mcv_m1_carbine.png')
        export('v_m1_carbine', ('v_m1_carbine', 'w_m1_carbine'))


if __name__ == '__main__':
    main()

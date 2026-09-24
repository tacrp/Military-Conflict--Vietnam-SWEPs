"""Build the SVD Irons and Type 56-1 Drum from the current port QCs.

Run with --install to install models/icons and export editable compile bundles.
This regenerates the kitbash meshes/QCs; use each bundle's compile.py for hand edits.
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


def mesh(path):
    header, data = path.read_text().split('triangles\n', 1)
    lines = data.splitlines()
    return header, [lines[i:i+4] for i in range(0, len(lines)-1, 4)]


def write_mesh(path, header, faces):
    path.write_text(header+'triangles\n'+'\n'.join(line for f in faces for line in f)+'\nend\n')


def remove_scope(source, output):
    header, faces = mesh(source)
    retained = [f for f in faces if f[0] not in ('optics_pso_1', 'lens_svd', 'w_svd_scope')]
    assert retained and len(retained) < len(faces)
    write_mesh(output, header, retained)
    print(output.name, 'removed scope faces:', len(faces)-len(retained), flush=True)


def drum_swap(source, donor, output, bone):
    sn, sf, _ = load_smd(source)
    dn, df, _ = load_smd(donor)
    sid = next(i for i, (n, _) in sn.items() if n == bone)
    did = next(i for i, (n, _) in dn.items() if n == bone)
    assert np.max(abs(fk(sn, sf[0])[sid]-fk(dn, df[0])[did])) < .001
    def is_mag(face, index):
        weights = [{int(v[j]) for j in range(10, len(v), 2) if float(v[j+1]) > 0}
                   for v in [line.split() for line in face[1:]]]
        if any(index in w for w in weights):
            assert all(w == {index} for w in weights), 'Mixed magazine weights'
            return True
        return False
    header, base = mesh(source)
    _, replacement = mesh(donor)
    keep = [f for f in base if not is_mag(f, sid)]
    added = [f for f in replacement if is_mag(f, did)]
    assert added and len(keep) < len(base)
    for face in added:
        for i in range(1, 4):
            v = face[i].split()
            v[0] = v[10] = str(sid)
            face[i] = ' '.join(v)
    write_mesh(output, header, keep+added)
    print(output.name, 'magazine faces:', len(base)-len(keep), '->', len(added), flush=True)


def build(name, original):
    bundle = HERE/'MCV_SMD/weapons'/('v_'+name)
    bundle.mkdir(parents=True, exist_ok=True)
    qcs = []
    for prefix in ('v', 'w'):
        stem, oldstem = prefix+'_'+name, prefix+'_'+original
        source, target = PORT/oldstem, PORT/stem
        target.mkdir(parents=True, exist_ok=True)
        qc = rebase((source/(oldstem+'.qc')).read_text(), source, target)
        qc = qc.replace(oldstem+'.mdl', stem+'.mdl')
        if original == 'svd':
            meshes = ['ref_new.smd'] if prefix == 'v' else ['w_svd_lod0'+s+'.smd' for s in ('', '_lod1', '_lod2')]
        else:
            meshes = ['type56_ref.smd'] if prefix == 'v' else ['w_ak_type56_lod0'+s+'.smd' for s in ('', '_lod1', '_lod2')]
        for i, filename in enumerate(meshes):
            oldmesh = OG/oldstem/filename
            newmesh = bundle/(stem+'_mesh'+str(i)+'.smd')
            if original == 'svd':
                remove_scope(oldmesh, newmesh)
            else:
                donor = OG/'v_rpk/RPK_mag_drum.smd' if prefix == 'v' else OG/'w_rpk'/('w_rpk_lod0'+('', '_lod1', '_lod2')[i]+'.smd')
                drum_swap(oldmesh, donor, newmesh, 'Mag' if prefix == 'v' else 'ValveBiped.weapon_bone2')
            oldref = relative(oldmesh, target)
            assert oldref in qc
            qc = qc.replace(oldref, relative(newmesh, target))
        if original == 'type56':
            qc = '$cdmaterials "models/weapons/mcv/'+prefix+'_rpk/"\n'+qc
            if prefix == 'v':
                donor_dir = PORT/'v_rpk'
                donor_qc = rebase((donor_dir/'v_rpk.qc').read_text(), donor_dir, target)
                for seq in ('reload', 'reload_empty'):
                    pattern = r'\$sequence "'+seq+r'" \{.*?^\}'
                    block = re.search(pattern, donor_qc, re.M | re.S).group()
                    qc, count = re.subn(pattern, lambda _: block, qc, flags=re.M | re.S)
                    assert count == 1
        path = target/(stem+'.qc')
        path.write_text(qc)
        qcs.append(path)
    return bundle, qcs


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--install', action='store_true')
    args = parser.parse_args()
    compiler = ROOT.parents[2]/'bin/studiomdl.exe'
    for name, donor in [('svd_irons', 'svd'), ('type56_drum', 'type56')]:
        bundle, qcs = build(name, donor)
        for qc in qcs:
            run = subprocess.run([str(compiler), '-game', str(SCRATCH), '-nop4', str(qc)], cwd=compiler.parent, capture_output=True, text=True, timeout=300)
            log = run.stdout+run.stderr
            (bundle/(qc.stem+'.log')).write_text(log)
            assert run.returncode == 0 and 'Completed' in log and 'ERROR:' not in log, log[-6000:]
            if args.install:
                for model in (SCRATCH/'models/weapons/mcv').glob(qc.stem+'.*'):
                    shutil.copy2(model, ROOT/'models/weapons/mcv'/model.name)
            print('Compiled', qc.stem, flush=True)
        make(name, bundle/('v_'+name+'_mesh0.smd'), out=bundle)
        if args.install:
            shutil.copy2(bundle/('mcv_'+name+'.png'), ROOT/'materials/entities'/('mcv_'+name+'.png'))
            export('v_'+name, ('v_'+name, 'w_'+name))


if __name__ == '__main__':
    main()

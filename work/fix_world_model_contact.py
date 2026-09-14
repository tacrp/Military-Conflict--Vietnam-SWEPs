"""Correct existing QC translations without regenerating meshes, sights or weapons."""
import argparse
import concurrent.futures
import json
import re
import shutil
import subprocess
from pathlib import Path
import port_qc
from world_model_contact import HAND_RE, contact_pivot, pitch_about_finger

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
PORT = HERE/'MCV_SMD_PORT/weapons'
OUT = HERE/'world_model_contact'
ALIASES = {'w_m635':'w_mk4mod0', 'w_xm16super':'w_mk4mod0'}


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--only', nargs='*')
    ap.add_argument('--apply', action='store_true')
    ap.add_argument('--compile', action='store_true')
    ap.add_argument('--install', action='store_true')
    ap.add_argument('--jobs', type=int, default=4)
    args = ap.parse_args()
    assert not args.install or args.compile
    assert not args.compile or args.apply
    OUT.mkdir(exist_ok=True)
    targets = json.loads((HERE/'world_model_pitch_targets.json').read_text())['models']
    derived = json.loads((HERE/'hand_offsets_derived.json').read_text())
    saved = json.loads((HERE/'hand_bones.json').read_text())
    manifest = OUT/'changes.json'
    changes = json.loads(manifest.read_text()) if manifest.exists() else {}
    planned, skipped = [], []
    for qc in sorted(PORT.glob('w_*/*.qc')):
        name = qc.stem
        if args.only and name not in args.only:
            continue
        source = ALIASES.get(name, name)
        target = targets.get(source)
        text = qc.read_text()
        m = HAND_RE.search(text)
        if not target or not m:
            skipped.append({'model':name,'reason':'no supported root hand / pitch target'})
            continue
        line = m[0]
        if name in changes:
            record = changes[name]
            if line not in (record['before'], record['after']):
                raise RuntimeError(f'{name}: hand line changed since the saved pass; inspect it first')
        else:
            if source in port_qc.HAND_OFFSETS:
                oldpitch = port_qc.HAND_OFFSETS[source][3]
            elif source in derived:
                oldpitch = derived[source]['hand'][3]
            elif source in saved and HAND_RE.match(saved[source]):
                oldpitch = float(HAND_RE.match(saved[source])[2].split()[3])
            else:
                skipped.append({'model':name,'reason':'no record of original pitch'})
                continue
            fields = m[2].split()
            off = list(map(float, fields[:6]))
            if abs(off[3]-target['pitch']) > .01:
                skipped.append({'model':name,'reason':'current pitch differs from the completed pitch pass'})
                continue
            old = list(off)
            old[3] = oldpitch
            pivot = contact_pivot(target['holdtype'])
            after = pitch_about_finger(old, off[3], pivot)
            updated = m[1] + ' '.join([*(f'{v:.6f}' for v in after), *fields[6:]])
            record = {'before':line,'after':updated,'holdtype':target['holdtype'],
                      'original_pitch':oldpitch,'finger_pivot':pivot,
                      'translation_delta':[after[i]-off[i] for i in range(3)]}
        planned.append((qc,record))
        if args.apply:
            backup = OUT/'before'/name/qc.name
            if not backup.exists():
                backup.parent.mkdir(parents=True,exist_ok=True)
                shutil.copy2(qc,backup)
            qc.write_text(text.replace(line,record['after'],1))
            changes[name] = record
    if args.apply:
        manifest.write_text(json.dumps(changes,indent=2)+'\n')
    (OUT/'plan.json').write_text(json.dumps({'planned':{qc.stem:r for qc,r in planned},'skipped':skipped},indent=2)+'\n')
    print(f'{len(planned)} models planned, {len(skipped)} skipped',flush=True)
    if not args.compile:
        return
    compiler = ROOT.parents[2]/'bin/studiomdl.exe'
    scratch = HERE/'compile_test_game'
    logs = OUT/'logs'
    logs.mkdir(exist_ok=True)
    def build(item):
        qc,record = item
        result = subprocess.run([str(compiler),'-game',str(scratch),'-nop4',str(qc)],
            cwd=compiler.parent,capture_output=True,text=True,timeout=180)
        output = result.stdout+result.stderr
        (logs/(qc.stem+'.log')).write_text(output)
        ok = result.returncode == 0 and 'Completed' in output and 'ERROR:' not in output
        if ok and args.install:
            for f in (scratch/'models/weapons/mcv').glob(qc.stem+'.*'):
                shutil.copy2(f,ROOT/'models/weapons/mcv'/f.name)
        return {'model':qc.stem,'ok':ok,'installed':ok and args.install}
    results = []
    with concurrent.futures.ThreadPoolExecutor(max_workers=args.jobs) as pool:
        for row in pool.map(build,planned):
            results.append(row)
            print(row['model'], 'OK' if row['ok'] else 'FAILED',flush=True)
    (OUT/'build.json').write_text(json.dumps(results,indent=2)+'\n')
    if not all(r['ok'] for r in results):
        raise SystemExit(1)


if __name__ == '__main__':
    main()

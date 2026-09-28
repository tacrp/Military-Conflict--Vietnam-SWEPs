"""Restore Cobra's wet-reload hierarchy; --compile builds/installs only its viewmodel.

python work/fix_cobra_reload.py --compile
Never launches GMod or edits the user's animation source.
"""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
from types import SimpleNamespace

from model_pose_fixes import prepare_pose_fixes
from pack_paths import ROOT, asset_path
from port_qc import Ctx
from fix_gyrojet_sprint import model_metadata
from check_deploy_layers import sequences

WORK = ROOT / 'work'
MODEL = 'v_cobra'
OUT = WORK / 'cobra_reload'
QC = WORK / f'MCV_SMD_PORT/weapons/{MODEL}/{MODEL}.qc'


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def prepare():
    source = WORK / f'MCV_SMD/weapons/{MODEL}/anims/reload.smd'
    unchanged = digest(source)
    ctx = Ctx(SimpleNamespace(fixed_root=str(WORK / 'MCV_SMD')),
              str(WORK / 'MCV_SMD_OG/weapons' / MODEL), str(QC.parent))
    prepare_pose_fixes(ctx)
    fixed = Path(ctx.resolve_smd(MODEL + '_anims/reload.smd'))
    assert fixed == QC.parent / 'fixed_anims/reload.smd'
    fixed_hash = digest(fixed)
    prepare_pose_fixes(ctx)
    assert digest(fixed) == fixed_hash and digest(source) == unchanged
    text = QC.read_text(encoding='utf-8')
    old = '../../../MCV_SMD/weapons/v_cobra/anims/reload.smd'.replace('/', '\\')
    new = 'fixed_anims\\reload.smd'
    assert text.count(old) + text.count(new) == 1
    if old in text:
        QC.write_text(text.replace(old, new, 1), encoding='utf-8', newline='\n')
    return {'hand_edit_sha256': unchanged, 'fixed_smd_sha256': fixed_hash,
            'frames': 70, 'duration_seconds': 69 / 30}


def compile_install(report):
    installed = asset_path(f'models/weapons/mcv/{MODEL}.mdl')
    before, layers = model_metadata(installed), sequences(installed)
    compiler = ROOT.parents[2] / 'bin/studiomdl.exe'
    run = subprocess.run([str(compiler), '-game', str(WORK / 'compile_test_game'), '-nop4', str(QC)],
                         cwd=compiler.parent, capture_output=True, text=True, timeout=180)
    log = run.stdout + run.stderr
    (OUT / 'compile.log').write_text(log, encoding='utf-8')
    assert run.returncode == 0 and 'Completed' in log and 'ERROR:' not in log, log[-4000:]
    built = WORK / f'compile_test_game/models/weapons/mcv/{MODEL}.mdl'
    assert model_metadata(built) == before, 'animation timings/activities/events changed'
    assert sequences(built) == layers, 'animation layers changed'
    report['compiled_reload'] = [a for a in before['animations'] if 'reload' in a[0]]
    sources = [built.with_suffix(ext) for ext in ('.mdl', '.vvd', '.dx80.vtx', '.dx90.vtx')]
    assert all(p.is_file() and p.stat().st_size for p in sources)
    report['installed'] = {}
    for source in sources:
        destination = asset_path('models/weapons/mcv/' + source.name)
        assert destination.parent == installed.parent
        shutil.copy2(source, destination)
        assert digest(source) == digest(destination)
        report['installed'][str(destination)] = digest(destination)


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

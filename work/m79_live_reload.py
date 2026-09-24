"""Append live-cartridge reloads without altering the original spent-shell reload.

python work/m79_live_reload.py --compile
Also called by port_qc.py so subsequent ports retain the extra sequences.
"""
import argparse
import re
import shutil
import subprocess
from pathlib import Path
import numpy as np
from bake_ik import load_smd, write_rows
from pack_paths import ROOT, asset_path


def prepare(qcpath):
    qcpath = Path(qcpath)
    if qcpath.stem not in ('v_m79', 'v_m79_short'):
        return
    text = qcpath.read_text()
    marker = '// BEGIN MCV LIVE M79 RELOAD'
    text = text.split(marker)[0].rstrip() + '\n'
    block = re.search(r'\$sequence "reload" \{.*?^\}', text, re.M | re.S)[0]
    paths = re.findall(r'^\s*"([^"]+\.smd)"', block, re.M)
    assert len(paths) == 2
    for index, relative in enumerate(paths):
        source = (qcpath.parent / relative.replace('\\', '/')).resolve()
        nodes, frames, lines = load_smd(source)
        tip = next(i for i, (name, _) in nodes.items() if name == 'ShellTip')
        # ShellTip is parented to Shell. Keep its live, frame-zero local transform
        # while the original shell and all hands follow the original animation.
        rows = {(frame, tip): frames[0][tip].copy() for frame in range(len(frames))}
        output = qcpath.parent / 'live_reload' / f'reload_live_{index}.smd'
        output.parent.mkdir(exist_ok=True)
        write_rows(lines, rows, str(output))
        _, fixed, _ = load_smd(output)
        for old, new in zip(frames, fixed):
            assert np.allclose(new[tip], frames[0][tip], atol=1e-6)
            assert all(np.array_equal(old[i], new[i]) for i in nodes if i != tip)
        block = block.replace(relative, f'live_reload/reload_live_{index}.smd')
    block = block.replace('$sequence "reload"', '$sequence "reload_live"')
    block = '\n'.join(line for line in block.splitlines()
                      if 'activity ' not in line and 'AE_CLIENT_EJECT_BRASS' not in line
                      and '_Reload.Eject' not in line)
    qcpath.write_text(text + '\n' + marker + '\n' + block + '\n// END MCV LIVE M79 RELOAD\n')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compile', action='store_true')
    args = parser.parse_args()
    from fix_gyrojet_sprint import model_metadata
    work = ROOT / 'work'
    compiler = ROOT.parents[2] / 'bin/studiomdl.exe'
    for model in ('v_m79', 'v_m79_short'):
        qc = work / 'MCV_SMD_PORT/weapons' / model / (model + '.qc')
        prepare(qc)
        first = qc.read_bytes()
        prepare(qc)
        assert first == qc.read_bytes()
        if not args.compile:
            continue
        before = model_metadata(asset_path(f'models/weapons/mcv/{model}.mdl'))
        run = subprocess.run([str(compiler), '-game', str(work / 'compile_test_game'), '-nop4', str(qc)],
                             cwd=compiler.parent, capture_output=True, text=True, timeout=240)
        log = run.stdout + run.stderr
        (qc.parent / 'live_reload/compile.log').write_text(log)
        assert run.returncode == 0 and 'Completed' in log and 'ERROR:' not in log, log[-3000:]
        built = work / 'compile_test_game/models/weapons/mcv' / (model + '.mdl')
        after = model_metadata(built)
        assert [s for s in before['sequences'] if s[0] != 'reload_live'] == [
            s for s in after['sequences'] if s[0] != 'reload_live']
        assert any(s[0] == 'reload_live' for s in after['sequences'])
        for ext in ('.mdl', '.vvd', '.dx90.vtx', '.dx80.vtx', '.sw.vtx'):
            src = built.with_suffix(ext)
            if src.exists():
                shutil.copy2(src, asset_path('models/weapons/mcv/' + src.name))
        print(model + ': verified live tip every frame, unchanged other bones and original sequences; installed')


if __name__ == '__main__':
    main()

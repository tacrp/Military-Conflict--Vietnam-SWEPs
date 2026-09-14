"""Rebuild/install only Garand, LPO-50 and M9A1 worldmodels from original assets."""
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import json
import shutil
import subprocess
import sys

here = Path(__file__).resolve().parent
addon = here.parent
out = here / 'nested_world_fix'
out.mkdir(exist_ok=True)

def build(model):
    result = subprocess.run([sys.executable, str(here / 'port_qc.py'),
        str(here / 'MCV_SMD_OG/weapons' / model), '--compile'], capture_output=True, text=True, timeout=240)
    (out / (model + '.log')).write_text(result.stdout + result.stderr)
    assert result.returncode == 0 and 'compile=OK' in result.stdout, result.stdout + result.stderr
    files = []
    for source in (here / 'compile_test_game/models/weapons/mcv').glob(model + '.*'):
        dest = addon / 'models/weapons/mcv' / source.name
        backup = out / 'before_models' / source.name
        backup.parent.mkdir(exist_ok=True)
        if dest.exists() and not backup.exists(): shutil.copy2(dest, backup)
        shutil.copy2(source, dest)
        files.append(source.name)
    manifest = here / 'MCV_SMD_PORT/weapons' / model / 'fixed_anims/world_rig/manifest.json'
    shutil.copy2(manifest, out / (model + '.json'))
    print(model, 'compiled and installed', flush=True)
    return {'model': model, 'files': files}

if __name__ == '__main__':
    with ThreadPoolExecutor(max_workers=3) as pool:
        results = list(pool.map(build, ['w_m1g_s', 'w_lpo50', 'w_m9a1']))
    (out / 'build.json').write_text(json.dumps(results, indent=2) + '\n')

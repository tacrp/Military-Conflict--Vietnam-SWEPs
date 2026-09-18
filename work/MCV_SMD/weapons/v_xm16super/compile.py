"""Compile this folder's edited QCs directly; does not regenerate source files."""
import argparse
from pathlib import Path
import shutil
import subprocess
import sys

folder = Path(__file__).resolve().parent
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--game', type=Path, help='GarrysMod/garrysmod directory (normally detected)')
args = parser.parse_args()
game = args.game or next((p for p in folder.parents if (p/'gameinfo.txt').exists() and (p.parent/'bin/studiomdl.exe').exists()), None)
if game is None: parser.error('Pass --game with your GarrysMod/garrysmod folder')
compiler = game.parent/'bin/studiomdl.exe'
scratch = folder/'compiled'
scratch.mkdir(exist_ok=True)
(scratch/'gameinfo.txt').write_text('"GameInfo" { game "MCV custom compile" FileSystem { SteamAppId 4000 SearchPaths { Game |gameinfo_path|. Game "'+game.as_posix()+'" } } }')
addon = next((p for p in folder.parents if (p/'lua/weapons/mcv_base_core').exists()), None)
if addon:
    sys.path.insert(0,str(addon/'work'))
    from pack_paths import asset_path
for qc in sorted(folder.glob('*.qc')):
    print('Compiling', qc.name, flush=True)
    run = subprocess.run([str(compiler), '-game', str(scratch), '-nop4', str(qc)], cwd=compiler.parent, capture_output=True, text=True)
    output = run.stdout + run.stderr
    (folder/(qc.stem+'.log')).write_text(output)
    if run.returncode or 'Completed' not in output or 'ERROR:' in output:
        raise SystemExit(output[-6000:])
    if addon:
        for model in (scratch/'models/weapons/mcv').glob(qc.stem+'.*'):
            shutil.copy2(model,asset_path('models/weapons/mcv/'+model.name))
        print('Installed', qc.name, flush=True)
    else:
        print('Built into', scratch/'models/weapons/mcv', flush=True)
print('Fully restart Garrys Mod to load the rebuilt models.')

"""Keep editable, local QC/SMD/QCI bundles beside each custom gun's input mesh."""
import hashlib
import json
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
BUNDLES = {'v_svd_irons': ('v_svd_irons', 'w_svd_irons'),
           'v_type56_drum': ('v_type56_drum', 'w_type56_drum'),
           'v_m1_carbine': ('v_m1_carbine', 'w_m1_carbine'),
           'v_xm16super': ('v_xm16super','w_xm16super'),
           'v_m635': ('v_m635','w_m635'), 'v_ptrd41_s': ('v_ptrd41_s','w_ptrd41_s')}
FILE_REF = re.compile(r'"([^"\n]+\.(?:smd|qci|vta|dmx))"', re.I)
COMPILER = '''"""Compile this folder's edited QCs directly; does not regenerate source files."""
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
'''


def digest(data): return hashlib.sha256(data).hexdigest()


def export(folder_name, models):
    folder = HERE/'MCV_SMD/weapons'/folder_name
    manifest = folder/'compile-manifest.json'
    previous = json.loads(manifest.read_text()) if manifest.exists() else {}
    generated, references, names = {}, {}, {}

    def dependency(path):
        path = path.resolve()
        if path.is_relative_to(folder.resolve()): return path.relative_to(folder).as_posix()
        if path in references: return references[path]
        name = 'assets/'+path.name
        if name.lower() in names and names[name.lower()] != path:
            name = 'assets/'+path.stem+'_'+digest(str(path).encode())[:8]+path.suffix
        names[name.lower()] = path
        references[path] = name
        if path.suffix.lower()=='.qci':
            # References inside an included file are relative to that file.
            data = rewrite(path, in_assets=True).encode()
        else:
            data = path.read_bytes()
        generated[name] = data
        return name

    def rewrite(path, in_assets=False):
        def replace(match):
            source = (path.parent/match[1].replace('\\','/')).resolve()
            local = dependency(source)
            if in_assets: local = '../'+local
            return '"'+local+'"'
        return FILE_REF.sub(replace,path.read_text())

    for model in models:
        qc = HERE/'MCV_SMD_PORT/weapons'/model/(model+'.qc')
        text = rewrite(qc)
        text = re.sub(r'^// (?:Generated|KEEP:)[^\n]*',
                      '// Editable local compile source. Run compile.py or compile this QC in Crowbar.',text,count=1)
        generated[qc.name] = text.encode()
    generated['compile.py'] = COMPILER.encode()
    generated['COMPILE.md'] = f'''# Editable compile files

The QCs in this folder use the original kitbash mesh here and local dependencies
in `assets/`, including the animation SMDs, hand-rig QCI and world-model sources.
The PTRD bundle also includes the separate `assets/Ref_Bullet.smd` cartridge.

Edit these QCs or SMDs, then run `python compile.py` from this folder, or select
the QC in Crowbar with Garry's Mod as the game. The Python command builds into
`compiled/` here and copies the results into this addon's `models/weapons/mcv/`.
Source files are never regenerated. Fully restart the game after compiling.

The existing addon supplies textures, sounds, Lua and the common compiled
gesture animation model. Pass `--game "path/to/GarrysMod/garrysmod"` when using
the folder outside this addon; then copy the outputs into your addon manually.
Output logs remain beside each QC. When using Crowbar, set its output to the
addon's model folder to avoid a second model copy overriding it in the game root.

`work/build_*.py` are separate generation tools for reconstructing the initial
port; normal hand editing uses the local QCs instead. The export tool refuses
to replace files changed since its last export. The original input mesh is never
overwritten by the exporter. The viewmodel and worldmodel meshes are independent.
'''.encode()
    # Verify all destinations before writing any file in this bundle.
    for name,data in generated.items():
        target = folder/name
        if target.exists() and target.read_bytes()!=data:
            if digest(target.read_bytes()) != previous.get(name):
                raise RuntimeError(f'Preserving edited file: {target}. Compile it directly; merge export changes by hand.')
    for name,data in generated.items():
        target = folder/name
        target.parent.mkdir(parents=True,exist_ok=True)
        target.write_bytes(data)
    manifest.write_text(json.dumps({name:digest(data) for name,data in generated.items()},indent=2)+'\n')
    print(folder_name, len(generated),'local compile files',flush=True)


if __name__=='__main__':
    for folder,models in BUNDLES.items(): export(folder,models)

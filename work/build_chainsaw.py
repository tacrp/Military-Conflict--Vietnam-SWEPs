"""Restore chainsaw looping/timing and import its original HUD icon; no game launch.

python work/build_chainsaw.py --compile
"""
from pathlib import Path
import argparse
import hashlib
import io
import json
import re
import shutil
import struct
import subprocess
from pack_paths import ROOT, asset_path

WORK = ROOT / 'work'
OUT = WORK / 'chainsaw'
QC = WORK / 'MCV_SMD_PORT/weapons/v_chainsaw/v_chainsaw.qc'


def prepare(path):
    path = Path(path)
    if path.stem != 'v_chainsaw':
        return
    text = path.read_text(encoding='utf-8')
    def patch(match):
        name, body = match.group(1), match.group(2)
        if name not in ('shootloop', 'shootend'):
            return match.group(0)
        # Ported delta poses play over a 61-frame idle. Preserve the original
        # 21-frame cutting cycle and 16-frame release at 30 FPS via parent rate.
        body = re.sub(r'^[ \t]*(?:fps\s+[^\n]+|loop)[ \t]*\n', '', body, flags=re.M)
        body = body.rstrip() + ('\n\tfps 90\n\tloop\n' if name == 'shootloop' else '\n\tfps 120\n')
        return '$sequence "' + name + '" {' + body + '}\n'
    result = re.sub(r'\$sequence "([^\"]+)" \{([^}]+)\}\n', patch, text)
    if result != text:
        path.write_text(result, encoding='utf-8', newline='\n')


def sequence_flags(path):
    data = path.read_bytes()
    assert data[:4] == b'IDST'
    count, offset = struct.unpack_from('<ii', data, 188)
    result = {}
    for i in range(count):
        at = offset + i * 212
        label = at + struct.unpack_from('<i', data, at + 4)[0]
        name = data[label:data.index(b'\0', label)].decode()
        result[name] = struct.unpack_from('<i', data, at + 12)[0]
    return result


def main():
    from vpklib import VPK
    import cairosvg
    from PIL import Image
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compile', action='store_true')
    parser.add_argument('--game', default='D:/SteamLibrary/steamapps/common/Military Conflict - Vietnam/vietnam')
    args = parser.parse_args()
    OUT.mkdir(exist_ok=True)
    prepare(QC)
    vpk = VPK(str(Path(args.game) / 'pak01_dir.vpk'))
    svg = vpk.read('materials/panorama/images/icons/equipment/weapon_chainsaw.svg')
    vpk.close()
    (OUT / 'chainsaw.svg').write_bytes(svg)
    image = Image.open(io.BytesIO(cairosvg.svg2png(bytestring=svg, output_width=2048))).convert('RGBA')
    image = image.crop(image.getbbox())
    image.thumbnail((500, 248), Image.Resampling.LANCZOS)
    canvas = Image.new('RGBA', (512, 512))
    canvas.alpha_composite(image, ((512-image.width)//2, (512-image.height)//2))
    canvas.save(asset_path('materials/entities/mcv_chainsaw.png'))
    if args.compile:
        compiler = ROOT.parents[2] / 'bin/studiomdl.exe'
        run = subprocess.run([str(compiler), '-game', str(WORK/'compile_test_game'), '-nop4', str(QC)],
                             cwd=compiler.parent, capture_output=True, text=True, timeout=180)
        log = run.stdout + run.stderr
        (OUT/'compile.log').write_text(log, encoding='utf-8')
        assert run.returncode == 0 and 'Completed' in log and 'ERROR:' not in log, log[-4000:]
        built = WORK/'compile_test_game/models/weapons/mcv/v_chainsaw.mdl'
        before = sequence_flags(asset_path('models/weapons/mcv/v_chainsaw.mdl'))
        after = sequence_flags(built)
        assert before.keys() == after.keys()
        assert after['shootloop'] & 1 and not after['shootend'] & 1
        installed = {}
        for ext in ('.mdl', '.vvd', '.dx90.vtx', '.dx80.vtx'):
            source = built.with_suffix(ext)
            destination = asset_path('models/weapons/mcv/' + source.name)
            shutil.copy2(source, destination)
            installed[destination.name] = hashlib.sha256(destination.read_bytes()).hexdigest()
        (OUT/'build.json').write_text(json.dumps(installed, indent=2)+'\n')
        print('Compiled/installed v_chainsaw: cutting loop flag enabled; original sequence names retained.')
    print('Imported original chainsaw icon.')


if __name__ == '__main__':
    main()

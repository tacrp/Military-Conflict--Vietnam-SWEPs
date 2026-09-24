"""Render the five newly implemented variants from their source meshes, offline."""
from pathlib import Path
import argparse
import hashlib
import json
from PIL import Image
from build_spawn_icons import make, preview
from pack_paths import ROOT, PART2

sources = {
    'x2f2a2': ('v_x2f2a2/v_x2f2a2_ref.smd', PART2),
    'vz59b': ('v_vz59b/Ref.smd', ROOT),
    'm16_flamer': ('v_m16_flamer/m16_flamer.smd', PART2),
    'type56xm148': ('v_type56xm148/type56_xm148.smd', PART2),
    'lunge_mine': ('v_lunge_mine/Ref_lunge.smd', ROOT),
}
out = ROOT / 'work/unused_variant_icons'
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('weapons', nargs='*', help='Variant names; omit to render all')
args = parser.parse_args()
if any(name not in sources for name in args.weapons):
    parser.error('Unknown variant; choose from: ' + ', '.join(sources))
records = []
for name, (relative, pack) in sources.items():
    if args.weapons and name not in args.weapons:
        continue
    source = ROOT / 'work/MCV_SMD_OG/weapons' / relative
    if not source.exists():
        raise FileNotFoundError(source)
    extra = {'type56xm148': 'body2_model0.smd', 'vz59b': 'body22_model0.smd',
             'x2f2a2': 'body1_model0.smd'}.get(name)
    if extra:
        # Bodygroup meshes share the reference coordinate system and are needed for the silhouette.
        text = source.read_text()
        head, triangles = text.split('triangles\n', 1)
        other = (source.parent / extra).read_text().split('triangles\n', 1)[1]
        out.mkdir(parents=True, exist_ok=True)
        source = out / (name + '_icon.smd')
        source.write_text(head + 'triangles\n' + triangles.rsplit('end', 1)[0] + other)
    record = make(name, source, out=out, exclude=('shell', 'arms', 'hands', 'sleeve', 'glove'))
    output = Path(record['output'])
    if not output.is_absolute(): output = ROOT / output
    if name == 'lunge_mine':
        with Image.open(output) as image:
            image.transpose(Image.Transpose.ROTATE_90).save(output)
        record['png_sha256'] = hashlib.sha256(output.read_bytes()).hexdigest()
        record['rotation'] = 90
    dest = pack / f'materials/entities/mcv_{name}.png'
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_bytes(Path(record['output']).read_bytes() if Path(record['output']).is_absolute()
                     else (ROOT / record['output']).read_bytes())
    records.append(record)
preview(records, out)
# make() already merges these records into the existing manifest.
print(f'Rendered {len(records)} icons:', out)

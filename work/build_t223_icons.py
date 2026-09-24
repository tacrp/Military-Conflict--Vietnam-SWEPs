"""Render the game's original T223 and extended/SOG SVG icons; no game launch."""
from pathlib import Path
import io
import cairosvg
from PIL import Image
from vpklib import VPK
from pack_paths import ROOT, PART2

out = ROOT / 'work/t223_icons'
out.mkdir(exist_ok=True)
vpk = VPK('D:/SteamLibrary/steamapps/common/Military Conflict - Vietnam/vietnam/pak01_dir.vpk')
previews = []
for source, target in [('t223', 't223_25'), ('t223_sog', 't223')]:
    svg = vpk.read(f'materials/panorama/images/icons/equipment/weapon_{source}.svg')
    (out / (source+'.svg')).write_bytes(svg)
    image = Image.open(io.BytesIO(cairosvg.svg2png(bytestring=svg, output_width=2048))).convert('RGBA')
    image = image.crop(image.getbbox())
    scale = min(512/image.width, 256/image.height)
    image = image.resize((round(image.width*scale), round(image.height*scale)), Image.Resampling.LANCZOS)
    canvas = Image.new('RGBA',(512,512))
    canvas.alpha_composite(image,((512-image.width)//2,(512-image.height)//2))
    canvas.save(PART2 / f'materials/entities/mcv_{target}.png')
    previews.append(canvas)
vpk.close()
preview = Image.new('RGBA',(1024,512),(65,65,65,255))
for i, image in enumerate(previews): preview.alpha_composite(image,(512*i,0))
preview.convert('RGB').save(out/'preview.png')
print('Rendered original 25R (left) and extended base T223 (right).')

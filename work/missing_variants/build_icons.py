"""Render only the four restored variants' original game SVG icons."""
import io
from pathlib import Path
import sys

import cairosvg
from PIL import Image

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "work"))
from vpklib import VPK
from pack_paths import asset_path

VARIANTS = {"m16a1_xm3": "m16a1_xm3", "m16a1_sog": "m16a1_sog",
            "kar98k_zf41": "kar98_zf41", "stg44_zf41": "stg44_zf41"}

if __name__ == "__main__":
    game = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("D:/SteamLibrary/steamapps/common/Military Conflict - Vietnam/vietnam")
    vpk = VPK(str(game / "pak01_dir.vpk"))
    for source, target in VARIANTS.items():
        paths = [p for p in vpk.entries if p.endswith(f"/weapon_{source}.svg")]
        path = next((p for p in paths if "/new/" in p), paths[0])
        svg = vpk.read(path)
        (Path(__file__).parent / (source + ".svg")).write_bytes(svg)
        im = Image.open(io.BytesIO(cairosvg.svg2png(bytestring=svg, output_width=1024))).convert("RGBA")
        im = im.crop(im.getbbox())
        scale = min(512 / im.width, 256 / im.height)
        im = im.resize((round(im.width * scale), round(im.height * scale)), Image.Resampling.LANCZOS)
        canvas = Image.new("RGBA", (512, 512), (255, 255, 255, 0))
        canvas.paste(im, ((512-im.width)//2, (512-im.height)//2), im)
        canvas.save(asset_path("materials/entities/mcv_" + target + ".png"))
        print(target)
    vpk.close()

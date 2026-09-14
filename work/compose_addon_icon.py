"""Pack original HUD icons into alternating rows beneath the actual MCV wordmark."""
import argparse
import hashlib
import json
import random
import re
from pathlib import Path

import numpy as np
from PIL import Image, ImageDraw, ImageFilter, ImageFont, ImageOps

ADDON = Path(__file__).resolve().parents[1]
ROOT = ADDON / 'work/artwork'
S = 2048


def icon_pool():
    # Require an original-game viewmodel, so kitbashes cannot enter the shuffle.
    originals = set()
    for script in (ADDON / 'work/cscripts').glob('weapon_*.txt'):
        originals.update(re.findall(r'"viewmodel"\s+"models/weapons/([^"/]+)"',
                                     script.read_text(errors='replace'), re.I))
    excluded = {'Equipment', 'Grenades', 'Explosives', 'Melee'}
    icons, seen = [], set()
    for weapon in sorted((ADDON / 'lua/weapons').glob('mcv_*.lua')):
        text = weapon.read_text(errors='replace')
        if not re.search(r'SWEP.Spawnable\s*=\s*true', text):
            continue
        model = re.search(r'SWEP.ViewModel\s*=\s*"models/weapons/mcv/([^"/]+)"', text)
        category = re.search(r'SWEP.SubCategory\s*=\s*"([^"]+)"', text)
        if not model or model[1] not in originals or not category or category[1] in excluded:
            continue
        override = re.search(r'SWEP.IconOverride\s*=\s*"([^"]+)"', text)
        path = ADDON / 'materials' / (override[1] if override else f'entities/{weapon.stem}.png')
        if not path.exists():
            continue
        icon = Image.open(path).convert('RGBA')
        icon = icon.crop(icon.getchannel('A').getbbox())
        fingerprint = hashlib.sha256(icon.tobytes()).hexdigest()
        if fingerprint in seen:
            continue
        seen.add(fingerprint)
        icons.append((weapon.stem, path, icon))
    return icons


def tracked_text(canvas, line, size, spacing, top, bold=False):
    font = ImageFont.truetype('C:/Windows/Fonts/' + ('arialbd.ttf' if bold else 'arial.ttf'), size)
    lengths = [font.getlength(c) for c in line]
    left = (S - sum(lengths) - spacing * (len(line) - 1)) / 2
    mask = Image.new('L', (S, S))
    draw = ImageDraw.Draw(mask)
    baseline = top - font.getbbox(line, anchor='ls')[1]
    for char, length in zip(line, lengths):
        draw.text((left, baseline), char, font=font, fill=255, anchor='ls')
        left += length + spacing
    shadow = Image.new('RGBA', (S, S), (0, 0, 0))
    shadow.putalpha(mask.filter(ImageFilter.GaussianBlur(8)))
    canvas.alpha_composite(shadow)
    letters = Image.new('RGBA', (S, S), (244, 243, 233))
    letters.putalpha(mask)
    canvas.alpha_composite(letters)


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--seed', type=int, help='Choose another random arrangement')
    args = ap.parse_args()
    manifest = ROOT / 'hud-icon-layout.json'
    seed = args.seed
    if seed is None:
        seed = json.loads(manifest.read_text())['seed'] if manifest.exists() else random.SystemRandom().randrange(2**32)
    rng = random.Random(seed)
    pool = icon_pool()
    rng.shuffle(pool)
    canvas = Image.new('RGBA', (S, S), (15, 19, 17, 255))
    placements = []
    index = 0
    for row in range(12):
        left = -rng.randrange(90, 340)
        center_y = 43 + row * 185
        while left < S:
            name, path, original = pool[index]
            index += 1
            icon = original.copy()
            scale = min(168 / icon.height, 640 / icon.width)
            icon = icon.resize((round(icon.width * scale), round(icon.height * scale)), Image.Resampling.LANCZOS)
            if row % 2:
                icon = ImageOps.mirror(icon)
            # Retain the HUD artwork's solid fill and internal lines, in dark olive grey.
            values = np.asarray(icon, dtype=np.float32).copy()
            luminance = values[..., :3].mean(axis=2) / 255
            values[..., :3] = np.array([23, 28, 24]) + luminance[..., None] * np.array([57, 59, 49])
            icon = Image.fromarray(np.uint8(np.clip(values, 0, 255)))
            top = round(center_y - icon.height / 2)
            canvas.alpha_composite(icon, (left, top))
            placements.append(dict(weapon=name, icon=str(path.relative_to(ADDON)).replace('\\', '/'),
                                   row=row, direction='left' if row % 2 else 'right',
                                   box=[left, top, icon.width, icon.height]))
            left += icon.width + 28

    # A restrained darkening behind the title keeps the continuous rows visible.
    y, x = np.mgrid[0:S, 0:S].astype(np.float32) / S
    center = np.exp(-(((x - .5) / .50)**4 + ((y - .51) / .235)**4) * 2)
    vignette = np.clip(1 - ((x - .5)**2 + (y - .5)**2) * .30, .85, 1)
    pixels = np.asarray(canvas.convert('RGB'), dtype=np.float32)
    pixels *= ((.94 - .43 * center) * vignette)[..., None]
    canvas = Image.fromarray(np.uint8(pixels)).convert('RGBA')
    canvas.convert('RGB').save(ROOT / 'weapon-pattern-background.png')

    logo = Image.open(ROOT / 'references/mcv_logo_original.png').convert('RGBA')
    logo = logo.crop(logo.getchannel('A').getbbox())
    logo = logo.resize((1536, round(logo.height * 1536 / logo.width)), Image.Resampling.LANCZOS)
    position = ((S - logo.width) // 2, 680)
    mask = Image.new('L', (S, S))
    mask.paste(logo.getchannel('A'), position)
    shadow = Image.new('RGBA', (S, S), (0, 0, 0))
    shadow.putalpha(mask.filter(ImageFilter.MaxFilter(7)).filter(ImageFilter.GaussianBlur(7)))
    canvas.alpha_composite(shadow)
    canvas.alpha_composite(logo, position)
    tracked_text(canvas, 'WEAPONS', 106, 22, 1405, bold=True)
    tracked_text(canvas, 'An Arctic Mod', 83, 5, 1840)

    rgb = canvas.convert('RGB')
    rgb.save(ROOT / 'addon-icon-hd.png')
    rgb.resize((512, 512), Image.Resampling.LANCZOS).save(ROOT / 'addon-icon-512.png')
    manifest.write_text(json.dumps(dict(seed=seed, eligible_icons=len(pool), placements=placements), indent=2) + '\n')
    print(f'{len(placements)} distinct icons from {len(pool)} original-game HUD icons; seed {seed}')
    print(ROOT / 'addon-icon-hd.png')


if __name__ == '__main__':
    main()

"""Compose native weapon renders and the original MCV wordmark. No imagegen."""
from pathlib import Path
import numpy as np
from PIL import Image, ImageDraw, ImageFont, ImageFilter, ImageEnhance

ROOT = Path(__file__).resolve().parent / 'artwork'
S = 2048
rng = np.random.default_rng(1968)
y, x = np.mgrid[0:S, 0:S].astype(np.float32)
X, Y = x / S, y / S
canvas = Image.new('RGBA', (S, S), (33, 35, 28, 255))


def paste_weapon(name, angle, size, center):
    im = Image.open(ROOT/'references'/f'icon_asset_{name}_alpha.png').convert('RGBA')
    im = im.crop(im.getbbox())
    im = ImageEnhance.Brightness(im).enhance(1.35)
    im = im.resize((size, round(im.height*size/im.width)), Image.Resampling.LANCZOS)
    im = im.rotate(angle, Image.Resampling.BICUBIC, expand=True)
    pos = (round(center[0]-im.width/2), round(center[1]-im.height/2))
    # Broad contact shadows help the overlapping receivers read as a dense pile.
    shadow_mask = Image.new('L', (S, S))
    shadow_mask.paste(im.getchannel('A'), (pos[0]+10, pos[1]+30))
    shadow = Image.new('RGBA', (S, S), (0, 0, 0, 0))
    shadow.putalpha(shadow_mask.filter(ImageFilter.GaussianBlur(19)))
    canvas.alpha_composite(shadow)
    canvas.alpha_composite(im, pos)


# Original-game oddities only. Frame the title with the distinctive magazines,
# launch tubes and pistol silhouettes instead of hiding them behind the logo.
paste_weapon('gyrojet_carbine', -24, 2550, (1050, 1080))
paste_weapon('chinalake', -24, 2360, (860, 470))
paste_weapon('dp28', 18, 1750, (600, 140))
paste_weapon('lpo50', 18, 1540, (900, 430))
paste_weapon('m202', -24, 1200, (1340, 255))
paste_weapon('owen', -62, 1640, (185, 1080))
paste_weapon('mat49_sog', -61, 1550, (1900, 1060))
paste_weapon('ppsh41dd', -24, 1780, (1260, 1590))
paste_weapon('gyrojet_pistol', -15, 880, (450, 1660))
paste_weapon('welrod', -28, 1180, (1000, 1960))
paste_weapon('qspr', 18, 660, (1750, 1790))

# Keep the weapon detail visible around the edge while supporting the title.
pixels = np.asarray(canvas.convert('RGB'), dtype=np.float32)
center = np.exp(-(((X-.5)/.49)**4 + ((Y-.52)/.23)**4)*2)
vignette = np.clip(1 - ((X-.5)**2 + (Y-.5)**2)*.55, .70, 1)
shade = (.78 - .23*center)*vignette
pixels *= shade[..., None]
pixels *= np.array([1.02, 1.01, .91])
pixels += rng.normal(0, .65, (S, S, 1))
canvas = Image.fromarray(np.uint8(np.clip(pixels, 0, 255))).convert('RGBA')
canvas.convert('RGB').save(ROOT/'weapon-collage-background.png')

# The original transparent menu logo preserves the real game's exact lettering.
logo = Image.open(ROOT/'references'/'mcv_logo_original.png').convert('RGBA')
logo = logo.crop(logo.getbbox())
logo = logo.resize((1536, round(logo.height*1536/logo.width)), Image.Resampling.LANCZOS)
position = ((S-logo.width)//2, 680)
mask = Image.new('L', (S, S))
mask.paste(logo.getchannel('A'), position)
shadow = Image.new('RGBA', (S, S), (0, 0, 0, 0))
shadow.putalpha(mask.filter(ImageFilter.MaxFilter(7)).filter(ImageFilter.GaussianBlur(7)))
canvas.alpha_composite(shadow)
canvas.alpha_composite(logo, position)


def tracked_text(line, size, spacing, top, color, bold=False):
    font = ImageFont.truetype('C:/Windows/Fonts/' + ('arialbd.ttf' if bold else 'arial.ttf'), size)
    lengths = [font.getlength(c) for c in line]
    width = sum(lengths) + spacing*(len(line)-1)
    left = (S-width)/2
    mask = Image.new('L', (S, S))
    draw = ImageDraw.Draw(mask)
    baseline = top - font.getbbox(line, anchor='ls')[1]
    for c, length in zip(line, lengths):
        draw.text((left, baseline), c, font=font, fill=255, anchor='ls')
        left += length + spacing
    shadow = Image.new('RGBA', (S, S), (0, 0, 0, 0))
    shadow.putalpha(mask.filter(ImageFilter.GaussianBlur(7)))
    canvas.alpha_composite(shadow)
    text = Image.new('RGBA', (S, S), color)
    text.putalpha(mask)
    canvas.alpha_composite(text)


tracked_text('WEAPONS', 106, 22, 1405, (244, 242, 229, 255), bold=True)
tracked_text('An Arctic Mod', 83, 5, 1840, (244, 242, 229, 255))

rgb = canvas.convert('RGB')
rgb.save(ROOT/'addon-icon-hd.png')
rgb.resize((512, 512), Image.Resampling.LANCZOS).save(ROOT/'addon-icon-512.png')
print(ROOT/'addon-icon-hd.png')

"""Build question-mark spawn icons with small country flag badges.

Run from any directory. Source flag SVGs are cached beside the build manifest;
subsequent builds are offline. All badges use flat artwork and identical dimensions.
"""
from pathlib import Path
import hashlib
import io
import json
import re
import urllib.parse
import urllib.request
import cairosvg
from PIL import Image, ImageDraw, ImageFont

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
WORK = HERE / "random_weapon_icons"
SOURCES = WORK / "sources"
OUTPUT = ROOT / "materials/mcv/random"
FLAG_ICONS = "https://raw.githubusercontent.com/lipis/flag-icons/v7.5.0/"
BADGE_SIZE = (128, 88)
BADGE_POSITION = (312, 330)
HISTORICAL = {
    "su": "Flag_of_the_Soviet_Union.svg",
    "rh": "Flag_of_Rhodesia_(1968\u20131979).svg",
    "yu": "Flag_of_Yugoslavia_(1946-1992).svg",
    "de_imperial": "Flag_of_Germany_(1867\u20131918).svg",
}


def fetch(url, destination):
    if not destination.exists():
        request = urllib.request.Request(url, headers={"User-Agent": "MCV-addon-icon-builder/1.0"})
        with urllib.request.urlopen(request, timeout=30) as response:
            content = response.read()
        destination.write_bytes(content)
    return destination.read_bytes()


def flag_source(code):
    if code in HISTORICAL:
        filename = HISTORICAL[code]
        digest = hashlib.md5(filename.encode()).hexdigest()
        url = "https://upload.wikimedia.org/wikipedia/commons/" + digest[0] + "/" + digest[:2] + "/" + urllib.parse.quote(filename)
        credit = "Wikimedia Commons; public-domain flag artwork"
        page = "https://commons.wikimedia.org/wiki/File:" + urllib.parse.quote(filename)
    else:
        url = FLAG_ICONS + "flags/4x3/" + code + ".svg"
        credit = "flag-icons: Panayiotis Lipiridis and contributors; MIT"
        page = "https://github.com/lipis/flag-icons/blob/v7.5.0/flags/4x3/" + code + ".svg"
    # Keep the old emoji cache separate so an offline rebuild cannot reuse it.
    cache = SOURCES if code in HISTORICAL else SOURCES / "flag-icons-v7.5.0"
    cache.mkdir(parents=True, exist_ok=True)
    destination = cache / (code + ".svg")
    return fetch(url, destination), {"flag": code, "url": url, "source_page": page, "credit": credit}


def main():
    SOURCES.mkdir(parents=True, exist_ok=True)
    OUTPUT.mkdir(parents=True, exist_ok=True)
    text = (ROOT / "lua/mcv/shared/sh_random_weapons.lua").read_text(encoding="utf-8")
    # Themes can use their own historical flag, such as WW2 Germany.
    flags = sorted(set(re.findall(r'(?:country|theme)\("[^"]+", "[^"]+", "([a-z_]+)"', text)))
    font = ImageFont.truetype("C:/Windows/Fonts/segoeuib.ttf", 330)
    question = Image.new("RGBA", (512, 512))
    draw = ImageDraw.Draw(question)
    x0, y0, x1, y1 = draw.textbbox((0, 0), "?", font=font)
    draw.text((256 - (x0 + x1) / 2, 238 - (y0 + y1) / 2), "?", font=font, fill="white")
    question.save(OUTPUT / "question.png")
    records = []
    for code in flags:
        svg, record = flag_source(code)
        badge = Image.open(io.BytesIO(cairosvg.svg2png(bytestring=svg, output_width=256))).convert("RGBA")
        badge = badge.crop(badge.getbbox())
        badge = badge.resize(BADGE_SIZE, Image.Resampling.LANCZOS)
        icon = question.copy()
        icon.alpha_composite(badge, BADGE_POSITION)
        destination = OUTPUT / (code + ".png")
        icon.save(destination)
        record.update({"style": "flat_rectangle", "badge_size": BADGE_SIZE,
                       "badge_position": BADGE_POSITION,
                       "source_sha256": hashlib.sha256(svg).hexdigest(),
                       "output": destination.relative_to(ROOT).as_posix(),
                       "png_sha256": hashlib.sha256(destination.read_bytes()).hexdigest()})
        records.append(record)
        print(code, flush=True)
    (WORK / "manifest.json").write_text(json.dumps(records, indent=2) + "\n")
    license_text = fetch(FLAG_ICONS + "LICENSE", SOURCES / "flag-icons-v7.5.0/LICENSE.txt")
    credits = ROOT / "licenses/mcv_random_flags"
    credits.mkdir(parents=True, exist_ok=True)
    (credits / "FLAG-ICONS-LICENSE.txt").write_bytes(license_text)
    (credits / "ATTRIBUTION.txt").write_text(
        "Question-mark badge composites for the MCV addon.\n"
        "Modern flags: flag-icons v7.5.0, Copyright (c) 2013 Panayiotis Lipiridis.\n"
        "https://github.com/lipis/flag-icons/tree/v7.5.0\n"
        "MIT license: see FLAG-ICONS-LICENSE.txt.\n"
        "Modifications: rasterized, normalized to a common rectangular badge,\n"
        "and combined with a white question mark.\n"
        "Earlier builds used Twemoji; its retained license covers the old cached\n"
        "sources and validation screenshots, not the current installed icons.\n\n"
        + "\n".join(r["flag"] + ": " + r["credit"] + "\n" + r["source_page"] for r in records if r["flag"] in HISTORICAL)
        + "\n", encoding="utf-8")
    columns, tile = 6, 180
    all_names = ["question", *flags]
    sheet = Image.new("RGB", (columns * tile, ((len(all_names) + columns - 1) // columns) * tile), (48, 52, 56))
    label_font = ImageFont.truetype("C:/Windows/Fonts/segoeui.ttf", 16)
    draw = ImageDraw.Draw(sheet)
    for i, code in enumerate(all_names):
        im = Image.open(OUTPUT / (code + ".png")).resize((150, 150), Image.Resampling.LANCZOS)
        x, y = (i % columns) * tile, (i // columns) * tile
        sheet.paste(im, (x + 15, y), im)
        draw.text((x + 80, y + 155), code, fill="white", font=label_font)
    sheet.save(WORK / "preview.png")
    print(f"Installed question mark and {len(flags)} flag badges.")


if __name__ == "__main__":
    main()

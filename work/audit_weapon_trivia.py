"""Audit both packs, or --apply targeted metadata edits; emit a complete TSV inventory."""
import argparse
import csv
import re
from functools import lru_cache
from pathlib import Path
from pack_paths import ROOT, PART2
from weapon_countries import canonical_country
from weapon_trivia import gameplay_ammo, trivia_caliber, CATEGORY_OVERRIDES


def catalog():
    files = {}
    for pack in (ROOT, PART2):
        for path in (pack / "lua/weapons").glob("*.lua"):
            assert path.stem not in files, path
            files[path.stem] = path
        for path in (pack / "lua/weapons").glob("*/shared.lua"):
            files[path.parent.name] = path
    return files


def resolver(files):
    @lru_cache(None)
    def fields(name):
        path = files.get(name)
        if not path:
            return {}
        text = re.sub(r"//[^\n]*", "", path.read_text(encoding="utf-8"))
        own = dict(re.findall(r'SWEP\.([\w.]+)\s*=\s*"([^"\n]*)"', text))
        own.update({k: v == "true" for k, v in re.findall(r'SWEP\.([\w.]+)\s*=\s*(true|false)\b', text)})
        base = own.get("Base")
        inherited = fields(base) if base and base != name else {}
        return {**inherited, **own}
    return fields


def desired(name, current):
    short = name.removeprefix("mcv_")
    caliber = trivia_caliber(name, current.get("Caliber", ""))
    category = CATEGORY_OVERRIDES.get(short, current.get("SubCategory", ""))
    values = {"Country": canonical_country(name, current.get("Country", "")), "Caliber": caliber,
              "SubCategory": category, "Primary.Ammo": gameplay_ammo(name, category, caliber, current.get("Primary.Ammo", ""))}
    if current.get("HasRifleGrenade") and name != "mcv_m16_flamer":
        values["Secondary.Ammo"] = "smg1_grenade"
    return values


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--apply", action="store_true")
    args = parser.parse_args()
    files = catalog()
    fields = resolver(files)
    changes = []
    targets = {name: desired(name, fields(name)) for name, p in files.items() if p.name != "shared.lua"}
    # Compare inherited values against the proposed parent as well: e.g. SVD Irons
    # needs its own AR2 override when its sniper parent switches to .357.
    for name, values in targets.items():
        path = files[name]
        text = path.read_bytes().decode("utf-8")
        newline = "\r\n" if "\r\n" in text else "\n"
        base = fields(name).get("Base")
        for key, value in values.items():
            pattern = re.compile(r'(^SWEP\.' + re.escape(key) + r'\s*=\s*)"([^"\n]*)"', re.M)
            match = pattern.search(text)
            effective = match[2] if match else targets.get(base, {}).get(key, fields(name).get(key, ""))
            if effective == value:
                continue
            changes.append((name, key, effective, value))
            if match:
                text = text[:match.start(2)] + value + text[match.end(2):]
            else:
                text += newline + f'SWEP.{key} = "{value}"' + newline
        if args.apply and text.encode("utf-8") != path.read_bytes():
            path.write_bytes(text.encode("utf-8"))
    fields = resolver(files)
    destination = ROOT / "work/weapon_trivia_audit.tsv"
    with destination.open("w", encoding="utf-8", newline="") as stream:
        writer = csv.writer(stream, delimiter="\t")
        writer.writerow(["Class", "Pack", "Spawnable", "Name", "Category", "Country", "Caliber", "Primary ammo", "Secondary ammo"])
        for name in sorted(targets):
            f, p = fields(name), files[name]
            writer.writerow([name, "Part 1" if p.is_relative_to(ROOT) else "Part 2", f.get("Spawnable", False)] +
                            [f.get(k, "") for k in ("PrintName", "SubCategory", "Country", "Caliber", "Primary.Ammo", "Secondary.Ammo")])
    for change in changes:
        print(" | ".join(map(str, change)))
    print(f"{len(targets)} definitions audited; {len(changes)} field changes {'applied' if args.apply else 'needed'}.")


if __name__ == "__main__":
    main()

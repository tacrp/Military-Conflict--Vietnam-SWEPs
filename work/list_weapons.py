"""Export the spawnable weapon roster from the actual Lua definitions."""
from pathlib import Path
import re
from collections import defaultdict

ROOT = Path(__file__).resolve().parent.parent
CUSTOM = {"mcv_m635", "mcv_xm16super", "mcv_ptrd_sniper"}


def main():
    definitions = {}
    for path in sorted((ROOT / "lua/weapons").glob("*.lua")):
        source = path.read_text(encoding="utf-8-sig")
        values = dict(re.findall(r'^SWEP\.(\w+)\s*=\s*"([^"\n]*)"', source, re.M))
        values["spawnable"] = bool(re.search(r'^SWEP\.Spawnable\s*=\s*true\b', source, re.M))
        definitions[path.stem] = values

    def inherited(name, key):
        seen = set()
        while name in definitions and name not in seen:
            seen.add(name)
            definition = definitions[name]
            if key in definition:
                return definition[key]
            name = definition.get("Base")
        raise ValueError(f"Missing {key} for {name}")

    groups = defaultdict(list)
    for name, definition in definitions.items():
        if definition["spawnable"]:
            groups[inherited(name, "SubCategory")].append((inherited(name, "PrintName"), name))
    count = sum(map(len, groups.values()))
    lines = ["# Military Conflict: Vietnam — weapon list", "",
             f"{count} spawnable weapon and equipment classes in the addon. "
             "Names and categories come from the current Lua definitions. "
             "Separate variants count separately; dual wield and grenade-launcher modes "
             "within a weapon do not add another class. Custom kitbashes are marked below.", ""]
    for category, entries in sorted(groups.items()):
        lines.extend([f"## {category} ({len(entries)})", "", "| Weapon | Class |", "| --- | --- |"])
        for label, name in sorted(entries, key=lambda entry: (entry[0].casefold(), entry[1])):
            suffix = " — custom kitbash" if name in CUSTOM else ""
            lines.append(f"| {label}{suffix} | `{name}` |")
        lines.append("")
    disabled = [(entry["PrintName"], name) for name, entry in definitions.items()
                if not entry["spawnable"] and entry.get("PrintName")]
    if disabled:
        lines.extend(["## Defined but not spawnable", "", "| Weapon | Class |", "| --- | --- |"])
        lines.extend(f"| {label} | `{name}` |" for label, name in sorted(disabled))
        lines.append("")
    destination = ROOT / "WEAPON_LIST.md"
    destination.write_text("\n".join(lines), encoding="utf-8")
    print(f"{count} classes -> {destination}")
    for category, entries in sorted(groups.items()):
        print(f"{category}: {len(entries)}")


if __name__ == "__main__":
    main()

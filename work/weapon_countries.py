"""Canonical country labels and corrections to the game's origin metadata.

Use country names rather than mixing regions, formal state names and short names.
Retain Czechoslovakia and the Soviet Union, which are distinct historical states.
These labels do not move assets between the two packs.
"""
ALIASES = {
    "Democratic Republic of Vietnam": "Vietnam", "North Vietnam": "Vietnam",
    "People's Republic of China": "China", "Shanxi Province": "China",
    "Empire of Japan": "Japan",
    "Nazi Germany": "Germany", "German Reich": "Germany", "German Empire": "Germany",
    "Kingdom of Denmark": "Denmark", "Kingdom of Spain": "Spain",
    "Polish People's Republic": "Poland", "Republic of Rhodesia": "Rhodesia",
    "Democratic People's Republic of Korea": "North Korea",
}
CORRECTIONS = {
    "cz52": "Czechoslovakia", "vz24": "Czechoslovakia",
    "vz54": "Czechoslovakia", "vz54s": "Czechoslovakia",
    "vz59": "Czechoslovakia", "vz59b": "Czechoslovakia",
    "g3": "Germany", "babybrowning": "Belgium",
    "m38": "Soviet Union", "m38_s": "Soviet Union", "m91": "Soviet Union",
    "v40": "Netherlands",
}


def canonical_country(name, country):
    return CORRECTIONS.get(name.removeprefix("mcv_"), ALIASES.get(country, country))


if __name__ == "__main__":
    import re
    from pathlib import Path
    root = Path(__file__).resolve().parents[1]
    for pack in (root, root.parent / "mcv-2"):
        for path in sorted((pack / "lua/weapons").glob("*.lua")):
            raw = path.read_bytes()
            text = raw.decode("utf-8")
            match = re.search(r'^SWEP.Country = "([^"]*)"', text, re.M)
            if not match:
                continue
            value = canonical_country(path.stem, match[1])
            if value != match[1]:
                updated = text[:match.start(1)] + value + text[match.end(1):]
                path.write_bytes(updated.encode("utf-8"))
                print(f"{pack.name}/{path.name}: {match[1]} -> {value}")

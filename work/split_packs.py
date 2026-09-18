"""Plan and maintain the Eastern/base and Western/content-only addon split.

Planning is read-only except for its report. --apply moves only manifest-listed files,
after hashing and checking both absolute roots. --verify checks the installed split.
"""
from collections import Counter, defaultdict
from functools import lru_cache
import argparse
import hashlib
import json
from pathlib import Path
import re
import struct
import os
from pack_paths import part2_root

ROOT = Path(__file__).resolve().parents[1]
PART2 = part2_root(ROOT)
OUT = ROOT / "work/pack_split"
FOLDERS = ("lua", "materials", "models", "sound", "particles", "shaders")
EAST = {"Soviet Union", "Russian Empire", "Russia", "Czechoslovakia", "Hungary",
        "Polish People's Republic", "Romania", "Yugoslavia", "People's Republic of China",
        "Shanxi Province", "Democratic People's Republic of Korea", "Empire of Japan",
        "Vietnam", "North Vietnam", "Democratic Republic of Vietnam"}
WEST = {"United States of America", "United Kingdom", "Australia", "Belgium", "France",
        "German Empire", "German Reich", "Nazi Germany", "Germany", "Finland", "Israel",
        "Italy", "Kingdom of Denmark", "Kingdom of Spain", "Sweden", "Republic of Rhodesia", "Rhodesia"}
OVERRIDES = {"mcv_ammobox_us": "western", "mcv_binoculars_us": "western", "mcv_medicbox_us": "western",
             "mcv_ammobox_vc": "eastern", "mcv_binoculars_vc": "eastern", "mcv_medicbox_vc": "eastern",
             "mcv_fists": "eastern", "mcv_wrench": "eastern", "mcv_crowbar": "eastern"}


def clean(value):
    return re.sub(r"/+", "/", value.replace("\\", "/")).lower().strip()


def strings(text):
    text = re.sub(r"//[^\n]*", "", text)
    return re.findall(r'"([^"\n]*)"', text)


def sha(path):
    with path.open("rb") as f:
        return hashlib.file_digest(f, "sha256").hexdigest()


class Audit:
    def __init__(self):
        self.files = {}
        for root in (ROOT, PART2):
            for folder in FOLDERS:
                for p in (root / folder).rglob("*"):
                    if p.is_file():
                        key = p.relative_to(root).as_posix().lower()
                        assert key not in self.files, f"Duplicate mounted path: {key}"
                        self.files[key] = p
        self.sounds = {}
        for key, p in self.files.items():
            if key.startswith("lua/mcv/shared/sh_soundscript_"):
                for block in p.read_text(encoding="utf8").split("sound.Add(")[1:]:
                    name = re.search(r'name\s*=\s*"([^"]+)"', block)
                    if name:
                        self.sounds[name[1].lower()] = {"sound/" + clean(s).lstrip("*#@<>")
                            for s in strings(block) if s.lower().endswith((".wav", ".mp3"))}
                        self.sounds[name[1].lower()] = {p.replace("sound/)", "sound/") for p in self.sounds[name[1].lower()]}
        self.weapons = {Path(k).stem: p for k, p in self.files.items()
                        if k.startswith("lua/weapons/") and k.count("/") == 2 and k.endswith(".lua")}
        self.refs = defaultdict(set)
        self.missing = defaultdict(set)

    @lru_cache(None)
    def fields(self, name):
        if name in self.weapons:
            p = self.weapons[name]
        else:
            p = self.files.get(f"lua/weapons/{name}/shared.lua")
        if not p:
            return {}
        raw = re.sub(r"//[^\n]*", "", p.read_text(encoding="utf8"))
        fields = dict(re.findall(r'SWEP\.([\w.]+)\s*=\s*"([^"\n]*)"', raw))
        base = fields.get("Base")
        return {**(self.fields(base) if base and base != name else {}), **fields}

    def path_refs(self, values):
        out = set()
        for v in values:
            v = clean(v).lstrip(")*#@<>^}")
            if v in self.sounds:
                out.update(self.sounds[v])
            if v.startswith("models/") and v.endswith(".mdl"):
                out.add(v)
            elif v.endswith((".wav", ".mp3")):
                out.add(v if v.startswith("sound/") else "sound/" + v)
            elif "/" in v and not v.startswith(("$", "!")):
                v = v if v.startswith("materials/") else "materials/" + v
                out.update(k for k in (v, v+".vmt", v+".vtf", v+".png") if k in self.files)
        return out

    @lru_cache(None)
    def dependencies(self, key):
        out = set()
        path = self.files.get(key)
        if not path:
            return out
        if key.endswith(".mdl"):
            d = path.read_bytes()
            if d[:4] != b"IDST":
                raise ValueError(key)
            number = lambda off: struct.unpack_from("<i", d, off)[0]
            string = lambda off: d[off:d.index(b"\0", off)].decode("latin1")
            stem = key[:-4]
            out.update(k for k in self.files if k.startswith(stem+".") and k != key)
            count, offset = number(204), number(208)
            dirs = [clean(string(number(number(216)+i*4))) for i in range(number(212))]
            for i in range(count):
                at = offset+i*64
                material = clean(string(at+number(at)))
                candidates = ["materials/"+dr+material+".vmt" for dr in dirs]
                candidates += ["materials/"+material+".vmt"]
                found = next((p for p in candidates if p in self.files), None)
                if found:
                    out.add(found)
                else:
                    self.missing[key].add("material:"+material)
            # Authored animation events hold the reload/cycle sound-script names.
            for s in re.findall(rb"[ -~]{4,}", d):
                value = s.decode("ascii").lower()
                if value in self.sounds:
                    out.update(self.sounds[value])
                elif value.endswith(".mdl"):
                    value = clean(value)
                    value = value if value.startswith("models/") else "models/"+value
                    if value in self.files and value != key:
                        out.add(value)
        elif key.endswith(".vmt"):
            out.update(self.path_refs(strings(path.read_text(encoding="utf8", errors="replace"))))
        return out

    def closure(self, initial, owner):
        pending, seen = list(initial), set()
        while pending:
            key = pending.pop()
            if key in seen:
                continue
            seen.add(key)
            if key not in self.files:
                self.missing[owner].add(key)
                continue
            self.refs[key].add(owner)
            pending.extend(self.dependencies(key)-seen)
        return seen & self.files.keys()

    def plan(self):
        catalog = {}
        for name, path in sorted(self.weapons.items()):
            raw = path.read_text(encoding="utf8")
            if not re.search(r"SWEP.Spawnable\s*=\s*true", raw):
                continue
            fields = self.fields(name)
            country = fields.get("Country", "")
            part = OVERRIDES.get(name) or ("eastern" if country in EAST else "western" if country in WEST else None)
            assert part, (name, country)
            base = fields.get("Base")
            values = [*fields.values(), *strings(raw)]
            # Inline code in inherited gun definitions may also use assets.
            while base in self.weapons:
                values += strings(self.weapons[base].read_text(encoding="utf8"))
                base = self.fields(base).get("Base")
            own = {f"lua/weapons/{name}.lua", f"materials/entities/{name}.png"}
            assets = self.closure(self.path_refs(values) | (own & self.files.keys()), part)
            catalog[name] = {"part": part, "country": country, "name":fields.get("PrintName", name),
                             "base": fields.get("Base"), "assets":sorted(assets)}
        # Shared implementation stays in Part 1, as do all assets it references.
        for key, path in self.files.items():
            if not key.startswith("lua/") or not key.endswith(".lua") or Path(key).stem in catalog:
                continue
            if key.startswith("lua/mcv_harness/") or key == "lua/autorun/sh_mcv_harness.lua" or "sh_soundscript_" in key:
                continue
            self.closure(self.path_refs(strings(path.read_text(encoding="utf8", errors="replace"))), "shared")
        # Dynamic shader/particle references and global effect assets belong to the base.
        for key in self.files:
            if key.startswith(("materials/effects/", "materials/particle", "materials/sprites/", "particles/", "shaders/")):
                self.closure({key}, "shared")
        assignments = {k:("western" if self.refs[k] == {"western"} else "eastern") for k in self.files}
        # Preserve unused skins/textures alongside the weapon family that owns them.
        # This also covers the original non-mcv material folders left by the initial rip.
        families = defaultdict(set)
        for key, owners in list(self.refs.items()):
            m = re.match(r"materials/models/weapons/(?:mcv/)?([^/]+)/", key)
            if m:
                families[m[1]].update(owners)
        for key in self.files:
            if self.refs[key]:
                continue
            m = re.match(r"materials/models/weapons/(?:mcv/)?([^/]+)/", key)
            if m and families[m[1]] == {"western"}:
                assignments[key] = "western"
        # Inheritance may not point from the standalone Eastern pack into Part 2.
        for name, item in catalog.items():
            if item["part"] == "eastern" and item["base"] in catalog:
                assert catalog[item["base"]]["part"] == "eastern", (name, item["base"])
        totals = Counter()
        sizes = Counter()
        for key, part in assignments.items():
            size = self.files[key].stat().st_size
            totals[part] += size
            sizes[part+":"+key.split("/")[0]] += size
        result = {"roots":{"eastern":str(ROOT),"western":str(PART2)}, "bytes":dict(totals),
                  "bytesByFolder":dict(sizes), "weapons":catalog, "assignments":assignments,
                  "existingMissingReferences":{k:sorted(v) for k,v in sorted(self.missing.items())},
                  "sharedAssets":sorted(k for k,v in self.refs.items() if "western" in v and len(v)>1)}
        OUT.mkdir(exist_ok=True)
        (OUT/"plan.json").write_text(json.dumps(result, indent=2)+"\n", encoding="utf8")
        print(json.dumps({"GiB":{k:round(v/1024**3,3) for k,v in totals.items()},
                          "weapons":dict(Counter(v["part"] for v in catalog.values())),
                          "GiBByFolder":{k:round(v/1024**3,3) for k,v in sizes.items()},
                          "missingReferenceGroups":len(self.missing)},indent=2))
        return result


def checked(root, relative):
    root = root.resolve()
    target = (root / relative).resolve()
    assert target.is_relative_to(root) and target != root, target
    return target


def apply(plan, files):
    assert PART2.resolve().parent == ROOT.resolve().parent and PART2.resolve() != ROOT.resolve()
    manifest = OUT / "moved_files.json"
    if manifest.exists():
        raise RuntimeError("This split was already applied. Use --verify; do not overwrite its recovery manifest.")
    assert not PART2.exists() or not any(PART2.iterdir()), "mcv-2 is not empty"
    records = []
    for key, part in sorted(plan["assignments"].items()):
        p = files[key]
        records.append({"path":key,"part":part,"bytes":p.stat().st_size,"sha256":sha(p),
                        "originalPath":p.relative_to(ROOT).as_posix()})
    # Persist exact contents and destinations before the first atomic, same-volume move.
    manifest.write_text(json.dumps(records, indent=2)+"\n", encoding="utf8")
    count = 0
    for row in records:
        if row["part"] != "western":
            continue
        src, dst = checked(ROOT,row["originalPath"]), checked(PART2,row["originalPath"])
        assert src.exists() and not dst.exists(), row["path"]
        assert src.stat().st_size == row["bytes"] and sha(src) == row["sha256"], src
        dst.parent.mkdir(parents=True,exist_ok=True)
        os.rename(src,dst)
        count += 1
    print(f"Moved {count} files to {PART2}; original contents recorded in {manifest}")


def verify():
    records = json.loads((OUT/"moved_files.json").read_text())
    for row in records:
        root = PART2 if row["part"] == "western" else ROOT
        p = checked(root,row["originalPath"])
        assert p.is_file() and p.stat().st_size == row["bytes"] and sha(p) == row["sha256"], row["path"]
        other = ROOT if root == PART2 else PART2
        assert not checked(other,row["path"]).exists(), "Duplicate: "+row["path"]
    audit = Audit()
    plan = audit.plan()
    for name,item in plan["weapons"].items():
        if item["part"] == "eastern":
            assert all(plan["assignments"][p] == "eastern" for p in item["assets"]), name
    western_lua = [p for p in audit.files if audit.files[p].is_relative_to(PART2) and p.startswith("lua/")]
    assert all(p.startswith("lua/weapons/mcv_") and p.count("/")==2 for p in western_lua)
    report = {"passed":True,"originalFilesVerified":len(records),"westernWeaponFiles":len(western_lua),
              "sharedAssetsInPart1":len(plan["sharedAssets"]),"bytes":plan["bytes"]}
    (OUT/"verification.json").write_text(json.dumps(report,indent=2)+"\n")
    print(json.dumps(report,indent=2))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--apply",action="store_true")
    parser.add_argument("--verify",action="store_true")
    args = parser.parse_args()
    if args.verify:
        verify()
    else:
        audit = Audit()
        plan = audit.plan()
        if args.apply:
            apply(plan,audit.files)

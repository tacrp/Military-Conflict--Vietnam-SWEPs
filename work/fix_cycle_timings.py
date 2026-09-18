"""Restore authored pump/bolt duration in existing QCs without regenerating other sequences.

python work/fix_cycle_timings.py [--compile]
Keeps a first-run QC backup and manifest under work/cycle_timings. Compilation installs
only the 19 affected viewmodel sets. Restart GMod after installing them.
"""
import argparse
from concurrent.futures import ThreadPoolExecutor
import json
from pathlib import Path
import re
import shutil
from types import SimpleNamespace

import port_qc as p
from pack_paths import asset_path

ROOT = Path(__file__).resolve().parents[1]
WORK = ROOT / "work"
OUT = WORK / "cycle_timings"


def patch_models():
    rows = []
    for source in sorted((WORK / "MCV_SMD_OG/weapons").glob("v_*/*.qc")):
        original = p.QC(source.read_text(encoding="utf8", errors="replace"))
        cycles = [s for s in original.blocks("sequence") if s.activity() == "ACT_VM_BOLTPULL"]
        if not cycles:
            continue
        path = WORK / "MCV_SMD_PORT/weapons" / source.parent.name / source.name
        raw = path.read_text(encoding="utf8")
        qc = p.QC(raw)
        ctx = p.Ctx(SimpleNamespace(fixed_root=str(WORK / "MCV_SMD")), str(source.parent), str(path.parent))
        for cycle in cycles:
            frames = max(p.anim_length(original, a, ctx) for a in cycle.anims())
            rates = {float((cycle.get("fps") or original.find("animation", a).get("fps") or "fps 30").split()[1])
                   for a in cycle.anims()}
            assert len(rates) == 1, (source.name, rates)
            fps = rates.pop()
            main = qc.find("sequence", cycle.name)
            assert main and main.activity() == "ACT_VM_RELOAD_INSERT_PULL"
            old = main.render()
            assert old in raw, (path, "sequence formatting")
            for anim in main.anims():
                base = re.sub(r"__f\d+(?:_fps[\d.]+)?$", "", anim)
                name = f"{base}__f{frames}" + (f"_fps{fps:g}" if fps != 30 else "")
                if not qc.find("animation", name):
                    block = qc.find("animation", base)
                    assert block
                    lines = [s for s in block.lines if not s.startswith(("numframes", "fps")) and s != "loop"]
                    clone = p.Block("animation", name, block.path, [f"fps {fps:g}", *lines, f"numframes {frames}"])
                    assert block.render() in raw
                    raw = raw.replace(block.render(), block.render() + "\n" + clone.render(), 1)
                    qc.insert_after(block, clone)
                main.lines = [s.replace(f'"{anim}"', f'"{name}"') for s in main.lines]
            # Restore source cues, including cues formerly clamped past the 60-frame end.
            events = [e.replace('"Weapon_', '"MCV_Weapon_') for e in cycle.events()]
            first = next(i for i, s in enumerate(main.lines) if s.startswith("{ event"))
            main.remove(lambda s: s.startswith("{ event"))
            main.lines[first:first] = events
            raw = raw.replace(old, main.render(), 1)
            rows.append({"model": source.parent.name, "sequence": cycle.name, "frames": frames,
                         "fps": fps, "duration": (frames - 1) / fps, "events": events})
        if raw != path.read_text(encoding="utf8"):
            backup = OUT / "before_qc" / source.name
            backup.parent.mkdir(parents=True, exist_ok=True)
            if not backup.exists():
                shutil.copy2(path, backup)
            path.write_text(raw, encoding="utf8", newline="\n")
    OUT.mkdir(exist_ok=True)
    (OUT / "manifest.json").write_text(json.dumps(rows, indent=2), encoding="utf8")
    return rows


def compile_model(row):
    name = row["model"]
    result = p.compile_qc(SimpleNamespace(game=str(WORK / "compile_test_game"), studiomdl=None),
                          str(WORK / "MCV_SMD_PORT/weapons" / name / (name + ".qc")))
    return name, result


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--compile", action="store_true")
    args = parser.parse_args()
    rows = patch_models()
    print(f"{len(rows)} cycle models; durations {min(r['duration'] for r in rows):.3f}–{max(r['duration'] for r in rows):.3f}s")
    if args.compile:
        with ThreadPoolExecutor(max_workers=4) as pool:
            results = dict(pool.map(compile_model, rows))
        (OUT / "compile.json").write_text(json.dumps(results, indent=2), encoding="utf8")
        assert all(r["ok"] for r in results.values()), results
        for name in results:
            for extension in (".mdl", ".vvd", ".dx80.vtx", ".dx90.vtx"):
                shutil.copy2(WORK / "compile_test_game/models/weapons/mcv" / (name + extension),
                             asset_path("models/weapons/mcv/" + name + extension))
        print(f"Compiled and installed {len(results)} viewmodels")

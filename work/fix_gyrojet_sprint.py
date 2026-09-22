"""Repair the Gyrojet movement correctives; optionally compile/install both viewmodels.

python work/fix_gyrojet_sprint.py --compile
Only existing corrective paths are patched; weapon Lua and other QC blocks are preserved.
This script never starts Garry's Mod.
"""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import struct
from types import SimpleNamespace

import numpy as np

import bake_ik
from pack_paths import asset_path
import port_qc

WORK = Path(__file__).resolve().parent
OUT = WORK / "gyrojet_sprint_fix"
MODELS = ("v_gyrojet_pistol", "v_gyrojet_carbine")
MOVEMENT = ("run_a", "walk_a")


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def motion_error(model, anim, repaired):
    source = WORK / "MCV_SMD_OG/weapons" / model / (model + "_anims")
    fixed = WORK / "MCV_SMD_PORT/weapons" / model / "fixed_anims"
    nodes, bases, _ = bake_ik.load_smd(source / "idle_a.smd")
    ids = {name: i for i, (name, _) in nodes.items()}
    gun, hand = ids["Base"], ids["hand_r"]
    world = bake_ik.fk(nodes, bases[0])
    grip = np.linalg.inv(world[hand]) @ world[gun]
    ref = {i: np.zeros(6) for i in nodes}
    corr = (fixed if repaired else source) / (anim + "_corrective_animation.smd")
    ref.update(bake_ik.load_smd(corr)[1][0])
    _, frames, _ = bake_ik.load_smd(fixed / (anim + ".smd"))
    errors = []
    for frame in frames:
        w = bake_ik.fk(nodes, bake_ik.final_pose(nodes, bases[0], ref, frame))
        held = np.linalg.inv(w[hand]) @ w[gun]
        rotation = np.degrees(np.arccos(np.clip(
            (np.trace(grip[:3, :3].T @ held[:3, :3]) - 1) / 2, -1, 1)))
        errors.append((np.linalg.norm(held[:3, 3] - grip[:3, 3]), rotation))
    position, degrees = np.max(errors, axis=0)
    return {"frames": len(frames), "max_grip_distance": float(position),
            "max_grip_angle_degrees": float(degrees)}


def model_metadata(path):
    """Read compiled sequence/event/timing data without loading the model in game."""
    data = path.read_bytes()
    assert data[:4] == b"IDST" and struct.unpack_from("<i", data, 4)[0] == 48, path
    integer = lambda off: struct.unpack_from("<i", data, off)[0]
    string = lambda off: data[off:data.index(b"\0", off)].decode("ascii")
    anim_count, anim_start, seq_count, seq_start = struct.unpack_from("<4i", data, 180)
    anims = []
    for i in range(anim_count):
        a = anim_start + i * 100
        anims.append((string(a + integer(a + 4)),
                      *struct.unpack_from("<fii", data, a + 8)))
    sequences = []
    for i in range(seq_count):
        s = seq_start + i * 212
        events = []
        count, offset = struct.unpack_from("<ii", data, s + 24)
        for j in range(count):
            e = s + offset + j * 80
            events.append((*struct.unpack_from("<fii", data, e), string(e + 12)))
        sequences.append((string(s + integer(s + 4)),
                          *struct.unpack_from("<iii", data, s + 12), events))
    return {"animations": anims, "sequences": sequences}


def patch_model(model):
    original = WORK / "MCV_SMD_OG/weapons" / model
    folder = WORK / "MCV_SMD_PORT/weapons" / model
    path = folder / (model + ".qc")
    raw = path.read_text(encoding="utf8")
    # Verify that this repair leaves the existing baked hand motion byte-identical.
    motions = {p: digest(p) for p in (folder / "fixed_anims").glob("*.smd")
               if "corrective" not in p.name}
    ctx = port_qc.Ctx(SimpleNamespace(fixed_root=str(WORK / "MCV_SMD")),
                      str(original), str(folder))
    qc = port_qc.QC((original / path.name).read_text())
    port_qc.step_fix_correctives(qc, ctx)
    edited = port_qc.QC(raw)
    for anim in MOVEMENT:
        block = edited.find("animation", anim + "_corrective_animation")
        assert block and block.render() in raw, (model, anim)
        old = block.render()
        block.path = "fixed_anims\\" + anim + "_corrective_animation.smd"
        raw = raw.replace(old, block.render(), 1)
    path.write_text(raw, encoding="utf8", newline="\n")
    assert all(digest(p) == value for p, value in motions.items()), model
    # Re-running the production correction must reproduce the same files.
    correctives = {p: digest(p) for p in (folder / "fixed_anims").glob("*_corrective_animation.smd")}
    port_qc.step_fix_correctives(qc, ctx)
    assert all(digest(p) == value for p, value in correctives.items()), model
    metrics = {}
    for anim in MOVEMENT:
        before, after = motion_error(model, anim, False), motion_error(model, anim, True)
        assert after["max_grip_angle_degrees"] < 1.2, (model, anim, after)
        assert after["max_grip_distance"] < 0.1, (model, anim, after)
        assert after["max_grip_angle_degrees"] < before["max_grip_angle_degrees"]
        assert abs(after["max_grip_distance"] - before["max_grip_distance"]) < 1e-8
        metrics[anim] = {"before": before, "after": after}
    return {"model": model, "hand_animation_sha256": {p.name: v for p, v in motions.items()},
            "corrective_sha256": {p.name: v for p, v in correctives.items()}, "motion": metrics}


def compile_and_install(rows):
    builds = []
    # Finish both compiles and checks before installing either model's companion files.
    for row in rows:
        model = row["model"]
        installed = asset_path("models/weapons/mcv/" + model + ".mdl")
        before = model_metadata(installed)
        qc = WORK / "MCV_SMD_PORT/weapons" / model / (model + ".qc")
        result = port_qc.compile_qc(SimpleNamespace(game=str(WORK / "compile_test_game"),
                                                   studiomdl=None), str(qc))
        row["compile"] = result
        assert result["ok"], (model, result)
        built = WORK / "compile_test_game/models/weapons/mcv" / (model + ".mdl")
        assert model_metadata(built) == before, (model, "sequence/event/timing changes")
        row["compiled_sequence_count"] = len(before["sequences"])
        row["compiled_animation_count"] = len(before["animations"])
        for ext in (".mdl", ".vvd", ".dx80.vtx", ".dx90.vtx"):
            src = built.with_name(model + ext)
            dst = asset_path("models/weapons/mcv/" + model + ext)
            assert src.is_file() and src.stat().st_size > 0, src
            builds.append((row, src, dst))
    for row, src, dst in builds:
        shutil.copy2(src, dst)
        value = digest(src)
        assert digest(dst) == value, dst
        row.setdefault("installed", {})[str(dst)] = value


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--compile", action="store_true")
    args = parser.parse_args()
    rows = [patch_model(model) for model in MODELS]
    if args.compile:
        compile_and_install(rows)
    OUT.mkdir(exist_ok=True)
    (OUT / "verification.json").write_text(json.dumps(rows, indent=2) + "\n", encoding="utf8")
    for row in rows:
        sprint = row["motion"]["run_a"]
        print(f"{row['model']}: maximum sprint grip angle "
              f"{sprint['before']['max_grip_angle_degrees']:.3f} -> "
              f"{sprint['after']['max_grip_angle_degrees']:.3f} degrees", flush=True)
    print("Both viewmodels compiled and installed." if args.compile else "Correctives and QCs patched.")


if __name__ == "__main__":
    main()

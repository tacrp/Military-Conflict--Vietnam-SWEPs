"""Bake the Vz 24 safety locomotion pilot without regenerating the rest of its QC.

python work/fix_nearwall_movement.py --compile
No game launch. This intentionally targets one model before a wider rollout.
"""
import argparse
import json
from pathlib import Path
import shutil
from types import SimpleNamespace

import numpy as np
from scipy.spatial.transform import Rotation

import bake_ik as rig
import port_qc
from pack_paths import asset_path

WORK = Path(__file__).resolve().parent
MODEL = "v_vz24"
SOURCE = WORK / "MCV_SMD_OG/weapons" / MODEL / (MODEL + "_anims")
PORT = WORK / "MCV_SMD_PORT/weapons" / MODEL
OUT = WORK / "nearwall_movement"
KNOTS = 17
WALK, SPRINT = 138.0, 233.0


def blend(a, b, t):
    """Position lerp and shortest-arc quaternion interpolation, all bones together."""
    if t <= 0:
        return a.copy()
    if t >= 1:
        return b.copy()
    qa = Rotation.from_euler("xyz", a[:, 3:]).as_quat()
    qb = Rotation.from_euler("xyz", b[:, 3:]).as_quat()
    dot = np.sum(qa * qb, axis=1)
    qb[dot < 0] *= -1
    theta = np.arccos(np.clip(np.abs(dot), 0, 1))
    sin = np.sin(theta)
    small = sin < 1e-6
    sin[small] = 1
    x, y = np.sin((1 - t) * theta) / sin, np.sin(t * theta) / sin
    x[small], y[small] = 1 - t, t
    q = qa * x[:, None] + qb * y[:, None]
    return np.column_stack((a[:, :3] * (1 - t) + b[:, :3] * t,
                            Rotation.from_quat(q).as_euler("xyz")))


def sample(frames, cycle):
    at = np.clip(cycle, 0, 1) * (len(frames) - 1)
    lo = int(at)
    return blend(frames[lo], frames[min(lo + 1, len(frames) - 1)], at - lo)


def load(name):
    nodes, frames, _ = rig.load_smd(SOURCE / (name + ".smd"))
    return nodes, np.array([[f[i] for i in range(len(nodes))] for f in frames])


def delta(name, nodes):
    _, frames = load(name)
    refpath = PORT / "fixed_anims" / (name + "_corrective_animation.smd")
    if not refpath.exists():
        refpath = SOURCE / (name + "_corrective_animation.smd")
    refs = rig.load_smd(refpath)[1][0]
    ref = np.array([refs.get(i, np.zeros(6)) for i in nodes])
    out = frames.copy()
    for f in out:
        f[:, :3] -= ref[:, :3]
        r = Rotation.from_euler("xyz", ref[:, 3:]).inv() * Rotation.from_euler("xyz", f[:, 3:])
        f[:, 3:] = r.as_euler("xyz")
    return out


def add(pose, movement, weight):
    d = blend(np.zeros_like(movement), movement, weight)
    rotations = Rotation.from_euler("xyz", pose[:, 3:]) * Rotation.from_euler("xyz", d[:, 3:])
    return np.column_stack((pose[:, :3] + d[:, :3], rotations.as_euler("xyz")))


def matrix_blend(a, b, t):
    av = np.r_[a[:3, 3], rig.euler(a[:3, :3])][None, :]
    bv = np.r_[b[:3, 3], rig.euler(b[:3, :3])][None, :]
    return rig.local_mat(blend(av, bv, t)[0])


def bake_pose(nodes, ids, base, hip, walk, run, speed):
    sprint = np.clip((speed - WALK) / (SPRINT - WALK), 0, 1)
    walking = max(0, 1 - abs(speed - WALK) / WALK)
    # At full sprint return to the authored sprint carry, not nearwall + sprint offsets.
    carry = blend(base, hip, sprint)
    pose = add(add(carry, walk, walking), run, sprint)
    wb, wh = rig.fk(nodes, base), rig.fk(nodes, hip)
    gun = ids["Base"]
    goals = {}
    worst = 0
    for side in ("r", "l"):
        upper, lower, hand = (ids[n + "_" + side] for n in ("upperarm", "lowerarm", "hand"))
        # Keep the complete authored grip, including wrist orientation, during the carry blend.
        grip = matrix_blend(np.linalg.inv(wb[gun]) @ wb[hand],
                            np.linalg.inv(wh[gun]) @ wh[hand], sprint)
        world = rig.fk(nodes, pose)
        want = world[gun] @ grip
        ru, rl, _ = rig.solve_two_bone(world, nodes, pose, upper, lower, hand, want[:3, 3])
        pose[upper, 3:], pose[lower, 3:] = rig.euler(ru), rig.euler(rl)
        world = rig.fk(nodes, pose)
        pose[hand, 3:] = rig.euler(world[lower][:3, :3].T @ want[:3, :3])
        world = rig.fk(nodes, pose)
        worst = max(worst, float(np.linalg.norm(world[hand][:3, 3] - want[:3, 3])))
        goals[side] = grip
    return pose, goals, worst


def write_smd(path, nodes, frames):
    lines = ["version 1", "nodes"]
    lines += [f'{i} "{name}" {parent}' for i, (name, parent) in nodes.items()]
    lines += ["end", "skeleton"]
    for frame, pose in enumerate(frames):
        lines.append(f"time {frame}")
        lines += [str(i) + " " + " ".join(f"{x:.8f}" for x in row) for i, row in enumerate(pose)]
    path.write_text("\n".join(lines + ["end", ""]), encoding="utf8")


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--compile", action="store_true")
    args = ap.parse_args()
    nodes, hips = load("basePose_a")
    ids = {name: i for i, (name, _) in nodes.items()}
    walks, runs = delta("walk_a", nodes), delta("run_a", nodes)
    target = PORT / "safe_anims"
    target.mkdir(exist_ok=True)
    OUT.mkdir(exist_ok=True)
    qcpath = PORT / (MODEL + ".qc")
    raw = qcpath.read_text()
    backup = OUT / "v_vz24.before.qc"
    if not backup.exists():
        backup.write_text(raw, encoding="utf8")
    # Reruns replace our generated block, preserving any edits elsewhere in the QC.
    begin, end = "// BEGIN MCV SAFETY LOCOMOTION\n", "// END MCV SAFETY LOCOMOTION\n"
    if begin in raw:
        a, rest = raw.split(begin, 1)
        _, b = rest.split(end, 1)
        raw = a + b
    qc = port_qc.QC(raw)
    generated = []
    report = {"model": MODEL, "knots": KNOTS, "sequences": [], "max_baked_grip_error": 0,
              "max_interpolated_grip_error": 0}
    for seqname, src in (("idletonearwall", "nearwall_s_a"), ("nearwall", "nearwall_a"),
                         ("nearwalltoidle", "nearwall_e_a")):
        seq = qc.find("sequence", seqname)
        old = seq.render()
        names = []
        for suffix in ("", "_i"):
            _, bases = load(src + suffix)
            tracks, grips = [], []
            for k in range(KNOTS):
                speed = k * SPRINT / (KNOTS - 1)
                name = f"mcv_safe_{src}{suffix}_{k:02}"
                names.append(name)
                poses, goals = [], []
                for fi, base in enumerate(bases):
                    phase = fi / (len(bases) - 1)
                    # Idle is cyclic. Transitions keep their original 30fps timing.
                    wc = phase if seqname == "nearwall" else (fi % (len(walks) - 1)) / (len(walks) - 1)
                    rc = phase if seqname == "nearwall" else (fi % (len(runs) - 1)) / (len(runs) - 1)
                    pose, goal, error = bake_pose(nodes, ids, base, sample(hips, phase),
                                                  sample(walks, wc), sample(runs, rc), speed)
                    report["max_baked_grip_error"] = max(report["max_baked_grip_error"], error)
                    poses.append(pose)
                    goals.append(goal)
                tracks.append(poses)
                grips.append(goals)
                write_smd(target / (name + ".smd"), nodes, poses)
                fps = 30
                if seqname == "nearwall":
                    walk_fraction = min(speed / 100, 1)
                    duration = 2 * (1 - walk_fraction) + (22 / 30) * walk_fraction
                    sprint = np.clip((speed - WALK) / (SPRINT - WALK), 0, 1)
                    duration = duration * (1 - sprint) + (18 / 30) * sprint
                    fps = (len(bases) - 1) / duration
                opts = [f"fps {fps:.8f}"]
                if seqname == "nearwall":
                    opts.append("loop")
                generated.append(port_qc.Block("animation", name, "safe_anims\\" + name + ".smd", opts).render())
            # Check the points between baked speed samples, where skeletal blending can drift.
            for k in range(KNOTS - 1):
                for fi in range(len(bases)):
                    pose = blend(tracks[k][fi], tracks[k + 1][fi], 0.5)
                    world = rig.fk(nodes, pose)
                    for side in ("r", "l"):
                        g = matrix_blend(grips[k][fi][side], grips[k + 1][fi][side], 0.5)
                        want = world[ids["Base"]] @ g
                        error = np.linalg.norm(world[ids["hand_" + side]][:3, 3] - want[:3, 3])
                        report["max_interpolated_grip_error"] = max(report["max_interpolated_grip_error"], float(error))
        opts = [line for line in seq.opts() if not line.startswith(("blend ", "blendwidth ", "addlayer \"walk", "addlayer \"run"))]
        seq.lines = [f'"{name}"' for name in names] + [f'blend "player_movement" 0 {SPRINT:g}',
                     'blend "ironsight" 0 1', f"blendwidth {KNOTS}"] + opts
        assert old in raw
        raw = raw.replace(old, seq.render(), 1)
        report["sequences"].append(seqname)
        print(seqname, "baked", flush=True)
    assert report["max_baked_grip_error"] < 0.02, report
    assert report["max_interpolated_grip_error"] < 0.15, report
    raw = raw.replace('$sequence "idletonearwall"', begin + "\n".join(generated) + end + '$sequence "idletonearwall"', 1)
    qcpath.write_text(raw, encoding="utf8", newline="\n")
    if args.compile:
        result = port_qc.compile_qc(SimpleNamespace(game=str(WORK / "compile_test_game"), studiomdl=None), str(qcpath))
        report["compile"] = result
        assert result["ok"], result
        report["installed"] = []
        for ext in (".mdl", ".vvd", ".dx80.vtx", ".dx90.vtx"):
            src = WORK / "compile_test_game/models/weapons/mcv" / (MODEL + ext)
            dst = asset_path("models/weapons/mcv/" + MODEL + ext)
            shutil.copy2(src, dst)
            report["installed"].append(str(dst))
    (OUT / "verification.json").write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()

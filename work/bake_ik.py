"""Bake an IK "touch" rule into a delta layer animation the port cannot run IK on.

    python bake_ik.py v_sterling run_a --ik upperarm_l lowerarm_l hand_l lhand_ikTarget --ik upperarm_r lowerarm_r hand_r rhand_ikTarget

The game's viewmodels glue a hand to a target bone on the gun with `$ikchain` + `ikrule touch`
while movement layers swing the gun around; GMod's studiomdl compiles the models without IK
(PORTING.md, "IK"), so the hand drifts off the magazine in the run layer. This solves the
two-bone chain per frame against the target's position in the final pose (idle base pose plus
the layer's delta) and writes the corrected arm rotations into
`MCV_SMD/weapons/<model>/anims/<anim>.smd`, which port_qc.py prefers over the OG file.

Conventions (Source, verified against studiomdl's `subtract` and bone_setup's delta blend):
SMD rotation (x, y, z) is Rz(z) Ry(y) Rx(x); a delta animation stores `anim = ref * delta`
(ref = the Crowbar corrective's frame 0 for the root-level bones it lists, zero for every other
bone: Crowbar writes the layer as the deltas themselves) and plays as
`final = base * delta` with the position delta added in the parent frame.
"""
import argparse
import math
import os
import re
import sys

import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
OG = os.path.join(HERE, "MCV_SMD_OG", "weapons")
OUT = os.path.join(HERE, "MCV_SMD", "weapons")


def load_smd(path):
    nodes = {}
    frames = []
    lines = open(path, encoding="utf-8", errors="replace").read().split("\n")
    sec = None
    cur = None
    for l in lines:
        t = l.strip()
        if t in ("nodes", "skeleton", "triangles"):
            sec = t
            continue
        if t == "end":
            sec = None
            continue
        if sec == "nodes":
            p = t.split()
            nodes[int(p[0])] = (p[1].strip('"'), int(p[2]))
        elif sec == "skeleton":
            if t.startswith("time"):
                cur = {}
                frames.append(cur)
            elif cur is not None and t:
                p = t.split()
                cur[int(p[0])] = np.array([float(x) for x in p[1:7]])
    return nodes, frames, lines


def rmat(e):
    x, y, z = e
    cx, sx, cy, sy, cz, sz = math.cos(x), math.sin(x), math.cos(y), math.sin(y), math.cos(z), math.sin(z)
    Rx = np.array([[1, 0, 0], [0, cx, -sx], [0, sx, cx]])
    Ry = np.array([[cy, 0, sy], [0, 1, 0], [-sy, 0, cy]])
    Rz = np.array([[cz, -sz, 0], [sz, cz, 0], [0, 0, 1]])
    return Rz @ Ry @ Rx


def euler(M):
    y = math.asin(max(-1.0, min(1.0, -M[2, 0])))
    x = math.atan2(M[2, 1], M[2, 2])
    z = math.atan2(M[1, 0], M[0, 0])
    return [x, y, z]


def local_mat(v):
    M = np.eye(4)
    M[:3, :3] = rmat(v[3:6])
    M[:3, 3] = v[:3]
    return M


def fk(nodes, pose):
    """World matrices for every bone of a pose {bone: [pos, rot]}."""
    world = {}
    def get(b):
        if b in world:
            return world[b]
        M = local_mat(pose[b])
        par = nodes[b][1]
        world[b] = (get(par) @ M) if par != -1 else M
        return world[b]
    for b in nodes:
        get(b)
    return world


def final_pose(nodes, base, ref, anim):
    """base * (ref^-1 * anim) per bone: rotation post-multiplied, position delta added."""
    pose = {}
    for b in nodes:
        Rb = rmat(base[b][3:6])
        Rr = rmat(ref[b][3:6])
        Ra = rmat(anim[b][3:6])
        R = Rb @ Rr.T @ Ra
        p = base[b][:3] + (anim[b][:3] - ref[b][:3])
        pose[b] = np.concatenate([p, euler(R)])
    return pose


def rot_between(a, b):
    """Rotation matrix taking unit vector a onto unit vector b."""
    a = a / (np.linalg.norm(a) + 1e-9)
    b = b / (np.linalg.norm(b) + 1e-9)
    v = np.cross(a, b)
    c = float(np.dot(a, b))
    if np.linalg.norm(v) < 1e-8:
        return np.eye(3) if c > 0 else -np.eye(3)
    K = np.array([[0, -v[2], v[1]], [v[2], 0, -v[0]], [-v[1], v[0], 0]])
    return np.eye(3) + K + K @ K * (1.0 / (1.0 + c))


def solve_two_bone(world, nodes, pose, upper, lower, hand, target):
    """Rotate `upper` and `lower` (world space) so `hand`'s origin lands on `target`. The elbow
    stays in the plane it already bends in. Returns the new local rotations of upper and lower."""
    S = world[upper][:3, 3]
    E = world[lower][:3, 3]
    W = world[hand][:3, 3]
    T = target
    L1, L2 = np.linalg.norm(E - S), np.linalg.norm(W - E)
    d = np.linalg.norm(T - S)
    d = min(d, L1 + L2 - 1e-3)
    # elbow bend plane: the current one (pole from the current elbow)
    axis_st = (T - S) / max(np.linalg.norm(T - S), 1e-9)
    pole = (E - S) - np.dot(E - S, axis_st) * axis_st
    if np.linalg.norm(pole) < 1e-4:
        cur_axis = (W - S) / max(np.linalg.norm(W - S), 1e-9)
        pole = (E - S) - np.dot(E - S, cur_axis) * cur_axis
    pole = pole / max(np.linalg.norm(pole), 1e-9)
    # law of cosines: elbow position on the ST line
    a = (L1 * L1 - L2 * L2 + d * d) / (2 * d)
    h = math.sqrt(max(L1 * L1 - a * a, 0.0))
    E2 = S + axis_st * a + pole * h
    W2 = S + axis_st * d
    # world rotations: turn the upper bone so S->E becomes S->E2, then the lower so E2->W maps to E2->W2
    Ru = rot_between(E - S, E2 - S)
    up_world = Ru @ world[upper][:3, :3]
    # the lower bone's current direction after the upper turned
    EW_after = Ru @ (W - E)
    Rl = rot_between(EW_after, W2 - E2)
    low_world = Rl @ Ru @ world[lower][:3, :3]
    # back to local rotations
    par_u = nodes[upper][1]
    up_local = world[par_u][:3, :3].T @ up_world
    low_local = up_world.T @ low_world
    return up_local, low_local, W2


def rule_weight(rng, frame):
    """How much of an ikrule applies at `frame`: `range start peak tail end` fades the rule in
    from start to peak and out from tail to end (a reload's hand is glued to the gun only while
    it holds it); `range 0 0 0 0` never applies. None means the whole animation."""
    if rng is None:
        return 1.0
    start, peak, tail, end = rng
    if end <= 0 and start <= 0 and peak <= 0 and tail <= 0:
        return 0.0
    if frame < start or frame > end:
        return 0.0
    if frame < peak:
        return (frame - start) / max(peak - start, 1e-6)
    if frame > tail:
        return (end - frame) / max(end - tail, 1e-6)
    return 1.0


def bake_animation(anim_path, corrective_path, base_path, chains, out_path, is_delta=True, log=None):
    """Bake the IK touch of `chains` ([(upper, lower, hand, target[, range, contact]) bone names]) into the animation
    at `anim_path`, writing `out_path`. Delta layers play over the idle at `base_path` (the
    corrective at `corrective_path` is what studiomdl subtracts); an absolute animation is its
    own final pose. Returns (worst distance before, worst after) over the frames, or None."""
    nodes, aframes, alines = load_smd(anim_path)
    idx = {n: b for b, (n, _) in nodes.items()}
    try:
        chains_b = [tuple(idx[n] for n in c[:4]) + tuple(c[4:]) for c in chains]
    except KeyError as e:
        if log:
            log("bake_ik: bone %s missing in %s" % (e, os.path.basename(anim_path)))
        return None
    base = ref = None
    if is_delta:
        cframes = load_smd(corrective_path)[1] if corrective_path and os.path.isfile(corrective_path) else [{}]
        base = load_smd(base_path)[1][0]
        ref = {b: np.zeros(6) for b in nodes}
        ref.update(cframes[0])
        if any(b not in base for b in nodes):
            if log:
                log("bake_ik: base %s lacks bones of %s" % (os.path.basename(base_path), os.path.basename(anim_path)))
            return None
    def pose_at(fi):
        af = aframes[min(max(fi, 0), len(aframes) - 1)]
        return final_pose(nodes, base, ref, af) if is_delta else {b: np.array(af[b]) for b in nodes}

    # a touch rule (IK_SELF) keeps the hand where it sits relative to the target bone at the
    # rule's contact frame: that offset, in the target's space, is what every frame reproduces.
    # A rule inherited from the idle (contact None) measures it on the idle pose itself.
    offsets = []
    for chain in chains_b:
        upper, lower, hand, target = chain[:4]
        contact = chain[5] if len(chain) > 5 else None
        if contact is None and is_delta:
            wc = fk(nodes, {b: np.array(base[b]) for b in nodes})
        else:
            wc = fk(nodes, pose_at(int(round(contact or 0))))
        offsets.append(np.linalg.inv(wc[target]) @ np.append(wc[hand][:3, 3], 1.0))
    worst_before = worst_after = 0.0
    new_rows = {}
    for fi, af in enumerate(aframes):
        pose = pose_at(fi)
        for chain, offset in zip(chains_b, offsets):
            upper, lower, hand, target = chain[:4]
            weight = rule_weight(chain[4], fi) if len(chain) > 4 else 1.0
            if weight <= 0.001:
                continue
            w = fk(nodes, pose)
            want = (w[target] @ offset)[:3]
            before = np.linalg.norm(w[hand][:3, 3] - want)
            worst_before = max(worst_before, before * weight)
            if before < 0.01:
                continue
            goal = w[hand][:3, 3] + (want - w[hand][:3, 3]) * weight
            up_local, low_local, _ = solve_two_bone(w, nodes, pose, upper, lower, hand, goal)
            for b, Rl in ((upper, up_local), (lower, low_local)):
                if is_delta:
                    Rb = rmat(base[b][3:6])
                    Rr = rmat(ref[b][3:6])
                    Ra = Rr @ (Rb.T @ Rl)
                    new_rows[(fi, b)] = np.concatenate([af[b][:3], euler(Ra)])
                else:
                    new_rows[(fi, b)] = np.concatenate([af[b][:3], euler(Rl)])
                pose[b] = np.concatenate([pose[b][:3], euler(Rl)])
            w2 = fk(nodes, pose)
            worst_after = max(worst_after, np.linalg.norm(w2[hand][:3, 3] - (w2[target] @ offset)[:3]) * weight)
    if not new_rows:
        return (worst_before, worst_after)
    out = []
    sec = None
    fi = -1
    for l in alines:
        t = l.strip()
        if t in ("nodes", "skeleton", "triangles"):
            sec = t
            out.append(l)
            continue
        if t == "end":
            sec = None
            out.append(l)
            continue
        if sec == "skeleton":
            if t.startswith("time"):
                fi += 1
                out.append(l)
                continue
            if t:
                b = int(t.split()[0])
                if (fi, b) in new_rows:
                    l = "  %d %s" % (b, " ".join("%.6f" % v for v in new_rows[(fi, b)]))
        out.append(l)
    os.makedirs(os.path.dirname(out_path), exist_ok=True)
    open(out_path, "w", encoding="utf-8", newline="\n").write("\n".join(out))
    return (worst_before, worst_after)


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("model")
    ap.add_argument("anim")
    ap.add_argument("--ik", nargs=4, action="append", metavar=("UPPER", "LOWER", "HAND", "TARGET"), required=True,
                    help="a two-bone chain and the ikTarget bone its hand is glued to (repeatable)")
    ap.add_argument("--base", default="basePose_a", help="the idle animation the layer plays over")
    ap.add_argument("--absolute", action="store_true", help="not a delta layer: the animation is its own final pose")
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()
    d = os.path.join(OG, args.model, args.model + "_anims")
    out = os.path.join(OUT, args.model, "anims", args.anim + ".smd")
    if args.dry_run:
        out = os.path.join(HERE, "compile_test_game", "bake_ik_dryrun.smd")
    r = bake_animation(os.path.join(d, args.anim + ".smd"), os.path.join(d, args.anim + "_corrective_animation.smd"),
                       os.path.join(d, args.base + ".smd"), args.ik, out, not args.absolute, print)
    print("worst hand-target distance: %.2f -> %.2f" % r if r else "nothing baked")
    if not args.dry_run:
        print("wrote", os.path.relpath(out, HERE))


if __name__ == "__main__":
    main()

"""copy_hand_edit.py - carry a hand-edited animation's change onto a sibling animation.

    python work/copy_hand_edit.py v_m21 reload_empty reload_empty_2

An override in `MCV_SMD/weapons/<model>/anims/<edited>.smd` is the game's animation of the
same name with something fixed by hand. A sequence that blends two of these (the hip
animation against its `_2` ironsighted twin) then carries the fix on one knot only, and the
bones it touches slide as the aim blend moves. This reads the change out of the override
(per frame, per bone, in the bone's own frame) and applies the same change to the sibling,
writing the result next to the override so `port_qc.resolve_smd` picks it up.

The two animations must share a frame count and a skeleton; only the bones the edit actually
moved are rewritten, so everything else stays byte for byte the game's.
"""
import os, sys, math, argparse
import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import bake_ik

OG = os.path.join(HERE, "MCV_SMD_OG", "weapons")
OVR = os.path.join(HERE, "MCV_SMD", "weapons")
EPS_POS = 0.05
EPS_ROT = 0.05  # degrees


def load(path):
    nodes, frames, lines = bake_ik.load_smd(path)
    names = {i: n for i, (n, _) in nodes.items()}
    parents = {n: (names.get(p) if p >= 0 else None) for i, (n, p) in nodes.items()}
    return names, {n: i for i, n in names.items()}, frames, lines, parents


def angle(Ra, Rb):
    c = (np.trace(Ra.T @ Rb) - 1.0) / 2.0
    return math.degrees(math.acos(max(-1.0, min(1.0, c))))


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("model", help="viewmodel directory name, e.g. v_m21")
    ap.add_argument("edited", help="the animation the override edits, e.g. reload_empty")
    ap.add_argument("onto", help="the sibling to carry the change onto, e.g. reload_empty_2")
    ap.add_argument("--out", default=None, help="output smd (default: the override folder, named after `onto`)")
    args = ap.parse_args()

    anims = os.path.join(OG, args.model, args.model + "_anims")
    p_ovr = os.path.join(OVR, args.model, "anims", args.edited + ".smd")
    p_base = os.path.join(anims, args.edited + ".smd")
    p_target = os.path.join(anims, args.onto + ".smd")
    for p in (p_ovr, p_base, p_target):
        if not os.path.isfile(p):
            sys.exit("missing: " + p)
    out = args.out or os.path.join(OVR, args.model, "anims", args.onto + ".smd")

    nO, iO, fO, _, pO = load(p_ovr)
    nB, iB, fB, _, pB = load(p_base)
    nT, iT, fT, linesT, pT = load(p_target)
    if not (len(fO) == len(fB) == len(fT)):
        sys.exit("frame counts differ: override %d, base %d, target %d" % (len(fO), len(fB), len(fT)))

    # A hand edit made against an older rig can hold a bone under a different parent (the 2024
    # overrides predate ValveBiped-style BaseRoot, so their Base folds its parent in). Its local
    # numbers then differ everywhere without anything having been edited, so only bones that
    # hang off the same parent in all three files carry over.
    shared = [n for n in iO if n in iB and n in iT and pO.get(n) == pB.get(n) == pT.get(n)]
    reparented = sorted(n for n in iO if n in iB and n in iT and not (pO.get(n) == pB.get(n) == pT.get(n)))
    if reparented:
        print("   (skipped, a different parent in the override: %s)" % ", ".join(reparented))
    new_rows = {}
    touched = {}
    for f in range(len(fT)):
        for name in shared:
            bo, bb, bt = iO[name], iB[name], iT[name]
            if bo not in fO[f] or bb not in fB[f] or bt not in fT[f]:
                continue
            ro, rb, rt = fO[f][bo], fB[f][bb], fT[f][bt]
            dpos = np.array(ro[:3]) - np.array(rb[:3])
            Ro, Rb_, Rt = bake_ik.rmat(ro[3:6]), bake_ik.rmat(rb[3:6]), bake_ik.rmat(rt[3:6])
            drot = angle(Ro, Rb_)
            if np.linalg.norm(dpos) < EPS_POS and drot < EPS_ROT:
                continue
            R = (Ro @ Rb_.T) @ Rt
            new_rows[(f, bt)] = np.concatenate([np.array(rt[:3]) + dpos, bake_ik.euler(R)])
            e = touched.setdefault(name, [0, 0.0, 0.0])
            e[0] += 1
            e[1] = max(e[1], float(np.linalg.norm(dpos)))
            e[2] = max(e[2], drot)

    if not new_rows:
        sys.exit("the override does not differ from the game's animation; nothing to carry over")
    bake_ik.write_rows(linesT, new_rows, out)
    print("%s: carried the %s edit onto %s (%d rows over %d bones)" % (
        args.model, args.edited, args.onto, len(new_rows), len(touched)))
    for name, (n, dp, dr) in sorted(touched.items(), key=lambda kv: -kv[1][2]):
        print("   %-24s %3d frames, up to %5.2f units and %5.1f degrees" % (name, n, dp, dr))
    print("wrote", os.path.relpath(out, os.path.dirname(HERE)))


if __name__ == "__main__":
    main()

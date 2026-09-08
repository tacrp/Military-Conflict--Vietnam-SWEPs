"""How far each world model's barrel is off the pitch Half-Life 2's own weapons sit at.

    python work/measure_world_model_pitch.py

GMod's player poses were built around Half-Life 2's weapons, so those weapons are the record of
what "pointing forward" means in each hold type. Both packs put a `muzzle` attachment down the
barrel, so the direction is read rather than guessed, and it is read in the frame of the hand
bone, where it is a property of the model alone and the same in every animation.

Two things this had to settle by measurement rather than assumption, both of which will bite
anyone writing the pass that applies these numbers:

* Which axis of the muzzle attachment is the barrel. The two packs do not agree: Half-Life 2
  authors it as the attachment's +X, this pack as its +Y. So the axis is chosen by whichever one
  best matches the direction from the hand to the muzzle, which is geometry and needs no
  convention.

* Which of the three rotation numbers on a $definebone line is the pitch. studiomdl reads the
  triple as pitch, yaw, roll and stores it as roll, pitch, yaw, so it is the FIRST number.
  Confirmed against the compiled bone on eight models.

Still open, and not answerable from the files: the barrel of every gun in this pack lies along
the hand frame's -Y, and Half-Life 2's along its +X, a 90 degree difference in yaw that the guns
plainly do not show in game. Something about how each pack reaches the hand differs, and until it
is known, whether a pitch correction belongs in the pitch slot or the roll slot is a guess. Try
one gun each way and look before running anything over two hundred of them.

Reads only. Writes work/world_model_pitch.json.
"""
import glob
import json
import math
import os
import re
import struct
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ADDON = os.path.normpath(os.path.join(HERE, ".."))
HL2 = r"C:\Program Files (x86)\Steam\steamapps\common\Half-Life 2\hl2\hl2_misc_dir.vpk"
sys.path.insert(0, HERE)
import vpklib

# hold type -> the Half-Life 2 weapon GMod poses that way. Melee, crossbow, slam and grenade have
# no usable reference: their world models are old single-bone props with no hand bone and no
# muzzle. A revolver is held as a pistol is.
REFERENCE = {
    "ar2": "models/weapons/w_irifle.mdl",
    "smg": "models/weapons/w_smg1.mdl",
    "pistol": "models/weapons/w_pistol.mdl",
    "shotgun": "models/weapons/w_shotgun.mdl",
    "rpg": "models/weapons/w_rocket_launcher.mdl",
}
REFERENCE_ALIAS = {"revolver": "pistol"}
HAND = "valvebiped.bip01_r_hand"


def mat(f):
    return [list(f[0:4]), list(f[4:8]), list(f[8:12])]


def mul(a, b):
    o = [[0.0] * 4 for _ in range(3)]
    for i in range(3):
        for j in range(3):
            o[i][j] = a[i][0] * b[0][j] + a[i][1] * b[1][j] + a[i][2] * b[2][j]
        o[i][3] = a[i][0] * b[0][3] + a[i][1] * b[1][3] + a[i][2] * b[2][3] + a[i][3]
    return o


def inv(m):
    o = [[0.0] * 4 for _ in range(3)]
    for i in range(3):
        for j in range(3):
            o[i][j] = m[j][i]
        o[i][3] = -(m[0][i] * m[0][3] + m[1][i] * m[1][3] + m[2][i] * m[2][3])
    return o


def parse(d):
    nb, ob = struct.unpack("<ii", d[156:164])
    bones = []
    for i in range(nb):
        b = ob + i * 216
        ni, _ = struct.unpack("<ii", d[b:b + 8])
        p = b + ni
        bones.append((d[p:d.index(b"\0", p)].decode("ascii", "replace"),
                      mat(struct.unpack("<12f", d[b + 96:b + 144]))))

    na, oa = struct.unpack("<ii", d[240:248])
    atts = {}
    for i in range(na):
        b = oa + i * 92
        ni, _, lb = struct.unpack("<iIi", d[b:b + 12])
        p = b + ni
        atts[d[p:d.index(b"\0", p)].decode("ascii", "replace").lower()] = (
            lb, mat(struct.unpack("<12f", d[b + 12:b + 60])))
    return bones, atts


def barrel(d):
    """Where the barrel points in the hand bone's frame, and how far the muzzle is out along it."""
    bones, atts = parse(d)
    if "muzzle" not in atts:
        return None

    hand = next((i for i, b in enumerate(bones) if b[0].lower() == HAND), None)
    if hand is None:
        return None

    lb, loc = atts["muzzle"]
    if lb >= len(bones):
        return None

    m = mul(bones[hand][1], mul(inv(bones[lb][1]), loc))
    pos = (m[0][3], m[1][3], m[2][3])
    reach = math.sqrt(sum(c * c for c in pos))
    if reach < 1e-3:
        return None
    toward = tuple(c / reach for c in pos)

    # the barrel is whichever attachment axis lies along the way to the muzzle, which is geometry
    # rather than a convention the two packs happen to disagree about
    axes = {"+X": (m[0][0], m[1][0], m[2][0]),
            "+Y": (m[0][1], m[1][1], m[2][1]),
            "+Z": (m[0][2], m[1][2], m[2][2])}
    which = max(axes, key=lambda k: sum(a * b for a, b in zip(axes[k], toward)))
    axis = axes[which]

    return {"axis": which,
            "agreement": round(sum(a * b for a, b in zip(axis, toward)), 4),
            "elevation": round(-math.degrees(math.asin(max(-1.0, min(1.0, axis[2])))), 3),
            "heading": round(math.degrees(math.atan2(axis[1], axis[0])), 3),
            "muzzle_out": round(reach, 2)}


def main():
    vpk = vpklib.VPK(HL2)
    ref = {}
    for hold, path in REFERENCE.items():
        got = barrel(vpk.read(path))
        if got:
            got["model"] = os.path.basename(path)[:-4]
            ref[hold] = got
    vpk.close()
    for a, b in REFERENCE_ALIAS.items():
        if b in ref:
            ref[a] = dict(ref[b], held_as=b)

    print("Half-Life 2's weapons, barrel in the hand's frame")
    print("%-10s %-22s %6s %10s %9s %8s" % ("holdtype", "reference", "axis", "elevation", "heading", "reach"))
    for hold in sorted(ref):
        r = ref[hold]
        print("%-10s %-22s %6s %10.2f %9.2f %8.1f"
              % (hold, r["model"], r["axis"], r["elevation"], r["heading"], r["muzzle_out"]))

    rows, skipped = [], []
    for f in sorted(glob.glob(os.path.join(ADDON, "lua", "weapons", "mcv_*.lua"))):
        s = open(f, encoding="utf-8", errors="replace").read()
        if not re.search(r'^SWEP\.Base\s*=\s*"mcv_', s, re.M):
            continue
        name = os.path.basename(f)[4:-4]

        m = re.search(r'^SWEP\.HoldType\s*=\s*"([^"]+)"', s, re.M)
        hold = m.group(1) if m else "ar2"
        if hold not in ref:
            skipped.append((name, hold, "no reference for this hold type"))
            continue

        wm = re.search(r'^SWEP\.WorldModel\s*=\s*"models/weapons/mcv/([^"]+)\.mdl"', s, re.M)
        if not wm:
            skipped.append((name, hold, "no world model"))
            continue
        p = os.path.join(ADDON, "models", "weapons", "mcv", wm.group(1) + ".mdl")
        if not os.path.isfile(p):
            skipped.append((name, hold, "world model not built"))
            continue

        got = barrel(open(p, "rb").read())
        if not got:
            skipped.append((name, hold, "no muzzle attachment or no hand bone"))
            continue

        qc = os.path.join(ADDON, "work", "MCV_SMD_PORT", "weapons", wm.group(1), wm.group(1) + ".qc")
        line = None
        if os.path.isfile(qc):
            mm = re.search(r'^\$definebone\s+"ValveBiped\.Bip01_R_Hand"\s+""\s+(\S+ \S+ \S+ \S+ \S+ \S+)',
                           open(qc, encoding="utf-8", errors="replace").read(), re.M)
            if mm:
                line = mm.group(1)

        rows.append({"weapon": name, "model": wm.group(1), "holdtype": hold,
                     "barrel_axis": got["axis"], "elevation": got["elevation"],
                     "heading": got["heading"], "muzzle_out": got["muzzle_out"],
                     "target_elevation": ref[hold]["elevation"],
                     "correction": round(ref[hold]["elevation"] - got["elevation"], 3),
                     "hand_bone_line": line,
                     "qc_pitch": float(line.split()[3]) if line else None})

    print()
    print("%d guns measured, %d not" % (len(rows), len(skipped)))
    print()
    print("%-10s %5s %12s %12s %10s" % ("holdtype", "guns", "elevation", "target", "correction"))
    by = {}
    for r in rows:
        by.setdefault(r["holdtype"], []).append(r)
    for hold in sorted(by):
        v = by[hold]
        elev = sorted({r["elevation"] for r in v})
        corr = sorted({r["correction"] for r in v})
        print("%-10s %5d %12s %12.2f %10s"
              % (hold, len(v), ", ".join("%.2f" % e for e in elev[:3]),
                 v[0]["target_elevation"], ", ".join("%.2f" % c for c in corr[:3])))

    out = os.path.join(ADDON, "work", "world_model_pitch.json")
    with open(out, "w", encoding="utf-8", newline="\n") as f:
        json.dump({
            "what": "How far each world model's barrel is off the pitch Half-Life 2's own weapons "
                    "sit at in the same hold type, measured in the hand bone's frame.",
            "barrel_axis": "Chosen per model by which attachment axis lies along the way from the "
                           "hand to the muzzle. Half-Life 2 authors the barrel as the muzzle "
                           "attachment's +X, this pack as its +Y, so it cannot be assumed.",
            "apply_to": "A rotation on the $definebone line for ValveBiped.Bip01_R_Hand, leaving "
                        "its three position numbers alone: that bone's origin is the grip, so "
                        "rotating it and nothing else turns the gun about the grip.",
            "which_number": "studiomdl reads the rotation triple as pitch, yaw, roll and stores it "
                            "as roll, pitch, yaw, so the FIRST of the three is the pitch. Verified "
                            "against the compiled bone on eight models.",
            "unresolved": "Every gun in this pack has its barrel along the hand frame's -Y and "
                          "Half-Life 2's along its +X, 90 degrees apart in heading, which the guns "
                          "do not show in game. Until that is understood, whether the correction "
                          "belongs in the pitch slot or the roll slot is unproven. Compile one gun "
                          "each way and look.",
            "reference": ref,
            "weapons": rows,
            "not_measured": [{"weapon": n, "holdtype": h, "why": w} for n, h, w in skipped],
        }, f, indent=2)
        f.write("\n")
    print()
    print("written to work/world_model_pitch.json")


if __name__ == "__main__":
    main()

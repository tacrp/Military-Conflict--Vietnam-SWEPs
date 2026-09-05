"""Bring every weapon lua in line with facts read from its compiled viewmodel and QC.

    python fix_lua_flags.py            # report and apply
    python fix_lua_flags.py --dry-run  # report only

Applied to all lua/weapons/mcv_*.lua (hand-written ones included), since the models they drive
were all recompiled from the current game data:

* NoEjectOnShoot  - true when the animation set throws the shell somewhere other than the shot
                    (bolt pull, pump, revolver / break-action reload), see port_weapon.eject_rule
* AnimationHandlesHammer / InvertAnimationHammer - both true for cycle weapons whose animations
                    carry hammerpos events (the game's convention is the inverse of the base's;
                    without the inverted flag the shot itself releases the bolt)
* RTScopeMaterialIndex / ScopeMaterial - lens submaterial index read from the compiled model,
                    reticle from the optics folder (a hand-made reticle already referenced wins)
"""
import argparse
import glob
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import port_weapon as pw  # noqa: E402

ADDON = pw.ADDON


def read(path):
    return open(path, encoding="utf-8", errors="replace").read()


def get(src, key):
    m = re.search(r'^SWEP\.%s\s*=\s*(.+?)\s*$' % re.escape(key), src, re.M)
    if not m:
        return None
    return re.sub(r'\s*(//|--).*$', '', m.group(1)).strip()


def set_line(src, key, value, after=None):
    """Replace `SWEP.key = ...` (also a commented-out one) or add it after `after`, else near the end."""
    line = "SWEP.%s = %s" % (key, value)
    pat = re.compile(r'^(//\s*)?SWEP\.%s\s*=.*$' % re.escape(key), re.M)
    if pat.search(src):
        return pat.sub(line, src, count=1)
    if after:
        m = re.search(r'^SWEP\.%s\s*=.*$' % re.escape(after), src, re.M)
        if m:
            return src[:m.end()] + "\n" + line + src[m.end():]
    return src.rstrip("\n") + "\n\n" + line + "\n"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()
    changes = []
    for lp in sorted(glob.glob(os.path.join(ADDON, "lua", "weapons", "mcv_*.lua"))):
        name = os.path.basename(lp)[4:-4]
        src = read(lp)
        m = re.search(r'SWEP\.ViewModel\s*=\s*"models/weapons/mcv/([^"]+)\.mdl"', src)
        if not m:
            continue
        vm = m.group(1)
        qc = pw.qc_facts(pw.find_qc(vm))
        if not qc["acts"]:
            continue
        acts = qc["acts"]
        new = src
        wtype_revolver = (get(src, "SubCategory") or "").strip('"') == "Revolvers" or "revolver_firemode_pose" in qc["poseparams"] \
            or (get(src, "HoldType") or "").strip('"') == "revolver"
        cycle = get(src, "PlayCycleAnimation") == "true"
        firemodes = get(src, "Firemodes") or ""
        fm_block = re.search(r'SWEP\.Firemodes\s*=\s*\{(.*?)\}', src, re.S)
        fms = fm_block.group(1) if fm_block else ""
        is_bolt = cycle and "FIREMODE_BOLT" in fms
        is_pump = cycle and "FIREMODE_PUMP" in fms

        # ---- eject ----
        is_rocket = get(src, "ShootEntity") not in (None, "nil")
        want = pw.eject_rule(qc, wtype_revolver, is_bolt, is_pump, is_rocket)
        cur = get(src, "NoEjectOnShoot")
        if (cur == "true") != want:
            new = set_line(new, "NoEjectOnShoot", "true" if want else "false", after="EjectBrassType")
            changes.append((name, "NoEjectOnShoot", cur, str(want).lower()))

        # ---- hammer ----
        if cycle and qc["hammer_events"]:
            # release the action on the event the cycle animation carries (see port_weapon)
            want = {"AnimationHandlesHammer": "true",
                    "InvertAnimationHammer": "false" if qc.get("cycle_hammerpos") == 1 else "true"}
            for key, val in want.items():
                if get(src, key) != val:
                    new = set_line(new, key, val, after="PlayCycleAnimation")
                    changes.append((name, key, get(src, key), val))

        # ---- scope ----
        if get(src, "HasScope") == "true":
            idx, mat = pw.scope_info(vm)
            cur_idx = get(src, "RTScopeMaterialIndex")
            if idx is not None and cur_idx != str(idx):
                new = set_line(new, "RTScopeMaterialIndex", str(idx), after="ScopeFOV2")
                changes.append((name, "RTScopeMaterialIndex", cur_idx, str(idx)))
            cur_mat = get(src, "ScopeMaterial") or ""
            rm = re.search(r'Material\("([^"]+)"\)', cur_mat)
            have = rm and os.path.isfile(os.path.join(ADDON, "materials", rm.group(1).replace("/", os.sep) + ".vmt"))
            if not have and mat:
                new = set_line(new, "ScopeMaterial", 'Material("%s")' % mat, after="HasScope")
                changes.append((name, "ScopeMaterial", cur_mat, mat))
            if idx is None:
                new = set_line(new, "HasScope", "false")
                changes.append((name, "HasScope", "true", "false (no lens material in model)"))

        if new != src and not args.dry_run:
            open(lp, "w", encoding="utf-8", newline="\n").write(new)
    for c in changes:
        print("%-24s %-24s %-40s -> %s" % c)
    print("%d changes%s" % (len(changes), " (dry run)" if args.dry_run else ""))


if __name__ == "__main__":
    main()

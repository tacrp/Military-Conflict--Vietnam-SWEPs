"""Replace the viewmodel offsets in every weapon lua with the game's own script values.

    python fix_sight_offsets.py            # report and apply
    python fix_sight_offsets.py --dry-run  # report only

Rewrites SWEP.IronsightPos / IronsightAng / CustomPos / CustomAng from the script's
ironsightright/forward/up/pitch/yaw/roll keys and CustomOffset block (port_weapon.sight_offsets).
The first port's hand-tuned offsets were made against the previous game rig, whose aimed pose
carried a small per-gun yaw; the current rig is straight, so those offsets put every front sight
left of the rear sight. Weapons whose script has no offsets (equipment) are left alone.
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
SCRIPTS = os.path.join(HERE, "cscripts")
KEYS = ("IronsightPos", "IronsightAng", "CustomPos", "CustomAng")


def set_line(src, key, value):
    """Replace `SWEP.<key> = ...` (comment dropped); returns (src, changed, found)."""
    pat = re.compile(r'^(SWEP\.%s[ \t]*=[ \t]*)([^\n]*?)[ \t]*$' % re.escape(key), re.M)
    m = pat.search(src)
    if not m:
        return src, False, False
    old = re.sub(r'\s*(//|--).*$', '', m.group(2)).strip()
    if old == value:
        return src, False, True
    return src[:m.start()] + m.group(1) + value + src[m.end():], True, True


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()

    name_map = pw.resolve_lua_names(SCRIPTS, ADDON)
    done = {}
    changed_files = 0
    for f in sorted(glob.glob(os.path.join(SCRIPTS, "weapon_*.txt"))):
        name = os.path.basename(f)[len("weapon_"):-4]
        lua_name = name_map.get(name, name)
        lp = os.path.join(ADDON, "lua", "weapons", "mcv_%s.lua" % lua_name)
        if not os.path.isfile(lp):
            continue
        if lua_name in done:
            # a merged variant (rifle grenade, silenced...) shares the lua; the base script wins
            continue
        kv = pw.parse_kv(open(f, encoding="utf-8", errors="replace").read())
        S = pw.flat(kv.get("WeaponData", kv))
        so = pw.sight_offsets(S)
        if not so:
            print("%-28s no offsets in script, left alone" % lua_name)
            continue
        done[lua_name] = name
        src = open(lp, encoding="utf-8", errors="replace").read()
        report = []
        for key in KEYS:
            src, changed, found = set_line(src, key, so[key])
            if not found:
                if key == "CustomAng":
                    # insert after CustomPos
                    src, ins, _ = set_line(src, "CustomPos", so["CustomPos"] + "\nSWEP.CustomAng = " + so["CustomAng"])
                    if ins:
                        report.append("CustomAng added")
                else:
                    report.append("%s missing" % key)
                continue
            if changed:
                report.append("%s -> %s" % (key, so[key]))
        if report:
            changed_files += 1
            print("%-28s %s" % (lua_name, "; ".join(report)))
            if not args.dry_run:
                open(lp, "w", encoding="utf-8", newline="\n").write(src)
    print("%d lua files %s" % (changed_files, "would change" if args.dry_run else "changed"))


if __name__ == "__main__":
    main()

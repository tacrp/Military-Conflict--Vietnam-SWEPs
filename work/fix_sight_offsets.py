"""Replace the viewmodel offsets in every weapon lua with the game's own script values.

    python fix_sight_offsets.py            # report and apply
    python fix_sight_offsets.py --dry-run  # report only

Rewrites SWEP.IronsightPos / IronsightAng / CustomPos / CustomAng from the script's
ironsightright/forward/up/pitch/yaw/roll keys and CustomOffset block, and ScopeFOV / ScopeFOV2
from ScopeLensFov / ScopeLensFov2 (port_weapon.sight_offsets).
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
KEYS = ("IronsightPos", "IronsightAng", "CustomPos", "CustomAng", "ScopeFOV", "ScopeFOV2", "BodyGroups",
        "SpreadBipod", "SpreadBipodIronsighted", "TracerParticle",
        "MagInTime", "MagInTimeEmpty", "MagOutTime", "MagOutTimeEmpty", "MovementPoseWalk", "MovementPoseSprint",
        "AkimboPoseRecoil", "AkimboRecoilTime", "IronsightPosAkimbo", "IronsightAngAkimbo")
# where a key that the lua file lacks is inserted (after this key; chains keep the order)
INSERT_AFTER = {"CustomAng": "CustomPos", "SpreadBipod": "SpreadIronsighted", "SpreadBipodIronsighted": "SpreadBipod",
                "TracerParticle": "TracerFrequency", "MagInTime": "BodyGroups", "MagInTimeEmpty": "MagInTime",
                "MagOutTime": "MagInTimeEmpty", "MagOutTimeEmpty": "MagOutTime",
                "MovementPoseWalk": "IronsightWalkBobbingStrength", "MovementPoseSprint": "MovementPoseWalk",
                "AkimboPoseRecoil": "ViewModelAkimbo", "AkimboRecoilTime": "AkimboPoseRecoil",
                "IronsightPosAkimbo": "IronsightAng", "IronsightAngAkimbo": "IronsightPosAkimbo"}


def set_line(src, key, value):
    """Replace `SWEP.<key> = ...` (comment dropped); returns (src, changed, found)."""
    pat = re.compile(r'^(SWEP\.%s[ \t]*=[ \t]*)([^\n]*?)[ \t]*$' % re.escape(key), re.M)
    m = pat.search(src)
    if not m:
        return src, False, False
    old = re.sub(r'\s*(//|--).*$', '', m.group(2)).strip()
    if value is None or old == value:
        return src, False, True
    return src[:m.start()] + m.group(1) + value + src[m.end():], True, True


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()

    name_map = pw.resolve_lua_names(SCRIPTS, ADDON)
    overrides = pw.load_overrides()
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
        S.update(overrides.get(name, {}))
        so = pw.sight_offsets(S)
        vm = S.get("viewmodel", "").replace("models/weapons/", "").replace(".mdl", "")
        if not vm:
            # the flamethrower scripts carry no viewmodel key: take the model from the lua file
            m = re.search(r'SWEP\.ViewModel\s*=\s*"models/weapons/mcv/([^"]+)\.mdl"', open(lp, encoding="utf-8", errors="replace").read())
            vm = m.group(1) if m else ""
        qc = pw.qc_facts(pw.find_qc(vm)) if vm else None
        # bodygroups from the script's BodygroupData block, in the model's bodygroup order
        if any(k.startswith("BodygroupData.") for k in S) and qc and qc["bodygroups"]:
            so = dict(so or {})
            so["BodyGroups"] = '"%s"' % pw.bodygroups_string(qc["bodygroups"], S)
        # run layer range and reload swap times from the animations
        if qc:
            timing = pw.anim_timing(qc)
            if timing:
                so = dict(so or {})
                so.update(timing)
        # dual wield: pose recoil when the dual model has the layers (only for luas that dual wield)
        if vm and os.path.isfile(lp) and "ViewModelAkimbo" in open(lp, encoding="utf-8", errors="replace").read():
            ak = pw.akimbo_timing(vm)
            ak.update(pw.akimbo_sight_offsets(name, SCRIPTS))
            if ak:
                so = dict(so or {})
                so.update(ak)
        if not so:
            print("%-28s no offsets in script, left alone" % lua_name)
            continue
        done[lua_name] = name
        src = open(lp, encoding="utf-8", errors="replace").read()
        report = []
        touched = False
        for key in KEYS:
            if key not in so:
                continue
            src, changed, found = set_line(src, key, so[key])
            if not found:
                m = None
                # the key's own anchor, else the last line of the model block
                for anchor in (INSERT_AFTER.get(key), "WorldModel"):
                    m = re.search(r'^SWEP\.%s\s*=.*$' % anchor, src, re.M) if anchor else None
                    if m:
                        break
                if m:
                    src = src[:m.end()] + "\nSWEP.%s = %s" % (key, so[key]) + src[m.end():]
                    touched = True
                    report.append("%s added" % key)
                else:
                    report.append("%s missing" % key)
                continue
            if changed:
                touched = True
                report.append("%s -> %s" % (key, so[key]))
        if report:
            print("%-28s %s" % (lua_name, "; ".join(report)))
        if touched:
            changed_files += 1
            if not args.dry_run:
                open(lp, "w", encoding="utf-8", newline="\n").write(src)
    print("%d lua files %s" % (changed_files, "would change" if args.dry_run else "changed"))


if __name__ == "__main__":
    main()

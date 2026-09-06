"""derive_hand_offsets.py - the ValveBiped.Bip01_R_Hand $definebone line for every world model,
from the game's own player animations.

    python work/derive_hand_offsets.py [--game DIR] [--rig DIR]

How the game places a gun: the world model bonemerges onto the player's ValveBiped.weapon_bone,
and the player animation set for the weapon's class (the weapon script's anim_prefix, e.g.
"rifle", "pistol", "sksm1g") animates that bone relative to the right hand. Its transform in
<prefix>_aim_idle (centre blend, frame 0) is A_c.

How GMod places ours (qc_methods.md "Setting up worldmodels"): the port adds a
ValveBiped.Bip01_R_Hand root that the engine merges onto the player's hand, and the gun bone
hangs under it. The root's $definebone H is the hand in the gun's frame, so the mesh ends up at
H^-1 in the hand: H = K * A_c^-1 with one constant K for the rig difference, calibrated on
the AK-47's hand-tuned line (K = H_ak47 * A_rifle). Fitted against every hand-tuned world
model: rms 1 unit on x/z, the China Lake's 15 degree tilt reproduced.

Output: work/hand_offsets_derived.json {name: {prefix, set, anim, hand [x y z ry rz rx],
hand_left}} - port_qc.py reads it for any world model without a HAND_OFFSETS entry. The dual
models' left line is the mirrored constant on the left hand-relative bone.

The player animation models (models/player/player_animations_*.mdl) are pulled from the game's
VPK and decompiled with tools/CrowbarCommandLineDecomp.exe into --rig (default
work/rip/player_rig; keep the path short, Crowbar hits MAX_PATH on long ones).
"""
import os, re, glob, json, math, sys, argparse, subprocess

HERE = os.path.dirname(os.path.abspath(__file__))
ADDON = os.path.normpath(os.path.join(HERE, ".."))
OG = os.path.join(HERE, "MCV_SMD_OG", "weapons")
CS = os.path.join(HERE, "cscripts")
CROWBAR = os.path.join(HERE, "tools", "CrowbarCommandLineDecomp.exe")
SETS = ["rifles", "carbinesnipershotgun", "smg", "set1", "set2", "equipments"]
HAND_AK = (-6, -1, -3.25, 0, 0, 180)  # x y z ry rz rx (the $definebone order Crowbar writes)
# hand-tuned lines (port_qc HAND_OFFSETS), printed next to the derived ones as a check
# world models no weapon script names (or whose anim_prefix has no animations: the Cobra's
# "cobra" set does not exist, the game falls back to the revolver's): the class to use
FALLBACK_PREFIX = {
    "w_cobra": "revolver", "w_rhogun": "revolver", "w_css_ignited": "csg", "w_dual_hp": "dualweapon",
    "w_kar98_dov": "boltaction", "w_ts3": "ts3", "w_type56xm148": "akxm148", "w_mk22_mod0": "pistol",
    "w_gyrojet_pepperbox": "gyrojet", "w_lunge_mine": "lungemine", "w_chainsaw": "chainsaw",
    "w_morph": "morph", "w_m16_flamer": "rifle",
}
TUNED = {
    "w_ak47": (-6, -1, -3.25, 0, 0, 180), "w_amd65": (-6, -1, -3.25, 0, 0, 180),
    "w_car15": (-6, -1, -3.25, 0, 0, 180), "w_xm177": (-6, -1, -3.25, 0, 0, 180),
    "w_aps": (-3.5, -1, -1.5, 0, 0, 180), "w_mle1935": (-3.5, -1, -1.5, 0, 0, 180),
    "w_browning_auto": (-11, -1, -2, 0, 0, 180), "w_chinalake": (-10, -1, 0, 15, 0, 180),
    "w_mas38": (-7, -1, -2, 0, 0, 180), "w_sks": (-10, -1, -2, 0, 0, 180), "w_rpd": (-6, -1, -2, 0, 0, 180),
}

# ---- 4x4 helpers ----------------------------------------------------------------------------
def ident(): return [[1.0 if i == j else 0.0 for j in range(4)] for i in range(4)]
def mul(A, B): return [[sum(A[i][k] * B[k][j] for k in range(4)) for j in range(4)] for i in range(4)]
def rx(a): c, s = math.cos(a), math.sin(a); return [[1,0,0,0],[0,c,-s,0],[0,s,c,0],[0,0,0,1]]
def ry(a): c, s = math.cos(a), math.sin(a); return [[c,0,s,0],[0,1,0,0],[-s,0,c,0],[0,0,0,1]]
def rz(a): c, s = math.cos(a), math.sin(a); return [[c,-s,0,0],[s,c,0,0],[0,0,1,0],[0,0,0,1]]
def trs(p, r):
    """Source: position, then RadianEuler(rx, ry, rz) -> Rz * Ry * Rx."""
    M = mul(rz(r[2]), mul(ry(r[1]), rx(r[0])))
    for i in range(3): M[i][3] = p[i]
    return M
def inv(M):
    R = [[M[j][i] for j in range(3)] for i in range(3)]
    t = [-sum(R[i][k] * M[k][3] for k in range(3)) for i in range(3)]
    out = ident()
    for i in range(3):
        for j in range(3): out[i][j] = R[i][j]
        out[i][3] = t[i]
    return out
def euler(M):
    y = math.asin(max(-1.0, min(1.0, -M[2][0])))
    if abs(math.cos(y)) > 1e-6:
        x = math.atan2(M[2][1], M[2][2]); z = math.atan2(M[1][0], M[0][0])
    else:
        x = math.atan2(-M[1][2], M[1][1]); z = 0.0
    return x, y, z
def def_from(off):
    """$definebone numbers (x y z ry rz rx, degrees) -> matrix."""
    return trs(off[:3], (math.radians(off[5]), math.radians(off[3]), math.radians(off[4])))
def def_to(M):
    x, y, z = euler(M)
    return [M[0][3], M[1][3], M[2][3], math.degrees(y), math.degrees(z), math.degrees(x)]

# ---- SMD: nodes and frame 0 (parent-relative) ----------------------------------------------
def smd_frame0(path):
    nodes = {}; frame = {}; sec = None; t = None
    with open(path, encoding="utf-8", errors="replace") as f:
        for line in f:
            tok = line.split()
            if not tok: continue
            if tok[0] in ("nodes", "skeleton", "triangles"): sec = tok[0]; continue
            if tok[0] == "end": sec = None; continue
            if sec == "nodes":
                m = re.match(r'\s*(\d+)\s+"([^"]+)"\s+(-?\d+)', line)
                nodes[int(m.group(1))] = (m.group(2), int(m.group(3)))
            elif sec == "skeleton":
                if tok[0] == "time":
                    t = int(tok[1])
                    if t > 0: break
                    continue
                if t == 0:
                    frame[int(tok[0])] = ([float(v) for v in tok[1:4]], [float(v) for v in tok[4:7]])
    return nodes, frame

def bone_local(nodes, frame, name):
    for i, (n, p) in nodes.items():
        if n.lower() == name.lower():
            return i, p, frame.get(i)
    return None, None, None

# ---- the player animation sets --------------------------------------------------------------
def ensure_rig(game, rig):
    """Pull the player animation models out of the VPK and decompile them (once)."""
    missing = [s for s in SETS if not os.path.isfile(os.path.join(rig, "dec_" + s, "player_animations_%s.qc" % s))]
    if not missing:
        return
    sys.path.insert(0, HERE)
    import vpklib
    vpk = vpklib.VPK(os.path.join(game, "pak01_dir.vpk"))
    for p in vpk.entries:
        if p.startswith("models/player/player_animations"):
            out = os.path.join(rig, p.replace("/", os.sep))
            os.makedirs(os.path.dirname(out), exist_ok=True)
            open(out, "wb").write(vpk.read(p))
    for s in missing:
        mdl = os.path.join(rig, "models", "player", "player_animations_%s.mdl" % s)
        print("decompiling", os.path.basename(mdl))
        r = subprocess.run([CROWBAR, "-p", mdl, "-o", os.path.join(rig, "dec_" + s)], capture_output=True, text=True)
        if "ERROR" in (r.stdout or "") + (r.stderr or ""):
            print("  crowbar reported errors (long paths?); output:\n" + (r.stdout or "")[-2000:])

def load_prefixes(rig):
    """prefix -> (A_right, A_left, set, anim smd): the weapon bone relative to the hand."""
    out = {}
    for s in SETS:
        qc = os.path.join(rig, "dec_" + s, "player_animations_%s.qc" % s)
        text = open(qc, encoding="utf-8", errors="replace").read()
        # the centre blend (body_yaw 0) of the hip idle
        for m in re.finditer(r'^\$sequence "([a-z0-9]+)_aim_idle" \{\s*\n\s*"[^"]+"\s*\n\s*"([^"]+)"', text, re.M):
            prefix, anim = m.group(1), m.group(2)
            am = re.search(r'^\$animation "%s" "([^"]+)"' % re.escape(anim), text, re.M)
            smd = am.group(1) if am else None
            if not smd:
                continue
            p = os.path.join(rig, "dec_" + s, smd.replace("\\", os.sep))
            if not os.path.isfile(p):
                print("  ! no smd for", prefix, smd); continue
            nodes, frame = smd_frame0(p)
            wi, wp, wl = bone_local(nodes, frame, "ValveBiped.weapon_bone")
            hi, _, _ = bone_local(nodes, frame, "ValveBiped.Bip01_R_Hand")
            li, lp, ll = bone_local(nodes, frame, "ValveBiped.weapon_bone_left")
            lhi, _, _ = bone_local(nodes, frame, "ValveBiped.Bip01_L_Hand")
            if wl is None or wp != hi:
                print("  ! %s: weapon_bone parent %s, hand %s" % (prefix, wp, hi)); continue
            A = trs(wl[0], wl[1])
            AL = trs(ll[0], ll[1]) if (ll is not None and lp == lhi) else None
            out[prefix] = (A, AL, s, os.path.basename(p))
    return out

# ---- weapon scripts: world model -> anim_prefix ---------------------------------------------
def load_scripts():
    wm = {}
    for f in glob.glob(os.path.join(CS, "weapon_*.txt")):
        t = open(f, encoding="utf-8", errors="replace").read()
        pm = re.search(r'"playermodel"\s+"models/weapons/(w_[^"]+)\.mdl"', t, re.I)
        ap = re.search(r'"anim_prefix"\s+"([^"]+)"', t, re.I)
        if pm and ap:
            wm.setdefault(pm.group(1).lower(), set()).add(ap.group(1).lower())
        for dm in re.finditer(r'"([a-z_]*playermodel[a-z_]*)"\s+"models/weapons/(w_[^"]+)\.mdl"', t, re.I):
            key, name = dm.group(1).lower(), dm.group(2).lower()
            if key != "playermodel":
                dp = re.search(r'"%s"\s+"([^"]+)"' % key.replace("playermodel", "anim_prefix"), t, re.I)
                wm.setdefault(name, set()).add((dp.group(1) if dp else (ap.group(1) if ap else "?")).lower())
    return wm

def root_bone(name):
    """The OG world model's root gun bone (from its reference smd)."""
    qc = os.path.join(OG, name, name + ".qc")
    s = open(qc, encoding="utf-8", errors="replace").read()
    m = re.search(r'studio\s+"([^"]+\.smd)"', s)
    if not m: return None
    nodes, frame = smd_frame0(os.path.join(OG, name, m.group(1).replace("\\", os.sep)))
    for i, (n, p) in nodes.items():
        if p == -1 and "weapon_bone" in n.lower() and not n.lower().endswith(("_left", "_l")):
            return n
    roots = [n for i, (n, p) in nodes.items() if p == -1]
    return "!" + (roots[0] if roots else "?")

def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--game", default=r"D:\SteamLibrary\steamapps\common\Military Conflict - Vietnam\vietnam")
    ap.add_argument("--rig", default=os.path.join(HERE, "rip", "player_rig"))
    ap.add_argument("--out", default=os.path.join(HERE, "hand_offsets_derived.json"))
    args = ap.parse_args()
    ensure_rig(args.game, args.rig)
    prefixes = load_prefixes(args.rig)
    scripts = load_scripts()
    print("animation classes: %d, weapon scripts with a world model: %d" % (len(prefixes), len(scripts)))
    K = mul(def_from(HAND_AK), prefixes["rifle"][0])
    S = ident(); S[1][1] = -1.0
    KL = mul(S, mul(K, S))
    results = {}; missing = []
    for d in sorted(glob.glob(os.path.join(OG, "w_*"))):
        name = os.path.basename(d)
        if not os.path.isfile(os.path.join(d, name + ".qc")): continue
        pref = scripts.get(name.lower())
        root = root_bone(name)
        p = [x for x in sorted(pref or ()) if x in prefixes]
        if not p:
            fb = FALLBACK_PREFIX.get(name) or ("dualweapon" if name.startswith("w_dual_") else None)
            if fb in prefixes:
                p = [fb]
        if not pref and not p:
            missing.append((name, "no weapon script names it", root)); continue
        if not p:
            missing.append((name, "anim_prefix %s has no aim_idle" % sorted(pref), root)); continue
        if not root or root.startswith("!"):
            missing.append((name, "root bone is not a weapon_bone", root)); continue
        A, AL, sset, smd = prefixes[p[0]]
        off = def_to(mul(K, inv(A)))
        entry = {"prefix": p[0], "set": sset, "anim": smd, "hand": [round(v, 3) for v in off]}
        if AL is not None:
            entry["hand_left"] = [round(v, 3) for v in def_to(mul(KL, inv(AL)))]
        results[name] = entry
        tuned = TUNED.get(name)
        print("%-22s %-14s %s%s" % (name, p[0], " ".join("%7.2f" % v for v in off),
                                    ("   tuned %s" % " ".join("%g" % v for v in tuned)) if tuned else ""))
    for m in missing:
        print("  - %-22s %s (root %s)" % m)
    json.dump(results, open(args.out, "w"), indent=1)
    print("wrote %s: %d world models" % (os.path.relpath(args.out, ADDON), len(results)))

if __name__ == "__main__":
    main()

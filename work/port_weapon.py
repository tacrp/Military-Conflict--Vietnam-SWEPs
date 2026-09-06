#!/usr/bin/env python3
"""
port_weapon.py - generate MCV GMod weapon Lua files from the game's weapon scripts.

    python port_weapon.py cscripts/weapon_sks.txt              # -> lua_port/mcv_sks.lua
    python port_weapon.py cscripts --all                        # every weapon_*.txt
    python port_weapon.py cscripts/weapon_sks.txt --out ../lua/weapons   # write into the addon

Data sources, in priority order:
  1. the game's weapon script (cscripts/weapon_X.txt)
  2. the viewmodel QC (MCV_SMD_PORT, then MCV_SMD, then MCV_SMD_OG) for everything that depends
     on what animations the model has: last-shot, clip loading, cycle, shotgun reload, revolver
     poses, grenade launcher, bayonet/grenade bodygroup indices, scope
  3. an existing lua/weapons/mcv_X.lua for the hand-tuned values that cannot be derived
     (ironsight position/angle, custom offset, print name, fire rate for semi-auto guns, scope
     material). Without one those fields are emitted with a "-- TODO tune" marker.

See PORTING.md for the tables.
"""
import argparse
import struct
import collections
import glob
import os
import re

HERE = os.path.dirname(os.path.abspath(__file__))
ADDON = os.path.normpath(os.path.join(HERE, ".."))

# --------------------------------------------------------------------------------------------
# Tables (derived from the 141 script/lua pairs, see correlate output in PORTING.md)
# --------------------------------------------------------------------------------------------

WEAPON_TYPE = {  # WeaponType -> (Slot, SubCategory, HoldType)
    "SubMachinegun": (2, "Submachine Guns", "smg"),
    "Rifle": (3, "Assault Rifles", "ar2"),
    "Carbine": (3, "Carbines", "ar2"),
    "Pistol": (1, "Pistols", "pistol"),
    "Machinegun": (3, "Light-Machine Guns", "ar2"),
    "BattleRifle": (3, "Battle Rifles", "ar2"),
    "MachinePistol": (1, "Machine Pistols", "pistol"),
    "Shotgun": (2, "Shotguns", "shotgun"),
    "Revolver": (1, "Revolvers", "revolver"),
    "GrenadeLauncher": (4, "Anti-Armor", "shotgun"),
    "Crossbow": (3, "Bows", "crossbow"),
    "Flaregun": (1, "Pistols", "pistol"),
    "Ptrd": (3, "Anti-Armor", "ar2"),
    "SniperRifle": (3, "Sniper Rifles", "ar2"),
    "RocketLauncher": (4, "Anti-Armor", "rpg"),
    "BoltActionRifle": (3, "Bolt-Action Rifles", "ar2"),
    "Melee": (0, "Melee", "melee"),
    "Grenade": (4, "Explosives", "grenade"),
    "SmokeGrenade": (4, "Explosives", "grenade"),
    "Mine": (4, "Explosives", "slam"),
    "Flaregun": (1, "Pistols", "pistol"),
    "RifleGrenade": (3, "Rifle Grenades", "ar2"),
    "Equipment": (5, "Equipment", "normal"),
}

# third person animation set per hold type: (hip, aim, sprint)
HOLDTYPES = {
    "ar2": ("ar2", "rpg", "passive"),
    "smg": ("smg", "smg", "passive"),
    "pistol": ("pistol", "revolver", "normal"),
    "revolver": ("revolver", "revolver", "normal"),
    "shotgun": ("shotgun", "shotgun", "passive"),
    "rpg": ("rpg", "rpg", "passive"),
    "melee": ("melee", "melee", "melee"),
    "grenade": ("grenade", "grenade", "grenade"),
    "slam": ("slam", "slam", "slam"),
    "normal": ("normal", "normal", "normal"),
}

AMMO = {  # primary_ammo -> (GMod ammo type, caliber label)
    "CrossbowBolt": ("mcv_crossbowbolt", "Crossbow Bolt"),
    "FlareRound": ("mcv_flareround", "26.5mm Flare"),
    "9x19mm": ("pistol", "9x19mm"),
    "5.56mm": ("ar2", "5.56x45mm"),
    "7.62x39": ("ar2", "7.62x39mm"),
    "7.62x63": ("ar2", ".30-06"),
    "7.62x54": ("ar2", "7.62x54mmR"),
    ".45ACP": ("pistol", ".45 ACP"),
    "12gauge": ("buckshot", "12 Gauge Shell"),
    "9x18mm": ("pistol", "9x18mm"),
    "7.62x25": ("pistol", "7.62x25mm Tokarev"),
    ".32acp": ("pistol", ".32 ACP"),
    "7.62x51": ("ar2", "7.62x51mm"),
    "7.62x33": ("ar2", ".30 Carbine"),
    "rpg_round": ("rpg_round", "Rocket"),
    "40mm_grenade": ("smg1_grenade", "40x46mm Grenade"),
    "7.92x57": ("ar2", "7.92x57mm"),
    "7.65x20": ("pistol", "7.65x20mm"),
    "7.92x33": ("ar2", "7.92x33mm"),
    ".22LR": ("pistol", ".22 Long Rifle"),
    "7.62x38": ("pistol", "7.62x38mmR"),
    ".38Special": ("pistol", ".38 Special"),
    "riflegrenade": ("smg1_grenade", "Rifle Grenade"),
    "None": ("", ""),
}

COUNTRY = {
    "#united_states_of_america": "United States of America",
    "#soviet_union": "Soviet Union",
    "#france": "France",
    "#nazi_germany": "Nazi Germany",
    "#united_kingdom": "United Kingdom",
    "#china": "People's Republic of China",
    "#australia": "Australia",
    "#czechslovakia": "Czechoslovakia",
    "#russian_empire": "Russian Empire",
    "#belgium": "Belgium",
    "#North_Vietnam": "Democratic Republic of Vietnam",
    "#polish_peoples_republic": "Polish People's Republic",
    "#sweden": "Sweden",
    "#republic_of_china": "Shanxi Province",
    "#Israel": "Israel",
    "#hungary": "Hungary",
    "#germany": "German Empire",
    "#italy": "Italy",
    "#yugoslavia": "Yugoslavia",
    "#denmark": "Kingdom of Denmark",
    "#romania": "Romania",
    "#germany2": "German Reich",
    "#japan": "Empire of Japan",
    "#north_korea": "Democratic People's Republic of Korea",
}

# Game EjectBrassType id -> MCV.ShellTypes index (lua/mcv/shared/sh_common.lua), by shell model.
BRASS = {0: 11, 1: 12, 2: 4, 3: 5, 4: 6, 5: 1, 6: 7, 7: 8, 8: 9, 9: 10, 10: 15, 11: 17,
         12: 16, 13: 18, 14: 3, 15: 2, 16: 13, 17: 14,
         # newer game ids (2025+); the addon has no dedicated shell model for most, nearest case
         19: 3, 20: 6, 21: 16, 22: 8, 23: 6, 24: 12, 26: 16, 27: 2, 28: 13, 29: 14, 30: 2, 31: 13}

# WeaponTypes the mcv_base can drive. Grenades, mines, flamethrowers, melee and equipment need
# their own bases and are skipped unless --all-types is given.
GUN_TYPES = {"SubMachinegun", "Rifle", "Carbine", "Pistol", "Machinegun", "BattleRifle", "MachinePistol", "Shotgun",
             "Revolver", "GrenadeLauncher", "SniperRifle", "RocketLauncher", "BoltActionRifle", "RifleGrenade",
             "Crossbow", "Flaregun", "Ptrd"}

# Muzzle flash effect names the addon uses (GMod stock effects; the game's particles need ARC9).
MUZZLE = {
    "Pistol": "muzzleflash_pistol", "MachinePistol": "muzzleflash_pistol", "Revolver": "muzzleflash_pistol",
    "SubMachinegun": "muzzleflash_pistol",
    "Shotgun": "muzzleflash_shotgun", "GrenadeLauncher": "muzzleflash_m79", "RocketLauncher": "muzzleflash_m79",
    "SniperRifle": "muzzleflash_m24", "BoltActionRifle": "muzzleflash_m24",
}
MUZZLE_DEFAULT = "muzzleflash_ak47"

FIREMODE = {"Auto": "MCV.FIREMODE_AUTO", "Semi": "MCV.FIREMODE_SEMI", "Burst": "MCV.FIREMODE_BURST",
            "Fast": "MCV.FIREMODE_FAST", "Slow": "MCV.FIREMODE_SLOW"}

VC_ORIGINS = {"#soviet_union", "#china", "#russian_empire", "#france", "#nazi_germany", "#polish_peoples_republic",
              "#North_Vietnam", "#czechslovakia", "#hungary", "#republic_of_china", "#north_korea"}

SHOOT_ENTITY = {"rpg2": "mcv_proj_rpg2", "rpg7": "mcv_proj_rpg", "m72": "mcv_proj_rpg", "m202": "mcv_proj_m202",
                "xm202": "mcv_proj_m202", "bazooka": "mcv_proj_bazooka", "panzerschreck": "mcv_proj_panzerschreck",
                "kolos": "mcv_proj_kolos",
                "crossbow": "mcv_proj_bolt", "m8": "mcv_proj_flare", "type97": "mcv_proj_flare",
                "m79": "mcv_proj_40mm", "m79_short": "mcv_proj_40mm", "china_lake": "mcv_proj_40mm", "chinalake": "mcv_proj_40mm"}

# projectile guns whose launch speed is the script's gl_velocity (m/s), not muzzle_velocity
GL_VELOCITY_GUNS = {"crossbow", "m8", "type97"}

# weapons that empty the whole clip in one trigger pull (the Kolos fires its seven rockets at once)
VOLLEY_ALL = {"kolos": 7}

# single-action revolvers whose dual wield reload swaps hands halfway (the Nagant does this in the game)
SA_DUAL_RELOAD = {"m1895", "blackhawk"}

# game script name -> addon lua name where the two cannot be matched through the viewmodel alone
# (several lua files share one viewmodel, or the model was renamed)
SCRIPT_ALIASES = {
    "mk22": "sw39",            # S&W M39-2 (the unsuppressed Mk 22); mk22_mod0 is the Hush Puppy"baby_browning": "babybrowning", "china_lake": "chinalake", "dual_hp": "dual_highpower",
                  "kar98k": "kar98", "kar98k_s": "kar98_s", "m1903": "springfield", "m1903s": "springfield_s",
                  "m1918_bar": "m1918_bar", "m1918": "m1918", "m1942": "m1942_machete", "stg44s": "stg44_s",
                  "svt40s": "svt40_s", "mas49s": "mas49_s", "m607s": "m607_s", "car15s": "car15_s",
                  "m21s": "m21", "m1gs": "m1d", "type17": "shanxi_type17"}

FIRE_ACT_RE = re.compile(r'ACT_VM_(PRIMARYATTACK|SHOOTLAST|RECOIL|ISHOOT|SHOOT)')

OPTICS_DIR = os.path.join(ADDON, "materials", "models", "weapons", "mcv", "optics")


def _norm(n):
    return re.sub(r'[^a-z0-9]', '', n.lower())


def resolve_lua_names(scripts_dir, addon=ADDON):
    """script name -> lua name (without the mcv_ prefix).

    Matched through the viewmodel path (the lua files were not named after the scripts). When
    several lua files share a viewmodel (kar98 / kar98_s, m1d / m1g), the alias table decides,
    then an exact name, then the closest name. A script whose viewmodel no lua uses maps to its
    own name (a new weapon)."""
    import difflib
    vm_to_luas = {}
    lua_names = set()
    for lp in glob.glob(os.path.join(addon, "lua", "weapons", "mcv_*.lua")):
        ln = os.path.basename(lp)[4:-4]
        lua_names.add(ln)
        m = re.search(r'SWEP\.ViewModel\s*=\s*"models/weapons/mcv/([^"]+)\.mdl"', open(lp, encoding="utf-8", errors="replace").read())
        if m:
            vm_to_luas.setdefault(m.group(1).lower(), []).append(ln)
    out = {}
    for sp in glob.glob(os.path.join(scripts_dir, "weapon_*.txt")):
        sname = os.path.basename(sp)[len("weapon_"):-4]
        if sname in SCRIPT_ALIASES:
            out[sname] = SCRIPT_ALIASES[sname]
            continue
        if sname in lua_names:
            out[sname] = sname
            continue
        m = re.search(r'"viewmodel"\s+"models/weapons/([^"]+)\.mdl"', open(sp, encoding="utf-8", errors="replace").read())
        cands = vm_to_luas.get(m.group(1).lower(), []) if m else []
        if not cands:
            out[sname] = sname
        elif len(cands) == 1:
            out[sname] = cands[0]
        else:
            ns = _norm(sname)
            out[sname] = max(cands, key=lambda c: (round(difflib.SequenceMatcher(None, ns, _norm(c)).ratio(), 3),
                                                   ns.startswith(_norm(c)), -len(c)))
    return out


def launcher_folds(scripts_dir):
    """The game's under-barrel launchers (m203, xm148, gp25) are weapons of their own that share
    the rifle's viewmodel. In the addon the launcher is a mode of the rifle, so the launcher
    script folds into the rifle script and lends it the grenade values.
    Returns {launcher script name: rifle script name}."""
    by_vm = {}
    types = {}
    for sp in glob.glob(os.path.join(scripts_dir, "weapon_*.txt")):
        sname = os.path.basename(sp)[len("weapon_"):-4]
        src = open(sp, encoding="utf-8", errors="replace").read()
        m = re.search(r'"viewmodel"\s+"models/weapons/([^"]+)\.mdl"', src)
        t = re.search(r'"WeaponType"\s+"([^"]+)"', src)
        if m and t:
            by_vm.setdefault(m.group(1).lower(), []).append(sname)
            types[sname] = t.group(1)
    out = {}
    for vm, names in by_vm.items():
        gls = [n for n in names if types[n] == "GrenadeLauncher" and not n.startswith("dual_")]
        rifles = [n for n in names if types[n] != "GrenadeLauncher" and not n.startswith("dual_")]
        if gls and rifles:
            rifle = sorted(rifles, key=len)[0]
            for g in gls:
                out[g] = rifle
    return out


def mdl_textures(vm):
    """Material names of the compiled viewmodel, in submaterial order."""
    p = os.path.join(ADDON, "models", "weapons", "mcv", vm + ".mdl")
    if not os.path.isfile(p):
        return []
    d = open(p, "rb").read()
    off = 4 + 4 + 4 + 64 + 4 + 12 * 6
    ints = struct.unpack_from("<41i", d, off + 44)
    numtex, texindex = ints[2], ints[3]
    names = []
    for i in range(numtex):
        t = texindex + i * 64
        nm = struct.unpack_from("<i", d, t)[0]
        names.append(d[t + nm:d.index(b"\0", t + nm)].decode("latin-1"))
    return names


def ensure_reticle_vmt(base):
    """The rip copies every crosshair_*.vtf of the game but only some come with a .vmt."""
    vmt = os.path.join(OPTICS_DIR, base + ".vmt")
    vtf = os.path.join(OPTICS_DIR, base + ".vtf")
    if os.path.isfile(vmt) or not os.path.isfile(vtf):
        return os.path.isfile(vmt)
    with open(vmt, "w", encoding="utf-8", newline="\n") as f:
        f.write('"VertexLitGeneric"\n{\n\t"$basetexture" "models\\weapons\\mcv\\optics\\%s"\n\t"$translucent" "1"\n\t"$nocsm" "1"\n}\n' % base)
    return True


def scope_info(vm, prefer=None):
    """(submaterial index of the lens, reticle material path) from the compiled model, or (None, None).

    The lens is the first material named lens_* (lens_<prefer> when given: the M607 / XM177
    model carries both the 4x lens and the OEG's lens_singlepoint); a few models (Vz.54 sniper)
    carry the reticle itself as a crosshair_* material instead. The reticle drawn into the
    render target is the matching crosshair_<suffix> texture from the game when the addon has it."""
    names = mdl_textures(vm)
    idx = None
    if prefer:
        for i, n in enumerate(names):
            if n.lower() == "lens_" + prefer:
                idx = i
                break
    for i, n in enumerate(names):
        if idx is None and n.lower().startswith("lens_"):
            idx = i
            break
    if idx is None:
        for i, n in enumerate(names):
            if n.lower().startswith("crosshair_"):
                idx = i
                break
    if idx is None:
        return None, None
    lens = names[idx].lower()
    suffix = lens.split("_", 1)[1] if "_" in lens else lens
    for cand in ("crosshair_" + suffix, lens):
        if ensure_reticle_vmt(cand):
            return idx, "models/weapons/mcv/optics/" + cand
    return idx, None


def eject_rule(qc, is_revolver, is_bolt, is_pump, is_rocket=False):
    """True when the shell must not be thrown by the shot: the animation set ejects it
    elsewhere (bolt pull, pump, revolver / break-action reload), or there is no shell."""
    if is_revolver or is_bolt or is_pump or is_rocket:
        return True
    return qc["eject_outside_fire"] and not qc["eject_in_fire"]

# --------------------------------------------------------------------------------------------
# KeyValues parsing
# --------------------------------------------------------------------------------------------

def parse_kv(text):
    text = re.sub(r'//[^\n]*', '', text)
    toks = []
    for m in re.finditer(r'"([^"]*)"|(\{)|(\})|([^\s"{}]+)', text):
        if m.group(2): toks.append("{")
        elif m.group(3): toks.append("}")
        elif m.group(1) is not None: toks.append(("s", m.group(1)))
        else: toks.append(("s", m.group(4)))
    def parse(i):
        d = collections.OrderedDict()
        while i < len(toks):
            t = toks[i]
            if t == "}":
                return d, i + 1
            key = t[1]; i += 1
            if i < len(toks) and toks[i] == "{":
                sub, i = parse(i + 1)
                d[key] = sub
            elif i < len(toks):
                d[key] = toks[i][1]; i += 1
        return d, i
    return parse(0)[0]

def flat(d, prefix=""):
    out = collections.OrderedDict()
    for k, v in d.items():
        if isinstance(v, dict):
            out.update(flat(v, prefix + k + "."))
        else:
            out[prefix + k] = v
    return out

# --------------------------------------------------------------------------------------------
# Viewmodel QC facts
# --------------------------------------------------------------------------------------------

def find_qc(vm_name):
    for root in ("MCV_SMD_PORT", "MCV_SMD", "MCV_SMD_OG"):
        p = os.path.join(HERE, root, "weapons", vm_name, vm_name + ".qc")
        if os.path.isfile(p):
            return p
    return None

def qc_facts(path):
    f = {"acts": set(), "bodygroups": [], "poseparams": [], "ammo_blend_reload": False, "hammer_events": False,
         "ammo_blend_names": [], "bullet_bodygroups": [], "eject_in_fire": False, "eject_outside_fire": False,
         "sequences": []}
    if not path:
        return f
    src = open(path, encoding="utf-8", errors="replace").read()
    f["acts"] = set(re.findall(r'activity\s+"([^"]+)"', src))
    f["bodygroups"] = re.findall(r'^\$bodygroup\s+"([^"]+)"', src, re.M)
    f["sequences"] = re.findall(r'^\$sequence\s+"([^"]+)"', src, re.M)
    f["poseparams"] = re.findall(r'^\$poseparameter\s+"([^"]+)"', src, re.M)
    f["hammer_events"] = "hammerpos" in src
    # the run layer's player_movement range: the game's walk speed for this weapon class (where
    # the run layer starts: 148 rifles, 106 M60, 80 LPO-50) and its sprint speed (where it is full)
    f["run_range"] = None
    m = re.search(r'^\$sequence\s+"runlayer"\s*\{(.*?)^\}', src, re.S | re.M)
    if m:
        b = re.search(r'blend\s+"player_movement"\s+(-?[\d.]+)\s+(-?[\d.]+)', m.group(1))
        if b:
            f["run_range"] = (float(b.group(1)), float(b.group(2)))
    # the sighted walk layer's top: full sighted walk at this player_movement (130 on rifles,
    # 106 M60, 80 LPO-50)
    f["sighted_top"] = None
    m = re.search(r'^\$sequence\s+"walklayerironsight"\s*\{(.*?)^\}', src, re.S | re.M)
    if m:
        b = re.search(r'blend\s+"player_movement"\s+(-?[\d.]+)\s+(-?[\d.]+)', m.group(1))
        if b:
            f["sighted_top"] = float(b.group(2))
    # reload animations: the frame the magazine / belt is swapped (the game's
    # AE_CL_BODYGROUP_SET_TO_NEXTCLIP event, _EMPTY when the old one comes out; the mag-in /
    # mag-out foley sounds as a fallback) and the fps, per reload activity
    f["reload_events"] = {}
    for m in re.finditer(r'^\$sequence\s+"([^"]+)"\s*\{(.*?)^\}', src, re.S | re.M):
        body = m.group(2)
        am = re.search(r'activity\s+"(ACT_VM_RELOAD|ACT_VM_RELOADEMPTY)"', body)
        if not am or am.group(1) in f["reload_events"]:
            continue
        e = {"fps": None, "nextclip": None, "nextclip_empty": None, "magin": None, "magout": None, "clippose": None}
        fm = re.search(r'^\s*fps\s+([\d.]+)', body, re.M)
        if fm:
            e["fps"] = float(fm.group(1))
        for ev, frame, arg in re.findall(r'\{\s*event\s+(\S+)\s+(\d+)\s+"([^"]*)"', body):
            frame = int(frame)
            if ev == "AE_CL_BODYGROUP_SET_TO_NEXTCLIP" and e["nextclip"] is None:
                e["nextclip"] = frame
            elif ev == "AE_CL_BODYGROUP_SET_TO_NEXTCLIP_EMPTY" and e["nextclip_empty"] is None:
                e["nextclip_empty"] = frame
            elif ev == "AE_WPN_NEXTCLIP_TO_POSEPARAM" and e["nextclip"] is None:
                # the game's other "the new magazine is in" event (M14 / XM21 family)
                e["nextclip"] = frame
            elif ev in ("AE_WPN_CLIP_TO_POSEPARAM", "AE_WPN_CLIPLOADED_TO_POSEPARAM") and frame >= 2:
                # the game refreshes the rounds shown here (the crossbow's string is drawn at 56);
                # a frame 0/1 event just primes the blend
                e["clippose"] = max(e["clippose"] or 0, frame)
            elif ev in ("5004", "AE_CL_PLAYSOUND"):
                low = arg.lower()
                if any(k in low for k in ("magin", "clipin", "bulletsin", "mag_in", "clip_in")) and e["magin"] is None:
                    e["magin"] = frame
                elif any(k in low for k in ("magout", "clipout", "bulletsout", "mag_out", "clip_out")) and e["magout"] is None:
                    e["magout"] = frame
        f["reload_events"][am.group(1)] = e
    # which hammerpos value the cycle animation (bolt pull / pump) carries: that is the event that
    # must release the action. Shotguns have shoot = 0 / pump = 1, bolt rifles shoot = 1 / bolt = 0.
    f["cycle_hammerpos"] = None
    for m in re.finditer(r'\$sequence\s+"[^"]+"\s*\{(.*?)\n\}', src, re.S):
        body = m.group(1)
        if re.search(r'activity\s+"(ACT_VM_RELOAD_INSERT_PULL|ACT_SHOTGUN_PUMP)"', body):
            ev = re.findall(r'hammerpos (\d)', body)
            if ev:
                f["cycle_hammerpos"] = int(ev[-1])
                break
    # belt / clip bullets modelled as bodygroups "bullet01".."bulletNN": their indices in bodygroup order
    f["bullet_bodygroups"] = [i for i, b in enumerate(f["bodygroups"]) if re.match(r'bullet\d+$', b.lower())]
    # the belt segment in the feed tray ("clamped*"): hidden with the last round
    # (only on belt-fed guns: the M16 family carries a "clamped1" of its own that is not a belt)
    f["belt_bodygroups"] = [i for i, b in enumerate(f["bodygroups"]) if re.match(r'clamped\d+$', b.lower())] if f["bullet_bodygroups"] else []
    for m in re.finditer(r'^\$sequence\s+"([^"]+)"\s*\{(.*?)^\}', src, re.S | re.M):
        body = m.group(2)
        if "AE_CLIENT_EJECT_BRASS" in body:
            acts_here = re.findall(r'activity\s+"([^"]+)"', body)
            if any(FIRE_ACT_RE.search(a) for a in acts_here):
                f["eject_in_fire"] = True
            else:
                f["eject_outside_fire"] = True
        # clip loaded weapons either blend the reload on ammo_fraction (SKS) or set the loaded
        # count from an event partway through the animation (Garand, SVT-40)
        if "RELOAD" in body and "delta" not in body and (
                'blend "ammo_fraction"' in body or "AE_WPN_CLIPLOADED_TO_POSEPARAM" in body):
            f["ammo_blend_reload"] = True
            f["ammo_blend_names"].append(m.group(1))
    return f

# --------------------------------------------------------------------------------------------
# Existing lua (hand-tuned values)
# --------------------------------------------------------------------------------------------

REUSE_KEYS = ("PrintName", "FireRate", "ScopeMaterial", "HasScope", "AdjustableScopes", "OEGScope", "Slot", "SubCategory", "Caliber",
              "CycleSpeed", "CyclePostDelay", "TriggerDelayTime", "IconOverride", "ViewModelFOV",
              "SightedViewModelFOV", "MuzzleParticle", "MuzzleParticle3rdPerson", "MuzzleParticleIronsighted",
              "RTScopeMaterialIndex", "IronsightSpeedScale", "InvertAnimationHammer", "AnimationHandlesHammer",
              "RifleGrenadeForce", "SoundGrenadeShot")

def shoot_anim_seconds(vm):
    """Length of the model's primary shot animation from the OG decompile (30 fps), or None."""
    for a in ("shoot1_a", "shoot_a", "shoot_hammer_a"):
        p = os.path.join(HERE, "MCV_SMD_OG", "weapons", vm, vm + "_anims", a + ".smd")
        if os.path.isfile(p):
            frames = open(p, encoding="utf-8", errors="replace").read().count("\ntime ")
            if frames > 1:
                return frames / 30.0
    return None


def sight_offsets(S):
    """IronsightPos / IronsightAng / CustomPos / CustomAng lua values from the script's viewmodel
    offset keys (ironsightright/forward/up/pitch/yaw/roll and the CustomOffset block).

    These are the values the game itself applies, and the ironsight animations are authored for
    them: the current rig puts every gun dead straight in the aimed pose, so any lateral or yaw
    fudge on top pushes the front sight off the rear sight. The offsets the first port carried
    were hand-tuned against the previous rig, which had a small per-gun yaw baked into the aimed
    pose, and mis-centred every sight after the recompile. None when the script has no offsets
    (equipment)."""
    if "ironsightforward" not in S and "ironsightright" not in S:
        return None
    def g(key, default=0.0):
        return num(S.get(key), default)
    def vec(right, forward, up):
        return "Vector(%s, %s, %s)" % (fmt(right), fmt(forward), fmt(up))
    def ang(pitch, yaw, roll):
        return "Angle(%s, %s, %s)" % (fmt(pitch), fmt(yaw), fmt(roll))
    out = {
        "IronsightPos": vec(g("ironsightright"), g("ironsightforward"), g("ironsightup")),
        "IronsightAng": ang(g("ironsightpitch"), g("ironsightyaw"), g("ironsightroll")),
        "CustomPos": vec(g("CustomOffset.right"), g("CustomOffset.forward"), g("CustomOffset.up")),
        "CustomAng": ang(g("CustomOffset.pitch"), g("CustomOffset.yaw"), g("CustomOffset.roll")),
    }
    # the lens picture is rendered at the game's scope camera FOV (ScopeLensFov, second zoom
    # level ScopeLensFov2); the world keeps the ironsight FOV
    if num(S.get("ScopeLensFov")):
        out["ScopeFOV"] = fmt(num(S.get("ScopeLensFov")))
        out["ScopeFOV2"] = fmt(num(S.get("ScopeLensFov2")) or num(S.get("ScopeLensFov")))
    if num(S.get("BulletSpreadDegreesBipod")):
        out["SpreadBipod"] = fmt(num(S.get("BulletSpreadDegreesBipod")))
        out["SpreadBipodIronsighted"] = fmt(num(S.get("BulletSpreadDegreesBipodIronsighted")) or num(S.get("BulletSpreadDegreesBipod")))
    if S.get("isSupressed") == "1":
        out["TracerParticle"] = '""'
    return out

def akimbo_timing(vm):
    """AkimboPoseRecoil / AkimboRecoilTime for a single-wield viewmodel whose dual model
    (v_dual_<name>) was compiled with the recoil_r / recoil_l pose layers (port_qc.py
    --pose-recoil): the recoil time is the hand's shot animation length."""
    out = {}
    dual = "v_dual_" + vm[2:] if vm.startswith("v_") else None
    if not dual:
        return out
    qp = find_qc(dual)
    if not qp:
        return out
    dq = qc_facts(qp)
    times = akimbo_reload_times(qp)
    if times:
        out["AkimboMagInTimes"] = times
    if "recoil_r" not in dq["poseparams"]:
        return out
    out["AkimboPoseRecoil"] = "true"
    for a in ("shoot1_r_a", "shoot_hammer_right_a", "shoot1_a"):
        p = os.path.join(HERE, "MCV_SMD_OG", "weapons", dual, dual + "_anims", a + ".smd")
        if os.path.isfile(p):
            frames = open(p, encoding="utf-8", errors="replace").read().count("\ntime ")
            if frames > 1:
                out["AkimboRecoilTime"] = fmt(round(frames / 30.0, 2))
                break
    return out


# the dual reload activities as the port maps them (port_qc ACT_MAP_DUAL_MAG)
AKIMBO_RELOAD_ACTS = {
    "ACT_VM_SECONDARY_RELOAD": "ACT_VM_RELOAD",
    "ACT_VM_RELOAD": "ACT_VM_MISSRIGHT",
    "ACT_VM_RELOADEMPTY": "ACT_VM_MISSRIGHT2",
    "ACT_VM_SECONDARY_RELOADEMPTY": "ACT_VM_RELOADEMPTY",
}


def akimbo_reload_times(qc_path):
    """`AkimboMagInTimes` lua table for a dual model: per reload activity, the second each gun's
    magazine takes its new count, from the AE_WPN_NEXTCLIP_TO_POSEPARAM events on ammo_fraction1
    (the right gun's bullet counter) and ammo_fraction2 (the left gun's). None without them
    (the dual revolvers load shells one at a time)."""
    try:
        src = open(qc_path, encoding="utf-8", errors="replace").read()
    except OSError:
        return None
    # a ported qc already carries the GMod activities; the OG one needs the port's mapping
    ported = "Generated by port_qc.py" in src[:200]
    entries = []
    for m in re.finditer(r'\$sequence\s+"([^"]+)"\s*\{(.*?)\n\}', src, re.S):
        body = m.group(2)
        am = re.search(r'activity\s+"(\w+)"', body)
        if not am:
            continue
        if ported:
            if am.group(1) not in AKIMBO_RELOAD_ACTS.values():
                continue
            act = am.group(1)
        else:
            if am.group(1) not in AKIMBO_RELOAD_ACTS:
                continue
            act = AKIMBO_RELOAD_ACTS[am.group(1)]
        fm = re.search(r'^\s*fps\s+([\d.]+)', body, re.M)
        fps = float(fm.group(1)) if fm else 30.0
        right = left = None
        for fr, pose in re.findall(r'\{\s*event\s+AE_WPN_NEXTCLIP_TO_POSEPARAM\s+(\d+)\s+"(ammo_fraction[12])"', body):
            if pose == "ammo_fraction1":
                right = round(int(fr) / fps, 2)
            else:
                left = round(int(fr) / fps, 2)
        if right is None and left is None:
            continue
        entries.append("[%s] = {%s, %s}" % (act, fmt(right) if right is not None else "nil", fmt(left) if left is not None else "nil"))
    if not entries:
        return None
    return "{" + ", ".join(entries) + "}"


def akimbo_sight_offsets(name, scripts_dir=None):
    """IronsightPosAkimbo / IronsightAngAkimbo from weapon_dual_<name>.txt when the dual model is
    aimed differently from the single one (13 of the 41 pairs)."""
    scripts_dir = scripts_dir or os.path.join(HERE, "cscripts")
    dp = os.path.join(scripts_dir, "weapon_dual_%s.txt" % name)
    sp = os.path.join(scripts_dir, "weapon_%s.txt" % name)
    if not (os.path.isfile(dp) and os.path.isfile(sp)):
        return {}
    D = flat(parse_kv(open(dp, encoding="utf-8", errors="replace").read()).get("WeaponData", {}))
    S = flat(parse_kv(open(sp, encoding="utf-8", errors="replace").read()).get("WeaponData", {}))
    so_d, so_s = sight_offsets(D), sight_offsets(S)
    if not so_d or not so_s:
        return {}
    if so_d["IronsightPos"] == so_s["IronsightPos"] and so_d["IronsightAng"] == so_s["IronsightAng"]:
        return {}
    return {"IronsightPosAkimbo": so_d["IronsightPos"], "IronsightAngAkimbo": so_d["IronsightAng"]}


def anim_timing(qc):
    """Lua values read off the viewmodel's animations: where the run layer starts and ends
    (MovementPoseWalk / MovementPoseSprint, so walking never bleeds into the sprint pose) and when
    the reload animations swap the magazine or belt (MagInTime / MagOutTime, and the *Empty pair
    for the empty reload; from AE_CL_BODYGROUP_SET_TO_NEXTCLIP or the mag foley events)."""
    out = {}
    if qc and qc.get("belt_bodygroups"):
        out["BeltBodygroups"] = "{%s}" % ", ".join(str(i) for i in qc["belt_bodygroups"])
    rr = qc.get("run_range") if qc else None
    if rr:
        out["MovementPoseWalk"] = fmt(rr[0])
        out["MovementPoseSprint"] = fmt(rr[1])
        st = qc.get("sighted_top") or rr[0]
        out["MovementPoseSighted"] = fmt(st)
    ev = (qc or {}).get("reload_events") or {}
    times = {}
    for act, kin, kout in (("ACT_VM_RELOAD", "MagInTime", "MagOutTime"),
                           ("ACT_VM_RELOADEMPTY", "MagInTimeEmpty", "MagOutTimeEmpty")):
        e = ev.get(act)
        if not e:
            continue
        fps = e.get("fps") or 30.0
        tin = e["nextclip"]
        if tin is None:
            tin = e["clippose"] if e["clippose"] is not None else e["magin"]
        # the rounds shown only go to zero between the game's own "old belt out" event
        # (AE_CL_BODYGROUP_SET_TO_NEXTCLIP_EMPTY) and the swap; the mag-out foley fires while the
        # magazine is still on screen, which emptied the belt in the player's hand
        tout = e["nextclip_empty"]
        if tin is None:
            continue
        times[kin] = round(tin / fps, 2)
        times[kout] = round(tout / fps, 2) if (tout is not None and tout < tin) else 0
    if "MagInTime" in times and "MagInTimeEmpty" not in times:
        # no separate empty reload animation: the empty reload plays the same one
        times["MagInTimeEmpty"] = times["MagInTime"]
        if "MagOutTime" in times:
            times["MagOutTimeEmpty"] = times["MagOutTime"]
    for k, v in times.items():
        out[k] = fmt(v)
    return out


def bodygroups_string(qc_bodygroups, S):
    """SWEP.BodyGroups digits from the script's BodygroupData block ("scope" "1" ...) laid over
    the model's bodygroup order. Unlisted groups stay 0. The plain CAR-15 / XM177 / M14 early
    carry the scope group at 1 (blank) this way; without it the scope body sat over their
    iron sights."""
    digits = []
    for name in qc_bodygroups:
        v = S.get("BodygroupData." + name)
        if v is None:
            v = S.get("BodygroupData." + name.lower())
        try:
            digits.append(str(int(float(v))) if v not in (None, "") else "0")
        except ValueError:
            digits.append("0")
    return "".join(digits)


def read_existing(lua_path):
    d = {}
    if not lua_path or not os.path.isfile(lua_path):
        return d
    src = open(lua_path, encoding="utf-8", errors="replace").read()
    for m in re.finditer(r'^SWEP\.([A-Za-z0-9_.]+)\s*=\s*(.+?)\s*$', src, re.M):
        val = m.group(2)
        val = re.sub(r'\s*//.*$', '', val)
        val = re.sub(r'\s*--.*$', '', val)
        d[m.group(1)] = val.strip()
    fm = re.search(r'SWEP\.Firemodes\s*=\s*\{(.*?)\}', src, re.S)
    if fm:
        d["Firemodes"] = [x.strip() for x in fm.group(1).replace("\n", " ").split(",") if x.strip()]
    bb = re.search(r'^SWEP\.BulletBodygroups\s*=\s*\{.*?^\}', src, re.S | re.M)
    if bb:
        d["BulletBodygroupsBlock"] = bb.group(0)
    return d

# --------------------------------------------------------------------------------------------
# Generation
# --------------------------------------------------------------------------------------------

def num(s, default=0):
    try:
        return float(s)
    except (TypeError, ValueError):
        return default

def fmt(v):
    if isinstance(v, bool):
        return "true" if v else "false"
    if isinstance(v, float):
        return ("%g" % v)
    if isinstance(v, int):
        return str(v)
    return '"%s"' % v

def pretty_name(printname):
    n = printname.lstrip("#")
    n = re.sub(r'^weapon_', '', n, flags=re.I)
    n = n.replace("_", " ")
    return " ".join(w if w.isupper() or any(c.isdigit() for c in w) else w.capitalize() for w in n.split())

OVERRIDES_DIR = os.path.join(HERE, "overrides")


def load_overrides():
    """work/overrides/weapon_<name>.txt: KeyValues fragments merged over the game's script.
    Any WeaponData key can be overridden; custom tags:
        "MergeInto" "<base script name>"   fold this weapon into another (rifle grenade variants)
    These files are ours, so they survive `rip_game.py --steps scripts`."""
    out = {}
    for f in glob.glob(os.path.join(OVERRIDES_DIR, "weapon_*.txt")):
        name = os.path.basename(f)[len("weapon_"):-4]
        kv = parse_kv(open(f, encoding="utf-8", errors="replace").read())
        wd = kv.get("WeaponData") or kv
        out[name] = flat(wd)
    return out


def _wm_of(S, vm):
    m = re.search(r'models/weapons/([^"]+)\.mdl', S.get("playermodel", "") or "")
    return m.group(1) if m else "w_" + vm[2:]


def _header(name, base, S, args, existing, printname_default, subcat, slot):
    country = COUNTRY.get(S.get("origin", ""))
    if country is None and args.strings:
        country = args.strings.get(S.get("origin", "").lstrip("#").lower())
    game_name = args.strings.get(S.get("printname", "").lstrip("#").lower()) if args.strings else None
    out = ['SWEP.Base = "%s"' % base, "", "SWEP.Spawnable = true", "", "AddCSLuaFile()", "",
           "// Generated by work/port_weapon.py from cscripts/weapon_%s.txt" % name, "",
           "// Names and basic information",
           "SWEP.PrintName = %s" % (existing.get("PrintName") or fmt(game_name or pretty_name(S.get("printname", printname_default)))),
           'SWEP.Category = "Military Conflict: Vietnam"',
           "SWEP.Country = %s" % fmt(country or ""),
           "SWEP.SubCategory = %s" % (existing.get("SubCategory") or fmt(subcat)),
           "", "SWEP.Slot = %s" % (existing.get("Slot") or slot), ""]
    return out


def generate_throwable(name, S, qc, vm, args, existing, warnings):
    """Grenade / SmokeGrenade / Incendiary scripts -> mcv_throwable."""
    wtype = S.get("WeaponType")
    dmg = num(S.get("ExplosionDamage"), 0)
    radius = num(S.get("ExplosionRadius"), 0)
    ignite = num(S.get("IgniteRadius"), 0)
    if wtype == "Incendiary":
        ent, ammo = "mcv_grenade_molotov", "mcv_molotov"
    elif wtype == "SmokeGrenade":
        ent, ammo = ("mcv_grenade_gas" if dmg > 0 else "mcv_grenade_smoke"), "mcv_grenade"
    else:
        ent, ammo = ("mcv_grenade_wp" if ignite > 0 else "mcv_grenade_frag"), "mcv_grenade"
    seqs = set(qc["sequences"])
    for need in ("drawbackhigh", "throw"):
        if need not in seqs:
            warnings.append("viewmodel has no %s sequence" % need)
    clip = (S.get("clip_size") or "-1/2").split("/")
    carried = int(num(clip[1], 2)) if len(clip) > 1 else 2
    fuses = sorted({num(S.get("FuseTimeMin"), 3), num(S.get("FuseTimeMax"), 5)})
    color = S.get("SmokeColor") or S.get("SmokeColors.0")

    out = _header(name, "mcv_throwable", S, args, existing, name, "Grenades", 4)
    A = out.append
    A('SWEP.ViewModel = "models/weapons/mcv/%s.mdl"' % vm)
    A('SWEP.WorldModel = "models/weapons/mcv/%s.mdl"' % _wm_of(S, vm))
    pm = re.search(r'models/weapons/([^"]+)\.mdl', S.get("projectilemodel", "") or "")
    if pm:
        A('SWEP.ThrowModel = "models/weapons/mcv/%s.mdl"' % pm.group(1))
    A("")
    A('SWEP.ThrowEntity = "%s"' % ent)
    if wtype == "Incendiary":
        A("SWEP.FuseImpact = true")
        A("SWEP.FuseModes = {0}")
    else:
        A("SWEP.FuseModes = {%s}" % ", ".join(fmt(f) for f in fuses))
    A("SWEP.HasUnderhand = %s" % fmt("drawbacklow" in seqs))
    A("")
    A("SWEP.ExplosionDamage = %s" % fmt(dmg))
    A("SWEP.ExplosionRadius = %s" % fmt(radius))
    if ignite:
        A("SWEP.IgniteRadius = %s" % fmt(ignite))
    if color and wtype == "SmokeGrenade" and dmg == 0:
        parts = color.split()
        if len(parts) == 3:
            A("SWEP.SmokeColor = Vector(%s, %s, %s)" % tuple(parts))
    A("")
    A('SWEP.Primary.Ammo = "%s"' % ammo)
    A("SWEP.Primary.ClipSize = -1")
    A("SWEP.Primary.DefaultClip = %d" % carried)
    A("")
    A("SWEP.WeaponWeight = %s" % fmt(num(S.get("weight"), 1)))
    if existing.get("IconOverride"):
        A("SWEP.IconOverride = %s" % existing["IconOverride"])
    A("")
    return "\n".join(out), warnings


def generate_melee(name, S, qc, vm, args, existing, warnings):
    """Melee / Fists scripts -> mcv_melee."""
    seqs = set(qc["sequences"])
    if not seqs & {"slash", "swing_a", "stab"}:
        warnings.append("viewmodel has no slash / stab sequence")
    dmg = num(S.get("DamageGeneric"), 30)
    dmg_alt = num(S.get("DamageGenericAlt"), 0)
    is_fists = S.get("WeaponType") == "Fists" or name == "fists"
    is_wrench = "repair" in seqs
    out = _header(name, "mcv_melee", S, args, existing, name, "Melee", 0)
    A = out.append
    A('SWEP.ViewModel = "models/weapons/mcv/%s.mdl"' % vm)
    A('SWEP.WorldModel = "models/weapons/mcv/%s.mdl"' % _wm_of(S, vm))
    A("")
    if is_fists:
        A('SWEP.HoldType = "fist"')
        A('SWEP.AimHoldType = "fist"')
    elif "shovel" in name or "crowbar" in name or is_wrench:
        A('SWEP.HoldType = "melee"')
        A('SWEP.AimHoldType = "melee"')
    A("")
    A("SWEP.DamageGeneric = %s" % fmt(dmg))
    if dmg_alt:
        A("SWEP.DamageGenericAlt = %s" % fmt(dmg_alt))
    A("SWEP.MeleeRange = %s" % fmt(num(S.get("MeleeRange"), 48)))
    A("SWEP.MeleeRangeAlt = %s" % fmt(num(S.get("MeleeRangeAlt"), num(S.get("MeleeRange"), 48) + 8)))
    A("SWEP.SlashRate = %s" % fmt(num(S.get("FireRate"), 150)))
    A("")
    A("SWEP.CanThrow = %s" % fmt("throw" in seqs and not is_wrench))
    if is_wrench:
        A("SWEP.CanRepair = true")
    A("")
    def snd(key, default):
        v = S.get("SoundData." + key, "")
        return fmt("MCV_" + v) if v and not v.startswith(("Flesh.", "Default.")) else fmt(default)
    A("SWEP.SoundHitFlesh = %s" % snd("melee_hit", "MCV_Weapon_Fists.Punch" if is_fists else "MCV_Weapon_M1942.Stab"))
    A("SWEP.SoundHitWorld = %s" % snd("melee_hit_world", "MCV_Weapon_Fists.PunchWall" if is_fists else "MCV_Weapon_M1942.Hit"))
    A("SWEP.SoundThrustFlesh = %s" % snd("special1", "MCV_Weapon_Fists.PowerPunch" if is_fists else "MCV_Weapon_M1942.ThrustStab"))
    A("SWEP.SoundThrustWorld = %s" % snd("special2", "MCV_Weapon_Fists.PowerPunchWall" if is_fists else "MCV_Weapon_M1942.ThrustHit"))
    A("")
    A("SWEP.WeaponWeight = %s" % fmt(num(S.get("weight"), 1)))
    if existing.get("IconOverride"):
        A("SWEP.IconOverride = %s" % existing["IconOverride"])
    A("")
    return "\n".join(out), warnings


def generate_equipment(name, S, qc, vm, args, existing, warnings):
    """Equipment scripts: ammo / medic boxes -> mcv_equipment_box, binoculars -> mcv_binoculars."""
    if name.startswith("binoculars"):
        if name not in ("binoculars_us", "binoculars_vc"):
            return None, ["artillery / napalm / barrage binoculars need a strike system; only the plain ones are converted"]
        out = _header(name, "mcv_binoculars", S, args, existing, name, "Equipment", 4)
        A = out.append
        A('SWEP.ViewModel = "models/weapons/mcv/%s.mdl"' % vm)
        A('SWEP.WorldModel = "models/weapons/mcv/%s.mdl"' % _wm_of(S, vm))
        A("")
        A("SWEP.IronsightPos = %s" % (existing.get("IronsightPos") or "Vector(0, -4, 0) -- TODO tune"))
        A("SWEP.IronsightAng = %s" % (existing.get("IronsightAng") or "Angle(0, 0, 0) -- TODO tune"))
        A("")
        return "\n".join(out), warnings
    if "box" not in name:
        return None, ["equipment %s is not supported yet" % name]
    kind = "medic" if "medic" in name else "ammo"
    clip = (S.get("clip_size") or "-1/3").split("/")
    carried = int(num(clip[1], 3)) if len(clip) > 1 else 3
    out = _header(name, "mcv_equipment_box", S, args, existing, name, "Equipment", 4)
    A = out.append
    A('SWEP.ViewModel = "models/weapons/mcv/%s.mdl"' % vm)
    A('SWEP.WorldModel = "models/weapons/mcv/%s.mdl"' % _wm_of(S, vm))
    A("")
    A('SWEP.BoxKind = "%s"' % kind)
    A('SWEP.Primary.Ammo = "%s"' % ("mcv_medicbox" if kind == "medic" else "mcv_ammobox"))
    A("SWEP.Primary.ClipSize = -1")
    A("SWEP.Primary.DefaultClip = %d" % carried)
    A("")
    return "\n".join(out), warnings


def generate_placeable(name, S, qc, vm, args, existing, warnings):
    """C4 / dynamite / mines -> mcv_placeable."""
    wtype = S.get("WeaponType")
    if wtype == "Mine":
        kind, ent, ammo = "mine", "mcv_placed_mine", "mcv_mine"
    elif "dynamite" in name:
        kind, ent, ammo = "dynamite", "mcv_placed_dynamite", "mcv_explosive_charge"
    else:
        kind, ent, ammo = "c4", "mcv_placed_c4", "mcv_explosive_charge"
    seqs = set(qc["sequences"])
    need = "placemine" if kind == "mine" else "plant"
    if need not in seqs:
        warnings.append("viewmodel has no %s sequence" % need)
    clip = (S.get("clip_size") or "-1/1").split("/")
    carried = int(num(clip[1], 1)) if len(clip) > 1 else 1
    out = _header(name, "mcv_placeable", S, args, existing, name, "Explosives", 4)
    A = out.append
    A('SWEP.ViewModel = "models/weapons/mcv/%s.mdl"' % vm)
    A('SWEP.WorldModel = "models/weapons/mcv/%s.mdl"' % _wm_of(S, vm))
    A("")
    A('SWEP.PlaceKind = "%s"' % kind)
    A('SWEP.PlacedEntityClass = "%s"' % ent)
    A("SWEP.ExplosionDamage = %s" % fmt(num(S.get("ExplosionDamage"), 500)))
    A("SWEP.ExplosionRadius = %s" % fmt(num(S.get("ExplosionRadius"), 500)))
    A("")
    A('SWEP.Primary.Ammo = "%s"' % ammo)
    A("SWEP.Primary.ClipSize = -1")
    A("SWEP.Primary.DefaultClip = %d" % carried)
    A("")
    A("SWEP.WeaponWeight = %s" % fmt(num(S.get("weight"), 2)))
    A("")
    return "\n".join(out), warnings


def generate_flamethrower(name, S, qc, vm, args, existing, warnings):
    """Flamethrower scripts -> mcv_flamethrower (a gun base with a fire stream)."""
    clip = (S.get("clip_size") or "-1/100").split("/")
    fuel = int(num(clip[1], 100)) if len(clip) > 1 else 100
    out = _header(name, "mcv_flamethrower", S, args, existing, name, "Flamethrowers", 3)
    A = out.append
    A('SWEP.ViewModel = "models/weapons/mcv/%s.mdl"' % vm)
    A('SWEP.WorldModel = "models/weapons/mcv/%s.mdl"' % _wm_of(S, vm))
    A("")
    A("SWEP.DamageGeneric = %s" % fmt(num(S.get("DamageGeneric"), 15)))
    A("SWEP.FireRate = %s" % fmt(num(S.get("FireRate"), 600)))
    A("")
    def snd(key, default):
        v = S.get("SoundData." + key, "")
        return fmt("MCV_" + v) if v else fmt(default)
    A("SWEP.SoundFireStart = %s" % snd("single_shot", "MCV_Weapon_LPO50.Primary_Fire_Start"))
    A("SWEP.SoundFireLoop = %s" % snd("special1", "MCV_Weapon_LPO50.Primary_Fire_Loop"))
    A("SWEP.SoundFireStop = %s" % snd("special2", "MCV_Weapon_LPO50.Primary_Fire_Stop"))
    A("")
    A("SWEP.IronsightPos = %s" % (existing.get("IronsightPos") or "Vector(0, -4, 0) -- TODO tune"))
    A("SWEP.IronsightAng = %s" % (existing.get("IronsightAng") or "Angle(0, 0, 0) -- TODO tune"))
    A("")
    A('SWEP.Primary.Ammo = "mcv_flamethrower_fuel"')
    A("SWEP.Primary.ClipSize = -1")
    A("SWEP.Primary.DefaultClip = %d" % fuel)
    A("")
    A("SWEP.WeaponWeight = %s" % fmt(num(S.get("weight"), 8)))
    A("")
    return "\n".join(out), warnings


EQUIPMENT_GENERATORS = {"Grenade": generate_throwable, "SmokeGrenade": generate_throwable, "Incendiary": generate_throwable,
                        "Melee": generate_melee, "Fists": generate_melee, "Equipment": generate_equipment,
                        "C4": generate_placeable, "Mine": generate_placeable, "Flamethrower": generate_flamethrower}


def generate(script_path, args):
    name = os.path.basename(script_path)[len("weapon_"):-4]
    kv = parse_kv(open(script_path, encoding="utf-8", errors="replace").read())
    wd = kv.get("WeaponData") or next(iter(kv.values()), {})
    S = flat(wd)
    warnings = []
    ov = args.overrides.get(name, {})
    for k, v in ov.items():
        if k != "MergeInto":
            S[k] = v
    # weapons folded into this one (weapon_x_riflegrenade with "MergeInto" "x")
    merged_variants = [vn for vn, o in args.overrides.items() if o.get("MergeInto") == name]

    vm = S.get("viewmodel", "").replace("models/weapons/", "").replace(".mdl", "")
    wm = S.get("playermodel", "").replace("models/weapons/", "").replace(".mdl", "")
    if not vm:
        return None, ["no viewmodel"]
    qc = qc_facts(find_qc(vm))
    acts = qc["acts"]

    lua_name = args.name_map.get(name, name)
    existing = read_existing(os.path.join(args.addon, "lua", "weapons", "mcv_%s.lua" % lua_name)) if args.reuse else {}
    def reuse(key):
        return existing.get(key) if args.reuse else None

    wtype = S.get("WeaponType")
    if not wtype and ("MeleeRange" in S or name in ("wrench", "fists")):
        wtype = "Melee"
    if not wtype and S.get("primary_ammo") == "flamethrower_fuel":
        wtype = "Flamethrower"
    if not wtype and S.get("primary_ammo") == "explosive_charge":
        wtype = "C4"
    if name.endswith("_zombie"):
        return None, ["zombie mode variant"]
    if wtype in EQUIPMENT_GENERATORS:
        return EQUIPMENT_GENERATORS[wtype](name, S, qc, vm, args, existing, warnings)
    if args.guns_only and wtype not in GUN_TYPES:
        return None, ["not a gun (WeaponType %s)" % wtype]
    wtype = wtype or "Rifle"
    slot, subcat, holdtype = WEAPON_TYPE.get(wtype, (3, wtype, "ar2"))
    if wtype not in WEAPON_TYPE:
        warnings.append("unknown WeaponType %s" % wtype)

    ammo_type, caliber = AMMO.get(S.get("primary_ammo", "None"), (None, None))
    if ammo_type is None:
        warnings.append("unknown primary_ammo %s" % S.get("primary_ammo"))
        ammo_type, caliber = "ar2", S.get("primary_ammo", "")

    clip = S.get("clip_size", "10/30").split("/")
    clipsize = int(num(clip[0], 10))
    maxammo = int(num(clip[1], clipsize * 3)) if len(clip) > 1 else clipsize * 3
    chamber = int(num(S.get("ExtraBulletChamber"), 0))

    # ---- fire modes ----------------------------------------------------------------------
    modes = [m for m in S.get("SupportedFireModes", "Semi").split("+") if m]
    is_revolver = wtype == "Revolver" or "revolver_firemode_pose" in qc["poseparams"]
    # a cycle animation on anything that is not automatic is a manually operated action; the
    # Welrod (Pistol) belongs here too. "ManualAction" "1" in an override forces it for models
    # whose shoot animation contains the cycling (3-round Vietcong pistol).
    is_bolt = ("ACT_VM_RELOAD_INSERT_PULL" in acts and wtype in ("BoltActionRifle", "SniperRifle", "Carbine", "BattleRifle", "Rifle", "Pistol") and "Auto" not in modes and "ACT_SHOTGUN_PUMP" not in acts) \
        or S.get("ManualAction") == "1"
    is_pump = "ACT_VM_RELOAD_INSERT_PULL" in acts and wtype in ("Shotgun", "GrenadeLauncher")
    is_volley = "ACT_VM_RECOIL1" in acts
    if is_revolver and "ACT_VM_HAULBACK" in acts:
        # the game's order: hammer (single action), western (fan), delayed (double action)
        firemodes = ["MCV.FIREMODE_SA", "MCV.FIREMODE_FAN", "MCV.FIREMODE_DA"] if "ACT_VM_PRIMARYATTACK_1" in acts else ["MCV.FIREMODE_SA", "MCV.FIREMODE_DA"]
    elif is_bolt:
        firemodes = ["MCV.FIREMODE_BOLT"]
    elif is_pump:
        firemodes = ["MCV.FIREMODE_PUMP"]
    else:
        firemodes = [FIREMODE[m] for m in modes if m in FIREMODE]
        if is_volley and "MCV.FIREMODE_VOLLEY" not in firemodes:
            firemodes.append("MCV.FIREMODE_VOLLEY")
        if not firemodes:
            firemodes = ["MCV.FIREMODE_SEMI"]
    if reuse("Firemodes"):
        firemodes = existing["Firemodes"]
    if name in VOLLEY_ALL:
        firemodes = ["MCV.FIREMODE_VOLLEY"]
        is_volley = True

    # ---- fire rate -------------------------------------------------------------------------
    firerate = num(S.get("FireRate"), 0)
    cycle = "ACT_VM_RELOAD_INSERT_PULL" in acts and (is_bolt or is_pump or ("Auto" not in modes and wtype in ("Shotgun", "BoltActionRifle")))
    if reuse("FireRate"):
        firerate = reuse("FireRate")
    elif cycle:
        # manually operated action with its own cycle animation: the cycle (NeedCycle, released
        # by the hammerpos event) is the delay between shots, not the fire rate; the script's
        # 40-100 RPM would add a dead wait on top of the bolt/pump animation
        firerate = 600
    elif firerate < 20:
        firerate = 120 if (is_bolt or is_pump) else (250 if is_revolver else 300)
        warnings.append("FireRate %s in script; using %d" % (S.get("FireRate"), firerate))
    if S.get("ManualAction") == "1":
        # the shot animation carries the manual cycling: one shot per animation
        secs = shoot_anim_seconds(vm)
        if secs:
            firerate = min(firerate, round(60 / secs, 1))

    # ---- flags from the QC -------------------------------------------------------------------
    # The script is authoritative for what the weapon *has*; the model often carries animations for
    # variants (bayonet, rifle grenade) that exist as separate weapon scripts in the game.
    has_bayonet = S.get("HasBayonet") == "1"
    if "ACT_VM_ATTACH_SILENCER" in acts and not has_bayonet:
        warnings.append("model has bayonet animations but the script does not enable HasBayonet")
    model_has_gl = any(a in acts for a in ("ACT_VM_ISHOOT_M203", "ACT_VM_DRAW_M203"))
    variant_script = os.path.isfile(os.path.join(args.scripts_dir, "weapon_%s_riflegrenade.txt" % name))
    # The addon merges the game's separate *_riflegrenade weapons into the base rifle (toggle with USE+WALK).
    has_gl = S.get("secondary_ammo") in ("40mm_grenade", "riflegrenade") or name.endswith("_riflegrenade") or wtype in ("RifleGrenade",) \
        or any(k in name for k in ("gp25", "m203", "xm148")) or (model_has_gl and variant_script)
    if merged_variants:
        if model_has_gl:
            has_gl = True
        else:
            warnings.append("%s folded in by override, but the viewmodel has no grenade animations yet (hand-merge pending); HasRifleGrenade left off" % ", ".join(merged_variants))
    if model_has_gl and not has_gl:
        warnings.append("model has grenade launcher animations but no *_riflegrenade script variant was found")
    gl_is_ubgl = "ACT_VM_IIN_M203" in acts
    bg = [b.lower() for b in qc["bodygroups"]]
    def bg_index(*names):
        for i, b in enumerate(bg):
            if b in names:
                return i
        return None
    bayonet_bg = bg_index("bayonet", "bayonets")
    gl_bg = bg_index("mount", "grenadelauncher", "launcher", "gl")
    gren_bg = bg_index("grenade", "riflegrenade")

    lastshot = "ACT_VM_SHOOTLAST" in acts
    # a clip reload that blends on ammo_fraction (Kar98, Vz.24, Springfield, M40...) wins over the
    # single-round animations the same models also carry: those rifles reload with the clip
    shotgun_reload = "ACT_SHOTGUN_RELOAD_START" in acts and not is_revolver and not qc["ammo_blend_reload"]
    alt_reload = "ACT_VM_RELOAD_INSERT" in acts
    # HasEmptyReload is the mag-style empty reload only; shell loaders use ShotgunReloadEmptyStartAnimation
    empty_reload = "ACT_VM_RELOADEMPTY" in acts
    # clip-loaded rifles (SKS, Kar98, M40...) blend their reload on ammo_fraction so the clip empties visibly
    mag_in_clip = qc["ammo_blend_reload"]
    has_akimbo = os.path.isdir(os.path.join(HERE, "MCV_SMD_OG", "weapons", "v_dual_" + vm[2:])) or os.path.isfile(os.path.join(args.scripts_dir, "weapon_dual_%s.txt" % name))

    # Hand-tuned gameplay decisions in an existing lua file win over the heuristics above
    # (e.g. "LastShotAnimation = false -- it jerks", sniper variants without bayonets).
    def rb(key, val):
        r = reuse(key)
        return val if r is None else (r == "true")
    def rv(key, val):
        r = reuse(key)
        return val if r is None else r.strip('"')
    lastshot = rb("LastShotAnimation", lastshot)
    mag_in_clip = rb("MagInClip", mag_in_clip)
    cycle = rb("PlayCycleAnimation", cycle)
    shotgun_reload = rb("ShotgunReload", shotgun_reload)
    alt_reload = rb("ShotgunAltReload", alt_reload)
    empty_reload = rb("HasEmptyReload", empty_reload)
    has_bayonet = rb("HasBayonet", has_bayonet)
    has_gl = rb("HasRifleGrenade", has_gl)
    # HasAkimbo is not taken from the old file: if the game has a weapon_dual_* script for it,
    # the dual mode belongs to this weapon.
    clipsize = int(num(rv("Primary.ClipSize", clipsize), clipsize))
    chamber = int(num(rv("Primary.Chamber", chamber), chamber))
    maxammo = int(num(rv("Primary.DefaultClip", maxammo), maxammo))
    ammo_type = rv("Primary.Ammo", ammo_type)
    akimbo_vm = "v_dual_" + vm[2:] if has_akimbo else None

    brass_game = int(num(S.get("EjectBrassType"), -1))
    brass = BRASS.get(brass_game, 0)
    if brass_game >= 0 and brass_game not in BRASS:
        warnings.append("unknown EjectBrassType %d" % brass_game)

    silencer = "silencer" in name or "_s" == name[-2:] or "suppress" in name
    muzzle = "muzzleflash_suppressed" if silencer else MUZZLE.get(wtype, MUZZLE_DEFAULT)

    # a scope bodygroup entry alone is not a scope (the M14 Early carries one for the M21 variant)
    has_scope = bool(S.get("ScopeLensFov")) or (name.endswith("_s") or name.endswith("s") and name[:-1] + ".txt" in os.listdir(args.scripts_dir).__str__()) and wtype in ("SniperRifle", "BoltActionRifle", "BattleRifle", "Carbine")
    if reuse("HasScope"):
        has_scope = reuse("HasScope") == "true"
    scope_idx, scope_mat = (None, None)
    if has_scope:
        scope_idx, scope_mat = scope_info(vm, "singlepoint" if reuse("OEGScope") else None)
        if scope_idx is None:
            warnings.append("script suggests a scope but the compiled model has no lens material; HasScope off")
            has_scope = False
        # a hand-made reticle in the optics folder wins over the game's texture
        r = reuse("ScopeMaterial")
        rm = re.search(r'Material\("([^"]+)"\)', r or "")
        if rm and os.path.isfile(os.path.join(ADDON, "materials", rm.group(1).replace("/", os.sep) + ".vmt")):
            scope_mat = rm.group(1)
        if scope_mat is None:
            warnings.append("no reticle material found for the scope")
    # the launcher script this rifle absorbed (m203 -> m16a1_m203, xm148 -> m16_xm148, gp25 -> akm_gp25)
    L = {}
    lp = getattr(args, "launcher_of", {}).get(name)
    if lp:
        lkv = parse_kv(open(lp, encoding="utf-8", errors="replace").read())
        L = flat(lkv.get("WeaponData", lkv))

    origin = S.get("origin", "")
    country = COUNTRY.get(origin)
    if country is None and args.strings:
        country = args.strings.get(origin.lstrip("#").lower())
    if country is None:
        warnings.append("unknown origin %s" % origin)
        country = origin.lstrip("#").replace("_", " ").title()
    # the game's own display name (resource/vietnam_english.txt via rip_game.py --steps strings)
    game_name = args.strings.get(S.get("printname", "").lstrip("#").lower()) if args.strings else None

    def line(k, v):
        return "SWEP.%s = %s" % (k, v)

    out = []
    A = out.append
    A('SWEP.Base = "mcv_base"')
    A("")
    A("SWEP.Spawnable = true")
    A("")
    A("AddCSLuaFile()")
    A("")
    A("// Generated by work/port_weapon.py from cscripts/weapon_%s.txt" % name)
    A("")
    A("// Names and basic information")
    A(line("PrintName", reuse("PrintName") or fmt(game_name or pretty_name(S.get("printname", name)))))
    A(line("Category", '"Military Conflict: Vietnam"'))
    A(line("Country", fmt(country)))
    A(line("SubCategory", reuse("SubCategory") or fmt(subcat)))
    A(line("Caliber", reuse("Caliber") or fmt(caliber)))
    A("")
    A(line("Slot", reuse("Slot") or slot))
    if holdtype != "ar2":
        hip, aim, sprint = HOLDTYPES.get(holdtype, HOLDTYPES["ar2"])
        A(line("HoldType", fmt(hip)))
        A(line("AimHoldType", fmt(aim)))
        A(line("SprintHoldType", fmt(sprint)))
    A("")
    A(line("ViewModel", fmt("models/weapons/mcv/%s.mdl" % vm)))
    if akimbo_vm:
        A(line("ViewModelAkimbo", fmt("models/weapons/mcv/%s.mdl" % akimbo_vm)))
        # the dual models carry pose-parameter recoil layers: each hand's shot is scrubbed on
        # recoil_r / recoil_l instead of a sequence, so both hands recoil independently
        for k, v in akimbo_timing(vm).items():
            A(line(k, v))
    A(line("WorldModel", fmt("models/weapons/mcv/%s.mdl" % wm)))
    A("")
    A(line("BodyGroups", fmt(bodygroups_string(qc["bodygroups"], S)) if any(k.startswith("BodygroupData.") for k in S) else '""'))
    if bayonet_bg is not None:
        A(line("BayonetBodygroup", bayonet_bg))
    if gl_bg is not None:
        A(line("GrenadeLauncherBodygroup", gl_bg))
    if gren_bg is not None:
        A(line("GrenadeBodygroup", gren_bg))
    if existing.get("BulletBodygroupsBlock"):
        A("")
        A(existing["BulletBodygroupsBlock"])
    elif qc["bullet_bodygroups"]:
        # visible belt / clip rounds: bodygroup i shows round i, hidden (blank) once it is fired
        A("")
        A("SWEP.BulletBodygroups = {")
        for n, idx in enumerate(qc["bullet_bodygroups"], 1):
            A("    [%d] = {%d, 1}," % (n, idx))
        A("}")
    timing = anim_timing(qc)
    if any(k.startswith("Mag") for k in timing):
        A("")
        A("// When the reload animation swaps the magazine / belt (from its events): the rounds shown")
        A("// on the model switch from the old count to the new one here, 0 in between when it is out")
        for k in ("MagInTime", "MagInTimeEmpty", "MagOutTime", "MagOutTimeEmpty"):
            if k in timing:
                A(line(k, timing[k]))
    if qc["belt_bodygroups"]:
        A(line("BeltBodygroups", "{%s}" % ", ".join(str(i) for i in qc["belt_bodygroups"])) + " // the belt in the feed tray, hidden once no rounds are shown")
    A("")
    A("// Stats")
    A("")
    A(line("DamageGeneric", fmt(num(S.get("DamageGeneric"), 30))))
    for k in ("DamageHeadMultiplier", "DamageChestMultiplier", "DamageStomachMultiplier", "DamageLegMultiplier", "DamageArmMultiplier"):
        A(line(k, fmt(num(S.get(k), 1))))
    A("")
    A(line("Num", int(num(S.get("bullets_per_shot"), 1))))
    A("")
    A(line("RangeModifier", fmt(num(S.get("rangemodifier"), 0.95))))
    A("")
    A("SWEP.Firemodes = {")
    A("    " + ",\n    ".join(firemodes))
    A("}")
    if is_volley:
        A(line("VolleyCount", VOLLEY_ALL.get(name, 2)))
    if "MCV.FIREMODE_FAST" in firemodes:
        A(line("FireRate_Fast", int(firerate)))
        A(line("FireRate_Slow", int(num(S.get("SecondaryFireRate"), num(firerate, 300) * 0.6))))
    A("")
    A(line("LastShotAnimation", fmt(lastshot)))
    if mag_in_clip:
        A(line("MagInClip", "true"))
        if not shotgun_reload and {"ACT_VM_RELOADEMPTY", "ACT_VM_RELOAD_INSERT", "ACT_SHOTGUN_RELOAD_START", "ACT_SHOTGUN_RELOAD_FINISH"} <= acts:
            # clip when empty, one round at a time when partly loaded (server convar mcv_hybrid_reload)
            A(line("HybridReloadCapable", "true"))
    if cycle:
        A(line("PlayCycleAnimation", "true"))
        if reuse("CycleSpeed"): A(line("CycleSpeed", reuse("CycleSpeed")))
        if reuse("CyclePostDelay"): A(line("CyclePostDelay", reuse("CyclePostDelay")))
    if shotgun_reload:
        A(line("ShotgunReload", "true"))
        if alt_reload:
            A(line("ShotgunAltReload", "true"))
        if "ACT_VM_RELOAD_INSERT_EMPTY" in acts:
            A(line("ShotgunReloadEmptyStartAnimation", "true"))
    if not empty_reload:
        A(line("HasEmptyReload", "false"))
    if is_revolver:
        A(line("RevolverFiremodePose", fmt("revolver_firemode_pose" in qc["poseparams"])))
        if shotgun_reload or "ACT_SHOTGUN_RELOAD_START" in acts:
            A(line("ShotgunReload", "true"))
    if qc["hammer_events"] and (cycle or shotgun_reload):
        # The base releases the action on "hammerpos 1" (or on 0 with the inverted flag). Bolt
        # rifles put 1 on the shot and 0 on the bolt pull, pump shotguns 0 on the shot and 1 on
        # the pump; whichever the cycle animation carries is the one that must count, otherwise
        # the shot itself releases the action and the gun fires semi/full-auto.
        A(line("AnimationHandlesHammer", "true"))
        A(line("InvertAnimationHammer", "false" if qc.get("cycle_hammerpos") == 1 else "true"))
    A(line("NoEjectOnShoot", fmt(eject_rule(qc, is_revolver, is_bolt, is_pump, wtype == "RocketLauncher" or name in SHOOT_ENTITY))))
    if has_akimbo and name in SA_DUAL_RELOAD:
        A(line("AkimboDualSingleActionReload", "true"))
    if has_gl and not gl_is_ubgl:
        A(line("RifleGrenadeEntity", fmt("mcv_proj_riflegrenade_vc" if origin in VC_ORIGINS else "mcv_proj_riflegrenade")))
        A(line("RifleGrenadeForce", 2000))
    if has_gl and gl_is_ubgl:
        A(line("RifleGrenadeIsUBGL", "true"))
        A(line("RifleGrenadeEntity", fmt("mcv_proj_40mm")))
        # the launcher script's gl_velocity is m/s; the hand-tuned M203 sits close to the 70 m/s value
        glv = num(L.get("gl_velocity"), 0)
        rf = reuse("RifleGrenadeForce")
        if rf in (None, "7000") and glv:
            rf = int(glv * 39.37)
        A(line("RifleGrenadeForce", rf or 2750))
    if name in SHOOT_ENTITY:
        A(line("ShootEntity", fmt(SHOOT_ENTITY[name])))
        if name in GL_VELOCITY_GUNS:
            A(line("ShootEntityForce", int(num(S.get("gl_velocity"), 100) * 39.37)))
        else:
            A(line("ShootEntityForce", int(num(S.get("muzzle_velocity"), 100)) * 50))
        A(line("AmmoPerShot", 1))
    A("")
    A("// View slide from recoil")
    A(line("ViewSlideRecoilUp", fmt(num(S.get("ViewSlideRecoil.Up"), 1.35))))
    A(line("ViewSlideRecoilRight", fmt(num(S.get("ViewSlideRecoil.Right"), 0.48))))
    A("")
    A(line("ViewSlideRecoilIronsightUp", fmt(num(S.get("ViewSlideRecoilIronsight.Up"), 0.65))))
    A(line("ViewSlideRecoilIronsightRight", fmt(num(S.get("ViewSlideRecoilIronsight.Right"), 0.25))))
    A("")
    A(line("RecoilPushbackValue", fmt(num(S.get("recoilpushbackvalue"), 1.5))))
    A("")
    A("// Camera shake from recoil")
    A(line("ShakeScale", fmt(num(S.get("ShakeScale"), 1))))
    A(line("ShakeFreq", fmt(num(S.get("ShakeFreq"), 45))))
    A(line("ShakeDuration", fmt(num(S.get("ShakeDuration"), 0.4))))
    A("")
    A(line("Ironsight", fmt(S.get("IronSight", "1") == "1")))
    A(line("IronsightSpeedScale", reuse("IronsightSpeedScale") or fmt(num(S.get("IronsightSpeedScale"), 1))))
    A(line("IronsightFov", "90 - %g" % abs(num(S.get("IronsightedFovOffset"), -15))))
    A(line("IronsightWalkBobbingStrength", fmt(num(S.get("ironsightwalkbobbingstrength"), -0.25))))
    if "MovementPoseWalk" in timing:
        # the model's run layer range on player_movement: this weapon class's walk and sprint speeds
        A(line("MovementPoseWalk", timing["MovementPoseWalk"]))
        A(line("MovementPoseSprint", timing["MovementPoseSprint"]))
        A(line("MovementPoseSighted", timing["MovementPoseSighted"]))
    A("")
    A(line("HasScope", fmt(has_scope)))
    if has_scope and scope_mat:
        A(line("ScopeMaterial", 'Material("%s")' % scope_mat))
    else:
        A(line("ScopeMaterial", "NULL"))
    so_fov = sight_offsets(S) or {}
    A(line("ScopeFOV", so_fov.get("ScopeFOV", 8)))
    A(line("ScopeFOV2", so_fov.get("ScopeFOV2", 4)))
    if has_scope and scope_idx is not None:
        A(line("RTScopeMaterialIndex", scope_idx))
    if reuse("AdjustableScopes"): A(line("AdjustableScopes", reuse("AdjustableScopes")))
    if reuse("OEGScope"): A(line("OEGScope", reuse("OEGScope")))
    A("")
    so = sight_offsets(S) or {}
    if not so:
        warnings.append("no viewmodel offsets in the script")
    A(line("IronsightPos", so.get("IronsightPos", "Vector(0, -4, 0) -- TODO tune")))
    A(line("IronsightAng", so.get("IronsightAng", "Angle(0, 0, 0)")))
    if akimbo_vm:
        for k, v in akimbo_sight_offsets(name, args.scripts_dir).items():
            A(line(k, v))
    A("")
    A(line("CustomPos", so.get("CustomPos", "Vector(0, -2, 0)")))
    A(line("CustomAng", so.get("CustomAng", "Angle(0, 0, 0)")))
    A("")
    A(line("Spread", fmt(num(S.get("BulletSpreadDegrees"), 5))))
    A(line("SpreadIronsighted", fmt(num(S.get("BulletSpreadDegreesIronsighted"), 1))))
    A("")
    A(line("FireRate", fmt(firerate) if not isinstance(firerate, str) else firerate) + " // in rounds per minute")
    A("")
    A(line("CrosshairMinDistance", fmt(num(S.get("CrosshairMinDistance"), 8))))
    A(line("CrosshairDeltaDistance", fmt(num(S.get("CrosshairDeltaDistance"), 4))))
    A("")
    A(line("WeaponWeight", fmt(num(S.get("weight"), 3))))
    A("")
    A(line("Primary.Ammo", fmt(ammo_type)))
    A(line("Primary.ClipSize", clipsize))
    A(line("Primary.Chamber", chamber))
    A(line("Primary.DefaultClip", maxammo))
    A(line("Primary.Automatic", "true"))
    A("")
    A(line("NearwallDistance", fmt(num(S.get("NearwallDistance"), 40))))
    A("")
    A("// Bullet spread multiplier according to current stance")
    for k in ("CrouchSpreadMultiplier", "ProneSpreadMultiplier", "StandMoveSpreadMultiplier", "SneakMoveSpreadMultiplier", "CrouchMoveSpreadMultiplier", "JumpSpreadMultiplier"):
        A(line(k, fmt(num(S.get(k), 1))))
    A("")
    A(line("HasBayonet", fmt(bool(has_bayonet))))
    A(line("HasRifleGrenade", fmt(bool(has_gl))))
    if has_akimbo:
        A(line("HasAkimbo", "true"))
    A("")
    A(line("BashDamage", 50))
    A(line("BayonetDamage", 100))
    A("")
    A(line("HasBipod", fmt(S.get("HasBipod") == "1")))
    if S.get("HasBipod") == "1" and "BulletSpreadDegreesBipod" in S:
        A(line("SpreadBipod", fmt(num(S.get("BulletSpreadDegreesBipod"), 1))))
    A("")
    A("// Penetration")
    for k in ("MetalPenetrationDepth", "GlassPenetrationDepth", "ConcretePenetrationDepth", "WoodPenetrationDepth", "OtherPenetrationDepth"):
        A(line(k, fmt(num(S.get(k), 10))))
    A("")
    for k in ("MetalDamageModifier", "GlassDamageModifier", "ConcreteDamageModifier", "WoodDamageModifier", "OtherDamageModifier"):
        A(line(k, fmt(num(S.get(k), 1.25))))
    A("")
    A("// Sound")
    def snd(key, default=""):
        v = S.get("SoundData." + key, "")
        return fmt("MCV_" + v) if v else fmt(default)
    A(line("SoundSingleShot", snd("single_shot")))
    A(line("SoundDoubleShot", snd("double_shot")))
    A(line("SoundReload", snd("reload")))
    A(line("SoundSpecial1", snd("special1")))
    A(line("SoundSpecial2", snd("special2")))
    if has_gl:
        gs = L.get("SoundData.double_shot") or L.get("SoundData.single_shot")
        rs = reuse("SoundGrenadeShot")
        if rs and ".RifleGrenade" not in rs:
            A(line("SoundGrenadeShot", rs))
        elif gs:
            A(line("SoundGrenadeShot", fmt("MCV_" + gs)))
        else:
            A(line("SoundGrenadeShot", fmt("MCV_Weapon_%s.RifleGrenade" % name.upper()) + " -- TODO check soundscript name"))
    A(line("SoundNearlyEmpty", snd("nearlyempty", "MCV_Weapon_Generic.NearlyEmptyClick")))
    A(line("SoundEmpty", snd("empty", "MCV_Weapon_Generic.ClipEmpty_01")))
    A("")
    A("// Particles (the game's own systems; particles/*.pcf and their materials ship with the addon)")
    def part(key, default=""):
        v = S.get(key, default)
        return fmt("" if v.lower() == "null" else v)
    A(line("MuzzleParticle", part("MuzzleParticle", muzzle)))
    A(line("MuzzleParticleSmoke", part("MuzzleParticle_Smoke")))
    A(line("MuzzleParticleIronsighted", part("MuzzleParticle_Ironsighted", S.get("MuzzleParticle", muzzle))))
    A(line("MuzzleParticleIronsightedSmoke", part("MuzzleParticle_IronsightedSmoke")))
    A("")
    A(line("MuzzleParticle3rdPerson", part("MuzzleParticle3rdPerson", S.get("MuzzleParticle", muzzle))))
    A("")
    A(line("EjectBrassType", brass))
    A(line("EjectBrassTrail", part("EjectBrassTrail", "vietnam_weaponeffect_shelleject_trail")))
    A(line("EjectBrassParticle", part("EjectBrassParticle", "vietnam_weaponeffect_shelleject_side")))
    A("")
    A(line("TracerParticle", part("TracerParticle", "vietnam_tracer_rifle_primary")))
    A("")
    A(line("TracerRandomness", int(num(S.get("TracerRandomness"), 6))))
    A(line("TracerFrequency", int(num(S.get("TracerFrequency"), 1))))
    if has_gl:
        A("")
        A(line("Secondary.Automatic", "true"))
        A(line("Secondary.ClipSize", 1))
        A(line("Secondary.Ammo", '"smg1_grenade"'))
        A(line("Secondary.DefaultClip", 1))
    if reuse("IconOverride"):
        A("")
        A(line("IconOverride", reuse("IconOverride")))
    A("")
    return "\n".join(out), warnings


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("source", help="weapon_X.txt or the cscripts dir with --all")
    ap.add_argument("--all", action="store_true")
    ap.add_argument("--out", default=os.path.join(HERE, "lua_port"))
    ap.add_argument("--addon", default=ADDON, help="addon root (for existing lua files)")
    ap.add_argument("--no-reuse", dest="reuse", action="store_false", help="do not copy hand-tuned values from existing lua files")
    ap.add_argument("--only-new", action="store_true", help="skip weapons that already have a lua file")
    ap.add_argument("--all-types", dest="guns_only", action="store_false",
                    help="also convert grenades, mines, flamethrowers, melee and equipment (the base cannot drive them)")
    ap.add_argument("--no-merge", dest="merge", action="store_false",
                    help="write scripts that share a viewmodel with another script as their own mcv_<script>.lua")
    args = ap.parse_args()
    args.scripts_dir = args.source if args.all else os.path.dirname(args.source)
    args.strings = None
    sp = os.path.join(HERE, "strings.json")
    if os.path.isfile(sp):
        import json
        args.strings = {k.lower(): v for k, v in json.load(open(sp, encoding="utf-8")).items()}
    # script name -> existing lua name. Matched through the viewmodel path (the lua files were not
    # named after the scripts), with a few manual pairs for models that were renamed as well.
    args.name_map = resolve_lua_names(args.scripts_dir, args.addon)

    if args.all:
        files = sorted(glob.glob(os.path.join(args.source, "weapon_*.txt")))
    else:
        files = [args.source]
    os.makedirs(args.out, exist_ok=True)
    args.overrides = load_overrides()
    # the game's rifle grenade weapons reuse the base rifle's viewmodel; fold them into the base
    # (same as an explicit "MergeInto" override). Done up front so the base sees its variants.
    for f in glob.glob(os.path.join(args.scripts_dir, "weapon_*_riflegrenade.txt")):
        name = os.path.basename(f)[len("weapon_"):-4]
        if args.overrides.get(name, {}).get("MergeInto"):
            continue
        base = name[:-len("_riflegrenade")]
        bp = os.path.join(args.scripts_dir, "weapon_%s.txt" % base)
        if os.path.isfile(bp):
            vm_v = re.search(r'"viewmodel"\s+"([^"]+)"', open(f, encoding="utf-8", errors="replace").read())
            vm_b = re.search(r'"viewmodel"\s+"([^"]+)"', open(bp, encoding="utf-8", errors="replace").read())
            if vm_v and vm_b and vm_v.group(1).lower() == vm_b.group(1).lower():
                args.overrides.setdefault(name, {})["MergeInto"] = base
    # under-barrel launcher scripts fold into their rifle (see launcher_folds)
    args.launcher_of = {}
    for gl, rifle in launcher_folds(args.scripts_dir).items():
        args.overrides.setdefault(gl, {})["MergeInto"] = rifle
        args.launcher_of[rifle] = os.path.join(args.scripts_dir, "weapon_%s.txt" % gl)
    produced = {}
    for f in files:
        name = os.path.basename(f)[len("weapon_"):-4]
        lua_name = args.name_map.get(name, name)
        target = args.overrides.get(name, {}).get("MergeInto")
        if target:
            what = "launcher of" if name in args.launcher_of.values() or target in args.launcher_of else "rifle grenade of"
            print("%-28s folded into mcv_%s (%s %s)" % (name, args.name_map.get(target, target), what, target))
            continue
        if name.startswith("dual_"):
            # Dual wield is a mode of the single-wield weapon in this addon (HasAkimbo +
            # ViewModelAkimbo, toggled with USE+WALK), never a weapon of its own.
            print("%-28s folded into the single-wield weapon (HasAkimbo)" % name)
            continue
        if lua_name in produced:
            # e.g. weapon_sks_riflegrenade shares v_sks with weapon_sks: the addon merges those
            # variants into one weapon (HasRifleGrenade), so only the first script is converted.
            # Silenced / optic variants (car15s, m607_oeg...) share a model too; use --no-merge
            # to get them as their own files.
            if args.merge:
                print("%-28s merged into mcv_%s (same viewmodel as weapon_%s)" % (name, lua_name, produced[lua_name]))
                continue
            lua_name = name
        produced[lua_name] = name
        if args.only_new and os.path.isfile(os.path.join(args.addon, "lua", "weapons", "mcv_%s.lua" % lua_name)):
            continue
        try:
            text, warnings = generate(f, args)
        except Exception as e:
            print("%-28s ERROR %s" % (name, e))
            continue
        if text is None:
            print("%-28s skipped: %s" % (name, ", ".join(warnings)))
            continue
        outp = os.path.join(args.out, "mcv_%s.lua" % lua_name)
        with open(outp, "w", encoding="utf-8", newline="\n") as fh:
            fh.write(text)
        print("%-28s -> %s%s" % (name, os.path.relpath(outp, HERE), ("  ! " + "; ".join(warnings)) if warnings else ""))


if __name__ == "__main__":
    main()

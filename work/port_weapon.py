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
         12: 16, 13: 18, 14: 3, 15: 2, 16: 13, 17: 14}

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
                "m79": "mcv_proj_40mm", "m79_short": "mcv_proj_40mm", "china_lake": "mcv_proj_40mm", "chinalake": "mcv_proj_40mm"}

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
         "ammo_blend_names": []}
    if not path:
        return f
    src = open(path, encoding="utf-8", errors="replace").read()
    f["acts"] = set(re.findall(r'activity\s+"([^"]+)"', src))
    f["bodygroups"] = re.findall(r'^\$bodygroup\s+"([^"]+)"', src, re.M)
    f["poseparams"] = re.findall(r'^\$poseparameter\s+"([^"]+)"', src, re.M)
    f["hammer_events"] = "hammerpos" in src
    for m in re.finditer(r'^\$sequence\s+"([^"]+)"\s*\{(.*?)^\}', src, re.S | re.M):
        body = m.group(2)
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

REUSE_KEYS = ("PrintName", "IronsightPos", "IronsightAng", "CustomPos", "FireRate", "ScopeMaterial", "ScopeFOV",
              "ScopeFOV2", "HasScope", "AdjustableScopes", "OEGScope", "Slot", "SubCategory", "Caliber",
              "CycleSpeed", "CyclePostDelay", "TriggerDelayTime", "IconOverride", "ViewModelFOV",
              "SightedViewModelFOV", "MuzzleParticle", "MuzzleParticle3rdPerson", "MuzzleParticleIronsighted",
              "RTScopeMaterialIndex", "IronsightSpeedScale", "InvertAnimationHammer", "AnimationHandlesHammer")

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

def generate(script_path, args):
    name = os.path.basename(script_path)[len("weapon_"):-4]
    kv = parse_kv(open(script_path, encoding="utf-8", errors="replace").read())
    wd = kv.get("WeaponData") or next(iter(kv.values()), {})
    S = flat(wd)
    warnings = []

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

    wtype = S.get("WeaponType", "Rifle")
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
    is_bolt = "ACT_VM_RELOAD_INSERT_PULL" in acts and wtype in ("BoltActionRifle", "SniperRifle", "Carbine", "BattleRifle", "Rifle") and "Auto" not in modes and "ACT_SHOTGUN_PUMP" not in acts
    is_pump = "ACT_VM_RELOAD_INSERT_PULL" in acts and wtype in ("Shotgun", "GrenadeLauncher")
    is_volley = "ACT_VM_RECOIL1" in acts
    if is_revolver and "ACT_VM_HAULBACK" in acts:
        firemodes = ["MCV.FIREMODE_SA", "MCV.FIREMODE_DA", "MCV.FIREMODE_FAN"] if "ACT_VM_PRIMARYATTACK_1" in acts else ["MCV.FIREMODE_SA", "MCV.FIREMODE_DA"]
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

    # ---- fire rate -------------------------------------------------------------------------
    firerate = num(S.get("FireRate"), 0)
    if reuse("FireRate"):
        firerate = reuse("FireRate")
    elif firerate < 100:  # the game stores a cadence cap for semi-auto, not RPM
        firerate = 120 if (is_bolt or is_pump) else (250 if is_revolver else 300)
        warnings.append("FireRate %s in script is not RPM; using %d" % (S.get("FireRate"), firerate))

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
    shotgun_reload = "ACT_SHOTGUN_RELOAD_START" in acts and not is_revolver
    alt_reload = "ACT_VM_RELOAD_INSERT" in acts
    # HasEmptyReload is the mag-style empty reload only; shell loaders use ShotgunReloadEmptyStartAnimation
    empty_reload = "ACT_VM_RELOADEMPTY" in acts
    # clip-loaded rifles (SKS, Kar98, M40...) blend their reload on ammo_fraction so the clip empties visibly
    mag_in_clip = qc["ammo_blend_reload"]
    cycle = "ACT_VM_RELOAD_INSERT_PULL" in acts and (is_bolt or is_pump or ("Auto" not in modes and wtype in ("Shotgun", "BoltActionRifle")))

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
    has_akimbo = rb("HasAkimbo", has_akimbo)
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

    has_scope = "BodygroupData.scope" in S or "ScopeLensFov" in S or name.endswith("_s") and wtype in ("SniperRifle", "BoltActionRifle", "BattleRifle", "Carbine")
    if reuse("HasScope"):
        has_scope = reuse("HasScope") == "true"

    origin = S.get("origin", "")
    country = COUNTRY.get(origin)
    if country is None:
        warnings.append("unknown origin %s" % origin)
        country = origin.lstrip("#").replace("_", " ").title()

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
    A(line("PrintName", reuse("PrintName") or fmt(pretty_name(S.get("printname", name)))))
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
    A(line("WorldModel", fmt("models/weapons/mcv/%s.mdl" % wm)))
    A("")
    A(line("BodyGroups", '""'))
    if bayonet_bg is not None:
        A(line("BayonetBodygroup", bayonet_bg))
    if gl_bg is not None:
        A(line("GrenadeLauncherBodygroup", gl_bg))
    if gren_bg is not None:
        A(line("GrenadeBodygroup", gren_bg))
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
        A(line("VolleyCount", 2))
    if "MCV.FIREMODE_FAST" in firemodes:
        A(line("FireRate_Fast", int(firerate)))
        A(line("FireRate_Slow", int(num(S.get("SecondaryFireRate"), num(firerate, 300) * 0.6))))
    A("")
    A(line("LastShotAnimation", fmt(lastshot)))
    if mag_in_clip:
        A(line("MagInClip", "true"))
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
        A(line("AnimationHandlesHammer", reuse("AnimationHandlesHammer") or "true"))
        if reuse("InvertAnimationHammer"):
            A(line("InvertAnimationHammer", reuse("InvertAnimationHammer")))
        else:
            A("// SWEP.InvertAnimationHammer = true -- TODO check: set if the hammer pose reads backwards in game")
    if has_gl and not gl_is_ubgl:
        A(line("RifleGrenadeEntity", fmt("mcv_proj_riflegrenade_vc" if origin in VC_ORIGINS else "mcv_proj_riflegrenade")))
        A(line("RifleGrenadeForce", 2000))
    if has_gl and gl_is_ubgl:
        A(line("RifleGrenadeIsUBGL", "true"))
        A(line("RifleGrenadeEntity", fmt("mcv_proj_40mm")))
        A(line("RifleGrenadeForce", 7000))
    if name in SHOOT_ENTITY:
        A(line("ShootEntity", fmt(SHOOT_ENTITY[name])))
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
    A("")
    A(line("HasScope", fmt(has_scope)))
    A(line("ScopeMaterial", reuse("ScopeMaterial") or ("NULL" if not has_scope else 'Material("models/weapons/mcv/optics/crosshair_%s") -- TODO check material exists' % name)))
    A(line("ScopeFOV", reuse("ScopeFOV") or 8))
    A(line("ScopeFOV2", reuse("ScopeFOV2") or 4))
    if reuse("AdjustableScopes"): A(line("AdjustableScopes", reuse("AdjustableScopes")))
    if reuse("OEGScope"): A(line("OEGScope", reuse("OEGScope")))
    if reuse("RTScopeMaterialIndex"): A(line("RTScopeMaterialIndex", reuse("RTScopeMaterialIndex")))
    A("")
    ip = reuse("IronsightPos")
    ia = reuse("IronsightAng")
    cp = reuse("CustomPos")
    A(line("IronsightPos", ip or "Vector(0.06, -4, 0) -- TODO tune (game: forward %s right %s up %s)" % (S.get("ironsightforward"), S.get("ironsightright"), S.get("ironsightup"))))
    A(line("IronsightAng", ia or "Angle(0.25, 0.1, 0) -- TODO tune"))
    A("")
    A(line("CustomPos", cp or "Vector(0, -2, 0)"))
    A(line("CustomAng", "Angle(0, 0, 0)"))
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
        A(line("SoundGrenadeShot", fmt("MCV_Weapon_%s.RifleGrenade" % name.upper()) + " -- TODO check soundscript name"))
    A(line("SoundNearlyEmpty", snd("nearlyempty", "MCV_Weapon_Generic.NearlyEmptyClick")))
    A(line("SoundEmpty", snd("empty", "MCV_Weapon_Generic.ClipEmpty_01")))
    A("")
    A("// Particles")
    A(line("MuzzleParticle", reuse("MuzzleParticle") or fmt(muzzle)))
    A(line("MuzzleParticleSmoke", '""'))
    A(line("MuzzleParticleIronsighted", reuse("MuzzleParticleIronsighted") or fmt(muzzle)))
    A(line("MuzzleParticleIronsightedSmoke", '""'))
    A("")
    A(line("MuzzleParticle3rdPerson", reuse("MuzzleParticle3rdPerson") or fmt(muzzle)))
    A("")
    A(line("EjectBrassType", brass))
    A(line("EjectBrassTrail", '"shellsmoke"'))
    A(line("EjectBrassParticle", '"port_smoke"'))
    A("")
    A(line("TracerParticle", '"tracer"'))
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
    ap.add_argument("--no-merge", dest="merge", action="store_false",
                    help="write scripts that share a viewmodel with another script as their own mcv_<script>.lua")
    args = ap.parse_args()
    args.scripts_dir = args.source if args.all else os.path.dirname(args.source)
    # script name -> existing lua name. Matched through the viewmodel path (the lua files were not
    # named after the scripts), with a few manual pairs for models that were renamed as well.
    args.name_map = {"baby_browning": "babybrowning", "china_lake": "chinalake", "dual_hp": "dual_highpower",
                     "kar98k_s": "kar98_s", "m1903s": "springfield_s", "m1918_bar": "bar_l", "m1942": "m1942_machete",
                     "stg44s": "stg44", "svt40s": "svt40_s", "mas49s": "mas49_s", "m607s": "m607", "car15s": "car15",
                     "m21s": "m21", "m1gs": "m1g_s"}
    vm_to_lua = {}
    for lp in glob.glob(os.path.join(args.addon, "lua", "weapons", "mcv_*.lua")):
        m = re.search(r'SWEP\.ViewModel\s*=\s*"models/weapons/mcv/([^"]+)\.mdl"', open(lp, encoding="utf-8", errors="replace").read())
        if m:
            vm_to_lua.setdefault(m.group(1).lower(), os.path.basename(lp)[4:-4])
    for sp in glob.glob(os.path.join(args.scripts_dir, "weapon_*.txt")):
        sname = os.path.basename(sp)[len("weapon_"):-4]
        if sname in args.name_map:
            continue
        m = re.search(r'"viewmodel"\s+"models/weapons/([^"]+)\.mdl"', open(sp, encoding="utf-8", errors="replace").read())
        if m and m.group(1).lower() in vm_to_lua:
            args.name_map[sname] = vm_to_lua[m.group(1).lower()]

    if args.all:
        files = sorted(glob.glob(os.path.join(args.source, "weapon_*.txt")))
    else:
        files = [args.source]
    os.makedirs(args.out, exist_ok=True)
    produced = {}
    for f in files:
        name = os.path.basename(f)[len("weapon_"):-4]
        lua_name = args.name_map.get(name, name)
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

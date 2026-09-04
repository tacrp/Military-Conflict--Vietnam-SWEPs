#!/usr/bin/env python3
"""
rip_game.py - pull weapon assets straight out of Military Conflict: Vietnam and update the addon.

    python rip_game.py --game "D:\SteamLibrary\steamapps\common\Military Conflict - Vietnam\vietnam" --steps all
    python rip_game.py --steps scripts,strings,materials,sounds,particles     # quick asset refresh
    python rip_game.py --steps models                                         # extract + decompile (slow)
    python rip_game.py --steps port                                           # port + compile every model (slow)
    python rip_game.py --steps install,lua                                    # copy compiled models in, generate new lua

Steps (in the order they run):
  scripts    copy the game's scripts/weapon_*.txt into work/cscripts
  strings    read resource/vietnam_english.txt into work/strings.json (weapon names, countries)
  models     extract models/weapons/* from the VPK into work/rip and decompile every v_/w_ model
             whose .mdl CRC changed (Crowbar command line fork) into work/MCV_SMD_OG/weapons
  port       run port_qc.py --all --compile on the decompiled models (viewmodels and worldmodels)
  install    copy the compiled model sets into the addon's models/weapons/mcv (only the ones that
             compiled), plus the game's non-weapon models under models/weapons (shells...) as-is
  materials  materials/models/weapons/<dir> for every dir a weapon QC references, into
             materials/models/weapons/mcv/<dir> with the VMT texture paths rewritten
  sounds     sound/weapons and sound/foley into sound/mcv/..., and the two weapon soundscripts
             regenerated into lua/mcv/shared through parse_soundscripts.py
  particles  particles/*.pcf into the addon
  lua        port_weapon.py --only-new for weapons that have no lua file yet

Every step is idempotent; a manifest of VPK CRCs in work/rip/manifest.json makes `models` skip
models that did not change since the last run.
"""
import argparse
import glob
import json
import os
import re
import shutil
import subprocess
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
ADDON = os.path.normpath(os.path.join(HERE, ".."))
sys.path.insert(0, HERE)
from vpklib import VPK  # noqa: E402

RIP = os.path.join(HERE, "rip")
OG = os.path.join(HERE, "MCV_SMD_OG", "weapons")
PORT = os.path.join(HERE, "MCV_SMD_PORT", "weapons")
CROWBAR = os.path.join(HERE, "tools", "CrowbarCommandLineDecomp.exe")
MANIFEST = os.path.join(RIP, "manifest.json")


def log(msg):
    print(time.strftime("%H:%M:%S"), msg, flush=True)


def load_manifest():
    if os.path.isfile(MANIFEST):
        return json.load(open(MANIFEST))
    return {}


def save_manifest(m):
    os.makedirs(RIP, exist_ok=True)
    json.dump(m, open(MANIFEST, "w"), indent=1, sort_keys=True)


# --------------------------------------------------------------------------------------------
def step_scripts(args, vpk):
    src = os.path.join(args.game, "scripts")
    dst = os.path.join(HERE, "cscripts")
    os.makedirs(dst, exist_ok=True)
    new = changed = 0
    for f in sorted(glob.glob(os.path.join(src, "weapon_*.txt"))):
        d = os.path.join(dst, os.path.basename(f))
        if not os.path.isfile(d):
            new += 1
        elif open(f, "rb").read().replace(b"\r\n", b"\n") != open(d, "rb").read().replace(b"\r\n", b"\n"):
            changed += 1
        else:
            continue
        shutil.copyfile(f, d)
    log("scripts: %d new, %d changed weapon scripts copied to work/cscripts" % (new, changed))


def step_strings(args, vpk):
    p = os.path.join(args.game, "resource", "vietnam_english.txt")
    raw = open(p, "rb").read()
    text = raw.decode("utf-16") if raw[:2] in (b"\xff\xfe", b"\xfe\xff") else raw.decode("utf-8", "replace")
    strings = {}
    for m in re.finditer(r'^\s*"([^"]+)"\s+"((?:[^"\\]|\\.)*)"', text, re.M):
        strings[m.group(1)] = m.group(2).replace('\\"', '"')
    weapons = {k: v for k, v in strings.items() if k.lower().startswith("weapon_")}
    out = os.path.join(HERE, "strings.json")
    json.dump(strings, open(out, "w", encoding="utf-8"), indent=1, ensure_ascii=False, sort_keys=True)
    log("strings: %d strings (%d weapon names) -> work/strings.json" % (len(strings), len(weapons)))


def weapon_model_entries(vpk):
    return sorted(p for p in vpk.entries if p.startswith("models/weapons/") and p.count("/") == 2
                  and re.match(r'models/weapons/([vw]_[^/]+|gesture_animations)\.(mdl|vvd|vtx|phy|ani)$', p))


STUDIO_FRAMEANIM = 0x40


def uses_frame_anim(mdl_path):
    """True when any animation in the .mdl is stored in the frame-based format
    (mstudio_frame_anim_t, animdesc flag 0x40). The current game models are compiled
    this way; only Crowbar 0.74+ decodes it. The 0.68 command line fork writes a
    constant garbage rotation for those bones instead, which shows in GMod as
    viewmodels frozen in a mangled bind pose."""
    try:
        d = open(mdl_path, "rb").read()
        off = 4 + 4 + 4 + 64 + 4 + 12 * 6
        numanim, animindex = struct.unpack_from("<ii", d, off + 7 * 4)
        for i in range(numanim):
            flags = struct.unpack_from("<i", d, animindex + i * 100 + 12)[0]
            if flags & STUDIO_FRAMEANIM:
                return True
    except Exception:
        return True
    return False


def import_decompiled(src_root, name, out):
    """Copy a Crowbar 0.74 GUI batch decompile (folder-for-each-model layout) into OG."""
    src = os.path.join(src_root, name)
    if not os.path.isfile(os.path.join(src, name + ".qc")):
        return False
    shutil.rmtree(out, ignore_errors=True)
    shutil.copytree(src, out)
    return True


def step_models(args, vpk):
    manifest = load_manifest()
    entries = weapon_model_entries(vpk)
    mdls = [p for p in entries if p.endswith(".mdl")]
    log("models: %d weapon model files in the VPK (%d .mdl)" % (len(entries), len(mdls)))
    for p in entries:
        vpk.extract(p, RIP)
    todo = []
    for p in mdls:
        name = os.path.basename(p)[:-4]
        crc = vpk.crc(p)
        if not args.force and manifest.get(p) == crc and os.path.isfile(os.path.join(OG, name, name + ".qc")):
            continue
        todo.append((p, name, crc))
    log("models: %d to decompile (%d unchanged)" % (len(todo), len(mdls) - len(todo)))
    if args.decompiled:
        n = 0
        rest = []
        for p, name, crc in todo:
            if import_decompiled(args.decompiled, name, os.path.join(OG, name)):
                manifest[p] = crc
                n += 1
            else:
                rest.append((p, name, crc))
        save_manifest(manifest)
        log("models: %d imported from %s" % (n, args.decompiled))
        todo = rest
    frame_anim = [(p, name, crc) for p, name, crc in todo
                  if uses_frame_anim(os.path.join(RIP, p.replace("/", os.sep)))]
    if frame_anim:
        log("models: %d models use frame-based animation storage, which the Crowbar 0.68 command line fork "
            "cannot decode. Batch-decompile work/rip/models/weapons with the Crowbar 0.74 GUI (folder for "
            "each model) and rerun with --decompiled <that folder>. Skipped: %s"
            % (len(frame_anim), ", ".join(n for _, n, _ in frame_anim[:15]) + (" ..." if len(frame_anim) > 15 else "")))
        todo = [t for t in todo if t not in frame_anim]
    if not todo:
        return
    if not os.path.isfile(CROWBAR):
        log("models: %s missing" % CROWBAR)
        return
    for i, (p, name, crc) in enumerate(todo, 1):
        out = os.path.join(OG, name)
        tmp = out + "__new"
        shutil.rmtree(tmp, ignore_errors=True)
        os.makedirs(tmp, exist_ok=True)
        mdl = os.path.join(RIP, p.replace("/", os.sep))
        try:
            r = subprocess.run([CROWBAR, "-p", mdl, "-o", tmp], capture_output=True, text=True, timeout=600)
            ok = os.path.isfile(os.path.join(tmp, name + ".qc"))
        except Exception as e:
            r = None; ok = False
            log("  %s: crowbar failed: %s" % (name, e))
        if ok:
            shutil.rmtree(out, ignore_errors=True)
            os.rename(tmp, out)
            manifest[p] = crc
            save_manifest(manifest)
        else:
            shutil.rmtree(tmp, ignore_errors=True)
            log("  %s: no qc produced%s" % (name, (": " + r.stdout[-300:].strip()) if r else ""))
        if i % 20 == 0 or i == len(todo):
            log("  decompiled %d/%d" % (i, len(todo)))


def step_port(args, vpk):
    game_dir = os.path.join(HERE, "compile_test_game")
    cmd = [sys.executable, os.path.join(HERE, "port_qc.py"), OG, "--all", "--compile", "--game", game_dir,
           "--report", os.path.join(RIP, "port_report.json"), "--jobs", str(args.jobs)]
    log("port: " + " ".join(cmd[1:]))
    with open(os.path.join(RIP, "port.log"), "w") as lf:
        subprocess.run(cmd, stdout=lf, stderr=subprocess.STDOUT, cwd=HERE)
    rep = json.load(open(os.path.join(RIP, "port_report.json")))
    ok = [r["name"] for r in rep if r.get("compile", {}).get("ok")]
    bad = [r["name"] for r in rep if r.get("compile") and not r["compile"].get("ok")]
    log("port: %d compiled, %d failed%s" % (len(ok), len(bad), (": " + ", ".join(bad[:20])) if bad else ""))


def step_install(args, vpk):
    game_dir = os.path.join(HERE, "compile_test_game", "models", "weapons", "mcv")
    dst = os.path.join(ADDON, "models", "weapons", "mcv")
    rep_path = os.path.join(RIP, "port_report.json")
    ok = None
    if os.path.isfile(rep_path):
        ok = {r["name"] for r in json.load(open(rep_path)) if r.get("compile", {}).get("ok")}
    n = 0
    for f in sorted(glob.glob(os.path.join(game_dir, "*"))):
        name = os.path.basename(f).split(".")[0]
        if ok is not None and name not in ok:
            continue
        if f.endswith(".ani"):
            # stale output from before port_qc.py stripped $animblocksize: the animation
            # data now lives in the .mdl and a leftover .ani must not ship
            os.remove(f)
            continue
        shutil.copyfile(f, os.path.join(dst, os.path.basename(f)))
        stale = os.path.join(dst, name + ".ani")
        if os.path.isfile(stale):
            os.remove(stale)
        n += 1
    log("install: %d compiled model files copied into models/weapons/mcv" % n)
    # non-weapon models under models/weapons (shells, grenades...) are used as-is, together with
    # their materials: they reference materials/models/weapons/<subdir>/ directly
    m = 0
    subdirs = set()
    for p in sorted(vpk.entries):
        if p.startswith("models/weapons/") and p.count("/") >= 3 and re.search(r'\.(mdl|vvd|vtx|phy)$', p):
            vpk.extract(p, ADDON)
            subdirs.add(p.split("/")[2].lower())
            m += 1
    mats = 0
    for p in sorted(vpk.entries):
        parts = p.lower().split("/")
        if len(parts) >= 5 and parts[0] == "materials" and parts[1] == "models" and parts[2] == "weapons" \
                and parts[3] in subdirs and re.search(r'\.(vmt|vtf)$', p):
            vpk.extract(p, ADDON)
            mats += 1
    log("install: %d model files under models/weapons/<subdir> copied as-is, with %d material files" % (m, mats))


def referenced_material_dirs():
    dirs = set()
    for qc in glob.glob(os.path.join(PORT, "*", "*.qc")) + glob.glob(os.path.join(OG, "*", "*.qc")):
        for m in re.finditer(r'\$cdmaterials\s+"models[\\/]weapons[\\/](?:mcv[\\/])?([^"\\/]+)[\\/]?"', open(qc, encoding="utf-8", errors="replace").read(), re.I):
            dirs.add(m.group(1).lower())
    return dirs


def step_materials(args, vpk):
    dirs = referenced_material_dirs()
    dst_root = os.path.join(ADDON, "materials", "models", "weapons", "mcv")
    n = 0
    inverted = kept = 0
    for p in sorted(vpk.entries):
        m = re.match(r'materials/models/weapons/([^/]+)/(.+)$', p, re.I)
        if not m or m.group(1).lower() not in dirs:
            continue
        out = os.path.join(dst_root, m.group(1), m.group(2).replace("/", os.sep))
        # The optics folder holds hand-made lens materials and reticles whose alpha was
        # inverted for the RT scope; never overwrite what is already there.
        is_optics = m.group(1).lower() == "optics"
        if is_optics and os.path.isfile(out):
            kept += 1
            continue
        data = vpk.read(p)
        if p.lower().endswith(".vmt"):
            txt = data.decode("latin-1")
            txt = re.sub(r'(models)([\\/])(weapons)([\\/])(?!mcv[\\/])', r'\1\2\3\4mcv\4', txt, flags=re.I)
            data = txt.encode("latin-1")
        os.makedirs(os.path.dirname(out), exist_ok=True)
        with open(out, "wb") as f:
            f.write(data)
        n += 1
        if is_optics and re.search(r'(?i)crosshair_[^/]*\.vtf$', p):
            # the game's reticles are opaque glass / transparent lines; the RT scope paints
            # black where alpha is high, so invert (exact DXT5 alpha block remap)
            from vtf_invert_alpha import invert_alpha
            try:
                invert_alpha(out); inverted += 1
            except Exception as e:
                log("  %s: alpha not inverted (%s)" % (os.path.basename(out), e))
    if kept or inverted:
        log("materials: optics: %d existing files kept, %d new reticles alpha-inverted" % (kept, inverted))
    log("materials: %d files for %d weapon material dirs -> materials/models/weapons/mcv" % (n, len(dirs)))


def step_sounds(args, vpk):
    n = 0
    for p in sorted(vpk.entries):
        if p.startswith("sound/weapons/") or p.startswith("sound/foley/"):
            out = os.path.join(ADDON, "sound", "mcv", p[len("sound/"):].replace("/", os.sep))
            os.makedirs(os.path.dirname(out), exist_ok=True)
            with open(out, "wb") as f:
                f.write(vpk.read(p))
            n += 1
    log("sounds: %d files -> sound/mcv" % n)
    conv = os.path.join(ADDON, "parse_soundscripts.py")
    for script, lua in (("scripts/vietnam_sounds_weapons.txt", "sh_soundscript_weapons.lua"),
                        ("scripts/vietnam_sounds_foley.txt", "sh_soundscript_foley.lua")):
        src = vpk.extract(script, RIP)
        out = os.path.join(ADDON, "lua", "mcv", "shared", lua)
        r = subprocess.run([sys.executable, conv, src, out, "MCV_", "mcv/"], capture_output=True, text=True)
        cnt = open(out, encoding="utf-8", errors="replace").read().count("sound.Add(")
        log("sounds: %s -> %s (%d entries)%s" % (script, lua, cnt, (" " + r.stderr.strip()[-200:]) if r.returncode else ""))


def step_particles(args, vpk):
    n = 0
    for p in sorted(vpk.entries):
        if p.startswith("particles/") and p.endswith(".pcf"):
            vpk.extract(p, ADDON)
            n += 1
    log("particles: %d pcf files copied" % n)


VMT_TEX_KEYS = ("$basetexture", "$basetexture2", "$bumpmap", "$normalmap", "$detail", "$envmapmask",
                "$ramptexture", "$lightwarptexture", "$phongexponenttexture", "$selfillummask", "$blendmodulatetexture",
                "$texture2", "$flowmap", "$refracttexture")


def _vtf_has_sheet(head):
    """True if a VTF (7.3+) carries a particle sprite sheet resource (tag 0x10 0x00 0x00)."""
    import struct
    if len(head) < 80 or head[:4] != b"VTF\0":
        return False
    vmaj, vmin = struct.unpack("<II", head[4:12])
    if vmaj != 7 or vmin < 3:
        return False
    nres = struct.unpack("<I", head[68:72])[0]
    for i in range(min(nres, 16)):
        tag = head[80 + 8 * i:80 + 8 * i + 3]
        if tag == b"\x10\x00\x00":
            return True
    return False


def _downgrade_sheet(data):
    """Rewrite a version-2 particle sheet resource (CS:GO era: 4 images per frame, each 4 UVs
    plus 16 extra floats) to version 1 (4 images per frame, 4 UVs each), which is the newest
    format GMod's CSheet reads. Returns the new VTF bytes, or None if nothing to do."""
    import struct
    if len(data) < 80 or data[:4] != b"VTF\0":
        return None
    vmaj, vmin = struct.unpack("<II", data[4:12])
    if vmaj != 7 or vmin < 3:
        return None
    nres = struct.unpack("<I", data[68:72])[0]
    for i in range(min(nres, 16)):
        tag = data[80 + 8 * i:80 + 8 * i + 3]
        if tag != b"\x10\x00\x00":
            continue
        off = struct.unpack("<I", data[84 + 8 * i:88 + 8 * i])[0]
        size = struct.unpack("<I", data[off:off + 4])[0]
        s = data[off + 4:off + 4 + size]
        ver, nseq = struct.unpack("<II", s[:8])
        if ver != 2:
            return None
        out = bytearray(struct.pack("<II", 1, nseq))
        p = 8
        try:
            for _ in range(nseq):
                sid, clamp, nfr, total = struct.unpack("<IIIf", s[p:p + 16]); p += 16
                out += struct.pack("<IIIf", sid, clamp, nfr, total)
                for _ in range(nfr):
                    out += s[p:p + 4]; p += 4                     # duration
                    for _ in range(4):                          # MAX_IMAGES_PER_FRAME_ON_DISK
                        out += s[p:p + 16]; p += 80              # 4 uv floats, skip 16 extra floats
        except struct.error:
            return None
        if p != size:
            return None                                          # layout guess did not fit; leave it
        if len(out) > size:
            return None
        new = bytearray(data)
        new[off:off + 4] = struct.pack("<I", len(out))
        new[off + 4:off + 4 + len(out)] = out
        return bytes(new)
    return None


def _vmt_textures(text):
    out = set()
    for key in VMT_TEX_KEYS:
        for m in re.finditer(r'(?i)"?' + re.escape(key) + r'"?\s+"?([^"\s]+)"?', text):
            v = m.group(1).replace("\\", "/").strip().lower()
            if v and not v.startswith("env_cubemap") and not v.startswith("_rt_"):
                out.add(v)
    return out


def step_particle_materials(args, vpk):
    """Materials referenced by the particle systems (muzzle flashes, explosions, tracers, smoke).
    PCFs are binary DMX; material names are plain strings in them, relative to materials/."""
    lower = {p.lower(): p for p in vpk.entries}
    mats = set()
    for pcf in glob.glob(os.path.join(ADDON, "particles", "*.pcf")):
        data = open(pcf, "rb").read()
        for m in re.finditer(rb'[A-Za-z0-9_][A-Za-z0-9_/\\\-.]{3,160}', data):
            s = m.group(0).decode("latin-1").replace("\\", "/").lower()
            if s.endswith(".vmt"):
                s = s[:-4]
            if ("materials/" + s + ".vmt") in lower:
                mats.add(s)
    log("particle materials: %d material names referenced by %d pcf files" % (len(mats), len(glob.glob(os.path.join(ADDON, "particles", "*.pcf")))))
    copied = sheets = 0
    seen = set()
    queue = list(mats)
    while queue:
        m = queue.pop()
        if m in seen:
            continue
        seen.add(m)
        vmt = lower.get("materials/" + m + ".vmt")
        if vmt:
            data = vpk.read(vmt)
            txt = data.decode("latin-1")
            # The game's particle materials are UnlitGeneric, which in GMod ignores the sprite
            # sheet resource inside the VTF and draws the whole sheet at once. SpriteCard is the
            # particle shader that samples sheets; switch to it when the base texture has one.
            bt = re.search(r'(?i)"?\$basetexture"?\s+"?([^"\s]+)"?', txt)
            if bt and re.match(r'(?i)\s*"?unlitgeneric"?', txt):
                vtf = lower.get("materials/" + bt.group(1).replace("\\", "/").lower() + ".vtf")
                if vtf and _vtf_has_sheet(vpk.read(vtf)[:256]):
                    txt = re.sub(r'(?i)^(\s*)"?unlitgeneric"?', r'\1"SpriteCard"', txt, count=1)
                    data = txt.encode("latin-1")
                    sheets += 1
            out = os.path.join(ADDON, vmt.replace("/", os.sep))
            os.makedirs(os.path.dirname(out), exist_ok=True)
            with open(out, "wb") as f:
                f.write(data)
            copied += 1
            for tex in _vmt_textures(txt):
                vtf = lower.get("materials/" + tex + ".vtf")
                if vtf and vtf not in seen:
                    raw = vpk.read(vtf)
                    conv = _downgrade_sheet(raw)
                    if conv:
                        sheets += 1
                    dst = os.path.join(ADDON, vtf.replace("/", os.sep))
                    os.makedirs(os.path.dirname(dst), exist_ok=True)
                    with open(dst, "wb") as f:
                        f.write(conv or raw)
                    copied += 1; seen.add(vtf)
                elif not vtf:
                    log("  texture missing in vpk: %s (from %s)" % (tex, m))
    log("particle materials: %d files copied into materials/, %d sprite sheets downgraded to version 1 for GMod" % (copied, sheets))
    with open(os.path.join(RIP, "particle_materials.txt"), "w") as f:
        f.write("\n".join(sorted(mats)))


def step_pcf_models(args, vpk):
    """Models the particle systems spawn (explosion debris chunks) plus the materials those
    models use, read straight from the MDL header strings."""
    lower = {p.lower(): p for p in vpk.entries}
    mdls = set()
    for pcf in glob.glob(os.path.join(ADDON, "particles", "*.pcf")):
        data = open(pcf, "rb").read()
        for m in re.finditer(rb'[A-Za-z0-9_][A-Za-z0-9_/\\\-.]{3,160}\.mdl', data):
            s = m.group(0).decode("latin-1").replace("\\", "/").lower()
            if not s.startswith("models/"):
                s = "models/" + s
            if s in lower:
                mdls.add(s)
    copied = 0
    mats = 0
    for mdl in sorted(mdls):
        base = mdl[:-4]
        for ext in (".mdl", ".vvd", ".dx90.vtx", ".dx80.vtx", ".sw.vtx", ".phy", ".ani"):
            p = lower.get(base + ext)
            if p:
                vpk.extract(p, ADDON); copied += 1
        # cdmaterials dirs and texture names are plain strings in the mdl header
        head = vpk.read(mdl)
        dirs = set(m.group(0).decode("latin-1").replace("\\", "/").lower() for m in re.finditer(rb'models[/\\][A-Za-z0-9_/\\\-.]+[/\\]', head))
        names = set(m.group(0).decode("latin-1").lower() for m in re.finditer(rb'[A-Za-z0-9_\-]{2,64}', head))
        for d in dirs:
            for n in names:
                vmt = lower.get("materials/" + d + n + ".vmt")
                if vmt:
                    vpk.extract(vmt, ADDON); mats += 1
                    for tex in _vmt_textures(vpk.read(vmt).decode("latin-1")):
                        vtf = lower.get("materials/" + tex + ".vtf")
                        if vtf:
                            vpk.extract(vtf, ADDON); mats += 1
    log("pcf models: %d models referenced by the particle systems, %d model files and %d material files copied" % (len(mdls), copied, mats))
    with open(os.path.join(RIP, "pcf_models.txt"), "w") as f:
        f.write("\n".join(sorted(mdls)))


def step_pcf_nolights(args, vpk):
    """Strip the 'Render lights' operator from the muzzle flash systems: their omnidirectional
    dynamic light lights up the rear sight from the muzzle side. Must run after `particles`
    (which copies the untouched pcfs)."""
    from dmxlib import DMX, strip_operators
    total = 0
    for pcf in sorted(glob.glob(os.path.join(ADDON, "particles", "*.pcf"))):
        data = open(pcf, "rb").read()
        try:
            d = DMX(data)
        except Exception as e:
            log("  %s: cannot parse (%s), left alone" % (os.path.basename(pcf), e))
            continue
        n = strip_operators(d, lambda name: "muzzleflash" in name.lower(), {"Render lights", "Render Dynamic Light", "render_projected"})
        if n:
            with open(pcf, "wb") as f:
                f.write(d.serialize())
            total += n
            log("  %s: %d light renderers removed" % (os.path.basename(pcf), n))
    log("pcf nolights: %d muzzle flash light renderers removed" % total)


def _lua_name_map():
    """script name -> lua name (same resolver as port_weapon.py)."""
    import port_weapon
    return port_weapon.resolve_lua_names(os.path.join(HERE, "cscripts"), ADDON)


def step_icons(args, vpk):
    """Weapon selection / spawn icons from the game's panorama SVGs: rendered white on
    transparent, scaled to fit the middle 256x128 band of a 256x256 png."""
    try:
        import cairosvg
        from PIL import Image
        import io
    except ImportError as e:
        log("icons: %s (pip install cairosvg pillow)" % e)
        return
    name_map = _lua_name_map()
    svgs = {}
    for p in vpk.entries:
        m = re.match(r'materials/panorama/images/icons/equipment/(?:new/)?(weapon_[^/]+)\.svg$', p, re.I)
        if m:
            svgs.setdefault(m.group(1).lower(), p)     # prefer the first seen; "new/" overrides below
    for p in vpk.entries:
        m = re.match(r'materials/panorama/images/icons/equipment/new/(weapon_[^/]+)\.svg$', p, re.I)
        if m:
            svgs[m.group(1).lower()] = p
    out_dir = os.path.join(ADDON, "materials", "entities")
    os.makedirs(out_dir, exist_ok=True)
    made = skipped = 0
    # several scripts map to one lua (weapon_sks and weapon_sks_riflegrenade both -> mcv_sks);
    # the icon must come from the base script, which is the shortest name for that lua file
    primary = {}
    for sname, lua_name in name_map.items():
        if sname.startswith("dual_"):
            continue
        # the script named like the lua file wins (weapon_akm_gp25 over weapon_gp25), else the
        # shortest name (weapon_sks over weapon_sks_riflegrenade)
        cur = primary.get(lua_name)
        if cur is None or sname == lua_name or (cur != lua_name and len(sname) < len(cur)):
            primary[lua_name] = sname
    for sname, lua_name in sorted(name_map.items()):
        if sname.startswith("dual_") or primary.get(lua_name) != sname:
            continue
        key = ("weapon_" + sname).lower()
        if key not in svgs:
            skipped += 1
            continue
        if args.only_new_icons and os.path.isfile(os.path.join(out_dir, "mcv_%s.png" % lua_name)):
            continue
        svg = vpk.read(svgs[key]).decode("utf-8", "replace")
        # everything white
        svg = re.sub(r'(?i)(fill|stroke)\s*:\s*#[0-9a-f]{3,8}', r'\1:#ffffff', svg)
        svg = re.sub(r'(?i)(fill|stroke)="(?!none)(?!transparent)[^"]*"', r'\1="#ffffff"', svg)
        try:
            png = cairosvg.svg2png(bytestring=svg.encode("utf-8"), output_width=1024)
        except Exception as e:
            log("  %s: svg render failed: %s" % (sname, e))
            continue
        im = Image.open(io.BytesIO(png)).convert("RGBA")
        bbox = im.getbbox()
        if not bbox:
            continue
        im = im.crop(bbox)
        # force pure white with the rendered alpha
        alpha = im.split()[3]
        im = Image.new("RGBA", im.size, (255, 255, 255, 0))
        im.putalpha(alpha)
        box_w, box_h = 256, 128
        scale = min(box_w / im.width, box_h / im.height)
        im = im.resize((max(1, round(im.width * scale)), max(1, round(im.height * scale))), Image.LANCZOS)
        canvas = Image.new("RGBA", (256, 256), (255, 255, 255, 0))
        canvas.paste(im, ((256 - im.width) // 2, (256 - im.height) // 2), im)
        canvas.save(os.path.join(out_dir, "mcv_%s.png" % lua_name))
        made += 1
    # variants no game script resolves to (sw39 / mk22, t223_40r / t223 ...) share the viewmodel of a
    # weapon that did get an icon: reuse that one
    copied = 0
    vm_of = {}
    for lp in glob.glob(os.path.join(ADDON, "lua", "weapons", "mcv_*.lua")):
        m = re.search(r'SWEP\.ViewModel\s*=\s*"models/weapons/mcv/([^"]+)\.mdl"', open(lp, encoding="utf-8", errors="replace").read())
        if m:
            vm_of[os.path.basename(lp)[:-4]] = m.group(1).lower()
    for lua, vm in vm_of.items():
        dst_png = os.path.join(out_dir, lua + ".png")
        if os.path.isfile(dst_png):
            continue
        for other, ovm in vm_of.items():
            src_png = os.path.join(out_dir, other + ".png")
            if other != lua and ovm == vm and os.path.isfile(src_png):
                shutil.copyfile(src_png, dst_png)
                copied += 1
                break
    log("icons: %d icons written to materials/entities, %d weapons without an svg, %d variants given their sibling's icon" % (made, skipped, copied))


EFFECT_FIELDS = (  # lua field, script key, default
    ("MuzzleParticle", "MuzzleParticle", ""),
    ("MuzzleParticleSmoke", "MuzzleParticle_Smoke", ""),
    ("MuzzleParticleIronsighted", "MuzzleParticle_Ironsighted", ""),
    ("MuzzleParticleIronsightedSmoke", "MuzzleParticle_IronsightedSmoke", ""),
    ("MuzzleParticle3rdPerson", "MuzzleParticle3rdPerson", ""),
    ("EjectBrassTrail", "EjectBrassTrail", "vietnam_weaponeffect_shelleject_trail"),
    ("EjectBrassParticle", "EjectBrassParticle", "vietnam_weaponeffect_shelleject_side"),
    ("TracerParticle", "TracerParticle", "vietnam_tracer_rifle_primary"),
)


def step_effects_lua(args, vpk):
    """Point every weapon lua at the game's own particle systems (muzzle flashes, brass, tracers)
    and refresh the pcf registration list in lua/mcv/shared/sh_effects.lua."""
    name_map = _lua_name_map()
    lua_dir = os.path.join(ADDON, "lua", "weapons")
    changed = 0
    for sname, lua_name in name_map.items():
        lp = os.path.join(lua_dir, "mcv_%s.lua" % lua_name)
        sp = os.path.join(HERE, "cscripts", "weapon_%s.txt" % sname)
        if not os.path.isfile(lp) or not os.path.isfile(sp):
            continue
        script = open(sp, encoding="utf-8", errors="replace").read()
        src = open(lp, encoding="utf-8", errors="replace").read()
        new = src
        for field, key, default in EFFECT_FIELDS:
            m = re.search(r'"%s"\s+"([^"]*)"' % key, script)
            val = m.group(1) if m else default
            if val.lower() == "null":
                val = ""
            if field == "MuzzleParticleIronsighted" and not val:
                val = re.search(r'SWEP\.MuzzleParticle\s*=\s*"([^"]*)"', new)
                val = val.group(1) if val else ""
            new, n = re.subn(r'^(SWEP\.%s\s*=\s*)"[^"]*"' % field, r'\1"%s"' % val, new, flags=re.M)
            if n == 0:
                new = new.rstrip("\n") + '\nSWEP.%s = "%s"\n' % (field, val)
        if new != src:
            open(lp, "w", encoding="utf-8", newline="\n").write(new)
            changed += 1
    log("effects_lua: %d weapon files switched to the game's particle names" % changed)
    pcfs = sorted(os.path.basename(p) for p in glob.glob(os.path.join(ADDON, "particles", "*.pcf")))
    eff = os.path.join(ADDON, "lua", "mcv", "shared", "sh_effects.lua")
    with open(eff, "w", encoding="utf-8", newline="\n") as f:
        f.write("// Generated by work/rip_game.py (--steps effects_lua): every pcf shipped in particles/\n")
        for p in pcfs:
            f.write('game.AddParticles( "particles/%s" )\n' % p)
    log("effects_lua: sh_effects.lua registers %d pcf files" % len(pcfs))


def step_lua(args, vpk):
    cmd = [sys.executable, os.path.join(HERE, "port_weapon.py"), os.path.join(HERE, "cscripts"), "--all", "--only-new",
           "--out", os.path.join(ADDON, "lua", "weapons")]
    r = subprocess.run(cmd, capture_output=True, text=True, cwd=HERE)
    made = [l for l in r.stdout.splitlines() if " -> " in l]
    log("lua: %d new weapon files written to lua/weapons" % len(made))
    for l in made:
        print("   " + l.strip())


STEPS = [("scripts", step_scripts), ("strings", step_strings), ("models", step_models), ("port", step_port),
         ("install", step_install), ("materials", step_materials), ("sounds", step_sounds),
         ("particles", step_particles), ("pcf_nolights", step_pcf_nolights), ("particle_materials", step_particle_materials),
         ("pcf_models", step_pcf_models),
         ("icons", step_icons), ("lua", step_lua), ("effects_lua", step_effects_lua)]


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--game", default=r"D:\SteamLibrary\steamapps\common\Military Conflict - Vietnam\vietnam")
    ap.add_argument("--steps", default="all", help="comma separated list, or all")
    ap.add_argument("--force", action="store_true", help="models: decompile even if the CRC is unchanged")
    ap.add_argument("--jobs", type=int, default=max(1, (os.cpu_count() or 4) - 2),
                    help="port: parallel port/compile jobs (default: cores - 2)")
    ap.add_argument("--decompiled", default=None,
                    help="models: folder holding a Crowbar 0.74 GUI batch decompile of work/rip/models/weapons "
                         "(folder for each model); imported instead of running the 0.68 command line fork")
    ap.add_argument("--only-new-icons", action="store_true", help="icons: keep existing pngs")
    args = ap.parse_args()
    want = [s for s, _ in STEPS] if args.steps == "all" else [s.strip() for s in args.steps.split(",")]
    vpk = VPK(os.path.join(args.game, "pak01_dir.vpk"))
    for name, fn in STEPS:
        if name in want:
            fn(args, vpk)
    vpk.close()


if __name__ == "__main__":
    main()

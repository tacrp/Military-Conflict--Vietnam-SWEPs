#!/usr/bin/env python3
"""
port_qc.py - semi-automatic port of Military Conflict: Vietnam viewmodel QCs to the MCV GMod base.

Reverse-engineered from the hand-ported QCs in work/MCV_SMD (see work/PORTING.md for the
full write-up). Reads Crowbar-decompiled QCs from the original game and writes GMod-ready QCs.

Usage (from the work/ directory):

    python port_qc.py MCV_SMD_OG/weapons/v_sks              # one weapon
    python port_qc.py MCV_SMD_OG/weapons --all              # everything
    python port_qc.py MCV_SMD_OG/weapons/v_dual_m1911 --compile

Output goes to MCV_SMD_PORT/weapons/<name>/<name>.qc by default (--out to change). SMD paths in the
generated QC point back at the original SMDs, except where an override exists in
MCV_SMD/weapons/<name>/anims/<file>.smd (hand-edited animations, e.g. the shotgun pumps).

Categories are detected automatically (normal / shell / dual / melee-or-other) and can be forced
with --mode. See --help for the switches that control the improvements over the hand port.
"""
import argparse
import collections
import glob
import json
import math
import os
import re
import numpy as np
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))

# --------------------------------------------------------------------------------------------
# Configuration tables
# --------------------------------------------------------------------------------------------

QCI_INCLUDE = "militaryconflict_vietnam_v2.qci"
GESTURE_MODEL = "weapons/mcv/gesture_animations.mdl"
MODEL_PREFIX = "weapons/mcv/"
MATERIAL_PREFIX = "models\\weapons\\mcv\\"

# Activity renames that apply to every weapon. Derived from all 204 hand-ported pairs.
ACT_MAP_COMMON = {
    "ACT_VM_IDLETONEARWALL": "ACT_VM_IDLE_TO_LOWERED",
    "ACT_VM_NEARWALL": "ACT_VM_IDLE_LOWERED",
    "ACT_VM_NEARWALLTOIDLE": "ACT_VM_LOWERED_TO_IDLE",
    "ACT_VM_PRONE": "ACT_VM_CRAWL",
    "ACT_VM_PRONETOIDLE": "ACT_VM_CRAWLTOIDLE",
    "ACT_VM_BASH": "ACT_VM_HITCENTER",
    "ACT_VM_FIRSTDRAW": "ACT_VM_READY",
    "ACT_VM_DEPLOYSHOOT": "ACT_VM_PRIMARYATTACK_DEPLOYED",
    "ACT_VM_BASH_BAYONET": "ACT_VM_HITLEFT",
    "ACT_VM_SLASH_BAYONET": "ACT_VM_HITRIGHT",
    "ACT_VM_BAYONET_EQUIP": "ACT_VM_ATTACH_SILENCER",
    "ACT_VM_BAYONET_UNEQUIP": "ACT_VM_DETACH_SILENCER",
    "ACT_VM_IDLETODEPLOY": "ACT_VM_DEPLOYED_IN",
    "ACT_VM_DEPLOYTOIDLE": "ACT_VM_DEPLOYED_OUT",
    "ACT_VM_UNDEPLOY": "ACT_VM_DEPLOYED_OUT",
    "ACT_VM_PRONEDEPLOY": "ACT_VM_CRAWLDEPLOY",
    "ACT_VM_RELOADEMPTY_DEPLOYED": "ACT_VM_DEPLOYED_RELOAD_EMPTY",
    "ACT_VM_GRENADE": "ACT_VM_IDLE_M203",
    "ACT_VM_GRENADE_DRAW": "ACT_VM_DRAWFULL_M203",
    "ACT_VM_GRENADE_DRAW_EMPTY": "ACT_VM_DRAW_M203",
    "ACT_VM_GRENADE_RELOAD": "ACT_VM_RELOAD_M203",
    "ACT_VM_GRENADE_SHOOT": "ACT_VM_ISHOOT_M203",
    "ACT_VM_SCOPE_ADJUST": "ACT_VM_FIDGET",
    "ACT_VM_BOLTPULL": "ACT_VM_RELOAD_INSERT_PULL",
    "ACT_VM_FIREMODE1": "ACT_VM_IFIREMODE",
    "ACT_VM_FIREMODE_DEPLOY": "ACT_VM_DFIREMODE",
    "ACT_VM_PRIMARYATTACK1": "ACT_VM_PRIMARYATTACK_1",
    "ACT_VM_PRIMARYATTACK2": "ACT_VM_PRIMARYATTACK_2",
    "ACT_VM_SECONDARYATTACK2": "ACT_VM_PRIMARYATTACK_3",
    "ACT_VM_HAULBACK2": "ACT_VM_PULLPIN",
    "ACT_VM_SHOTGUN_RELOAD": "ACT_VM_RELOAD_INSERT",
    "ACT_VM_SHOTGUN_RELOADEMPTY_START": "ACT_VM_RELOAD_INSERT_EMPTY",
    "ACT_SHOTGUN_RELOADEMPTY_START": "ACT_VM_RELOAD_INSERT_EMPTY",
    "ACT_SHOTGUN_PRIMARY_RELOAD_FINISH": "ACT_VM_RELOAD_END_EMPTY",
    "ACT_SHOTGUN_RELOAD_CHANGE": "ACT_VM_RELOAD_END",
    # Underbarrel grenade launcher (M203 / GP25 style) variants
    "ACT_VM_GL": "ACT_VM_IIDLE_M203",
    "ACT_VM_GLTOIDLE": "ACT_VM_IOUT_M203",
    "ACT_VM_GL_DRAW": "ACT_VM_DRAW_M203",
    "ACT_VM_IDLETOGL": "ACT_VM_IIN_M203",
    "ACT_VM_RELOAD_SECONDARY": "ACT_VM_RELOAD_M203",
    "ACT_VM_PRONE_GL": "ACT_VM_CRAWL_GL",
    "ACT_VM_BASH_GL": "ACT_VM_HITCENTER_GL",
    "ACT_VM_IDLETONEARWALL_GL": "ACT_VM_IDLE_TO_LOWERED_GL",
    "ACT_VM_NEARWALLTOIDLE_GL": "ACT_VM_LOWERED_TO_IDLE_GL",
    "ACT_VM_NEARWALL_GL": "ACT_VM_IDLE_LOWERED_GL",
    "ACT_VM_PRONETOIDLE_GL": "ACT_VM_CRAWLTOIDLE_GL",
}

# Dual-wield pistols/SMGs: the original game used SECONDARY_* for the both-hands actions.
ACT_MAP_DUAL_MAG = {
    "ACT_VM_SECONDARY_RELOAD": "ACT_VM_RELOAD",
    "ACT_VM_RELOAD": "ACT_VM_MISSRIGHT",
    "ACT_VM_RELOADEMPTY": "ACT_VM_MISSRIGHT2",
    "ACT_VM_SECONDARY_RELOADEMPTY": "ACT_VM_RELOADEMPTY",
    "ACT_VM_PRIMARYSHOOTLAST": "ACT_VM_PRIMARYATTACK_EMPTY",
    "ACT_VM_SECONDARYSHOOTLAST": "ACT_VM_SHOOTLAST",
}
# Dual-wield shell loaders (revolvers, izh43): per-hand insert loops
ACT_MAP_DUAL_SHELL = {
    "ACT_VM_SECONDARY_RELOAD": "ACT_VM_RELOAD2",
    "ACT_VM_PRIMARYSHOOTLAST": "ACT_VM_PRIMARYATTACK_EMPTY",
    "ACT_VM_SECONDARYSHOOTLAST": "ACT_VM_SHOOTLAST",
}

# Activities whose main sequence must use `snap` (fire animations). Everything else that gets
# pose-split (bolt pulls, hammer cocks) uses a short fade instead.
FIRE_ACTS = {
    "ACT_VM_PRIMARYATTACK", "ACT_VM_SECONDARYATTACK", "ACT_VM_SHOOTLAST",
    "ACT_VM_PRIMARYATTACK_EMPTY", "ACT_VM_PRIMARYATTACK_DEPLOYED", "ACT_VM_ISHOOT_M203",
    "ACT_VM_PRIMARYATTACK_1", "ACT_VM_PRIMARYATTACK_2", "ACT_VM_PRIMARYATTACK_3",
    "ACT_VM_RECOIL1", "ACT_VM_RECOIL2", "ACT_VM_RECOIL3",
}

# Which idle a delta layer was authored on top of. Keyed by the (already renamed) activity of the
# delta sequence; value is the activity of the idle whose animations become the base of the new
# main sequence. Anything not listed uses ACT_VM_IDLE.
BASE_IDLE_FOR = {
    "ACT_VM_PRIMARYATTACK_DEPLOYED": "ACT_VM_DEPLOY",
    "ACT_VM_ISHOOT_M203": ("ACT_VM_IIDLE_M203", "ACT_VM_IDLE_M203"),
}

# Events the Lua base drives itself when it fires (muzzle flash, shell eject, ammo pose parameter);
# they are dropped from fire sequences so they don't double up. Cycle/pump sequences keep them.
LUA_HANDLED_EVENTS = ("AE_MUZZLEFLASH", "AE_CLIENT_EJECT_BRASS", "AE_WPN_CLIP_TO_POSEPARAM")

# GMod activity list (Enums/ACT, ACT_VM_* and ACT_SHOTGUN_* subset). Used only to warn.
GMOD_ACTS = set("""ACT_VM_DRAW ACT_VM_HOLSTER ACT_VM_IDLE ACT_VM_FIDGET ACT_VM_PULLBACK ACT_VM_PULLBACK_HIGH
ACT_VM_PULLBACK_LOW ACT_VM_THROW ACT_VM_PULLPIN ACT_VM_PRIMARYATTACK ACT_VM_SECONDARYATTACK ACT_VM_RELOAD
ACT_VM_DRYFIRE ACT_VM_HITLEFT ACT_VM_HITLEFT2 ACT_VM_HITRIGHT ACT_VM_HITRIGHT2 ACT_VM_HITCENTER ACT_VM_HITCENTER2
ACT_VM_MISSLEFT ACT_VM_MISSLEFT2 ACT_VM_MISSRIGHT ACT_VM_MISSRIGHT2 ACT_VM_MISSCENTER ACT_VM_MISSCENTER2
ACT_VM_HAULBACK ACT_VM_SWINGHARD ACT_VM_SWINGMISS ACT_VM_SWINGHIT ACT_VM_IDLE_TO_LOWERED ACT_VM_IDLE_LOWERED
ACT_VM_LOWERED_TO_IDLE ACT_VM_RECOIL1 ACT_VM_RECOIL2 ACT_VM_RECOIL3 ACT_VM_PICKUP ACT_VM_RELEASE
ACT_VM_ATTACH_SILENCER ACT_VM_DETACH_SILENCER ACT_VM_PRIMARYATTACK_SILENCED ACT_VM_RELOAD_SILENCED
ACT_VM_DRYFIRE_SILENCED ACT_VM_IDLE_SILENCED ACT_VM_DRAW_SILENCED ACT_VM_IDLE_EMPTY_LEFT ACT_VM_DRYFIRE_LEFT
ACT_VM_RELOAD_DEPLOYED ACT_VM_RELOAD_IDLE ACT_VM_DRAW_DEPLOYED ACT_VM_DRAW_EMPTY ACT_VM_PRIMARYATTACK_EMPTY
ACT_VM_RELOAD_EMPTY ACT_VM_IDLE_EMPTY ACT_VM_IDLE_DEPLOYED_EMPTY ACT_VM_IDLE_8 ACT_VM_IDLE_7 ACT_VM_IDLE_6
ACT_VM_IDLE_5 ACT_VM_IDLE_4 ACT_VM_IDLE_3 ACT_VM_IDLE_2 ACT_VM_IDLE_1 ACT_VM_IDLE_DEPLOYED ACT_VM_IDLE_DEPLOYED_8
ACT_VM_IDLE_DEPLOYED_7 ACT_VM_IDLE_DEPLOYED_6 ACT_VM_IDLE_DEPLOYED_5 ACT_VM_IDLE_DEPLOYED_4 ACT_VM_IDLE_DEPLOYED_3
ACT_VM_IDLE_DEPLOYED_2 ACT_VM_IDLE_DEPLOYED_1 ACT_VM_UNDEPLOY ACT_VM_UNDEPLOY_8 ACT_VM_UNDEPLOY_7 ACT_VM_UNDEPLOY_6
ACT_VM_UNDEPLOY_5 ACT_VM_UNDEPLOY_4 ACT_VM_UNDEPLOY_3 ACT_VM_UNDEPLOY_2 ACT_VM_UNDEPLOY_1 ACT_VM_UNDEPLOY_EMPTY
ACT_VM_DEPLOY ACT_VM_DEPLOY_8 ACT_VM_DEPLOY_7 ACT_VM_DEPLOY_6 ACT_VM_DEPLOY_5 ACT_VM_DEPLOY_4 ACT_VM_DEPLOY_3
ACT_VM_DEPLOY_2 ACT_VM_DEPLOY_1 ACT_VM_DEPLOY_EMPTY ACT_VM_PRIMARYATTACK_8 ACT_VM_PRIMARYATTACK_7
ACT_VM_PRIMARYATTACK_6 ACT_VM_PRIMARYATTACK_5 ACT_VM_PRIMARYATTACK_4 ACT_VM_PRIMARYATTACK_3 ACT_VM_PRIMARYATTACK_2
ACT_VM_PRIMARYATTACK_1 ACT_VM_PRIMARYATTACK_DEPLOYED ACT_VM_PRIMARYATTACK_DEPLOYED_8 ACT_VM_PRIMARYATTACK_DEPLOYED_7
ACT_VM_PRIMARYATTACK_DEPLOYED_6 ACT_VM_PRIMARYATTACK_DEPLOYED_5 ACT_VM_PRIMARYATTACK_DEPLOYED_4
ACT_VM_PRIMARYATTACK_DEPLOYED_3 ACT_VM_PRIMARYATTACK_DEPLOYED_2 ACT_VM_PRIMARYATTACK_DEPLOYED_1
ACT_VM_PRIMARYATTACK_DEPLOYED_EMPTY ACT_VM_FIZZLE ACT_VM_SPRINT_ENTER ACT_VM_SPRINT_IDLE ACT_VM_SPRINT_LEAVE
ACT_VM_UNUSABLE ACT_VM_UNUSABLE_TO_USABLE ACT_VM_USABLE_TO_UNUSABLE ACT_VM_CRAWL ACT_VM_CRAWL_EMPTY
ACT_VM_HOLSTER_EMPTY ACT_VM_DOWN ACT_VM_DOWN_EMPTY ACT_VM_READY ACT_VM_ISHOOT ACT_VM_IIN ACT_VM_IIN_EMPTY ACT_VM_IIDLE
ACT_VM_IIDLE_EMPTY ACT_VM_IOUT ACT_VM_IOUT_EMPTY ACT_VM_PULLBACK_HIGH_BAKE ACT_VM_HITKILL ACT_VM_DEPLOYED_IN
ACT_VM_DEPLOYED_IDLE ACT_VM_DEPLOYED_FIRE ACT_VM_DEPLOYED_DRYFIRE ACT_VM_DEPLOYED_RELOAD ACT_VM_DEPLOYED_RELOAD_EMPTY
ACT_VM_DEPLOYED_OUT ACT_VM_DEPLOYED_IRON_IN ACT_VM_DEPLOYED_IRON_IDLE ACT_VM_DEPLOYED_IRON_FIRE
ACT_VM_DEPLOYED_IRON_DRYFIRE ACT_VM_DEPLOYED_IRON_OUT ACT_VM_DEPLOYED_LIFTED_IN ACT_VM_DEPLOYED_LIFTED_IDLE
ACT_VM_DEPLOYED_LIFTED_OUT ACT_VM_RELOADEMPTY ACT_VM_IRECOIL1 ACT_VM_IRECOIL2 ACT_VM_FIREMODE ACT_VM_ISHOOT_LAST
ACT_VM_IFIREMODE ACT_VM_DFIREMODE ACT_VM_DIFIREMODE ACT_VM_SHOOTLAST ACT_VM_ISHOOTDRY ACT_VM_DRAW_M203
ACT_VM_DRAWFULL_M203 ACT_VM_READY_M203 ACT_VM_IDLE_M203 ACT_VM_RELOAD_M203 ACT_VM_HOLSTER_M203 ACT_VM_HOLSTERFULL_M203
ACT_VM_IIN_M203 ACT_VM_IIDLE_M203 ACT_VM_IOUT_M203 ACT_VM_CRAWL_M203 ACT_VM_DOWN_M203 ACT_VM_ISHOOT_M203
ACT_VM_RELOAD_INSERT ACT_VM_RELOAD_INSERT_PULL ACT_VM_RELOAD_END ACT_VM_RELOAD_END_EMPTY ACT_VM_RELOAD_INSERT_EMPTY
ACT_VM_FIRE_TO_EMPTY ACT_VM_UNLOAD ACT_VM_RELOAD2 ACT_SHOTGUN_RELOAD_START ACT_SHOTGUN_RELOAD_FINISH ACT_SHOTGUN_PUMP
ACT_SHOTGUN_IDLE_DEEP ACT_SHOTGUN_IDLE4""".split())

# --------------------------------------------------------------------------------------------
# QC model
# --------------------------------------------------------------------------------------------

class Block:
    """A $animation or $sequence block. `head` is the text before '{', `lines` the stripped body."""
    def __init__(self, kind, name, path, lines):
        self.kind = kind          # "animation" | "sequence"
        self.name = name
        self.path = path          # for $animation: the smd path
        self.lines = lines        # list of stripped body lines (no blanks)

    # ---- accessors -------------------------------------------------------------------------
    def anims(self):
        """Animation references: leading quoted lines of a sequence body."""
        out = []
        for l in self.lines:
            m = re.match(r'^"([^"]+)"$', l)
            if m:
                out.append(m.group(1))
            else:
                break
        return out

    def opts(self):
        return self.lines[len(self.anims()):]

    def get(self, key):
        for l in self.opts():
            if l == key or l.startswith(key + " "):
                return l
        return None

    def has(self, key):
        return self.get(key) is not None

    def activity(self):
        l = self.get("activity")
        if not l:
            return None
        return re.match(r'activity\s+"([^"]+)"', l).group(1)

    def set_activity(self, act):
        for i, l in enumerate(self.lines):
            if l.startswith("activity "):
                self.lines[i] = 'activity "%s" 1' % act
                return
        self.lines.append('activity "%s" 1' % act)

    def remove(self, pred):
        self.lines = [l for l in self.lines if not pred(l)]

    def remove_key(self, key):
        self.remove(lambda l: l == key or l.startswith(key + " "))

    def events(self):
        return [l for l in self.lines if l.startswith("{ event")]

    def layers(self):
        return [re.match(r'addlayer\s+"([^"]+)"', l).group(1) for l in self.lines if l.startswith("addlayer ")]

    def render(self):
        if self.kind == "animation":
            head = '$animation "%s" "%s"' % (self.name, self.path)
        else:
            head = '$sequence "%s"' % self.name
        if not self.lines:
            return head + " {\n}\n"
        return head + " {\n" + "".join("\t%s\n" % l for l in self.lines) + "}\n"


# A block ends at a line-start "}" or, for the blocks Crowbar 0.68 leaves unterminated (it
# drops the brace after some `loop` animations and closes it much later), at the next
# top-level "$" command.
BLOCK_RE = re.compile(r'^\$(sequence|animation)\s+"([^"]+)"(?:\s+"([^"]+)")?\s*\{(.*?)(?:^\}[ \t]*\n?|(?=^\$))', re.S | re.M)


class QC:
    """Whole QC as an ordered list of items: either raw text strings or Block objects."""
    def __init__(self, text):
        self.items = []
        pos = 0
        for m in BLOCK_RE.finditer(text):
            if m.start() > pos:
                self.items.append(text[pos:m.start()])
            body = [l.strip() for l in m.group(4).split("\n") if l.strip()]
            self.items.append(Block(m.group(1), m.group(2), m.group(3), body))
            pos = m.end()
        if pos < len(text):
            self.items.append(text[pos:])
    def blocks(self, kind=None):
        return [b for b in self.items if isinstance(b, Block) and (kind is None or b.kind == kind)]

    def find(self, kind, name):
        for b in self.blocks(kind):
            if b.name == name:
                return b
        return None

    def find_by_activity(self, act):
        for b in self.blocks("sequence"):
            if b.activity() == act:
                return b
        return None

    def insert_before(self, ref, block):
        i = self.items.index(ref)
        self.items.insert(i, block)

    def insert_after(self, ref, block):
        i = self.items.index(ref)
        self.items.insert(i + 1, block)

    def raw_sub(self, pattern, repl, flags=0):
        """Regex substitute on the raw text items only (not inside blocks)."""
        n = 0
        for i, it in enumerate(self.items):
            if isinstance(it, str):
                new, k = re.subn(pattern, repl, it, flags=flags)
                self.items[i] = new
                n += k
        return n

    def raw_text(self):
        return "".join(it for it in self.items if isinstance(it, str))

    def render(self):
        out = []
        for it in self.items:
            if isinstance(it, str):
                out.append(it)
            else:
                out.append(it.render())
        return "".join(out)


# --------------------------------------------------------------------------------------------
# SMD helpers
# --------------------------------------------------------------------------------------------

_frame_cache = {}

def smd_frames(path):
    """Number of frames in an SMD (count of 'time N' lines in the skeleton block)."""
    if path in _frame_cache:
        return _frame_cache[path]
    n = 0
    try:
        with open(path, "r", encoding="utf-8", errors="replace") as f:
            for line in f:
                if line.lstrip().startswith("time "):
                    n += 1
                elif line.startswith("triangles"):
                    break
    except OSError:
        n = 0
    _frame_cache[path] = n
    return n


def anim_length(qc, name_or_path, ctx):
    """Length in frames of an $animation (by name) or inline smd, honouring frame/numframes."""
    b = qc.find("animation", name_or_path)
    if b is None:
        return smd_frames(ctx.resolve_smd(name_or_path))
    nf = b.get("numframes")
    if nf:
        return int(nf.split()[1])
    fr = b.get("frame")
    if fr:
        a, z = int(fr.split()[1]), int(fr.split()[2])
        return z - a + 1
    return smd_frames(ctx.resolve_smd(b.path))


# --------------------------------------------------------------------------------------------
# Porting context
# --------------------------------------------------------------------------------------------

class Ctx:
    def __init__(self, args, og_dir, out_dir):
        self.args = args
        self.og_dir = og_dir
        self.out_dir = out_dir
        self.name = os.path.basename(og_dir)
        self.override_dir = os.path.join(args.fixed_root, "weapons", self.name, "anims")
        # correctives rewritten by step_fix_correctives land here and win over the OG file
        self.fixed_dir = os.path.join(out_dir, "fixed_anims")
        self.warnings = []
        self.notes = []
        self.mode = None
        self.shell_dual = False
        self.primary_pose_len = None
        self.static_anims = set()

    def warn(self, msg):
        self.warnings.append(msg)

    def note(self, msg):
        self.notes.append(msg)

    def resolve_smd(self, rel):
        """Absolute path of an smd referenced from the OG qc (checks overrides first)."""
        rel = rel.replace("\\", os.sep).replace("/", os.sep)
        base = os.path.basename(rel)
        ov = os.path.join(self.override_dir, base)
        if os.path.isfile(ov):
            return ov
        fx = os.path.join(self.fixed_dir, base)
        if os.path.isfile(fx):
            return fx
        return os.path.join(self.og_dir, rel)

    def out_smd_path(self, rel):
        """Path to write into the generated qc for an OG-relative smd reference."""
        abs_path = self.resolve_smd(rel)
        if self.args.copy_smd:
            dst = os.path.join(self.out_dir, rel.replace("\\", os.sep))
            os.makedirs(os.path.dirname(dst), exist_ok=True)
            if not os.path.isfile(dst) or self.args.force_copy:
                shutil.copyfile(abs_path, dst)
            return rel.replace("/", "\\")
        return os.path.relpath(abs_path, self.out_dir).replace("/", "\\")


# --------------------------------------------------------------------------------------------
# Detection
# --------------------------------------------------------------------------------------------

def detect_mode(qc, name):
    raw = qc.raw_text()
    acts = {b.activity() for b in qc.blocks("sequence") if b.activity()}
    has_ironsight = '$poseparameter "ironsight"' in raw
    if name.startswith("v_dual_"):
        return "dual"
    if not name.startswith("v_"):
        # shared animation-only models such as gesture_animations: no idle/pose surgery
        return "other"
    if "ACT_SHOTGUN_RELOAD_START" in acts or "ACT_VM_SHOTGUN_RELOAD" in acts:
        return "shell"
    if not has_ironsight:
        return "other"
    return "normal"


# --------------------------------------------------------------------------------------------
# Transform steps
# --------------------------------------------------------------------------------------------

def step_bbox(qc, ctx):
    """The $bbox is the viewmodel's render box, and a box that ends at eye height (the molotov's
    and the dynamite's, max z 0) had the whole viewmodel culled in GMod. A generous box costs
    nothing on a viewmodel (Lua sets the same bounds every frame, mcv_base_core/sh_vm.lua)."""
    if not ctx.name.startswith("v_"):
        return
    box = "$bbox -96 -96 -96 96 96 96"
    if qc.raw_sub(r'^\$bbox(\s+[-0-9.]+){6}', box, re.M) == 0:
        for i, it in enumerate(qc.items):
            if isinstance(it, str) and "$cdmaterials" in it:
                qc.items[i] = it.replace("$cdmaterials", box + "\n$cdmaterials", 1)
                break


def step_illumposition(qc, ctx):
    """Light every weapon from the model origin (the game's per-model value sits off in the
    arms and lights the gun unevenly in GMod)."""
    if qc.raw_sub(r'\$illumposition\s+[-0-9.]+\s+[-0-9.]+\s+[-0-9.]+', '$illumposition 0 0 0') == 0:
        for i, it in enumerate(qc.items):
            if isinstance(it, str) and "$modelname" in it:
                qc.items[i] = it.replace("\n", "\n$illumposition 0 0 0\n", 1)
                break


def _smd_first_frame(path):
    """bone name -> [x y z rx ry rz] of the first skeleton frame, plus whether every listed bone
    is constant over all frames."""
    lines = open(path, encoding="utf-8", errors="replace").read().split("\n")
    i = lines.index("nodes") + 1
    names = {}
    while lines[i].strip() != "end":
        q = lines[i].split()
        names[int(q[0])] = q[1].strip('"')
        i += 1
    i = lines.index("skeleton") + 1
    first, constant, frame = {}, {}, -1
    while True:
        q = lines[i].split()
        i += 1
        if not q:
            continue
        if q[0] == "end":
            break
        if q[0] == "time":
            frame += 1
            continue
        b = names[int(q[0])]
        v = [float(x) for x in q[1:7]]
        if frame == 0:
            first[b] = v
            constant[b] = True
        elif b in first and constant[b] and any(abs(a - c) > 1e-4 for a, c in zip(first[b], v)):
            constant[b] = False
    return first, constant


def step_fix_correctives(qc, ctx):
    """Crowbar's *_corrective_animation.smd files are subtracted from the delta animations to
    cancel the constant rotation it writes on the root-level bones (root, cam_driver, BaseRoot:
    -90 degrees each). On a few models (K-50M, K-50M VC, L1A1 SOG) Crowbar accumulated that
    angle per root bone instead (-90, -180, -270), so the subtraction left +180 degrees on
    BaseRoot, applied by both the walk and run layers, and the gun sat behind the camera. Where a
    corrective disagrees with a bone that is constant in its delta animation, the corrective is
    rewritten to that bone's value and the fixed file used instead."""
    fixed = 0
    for corr in sorted(glob.glob(os.path.join(ctx.og_dir, "*_anims", "*_corrective_animation.smd"))):
        anim = corr.replace("_corrective_animation", "")
        if not os.path.isfile(anim):
            continue
        cf, _ = _smd_first_frame(corr)
        af, const = _smd_first_frame(anim)
        wrong = [b for b, v in cf.items() if b in af and const.get(b) and any(abs(a - c) > 0.01 for a, c in zip(v[3:], af[b][3:]))]
        if not wrong:
            continue
        text = open(corr, encoding="utf-8", errors="replace").read()
        lines = text.split("\n")
        i = lines.index("nodes") + 1
        names = {}
        while lines[i].strip() != "end":
            q = lines[i].split()
            names[int(q[0])] = q[1].strip('"')
            i += 1
        i = lines.index("skeleton") + 1
        while lines[i].strip() != "end":
            q = lines[i].split()
            if q and q[0] != "time" and names[int(q[0])] in wrong:
                v = af[names[int(q[0])]]
                lines[i] = "%s %s" % (q[0], " ".join("%.6f" % x for x in v))
            i += 1
        os.makedirs(ctx.fixed_dir, exist_ok=True)
        with open(os.path.join(ctx.fixed_dir, os.path.basename(corr)), "w", encoding="utf-8", newline="\n") as f:
            f.write("\n".join(lines))
        fixed += 1
    if fixed:
        ctx.note("%d corrective animations rewritten to match their delta animation (Crowbar root bone rotation)" % fixed)


def step_glue_guns(qc, ctx):
    """The dual Blackhawk's guns are root-level bones of their own (BaseMesh, BaseLeftMesh, the
    hands' ikTargets under them) and its run layer carries them a constant 12 units away from
    the animated hands, the game's IK dragging the arms after them. Solving the arms onto the
    guns swung the upper arms 49 degrees and looked broken; instead the guns follow the hands:
    in every delta layer the gun bone is rewritten so the hand keeps the grip it has in the
    idle. Only root-level bones whose ikTargets all belong to one hand qualify (the revolvers'
    empty `Base` helper carries both hands' targets and is left to the IK bake). The rewritten
    layer goes to fixed_anims/ and step_bake_ik reads it from there (ctx.glued)."""
    import bake_ik
    raw = qc.raw_text()
    chains = dict(re.findall(r'^\$ikchain\s+"([^"]+)"\s+"([^"]+)"', raw, re.M))
    if not chains:
        return
    idle = qc.find_by_activity("ACT_VM_IDLE")
    base_anim = idle.anims()[0] if idle and idle.anims() else None
    base_block = qc.find("animation", base_anim) if base_anim else None
    if not base_block:
        return
    base_path = ctx.resolve_smd(base_block.path)
    if not os.path.isfile(base_path):
        return
    rules = re.findall(r'ikrule\s+"([^"]+)"\s+touch\s+"([^"]+)"', "\n".join(base_block.lines))
    nodes, bframes, _ = bake_ik.load_smd(base_path)
    byname = {n: b for b, (n, _) in nodes.items()}
    def top(b):
        while nodes[b][1] != -1:
            b = nodes[b][1]
        return b
    # gun root bone -> the hand glued to it
    guns = {}
    for chain, target in rules:
        hand = chains.get(chain)
        if hand not in byname or target not in byname:
            continue
        g = top(byname[target])
        if nodes[g][0] in ("root", "cam_driver", "BaseRoot") or g == top(byname[hand]):
            continue
        guns.setdefault(g, set()).add(byname[hand])
    guns = {g: hands.pop() for g, hands in guns.items() if len(hands) == 1}
    if not guns:
        return
    layered = set()
    for sq in qc.blocks("sequence"):
        if sq.name in ("walklayer", "runlayer", "walklayerironsight"):
            layered.update(sq.anims())
    base = bframes[0]
    wb = bake_ik.fk(nodes, {b: np.array(base[b]) for b in nodes})
    grip = {g: np.linalg.inv(wb[h]) @ wb[g] for g, h in guns.items()}
    ctx.glued = getattr(ctx, "glued", {})
    done = 0
    for b in qc.blocks("animation"):
        if b.name not in layered or not b.path:
            continue
        src = ctx.resolve_smd(b.path)
        if os.path.abspath(os.path.dirname(src)) == os.path.abspath(ctx.fixed_dir):
            ov = os.path.join(ctx.override_dir, os.path.basename(src))
            src = ov if os.path.isfile(ov) else os.path.join(ctx.og_dir, b.path.replace("\\", os.sep).replace("/", os.sep))
        if not os.path.isfile(src):
            continue
        corr = os.path.join(os.path.dirname(src), os.path.basename(src)[:-4] + "_corrective_animation.smd")
        if os.path.isfile(os.path.join(ctx.fixed_dir, os.path.basename(corr))):
            corr = os.path.join(ctx.fixed_dir, os.path.basename(corr))
        anodes, aframes, alines = bake_ik.load_smd(src)
        if set(anodes) != set(nodes):
            continue
        cframes = bake_ik.load_smd(corr)[1] if os.path.isfile(corr) else [{}]
        ref = {bb: np.zeros(6) for bb in nodes}
        ref.update(cframes[0])
        new_rows = {}
        worst = 0.0
        for fi, af in enumerate(aframes):
            pose = bake_ik.final_pose(nodes, base, ref, af)
            w = bake_ik.fk(nodes, pose)
            for g, h in guns.items():
                want = w[h] @ grip[g]
                worst = max(worst, float(np.linalg.norm(want[:3, 3] - w[g][:3, 3])))
                Rb = bake_ik.rmat(base[g][3:6])
                Rr = bake_ik.rmat(ref[g][3:6])
                Ra = Rr @ (Rb.T @ want[:3, :3])
                pos = ref[g][:3] + (want[:3, 3] - base[g][:3])
                new_rows[(fi, g)] = np.concatenate([pos, bake_ik.euler(Ra)])
        out = os.path.join(ctx.fixed_dir, os.path.basename(src))
        bake_ik.write_rows(alines, new_rows, out)
        ctx.glued[os.path.basename(src)] = out
        done += 1
        ctx.note("%s: %s glued to the hand (moved up to %.1f units)" % (
            b.name, ", ".join(nodes[g][0] for g in guns), worst))
    if done:
        ctx.note("guns glued to the hands in %d movement layers" % done)


def step_bake_ik(qc, ctx):
    """The game's viewmodels glue the hands to target bones on the gun with `$ikchain` +
    `ikrule ... touch` (273 of 278 models: the movement and prone layers, the duals' reloads and
    draws too). GMod's studiomdl strips the IK, so a hand drifts off the gun wherever a layer
    moves the gun (the Sterling's left hand off its magazine when sprinting, the dual Blackhawk's
    guns out of the hands). Every animation with a touch rule is solved per frame (two-bone IK,
    bake_ik.py) and the corrected arm rotations written to fixed_anims/, which resolve_smd
    prefers; the touch rules themselves go with the rest of the IK."""
    import bake_ik
    raw = qc.raw_text()
    chains = {}
    for m in re.finditer(r'^\$ikchain\s+"([^"]+)"\s+"([^"]+)"', raw, re.M):
        chains[m.group(1)] = m.group(2)
    if not chains:
        return
    # the idle the delta layers play over
    idle = qc.find_by_activity("ACT_VM_IDLE")
    base_anim = idle.anims()[0] if idle and idle.anims() else None
    base_block = qc.find("animation", base_anim) if base_anim else None
    base_path = ctx.resolve_smd(base_block.path) if base_block else None
    # Source solves IK on the final blended pose with the playing sequence's rules, so the idle's
    # touch rules also hold while a movement layer swings the gun: the layers over the idle get
    # the idle's rules on top of their own (the dual Blackhawk's run layer has none of its own)
    rule_re = re.compile(r'ikrule\s+"([^"]+)"\s+touch\s+"([^"]+)"(?:\s+contact\s+([\d.-]+))?(?:[^\n]*?range\s+([\d.-]+)\s+([\d.-]+)\s+([\d.-]+)\s+([\d.-]+))?')
    def touch_rules(lines, whole=False):
        # (chain, target, range, contact): the rule holds over `range start peak tail end` frames
        # only (a reload's hand is on the gun for part of it) and keeps the hand's offset from the
        # target as of the `contact` frame; the idle's rules inherited by a layer hold for the
        # whole layer (range None) with the offset of the idle pose (contact None)
        out = []
        for m in rule_re.finditer("\n".join(lines)):
            rng = None if whole or not m.group(4) else tuple(float(m.group(i)) for i in (4, 5, 6, 7))
            contact = None if whole or not m.group(3) else float(m.group(3))
            out.append((m.group(1), m.group(2), rng, contact))
        return out
    idle_rules = touch_rules(base_block.lines, True) if base_block else []
    layered = set()
    delta_anims = set()
    for sq in qc.blocks("sequence"):
        if sq.name in ("walklayer", "runlayer", "walklayerironsight") or "prone" in sq.name.lower():
            layered.update(sq.anims())
        if sq.has("delta"):
            delta_anims.update(sq.anims())
    done = 0
    worst = 0.0
    for b in qc.blocks("animation"):
        rules = touch_rules(b.lines, b.name in layered)
        if b.name in layered:
            rules = list(dict.fromkeys(rules + idle_rules))
        if not rules or not b.path:
            continue
        # always bake from the untouched animation (override or OG), never from a previous run's
        # fixed_anims copy: resolve_smd prefers fixed_dir, which once fed the stale output of a
        # wrong bake back in as the source and skipped it as "already baked"
        src = ctx.resolve_smd(b.path)
        if os.path.abspath(os.path.dirname(src)) == os.path.abspath(ctx.fixed_dir):
            ov = os.path.join(ctx.override_dir, os.path.basename(src))
            src = ov if os.path.isfile(ov) else os.path.join(ctx.og_dir, b.path.replace("\\", os.sep).replace("/", os.sep))
        # a layer step_glue_guns rewrote this run is the one to bake over; its corrective is
        # still the original's (next to the OG layer, or the rewritten one in fixed_anims)
        corr_src = src
        src = getattr(ctx, "glued", {}).get(os.path.basename(src), src)
        if not os.path.isfile(src):
            continue
        # chain bones: the ikchain's end bone and its two parents, from the smd's own hierarchy
        nodes = bake_ik.load_smd(src)[0]
        byname = {n: (i, par) for i, (n, par) in nodes.items()}
        ik = []
        cross = []
        for chain, target, rng, contact in rules:
            hand = chains.get(chain)
            if hand not in byname or target not in byname:
                continue
            # A dual's reloads tie the off hand to the hand doing the loading (the revolvers'
            # insert loops carry `ikrule "lhand" touch "hand_r"` and its mirror). Solving that
            # with two bones drags the whole arm after the other hand and reads wrong in game,
            # which is what MAX_PULL was added for; the short ones slip under its four units,
            # so a rule aimed at another chain's hand is left alone whatever the distance.
            if ctx.mode == "dual" and target in set(chains.values()) and target != hand:
                cross.append("%s -> %s" % (chain, target))
                continue
            lower = nodes[byname[hand][1]][0] if byname[hand][1] != -1 else None
            upper = nodes[byname[lower][1]][0] if lower and byname[lower][1] != -1 else None
            if upper and lower:
                ik.append((upper, lower, hand, target, rng, contact))
        if cross:
            ctx.note("%s: cross-hand touch rules left as animated (%s)" % (os.path.basename(src), ", ".join(cross)))
        if not ik:
            # an earlier run may have baked this one before the rules were reconsidered; its
            # copy has to go, since resolve_smd prefers fixed_anims over the source
            stale = os.path.join(ctx.fixed_dir, os.path.basename(src))
            if os.path.isfile(stale) and os.path.abspath(stale) != os.path.abspath(src):
                os.remove(stale)
                ctx.note("%s: dropped an earlier bake, it has no rules to solve now" % os.path.basename(src))
            continue
        # `delta` is declared on the sequence that plays the animation, not on the $animation
        # block; Crowbar's `subtract` on the block is the other mark of a delta layer. Treating a
        # delta layer as an absolute pose bakes a nonsense arm (hands off screen when walking).
        is_delta = b.has("subtract") or b.name in delta_anims
        if is_delta and not base_path:
            continue
        corr = os.path.join(os.path.dirname(corr_src), os.path.basename(corr_src)[:-4] + "_corrective_animation.smd")
        if not os.path.isfile(corr):
            corr = None
        elif os.path.isfile(os.path.join(ctx.fixed_dir, os.path.basename(corr))):
            corr = os.path.join(ctx.fixed_dir, os.path.basename(corr))
        out = os.path.join(ctx.fixed_dir, os.path.basename(src))
        # a dual holds a gun in each hand, so its rules are judged one hand at a time
        r = bake_ik.bake_animation(src, corr, base_path, ik, out, is_delta, ctx.warn,
                                   paired=ctx.mode != "dual")
        if r and os.path.isfile(out):
            done += 1
            worst = max(worst, r[0])
    if done:
        ctx.note("IK baked into %d animations (worst hand-target drift before %.1f units)" % (done, worst))


def step_paths(qc, ctx):
    n = qc.raw_sub(r'\$modelname\s+"weapons/', '$modelname "' + MODEL_PREFIX)
    if n == 0:
        ctx.warn("no $modelname weapons/ line found")
    step_illumposition(qc, ctx)
    step_bbox(qc, ctx)
    qc.raw_sub(r'\$cdmaterials\s+"models\\[Ww]eapons\\', '$cdmaterials "' + MATERIAL_PREFIX.replace("\\", "\\\\"))
    qc.raw_sub(r'\$includemodel\s+"weapons/gesture_animations\.mdl"', '$includemodel "%s"' % GESTURE_MODEL)
    # mesh / physics / any other smd referenced outside animation blocks
    def _fix(m):
        return '"%s"' % ctx.out_smd_path(m.group(1))
    qc.raw_sub(r'"([^"\n]+\.smd)"', _fix)
    # animation smd paths
    for b in qc.blocks("animation"):
        if b.path:
            b.path = ctx.out_smd_path(b.path)
    for b in qc.blocks("sequence"):
        for i, l in enumerate(b.lines):
            m = re.match(r'^"([^"]+\.smd)"$', l)
            if m:
                b.lines[i] = '"%s"' % ctx.out_smd_path(m.group(1))


def step_reconstruct_missing_anims(qc, ctx):
    """Crowbar 0.68 stops writing $animation blocks after an animation with `loop` (the block is
    left unterminated and every later definition is missing), while the sequences still refer to
    them by name and the SMDs are on disk. Recreate a plain definition for each such name."""
    defined = {b.name for b in qc.blocks("animation")}
    anim_dirs = []
    for b in qc.blocks("animation"):
        d = os.path.dirname(b.path.replace("/", "\\")) if b.path else ""
        if d and d not in anim_dirs:
            anim_dirs.append(d)
    first_seq = next((b for b in qc.blocks("sequence")), None)
    if first_seq is None:
        return
    made = []
    for seq in qc.blocks("sequence"):
        for a in seq.anims():
            if a in defined or a.lower().endswith(".smd"):
                continue
            path = None
            for d in anim_dirs:
                cand = os.path.normpath(os.path.join(ctx.out_dir, (d + "\\" + a + ".smd").replace("\\", os.sep)))
                if os.path.isfile(cand):
                    path = d + "\\" + a + ".smd"
                    break
            if path is None:
                ctx.warn("sequence %s uses animation %s which is neither defined nor on disk" % (seq.name, a))
                defined.add(a)
                continue
            lines = ["fps 30"]
            corr = a + "_corrective_animation"
            if corr in defined:
                lines.append('subtract "%s" 0' % corr)
            qc.insert_before(first_seq, Block("animation", a, path, lines))
            defined.add(a)
            made.append(a)
    if made:
        ctx.note("reconstructed %d $animation definitions Crowbar 0.68 dropped: %s" % (len(made), ", ".join(made[:12])))


def step_include(qc, ctx):
    qci = ctx.args.qci
    if not qci:
        # default: relative from out dir to <fixed_root>/<QCI_INCLUDE>
        qci_abs = os.path.join(ctx.args.fixed_root, QCI_INCLUDE)
        qci = os.path.relpath(qci_abs, ctx.out_dir).replace("\\", "/")
    line = '$include "%s"\n' % qci
    # after the last $bonemerge, else before $sectionframes, else before first block
    for i in range(len(qc.items) - 1, -1, -1):
        it = qc.items[i]
        if isinstance(it, str) and "$bonemerge" in it:
            idx = it.rfind("$bonemerge")
            end = it.find("\n", idx)
            qc.items[i] = it[:end + 1] + "\n" + line + it[end + 1:]
            return
    for i, it in enumerate(qc.items):
        if isinstance(it, str) and "$sectionframes" in it:
            qc.items[i] = it.replace("$sectionframes", line + "\n$sectionframes", 1)
            return
    ctx.warn("could not find a place for $include; prepended")
    qc.items.insert(0, line)


def step_strip_ik(qc, ctx):
    if ctx.args.keep_ik:
        return
    qc.raw_sub(r'^\$ikchain[^\n]*\n', '', flags=re.M)
    for b in qc.blocks():
        b.remove(lambda l: l.startswith("ikrule "))


def step_activities(qc, ctx):
    amap = dict(ACT_MAP_COMMON)
    if ctx.mode == "dual":
        amap.update(ACT_MAP_DUAL_SHELL if ctx.shell_dual else ACT_MAP_DUAL_MAG)
    for b in qc.blocks("sequence"):
        a = b.activity()
        if a and a in amap:
            b.set_activity(amap[a])
    for b in qc.blocks("sequence"):
        a = b.activity()
        if a and a not in GMOD_ACTS:
            ctx.warn("activity %s (sequence %s) is not a GMod activity; unreachable from Lua" % (a, b.name))


def step_sounds(qc, ctx):
    for b in qc.blocks("sequence"):
        for i, l in enumerate(b.lines):
            m = re.match(r'^\{ event 5004 (\d+) "([^"]+)" \}$', l)
            if m and not m.group(2).startswith("MCV_"):
                snd = m.group(2)
                if snd.startswith("Weapon_") or snd.startswith("Vietnam_"):
                    b.lines[i] = '{ event 5004 %s "MCV_%s" }' % (m.group(1), snd)


def is_static_pose_anim(b):
    return b.has("fps 0.5")


def step_static_anims(qc, ctx):
    """fps 0.5 pose animations -> single held frame at 30 fps."""
    for b in qc.blocks("animation"):
        if not is_static_pose_anim(b):
            continue
        b.remove_key("fps")
        hold = "frame 1 1" if re.search(r'ironsight(deploy)?$', b.name) else "frame 0 1"
        b.lines.insert(0, "numframes 60")
        b.lines.insert(0, hold)
        b.lines.insert(0, "fps 30")
        ctx.static_anims.add(b.name)


def step_equalize_static_blends(qc, ctx):
    """A sequence that blends one of the (now 60 frame) static poses with a shorter animation
    must have equal lengths; freeze the shorter partner on its first frame and extend it,
    exactly as the hand port did for deployed idles (deploy_a: frame 0 0, numframes 60)."""
    for seq in qc.blocks("sequence"):
        anims = seq.anims()
        if len(anims) < 2 or seq.has("delta"):
            continue
        if not any(a in ctx.static_anims for a in anims):
            continue
        for a in anims:
            if a in ctx.static_anims:
                continue
            ab = qc.find("animation", a)
            if ab is None or ab.has("numframes"):
                continue
            n = anim_length(qc, a, ctx)
            if n == 60:
                continue
            if n > 60:
                ab.lines.append("numframes 60")
            else:
                if not ab.has("frame"):
                    ab.lines.insert(0, "frame 0 0")
                ab.lines.append("numframes 60")
                ab.remove_key("loop")
            ctx.note("%s: extended to 60 frames to blend with a static pose in %s" % (a, seq.name))


def idle_trio(qc, ctx):
    """Names of the idle blend animations (basePose_a, ironsight_transition, ironsight) if present."""
    idle = qc.find_by_activity("ACT_VM_IDLE")
    if not idle:
        return None
    anims = idle.anims()
    if len(anims) == 2 and qc.find("animation", "ironsight"):
        return anims + ["ironsight"]
    return anims


def step_idle(qc, ctx):
    idle = qc.find_by_activity("ACT_VM_IDLE")
    if not idle:
        ctx.warn("no ACT_VM_IDLE sequence")
        return
    trio = idle_trio(qc, ctx)
    if trio and len(trio) == 3 and len(idle.anims()) == 2:
        idle.lines.insert(2, '"ironsight"')
        idle.remove_key("blend")
        idle.remove_key("blendwidth")
        idle.lines.insert(3, 'blend "ironsight" 0 1')
        idle.lines.insert(4, 'blendwidth 3')
    idle.remove(lambda l: l.startswith('blendlayer "ironsight_test"'))
    # equalise the lengths of the blended idle anims: 60 frames, no loop
    for a in idle.anims():
        b = qc.find("animation", a)
        if b is None:
            continue
        b.remove_key("loop")
        if not b.has("numframes"):
            b.lines.append("numframes 60")
    # the ironsight_test helper sequence is no longer referenced
    t = qc.find("sequence", "ironsight_test")
    if t:
        qc.items.remove(t)


def step_mode_idles(qc, ctx):
    """The launcher and rifle-grenade idles (gl, gren...) bring their aimed pose in with
    `blendlayer "<x>_ironsight_test" 0 0 1 0 poseparameter ironsight`. With start equal to end
    Source skips the ramp and plays the layer at full weight, so the gun sat in its sights the
    whole time the launcher was up. The aimed pose becomes a row of an ironsight blend on the
    sequence itself, like the main idle (step_idle)."""
    pat = re.compile(r'^blendlayer\s+"(\w+_ironsight_test)"\s+[-0-9.]+\s+[-0-9.]+\s+[-0-9.]+\s+[-0-9.]+.*poseparameter\s+ironsight')
    done = 0
    for sq in qc.blocks("sequence"):
        m = None
        for l in sq.lines:
            m = pat.match(l.strip())
            if m:
                break
        if not m:
            continue
        test = qc.find("sequence", m.group(1))
        if not test or not test.anims():
            continue
        aimed = test.anims()[0]
        anims = sq.anims()
        if aimed in anims:
            sq.remove(lambda l, pat=pat: pat.match(l.strip()) is not None)
            continue
        # the anims are the first lines of the block; the aimed pose goes after them
        sq.lines.insert(len(anims), '"%s"' % aimed)
        sq.remove_key("blend")
        sq.remove_key("blendwidth")
        sq.lines.insert(len(anims) + 1, 'blend "ironsight" 0 1')
        sq.lines.insert(len(anims) + 2, 'blendwidth %d' % (len(anims) + 1))
        sq.remove(lambda l, pat=pat: pat.match(l.strip()) is not None)
        for a in sq.anims():
            b = qc.find("animation", a)
            if b is None:
                continue
            b.remove_key("loop")
            if not b.has("numframes"):
                b.lines.append("numframes 60")
        if test in qc.items:
            qc.items.remove(test)
        done += 1
    if done:
        ctx.note("%d mode idle(s) blend their aimed pose on ironsight instead of a full-weight blendlayer" % done)


def step_counter_zero(qc, ctx):
    """A bullet-counter layer (BulletCounter*, blended on an ammo fraction) whose first knot,
    the empty magazine, still leaves a bullet bone showing while the model carries a deeper
    Bullet<NN+2> pose that hides them all (dual PPK: Bullet13 hides 7 of 8, Bullet15 all 8;
    dual Type 67 the same one step up) takes that deeper pose as its empty knot."""
    import bake_ik
    n = 0
    for sq in qc.blocks("sequence"):
        if not sq.name.lower().startswith("bulletcounter"):
            continue
        anims = sq.anims()
        if not anims:
            continue
        m = re.match(r'^(Bullet)(\d+)$', anims[0])
        if not m:
            continue
        deeper = "%s%02d" % (m.group(1), int(m.group(2)) + 2)
        first_b, deep_b = qc.find("animation", anims[0]), qc.find("animation", deeper)
        if first_b is None or deep_b is None:
            continue
        def hidden(b):
            src = ctx.resolve_smd(b.path)
            if not os.path.isfile(src):
                return -1
            nodes, frames, _ = bake_ik.load_smd(src)
            return sum(1 for bone, row in frames[0].items()
                       if nodes[bone][0].lower().startswith("bullet") and max(abs(float(v)) for v in row[:3]) > 0.05)
        if hidden(deep_b) > hidden(first_b) >= 0:
            i = sq.lines.index('"%s"' % anims[0])
            sq.lines[i] = '"%s"' % deeper
            n += 1
            # The counter's own knots are deltas confined to the magazine: each subtracts its
            # corrective and carries the layer's weightlist. The deeper pose is one the game's
            # counter never used, so Crowbar wrote it plain, and without those two lines its
            # whole raw pose became the layer's delta on every bone (the dual PPK's hands and
            # guns took a 90 degree whip at the last and second-to-last shot, and through the
            # reload). Carrying them over leaves just the extra hidden bullet.
            carried = []
            for key in ("subtract", "weightlist"):
                line = next((l for l in first_b.lines if l.strip().startswith(key + " ")), None)
                if line and not any(l.strip().startswith(key + " ") for l in deep_b.lines):
                    deep_b.lines.append(line.strip())
                    carried.append(line.strip())
            ctx.note("%s: empty knot %s -> %s (hides every bullet)%s" % (
                sq.name, anims[0], deeper,
                ("; %s carried over from %s" % (", ".join(c.split()[0] for c in carried), anims[0]))
                if carried else ""))
    return n


# Models whose idle must not be interpolated into. The sequence transitioner blends the whole
# pose over the fade, so a bone that changes hands exactly at that moment slides across it: the
# PTRD's bolt is thrown open by the shot's own SlideMovement layer (absolute, weightlisted) and
# then held open by the idle's SlidePosition layer (a delta on ammo_fraction), and the two
# crossfade past each other even though they agree on where the bolt ends up. `snap` drops the
# outgoing sequence outright (STUDIO_SNAP; a zero `fadein` does not stop it, see
# step_snap_draws). Per model, since it makes every animation that ends in the idle a hard cut.
SNAP_IDLE = {"v_ptrd41", "v_vcpistol"}

IDLE_ACTS = ("ACT_VM_IDLE", "ACT_VM_DEPLOY", "ACT_VM_IIDLE_M203")


def step_snap_idles(qc, ctx):
    """`snap` on the idles of the SNAP_IDLE models, so nothing blends into them."""
    if ctx.name not in SNAP_IDLE:
        return
    n = 0
    for b in qc.blocks("sequence"):
        if b.activity() in IDLE_ACTS and not b.has("snap"):
            b.lines.append("snap")
            n += 1
    if n:
        ctx.note("snap on %d idle sequences: nothing interpolates into the idle" % n)


def step_snap_draws(qc, ctx):
    """Throwables: the draw after a throw blended from the throw's end pose (hand out, empty)
    into the draw's first frame over the old sequence's fade-out, so the next grenade slid back
    into the hand. `snap` starts the draw on its own first frame (the sequence transitioner
    reads STUDIO_SNAP; a zero `fadein` does not stop it).

    Runs in every mode. A throwable has no `ironsight` pose parameter, so detect_mode calls it
    "other" and the mode-gated steps skip it; the throw activities below are the real guard."""
    acts = {b.activity() for b in qc.blocks("sequence")}
    # the grenade windup, which only a throwable has; melee models carry ACT_VM_THROW too
    # (it is their swing), so that activity cannot be part of the guard
    if not acts & {"ACT_VM_PULLBACK_HIGH", "ACT_VM_PULLBACK_LOW"}:
        return
    n = 0
    for b in qc.blocks("sequence"):
        if b.activity() in ("ACT_VM_DRAW", "ACT_VM_FIRSTDRAW", "ACT_VM_READY") and not b.has("snap"):
            b.lines.append("snap")
            n += 1
    if n:
        ctx.note("%d draw sequence(s) snap in (throwable)" % n)


def step_movement_layers(qc, ctx):
    """reloads: no sighted walk layer (the sights drop for a reload anyway)."""
    for b in qc.blocks("sequence"):
        a = b.activity() or ""
        if "RELOAD" in a and ("ACT_SHOTGUN" not in a):
            b.remove(lambda l: l == 'addlayer "walklayerironsight"')


def _two_rows(layer, hip_row, sighted_row):
    """Rebuild a movement layer as a player_movement x ironsight grid: row 0 (hip) and row 1
    (sights up), keeping its other options."""
    opts = [l for l in layer.opts() if not l.startswith('blend "ironsight"') and not l.startswith("blendwidth")]
    pm = [l for l in opts if l.startswith("blend ")]
    rest = [l for l in opts if not l.startswith("blend ")]
    layer.lines = ['"%s"' % a for a in hip_row + sighted_row] + pm + ['blend "ironsight" 0 1', "blendwidth %d" % len(hip_row)] + rest


def _rows(layer):
    """(hip row, sighted row) of a movement layer as authored: one axis = the same row twice."""
    anims = layer.anims()
    axes = [l for l in layer.lines if l.startswith("blend ")]
    if len(axes) >= 2 and len(anims) % 2 == 0:
        h = len(anims) // 2
        return anims[:h], anims[h:]
    return anims, anims


def step_belt_blank(qc, ctx):
    """The belt LMGs' "clamped*" bodygroups (the belt segment in the feed tray) ship with one
    submodel and no blank, so the belt could never be hidden; give them a blank so Lua can drop
    the belt with the last round (SWEP.BeltBodygroups)."""
    def _fix(m):
        body = m.group(2)
        if "blank" in body:
            return m.group(0)
        return m.group(1) + body.rstrip() + "\n\tblank\n}"
    n = 0
    for i, it in enumerate(qc.items):
        if isinstance(it, str) and '$bodygroup "clamped' in it:
            new = re.sub(r'(\$bodygroup\s+"clamped\d+"\s*\{)(.*?)\}', _fix, it, flags=re.S)
            if new != it:
                qc.items[i] = new
                n += 1
    if n:
        ctx.note("blank added to %d belt bodygroup(s)" % n)


def step_sighted_walk(qc, ctx):
    """Sighted walking sway like the game's. The game aims from its `ironsight_test` sequence,
    which carries `walklayerironsight` (walkIdle -> walk over 0..walk speed) instead of the
    hip's walklayer + runlayer. The port merges aiming into the idle through the `ironsight`
    pose, so the layers get that axis instead: walklayer and runlayer fade to their idle pose as
    the sights come up (a third of the models already had that row; the others had one axis and
    swayed as much aimed as from the hip), and walklayerironsight fades in (its hip row is the
    idle pose). Lua drives player_movement to a fraction of the sighted layer's top when aiming
    (MovementPoseSighted x SightedSwayFraction), so every gun sways the same, a little."""
    wl = qc.find("sequence", "walklayer")
    if wl is None or not wl.anims():
        return
    hip, _ = _rows(wl)
    idle_anim, walk_anim = hip[0], (hip[1] if len(hip) > 1 else None)
    _two_rows(wl, hip, [idle_anim] * len(hip))
    rl = qc.find("sequence", "runlayer")
    if rl is not None and rl.anims():
        rhip, _ = _rows(rl)
        _two_rows(rl, rhip, [rhip[0]] * len(rhip))
    wli = qc.find("sequence", "walklayerironsight")
    if wli is None:
        if walk_anim is None:
            return
        top = 130.0
        if rl is not None:
            m = re.search(r'blend\s+"player_movement"\s+(-?[\d.]+)', " ".join(rl.lines))
            if m:
                top = float(m.group(1))
        wli = Block("sequence", "walklayerironsight", None,
                    ['"%s"' % idle_anim, '"%s"' % walk_anim, 'blend "player_movement" 0 %g' % top, "blendwidth 2",
                     "delta", "fadein 0.2", "fadeout 0.2", "hidden", "realtime"])
        qc.insert_after(wl, wli)
        ctx.note("walklayerironsight built from the walk layer (0..%g)" % top)
    _, sighted = _rows(wli)
    _two_rows(wli, [sighted[0]] * len(sighted), sighted)
    # every sequence that walks at the hip also walks on the sights
    for b in qc.blocks("sequence"):
        layers = b.layers()
        if "walklayer" in layers and "walklayerironsight" not in layers:
            i = b.lines.index('addlayer "walklayer"')
            b.lines.insert(i + 1, 'addlayer "walklayerironsight"')


def make_len_variant(qc, ctx, anim_name, nframes, created):
    """Return the name of a copy of animation `anim_name` forced to `nframes` frames."""
    src = qc.find("animation", anim_name)
    if src is None:
        ctx.warn("base animation %s not defined as $animation; using as-is" % anim_name)
        return anim_name
    key = (anim_name, nframes)
    if key in created:
        return created[key]
    new_name = "%s__f%d" % (anim_name, nframes)
    # The frame count is meant at 30 fps (a 60-frame base is two seconds). Static poses come
    # out of Crowbar as "fps 1" (the PTRD's deploy_a: 5 frames), and a 60-frame variant at
    # 1 fps is a one-minute base, which stretched the PTRD's deployed shot to a minute.
    lines = [l for l in src.lines if not l.startswith("numframes") and not l.startswith("fps") and l != "loop"]
    lines.insert(0, "fps 30")
    lines.append("numframes %d" % nframes)
    nb = Block("animation", new_name, src.path, lines)
    qc.insert_after(src, nb)
    created[key] = new_name
    return new_name


def base_sequence_for(qc, ctx, act):
    """The idle sequence a delta layer with activity `act` was layered on in the original game."""
    want = BASE_IDLE_FOR.get(act, "ACT_VM_IDLE")
    if isinstance(want, str):
        want = (want,)
    for w in want:
        s = qc.find_by_activity(w)
        if s:
            return s
    return qc.find_by_activity("ACT_VM_IDLE")


def step_pose_split(qc, ctx):
    """Turn every delta sequence that carries an activity into main sequence + hidden pose layer."""
    created = {}
    targets = [b for b in qc.blocks("sequence") if b.activity() and b.has("delta")]
    prim = qc.find_by_activity("ACT_VM_PRIMARYATTACK")
    if prim and prim.has("delta") and prim.anims():
        ctx.primary_pose_len = anim_length(qc, prim.anims()[0], ctx)
    for seq in targets:
        act = seq.activity()
        base = base_sequence_for(qc, ctx, act)
        if base is None or not base.anims():
            ctx.warn("no base idle for %s; left as plain delta sequence" % seq.name)
            continue
        base_anims = list(base.anims())
        if len(base_anims) == 2 and base.activity() == "ACT_VM_IDLE" and qc.find("animation", "ironsight"):
            base_anims.append("ironsight")

        # Length of the base the pose layer plays over. `addlayer` layers run in sync with the
        # parent cycle, so the pose animation is stretched to this length.
        #   60        - hand-port behaviour (default; verified to look fine on nearly every gun)
        #   match     - exact length of the pose animation (authored timing, needs Lua retuning)
        #   normalize - same stretch ratio as the primary attack of this weapon; fixes the few
        #               guns whose deployed/cycle poses are far shorter than their hip shot
        pose_len = anim_length(qc, seq.anims()[0], ctx) if seq.anims() else 0
        if pose_len <= 0:
            nframes = 60
            ctx.warn("could not determine length of %s; using 60" % seq.name)
        elif act == "ACT_VM_PRIMARYATTACK_DEPLOYED" and ctx.args.base_len == "60" and ctx.primary_pose_len:
            # the deployed shot keeps its ratio to the hip shot (RPK / TUL-1 / DP-28 / M60: a 10
            # or 15 frame pose over a 60 frame base ran the bolt at a third of its speed)
            nframes = max(2, int(round(pose_len * 60.0 / ctx.primary_pose_len)))
        elif ctx.args.base_len == "match":
            nframes = pose_len
        elif ctx.args.base_len == "normalize":
            ref = ctx.primary_pose_len or pose_len
            nframes = max(2, round(pose_len * 60.0 / ref))
        else:
            nframes = 60

        # ---- pose layer: the original block, renamed and hidden -------------------------
        pose = seq
        pose_name = seq.name + "_pose"
        pose.name = pose_name
        events = pose.events()
        pose.remove(lambda l: l.startswith("{ event"))
        pose.remove_key("activity")
        pose.remove_key("fadein")
        pose.remove_key("fadeout")
        pose.remove_key("node")
        pose.remove_key("hidden")
        pose.remove_key("snap")
        # movement / bolt layers belong on the main sequence
        extra_layers = [l for l in pose.layers()]
        pose.remove(lambda l: l.startswith("addlayer "))
        pose.lines.append("snap")
        pose.lines.append("hidden")

        # ---- main sequence ----------------------------------------------------------------
        lines = []
        for a in base_anims:
            lines.append('"%s"' % make_len_variant(qc, ctx, a, nframes, created))
        lines.append('activity "%s" 1' % act)
        blends = [l for l in base.lines if l.startswith("blend ")]
        if not blends and len(base_anims) > 1:
            blends = ['blend "ironsight" 0 1']
        lines.extend(blends)
        if len(base_anims) > 1:
            # one row per blend axis: a two-axis idle (ironsight x revolver_firemode_pose, 9
            # anims) is a 3x3 grid; "blendwidth 9" made the ironsight axis run through all
            # nine poses and the revolvers went wild when aimed during the hammer animation
            # The ironsight axis always has three knots (basePose, transition, ironsight), so a
            # two-axis grid (x revolver_firemode_pose: 6 anims for the dual revolvers' two modes,
            # 9 for the single ones' three) is 3 wide. sqrt() gave 2 for the six-anim grid and
            # the rows slid: the sighted pose landed in the hip slot of the second mode, which
            # is why the dual revolvers fired with the aimed animation when not aiming.
            if len(blends) < 2:
                width = len(base_anims)
            elif len(base_anims) % 3 == 0:
                width = 3
            else:
                width = int(round(len(base_anims) ** 0.5))
            lines.append("blendwidth %d" % width)
        # the game's own snap is kept: the homemade pistol's bolt pull carries one, and blending
        # into it let the idle's magazine layer overlap the sequence's own override
        if act in FIRE_ACTS or base.has("snap") or pose.has("snap"):
            lines.append("snap")
        else:
            lines.append("fadein 0.1")
            lines.append("fadeout 0.2")
        for ev in events:
            if any(k in ev for k in LUA_HANDLED_EVENTS) and act in FIRE_ACTS:
                continue
            # the main sequence is nframes long; an event authored past that would be a compile error
            m = re.match(r'^\{ event (\S+) (\d+) (.*)$', ev)
            if m and int(m.group(2)) >= nframes:
                ev = "{ event %s %d %s" % (m.group(1), nframes - 1, m.group(3))
                ctx.note("%s: event %s moved from frame %s to %d" % (seq.name, m.group(1), m.group(2), nframes - 1))
            lines.append(ev)
        movement = [l for l in base.layers() if l in ("walklayer", "runlayer", "walklayerironsight")]
        for ml in movement:
            lines.append('addlayer "%s"' % ml)
        # bones the sequence's own layers drive outright (a weightlisted, non-delta layer such as
        # the homemade pistol's boltpull_magoverride on the Mag bone)
        owned = set()
        overrides = []
        for xl in extra_layers:
            bones = layer_owned_bones(qc, xl)
            owned |= bones
            if bones and xl not in movement:
                overrides.append(xl)
        for xl in extra_layers:
            if xl not in movement and xl not in overrides:
                lines.append('addlayer "%s"' % xl)
        for bl in base.layers():
            if bl not in movement and bl not in extra_layers and bl != pose_name:
                if owned and layer_delta_bones(qc, ctx, bl) & owned:
                    # the idle's delta layer would stack on the override (one slot too far)
                    ctx.note("%s: idle layer %s left off, its bones are driven by the sequence's own layer" % (seq.name, bl))
                    continue
                lines.append('addlayer "%s"' % bl)     # SlidePosition, BulletCounter, hammer layers
        lines.append('addlayer "%s"' % pose_name)
        # An override sets its bones outright, so it has to come after the pose delta: the game
        # plays the action as a delta over the idle with the override on top, and a layer added
        # before the delta is simply added to instead (the homemade pistol's harmonica took the
        # override's step and the pose layer's on top of it, a slot too far every shot).
        for xl in overrides:
            lines.append('addlayer "%s"' % xl)
        lines.append('node "0"')
        main = Block("sequence", seq.name if False else pose_name[:-5], None, lines)
        qc.insert_before(pose, main)
        ctx.note("%s: pose split, base %d frames%s" % (main.name, nframes, "" if nframes == pose_len else " (pose is %d)" % pose_len))


RECOIL_TAIL = 3          # knots easing the last frame back to rest
RECOIL_TAIL_POS = 0.1    # units, and degrees below: a residual smaller than this needs no tail
RECOIL_TAIL_ROT = 1.0


def _scale_toward(row, base, t):
    """The pose `t` of the way from `base` to `row` (t=0 is base), rotations scaled about the
    axis that separates them."""
    import numpy as np
    import bake_ik
    pos = [base[i] + (row[i] - base[i]) * t for i in range(3)]
    Rb = bake_ik.rmat(base[3:6])
    R = bake_ik.rmat(row[3:6]) @ Rb.T
    c = max(-1.0, min(1.0, (np.trace(R) - 1.0) / 2.0))
    ang = math.acos(c)
    if ang > 1e-6:
        axis = np.array([R[2][1] - R[1][2], R[0][2] - R[2][0], R[1][0] - R[0][1]])
        n = np.linalg.norm(axis)
        if n > 1e-9:
            axis = axis / n
            a = ang * t
            K = np.array([[0, -axis[2], axis[1]], [axis[2], 0, -axis[0]], [-axis[1], axis[0], 0]])
            R = np.eye(3) + math.sin(a) * K + (1 - math.cos(a)) * (K @ K)
        else:
            R = np.eye(3)
    else:
        R = np.eye(3)
    return list(pos) + list(bake_ik.euler(R @ Rb))


def recoil_tail_knots(qc, ctx, src, corrective, last):
    """Files for the eased tail of a recoil layer, or [] when the shot already ends at rest.
    Each is the source animation with frame `last` scaled back towards the corrective."""
    import numpy as np
    import bake_ik
    if corrective is None or not src.path:
        return []
    sp, cp = ctx.resolve_smd(src.path), ctx.resolve_smd(corrective.path)
    if not (os.path.isfile(sp) and os.path.isfile(cp)):
        return []
    nodes, frames, lines = bake_ik.load_smd(sp)
    cnodes, cframes, _ = bake_ik.load_smd(cp)
    names = {i: n for i, (n, _) in nodes.items()}
    cbyname = {cnodes[i][0]: cframes[0][i] for i in cframes[0]} if cframes else {}
    fi = min(last, len(frames) - 1)
    shared = [(b, names[b]) for b in frames[fi] if names.get(b) in cbyname]
    worst_p = worst_r = 0.0
    for b, nm in shared:
        row, base = frames[fi][b], cbyname[nm]
        worst_p = max(worst_p, max(abs(row[k] - base[k]) for k in range(3)))
        R = bake_ik.rmat(row[3:6]) @ bake_ik.rmat(base[3:6]).T
        c = max(-1.0, min(1.0, (np.trace(R) - 1.0) / 2.0))
        worst_r = max(worst_r, math.degrees(math.acos(c)))
    if worst_p < RECOIL_TAIL_POS and worst_r < RECOIL_TAIL_ROT:
        return []
    out = []
    for i in range(RECOIL_TAIL, 0, -1):
        t = i / float(RECOIL_TAIL + 1)
        rows = {(fi, b): _scale_toward(frames[fi][b], cbyname[nm], t) for b, nm in shared}
        name = "%s_tail%02d" % (os.path.basename(sp)[:-4], i)
        path = os.path.join(ctx.fixed_dir, name + ".smd")
        bake_ik.write_rows(lines, rows, path)
        out.append((name, os.path.relpath(path, ctx.out_dir).replace("/", "\\")))
    ctx.note("%s: recoil layer eased out over %d knots (it ends %.1f degrees, %.2f units from rest)"
             % (os.path.basename(sp), RECOIL_TAIL, worst_r, worst_p))
    return out


def step_pose_recoil(qc, ctx):
    """Optional: pose-parameter driven recoil layers for dual wield (see PORTING.md)."""
    if ctx.args.pose_recoil == "off":
        return
    if ctx.args.pose_recoil == "auto" and ctx.mode != "dual":
        return
    idle = qc.find_by_activity("ACT_VM_IDLE")
    if not idle:
        return
    # find the right/left primary fire pose layers produced by step_pose_split
    hands = {"r": "ACT_VM_PRIMARYATTACK", "l": "ACT_VM_SECONDARYATTACK"}
    if ctx.mode != "dual":
        hands = {"r": "ACT_VM_PRIMARYATTACK"}
    samples = ctx.args.recoil_samples
    added = []
    for hand, act in hands.items():
        main = qc.find_by_activity(act)
        if not main:
            continue
        pose = qc.find("sequence", main.name + "_pose")
        if not pose:
            continue
        anims = pose.anims()
        if not anims:
            continue
        length = anim_length(qc, anims[0], ctx)
        if length < 2:
            continue
        # sample frame indices
        idx = sorted({round(i * (length - 1) / (samples - 1)) for i in range(samples)})
        rows = []
        for src_name in anims[:2]:              # hip row, ironsight row (if present)
            src = qc.find("animation", src_name)
            if src is None:
                ctx.warn("recoil layer: %s is not an $animation" % src_name)
                rows = []
                break
            row = []
            subtract_lines = [l for l in src.lines if l.startswith("subtract")]
            for k in idx:
                nm = "rc_%s_%s_f%02d" % (hand, src_name, k)
                lines = ["fps 30", "frame %d %d" % (k, k)] + subtract_lines
                nb = Block("animation", nm, src.path, lines)
                qc.insert_after(src, nb)
                row.append(nm)
            corrective = qc.find("animation", src_name + "_corrective_animation")
            # a shot that ends away from rest gets a short eased tail, so the return is not
            # crammed into the last sample interval (see recoil_tail_knots)
            for tname, tpath in recoil_tail_knots(qc, ctx, src, corrective, idx[-1]):
                nm = "rc_%s_%s" % (hand, tname)
                lines = ["fps 30", "frame %d %d" % (idx[-1], idx[-1])] + subtract_lines
                qc.insert_after(src, Block("animation", nm, tpath, lines))
                row.append(nm)
            # trailing zero-delta pose so pose value 1.0 == rest: an animation minus itself
            zero_name = "rc_%s_%s_zero" % (hand, src_name)
            zero_src = corrective if corrective is not None else src
            zero_lines = ["fps 30", "frame 0 0", 'subtract "%s" 0' % zero_src.name]
            qc.insert_after(zero_src, Block("animation", zero_name, zero_src.path, zero_lines))
            row.append(zero_name)
            rows.append(row)
        if not rows:
            continue
        width = len(rows[0])
        seq_lines = []
        for row in rows:
            seq_lines.extend('"%s"' % n for n in row)
        seq_lines.append('blend "recoil_%s" 0 1' % hand)
        if len(rows) > 1:
            seq_lines.append('blend "ironsight" 0 1')
        seq_lines.append("blendwidth %d" % width)
        seq_lines.append("delta")
        seq_lines.append("hidden")
        layer = Block("sequence", "recoil_layer_%s" % hand, None, seq_lines)
        qc.insert_before(idle, layer)
        node_at = next((i for i, l in enumerate(idle.lines) if l.startswith("node")), len(idle.lines))
        idle.lines.insert(node_at, 'addlayer "recoil_layer_%s"' % hand)
        added.append(hand)
    if added:
        pp = "".join('$poseparameter "recoil_%s" 0 1 loop 0\n' % h for h in added)
        n = qc.raw_sub(r'(\$poseparameter "ironsight"[^\n]*\n)', r'\1' + pp)
        if n == 0:
            qc.items.insert(0, pp)
        ctx.note("pose recoil layers added for hands: %s" % ", ".join(added))


def layer_owned_bones(qc, lname):
    """Bones a non-delta layer sets outright: the weight-1 entries of the $weightlist its
    animations carry (empty for delta layers and layers without a weightlist)."""
    layer = qc.find("sequence", lname)
    if layer is None or layer.has("delta"):
        return set()
    raw = qc.raw_text()
    bones = set()
    for a in layer.anims():
        ab = qc.find("animation", a)
        if ab is None:
            continue
        for wl in re.findall(r'^\s*weightlist\s+"([^"]+)"', "\n".join(ab.lines), re.M):
            m = re.search(r'\$weightlist\s+"%s"\s*\{(.*?)\}' % re.escape(wl), raw, re.S)
            if m:
                bones |= {b for b, w in re.findall(r'"([^"]+)"\s+([\d.]+)', m.group(1)) if float(w) > 0}
    return bones


def layer_delta_bones(qc, ctx, lname):
    """Bones a delta layer moves: rows of its first animation's first frame that are not zero
    (root-level bones excluded, they carry Crowbar's corrective)."""
    import bake_ik
    layer = qc.find("sequence", lname)
    if layer is None:
        return set()
    bones = set()
    for a in layer.anims():
        ab = qc.find("animation", a)
        if ab is None or not ab.path:
            continue
        src = ctx.resolve_smd(ab.path)
        if not os.path.isfile(src):
            continue
        nodes, frames, _ = bake_ik.load_smd(src)
        for b, row in frames[0].items():
            name, par = nodes[b]
            if par == -1:
                continue
            if max(abs(float(v)) for v in row[:3]) > 0.01 or max(abs(float(v)) for v in row[3:6]) > 0.02:
                bones.add(name)
    return bones


def step_idle_layers(qc, ctx):
    """Rule from testing (Oct 2024): `loop` must not appear on any animation used by a pose-parameter
    driven layer that the idle sequence calls (slide position, hammer, bullet counter...), or the
    firing animations jerk. Also equalise blend lengths inside those layers (studiomdl requires it)."""
    idle = qc.find_by_activity("ACT_VM_IDLE")
    if not idle:
        return
    for lname in idle.layers():
        layer = qc.find("sequence", lname)
        if layer is None or not layer.has("blend") or layer.has("realtime"):
            continue          # walk/run layers are realtime movement layers, leave them alone
        anims = layer.anims()
        lens = {}
        for a in anims:
            ab = qc.find("animation", a)
            if ab is None:
                continue
            if ab.has("loop"):
                ab.remove_key("loop")
                ctx.note("removed loop from %s (used by idle layer %s)" % (a, lname))
            lens[a] = anim_length(qc, a, ctx)
        if len(set(lens.values())) > 1:
            target = max(lens.values())
            for a, n in lens.items():
                ab = qc.find("animation", a)
                if n != target and not ab.has("numframes"):
                    ab.lines.append("numframes %d" % target)
                    ctx.note("numframes %d on %s to match blend partners in %s" % (target, a, lname))


ANIMBLOCK_RE = re.compile(r'(?m)^[ \t]*(//[^\n]*(animblocksize|guess until further is known)[^\n]*|\$(animblocksize|sectionframes|bonesaveframe)\b[^\n]*)\n?')


def step_strip_animblocks(qc, ctx):
    """Keep every animation inside the .mdl.

    The current game models are compiled with $animblocksize / $sectionframes /
    $bonesaveframe, which Crowbar reproduces: the animation data past the first
    30-frame section goes into a .ani file and the engine falls back to the
    bind pose (or the saved zero frame) when a block is not resident. In GMod
    that showed up as every ported viewmodel frozen in its bind pose with the
    gun off-screen. The earlier working compiles had none of these, so drop them.
    """
    n = 0
    for i, it in enumerate(qc.items):
        if not isinstance(it, str):
            continue
        new, k = re.subn(ANIMBLOCK_RE, '', it)
        if k:
            qc.items[i] = new
            n += k
    if n:
        ctx.note("removed %d animblock/sectionframes/bonesaveframe lines; all animation data stays in the .mdl" % n)


def step_tidy(qc, ctx):
    # remove `node "0"` from hidden helper layers (harmless either way; matches hand port)
    for b in qc.blocks("sequence"):
        if b.has("hidden") and not b.has("realtime") and b.name.endswith("Movement"):
            b.remove_key("node")
    step_strip_animblocks(qc, ctx)


def step_validate(qc, ctx):
    """Blend length equality and missing files."""
    for b in qc.blocks("sequence"):
        anims = b.anims()
        if len(anims) > 1:
            lens = []
            for a in anims:
                lens.append(anim_length(qc, a, ctx))
            if len(set(lens)) > 1:
                # The original game's delta pose blends already had unequal lengths and compile
                # fine; only blends this script assembled (idle bases) must be equal.
                msg = "sequence %s blends animations of different lengths: %s" % (b.name, dict(zip(anims, lens)))
                touched = any(a in ctx.static_anims or a.endswith("__f%d" % lens[0]) for a in anims)
                if b.has("delta") or not touched:
                    ctx.note(msg)
                else:
                    ctx.warn(msg)
    for b in qc.blocks("animation"):
        p = os.path.normpath(os.path.join(ctx.out_dir, b.path.replace("\\", os.sep)))
        if not os.path.isfile(p):
            ctx.warn("missing smd: %s" % b.path)


# --------------------------------------------------------------------------------------------
# Worldmodels
# --------------------------------------------------------------------------------------------

# Hand-tuned ValveBiped.Bip01_R_Hand offsets from the hand port: x y z rx ry rz. The gun bone is
# re-parented under this bone so the world model bonemerges to the player's right hand. rx is
# the tilt that pitches the barrel up along the curve of the arms (China Lake uses 15).
HAND_DEFAULT = (-6, -1, -2, 0, 0, 180)
# Barrel pitch (degrees, positive = muzzle up) applied on top of the offset, computed from the
# model's own bone and mesh data by hand_with_tilt(); see PORTING.md "World models".
HAND_TILT = {
    "w_sks": 7.5,
}
# Every other world model takes its line from work/hand_offsets_derived.json: the game's own
# hand-relative weapon bone for the weapon's animation class (anim_prefix in the weapon script,
# the <prefix>_aim_idle of the player animation sets), inverted and calibrated on the AK-47's
# tuned line (H = H_ak47 * A_rifle * A_class^-1; reproduces the hand-tuned guns within a unit).
# Regenerate with work/derive_hand_offsets.py after decompiling the player animation models.
DERIVED_HANDS = os.path.join(HERE, "hand_offsets_derived.json")
HAND_OFFSETS = {
    "w_sks": (-10, -1, -2, 0, 0, 180),
    "w_ak47": (-6, -1, -3.25, 0, 0, 180),
    "w_amd65": (-6, -1, -3.25, 0, 0, 180),
    "w_car15": (-6, -1, -3.25, 0, 0, 180),
    "w_xm177": (-6, -1, -3.25, 0, 0, 180),
    "w_aps": (-3.5, -1, -1.5, 0, 0, 180),
    "w_mle1935": (-3.5, -1, -1.5, 0, 0, 180),
    "w_browning_auto": (-11, -1, -2, 0, 0, 180),
    "w_chinalake": (-10, -1, 0, 15, 0, 180),
    "w_mas38": (-7, -1, -2, 0, 0, 180),
}


# ---- small 3x3 matrix helpers (no numpy) ---------------------------------------------------
def _rx(a): c, s = math.cos(a), math.sin(a); return [[1, 0, 0], [0, c, -s], [0, s, c]]
def _ry(a): c, s = math.cos(a), math.sin(a); return [[c, 0, s], [0, 1, 0], [-s, 0, c]]
def _rz(a): c, s = math.cos(a), math.sin(a); return [[c, -s, 0], [s, c, 0], [0, 0, 1]]
def _mul(A, B): return [[sum(A[i][k] * B[k][j] for k in range(3)) for j in range(3)] for i in range(3)]
def _mv(A, v): return [sum(A[i][k] * v[k] for k in range(3)) for i in range(3)]
def _t(A): return [[A[j][i] for j in range(3)] for i in range(3)]
def _norm(v):
    l = math.sqrt(sum(a * a for a in v)) or 1.0
    return [a / l for a in v]
def _cross(a, b): return [a[1] * b[2] - a[2] * b[1], a[2] * b[0] - a[0] * b[2], a[0] * b[1] - a[1] * b[0]]
def _euler_matrix(x, y, z):
    """Source AngleMatrix for RadianEuler(x, y, z): Rz(yaw) * Ry(pitch) * Rx(roll)."""
    return _mul(_rz(z), _mul(_ry(y), _rx(x)))
def _matrix_euler(M):
    y = math.asin(max(-1.0, min(1.0, -M[2][0])))
    if abs(math.cos(y)) > 1e-6:
        x = math.atan2(M[2][1], M[2][2]); z = math.atan2(M[1][0], M[0][0])
    else:
        x = math.atan2(-M[1][2], M[1][1]); z = 0.0
    return x, y, z
def _axis_rot(n, a):
    x, y, z = n; c, s = math.cos(a), math.sin(a); C = 1 - c
    return [[c + x * x * C, x * y * C - z * s, x * z * C + y * s],
            [y * x * C + z * s, c + y * y * C, y * z * C - x * s],
            [z * x * C - y * s, z * y * C + x * s, c + z * z * C]]

# Crowbar writes $definebone rotations as (ry, rz, rx) in degrees; SMD skeleton lines are
# (rx, ry, rz) in radians. Verified against every bone of v_sks.
def _def_to_matrix(off):
    ry_, rz_, rx_ = (math.radians(v) for v in off[3:6])
    return _euler_matrix(rx_, ry_, rz_)
def _matrix_to_def(M):
    x, y, z = _matrix_euler(M)
    return [math.degrees(y), math.degrees(z), math.degrees(x)]


def _smd_root_frame_and_mesh(path):
    """Root bone (index 0) frame from an SMD plus its vertices (world space)."""
    frame = None; verts = []; sec = None
    with open(path, encoding="utf-8", errors="replace") as f:
        for line in f:
            t = line.split()
            if not t:
                continue
            if t[0] in ("nodes", "skeleton", "triangles"):
                sec = t[0]; continue
            if t[0] == "end":
                sec = None; continue
            if sec == "skeleton":
                if t[0] == "time":
                    if frame is not None:
                        break
                    continue
                if t[0] == "0":
                    frame = [float(x) for x in t[1:7]]
            elif sec == "triangles" and len(t) >= 10 and t[0].isdigit():
                verts.append((float(t[1]), float(t[2]), float(t[3])))
    return frame, verts


def _gun_axes(og_dir, raw_qc, ctx):
    """Barrel and up directions of the gun in its root bone's local space, from the reference
    SMD mesh and the muzzle attachment. Returns (fwd, up) unit vectors or None."""
    m = re.search(r'^\$bodygroup[^{]*\{\s*(?:blank\s*)?studio\s+"([^"]+)"', raw_qc, re.M | re.S)
    ref = m.group(1) if m else None
    if not ref:
        m = re.search(r'studio\s+"([^"]+\.smd)"', raw_qc)
        ref = m.group(1) if m else None
    if not ref:
        ctx.warn("tilt: no reference smd found")
        return None
    frame, verts = _smd_root_frame_and_mesh(os.path.join(og_dir, ref.replace("\\", os.sep)))
    if not frame or len(verts) < 10:
        ctx.warn("tilt: could not read the reference smd")
        return None
    gun = _euler_matrix(frame[3], frame[4], frame[5])
    gun_t = _t(gun); p = frame[0:3]
    loc = [_mv(gun_t, [v[0] - p[0], v[1] - p[1], v[2] - p[2]]) for v in verts]
    ext = [max(v[i] for v in loc) - min(v[i] for v in loc) for i in range(3)]
    fwd_axis = ext.index(max(ext))
    fwd = [0.0, 0.0, 0.0]; fwd[fwd_axis] = 1.0
    am = re.search(r'^\$attachment\s+"muzzle"\s+"[^"]+"\s+([-\d.]+)\s+([-\d.]+)\s+([-\d.]+)', raw_qc, re.M)
    mz = [float(am.group(i)) for i in (1, 2, 3)] if am else None
    if mz and mz[fwd_axis] < 0:
        fwd[fwd_axis] = -1.0
    # up: of the other two axes take the taller one. The bore sits above the grip bone, so the
    # muzzle attachment's offset on that axis points up; failing that, the grip/magazine hang
    # further below the bone than the sights rise above it.
    others = [i for i in range(3) if i != fwd_axis]
    up_axis = max(others, key=lambda i: ext[i])
    up = [0.0, 0.0, 0.0]
    if mz and abs(mz[up_axis]) > 0.3:
        up[up_axis] = 1.0 if mz[up_axis] > 0 else -1.0
    else:
        lo = min(v[up_axis] for v in loc); hi = max(v[up_axis] for v in loc)
        up[up_axis] = 1.0 if abs(lo) > abs(hi) else -1.0
    ctx.note("gun axes: barrel gun-local %s%s, up %s%s" % ("+-"[fwd[fwd_axis] < 0], "XYZ"[fwd_axis], "+-"[up[up_axis] < 0], "XYZ"[up_axis]))
    return fwd, up


def transform_anim_smds(qc, ctx, og_dir, raw_qc, tilt_deg, move):
    """Pitch the gun by tilt_deg (muzzle up) and shift it by `move` (gun-local units, forward /
    up / right) by rewriting the root bone's frames in every animation SMD the QC plays, and
    point the QC at the rewritten copies.

    With bonemerge the player's hand replaces the hand bone, so the gun's placement is the root
    gun bone's own transform from the animation. Editing the hand bone's $definebone does
    nothing for a merged model; the animation data has to move."""
    axes = _gun_axes(og_dir, raw_qc, ctx)
    if axes is None:
        return
    fwd, up = axes
    right = _norm(_cross(fwd, up))
    side = _norm(_cross(fwd, up))            # rotating about this axis moves the barrel toward up
    Rt = _axis_rot(side, math.radians(tilt_deg)) if tilt_deg else None
    shift = [move[0] * fwd[i] + move[1] * up[i] + move[2] * right[i] for i in range(3)] if move and any(move) else None
    done = 0
    for seq in qc.blocks("sequence"):
        for i, l in enumerate(seq.lines):
            m = re.match(r'^"([^"]+\.smd)"$', l)
            if not m:
                continue
            src_rel = m.group(1)
            src = os.path.normpath(os.path.join(ctx.out_dir, src_rel.replace("\\", os.sep)))
            if not os.path.isfile(src):
                continue
            base = os.path.basename(src)
            dst_rel = os.path.join(ctx.name + "_anims_tilted", base)
            dst = os.path.join(ctx.out_dir, dst_rel)
            os.makedirs(os.path.dirname(dst), exist_ok=True)
            with open(src, encoding="utf-8", errors="replace") as fi, open(dst, "w", encoding="utf-8", newline="\n") as fo:
                sec = None
                for line in fi:
                    t = line.split()
                    if t and t[0] in ("nodes", "skeleton", "triangles"):
                        sec = t[0]
                    elif t and t[0] == "end":
                        sec = None
                    elif sec == "skeleton" and len(t) == 7 and t[0] == "0":
                        pos = [float(x) for x in t[1:4]]
                        R = _euler_matrix(float(t[4]), float(t[5]), float(t[6]))
                        if Rt:
                            R = _mul(R, Rt)
                        if shift:
                            d = _mv(R, shift)
                            pos = [pos[k] + d[k] for k in range(3)]
                        x, y, z = _matrix_euler(R)
                        line = "    0 %f %f %f %f %f %f\n" % (pos[0], pos[1], pos[2], x, y, z)
                    fo.write(line)
            seq.lines[i] = '"%s"' % dst_rel.replace("/", "\\")
            done += 1
    ctx.note("tilt %g / move %s applied to %d animation smd(s) (root bone frames rewritten)" % (tilt_deg, move, done))


def hand_with_tilt(off, tilt_deg, og_dir, raw_qc, ctx):
    """Kept for reference: composes the pitch into the hand bone. Has no effect on a bonemerged
    model (see transform_anim_smds), so it is no longer used by the port."""
    axes = _gun_axes(og_dir, raw_qc, ctx)
    if axes is None:
        return off
    fwd, up = axes
    m = re.search(r'studio\s+"([^"]+\.smd)"', raw_qc)
    frame, _ = _smd_root_frame_and_mesh(os.path.join(og_dir, m.group(1).replace("\\", os.sep)))
    gun = _euler_matrix(frame[3], frame[4], frame[5])
    H = _def_to_matrix(off)
    G = _mul(_t(H), gun)
    side = _norm(_cross(_norm(_mv(G, fwd)), _norm(_mv(G, up))))
    Hn = _mul(H, _axis_rot(side, -math.radians(tilt_deg)))
    return list(off[:3]) + _matrix_to_def(Hn)


def port_worldmodel(args, og_dir):
    name = os.path.basename(og_dir.rstrip("/\\"))
    og_qc = os.path.join(og_dir, name + ".qc")
    if not os.path.isfile(og_qc):
        return {"name": name, "status": "skipped (no qc)"}
    out_dir = os.path.join(args.out, "weapons", name)
    os.makedirs(out_dir, exist_ok=True)
    ctx = Ctx(args, og_dir, out_dir)
    ctx.mode = "world"
    text = open(og_qc, encoding="utf-8", errors="replace").read().replace("\r\n", "\n")
    qc = QC(text)

    n = qc.raw_sub(r'\$modelname\s+"weapons[\\/]', '$modelname "weapons\\\\mcv\\\\')
    if n == 0:
        ctx.warn("no $modelname weapons\\ line found")
    step_illumposition(qc, ctx)
    step_bbox(qc, ctx)
    qc.raw_sub(r'\$cdmaterials\s+"models\\[Ww]eapons\\', '$cdmaterials "' + MATERIAL_PREFIX.replace("\\", "\\\\"))
    qc.raw_sub(r'"([^"\n]+\.smd)"', lambda m: '"%s"' % ctx.out_smd_path(m.group(1)))
    for b in qc.blocks("animation"):
        if b.path:
            b.path = ctx.out_smd_path(b.path)
    for b in qc.blocks("sequence"):
        for i, l in enumerate(b.lines):
            m = re.match(r'^"([^"]+\.smd)"$', l)
            if m:
                b.lines[i] = '"%s"' % ctx.out_smd_path(m.group(1))

    raw = qc.raw_text()
    if "Bip01_R_Hand" in raw:
        ctx.note("already has a ValveBiped.Bip01_R_Hand bone")
    else:
        # precedence: --hand/--tilt > per-weapon table > hand-tuned line in the fixed tree > default
        fixed_qc = os.path.join(args.fixed_root, "weapons", name, name + ".qc")
        hand_line = None
        off = None
        tilt = args.tilt if args.tilt is not None else HAND_TILT.get(name, 0)
        if tilt or (args.move and any(args.move)):
            transform_anim_smds(qc, ctx, og_dir, raw, tilt, args.move)
        derived = None
        if os.path.isfile(DERIVED_HANDS):
            derived = json.load(open(DERIVED_HANDS, encoding="utf-8")).get(name)
        if args.hand or name in HAND_OFFSETS:
            off = list(args.hand) if args.hand else list(HAND_OFFSETS.get(name, HAND_DEFAULT))
        elif derived:
            off = list(derived["hand"])
            ctx.note("hand bone derived from the game's %s animations (%s)" % (derived["prefix"], derived["anim"]))
        elif os.path.isfile(fixed_qc):
            m = re.search(r'^\$definebone\s+"ValveBiped\.Bip01_R_Hand"[^\n]*$', open(fixed_qc, encoding="utf-8", errors="replace").read(), re.M)
            if m:
                hand_line = m.group(0)
                ctx.note("hand bone reused from hand-ported qc")
        if hand_line is None and off is None:
            # the hand-ported QCs were removed from the tree; their hand bone lines live on here
            saved = os.path.join(HERE, "hand_bones.json")
            if os.path.isfile(saved):
                hand_line = json.load(open(saved, encoding="utf-8")).get(name)
                if hand_line:
                    ctx.note("hand bone reused from work/hand_bones.json")
        if hand_line is None:
            if off is None:
                off = list(HAND_DEFAULT)
                ctx.warn("no tuned hand offset for this model; using the default, check it in game")
            hand_line = '$definebone "ValveBiped.Bip01_R_Hand" "" %s 0 0 0 0 0 0' % " ".join("%g" % v for v in off)
            ctx.note("hand bone %s" % " ".join("%g" % v for v in off))
        # dual wield world models: bones for the left gun go under the left hand
        roots = re.findall(r'^\$definebone\s+"([^"]+)"\s+""', raw, re.M)
        left_roots = [r for r in roots if re.search(r'(_left|_l)$', r, re.I)]
        left_line = None
        if left_roots:
            if derived and derived.get("hand_left"):
                loff = list(derived["hand_left"])
                ctx.note("dual wield: left gun bones (%s) parented to a left hand derived from the game's animations" % ", ".join(left_roots))
            else:
                base = off if off is not None else list(HAND_DEFAULT)
                loff = [base[0], -base[1], base[2], base[3], base[4], base[5]]
                ctx.warn("dual wield: left gun bones (%s) parented to a mirrored left hand; tune in game" % ", ".join(left_roots))
            left_line = '$definebone "ValveBiped.Bip01_L_Hand" "" %s 0 0 0 0 0 0' % " ".join("%g" % v for v in loff)
        if not roots:
            ctx.warn("no root $definebone found; hand bone not added")
        else:
            for i, it in enumerate(qc.items):
                if isinstance(it, str) and "$definebone" in it:
                    def _reparent(m):
                        bone = m.group(2)
                        parent = "ValveBiped.Bip01_L_Hand" if bone in left_roots else "ValveBiped.Bip01_R_Hand"
                        return '%s"%s" "%s"' % (m.group(1), bone, parent)
                    new = re.sub(r'^(\$definebone\s+)"([^"]+)"\s+""', _reparent, it, flags=re.M)
                    idx = new.find("$definebone")
                    new = new[:idx] + hand_line + "\n" + (left_line + "\n" if left_line else "") + new[idx:]
                    qc.items[i] = new
                    break
            ctx.note("re-parented %s under the hand bone(s)" % ", ".join(roots))

    step_validate(qc, ctx)
    step_strip_animblocks(qc, ctx)
    out_qc = os.path.join(out_dir, name + ".qc")
    header = "// Generated by port_qc.py from %s (world model)\n" % os.path.relpath(og_qc, HERE).replace("\\", "/")
    with open(out_qc, "w", encoding="utf-8", newline="\n") as f:
        f.write(header + qc.render())
    result = {"name": name, "mode": "world", "qc": out_qc, "warnings": ctx.warnings, "notes": ctx.notes}
    if args.compile:
        result["compile"] = compile_qc(args, out_qc)
    return result


# --------------------------------------------------------------------------------------------
# Driver
# --------------------------------------------------------------------------------------------

# Plain bolt rifles whose game model has only the clip reload, and the sniper twin (same
# skeleton, the plain model's extra Grenade bone just keeps its bind pose) whose single-round
# loop they borrow. The MAS-36 pair has no twin with its rig. Nothing plays the borrowed loop
# now that the hybrid reload is gone; the step is kept because it is the only way back to a
# single-round reload on these three, and the animations cost nothing where they sit.
INSERT_DONORS = {
    "v_m38": "v_m38_s",
    "v_m91": "v_m38_s",
    "v_vz54": "v_vz54s",
}
INSERT_SEQUENCES = ("reload_start", "reload_start_empty", "reload_insert", "reload_end")


def borrow_inserts(text, name, og_dir, ctx):
    """Append the donor's single-round reload sequences and their $animation blocks to the qc
    text, before it is parsed, so every later step treats them like the model's own. The
    animation paths point into the donor's directory (relative to this model's)."""
    donor = INSERT_DONORS.get(name)
    if not donor or re.search(r'\$sequence\s+"reload_insert"', text):
        return text
    donor_qc = os.path.join(os.path.dirname(og_dir.rstrip("/\\")), donor, donor + ".qc")
    if not os.path.isfile(donor_qc):
        ctx.warn("insert donor %s has no qc" % donor)
        return text
    dsrc = open(donor_qc, encoding="utf-8", errors="replace").read().replace("\r\n", "\n")
    seqs = []
    anims = []
    for sq in INSERT_SEQUENCES:
        m = re.search(r'^\$sequence\s+"%s"\s*\{.*?^\}' % sq, dsrc, re.S | re.M)
        if not m:
            ctx.warn("insert donor %s lacks %s" % (donor, sq))
            return text
        seqs.append(m.group(0))
        anims += re.findall(r'^\s*"([^"\\]+)"\s*$', m.group(0), re.M)
    own = set(re.findall(r'^\$animation\s+"([^"]+)"', text, re.M))
    blocks = []
    for a in dict.fromkeys(anims):
        if a in own:
            continue
        m = re.search(r'^\$animation\s+"%s"\s+"([^"]+)"\s*\{.*?^\}' % re.escape(a), dsrc, re.S | re.M)
        if not m:
            ctx.warn("insert donor %s lacks animation %s" % (donor, a))
            return text
        rel = "..\\" + donor + "\\" + m.group(1).replace("/", "\\")
        blocks.append(m.group(0).replace('"%s"' % m.group(1), '"%s"' % rel, 1))
    ctx.note("single-round reload borrowed from %s (%d sequences, %d animations)" % (donor, len(seqs), len(blocks)))
    return text + "\n\n// single-round reload borrowed from " + donor + " (port_qc INSERT_DONORS)\n" + "\n\n".join(blocks + seqs) + "\n"


KEEP_MARK = "KEEP"


def kept_qc(args, name):
    """The generated qc for `name` if its first lines carry the KEEP marker: hand-edited, the
    port leaves it alone (and just compiles it)."""
    p = os.path.join(args.out, "weapons", name, name + ".qc")
    if not os.path.isfile(p):
        return None
    with open(p, encoding="utf-8", errors="replace") as f:
        head = "".join(f.readline() for _ in range(6))
    return p if KEEP_MARK in head else None


def port_one(args, og_dir):
    name = os.path.basename(og_dir.rstrip("/\\"))
    kept = kept_qc(args, name)
    if kept:
        r = {"name": name, "status": "kept (hand-edited qc)", "qc": kept, "notes": [], "warnings": []}
        if args.compile:
            r["compile"] = compile_qc(args, kept)
        return r
    if name.startswith("w_"):
        return port_worldmodel(args, og_dir)
    og_qc = os.path.join(og_dir, name + ".qc")
    if not os.path.isfile(og_qc):
        return {"name": name, "status": "skipped (no qc)"}
    out_dir = os.path.join(args.out, "weapons", name)
    os.makedirs(out_dir, exist_ok=True)
    ctx = Ctx(args, og_dir, out_dir)
    text = open(og_qc, encoding="utf-8", errors="replace").read().replace("\r\n", "\n")
    text = borrow_inserts(text, name, og_dir, ctx)
    qc = QC(text)
    ctx.mode = args.mode if args.mode != "auto" else detect_mode(qc, name)
    acts = {b.activity() for b in qc.blocks("sequence")}
    ctx.shell_dual = ctx.mode == "dual" and "ACT_SHOTGUN_RELOAD_START" in acts

    step_fix_correctives(qc, ctx)
    step_glue_guns(qc, ctx)
    step_bake_ik(qc, ctx)
    step_paths(qc, ctx)
    step_reconstruct_missing_anims(qc, ctx)
    step_include(qc, ctx)
    step_strip_ik(qc, ctx)
    step_activities(qc, ctx)
    step_sounds(qc, ctx)
    step_static_anims(qc, ctx)
    step_snap_draws(qc, ctx)   # throwables are mode "other" (no ironsight pose parameter)
    if ctx.mode != "other":
        step_idle(qc, ctx)
        step_mode_idles(qc, ctx)
        step_counter_zero(qc, ctx)
        step_movement_layers(qc, ctx)
    step_sighted_walk(qc, ctx)   # guards on a walklayer being present
    step_belt_blank(qc, ctx)
    step_equalize_static_blends(qc, ctx)
    step_idle_layers(qc, ctx)
    step_pose_split(qc, ctx)
    step_pose_recoil(qc, ctx)
    step_snap_idles(qc, ctx)
    step_tidy(qc, ctx)
    step_validate(qc, ctx)

    out_qc = os.path.join(out_dir, name + ".qc")
    header = "// Generated by port_qc.py from %s (mode: %s)\n" % (os.path.relpath(og_qc, HERE).replace("\\", "/"), ctx.mode)
    with open(out_qc, "w", encoding="utf-8", newline="\n") as f:
        f.write(header + qc.render())

    result = {"name": name, "mode": ctx.mode, "qc": out_qc, "warnings": ctx.warnings, "notes": ctx.notes}
    if args.compile:
        result["compile"] = compile_qc(args, out_qc)
    return result


def compile_qc(args, qc_path):
    game = args.game or os.path.join(HERE, "compile_test_game")
    if not os.path.isfile(os.path.join(game, "gameinfo.txt")):
        os.makedirs(game, exist_ok=True)
        gm = os.path.normpath(os.path.join(HERE, "..", "..", ".."))
        with open(os.path.join(game, "gameinfo.txt"), "w") as f:
            f.write('"GameInfo"\n{\n\tgame "mcv_compile_test"\n\ttype singleplayer_only\n\tFileSystem\n\t{\n'
                    '\t\tSteamAppId 4000\n\t\tSearchPaths\n\t\t{\n\t\t\tGame |gameinfo_path|.\n\t\t\tGame "%s"\n\t\t}\n\t}\n}\n' % gm)
    exe = args.studiomdl
    if not exe:
        exe = os.path.normpath(os.path.join(HERE, "..", "..", "..", "..", "bin", "studiomdl.exe"))
    cmd = [exe, "-game", game, "-nop4", qc_path]
    try:
        p = subprocess.run(cmd, capture_output=True, text=True, timeout=900, cwd=os.path.dirname(exe))
    except Exception as e:
        return {"ok": False, "error": str(e)}
    out = p.stdout + p.stderr
    ok = "Completed" in out and p.returncode == 0
    errs = [l for l in out.splitlines() if "ERROR" in l or "WARNING" in l or "error" in l.lower()][:20]
    return {"ok": ok, "returncode": p.returncode, "messages": errs}


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("source", help="OG weapon dir (MCV_SMD_OG/weapons/v_x) or the weapons root with --all")
    ap.add_argument("--all", action="store_true", help="port every v_* dir under source")
    ap.add_argument("--out", default=os.path.join(HERE, "MCV_SMD_PORT"), help="output root (default MCV_SMD_PORT)")
    ap.add_argument("--fixed-root", default=os.path.join(HERE, "MCV_SMD"),
                    help="hand-ported tree; used for the qci and per-weapon anims/ overrides")
    ap.add_argument("--qci", default=None, help="explicit $include path to write (default: relative path to fixed-root qci)")
    ap.add_argument("--mode", choices=["auto", "normal", "shell", "dual", "other"], default="auto")
    ap.add_argument("--base-len", choices=["60", "match", "normalize"], default="60",
                    help="length of the idle base under pose layers: 60 frames (hand port, default), "
                         "match the pose animation exactly, or normalize to the primary attack's stretch ratio "
                         "(for guns whose deployed/cycle poses play too slowly)")
    ap.add_argument("--pose-recoil", choices=["auto", "on", "off"], default="auto",
                    help="emit pose-parameter driven recoil layers (auto = dual wield only)")
    ap.add_argument("--recoil-samples", type=int, default=12, help="frames sampled per recoil layer")
    ap.add_argument("--keep-ik", action="store_true", help="keep $ikchain / ikrule lines")
    ap.add_argument("--copy-smd", action="store_true", help="copy smds next to the generated qc instead of referencing the OG tree")
    ap.add_argument("--force-copy", action="store_true")
    ap.add_argument("--compile", action="store_true", help="test-compile with studiomdl into a scratch game dir")
    ap.add_argument("--studiomdl", default=None)
    ap.add_argument("--game", default=None, help="scratch game dir for --compile")
    ap.add_argument("--report", default=None, help="write a json report here")
    ap.add_argument("--only", choices=["v", "w", "all"], default="all", help="with --all: viewmodels, worldmodels or both")
    ap.add_argument("--jobs", type=int, default=1, help="with --all: port/compile this many models in parallel")
    ap.add_argument("--hand", type=float, nargs=6, metavar=("X", "Y", "Z", "RX", "RY", "RZ"), default=None,
                    help="worldmodels: ValveBiped.Bip01_R_Hand offset (overrides the per-weapon table)")
    ap.add_argument("--tilt", type=float, default=None,
                    help="worldmodels: pitch the gun's barrel up by this many degrees (SKS: 7.5); applied to the animation data")
    ap.add_argument("--move", type=float, nargs=3, metavar=("FWD", "UP", "RIGHT"), default=None,
                    help="worldmodels: shift the gun in its own frame by these units; applied to the animation data")
    args = ap.parse_args()

    if args.all:
        prefixes = {"v": ("v_",), "w": ("w_",), "all": ("v_", "w_")}[args.only]
        shared = ("gesture_animations",) if args.only in ("v", "all") else ()
        dirs = sorted(d for d in (os.path.join(args.source, x) for x in os.listdir(args.source))
                      if os.path.isdir(d) and (os.path.basename(d).startswith(prefixes) or os.path.basename(d) in shared))
    else:
        dirs = [args.source]

    results = []
    if args.jobs > 1 and len(dirs) > 1:
        import concurrent.futures
        with concurrent.futures.ProcessPoolExecutor(max_workers=args.jobs) as ex:
            futures = {ex.submit(port_one, args, d): d for d in dirs}
            done = []
            for fut in concurrent.futures.as_completed(futures):
                try:
                    done.append(fut.result())
                except Exception as e:
                    done.append({"name": os.path.basename(futures[fut]), "status": "crashed: %s" % e, "warnings": []})
                r = done[-1]
                print("[%d/%d] %-32s %s" % (len(done), len(dirs), r["name"], r.get("status", "ok")), flush=True)
        results_iter = iter(sorted(done, key=lambda r: r["name"]))
    else:
        results_iter = (port_one(args, d) for d in dirs)
    for r in results_iter:
        results.append(r)
        status = r.get("status", "ok")
        comp = r.get("compile")
        comp_s = "" if comp is None else (" compile=OK" if comp.get("ok") else " compile=FAIL")
        print("%-32s %-7s %s%s  warnings=%d" % (r["name"], r.get("mode", "-"), status, comp_s, len(r.get("warnings", []))))
        for w in r.get("warnings", []):
            print("    ! " + w)
        if comp is not None and not comp.get("ok"):
            for m in comp.get("messages", [])[:8]:
                print("    # " + m)
    if args.report:
        with open(args.report, "w") as f:
            json.dump(results, f, indent=1)


if __name__ == "__main__":
    main()

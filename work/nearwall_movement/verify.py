"""Offline checks for the Vz 24 pilot. Does not load Garry's Mod."""
import json
from pathlib import Path
import subprocess
import struct
import sys
import tempfile

import numpy as np
from lupa import LuaRuntime

WORK = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(WORK))
import fix_nearwall_movement as fix
from fix_gyrojet_sprint import model_metadata
from glua_check import to_lua
import port_qc
import bake_ik as rig

ROOT = WORK.parent
nodes, _ = fix.load("basePose_a")
ids = {name: i for i, (name, _) in nodes.items()}
walk = fix.delta("walk_a", nodes)
report = {}
worst_old = 0
# Before the patch, ordinary safety walking was capped at pose 86, and used the
# hip walk delta on the lowered skeleton, without an IK solve in that base pose.
for source in ("nearwall_s_a", "nearwall_a", "nearwall_e_a"):
    _, baseframes = fix.load(source)
    for base in baseframes:
        wb = rig.fk(nodes, base)
        for movement in walk:
            pose = fix.add(base, movement, 86 / fix.WALK)
            w = rig.fk(nodes, pose)
            for side in ("r", "l"):
                hand, gun = ids["hand_" + side], ids["Base"]
                goal = w[gun] @ np.linalg.inv(wb[gun]) @ wb[hand]
                worst_old = max(worst_old, float(np.linalg.norm(w[hand][:3, 3] - goal[:3, 3])))
report["old_max_grip_error_at_pose_86"] = worst_old

before = port_qc.QC((fix.OUT / "v_vz24.before.qc").read_text())
after = port_qc.QC((fix.PORT / "v_vz24.qc").read_text())
changed = {"idletonearwall", "nearwall", "nearwalltoidle"}
for kind in ("sequence", "animation"):
    for old in before.blocks(kind):
        new = after.find(kind, old.name)
        assert new is not None
        if kind != "sequence" or old.name not in changed:
            assert new.render() == old.render(), (kind, old.name)
        else:
            assert new.activity() == old.activity() and new.events() == old.events()
            assert not any(x.startswith(("walklayer", "runlayer")) for x in new.layers())
            assert len(new.anims()) == fix.KNOTS * 2
unchanged_raw = after.raw_text().replace(
    "// BEGIN MCV SAFETY LOCOMOTION\n", "").replace("// END MCV SAFETY LOCOMOTION\n", "")
assert [s for s in before.raw_text().splitlines() if s.strip()] == [
    s for s in unchanged_raw.splitlines() if s.strip()]

lua = LuaRuntime()
lua.execute('''
    SWEP={}; CLIENT=false
    function Lerp(t,a,b) return a+(b-a)*t end
    function math.Clamp(v,a,b) return math.max(a,math.min(v,b)) end
    function SWEP:GetSafe() return self.safe end
''')
lua.execute(to_lua((ROOT / "lua/weapons/mcv_base_core/sh_think.lua").read_text()))
lua.execute('''
    SWEP.MovementPoseWalk=138; SWEP.MovementPoseSprint=233
    SWEP.safe=true
    assert(SWEP:GetMovementPose(SWEP.SpeedSprint,0)==86)
    SWEP.SafeMovementAnimations=true
    assert(SWEP:GetMovementPose(SWEP.SpeedSprint,0)==233)
    assert(SWEP:GetMovementPose(SWEP.SpeedRun,0)==100)
    assert(SWEP:GetMovementPose(0,0)==0)
    SWEP.safe=false
    assert(SWEP:GetMovementPose(SWEP.SpeedSprint,0)==233)
''')

# Compare compiled event/activity metadata and all pre-existing animation timings against
# the clean installed model from Git. New safety animations are the only additions.
rel = "models/weapons/mcv/v_vz24.mdl"
with tempfile.TemporaryDirectory() as tmp:
    baseline = Path(tmp) / "v_vz24.mdl"
    baseline.write_bytes(subprocess.check_output(["git", "show", "HEAD:" + rel], cwd=ROOT))
    old = model_metadata(baseline)
new = model_metadata(ROOT / rel)
assert old["sequences"] == new["sequences"], "compiled sequence events/activity changed"
new_anims = {row[0]: row for row in new["animations"]}
assert all(new_anims[row[0]] == row for row in old["animations"])
data = (ROOT / rel).read_bytes()
count, start = struct.unpack_from("<ii", data, 188)
for i in range(count):
    s = start + i * 212
    name_at = s + struct.unpack_from("<i", data, s + 4)[0]
    name = data[name_at:data.index(b"\0", name_at)].decode()
    if name in changed:
        assert struct.unpack_from("<i", data, s + 56)[0] == fix.KNOTS * 2
        assert struct.unpack_from("<ii", data, s + 68) == (fix.KNOTS, 2)
        assert struct.unpack_from("<4f", data, s + 84) == (0, 0, fix.SPRINT, 1)
for ext in (".mdl", ".vvd", ".dx80.vtx", ".dx90.vtx"):
    assert (ROOT / "models/weapons/mcv" / (fix.MODEL + ext)).read_bytes() == (
        WORK / "compile_test_game/models/weapons/mcv" / (fix.MODEL + ext)).read_bytes()
report["compiled_sequences_preserved"] = len(old["sequences"])
report["existing_animation_timings_preserved"] = len(old["animations"])
report["new_animations"] = len(new["animations"]) - len(old["animations"])
report["qc_changes_limited_to_three_nearwall_sequences_and_new_animations"] = True
report["lua_movement_mapping"] = "pilot reaches sprint; other models retain cap"
(fix.OUT / "checks.json").write_text(json.dumps(report, indent=2) + "\n")
print(json.dumps(report, indent=2))

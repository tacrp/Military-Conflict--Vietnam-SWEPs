"""Roll the accepted Vz 24 safety locomotion bake out to mounted viewmodels.

python work/build_safe_movement.py --jobs 6 --compile
Existing QCs are patched, never regenerated; original blocks are backed up for repeatable builds.
"""
import argparse
from functools import lru_cache
from concurrent.futures import ProcessPoolExecutor, as_completed
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import traceback
import tempfile
from types import SimpleNamespace

import numpy as np
from scipy.spatial.transform import Rotation

import bake_ik as rig
import fix_nearwall_movement as pilot
from fix_gyrojet_sprint import model_metadata
from pack_paths import asset_path, mounted_files
import port_qc as p

WORK = Path(__file__).resolve().parent
OUT = WORK / "safety_rollout"
PORT = WORK / "MCV_SMD_PORT/weapons"
BEGIN, END = "// BEGIN MCV SAFETY LOCOMOTION\n", "// END MCV SAFETY LOCOMOTION\n"
ACTS = {"ACT_VM_IDLE_TO_LOWERED", "ACT_VM_IDLE_LOWERED", "ACT_VM_LOWERED_TO_IDLE"}


@lru_cache(None)
def weapon_models():
    classes, references = {}, {}
    for path in list(mounted_files("lua/weapons", "*.lua")) + list(mounted_files("lua/weapons", "*/shared.lua")):
        text = path.read_text(errors="replace")
        base = re.search(r'SWEP.Base\s*=\s*"([^"]+)"', text)
        cls = path.parent.name if path.name == "shared.lua" else path.stem
        classes[cls] = base.group(1) if base else ""
        references[cls] = {m.lower() for m in re.findall(r'models/weapons/mcv/(v_[^" ]+)\.mdl', text)}
    def gun(cls, seen=None):
        if cls in ("mcv_base", "mcv_flamethrower"):
            return True
        seen = set() if seen is None else seen
        if cls in seen or cls not in classes:
            return False
        return gun(classes[cls], seen | {cls})
    used, guns = set(), set()
    for cls, models in references.items():
        used.update(models)
        if gun(cls):
            guns.update(models)
    return used, guns


def fk(nodes, pose):
    values = np.asarray(pose) if not isinstance(pose, dict) else np.array([pose[i] for i in nodes])
    local = np.tile(np.eye(4), (len(nodes), 1, 1))
    local[:, :3, :3] = Rotation.from_euler("xyz", values[:, 3:]).as_matrix()
    local[:, :3, 3] = values[:, :3]
    world = {}
    def get(i):
        if i not in world:
            parent = nodes[i][1]
            world[i] = local[i] if parent < 0 else get(parent) @ local[i]
        return world[i]
    for i in nodes:
        get(i)
    return world


rig.fk = fk


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def write_qc(path, text):
    # Avoid truncating a source QC if Windows rejects opening the existing file for write.
    temporary = path.with_suffix('.safe-movement.tmp')
    temporary.write_text(text, encoding='utf8', newline='\n')
    os.replace(temporary, path)


def verify_timings(name, before, after):
    qcpath = PORT / name / (name + '.qc')
    safety = {'@' + s.name for s in p.QC(qcpath.read_text()).blocks('sequence') if s.activity() in ACTS}
    original = {a[0]: a[1:] for a in before['animations']
                if not a[0].startswith('mcv_safe_') and a[0] not in safety}
    current = {a[0]: a[1:] for a in after['animations']}
    changed = {k: {'installed': v, 'rebuilt': current.get(k)}
               for k, v in original.items() if current.get(k) != v}
    if not changed:
        return {'matches_installed': True}
    # Some editable sources already differ from the last installed model. Compile the
    # untouched pre-migration QC against those same sources to distinguish those changes
    # from accidental changes introduced by this migration.
    backup = OUT / 'before_qc' / (name + '.qc')
    assert backup.exists(), (name, 'missing pre-migration QC')
    with tempfile.NamedTemporaryFile(mode='w', suffix='.qc', prefix='safety_baseline_',
                                     dir=qcpath.parent, encoding='utf8', delete=False) as file:
        file.write(backup.read_text())
        temporary = Path(file.name)
    baseline_game = WORK / 'compile_test_game/safety_baseline'
    try:
        result = p.compile_qc(SimpleNamespace(game=str(baseline_game), studiomdl=None), str(temporary))
        assert result['ok'], (name, 'baseline compile', result)
    finally:
        temporary.unlink()
    baseline = model_metadata(baseline_game / 'models/weapons/mcv' / (name + '.mdl'))
    reference = {a[0]: a[1:] for a in baseline['animations']}
    assert all(current.get(k) == reference.get(k) for k in original), (name, 'migration changed animation timing')
    return {'matches_installed': False, 'matches_pre_migration_sources': True, 'source_differences': changed}


class Model:
    def __init__(self, name, knots=17, reach_margin=None):
        self.name = name
        self.folder = PORT / name
        self.qcpath = self.folder / (name + ".qc")
        self.raw = self.qcpath.read_text()
        self.qc = p.QC(self.raw)
        self.cache = {}
        self.max_shift = 0.0
        self.max_error = 0.0
        self.max_between = 0.0
        self.worst_blend = None
        self.knots = knots
        self.reach_margin = reach_margin if reach_margin is not None else (0.5 if knots > 17 else 0.002)

    def anim(self, name):
        if name in self.cache:
            return self.cache[name]
        block = self.qc.find("animation", name)
        rel = block.path if block else name
        path = (self.folder / rel.replace("\\", "/")).resolve()
        nodes, raw, _ = rig.load_smd(path)
        arr = np.zeros((len(raw), len(nodes), 6))
        for fi, frame in enumerate(raw):
            for i, v in frame.items():
                arr[fi, i] = v
        if block and block.get("frame"):
            lo, hi = map(int, block.get("frame").split()[1:3])
            arr = arr[lo:hi + 1]
        fps = float((block.get("fps") if block else None or "fps 30").split()[1]) if block and block.get("fps") else 30
        self.cache[name] = nodes, arr, fps
        return nodes, arr, fps

    def delta(self, name):
        nodes, arr, fps = self.anim(name)
        block = self.qc.find("animation", name)
        ref = np.zeros((len(nodes), 6))
        if block and block.get("subtract"):
            corr, frame = re.match(r'subtract "([^"]+)" (\d+)', block.get("subtract")).groups()
            ref = self.anim(corr)[1][int(frame)]
        result = arr.copy()
        result[:, :, :3] -= ref[None, :, :3]
        for row in result:
            row[:, 3:] = (Rotation.from_euler("xyz", ref[:, 3:]).inv() *
                          Rotation.from_euler("xyz", row[:, 3:])).as_euler("xyz")
        return result, fps

    def solve(self, base, hip, walk, run, speed):
        sprint = float(np.clip((speed - self.walk) / (self.sprint - self.walk), 0, 1))
        carry = sprint
        walking = max(0, 1 - abs(speed - self.walk) / self.walk)
        pose = pilot.add(pilot.add(pilot.blend(base, hip, carry), walk, walking), run, sprint)
        wb, wh = fk(self.nodes, base), fk(self.nodes, hip)
        for side, gun, upper, lower, hand, attached in self.chains:
            grip = pilot.matrix_blend(np.linalg.inv(wb[gun]) @ wb[hand],
                                      np.linalg.inv(wh[gun]) @ wh[hand], carry)
            world = fk(self.nodes, pose)
            if attached:
                # Many dual rigs parent each gun to its hand: correct the gun offset,
                # never try to solve the arm towards a target descending from itself.
                desired = world[hand] @ np.linalg.inv(grip)
                parent = self.nodes[gun][1]
                local = np.linalg.inv(world[parent]) @ desired if parent >= 0 else desired
                pose[gun] = np.r_[local[:3, 3], rig.euler(local[:3, :3])]
            else:
                want = world[gun] @ grip
                shoulder = world[upper][:3, 3]
                length = np.linalg.norm(world[lower][:3, 3] - shoulder) + np.linalg.norm(
                    world[hand][:3, 3] - world[lower][:3, 3])
                distance = np.linalg.norm(want[:3, 3] - shoulder)
                reach_margin = self.reach_margin
                if distance >= length - reach_margin:
                    # Blending two valid carries can put the target just past arm reach.
                    # Translate the shoulder by the minimum excess rather than stretch bones.
                    shift = (want[:3, 3] - shoulder) / max(distance, 1e-9) * (distance - length + reach_margin)
                    parent = self.nodes[upper][1]
                    pose[upper, :3] += world[parent][:3, :3].T @ shift
                    self.max_shift = max(self.max_shift, float(np.linalg.norm(shift)))
                    world = fk(self.nodes, pose)
                ru, rl, _ = rig.solve_two_bone(world, self.nodes, pose, upper, lower, hand, want[:3, 3])
                pose[upper, 3:], pose[lower, 3:] = rig.euler(ru), rig.euler(rl)
                world = fk(self.nodes, pose)
                pose[hand, 3:] = rig.euler(world[lower][:3, :3].T @ want[:3, :3])
            world = fk(self.nodes, pose)
            error = np.linalg.norm((np.linalg.inv(world[gun]) @ world[hand])[:3, 3] - grip[:3, 3])
            self.max_error = max(self.max_error, float(error))
        return pose

    def setup(self):
        idle = self.qc.find_by_activity("ACT_VM_IDLE")
        run = self.qc.find("sequence", "runlayer")
        walk = self.qc.find("sequence", "walklayer")
        if not idle or not run or not walk:
            return False
        self.idle = idle
        self.nodes, _, _ = self.anim(idle.anims()[0])
        ids = {n.lower(): i for i, (n, _) in self.nodes.items()}
        self.walk, self.sprint = map(float, re.search(r'blend "player_movement" ([\d.]+) ([\d.]+)', run.render()).groups())
        self.walks, self.walk_fps = self.delta(walk.anims()[1])
        self.runs, self.run_fps = self.delta(run.anims()[1])
        self.chains = []
        for side, gun_name in (("r", "basemesh"), ("l", "baseleftmesh")):
            names = [x + "_" + side for x in ("upperarm", "lowerarm", "hand")]
            if not all(n in ids for n in names):
                continue
            gun = ids.get(gun_name, ids.get("base"))
            if gun is None:
                raise ValueError("no grip bone for " + side)
            upper, lower, hand = (ids[n] for n in names)
            parent = self.nodes[gun][1]
            attached = False
            while parent >= 0:
                if parent == hand:
                    attached = True
                parent = self.nodes[parent][1]
            self.chains.append((side, gun, upper, lower, hand, attached))
        if not self.chains:
            raise ValueError("no arm chains")
        return True

    def build(self):
        backup = OUT / "before_qc" / (self.name + ".qc")
        if BEGIN in self.raw and backup.exists():
            # Recover only our three replaced blocks, leaving other newer edits intact.
            original = p.QC(backup.read_text())
            for old in original.blocks("sequence"):
                if old.activity() in ACTS:
                    current = self.qc.find("sequence", old.name)
                    self.raw = self.raw.replace(current.render(), old.render(), 1)
            a, rest = self.raw.split(BEGIN, 1)
            _, b = rest.split(END, 1)
            self.raw = a + b
            self.qc = p.QC(self.raw)
        if self.name == "v_vz24":
            return {"model": self.name, "status": "accepted pilot", "safe": True,
                    "qc_sha256": digest(self.qcpath)}
        if self.name not in weapon_models()[1]:
            if self.qcpath.read_text() != self.raw:
                write_qc(self.qcpath, self.raw)
            return {"model": self.name, "status": "equipment: original animations", "safe": False,
                    "qc_sha256": digest(self.qcpath)}
        seqs = [s for s in self.qc.blocks("sequence") if s.activity() in ACTS]
        if not seqs:
            return {"model": self.name, "status": "no safety sequences", "safe": False}
        if not self.setup():
            return {"model": self.name, "status": "no movement layers", "safe": False}
        # Keep grids within 64 animations and at most 31 columns; the local compiler
        # crashed on our wider 33-column grids.
        rows = max(len(s.anims()) // (2 if 'blend "revolver_firemode_pose"' in s.render() else 1)
                   for s in seqs)
        self.knots = min(self.knots, 64 // rows)
        if not backup.exists():
            backup.parent.mkdir(parents=True, exist_ok=True)
            backup.write_text(self.raw, encoding="utf8")
        target = self.folder / "safe_anims"
        target.mkdir(exist_ok=True)
        generated, details = [], []
        for seq in seqs:
            old = seq.render()
            anames = seq.anims()
            modes = 'blend "revolver_firemode_pose"' in old
            # Source supports two blend axes. Safety forbids aiming; keep the revolver
            # mode axis (and all its grips), using its hip column instead of a third axis.
            if modes:
                rows = anames[::2]
                mode_count = len(rows)
                hip_width = len(self.idle.anims()) // mode_count
                hips = [self.idle.anims()[i * hip_width] for i in range(mode_count)]
                row_axis = next(l for l in seq.lines if l.startswith('blend "revolver_firemode_pose"'))
            else:
                rows = anames
                hips = [self.idle.anims()[0]] * len(rows)
                row_axis = 'blend "ironsight" 0 1' if len(rows) > 1 else None
            assert len(rows) <= 3, (self.name, seq.name, rows)
            names = []
            looping = seq.activity() == "ACT_VM_IDLE_LOWERED"
            for row, (anim, hipname) in enumerate(zip(rows, hips)):
                nodes, bases, base_fps = self.anim(anim)
                assert nodes == self.nodes, (self.name, anim, "skeleton mismatch")
                _, hipframes, _ = self.anim(hipname)
                duration = max(len(bases) - 1, 1) / base_fps
                tracks = []
                for k in range(self.knots):
                    speed = k * self.sprint / (self.knots - 1)
                    name = f"mcv_safe_{seq.name}_{row}_{k:02}"
                    names.append(name)
                    poses = []
                    for fi, base in enumerate(bases):
                        phase = fi / max(len(bases) - 1, 1)
                        wc = phase if looping else ((fi / base_fps) * self.walk_fps % (len(self.walks) - 1)) / (len(self.walks) - 1)
                        rc = phase if looping else ((fi / base_fps) * self.run_fps % (len(self.runs) - 1)) / (len(self.runs) - 1)
                        poses.append(self.solve(base, pilot.sample(hipframes, phase), pilot.sample(self.walks, wc),
                                                pilot.sample(self.runs, rc), speed))
                    tracks.append(poses)
                    temporary = target / (name + ".tmp.smd")
                    pilot.write_smd(temporary, self.nodes, poses)
                    os.replace(temporary, target / (name + ".smd"))
                    fps = base_fps
                    if looping:
                        w = min(speed / min(100, self.walk * 0.95), 1)
                        d = duration * (1 - w) + (len(self.walks) - 1) / self.walk_fps * w
                        s = float(np.clip((speed - self.walk) / (self.sprint - self.walk), 0, 1))
                        d = d * (1 - s) + (len(self.runs) - 1) / self.run_fps * s
                        fps = max(len(bases) - 1, 1) / d
                    opts = [f"fps {fps:.8f}"] + (["loop"] if looping else [])
                    generated.append(p.Block("animation", name, "safe_anims\\" + name + ".smd", opts).render())
                for k in range(self.knots - 1):
                    for fi in range(len(bases)):
                        a, b = fk(self.nodes, tracks[k][fi]), fk(self.nodes, tracks[k + 1][fi])
                        mid = fk(self.nodes, pilot.blend(tracks[k][fi], tracks[k + 1][fi], 0.5))
                        for _, gun, _, _, hand, _ in self.chains:
                            wanted = pilot.matrix_blend(np.linalg.inv(a[gun]) @ a[hand],
                                                        np.linalg.inv(b[gun]) @ b[hand], 0.5)
                            actual = np.linalg.inv(mid[gun]) @ mid[hand]
                            error = float(np.linalg.norm(actual[:3, 3] - wanted[:3, 3]))
                            if error > self.max_between:
                                self.max_between = error
                                self.worst_blend = (seq.name, row, k, fi, hand)
            opts = [l for l in seq.opts() if not l.startswith(("blend ", "blendwidth ", 'addlayer "walk', 'addlayer "run'))]
            seq.lines = [f'"{n}"' for n in names] + [f'blend "player_movement" 0 {self.sprint:g}'] + (
                [row_axis] if row_axis else []) + [f"blendwidth {self.knots}"] + opts
            self.raw = self.raw.replace(old, seq.render(), 1)
            details.append({"sequence": seq.name, "rows": len(rows), "mode_axis": modes})
        assert self.max_error < 0.02, (self.name, "grip", self.max_error)
        assert self.max_between < 0.25, (self.name, "blended grip", self.max_between, self.worst_blend)
        assert self.max_shift < 4, (self.name, "shoulder shift", self.max_shift)
        marker = '$sequence "' + seqs[0].name + '"'
        self.raw = self.raw.replace(marker, BEGIN + "\n".join(generated) + END + marker, 1)
        write_qc(self.qcpath, self.raw)
        return {"model": self.name, "safe": True, "status": "baked", "sequences": details,
                "max_grip_error": self.max_error, "max_blended_grip_error": self.max_between,
                "max_shoulder_shift": self.max_shift, "knots": self.knots,
                "reach_margin": self.reach_margin, "qc_sha256": digest(self.qcpath)}


def job(name, compile_model, dense=False):
    try:
        model = Model(name, knots=31 if dense else 17)
        report_path = OUT / "models" / (name + ".json")
        if report_path.exists():
            report = json.loads(report_path.read_text())
        else:
            report = {}
        if (report.get("qc_sha256") != digest(model.qcpath) or report.get("error")
                or (bool(report.get("safe")) != (name in weapon_models()[1]))):
            try:
                report = model.build()
            except AssertionError as error:
                if "blended grip" not in str(error):
                    raise
                for margin in (0.002, 0.25, 0.5):
                    try:
                        report = Model(name, knots=31, reach_margin=margin).build()
                        break
                    except AssertionError as retry_error:
                        if "blended grip" not in str(retry_error) or margin == 0.5:
                            raise
        report["qc_sha256"] = digest(model.qcpath)
        if compile_model:
            before = model_metadata(asset_path("models/weapons/mcv/" + name + ".mdl"))
            result = p.compile_qc(SimpleNamespace(game=str(WORK / "compile_test_game"), studiomdl=None), str(model.qcpath))
            report["compile"] = result
            assert result["ok"], result
            after = model_metadata(WORK / "compile_test_game/models/weapons/mcv" / (name + ".mdl"))
            assert before["sequences"] == after["sequences"], (name, "sequence events/activity changed")
            report["timing_check"] = verify_timings(name, before, after)
            report["compiled_sequence_count"] = len(after["sequences"])
        report_path.write_text(json.dumps(report, indent=2) + "\n")
        return report
    except Exception as error:
        failure = {"model": name, "error": repr(error), "traceback": traceback.format_exc()}
        (OUT / "models" / (name + ".json")).write_text(json.dumps(failure, indent=2) + "\n")
        return failure


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--models", nargs="*")
    ap.add_argument("--jobs", type=int, default=6)
    ap.add_argument("--compile", action="store_true")
    ap.add_argument("--dense", action="store_true", help="Start with the finer, bend-preserving carry bake")
    args = ap.parse_args()
    (OUT / "models").mkdir(parents=True, exist_ok=True)
    names = args.models or sorted({path.stem for path in mounted_files("models/weapons/mcv", "v_*.mdl")} & weapon_models()[0])
    rows = []
    with ProcessPoolExecutor(max_workers=args.jobs) as pool:
        futures = {pool.submit(job, name, args.compile, args.dense): name for name in names}
        for f in as_completed(futures):
            row = f.result()
            rows.append(row)
            print(f"[{len(rows)}/{len(names)}] {row['model']}: {row.get('error', row.get('status'))}", flush=True)
    (OUT / "latest.json").write_text(json.dumps(rows, indent=2) + "\n")
    failures = [r for r in rows if "error" in r]
    print(f"Finished {len(rows)} models; {len(failures)} failures", flush=True)
    if failures:
        raise SystemExit(1)


if __name__ == "__main__":
    main()

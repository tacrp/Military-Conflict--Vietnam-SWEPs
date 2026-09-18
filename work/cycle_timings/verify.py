"""Build real-input fixtures, then verify engine durations and compiled event phases.

python work/cycle_timings/verify.py --fixtures
python work/cycle_timings/verify.py
"""
import json
from pathlib import Path
import re
import struct
import sys
from types import SimpleNamespace

ROOT = Path(__file__).resolve().parents[2]
OUT = Path(__file__).resolve().parent
DATA = ROOT / "../../data/mcv_harness/p27018/results"
CASES = ("m37", "kar98", "m40", "type67", "vcpistol", "welrod")
manifest = json.loads((OUT / "manifest.json").read_text())
sys.path.insert(0, str(ROOT / "work"))
import port_qc
from pack_paths import asset_path


def fixtures():
    for lag in (0, 100):
        lines = ["cmd sv_cheats 1", "ccmd cl_showerror 0", "wait 0.4", f"ccmd net_fakelag {lag}", "wait 2",
                 'lua include("mcv_harness/cycle_timing.lua") MCVCycleTiming.Audit()',
                 'clua include("mcv_harness/cycle_timing.lua") MCVCycleTiming.Audit()']
        for gun in CASES:
            tag = f"{gun}_{lag}"
            lines += ['ccmd cl_showerror 0', 'wait 0.4', f'give mcv_{gun}' if lag == 0 else f'select mcv_{gun}', "wait 2.5",
                      f'lua MCVCycleTiming.Start(ply,"{tag}")', f'clua MCVCycleTiming.Start(ply,"{tag}")',
                      'ccmd cl_showerror 2', 'wait 0.4', 'tap +attack 0.15', 'wait 3.5',
                      'clua MCVCycleTiming.Finish()', 'lua MCVCycleTiming.Finish()']
        lines += ['ccmd net_fakelag 0', 'wait 1']
        (ROOT / f"work/tests/cycle_timing_{lag}.txt").write_text("\n".join(lines)+"\n")


def compiled_events():
    rows = []
    for spec in manifest:
        data = asset_path("models/weapons/mcv/" + spec["model"] + ".mdl").read_bytes()
        integer = lambda off: struct.unpack_from("<i",data,off)[0]
        string = lambda off: data[off:data.index(b"\0",off)].decode("ascii")
        count, offset = struct.unpack_from("<ii",data,188)
        for i in range(count):
            seq = offset+i*212
            if string(seq+integer(seq+4)) != spec["sequence"]:
                continue
            n,start = struct.unpack_from("<ii",data,seq+24)
            events = []
            for j in range(n):
                e = seq+start+j*80
                events.append((struct.unpack_from("<f",data,e)[0],string(e+12)))
            expected = [(int(m[1])/(spec["frames"]-1),m[2]) for e in spec["events"]
                        if (m := re.match(r'^\{ event \S+ (\d+) "(.*)"',e))]
            assert len(expected)==len(events), spec["model"]
            for phase, options in expected:
                assert any(o==options and abs(c-phase)<1e-6 for c,o in events), (spec["model"],options)
            rows.append({"model":spec["model"],"events":len(events),"duration":spec["duration"]})
    assert len(rows)==len(manifest)==19
    return rows


def porter_timings():
    # Exercise the production conversion without writing any editable QC/SMD.
    for spec in manifest:
        source = ROOT / "work/MCV_SMD_OG/weapons" / spec["model"]
        qc = port_qc.QC((source / (spec["model"] + ".qc")).read_text())
        ctx = port_qc.Ctx(SimpleNamespace(fixed_root=str(ROOT / "work/MCV_SMD"), base_len="60"),
                          str(source), str(source))
        seq = qc.find("sequence", spec["sequence"])
        seq.set_activity("ACT_VM_RELOAD_INSERT_PULL")
        port_qc.step_pose_split(qc, ctx)
        main = qc.find("sequence", spec["sequence"])
        for name in main.anims():
            anim = qc.find("animation", name)
            assert int(anim.get("numframes").split()[1]) == spec["frames"], spec["model"]
            assert float(anim.get("fps").split()[1]) == spec["fps"], spec["model"]
        assert main.events() == [e.replace('"MCV_', '"') for e in spec["events"]], spec["model"]
    return len(manifest)


def recordings():
    expected = {"models/weapons/mcv/"+r["model"]+".mdl": r["duration"] for r in manifest}
    report = []
    for lag in (0,100):
        for gun in CASES:
            pair = []
            for realm in ("server","client"):
                path = DATA/f"cycle_{gun}_{lag}_{realm}.json"
                result = json.loads(path.read_text())
                rows = result["rows"]
                assert sum(r["first"] for r in rows)==1, (path,len(rows))
                for row in rows:
                    assert row["rate"]==1 and abs(row["duration"]-expected[row["model"]])<1e-4
                assert not result["needCycle"]
                pair.append(result)
                (OUT/path.name).write_text(json.dumps(result,indent=2))
            # Tick-base corrections can move first-predicted time. The replayed DT
            # timeline must settle on the server start, with identical action length.
            assert abs(pair[0]["finalStart"]-pair[1]["finalStart"])<.002, (gun,lag,pair)
            assert pair[0]["clip"]==pair[1]["clip"]
            report.append({"gun":gun,"fakelag":lag,"duration":pair[0]["rows"][0]["duration"],
                           "clientPasses":len(pair[1]["rows"]),"clientServerAgree":True})
    for realm in ("server","client"):
        path = DATA/f"cycle_models_{realm}.json"
        data = json.loads(path.read_text())
        assert len(data)==19
        (OUT/path.name).write_text(json.dumps(data,indent=2))
    return report


if __name__ == "__main__":
    if "--fixtures" in sys.argv:
        fixtures()
    else:
        report={"compiled":compiled_events(),"porterModels":porter_timings(),"realInput":recordings(),"passed":True}
        (OUT/"verification.json").write_text(json.dumps(report,indent=2))
        print(json.dumps(report,indent=2))

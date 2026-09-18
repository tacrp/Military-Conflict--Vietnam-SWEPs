"""Check the ported events and the real-input harness recordings.

Run from the addon root after type67_timing.txt and type67_timing_lag.txt:
    python work/type67_timing/verify.py
"""
import json
from pathlib import Path
import re
import struct
import sys
from types import SimpleNamespace

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "work"))
import port_qc
from build_hammer_events import read_events

OUT = Path(__file__).resolve().parent
DATA = ROOT / "../../data/mcv_harness/p27018/results"


def check_model():
    source = ROOT / "work/MCV_SMD_OG/weapons/v_type67"
    qc = port_qc.QC((source / "v_type67.qc").read_text())
    ctx = port_qc.Ctx(SimpleNamespace(fixed_root=str(ROOT / "work/MCV_SMD"), base_len="60"),
                      str(source), str(source))
    # Exercise the porter on the real source without regenerating the editable QC.
    original = qc.find("sequence", "boltpull").events()
    qc.find("sequence", "boltpull").set_activity("ACT_VM_RELOAD_INSERT_PULL")
    port_qc.step_pose_split(qc, ctx)
    expected = qc.find("sequence", "boltpull").events()
    shipped_qc = port_qc.QC((ROOT / "work/MCV_SMD_PORT/weapons/v_type67/v_type67.qc").read_text())
    actual = shipped_qc.find("sequence", "boltpull").events()
    assert [e.replace('"MCV_', '"') for e in actual] == expected
    data = (ROOT / "models/weapons/mcv/v_type67.mdl").read_bytes()
    integer = lambda off: struct.unpack_from("<i", data, off)[0]
    string = lambda off: data[off:data.index(b"\0", off)].decode("ascii")
    count, offset = struct.unpack_from("<ii", data, 188)
    compiled = []
    for i in range(count):
        seq = offset + i * 212
        if string(seq + integer(seq + 4)) != "boltpull":
            continue
        n, start = struct.unpack_from("<ii", data, seq + 24)
        for j in range(n):
            event = seq + start + j * 80
            compiled.append((struct.unpack_from("<f", data, event)[0], string(event + 12)))
    assert len(compiled) == len(original) == 4
    for event in original:
        match = re.match(r'^\{ event \S+ (\d+) "(.*)" \}', event)
        frame, options = int(match[1]), match[2]
        cycle = next(c for c, o in compiled if o.removeprefix("MCV_") == options)
        assert abs(cycle - frame / 29) < 1e-6
    assert abs(read_events(ROOT / "models/weapons/mcv/v_type67.mdl")["boltpull"][0] - 10 / 29) < 1e-6
    return compiled


def check_recording(tag):
    report = {}
    for realm in ("server", "client"):
        path = DATA / f"type67_{tag}_{realm}.json"
        d = json.loads(path.read_text())
        assert d["handlesHammer"]
        rows = d["rows"]
        starts = sorted({r["start"] for r in rows if r["sequence"] == "boltpull"})
        assert len(starts) == 2, (tag, realm, starts)
        report[realm] = []
        for start in starts:
            cycle = [r for r in rows if r["sequence"] == "boltpull" and r["start"] == start]
            due = cycle[0]["duration"] * 10 / 29
            before = [r for r in cycle if 0.05 < r["elapsed"] < due - 0.025]
            after = [r for r in cycle if due + 0.03 < r["elapsed"] < due + 0.15]
            assert before and after
            assert all(r["needCycle"] for r in before), (tag, realm, "early cock")
            assert all(not r["needCycle"] for r in after), (tag, realm, "late cock")
            visual = [r for r in cycle if r["kind"] == "render"]
            if realm == "client":
                assert visual
                assert all(r["hammer"] == 1 for r in before if r["kind"] == "render")
                assert all(r["hammer"] == 0 for r in after if r["kind"] == "render")
                ejections = [r for r in cycle if r["kind"] == "eject"]
                assert len(ejections) == 1, (tag, "eject count", len(ejections))
                eject = ejections[0]
                previous = [r for r in visual if r["time"] < eject["time"] - 1e-5]
                assert previous
                # Animation events dispatch on rendered frames. A slow frame may cross
                # the cue by several ticks; it must be the first frame crossing it.
                assert previous[-1]["cycle"] < 11 / 29 <= eject["cycle"]
            report[realm].append({"start": start, "hammerAt": due,
                "ejectAt": [r["elapsed"] for r in cycle if r["kind"] == "eject"]})
        if tag == "fixed":
            reload = [r for r in rows if r["sequence"] == "reload_empty"]
            assert reload
            due = reload[0]["duration"] * 60 / 79
            assert any(r["emptyReload"] for r in reload if r["elapsed"] < due - 0.03)
            assert all(not r["emptyReload"] for r in reload if r["elapsed"] > due + 0.03)
        (OUT / path.name).write_text(json.dumps(d, separators=(",", ":")))
    assert all(abs(a["start"] - b["start"]) < 0.02
               for a, b in zip(report["server"], report["client"]))
    return report


def check_dual():
    result = {}
    for realm in ("server", "client"):
        path = DATA / f"type67_dual_{realm}.json"
        data = json.loads(path.read_text())
        rows = data["rows"]
        assert all(r["akimbo"] for r in rows)
        assert rows[0]["clip"] - rows[-1]["clip"] == 2
        assert not rows[-1]["needCycle"]
        assert not any(r["sequence"] == "boltpull" for r in rows)
        result[realm] = {"shots": 2, "actionReady": True}
        (OUT / path.name).write_text(json.dumps(data, separators=(",", ":")))
    return result


if __name__ == "__main__":
    report = {"compiled": check_model(), "fixed": check_recording("fixed"),
              "lag100": check_recording("lag100"), "dual": check_dual(), "passed": True}
    (OUT / "verification.json").write_text(json.dumps(report, indent=2))
    print(json.dumps(report, indent=2))

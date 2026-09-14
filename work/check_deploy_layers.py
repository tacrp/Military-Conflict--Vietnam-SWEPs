"""Check the installed MDL autolayer tables against the existing, patched QCs.

Source layout: ValveSoftware/source-sdk-2013/src/public/studio.h:
mstudioseqdesc_t (212 bytes), mstudioautolayer_t (24 bytes), studiohdr_t v48/v49.
"""
from pathlib import Path
import json
import re
import struct

from build_deploy_layers import ADDON, HERE, OUT, BUNDLES, UNUSED_TEST_MODELS, patch_text
from port_qc import QC, is_deploy_activity, DEPLOY_MOVEMENT_LAYERS


def sequences(path):
    data = path.read_bytes()
    integer = lambda at: struct.unpack_from("<i", data, at)[0]

    def string(at):
        return data[at:data.index(b"\0", at)].decode("ascii")

    assert data[:4] == b"IDST" and integer(4) in (48, 49), path
    count, start = struct.unpack_from("<ii", data, 188)
    assert 0 < count < 4096 and start + 212 * count <= len(data), path
    blocks = [start + i * 212 for i in range(count)]
    labels = [string(at + integer(at + 4)) for at in blocks]
    rows = {}
    for label, at in zip(labels, blocks):
        n, relative = struct.unpack_from("<ii", data, at + 148)
        assert 0 <= n < 256 and (not n or at + relative + n * 24 <= len(data)), (path, label)
        indices = [struct.unpack_from("<h", data, at + relative + i * 24)[0] for i in range(n)]
        assert all(0 <= i < count for i in indices), (path, label, indices)
        rows[label.lower()] = [labels[i].lower() for i in indices]
    return rows


def main():
    builds = json.loads((OUT / "build.json").read_text())
    required = {path.stem for path in (OUT / "before_qc/MCV_SMD_PORT/weapons").glob("v_*/*.qc")
                if path.stem not in UNUSED_TEST_MODELS}
    assert required <= {row["model"] for row in builds if row["ok"]}, "Incomplete build report"
    results = []
    for build in builds:
        name = build["model"]
        if name in UNUSED_TEST_MODELS:
            continue
        assert build["ok"], name
        qc = HERE / "MCV_SMD_PORT/weapons" / name / f"{name}.qc"
        backup = OUT / "before_qc" / qc.relative_to(HERE)
        assert patch_text(backup.read_bytes().decode("utf-8"))[0].encode("utf-8") == qc.read_bytes(), name
        mdl = ADDON / "models/weapons/mcv" / f"{name}.mdl"
        compiled = sequences(mdl)
        draws = []
        preserved = 0
        for block in QC(qc.read_text(encoding="utf-8")).blocks("sequence"):
            expected = [m.group(1).lower() for line in block.lines
                        if (m := re.match(r'^(?:addlayer|blendlayer)\s+"([^\"]+)"', line))]
            actual = compiled[block.name.lower()]
            assert actual == expected, (name, block.name, actual, expected)
            if is_deploy_activity(block.activity()):
                assert not DEPLOY_MOVEMENT_LAYERS.intersection(actual), (name, block.name)
                draws.append(block.name)
            else:
                preserved += len(DEPLOY_MOVEMENT_LAYERS.intersection(actual))
        results.append({"model": name, "draws": draws, "movement_layers_on_other_sequences": preserved})
    for name in BUNDLES:
        qc = HERE / "MCV_SMD/weapons" / name / f"{name}.qc"
        backup = OUT / "before_qc" / qc.relative_to(HERE)
        assert patch_text(backup.read_bytes().decode("utf-8"))[0].encode("utf-8") == qc.read_bytes(), qc
    (OUT / "validation.json").write_text(json.dumps(results, indent=2) + "\n")
    print(f"{len(results)} installed models; {sum(len(row['draws']) for row in results)} draws checked; "
          "all compiled layers match their QCs and all other QC content is unchanged")


if __name__ == "__main__":
    main()

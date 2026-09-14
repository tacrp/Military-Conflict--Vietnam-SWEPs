"""Remove only draw movement-layer lines from existing QCs, then rebuild them.

No mesh/animation regeneration: retain hand edits, corrective layers and timings.
Usage: python work/build_deploy_layers.py [--apply] [--compile] [--jobs 4]
"""
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
import argparse
import hashlib
import json
import re
import shutil
import subprocess

from port_qc import BLOCK_RE, QC, is_deploy_activity, is_deploy_movement_layer

HERE = Path(__file__).resolve().parent
ADDON = HERE.parent
OUT = HERE / "deploy_layer_fix"
BUNDLES = ("v_m635", "v_xm16super", "v_ptrd41_s")
# Old material-test exports with no source folder and no references from weapon Lua.
# The actual Cobra and LDP Kommando use v_cobra and v_lacoste.
UNUSED_TEST_MODELS = frozenset({"v_cobra_pbr", "v_lacoste_pbr"})


def patch_text(source):
    changes = []

    def patch_block(match):
        text = match.group(0)
        if match.group(1) != "sequence":
            return text
        activity = re.search(r'^\s*activity\s+"([^\"]+)"', text, re.M)
        if not activity or not is_deploy_activity(activity.group(1)):
            return text
        removed = [line.strip() for line in text.splitlines() if is_deploy_movement_layer(line)]
        if removed:
            changes.append({"sequence": match.group(2), "activity": activity.group(1), "removed": removed})
        return "".join(line for line in text.splitlines(keepends=True) if not is_deploy_movement_layer(line))

    result = BLOCK_RE.sub(patch_block, source)
    for block in QC(result).blocks("sequence"):
        assert not (is_deploy_activity(block.activity()) and any(map(is_deploy_movement_layer, block.lines)))
    # The surgical patch and permanent generation rule must produce the same sequences.
    from port_qc import step_deploy_no_movement
    before = QC(source)
    step_deploy_no_movement(before, type("Notes", (), {"note": lambda *args: None})())
    assert before.render() == QC(result).render()
    return result, changes


def compile_model(qc):
    compiler = ADDON.parents[2] / "bin/studiomdl.exe"
    game = HERE / "compile_test_game"
    assert (game / "gameinfo.txt").exists()
    proc = subprocess.run([str(compiler), "-game", str(game), "-nop4", str(qc)],
                          cwd=compiler.parent, capture_output=True, text=True, timeout=900)
    output = proc.stdout + proc.stderr
    (OUT / "logs" / f"{qc.stem}.log").write_text(output, encoding="utf-8")
    ok = proc.returncode == 0 and "Completed" in output
    result = {"model": qc.stem, "ok": ok, "returncode": proc.returncode, "files": []}
    if not ok:
        result["errors"] = [line for line in output.splitlines() if "error" in line.lower()]
        return result
    built = game / "models/weapons/mcv"
    required = [built / (qc.stem + ext) for ext in (".mdl", ".vvd", ".dx90.vtx", ".dx80.vtx")]
    assert all(path.exists() for path in required), qc
    for source in built.glob(qc.stem + ".*"):
        destination = ADDON / "models/weapons/mcv" / source.name
        shutil.copy2(source, destination)
        result["files"].append({"name": source.name, "sha256": hashlib.sha256(source.read_bytes()).hexdigest()})
        if qc.stem in BUNDLES:
            bundled = HERE / "MCV_SMD/weapons" / qc.stem / "compiled/models/weapons/mcv" / source.name
            bundled.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(source, bundled)
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--apply", action="store_true")
    parser.add_argument("--compile", action="store_true")
    parser.add_argument("--jobs", type=int, default=4)
    args = parser.parse_args()
    assert not args.compile or args.apply, "Use --apply with --compile"
    paths = sorted(path for path in (HERE / "MCV_SMD_PORT/weapons").glob("v_*/*.qc")
                   if path.stem not in UNUSED_TEST_MODELS)
    paths += [HERE / "MCV_SMD/weapons" / name / f"{name}.qc" for name in BUNDLES]
    changes = []
    to_compile = []
    if args.apply:
        (OUT / "logs").mkdir(parents=True, exist_ok=True)
    for path in paths:
        source = path.read_bytes().decode("utf-8")
        patched, removed = patch_text(source)
        relative = path.relative_to(HERE)
        backup = OUT / "before_qc" / relative
        if removed:
            changes.append({"qc": relative.as_posix(), "changes": removed})
            if args.apply:
                backup.parent.mkdir(parents=True, exist_ok=True)
                if not backup.exists():
                    backup.write_bytes(path.read_bytes())
                path.write_bytes(patched.encode("utf-8"))
                # Preserve the exporter's edit protection for files already changed by users.
                manifest_path = path.parent / "compile-manifest.json"
                if manifest_path.exists():
                    manifest = json.loads(manifest_path.read_text())
                    if manifest.get(path.name) == hashlib.sha256(source.encode("utf-8")).hexdigest():
                        manifest[path.name] = hashlib.sha256(path.read_bytes()).hexdigest()
                        manifest_path.write_text(json.dumps(manifest, indent=2) + "\n")
        if (removed or backup.exists()) and "MCV_SMD_PORT" in path.parts:
            to_compile.append(path)
    print(f"{len(changes)} QCs; {sum(len(c['changes']) for c in changes)} draw sequences; "
          f"{len(to_compile)} models to rebuild", flush=True)
    if args.apply and changes:
        (OUT / "changes.json").write_text(json.dumps(changes, indent=2) + "\n")
    if args.compile:
        results = []
        with ThreadPoolExecutor(max_workers=args.jobs) as pool:
            futures = [pool.submit(compile_model, path) for path in to_compile]
            for future in as_completed(futures):
                result = future.result()
                results.append(result)
                (OUT / "build.json").write_text(json.dumps(sorted(results, key=lambda row: row["model"]), indent=2) + "\n")
                if len(results) % 10 == 0 or not result["ok"] or len(results) == len(to_compile):
                    print(f"{len(results)}/{len(to_compile)} compiled; "
                          f"{sum(not r['ok'] for r in results)} failed", flush=True)
        assert all(result["ok"] for result in results), "See build.json and logs for failures"


if __name__ == "__main__":
    main()

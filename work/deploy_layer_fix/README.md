# Deploy movement-layer correction — September 14, 2026

Removed walk/run layers from weapon draw and first-draw sequences, including empty,
dual and grenade-launcher variants. **279 viewmodels rebuilt and installed**, with
570 affected draw sequences changed; 572 total compiled draws checked. The three
editable custom bundles contain the same correction (seven duplicate sequences).

`changes.json` records each deleted line. Existing QCs were patched directly: no
mesh/animation regeneration and no changes to other lines, including corrective
layers, events, sights or timings. Backups are under `before_qc`. The permanent
`port_qc.step_deploy_no_movement` runs after steps that inherit movement layers.
An isolated generation check covered SKS, M203 and dual M1911.

Two obsolete `_pbr` material-test models had no source assets and no weapon Lua
references. Their QC edits were reverted; `excluded_test_exports.json` records the
failed attempts. The playable Cobra and LDP Kommando models compiled normally.
An XM16 Super install initially encountered a file lock; its successful compile
was installed after closing only the test instance, with all four files verified.

`check_deploy_layers.py` reads the installed MDLs using the sequence/autolayer
layout in Valve's [studio.h](https://github.com/ValveSoftware/source-sdk-2013/blob/master/src/public/studio.h).
Every compiled sequence's layers match its QC; every draw is free of movement
layers. All other QC text is byte-for-byte preserved. `validation.json` contains
the per-model results, and `build.json` the installed file hashes.

Runtime probe: fresh gm_flatgrass local multiplayer, port 27017. Nine representative
models cover rifles, rifle/underbarrel launchers, dual wield, scoped reload rigs,
flamethrowers and all three custom guns. It compares all bone positions during each
draw at 20%, 50% and 80% cycle, with the movement pose at its minimum and maximum.
It also checks that each model's idle still responds to movement. Wait for a frame
after creating models and for sequence fades to settle before reading bones; a
same-frame read can incorrectly return the same cached pose for both conditions.
The final output is `deploy_layers_runtime.json`: all 23 sampled draws had zero
bone-position change from movement. Idle positive controls changed by 1.18–31.86
units, confirming that the probe actually evaluated both movement poses.

Rebuild existing sources with `python work/build_deploy_layers.py --apply --compile`.
Check compiled assets with `python work/check_deploy_layers.py`. Run the render
probe through the harness with `clua include("mcv_harness/deploy_layers.lua")` and
wait until its results file has `ok: true`. No gameplay/prediction logic changed.
**Fully restart Garry's Mod** to load the rebuilt models.

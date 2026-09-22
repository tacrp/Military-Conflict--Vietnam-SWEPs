# At-ease movement pilot: Vz 24 — 2026-09-21

Only `v_vz24` has been rebuilt. No in-game verification or full-pack recompile was run.

## Cause

Safety mode was capped at movement pose 86 in `GetMovementPose`; the Vz 24 sprint layer
starts at 138. In addition, the original nearwall entry, idle and exit sequences had only
the ordinary walk layer, with no sprint layer. Their hands used release IK rules, and the
ported walk layer was applied in the lowered pose without correcting its different grip.
Simply adding the hip sprint delta would also add its offsets on top of an already-lowered
gun, rather than transition to the normal sprint carry.

## Pilot change

The three nearwall sequences now blend complete poses over movement speed and the existing
ironsight axis. For every frame the builder composes the lowered walk, blends toward the
authored hip/sprint carry as speed rises, and solves both arms and wrist orientations to
preserve the authored grip relative to the gun. There are 17 speed samples in each of two
sight rows, including the entry/exit transitions. No ordinary walk/run layer is added again.

The idle loop's sampling/FPS preserves native walking and running cadence (22 and 18 frame
intervals at 30fps); entry and exit keep their original 16 frames at 30fps and sound events.
The 102 generated absolute animations live alongside the QC in `safe_anims/`.

`SWEP.SafeMovementAnimations = true` enables the full movement range for the Vz 24 only.
Other weapons keep the old safety clamp until their animations are rebuilt. No sight offsets,
weapon stats, original animation SMDs, firing, reload or launcher sequence blocks were edited.

## Reproduce/check

From the `mcv` folder:

```powershell
python work/fix_nearwall_movement.py --compile
python work/nearwall_movement/verify.py
```

The builder patches the three existing sequence blocks and its own generated animation section
only. It installs just this model's four compiled companion files using `pack_paths.asset_path`.
It intentionally does not yet alter the general porter: a fresh full port would need this
pilot reapplied. Broader generation should wait for visual acceptance of the test weapon.

`verification.json` records a maximum solved grip-position error below 0.000001 units and
0.0401 units when interpolating halfway between adjacent speed samples. Before the change,
the old walk layer at the safety cap produced up to 0.3925 units of additional hand drift
across the three nearwall animations. This is relative to each authored pose's grip, not a
claim that the original mesh/finger placement was perfect.

`checks.json` records unchanged compiled events/activities for all 45 sequences and unchanged
timings for all 112 pre-existing animations. The new compiled grids are 17 x 2, with the full
0..233 movement range. The Lua mapping check confirms only the opt-in model escapes the cap.
Installed model files match the compiler outputs. These are offline numerical/file checks;
they cannot certify the final visual result.

**Fully restart GMod** to load the model, not just a map change. For later user verification,
try Vz 24 at ease while standing, walking and sprinting, then toggle safety while moving.
Also compare normal firing/reloading and rifle-grenade use. The user subsequently accepted
this pilot; the completed broader recompile is documented in `../safety_rollout/README.md`.

# Gyrojet movement correction — 2026-09-19

The pistol and carbine use an independent root bone named `Base` for the gun. Their hands'
IK targets belong to another root, `BaseRoot`. Crowbar wrote the first animated gun rotation
into `run_a_corrective_animation.smd`, which the QC subtracts from every sprint frame.
This removed the gun's carry angle while retaining the hands' rotation.

`port_qc.step_fix_correctives` now takes only `Base` from the matching neutral movement
corrective (`runIdle_a` for sprint, `walkIdle_a` for walk) for these two models. This retains
the required -90-degree exporter coordinate correction. The walk export has the same fault
at a much smaller angle. Other bones and all hand animation SMDs are unchanged.

The existing QCs were patched at those four corrective paths only. Both viewmodels and
their companion files were compiled and installed into Part 2 through `pack_paths.asset_path`.
No weapon Lua, sight offsets, worldmodels or gameplay settings were changed.

## Reproduce

From the `mcv` addon directory:

```powershell
python work/fix_gyrojet_sprint.py --compile
```

Omit `--compile` to patch and check the source files only. The script uses the existing OG
sources, baked movement animations and editable ported QCs. It does not regenerate a weapon
Lua or a whole QC, and never launches the game. Future full ports retain the correction too.

## Offline checks

Every frame was evaluated with the idle base pose, additive movement and its corrective,
then the gun transform was measured relative to the right hand's idle grip:

| Model | Sprint maximum angle, before → after | Walk maximum angle, before → after |
| --- | --- | --- |
| Gyrojet pistol | 28.597° → 0.780° | 0.858° → 0.389° |
| Gyrojet carbine | 28.338° → 1.070° | 0.971° → 0.444° |

Each sprint has 19 frames and each walk has 23. Maximum grip position differences remain
below 0.084 units; the correction changes rotation only. SHA-256 checks confirm unchanged
baked hand animation files and repeatable corrective generation. Both compiles succeeded;
each compiled model retains its 30 sequences, 81 animations, FPS/frame counts and events.
Installed files match the compiler outputs by SHA-256. Details are in `verification.json`.

No in-game verification was performed. **Fully restart Garry's Mod** to load the rebuilt
models; changing maps alone does not reload them. Existing release GMA archives were not rebuilt.

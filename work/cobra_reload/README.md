# Cobra wet-reload hierarchy correction

The edited hip `reload.smd` has 55 bones and makes `Base` a root. The current
model, idle and aimed reload have 56 bones, with `Base` parented to `BaseRoot`.
This is the same hierarchy mismatch previously repaired in the M21's empty
reload, causing an incorrect blend back into idle.

The shared `model_pose_fixes.restore_reload_rig` converter restores the original
`BaseRoot` track and expresses every edited pose in the current hierarchy.
It preserves the original hand edit, every existing bone's world-space pose,
and all 70 frames. The generated SMD is kept under the port's `fixed_anims/`;
only the hip reload path changes in the existing QC. `prepare_pose_fixes` retains
the correction in future ports. The aimed and empty reload sources are unchanged.

From the Part 1 addon directory:

```powershell
python work/fix_cobra_reload.py --compile
python work/test_reload_rigs.py
```

Without `--compile`, the helper only prepares the corrected SMD/QC reference.
Compiling uses the scratch game and installs the four matching `v_cobra` model
files at their existing Part 2 paths. It checks all compiled animation timings,
sequence activities/events and animation layers against the installed model
before replacing any files. The installed safety movement bake is retained.
`compile.log` and `build.json` record the compiler result, timings and hashes.

Offline validation:

- Both wet-reload blends remain 70 frames at 30 FPS (2.3 seconds).
- Both empty-reload blends remain 94 frames at 30 FPS (3.1 seconds).
- Every edited world-space bone matrix is preserved within 0.000000012 after
  writing and re-reading the SMD. Original source hashes are unchanged.
- The restored root matches idle at both endpoints; the authored gun return
  already ends within 0.005 HU of idle, so no smoothing or retiming was needed.
- Repeated preparation is identical. The shared conversion also passes the
  M21's hip/aimed empty-reload pose-preservation regression.

No in-game verification was performed. **Fully restart GMod** to load the model.

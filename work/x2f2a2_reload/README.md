# X2F2A2 empty reload while aiming

The shipped `reload_empty` sequence had two ironsight blends: 115 frames from
the hip and **one frame** when aimed. The weapon uses the selected sequence's
duration for its reload lock, so aiming collapsed the empty reload.

`fix_x2f2a2_reload.py` restores the aimed animation from the complete L1A1 clip.
Their hip empty reloads are identical on all 58 shared bones. The builder maps
bones by name, omits the L1A1's extra Bayonet bone, and eases from/to the X2F2A2's
own aiming grip over the first/last 15 frames. The middle magazine/bolt motion
and the empty animation's hidden-round state come from the complete donor.

Run from the Part 1 addon directory:

```powershell
python work/fix_x2f2a2_reload.py --compile
```

Without `--compile`, this only regenerates the retained SMD override and patches
its one path in the existing QC. Future `port_qc.py` runs prefer that override
automatically. Original decompiled files, weapon stats and sight offsets remain
intact.

The compile uses `work/compile_test_game`, checks both empty-reload blends have
115 frames at 30 FPS (3.8 seconds), and checks that other animation timings,
sequence activities/events and animation layers are unchanged before installing
the four matching viewmodel files at their existing mounted paths, resolved by
`pack_paths.py` (this model currently lives in Part 1 although its weapon Lua is
in Part 2). `build.json` records timings/hashes;
`compile.log` retains the compiler output. Source checks also verify bone parents,
the unchanged middle motion and the X2F2A2 grip at both endpoints.

The source QC also contains a pending safety locomotion bake which this rifle
does not currently use. For that installed configuration, the builder substitutes
the retained pre-bake safety blocks in its separate build QC; it leaves the main
QC's pending work intact. This keeps the reload repair's installed animation
layers/timings identical apart from the repaired reload blend.

This is offline asset validation, not in-game verification. **Fully restart GMod**
to load the rebuilt model; a map change alone does not refresh models.

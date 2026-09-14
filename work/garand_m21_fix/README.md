# Garand orientation and XM21 empty-reload correction

The initial Garand angle-only correction documented by this evidence aligned its
barrel but left it displaced from the hands. It has been superseded by the complete
nested-rig correction in `../nested_world_fix/README.md`, shared with the LPO-50 and
M9A1 flamethrowers. The current build helper regenerates the Garand through that
pipeline. The older screenshots below are historical, not final placement evidence.

The XM21 hip empty-reload override contains 60 bones, while the current rig has
61: the override removed BaseRoot and placed Base at the top level. Source blends
that different hierarchy into and out of the current idle, moving the missing
root through the transitions. The generated animation restores BaseRoot and
recalculates Base relative to it. Every existing bone's world-space transform is
verified unchanged on every frame; all 98 frames, sounds and reload timing remain.
The aimed override already has the current hierarchy and is copied unchanged.

Validation:

- Both model families compiled and installed; originals retained in before_models.
- Original meshes and hand-edited animation sources were not modified.
- Fresh gm_flatgrass local multiplayer, port 27016, net_fakelag 0.
- Garand/M1D screenshots show the barrel pointing forward with their correct scope bodygroups.
- PostDrawViewModel traces compare both ends of the XM21 reload; the corrected
  gun-root excursion is below 0.02 units, including an empty reload started in ADS.
- Hip/aimed empty reloads produced 20 rounds; tactical reload produced 21.
- Separate port generation preserved both fixes; 242 Lua files passed syntax checking.

Rebuild only these two models:

```
python work/build_garand_m21_fixes.py
```

The permanent generation hook is in port_qc.py and model_pose_fixes.py. The build
helper changes only the affected paths in the existing QCs. Full game restart is
required after rebuilding. Tests are work/tests/garand_m21_after.txt and the
before/trace fixtures beside it. Analyze captured traces with:

```
python work/analyze_m21_render.py before_m21 after_m21 after_m21_aimed
```

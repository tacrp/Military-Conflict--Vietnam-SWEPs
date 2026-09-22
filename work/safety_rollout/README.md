# At-ease movement rollout

Installed: **261 referenced viewmodels, including 227 firearm safety opt-ins**, across both
packs. The user accepted the Vz 24 pilot in game. The rollout rebuilds the same three safety
sequences on the other firearm rigs, preserving their sequence order, activities, events
and the current sources' other animation frame counts/FPS. It does not launch the game.

From the addon directory:

```
python work/build_safe_movement.py --compile --jobs 6
python work/install_safe_movement.py
```

To retry or update particular source models, pass `--models v_m635 v_xm16super` to the
builder. Use `--dense` to begin with the finer carry blend on difficult rigs. The installer
requires a successful, current staged build for every referenced viewmodel before copying
anything into either pack. Run these tools after regenerating a port QC as well: ordinary
QC regeneration does not produce these additional safety animations.

Existing QCs are patched in place, not regenerated. Original safety sequence blocks are
backed up under `before_qc/`; generated SMDs live in each port's `safe_anims/`. Only the
three safety blocks and their generated animation definitions are replaced on a rebuild,
leaving other subsequent hand edits intact. Equipment without firearm safety keeps its
original animations. Unused experimental models without sources are not required.

The baked poses combine lowered carry with locomotion, including sprint, and solve both
hand positions and wrist orientations against the gun. Gun-under-hand dual rigs correct
the gun's relative transform instead of solving a circular arm target. Normal models use
17 speed samples; difficult rigs use up to 31, with a small
arm-bend margin to avoid near-straight elbow instability. The accepted pilot is preserved.
Revolvers retain their firemode axis and use its hip poses for safety: safety disallows
aiming, and the model format supports only two blend axes.

The checks bound exact-pose grip error, halfway-between-speed-samples grip drift and
required shoulder displacement. Compiled sequence events/activities and original animation
timings are compared with the installed model. Ten models had pre-existing source timing
differences; compiling their untouched pre-migration QCs confirmed those differences already
existed in the editable source, so they were retained (`source_baselines.json`, reproducible
with `python work/check_safe_source_baselines.py`). Inline safety animations on the two
PTRD rigs are replaced by the new blends. Per-model results are in `models/`; `installed.json`
records installed file hashes. This does not replace visual checks of the remaining rigs.

The installer generates `lua/mcv/shared/sh_safe_movement.lua` to allow the full movement
range only for successfully rebuilt gun models. All shared code stays in Part 1. Model
companions go to their existing Eastern/Western pack via `pack_paths.py`.

The M635, XM16 Super and PTRD-41 Sniper editable bundles receive the same safety sequence
blocks and local `safe_anims/` sources. Their other QC edits and original meshes stay intact;
their existing `compile.py` remains the command for hand-edited custom rebuilds.

Fully restart Garry's Mod to load the models. No in-game verification was performed by
the agent; testing in game requires an explicit request.

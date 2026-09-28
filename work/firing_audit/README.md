# Firing animation tail audit

The M1911's third hip-fire track has 21 frames. Frame 19 has already settled
to rest; frame 20 reintroduces a 1.476-HU gun offset, trigger movement and up to
70.276 degrees of bone rotation. Its sighted partner has 20 frames. Randomly
selecting the third shot creates an intermittent end-of-shot twitch.

The same defect occurs in HDM, Hi-Power, Mamba, Mk22, Mle1935, TT33 and the
second homemade pistol. BAR-L has smaller rest-then-jump tails in two aimed,
deployed firing tracks. Ten tracks in nine models were repaired.

The fix holds the settled penultimate pose for the final frame. All earlier
source poses and the original frame count remain unchanged. Original and
hand-edited source SMDs are untouched; generated repairs live in each ported
model's fixed_anims folder. Existing QCs change only those animation paths.
No weapon Lua, sights, safety poses, firing timings or layers were regenerated.

before.json and audit.json cover 259 ported firing viewmodels and 2,074
subtractive firing-related tracks, including recursively referenced layers.
There are no animation/corrective hierarchy mismatches. The remaining flagged
track, DP-28 NotEmptyMove, intentionally returns its bolt to the open position
and is unchanged. The 136 unequal delta-blend lengths are reported for review:
length differences alone are not discontinuities, and the port already permits
the original game's unequal delta blends. They were not automatically resampled.
This is a structural/source audit, not a claim that every animation has been
visually reviewed in game.

build.json records source and installed companion hashes. All nine builds
passed exact before/after compiled animation timing/activity/event and autolayer
comparisons before installation via pack_paths.asset_path. Both packs receive
their own models. Compiler logs and the original QCs are retained here.

## Reproduce

From the addon root:

    python work/audit_firing_tails.py
    python work/fix_firing_tails.py --compile
    python work/test_firing_tails.py
    python work/test_reload_rigs.py

The repair is also part of model_pose_fixes.prepare_pose_fixes, used by the
normal port. port_qc.step_validate rejects new shooting tracks which settle to
rest and then jump away on their final frame. Existing pose-parameter samples
and intentional movement/bolt-state layers are excluded from this guard.
The regression test proves that old QCs fail and repaired QCs pass, that repeated
preparation is stable, and that original source files and earlier frames survive.

No in-game verification was performed. **Restart Garry's Mod fully** to load the
rebuilt viewmodels; a map change does not reload models.

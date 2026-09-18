# Type 67 bolt timing

**Timing superseded by `../cycle_timings/README.md`.** The current model retains the original
30-frame action at 30 FPS, with no `CycleSpeed` multiplier: hammer frame 10 (0.333 s),
eject frame 11 (0.367 s). `verify.py` now expects these authored phases when rerunning the
fixtures. The old recordings and verification below document the initial fix before that
subsequent change; run the fixtures again before checking the current model against them.

Two independent problems caused the early cocking/ejection:

- The weapon omitted `AnimationHandlesHammer`, so starting its bolt animation immediately
  cleared `NeedCycle` and reset the hammer pose. It now waits for the existing predicted
  `HammerReleaseTime` transition.
- The original bolt animation has 30 frames, stretched over a 60-frame parent by the port.
  Its events were copied as absolute frame numbers. Sound, cocking and ejection cues now
  keep their original phase in that motion. `port_qc.py` preserves this when rebuilding.

Only the single Type 67 model was rebuilt. Its bolt events change from sound 1/8, hammer 10,
eject 11 to sound 2/16, hammer 20, eject 22. The compiled hammer table follows 20/59.
At the current inherited `CycleSpeed = 0.9`, cocking is 0.60 seconds into the pull and
ejection is 0.66 seconds; both scale with the animation duration. The base cycle-speed
setting is unchanged by this fix. The dual model has no separate bolt-pull sequence.

## Reproduce

With a fresh test instance (the normal user's game can stay running):

```powershell
python work/harness.py start gm_flatgrass --mp --multirun --port 27018
python work/harness.py run work/tests/type67_timing.txt --port 27018
python work/harness.py run work/tests/type67_timing_lag.txt --port 27018
python work/harness.py run work/tests/type67_dual.txt --port 27018
python work/type67_timing/verify.py
```

The fixture records real input, predicted state on both realms, rendered hammer poses and
ejection callbacks. Verification compares the compiled events with the source motion and
porter output, checks that cocking waits for its cue, checks one ejection on the first
rendered frame crossing its cue, and compares client/server bolt-start times. It covers
hip/aimed shots at 0/100 fakelag, empty reload and two successive dual shots. Effects dispatch
on rendered frames, so a slow frame can delay them past their cue. Raw recordings and the
compact `verification.json` are saved here. `type67_baseline.txt` reproduced the old early
reset and roughly 0.33-second ejection before the changes.

Validation passed: `type67_timing_93910627`, `type67_timing_lag_93911412` and
`type67_dual_93913199`, all with empty harness error lists. The deliberate clip setup for
the empty-reload case produced one clip correction; the lagged firing and final dual run
logged no prediction complaints. Lua syntax validation passed for all 243 checked files.
The earlier dual fixture tried to give an already-owned weapon; its corrected version selects
the carried weapon before toggling dual wield.

**Fully restart Garry's Mod** to load the recompiled model; a map change alone is insufficient.

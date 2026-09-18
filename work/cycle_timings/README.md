# Authored manual-action timing

The old port stretched pump and bolt poses onto 60-frame parents, then applied a shared
`CycleSpeed` duration multiplier. That erased the source actions' different durations.
The 19 affected viewmodels now retain the maximum blended source frame count and the
source FPS. Lua plays the action at rate 1 and obtains its duration from the model.
`CyclePostDelay` retains the existing recovery fraction; sounds, shell ejection, hammer
release and the homemade pistol's ammunition display follow the authored timeline.

Examples (Source duration is `(frames - 1) / fps`):

| Action | Duration |
| --- | ---: |
| M1897 / M37 / M870 pump | 0.667 s |
| China Lake pump | 0.833 s |
| Type 67 bolt | 0.967 s |
| Mosin / Springfield / vz. 54 bolt | 1.133 s |
| Kar98 / MAS-36 / vz. 24 bolt | 1.300 s |
| Welrod bolt | 1.333 s |
| M40 bolt (24 FPS) | 1.417 s |
| Homemade pistol harmonica action | 2.333 s |

`manifest.json` records every source frame count, FPS and event. The patcher edits existing
QCs without regenerating other sequences or replacing hand edits; first-run backups are
in `before_qc`. `port_qc.py` preserves this rule on future ports. The Type 67's earlier
60-frame timing fix is superseded: hammer release is frame 10 (0.333 s), shell ejection
frame 11 (0.367 s). Its `AnimationHandlesHammer` fix remains necessary.

## Rebuild and check

From the addon root:

```powershell
python work/fix_cycle_timings.py --compile
python work/build_hammer_events.py
python work/cycle_timings/verify.py --fixtures
Copy-Item work/cycle_timings/manifest.json ../../data/mcv_harness/p27018/cycle_manifest.json
python work/harness.py start gm_flatgrass --mp --multirun --port 27018
python work/harness.py run work/tests/cycle_timing_0.txt --port 27018
python work/harness.py run work/tests/cycle_timing_100.txt --port 27018
python work/cycle_timings/verify.py
```

Use a fresh test instance so all models load and fixture weapons are initially absent.
`verify.py` checks compiled event phases for all 19 models, model durations in both realms,
and real-input cycles for six representative guns at 0/100 fakelag. Each replay must use
the same duration and playback rate; the final action start, completed state and ammunition
must agree between client and server. A first-predicted timestamp alone is insufficient:
engine tick-base correction can move it during replay. These tests do not assert that
the engine never emits a prediction correction.

Validation: `cycle_timing_0_93935066` and `cycle_timing_100_93935914` completed without
harness/Lua failures; all 19 engine model audits and all 12 real-input cases passed.
The zero-lag job logged no prediction complaints. The 100-lag job logged tick-base and
weapon-switch corrections; final action timelines agreed. The fixture now waits after
disabling detailed diagnostics before its server-driven weapon selection, so those setup
transitions do not leak into the next firing window. Client/server JSON and the compiled/
porter comparison are preserved in `verification.json` and its accompanying recordings.

**Fully restart Garry's Mod** after installing rebuilt models.

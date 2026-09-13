# Prediction testing

Use a local **multiplayer** listen server, `sv_cheats 1`, `cl_showerror 2`, and
`net_fakelag`. Singleplayer is a regression check, not proof of multiplayer prediction.

```powershell
python work/harness.py start gm_flatgrass --mp --multirun --port 27016
python work/harness.py run work/tests/pred_calibrate.txt --port 27016
python work/prediction_suite.py --port 27016 --label baseline --lag 100 --trace
python work/prediction_suite.py --port 27016 --label replay --lag 100 --optimize 0
python work/ptrace_diff.py baseline_mcv_m14 --port 27016
```

The calibration temporarily makes the client's M14 clip 7 while the server keeps 20.
`cl_showerror 2` must report `CBaseCombatWeapon::m_iClip1` with that difference.
The script strips that instance afterwards. This checks that silence in later tests
means something. It is only a harness test; no mismatch is built into the addon.

Suite scripts, raw console slices, and `summary.json` are saved in
`garrysmod/data/mcv_harness/p27016/results/<label>/`. Before/after state reports and
optional command traces sit in its parent `results/` directory. Setup and teardown
are outside measured console markers. Check the reports to ensure input actually
exercised the feature; zero diagnostics with no shots is not a passing firing test.

## Rifle-grenade sights and selector, Sep 13 2026

The rifle-grenade idle was missing from Lua's `IdleActivity`, not from the model.
Both vz.24 and SKS already blend `grenade_ironsight` into `grenade_idle` and
`grenade_shoot`, but Lua selected `ACT_VM_IDLE` between shots. This aimed through
the normal irons until the shot abruptly selected the ladder-sight pose. The base
now selects `ACT_VM_IDLE_M203` for rifle grenades and retains `ACT_VM_IIDLE_M203`
for underbarrel launchers. All 18 weapon files with `HasRifleGrenade = true` have
the appropriate idle activity in their ported model source. No model or sight
offset edits were needed; reload the map for the Lua change.

`ChangeFiremode` now returns immediately in launcher mode, before changing rifle
mode, scope level, burst state, sound, or animation. Its control hint is hidden
there. The selected rifle mode is preserved when switching back.

`work/launcher_prediction.py` uses actual input in local MP to aim, enable the
launcher, attempt a fire-mode change, fire, reload, disable it, and use the rifle
selector again. It retains client/server mode and ammo reports, rendered-frame
traces, an aimed screenshot, and the native console slice. Run it with, for example:

```powershell
python work/launcher_prediction.py --label launcher_fixed100 --lag 100
```

Baseline evidence: `launcher_before100_mcv_vz24.visual.json` shows ordinary
`idle` while aiming in launcher mode, followed by `grenade_shoot` on firing.
That first run's custom state export failed because the loader replaced the
public `MCV.Harness` table; its visual trace remains usable, but it is not a
passing functional test. The driver now exports state directly. The subsequent
`launcher_baseline100` SKS and M14 runs both detect the wrong idle on both realms.
SKS also recorded tick-base and animation/deadline corrections, retained in its
console slice; M14's native error log was clear despite its wrong sight pose.

The corrected vz.24's right-hand position at the end of `grenade_shoot` is within
0.003 model units of its aimed idle, versus a 4.764-unit difference before the fix.
This compares the settled shot pose, so the grenade's intended recoil remains.
SKS's corresponding difference fell from 3.775 to 0.002 model units.

`launcher_fixed100` exercised vz.24, SKS, M14, M16A1 M203 and M16 XM148 at
`net_fakelag 100`, `cl_pred_optimize 0`: 4,654 rendered frames and 40,799 movement
replays. All five passed the functional checks on both realms. The three rifle
grenade runs had no native field errors. Both underbarrel guns kept rifle mode 1
through the blocked selector input and launcher exit, then changed to mode 2 on
the next rifle selector input. Their raw native logs are not clean: the shared
console also contains the original game's suicide/respawn and weapon-give errors
around time 18,850 / command 1,256,000, while the test ran around time 160-240 /
command 10,700-16,000. XM148 also recorded four local player tick-base corrections.
These logs are retained and the driver returns failure for nonempty native
diagnostics; do not present these two runs as proof of zero prediction errors.
The previously reverted underbarrel firing-activity fallback remains untouched.

Validation also passed the requested 238 standalone-weapon GLua checks, all 13
base-gun modules, Python compilation, eight existing animation/supply tests and
`git diff --check` for the touched tracked files.

## Starting rifle-grenade ammo option

`mcv_spawn_rifle_grenade_ammo` defaults to 1 and is archived, replicated and shown
under Options > Military Conflict: Vietnam > Server as "Starting rifle-grenade
ammo". At 0, server-side weapon initialization clears only the new secondary
`smg1_grenade` clip. All current declarations supply their single starting round
in that clip, with no extra reserve. The owner's ammo pool, existing weapons,
resupply and normal reloading are unaffected. Matching the secondary ammo type
also covers rifles with an unused secondary grenade clip but no launcher mode;
standalone launchers' primary ammo is unaffected. No weapon definitions or
`DefaultClip` tables are modified.

`work/tests/starting_rifle_grenade_ammo.txt` checks empty world spawns, new and
duplicate gives with an existing reserve, client replication, empty launcher
activation, reloading collected ammo, redeploying a loaded weapon, turning the
option back on, and construction of the Server-menu checkbox. The isolated MP
run `starting_rifle_grenade_ammo_93017022` passed all assertions, including the
client-side checks (its console slice is retained). The new setting was restored
to its default of 1 after testing. Syntax validation passed for 241 Lua files.

## What the measurements mean

- `cl_showerror 1` only displays the player's positional error. **2** prints errors
  for weapon fields, viewmodels, ammo and player fields. Preserve the raw field deltas.
- `cl_predictionlist 1` shows which entities predict. `cl_pdump <entity index>` shows
  their prediction fields on screen. These are useful when narrowing an error to a
  weapon or its viewmodel; they are not substitutes for logged deltas.
- Match Lua samples by **CUserCmd:CommandNumber**, weapon entity and hook. Neither
  engine tick count nor CurTime uniquely aligns client and server commands. Tick base
  corrections can change the command's simulated time.
- Weapon Think runs before movement on the client and after movement on the server.
  Its position, velocity, ground and view-punch samples are not comparable snapshots.
- Replaying unacknowledged commands is normal. `IsFirstTimePredicted() == false` does
  not count a prediction error. The last replay we observed is not necessarily settled.
- A Lua trace difference is a diagnostic clue. Only the engine's acknowledged snapshot
  comparison determines an engine prediction error. Trace serialization can stall a
  frame; keep it outside the measured console interval.
- `Player:SelectWeapon` and console `use` switch outside prediction. Test normal
  inventory switches with `input.SelectWeapon` / `CUserCmd:SelectWeapon` after the
  destination entity has networked. Test forced server switches separately.
- Engine clock correction, authoritative entity creation/removal, damage, and other
  installed addons can also cause corrections. Preserve them in the evidence and
  use a stock weapon control; do not claim a universal guarantee of zero corrections.

Queues are separated by `--port`. The existing `console.log` is shared by game
instances, so measured suites currently run serially. Do not attribute concurrent
console output to a particular instance. `con_logfile` has been removed from GMod;
it cannot isolate these logs even as a launch option. `echo` is blocked through Lua
ConCommand, so console markers use the client's `print`. `fps_max` and
`engine_no_focus_sleep` are also blocked through Lua: apply them at test-instance
launch, then report the measured frame rate rather than assuming the cap was reached.

The suite clears the local test map between cases, resets inputs and ammo, and checks
the active weapon before and after. `tap` times both button edges on the client and
acknowledges the release; timing its release on the server let lagged packets deliver
both edges in one client frame. Modes and attachments have intermediate assertions;
ammo, health and completed action state are checked separately from diagnostic silence.
Material-loading warnings remain in the evidence but are listed apart from Lua errors.
MP cases also assert `GetPredictable()` and count new predicted Think calls; forced
replay cases require replay calls as well. A stalled Deploy therefore cannot masquerade
as a zero-error pass. The final calibration logged 133 exact clip mismatches (20 vs 7)
and 2,301 Think calls; see `results/calibration_final.console.txt` on port 27016.

## Changes from the September 12 investigation

- Replace queued Lua closures in throwables, melee, placement, boxes and bayonet
  charges with named deferred stages. Deadlines, variants and counters live in
  NetworkVars, so restoring and replaying a command also restores its pending action.
  Only server entity creation keeps a private placement trace.
- Schedule hammer release from the compiled model's event cycle and predicted
  animation start. Render-time animation events no longer change `NeedCycle` or
  `EmptyReload`. `build_hammer_events.py` extracts 51 sequences from eight models;
  rerun it after recompiling those models. No model or sight offset was changed here.
  Resolve this data from the weapon's current mode, since the viewmodel's Lua
  `GetModel()` string can remain stale after a dual-wield swap or weapon switch.
- Queue recoil for the next command and apply it in shared `SetupMove`. Applying
  `Player:SetVelocity` in weapon hooks previously changed base velocity on different
  sides of the movement simulation. The queued impulse is itself restored on replay.
  Its direction comes from the input command's view angles. Including view punch
  fed native camera tolerances into a strict Vector NetworkVar, producing an airborne
  mismatch as small as 0.000024 units. Camera recoil and shot aiming are unchanged.
- Predict world-model bodygroups, health from self-healing, and ammo from hand use.
  Keep the handle of a newly created mine outside the predicted datatable; creation
  cannot provide the client with the server's future entity handle.
- Use command numbers for delayed inventory selection. `StartCommand` must not use
  its non-predicted clock to decide the delay or change weapon NetworkVars. Ignore the
  engine's extra client Holster notification for state changes; forced server switches
  complete directly. The server's save-value interface takes a relative next-attack
  delay, while the client's prediction field takes an absolute time: use zero on the
  server and CurTime on the client. Giving the server CurTime doubled the resulting
  deadline and blocked input; the action checks and calibration caught this. The
  server's GetInternalVariable result decreases with time because it is relative;
  this must not be mistaken for the raw engine deadline.
- Precache dual-wield models before switching and preserve the viewmodel collision
  bounds when changing models. The old path predicted model index -1 and MDL hull
  bounds while the server retained the viewmodel's small hull. Reconstruct the Lua
  ViewModel alias and weapon's cached viewmodel index on replay; plain Lua aliases
  survive rollback. Explicit swaps reapply SetModel even if GetModel's cached string
  already names the future model. Comparing that string alone skipped the swap on
  replay, producing a different ready sequence and a 0.1-second lock-time error.
  The server's weapon-model cache advances before Lua Think and is not writable
  through its save table. The client repairs its cache before deferred actions,
  preserving that one-command boundary rather than advancing early at the swap.
- An experimental fallback to the secondary-attack activity was reverted at the
  user's request: it represents hip fire rather than the deployed launcher mode.
  `RifleGrenadeAttack` again requests `ACT_VM_ISHOOT_M203`. Earlier test results that
  used the fallback are historical evidence, not validation of the restored animation.

### Authoritative interactions

A dropped supply box is a server-owned physics entity. Its proximity pickup can
grant ammo after a predicted command and therefore legitimately correct player ammo.
For example, `extended3/mcv_ammobox_us.console.txt` recorded net 120 versus predicted
80: two hand uses had supplied 80 and the new ground box supplied another 40. The
weapon-action regression fills the rifle first, checks a refused full-ammo use, then
drops the box. This isolates hand-use prediction without disabling pickup behavior
or suppressing its diagnostics. Other-player healing, vehicle damage/repair, destroyed
mines and exhausted-weapon removal likewise depend on authoritative world state;
passing the isolated weapon scenarios does not guarantee those never correct.

The host also produced a native crash dump during an unmeasured map reload at
21:10 on September 12. Completed results were retained and the test host restarted;
that event is not counted as a passing scenario or attributed to a prediction field.

Singleplayer runs keep `cl_showerror` off and record `prediction_checked: false`.
Forcing prediction diagnostics there produced a one-tick player tick-base difference
on every packet, which says nothing useful about multiplayer weapon prediction.
Singleplayer is validated through actual actions and final client/server state.

## Final multiplayer results, September 12, 2026

All cases below used a local multiplayer listen server, `sv_cheats 1`, weapon
prediction enabled and `cl_showerror 2`. Measured setup was followed by real client
input and assertions for completed actions and matching client/server state.

| Retained run | Fake lag | cl_pred_optimize | MCV scenarios | Engine errors | Replayed Think calls |
| --- | ---: | ---: | ---: | ---: | ---: |
| `final_matrix100` | 100 ms | 2 | 20 | 0 | 358,360 |
| `stress_final200` | 200 ms | 0 | 6 | 0 | 209,035 |
| `final_zero` | 0 ms | 2 | 1 | 0 | 0 |

The full matrix covers dual wielding and predicted inventory switches, self-resupply,
semi/automatic rifles, bolt and pump actions, revolver fire, grenade throws and cooking,
melee attacks and charge, C4, mine/stake placement, dynamite, flamethrower, self-healing,
binoculars, the launcher, bayonet charge, bipod use, and airborne hip/aimed fire. The
last case uses fractional pitch/yaw to exercise every recoil-vector component.
The stress set repeats dual wielding/switches, M91, M1897, grenades, mines and airborne
recoil with full restore/replay. Both runs have zero Lua, harness or final-state errors.
The zero-lag airborne test also passes with 714 new predicted Think calls; no replay
is expected on this loopback run with prediction optimization enabled.

The final singleplayer run, `p27017/results/sp_final_code/`, passes all four functional
cases: M1911 dual wielding and inventory switches, M91, M1897, and airborne M14 fire.
Each has matching final client/server state and no Lua or harness errors. Its engine
error count is deliberately null (`prediction_checked: false`). Earlier singleplayer
checks of grenades, melee and C4 also passed in `p27017/results/sp_final/`.

```powershell
python work/prediction_suite.py --port 27016 --label final_matrix100 --lag 100
python work/prediction_suite.py --port 27016 --label stress_final200 --lag 200 --optimize 0 --classes mcv_m1911a1 mcv_m91 mcv_m1897 mcv_m26 mcv_m16mine mcv_m14_air_test
python work/prediction_suite.py --port 27016 --label final_zero --lag 0 --classes mcv_m14_air_test
# After starting a separate singleplayer instance on port 27017:
python work/prediction_suite.py --port 27017 --label sp_final_code --singleplayer --lag 0 --classes mcv_m1911a1 mcv_m91 mcv_m1897 mcv_m14_air_test
```

Use a new label to preserve an earlier run; reusing a label overwrites its reports.
The retained 200 ms stress run used the airborne case's original level aim; the
final 100 ms, zero-lag and singleplayer runs include the fractional-angle extension.

`final_matrix100` also includes a **stock `weapon_pistol` control**, which reproduced
eight native errors: four `CBaseViewModel::m_nSequence` and four
`CWeaponPistol::m_nNumShotsFired`. They are retained in the same summary and raw log;
the suite therefore correctly exits with status 1. None is counted as an MCV pass.
Two existing material patch warnings (`m60_link` and `rpd`) remain in the first case's
raw output and `asset_errors`, separate from Lua errors.

Run records are under `garrysmod/data/mcv_harness/p27016/results/`; each table label
is a directory containing `summary.json`, the exact input scripts and console slices.
Earlier failed runs are retained too. In particular, `regression100` exposed the stale
hammer-model lookup and tiny recoil-vector mismatch, and the final matrix repeats
those scenarios with the fixes in place.

The eight rollback unit tests in `work/test_prediction_replay.py` pass. They restore
engine-owned state while leaving Lua fields intact, covering deferred throw stages,
melee sequencing, cancellation, holster selection, model-cache restoration, hammer
timing and applying recoil exactly once. The GLua checker accepts all 272 checked
weapon, base, harness and generated-data files.

## Sprint and aim visuals, September 13, 2026

The September 12 gameplay checks did not measure render-cache ownership or the
bone poses actually drawn. They therefore missed the reported sprint/ADS jitter.
The follow-up uses the M2 Carbine and XM177 OEG at the reported `net_fakelag 100`.

The live trace showed `GetViewModelPosition` executing both inside command prediction
and outside it for rendering. `FrameNumber()` alone did not distinguish those calls.
The first predicted call advanced the ordinary Lua visual aim cache with a tick's
`FrameTime()`, then subsequent calls in that rendered frame reused an earlier
command's value. In the M2 baseline, gameplay aim reached 70% while visual aim was
still 7%. In a later frame gameplay and the hand bones were fully aimed while the
positional visual blend was only 19%.

Pose parameters were also rewritten in `PreDrawViewModel`, after the engine could
already have built the bones. The frame could therefore combine bones for one pose
with the viewmodel offset for another. Neither fault requires a weapon datatable
mismatch, so a quiet `cl_showerror 2` log cannot exclude it.

Changes:

- Visual aim, movement, stance and steadiness getters do not advance their Lua
  caches while the owner is being predicted. They update once outside prediction
  with the frame's time and the resulting gameplay state.
- The non-predicted `GetViewModelPosition` call applies the visual poses before
  drawing and invalidates the bone cache. `PreDrawViewModel` handles drawing only.
  Shared Think still writes the deterministic viewmodel state.
- `FinishMove` stores completed movement speed, ground and crouch state plus its
  command number in weapon NetworkVars. Current and previous samples are retained:
  client Think before movement and server Think after movement both read command
  N-1. Rendering reads the latest completed sample. This makes movement-dependent
  spread/sway and jump/landing blend targets use the same movement phase and lets
  the engine restore that history on replay. A plain Lua last-speed field would
  survive rollback and could supply a future command's speed instead.

### Reproduced baseline and render checks

All rows below used 100 ms fake lag, optimization 2, and about 11 FPS while rendering
in the background. Counts come from actual hook calls, not a mock render loop.

| Run / weapon | Rendered frames | Prediction advanced visual cache | Pose changed after positioning |
| --- | ---: | ---: | ---: |
| `visual_baseline2` / M2 Carbine | 227 | 227 | 70 |
| `visual_baseline2` / XM177 OEG | 337 | 337 | 68 |
| `visual_movement` / M2 Carbine | 234 | 0 | 0 |
| `visual_movement` / XM177 OEG | 234 | 0 | 0 |

The first M2 aim phase took 1.206 seconds to reach full visual aim in the baseline
and 0.280 seconds with the fixes. The corresponding XM177 times were 0.973 and
0.272 seconds. Each `visual_movement` window retained one native player tick-base
correction; neither contained a weapon or viewmodel field error.

`visual_replay100_mcv_m2c` also completed at 118.9 median FPS with optimization 0:
4,154 rendered frames, zero cache/pose violations, 25,979 replayed movement captures,
and zero native errors between the measured markers. Its paired realm traces have
5,069 matching command/entity/hook samples with identical selected speed, ground
and crouch values, both on first prediction and the last recorded simulation.

Keep failed runs too. `visual_baseline` failed because the loader replaces the global
MCV table; the explicit visual helper now uses `MCV.VisualHarness`. `visual_fast100`
retains rejected Lua frame-rate commands and firing/tick-base corrections at about
19 FPS; it is not a passing high-frame-rate test. The XM177 part of `visual_replay100`
recorded firing corrections and the test process exited during trace saving, before
the visual trace was written. Its saved command samples show matching selected
movement values, but the incomplete run is not a pass. Subsequent instrumentation
counts replay cache checks without allocating two large render records per command,
and collects unused trace data between cases to reduce memory pressure.

The completed final runs use the same extended input sequence on both weapons:
sprint/ADS transitions, aim held across sprinting, jump and landing, moving crouched
fire, and rapid sprint/aim reversals. All final render invariant checks pass, including
monotonic aim during a steady input phase and proof that sprint, aim and jump occurred.

| Run | Fake lag | Optimization | M2 / XM177 frames | Movement replays, both weapons | Native errors in measured log |
| --- | ---: | ---: | ---: | ---: | --- |
| `visual_final100` | 100 ms | 2 | 4,172 / 4,157 | 48,140 | 0 |
| `visual_final200` | 200 ms | 0 | 3,260 / 3,254 | 92,463 | 0 |
| `visual_final0` | 0 ms | 2 | 3,564 / 3,453 | 0 | M2: 0; XM177: 10 player tick-base lines from the other instance |

Median measured FPS is about 119 in the 0/100 ms runs and 124 with JPEG capture in
the 200 ms run. The 0 ms XM177 log has tick-base values around 194,800, while its own
trace is between 22,613 and 24,592: those ten lines cannot describe this test player.
The shared-log parser conservatively retains them and exits with status 1; no errors
are silently filtered to make that run green. There are no weapon/viewmodel field
errors in its measured slice. The original user game remained running throughout.

The 200 ms captures are saved as timestamped JPEGs and exported MP4s (about 20 captured
frames per second). The graphs and video exports are derived from the retained data;
they do not replace the engine trace or its higher-frequency render checks.

`visual_gameplay100` rechecks dual-wield inventory switches and airborne M14 fire.
Both finish with matching client/server state and no Lua/harness errors. The airborne
case has zero native errors. The pistol case retains 59 native lines: it overlaps
the other game's explicit gives of `mcv_m1c` and `mcv_l2a1`, with times around 3,030
seconds. It also contains the test's own tick-base corrections around tick 30,000
and a 0.075-second weapon timestamp correction. This is a functional pass, **not**
a clean native-prediction pass. It must not be merged into the zero-error visual
results or used to promise that engine clock corrections have been eliminated.

The separate singleplayer follow-up `p27017/results/visual_sp_final/` completes the
same extended sequence on both weapons: 3,540 rendered frames each, no Lua/harness
errors, no cache/pose violations, and all sprint/aim/jump checks pass. Native
prediction diagnostics remain disabled (`prediction_checked: false`). Only the
owned test processes were closed afterwards; the original game was left running.

### Repeating the visual tests

Only the test instance needs launch options `+engine_no_focus_sleep 0 +fps_max 120`;
do not apply these by restarting a user's existing session. Keep cheats and local
multiplayer enabled as above. The helper is explicitly included and only operates
with the local harness enable marker. It adds no gameplay convars or normal hooks
when inactive.

```powershell
python work/visual_prediction.py --port 27016 --label visual_check100 --lag 100 --extended
python work/visual_prediction.py --port 27016 --label visual_check200 --lag 200 --optimize 0 --extended --capture
python work/visual_prediction.py --port 27016 --label visual_check0 --lag 0 --extended
# With a separately launched singleplayer test instance on port 27017:
python work/visual_prediction.py --port 27017 --label visual_check_sp --singleplayer --lag 0 --extended
```

The runner saves the exact input script, raw console slice, visual trace and a
summary with measured FPS, native errors and render invariant checks. `--capture`
also saves JPEGs and their actual frame timestamps. `--trace` adds the larger paired
command traces for diagnosis. Use `visual_trace_report.py` to analyze retained traces
and `--check` to fail on cache ownership or pose-timing violations. The plotting
helper `plot_visual_trace.py` produces the before/after aim chart from these samples.
Fake lag, tick-base corrections and authored walk/run animation are separate from
cache ownership: do not classify every bone oscillation as a prediction fault.

The ten rollback unit tests now also check movement history across hook order and
rollback, plus all four visual caches under prediction and rendering. Lua changes,
including new NetworkVars, need a map change. Models and hand-tuned sight offsets
are unchanged. The final syntax check accepts 273 weapon, base, harness and generated
data Lua files, and all updated Python harness scripts compile.

## Shooting, reloads, deployment and ammo follow-up

The first animation probe confirmed why native error counts were insufficient.
At zero fake lag, the M2 sometimes first rendered a shot at cycle 0.08, skipping
nearly all bolt motion, whereas repeating the same sequence started around 0.02.
Its minimum measured bolt travel was 0.002 units relative to its parent (effectively
stationary). The clock changed after `PlayAnimation` returned, without a native error.

The Source SDK's viewmodel `RecvProxy_SequenceNum` writes `m_flAnimTime` using the
current world clock on a sequence change. Its viewmodel datamap does predict that
field locally, but it is not a networked error-checked weapon deadline; its cycle
is private/no-error-check. Reading only the base-entity datamap had missed this
viewmodel override. Preserving the timestamp during replay alone did not solve the
post-prediction sequence update. Gating the entire animation call also failed:
the `reload_guard_probe` retained 4 sequence and 11 parity errors.

The final implementation replays sequence, parity, playback rate and gameplay
deadlines on every pass. Two weapon NetworkVars record animation start and signed
duration. Before render bone setup, the local MP client reconstructs the cycle
using its predicted tick base plus the fractional render tick. The same clock
drives reload-related poses and dual-hand recoil poses. `noidle` stages clamp at
their final frame even if the compiled insert sequence has a loop flag; otherwise
an insert could visibly restart one or two render frames before the next command.
Singleplayer keeps its engine-driven timeline. Existing weapons without the new
accessors tolerate Lua refresh but require a map change for the complete fix.
Only the local owner's viewmodel uses this reconstruction; remote/spectated owners
retain the engine clock. An unchanged animation also keeps its furthest rendered
progress during a tick-base correction, briefly holding until the clock catches up
instead of playing old frames backwards. This cosmetic cache is never written by
prediction and resets for a changed sequence, start time, duration or viewmodel.

The XM177 had a separate authored-timing issue. Its 20-frame shot pose is stretched
over a 60-frame base, holding the bolt fully back through approximately the first
0.1 of a roughly one-second shot. At 750 RPM the next shot interrupted its return.
The two XM177 Lua definitions use `ShootAnimRate = 0.15` so the mechanism completes
before the next shot. This speeds their firing animation, without changing RPM,
damage, or the separately calculated camera recoil. No models were recompiled.

Deployment now always reapplies the weapon's model, including the dual model when
selected. M203/XM148 launcher modes use the combined launcher model and resume their
deployed activity. Collision bounds and the existing engine-cache update boundary
are preserved. The hip-fire launcher fallback is reverted as described above.

Ammo boxes allocate **one magazine-equivalent total per use**. Distinct ammo types
share that budget; duplicate guns cannot add a second grant for the same pool.
Magazine size sets each round's budget cost. Clipless grenades and one-round rockets
cost a whole share, so sorted pools rotate priority between successful uses. Primary
and secondary pools from MCV and stock guns participate. Reserves stop at the greater
of one magazine or the declared starting reserve, also bounded by the engine ammo
maximum; a weapon with no usable starting-reserve definition stops at one magazine.
No supply ammo is eligible. The hand-held cursor is predicted; a dropped server-owned
box maintains its own cursor. A failed full-reserve use consumes nothing.

Development helpers are explicitly included from `lua/mcv_harness/`; they are not
loaded during ordinary addon use. `reload_prediction.py` records actual animation
calls, render cycles, parent-relative bolt bones and emitted sounds. The shooting
mode uses CreateMove user-command pulses to avoid fake-lag-dependent key-release
delays. `animation_trace_report.py` checks continuity independently of native errors;
`shoot_trace_report.py` measures per-shot mechanism travel. A replayed intermediate
`SetCycle(0)` is expected; only the final rendered timeline is a continuity check.
`supply_deploy_prediction.py` checks the mixed-inventory grant against both realms,
the budget bound, real inventory switches and deliberately wrong model recovery.

Retained checks already completed before the final hold-stage adjustment:

- `shoot_timeline0`: M2 bolt travel at least 1.835 units on each of 19 shots, compared
  with 0.002 before the fix. Seven native tick-base lines in the measured slice came
  from the original game around tick 407,000; this test was near tick 800. The raw
  console also retains temporary Lua-refresh errors from old entities, fixed by the
  accessor guard. This is not classified as a clean console run.
- `shooting_final100`: M2, XM177 OEG and XM177 all had zero native errors and zero
  render-clock disagreement/backward motion across 4,698 rendered frames and 32,212
  movement replays. All recorded shots had measurable bolt strokes. Captures and
  timestamped MP4s are in that results directory.
- `reload_third_baseline` vs `reload_third_fixed100`: M870 custom third-person reload
  sounds fell from 54 calls (50 replayed) to 4 calls (all first-pass). Five additional
  stock player-model reload sounds in the fixed trace occurred outside prediction;
  they are recorded separately, not hidden or counted as replay spam. M2 magazine
  reload emitted its one custom sound once. Both fixed runs had zero native errors.
- `deploy_modes100`: ordinary/dual/M203/XM148 deployment and wrong-model recovery
  passed; no native errors in the real-switch window. Deliberate corruption occurred
  outside that window and is not claimed as a zero-error prediction scenario.
- `supply_inventory100`: six mixed-inventory uses stayed at or below one magazine
  equivalent, supplied every eligible pool including explosives, consumed one box
  each, and matched client/server ammo. Zero native errors.

The initial `reload_empty_final200` had correct ammo and no native errors but exposed
four premature insert wraps on the M870. It is retained as a **visual failure**, not
included in the final continuity passes. Subsequent results are recorded below.

| Retained run | Checks and outcome |
| --- | --- |
| `shooting_verified0` | M2 and XM177 OEG: 17 shots each, zero native errors, zero backward render cycles or clock disagreement. Minimum bolt travel 2.084 / 3.528 units. |
| `shooting_verified200` | Both guns: 17 shots each, zero native errors; every shot has a bolt stroke. One XM177 idle reversal after firing exposed a ten-tick clock correction and prompted the final cosmetic hold. |
| `animation_final200` | Both guns: 17 shots each; 3,778 rendered frames and 54,521 movement replays with no backward cycles or clock disagreement. Minimum bolt travel 2.079 / 3.528 units. XM177 native log is clean; M2 overlaps the original game's M14 give, as detailed below. |
| `reload_hold_final200` | Empty M870, M1897 and M37: zero native errors, all inserts/pump endings completed, identical final clip/reserve totals, no backward cycles during the reload. One pre-action M1897 idle correction is explicitly retained as warm-up evidence. |
| `supply_budget_final100` | Six mixed-inventory grants and a full-reserve refusal pass. No use exceeds one magazine-equivalent; each successful use costs one box, refusal costs none. No native errors. |
| `reload_partial_final100` | M870/M1897 top-ups: 3,821 rendered frames, 23,846 movement replays, no backward cycles or clock disagreement, matching ammo. M870 native log is clean; M1897 retains 20 lines after the original game's M38 give (deadlines around 7,311 seconds). |
| `audio_final100` | Final M870 third-person check: four custom sounds, all first-pass; five stock model sounds outside prediction. No replayed custom sound, no native errors, correct clip/reserve. |

`animation_final200` retains 19 native lines immediately after `Giving Arctic a
mcv_m14` in the original instance. Their deadlines are around 7,204 seconds and
command fields around 480,213; the measured M2 trace is near the beginning of its
new map, remains on M2 throughout, and issues no give/switch during firing. The
shared log is not filtered to zero. This run establishes rendered continuity and
matching action state, while `shooting_verified200` supplies the clean native
200 ms result. No claim is made that every engine clock correction, forced weapon
give or unrelated addon's prediction error has been eliminated.

Reproduce the focused checks on a local MP test instance:

```powershell
python work/reload_prediction.py --port 27016 --label shots --lag 200 --shoot --classes mcv_m2c mcv_xm177_oeg
python work/reload_prediction.py --port 27016 --label shells --lag 200 --empty --classes mcv_m870 mcv_m1897 mcv_m37
python work/reload_prediction.py --port 27016 --label sounds --lag 100 --third --classes mcv_m870
python work/supply_deploy_prediction.py --port 27016 --label budget --lag 100 --only supply
python work/supply_deploy_prediction.py --port 27016 --label models --lag 100 --only deploy
python -m unittest discover -s work -p 'test_*.py'
```

The replay/budget tests pass 18 cases. The final GLua check accepts 278 files; Python
compilation and `git diff --check` also pass. The per-shot comparison figure is
`p27016/results/shooting_verified0/bolt_travel.png`, generated by
`work/plot_bolt_travel.py` from the actual parent-relative bone traces.
The owned port-27016 test process is closed after testing; the original user game
and existing harness enable marker are left in place. No files were staged or committed.

## Sources checked

- [Source viewmodel state and sequence receiver](https://github.com/ValveSoftware/source-sdk-2013/blob/master/src/game/shared/baseviewmodel_shared.cpp):
  local predicted animation-time field, unchecked/private cycle, and the sequence
  receive proxy's timestamp reset.
- [Source client viewmodel interpolation](https://github.com/ValveSoftware/source-sdk-2013/blob/master/src/game/client/c_baseviewmodel.cpp):
  cycle advancement uses final predicted time plus the fractional render tick.
- [Facepunch prediction guide](https://wiki.facepunch.com/gmod/Prediction): rollback,
  NetworkVars, timers, first-prediction guards, and diagnostic commands.
- [SWEP Think](https://wiki.facepunch.com/gmod/WEAPON:Think): realm and movement-order
  differences, including the non-predicted singleplayer client call.
- [Current command](https://wiki.facepunch.com/gmod/Player:GetCurrentCommand): command
  access is only valid in the appropriate prediction context.
- [Deployment discussion, issue 1776](https://github.com/Facepunch/garrysmod-issues/issues/1776):
  `use` and server `SelectWeapon` do not run normal client predicted deployment.
- [Duplicate Holster discussion, issue 2854](https://github.com/Facepunch/garrysmod-issues/issues/2854):
  the extra client call can even report the weapon being holstered to itself, as
  observed in the local command trace.
- [SetupMove](https://wiki.facepunch.com/gmod/GM:SetupMove): shared movement changes
  before movement processing.
- [FinishMove](https://wiki.facepunch.com/gmod/GM:FinishMove): the shared hook after
  movement simulation, used for the completed-command sample.
- [SetPoseParameter](https://wiki.facepunch.com/gmod/Entity:SetPoseParameter): invalidate
  the bone cache after a pose update; late draw-hook updates can cause artifacts.
- [Viewmodel pose-layer discussion, issue 3698](https://github.com/Facepunch/garrysmod-issues/issues/3698):
  animation-cycle and pose-layer choppiness can be distinct from datatable errors.
- [Blocked/removed commands](https://wiki.facepunch.com/gmod/Blocked_ConCommands):
  `con_logfile` is removed, rather than merely unavailable to the Lua harness.
- [Save tables](https://wiki.facepunch.com/gmod/Entity:GetSaveTable) and
  [internal variables](https://wiki.facepunch.com/gmod/Entity:GetInternalVariable):
  client/server field layouts differ; the latter's time example also returns a
  relative value. The next-attack and model-cache behavior above was checked locally.

Lua changes require a **map change** before final testing. No model rebuild is needed
for these tests.

# Weapon hot-path optimization

Research: [Facepunch optimization guidance](https://wiki.facepunch.com/gmod/optimizationTips)
and [LuaJIT statistical profiler](https://luajit.org/ext_profiler.html).
Repeated engine calls, temporary objects and unnecessary frame/tick work are the
first targets. Local function bindings are useful selectively; wholesale aliases,
loop rewrites or GC tuning are not evidence of improved frame times. LuaJIT can
inline Lua code, and its profiler distinguishes native, interpreted, C and GC work.
Profiler module availability in the actual GMod build must be checked before use.

## Implemented and checked offline

* Scalar ballistic integration creates two result vectors instead of seven (no
  drag) or eight (drag), retaining the same analytic equations and return ownership.
* Each physical bullet owns one trace-request/filter pair, reused per substep on
  both realms. Result traces remain independently owned; no global scratch input
  shared between bullets or callbacks.
* Client bullet collision still runs at its existing substep interval. Routine
  beam/smoke position work runs once after those steps, with immediate updates
  retained for terminal contacts, penetration and server adoption/correction.
* Expired HUD hints return before constructing nested control-hint lists and
  reading weapon state. Visible and always-on hints remain live.

`python work/test_hotpath_allocations.py` uses standalone LuaJIT 2.1 with counted
vector stand-ins. In 10,000 flight steps: 70,000/80,000 vector constructions become
20,000. Numeric results match across zero/nonzero drag and different intervals.
Two bullets reuse two input/filter pairs over 20,000 traces. Expired hints avoid
10,000 list-building calls. `test_physbullets.py` checks one pair of smoke control
point writes across twelve collision substeps, plus existing prediction/contact,
penetration, muzzle blend and correction behavior.

These counts describe code operations, not GMod FPS or engine allocation timings.
No in-game benchmarks were run. Earlier shared-base improvements are documented
in `BASE_REFACTOR.md`.

## Shared-base/model/render pass

`sh_modelcache.lua` caches successful attachment, bone and named-sequence indices
and sequence loop flags per entity/model. Weak entity keys release removed entities;
model changes invalidate every cached index. Missing metadata is retried, including
sequence index -1, attachment index 0 and absent bones. Bone/sequence index 0 and
non-looping flags are valid cached results. Weighted activity selection and all
attachment/bone transforms remain live. The cache serves common animation/render
code, gun effects, flamethrowers and physical muzzle capture, so equipment using
named animations benefits too.

Worldmodel tuning strings and dual-wield mirror matrices reuse parsed values until
their convar text changes. HUD availability draws directly, avoiding intermediate
icon-list tables and the duplicate bayonet inventory scan. Shell ejection chooses
one/two ports without allocating a names list; effect dispatch reads the shoot
position once. Flamethrower visual traces reuse their input table and end position.
An unused view-punch read is removed from viewmodel positioning. Physical muzzle
capture now skips disabled/ineligible weapons, reuses its entry and attachment-name
list, and reads world FOV once per capture.

Checks in `test_model_cache_effects.py` and `test_weapon_render_hotpaths.py` cover
10,000 model queries, model/entity changes, missing-to-ready transitions, shell
fallback/dual/volley/replay routing, identical HUD geometry/opacity/order, and live
worldmodel convar changes. Existing animation tests cover loop/clamp transitions
with model invalidation. Physical-bullet tests verify disabled/ineligible capture
doesn't read attachments and eligible capture still follows the rendered muzzle.

## Prediction reads, impact history, and shot dispatch

Viewmodel ammo/pose updates now snapshot clip count, reload state and dual-wield
state once per invocation. Values are never reused across invocations or prediction
commands. `test_vm_state_reads.py` compares 2,304 combinations against checkpoint
`e9b2e0895`, including empty/partial clips, magazine and shotgun reloads, delayed
inserts, dual guns, grenade launchers, hammer inversion, recoil and sparse bullet
bodygroup maps. Every pose/bodygroup write matches; these three getter families
drop from 33,936 reads to 6,912 across the cases (about 80% fewer).

Physical-impact deduplication keeps an ordered expiry queue instead of scanning
every retained hit on every frame. Corrected contacts replace the map entry without
letting the older queued entry erase them. Cleanup processes only expired entries;
occasional compaction bounds queue indices during continuous fire. Clock rollback
and map cleanup clear both structures. `test_impact_expiry.py` checks 10,000 quiet
frames holding 1,000 contacts: one oldest-entry lookup per frame instead of ten
million map visits total, plus strict expiry, corrections, compaction and resets.

Shot sound sample selection uses a shared helper instead of creating a closure
for each near/distant layer. Ranged properties share one owner lookup per layer;
scalar-only scripts require none. Script properties remain live, random seeds and
channels are unchanged. The 1,000-shot regression checks owner reads, selected
samples, levels, volume, channels, raw-file fallback and replay suppression.

## Remaining profiling targets

Measure scope screen captures and world/viewmodel bone setup before changing them;
extra passes can be required by depth shaders and render context. Check dense-fire
loads for water tracing, penetration probes and particle simulation. Consider
numeric arrays or pooled bullet storage only if allocation profiles justify the
extra lifetime bookkeeping. Network culling requires explicit PVS-transition tests.

Do not cache mutable predicted state across commands, skip replay updates with
IsFirstTimePredicted, lower collision sampling to hide cost, pool trace results
retained by callbacks, or cache weighted animation choices. These can alter
gameplay or restore the prediction/effect bugs already fixed. Live convar values,
dynamic key bindings and model changes must retain their invalidation paths.

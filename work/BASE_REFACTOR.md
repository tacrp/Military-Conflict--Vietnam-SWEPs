# Shared base cleanup

Checkpoint before this pass: Part 1 `e9b2e0895`, Part 2 `0f0ed66`.

* `MCV.BulletImpact` owns custom/stock bullet impact dispatch for both hitscan
  and physical bullets. Command prediction and contact deduplication stay with
  their callers; the shared helper preserves the caller's recipient filter.
* Category/stat convar names are built once per pair. Convar lookup and GetFloat
  still happen on every read, so live settings, replacement convar objects and
  late registration keep working. Unknown categories still inherit All.
* Viewmodel shell and particle lists compact in place, preserving draw order.
  Ordinary colour passes no longer allocate three replacement/list tables.
  A world-particle list is allocated only when a world particle is present.
  Depth passes leave the lists untouched.

Offline checks: `test_base_refactor.py`, `test_hitscan_impacts.py`,
`test_physbullets.py`, `test_prediction_replay.py`, `test_viewmodel_depth.py`,
`test_scope_capture.py`, and GLua syntax checks. The base test exercises 10,000
stat reads without rebuilding names, live settings and late registration,
stable effect ordering, list identity, invalid-effect cleanup and depth passes.

## Base consolidation and hot paths

The registered `mcv_base_core` class is removed. Common behavior now lives under
`lua/mcv/weapon_common`. Its loader builds one template per realm and composes it
into the gun, throwable, melee, placeable and supply-box bases before their own
overrides. Those bases inherit directly from `weapon_base`. Functions are shared;
default tables are copied separately. Shared hooks register once. Gun defaults
that duplicated common defaults and six duplicate module loaders are removed.

Internal direct core calls now use `MCV.WeaponCommon`; spawn-menu membership uses
the existing `MilitaryConflictVietnam` marker. Tests and custom compile tools use
the new module paths. External addons referencing `mcv_base_core` need updating.

The viewmodel's full bodygroup clear now happens on deploy/model/viewmodel changes,
not on every predicted tick. World bodygroup indices are cached until the model
changes; their actual predicted values are still read and updated on every pass.
The bone-restoration hook tracks adjusted owners instead of allocating/scanning
the whole player list each frame, including NPC owners. The rotated HUD icon
reuses four vertices rather than creating ten tables for each draw.

`test_weapon_composition.py` compares both realm definitions against checkpoint
`e9b2e0895`: all five bases retain their defaults and method sets, hooks load once,
and default tables remain isolated. `test_base_refactor.py` checks 10,000 stable
ticks with four bodygroup-name lookups and one full viewmodel reset, followed by
model swaps, dual-wield changes, deploys and restored prediction state.

No in-game verification or FPS benchmark was run. Restart Garry's Mod for this
structural change so the old registered base cannot remain cached. This pass does
not alter bullet flight, damage, network formats or weapon-specific configuration.

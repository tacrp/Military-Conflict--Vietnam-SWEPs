# Porting MCV viewmodel QCs to Garry's Mod

This documents what the hand-ported QCs in `MCV_SMD/weapons` do compared to the game's originals
in `MCV_SMD_OG/weapons`, how `port_qc.py` reproduces it, and what it does differently on purpose.
It was reverse-engineered by diffing all 204 pairs; the older `qc_methods.md` is the
human-written version of "Method 1" and is still accurate.

## Quick start

```
cd work
python port_qc.py MCV_SMD_OG/weapons/v_sks                  # one weapon -> MCV_SMD_PORT/weapons/v_sks/v_sks.qc
python port_qc.py MCV_SMD_OG/weapons --all --report r.json  # everything
python port_qc.py MCV_SMD_OG/weapons/v_dual_m1911 --compile # also test-compiles with GMod's studiomdl
```

The generated QC references the SMDs in the OG tree by relative path, so nothing is copied.
If `MCV_SMD/weapons/<name>/anims/<file>.smd` exists it is used instead of the OG file. That is
how the hand-edited pump animations (M1897, M870, M37, China Lake) and the MD63/M203 fixes are
picked up; put any future Blender-fixed SMD there and the script will prefer it.

`--compile` runs `GarrysMod/bin/studiomdl.exe` with a scratch game directory
(`work/compile_test_game`, created on first use) so nothing is written into the real
`models/` folder. The compiled files land under that scratch directory.

Switches that change behaviour:

| switch | default | meaning |
| --- | --- | --- |
| `--mode` | auto | normal / shell / dual / other; auto detects from the QC |
| `--base-len` | 60 | length of the idle base under a pose layer, see "Timing" below |
| `--pose-recoil` | auto | pose-parameter recoil layers; auto = dual wield only |
| `--keep-ik` | off | keep `$ikchain` / `ikrule` lines |
| `--copy-smd` | off | copy SMDs next to the output instead of referencing the OG tree |

## What the hand port does (and the script reproduces)

Categories are detected as: `dual` (name starts with `v_dual_`), `shell` (has
`ACT_SHOTGUN_RELOAD_START`), `other` (no `ironsight` pose parameter: melee, throwables, tools),
`normal` (everything else).

### All weapons

1. `$modelname "weapons/X.mdl"` becomes `weapons/mcv/X.mdl`; `$cdmaterials models\Weapons\...`
   becomes `models\weapons\mcv\...`.
2. `$include "../../militaryconflict_vietnam_v2.qci"` is inserted after the `$bonemerge`
   block. The qci defines the ValveBiped hand bones on top of the UE-style skeleton so GMod
   player hands (c_hands) merge. v2 is the one used by all 199 ported files; v3/v4 were
   experiments for the IK problem (see below) and are not used.
3. Every `$ikchain` and every `ikrule` line is removed.
4. Activities are renamed to GMod activities that the Lua base plays. The full table is
   `ACT_MAP_COMMON` in the script; the common ones:

   | original | GMod |
   | --- | --- |
   | ACT_VM_IDLETONEARWALL / NEARWALL / NEARWALLTOIDLE | ACT_VM_IDLE_TO_LOWERED / IDLE_LOWERED / LOWERED_TO_IDLE |
   | ACT_VM_PRONE | ACT_VM_CRAWL |
   | ACT_VM_BASH | ACT_VM_HITCENTER |
   | ACT_VM_FIRSTDRAW | ACT_VM_READY |
   | ACT_VM_DEPLOYSHOOT | ACT_VM_PRIMARYATTACK_DEPLOYED |
   | ACT_VM_BASH_BAYONET / SLASH_BAYONET | ACT_VM_HITLEFT / HITRIGHT |
   | ACT_VM_BAYONET_EQUIP / UNEQUIP | ACT_VM_ATTACH_SILENCER / DETACH_SILENCER |
   | ACT_VM_IDLETODEPLOY / DEPLOYTOIDLE | ACT_VM_DEPLOYED_IN / DEPLOYED_OUT |
   | ACT_VM_GRENADE* | the *_M203 activities |
   | ACT_VM_SCOPE_ADJUST | ACT_VM_FIDGET |
   | ACT_VM_BOLTPULL | ACT_VM_RELOAD_INSERT_PULL |
   | ACT_VM_FIREMODE1 / FIREMODE_DEPLOY | ACT_VM_IFIREMODE / DFIREMODE |
   | ACT_VM_PRIMARYATTACK1 / 2, SECONDARYATTACK2, HAULBACK2 | ACT_VM_PRIMARYATTACK_1 / _2 / _3, ACT_VM_PULLPIN |

5. Sound events `{ event 5004 N "Weapon_..." }` get the `MCV_` prefix (the soundscripts were
   renamed to avoid clashing with other packs). The hand port missed 30 of these.
6. `$includemodel "weapons/gesture_animations.mdl"` is pointed at
   `weapons/mcv/gesture_animations.mdl`, which is where the addon actually ships it.

### Normal guns (Method 1)

7. Static pose animations that the game stored at `fps 0.5` become `fps 30`, one held frame
   (`frame 1 1` for `ironsight` and `ironsightdeploy`, `frame 0 1` for everything else:
   `ironsight_transition`, `HammerPos*`, `grenade_ironsight`) and `numframes 60`.
   `frame 0 1` on the ironsight pose makes the weapon twitch in ADS, hence the special case.
8. The idle sequence becomes a three-way blend `basePose_a / ironsight_transition / ironsight`
   over `blend "ironsight" 0 1`, `blendwidth 3`. The game drove ADS with a
   `blendlayer "ironsight_test" ... poseparameter ironsight` layer instead; that line and the
   `ironsight_test` sequence are removed. `loop` is removed from the three idle animations and
   `basePose_a` gets `numframes 60` so all three are the same length.
9. Every sequence that is a `delta` layer and carries an activity (the shots, the deployed
   shots, grenade shots, bolt pulls, revolver hammer cocks) is split in two:
   * `<name>_pose`: the original delta blend, `snap`, `hidden`, no activity, no events.
   * `<name>`: a copy of the idle's three animations (each duplicated as
     `<anim>__f60` with `numframes 60`), the activity, `blend "ironsight" 0 1`, `blendwidth 3`,
     `snap` for fire activities or `fadein 0.1 / fadeout 0.2` for cycles, the idle's movement
     layers (`walklayer` + `runlayer`), any other layers the idle carries (`SlidePosition`,
     `BulletCounter`, hammer layers), any layers the original delta carried
     (`BoltshootMovement`), and finally `addlayer "<name>_pose"`.
   Animation events only fire from the main sequence, never from `addlayer` layers, so the
   script moves them to the main sequence. For fire activities `AE_MUZZLEFLASH`,
   `AE_CLIENT_EJECT_BRASS` and `AE_WPN_CLIP_TO_POSEPARAM` are dropped because the Lua base does
   those itself (keeping them double-ejects). Cycle sequences keep their eject event, which is
   what the Lua `NoEjectOnShoot` weapons rely on.
10. `draw`, `Firstdraw` (`ACT_VM_READY`) and `holster` swap `walklayer` + `runlayer` for
    `walklayerironsight`; reload sequences lose `addlayer "walklayerironsight"` (hands clip).
11. `loop` is removed from every animation used by a pose-parameter layer that the idle calls
    (`SlidePosition`, `BulletCounter`, `HammerPosition`): a looping animation in one of those
    layers is what caused the jerking fire animations found in October 2024. If those blends
    have unequal lengths the shorter one gets `numframes` to match (the hand port's
    `Slideback: numframes 24`).
12. Any sequence that blends one of the new 60-frame static poses with a shorter animation
    (`deploy`: `deploy_a` 6 frames + `ironsightdeploy`) gets the shorter one frozen on frame 0
    and extended to 60, as the hand port did by hand.

### Shell-based guns

Same as normal plus: `ACT_VM_BOLTPULL` becomes `ACT_VM_RELOAD_INSERT_PULL` and its sequence is
pose-split like a shot but without `snap` and with the eject / hammer / sound events kept on the
main sequence. `ACT_SHOTGUN_RELOAD_START / FINISH / PUMP`, `ACT_VM_RELOAD` are unchanged and
`ACT_SHOTGUN_RELOADEMPTY_START` becomes `ACT_VM_RELOAD_INSERT_EMPTY` (the Lua only plays it when
`SWEP.ShotgunReloadEmptyStartAnimation` is true, which is what the Shanxi Type 17 and C96 bug in
the bug list is: the Lua files do not set the flag).

### Dual wield

Same as normal, plus a second activity table because the game used `SECONDARY_*` activities for
the both-hands actions and the Lua base uses `MISSRIGHT*` for single-hand reloads:

| original | dual pistols / SMGs | dual shell loaders (revolvers, IZH43) |
| --- | --- | --- |
| ACT_VM_SECONDARY_RELOAD | ACT_VM_RELOAD | ACT_VM_RELOAD2 |
| ACT_VM_RELOAD | ACT_VM_MISSRIGHT | unchanged |
| ACT_VM_RELOADEMPTY | ACT_VM_MISSRIGHT2 | unchanged |
| ACT_VM_SECONDARY_RELOADEMPTY | ACT_VM_RELOADEMPTY | unchanged |
| ACT_VM_PRIMARYSHOOTLAST / SECONDARYSHOOTLAST | ACT_VM_PRIMARYATTACK_EMPTY / ACT_VM_SHOOTLAST | same |
| ACT_SHOTGUN_PRIMARY_RELOAD_FINISH / RELOAD_CHANGE | | ACT_VM_RELOAD_END_EMPTY / ACT_VM_RELOAD_END |

Left-hand shots (`ACT_VM_SECONDARYATTACK`) are pose-split exactly like right-hand ones.

## Where the hand port was inconsistent

Found by scanning all 204 files; the script applies one rule everywhere.

* 309 pose layers kept `node "Fire"` and 288 kept their `AE_*` events. Layers never fire
  events, so the events were silently dead; sound events inside pose layers (some `shootlast`
  metal sounds) never played.
* 130 pose-split main sequences have no `snap`, 23 pose layers have no `snap`, 20 keep a
  `fadein`.
* 339 shot sequences use `walklayer` + `runlayer`, 211 use `walklayerironsight`, 44 have no
  movement layer at all.
* Pose layer names vary (`shootpose1`, `shoot1_pose`, `shootlayer1`, `shoot1pose_r`); the script
  always uses `<sequence>_pose`.
* 157 files still define the unused `ironsight_test` sequence.
* 30 sound events were left without the `MCV_` prefix.
* 60 activities in the hand port are not GMod activities and can never be selected from Lua
  (`ACT_VM_PICKUPSTART/LOOP/END`, `ACT_VM_CHARGE_*`, `ACT_VM_CRAWLDEPLOY`, `ACT_VM_FIREMODE2`,
  the `_GL` variants, `ACT_VM_EMPTY_DRAW`, the melee `ACT_VM_SLASH/STAB/RUN/WALK`). The script
  keeps them but warns; they need either a Lua-side sequence-by-name lookup or a rename to a
  spare GMod activity (`ACT_VM_IDLE_1..8`, `ACT_VM_PRIMARYATTACK_4..8` are free) if you want
  the pickup, charge, deployed-crawl and melee run animations back.

## Timing: the 60-frame base

An `addlayer` layer plays in sync with the parent sequence's cycle. The parent of every pose
layer is the 60-frame idle copy, so a 25-frame shot pose is stretched to 60 frames and played
back at the Lua rate (`PlayAnimation(..., 0.5)`, now `SWEP.ShootAnimRate`). For the shots this
is by design and looks right. It is the cause of the bug-list items where the pose is much
shorter than a shot:

* RPK / TUL-1 bolt too slow when deployed: the deployed shot pose is 10 frames stretched to 60.
* Manual actions with wrong eject timing: the pump events were re-timed by hand for the
  stretched sequence (M1897 `MetalStart 1 -> 9`, `MetalEnd 5 -> 24`) while the eject frame was
  not.

`--base-len normalize` gives every pose-layered sequence the same stretch ratio as the weapon's
primary attack (so a 10-frame deployed shot gets a 30-frame base when the hip shot is 20 frames
over 60). `--base-len match` uses the authored length and keeps events on their authored frames,
but then `SWEP.ShootAnimRate` has to be 1 and `CycleSpeed` / `CyclePostDelay` retuned. Use these
only on the guns that need it; leave the default for the rest.

## Pose-parameter recoil for dual wield (new)

With sequence-based shots, firing the left gun restarts the whole viewmodel sequence and snaps
the right gun out of its recoil. The script can instead emit, for each hand, a hidden delta
layer on the idle whose blend is driven by a pose parameter:

```
$poseparameter "recoil_r" 0 1 loop 0
$sequence "recoil_layer_r" {
    "rc_r_shoot1_r_a_f00" ... "rc_r_shoot1_r_a_f24" "rc_r_shoot1_r_a_zero"        // hip row
    "rc_r_shoot1_r_ironsight_a_f00" ... "rc_r_shoot1_r_ironsight_a_zero"           // ADS row
    blend "recoil_r" 0 1
    blend "ironsight" 0 1
    blendwidth 13
    delta
    hidden
}
```

Each `rc_*_fNN` is one frame of the hand's shot animation (`frame NN NN`, same `subtract` as
the source) and `*_zero` is a zero delta, so pose value 0 is the first frame of the recoil and
1 is rest. The Lua side (`SWEP.AkimboPoseRecoil = true`, `SWEP.AkimboRecoilTime`) stamps
`LastShotTimeR/L` on each shot instead of playing a sequence and scrubs the pose parameters every
frame from `DoBodygroups`. Both hands recoil independently, the idle sway and walk/run layers keep
playing, and nothing snaps. The normal shot sequences are still compiled so the Lua can fall back
(last-shot slide lock, volley and double-action still use sequences). This uses only the standard
blend mechanism the models already rely on for `ironsight` and `SlidePosition`, so it compiles
with GMod's studiomdl; it has not yet been checked in game.

## IK

The originals use `$ikchain rhand/lhand` and per-animation `ikrule ... touch "rhand_ikTarget"`
so the hands stay glued to the weapon while layers blend. The port removes all of it, which is
why sprint and ADS transitions on some guns (Sterling, M203/GP25 hands) drift. Nothing in the
GMod changelogs from October 2024 to May 2026 adds or changes viewmodel IK; the only IK entries
are crash fixes (November 2025, April 2026). The v3/v4 qci experiments (re-parenting the
ValveBiped hand bones onto the `*_ikTarget` bones) are still in the tree. `--keep-ik` compiles
the original chains untouched if you want to re-test.

## What GMod added since 2024 that is useful here

* November 2025: new studiomdl QC commands `$defaultfadein`, `$defaultfadeout` (one line
  instead of per-sequence fades), `$lcaseallsequences`, `$redefineattachment`, `$appendsource`.
  `util.GetModelInfo` now returns sequence events, and since April 2026 also `ActivityID` per
  sequence, so a Lua script can verify a compiled model's activities and events without opening
  it in a model viewer.
* July 2025: private animation events are registered as client events too, so custom
  `AE_WPN_SET_POSEPARAM`-style events reach `SWEP:FireAnimationEvent` reliably.
* April 2026: `PreDrawViewModel` / `ViewModelDrawn` receive the STUDIO render flags, which lets
  the base skip per-frame work on shadow or reflection passes.
* March 2025: studiomdl reports `numframes 0` in a `$sequence` as an error instead of crashing.

## Bug list items that are QC / port issues

* RPK, TUL-1 deployed bolt speed: base-length stretch, see Timing (`--base-len normalize`).
* Manual-action eject delay: events re-timed by hand for the stretch; `normalize` or `match`
  keeps the authored frames.
* PTRD-41 idle jitter: the ported idle has only `basePose_a` (no ironsight blend, no `frame`
  hold) while the deployed idle uses `ironsightdeploy` with `frame 1 1`. The script now
  produces the three-way idle for it like every other gun.
* Shanxi Type 17 / C96 missing empty reload start: the sequence is compiled
  (`ACT_VM_RELOAD_INSERT_EMPTY`) but the Lua files lack `SWEP.ShotgunReloadEmptyStartAnimation
  = true`.
* Revolver firemode order and switch animations: the QC activities are right
  (`ACT_VM_FIREMODE` / `IFIREMODE`); the order comes from `SWEP.Firemodes` in Lua
  (single, double, fan) and `changefiremode_tohammer` is compiled as `ACT_VM_FIREMODE2`, which
  GMod does not have.
* Dual revolver double-action reload, dual-wield ironsight offsets, M79 ammo switch, slam fire:
  Lua, not QC.
* Sterling / M203 / GP25 hand drift, sprint-ADS transitions: IK removal, no QC fix available.

## World models

`port_qc.py` handles `w_*` directories too (`--all --only w`). The hand port changed only three
things and the script does the same:

1. `$modelname "weapons\X.mdl"` to `weapons\mcv\X.mdl`, `$cdmaterials` to `models\weapons\mcv\`.
2. A `ValveBiped.Bip01_R_Hand` root bone is added and every root bone of the model
   (`ValveBiped.weapon_bone` on most guns) is re-parented under it, so the model bonemerges to
   the player's right hand. Only 15 of the 198 hand-ported world models had this; the rest only
   had the path changes and therefore float at the player's origin.
3. The hand bone gets the offset `x y z ry rz rx` from `HAND_OFFSETS` (note the order: Crowbar
   writes `$definebone` rotations as ry, rz, rx), else the `qc_methods.md` starting value
   `-6 -1 -2 0 0 180` with a warning. Be aware that on a bonemerged model the player's hand
   replaces this bone entirely, so these values only affect the unmerged (dropped) pose.
4. Placing the gun in the hand therefore has to move the model data: `--tilt DEG` pitches the
   barrel up and `--move FWD UP RIGHT` shifts the gun, both in the gun's own frame, by rewriting
   the root gun bone's frames in every animation SMD the QC plays (written to
   `<name>_anims_tilted/`). The barrel and up axes are read from the reference mesh and the
   muzzle attachment. The SKS uses `HAND_TILT["w_sks"] = 7.5`.
5. Dual-wield world models get a mirrored `ValveBiped.Bip01_L_Hand` and bones named `*_left` /
   `*_l` are parented to it. None of the hand-ported duals did this, so the left offset is a
   guess to be tuned in game.

Four world models in the fixed tree (`w_lpo50`, `w_m1g_s`, `w_m9a1`, `w_r76`) use a different
scheme (a full hand transform parented to a `ValveBiped` root); those lines are reused as they
are when no table entry exists.

## Ripping the game directly (`rip_game.py`)

`rip_game.py` reads the game's `pak01_dir.vpk` (through `vpklib.py`, a small VPK v1/v2
reader) and the loose `scripts/` and `resource/` folders, and updates the addon in steps:

| step | what it does |
| --- | --- |
| `scripts` | copies `scripts/weapon_*.txt` into `work/cscripts` |
| `strings` | reads `resource/vietnam_english.txt` (UTF-16) into `work/strings.json`; `port_weapon.py` uses it for display names and countries |
| `models` | extracts every `models/weapons/v_*`, `w_*` and `gesture_animations` file into `work/rip`. Models whose CRC changed are imported from a Crowbar 0.74 batch decompile (`--decompiled <folder>`, see below) or, when they use the classic animation storage, decompiled with `tools/CrowbarCommandLineDecomp.exe` (Crowbar 0.68 fork) into `work/MCV_SMD_OG/weapons` |
| `port` | `port_qc.py --all --compile --jobs N` over the decompiled tree, into `work/compile_test_game` (`--jobs`, default cores minus 2; the serial run takes about three hours, twelve jobs about fifteen minutes) |
| `install` | copies the compiled model sets that succeeded into `models/weapons/mcv` (deleting any stale `.ani`), and the game's `models/weapons/<subdir>` models (shells etc.) as they are |
| `materials` | every `materials/models/weapons/<dir>` that a weapon QC references, into `materials/models/weapons/mcv/<dir>` with the texture paths inside the VMTs rewritten |
| `sounds` | `sound/weapons` and `sound/foley` into `sound/mcv`, then `vietnam_sounds_weapons.txt` and `vietnam_sounds_foley.txt` through `parse_soundscripts.py` (which now drops the `~` and `` ` `` sound characters GMod does not know) |
| `particles` | all `particles/*.pcf` |
| `particle_materials` | scans the pcfs for material names (they are stored as `effects\vietnam\x.vmt`) and pulls those VMTs plus every texture they reference |
| `icons` | renders `materials/panorama/images/icons/equipment/weapon_*.svg` white on transparent, scaled to fit the middle 256x128 band of a 256x256 png, into `materials/entities/mcv_<lua>.png` |
| `lua` | `port_weapon.py --only-new` for weapons without a lua file |
| `effects_lua` | switches every weapon lua's muzzle / brass / tracer fields to the game's particle names and regenerates the pcf list in `lua/mcv/shared/sh_effects.lua` |

`work/rip` and `work/MCV_SMD_OG` are git-ignored (several GB). `work/rip/manifest.json` remembers
the VPK CRC of every decompiled model so a later run only redoes what the game updated.

### Decompiler: Crowbar 0.74 is required for the current game models

The game's current models (MDL v49) store almost every animation in the frame-based format
(`mstudio_frame_anim_t`, animdesc flag `0x40`, rotations as Quaternion48S) and split it into
`.ani` animblocks. Only Crowbar 0.74 decodes that format. Crowbar 0.68 and 0.71 (the two
command-line builds) silently write a constant garbage rotation for those bone tracks and leave
the clavicle at its bind position; compiled into GMod that is a viewmodel frozen in a mangled
bind pose with the gun off screen. The few models still in the classic run-length format (G3,
H&R T223, `gesture_animations`) decompile fine with any version, which is why those kept working.

`rip_game.py --steps models` detects the frame format in the `.mdl` header and refuses to run the
0.68 fork on such models. The workflow for them is manual once per game update:

1. run `rip_game.py --steps models` so `work/rip/models/weapons` holds the current files;
2. in the Crowbar 0.74 GUI, Decompile tab: input = that folder, output = a full path, with
   "Folder for each model", QC, reference mesh and bone animation SMDs in a subfolder ticked;
3. `rip_game.py --steps models --decompiled <that output folder>` imports the result into
   `work/MCV_SMD_OG/weapons` and records the CRCs in the manifest.

Whatever produced the decompile, `port_qc.py` strips `$animblocksize`, `$sectionframes` and
`$bonesaveframe` (`step_strip_animblocks`), so every compiled model keeps all animation data in
the `.mdl` and ships no `.ani`. The engine falls back to the bind pose when an animblock is not
resident, and the earlier working compiles never used them.

`gesture_animations.mdl` (the `$includemodel` every viewmodel pulls in) is ported from the game's
own copy as mode `other`, so its skeleton matches the current rig (`Base` under `BaseRoot`).
Compiling it from the 2024 hand port produced `missmatched parent bones on "Base"` on every model.

Crowbar 0.68 (the command-line fork) also has two QC quirks the port works around: after some
`loop` animations it drops the closing brace and every later `$animation` definition. The QC
parser ends a block at the next top-level `$` command, and `step_reconstruct_missing_anims`
recreates plain `fps 30` definitions (with the `subtract` corrective when one exists) for every
animation a sequence names that has an SMD on disk but no definition.

`port_weapon.py` converts guns only by default (`--all-types` for the rest): the game scripts also
describe grenades, mines, flamethrowers, melee and equipment, which the mcv_base cannot drive.
Brass ids the game added after 2024 (19 to 31) map to the nearest shell model the addon has.

### What the generator reads from the model and the game (second pass)

* **Script to lua matching** (`resolve_lua_names`): through the viewmodel path, then the
  `SCRIPT_ALIASES` table, an exact name, or the closest name when several lua files share a
  viewmodel (kar98 / kar98_s, m1d / m1g). The icons step uses the same function, so a variant's
  icon comes from its own script (weapon_kar98k_s.svg for mcv_kar98_s). Variants that no script
  resolves to get their viewmodel sibling's icon. The game ships no icon for the Cobra, R76 and
  Rhogun; those still need hand-made ones.
* **Under-barrel launchers** (`launcher_folds`): weapon_m203 / xm148 / gp25 share the rifle's
  viewmodel and fold into the rifle script; the rifle takes `SoundGrenadeShot` from the launcher's
  `double_shot` sound and `RifleGrenadeForce` from its `gl_velocity` (m/s to units).
* **Scopes** (`scope_info`): `RTScopeMaterialIndex` is the index of the first `lens_*` (else
  `crosshair_*`) material in the compiled model's texture list; the reticle is the matching
  `crosshair_<suffix>` texture from the optics folder (a VMT is written when the rip only brought
  the VTF). A reticle a lua file already references and that exists on disk wins. A script that
  claims a scope for a model without a lens (Vz.54, G43) gets `HasScope = false`. The game
  reordered the materials of several old models, so `work/fix_lua_flags.py` re-derives the index
  for every scoped lua.
* **Belt / clip bullets**: `$bodygroup "bulletNN"` entries become `BulletBodygroups`.
* **Ejection** (`eject_rule`): `NoEjectOnShoot = true` for revolvers, bolt actions, pumps, rocket
  launchers and any model whose eject event lives outside the fire sequences (break-action
  reload). The shot then leaves the shell to the animation's own `eject` event.
* **Hammer events**: the game's shot animation sets `hammerpos 1`, the bolt / pump animation
  `hammerpos 0`. The base reads the parameter the other way round, so cycle weapons with hammer
  events get `AnimationHandlesHammer = true` and `InvertAnimationHammer = true`; without the
  inverted flag the shot itself releases the action and a bolt rifle fires semi-auto.
* **Volleys**: `VOLLEY_ALL` (Kolos: 7) makes `FIREMODE_VOLLEY` the only mode; `RocketAttack`
  launches one projectile per round with its own spread.
* **Dual single-action revolvers** (`SA_DUAL_RELOAD`: Nagant, Blackhawk) get
  `AkimboDualSingleActionReload`.
* The `empty` pose parameter is 1 when the clip is empty (the game's `SlidePosition` and
  `BoltshootMovement` layers blend from 0.6 to 1 towards the locked-back bolt).
* `$illumposition 0 0 0` on every model.
* **Sight offsets** (`sight_offsets`): `IronsightPos` / `IronsightAng` / `CustomPos` /
  `CustomAng` come straight from the script's `ironsightright/forward/up/pitch/yaw/roll` keys and
  its `CustomOffset` block; they are no longer copied from the existing lua. The first port's
  hand-tuned offsets (x around 0.06, a 0.2-0.4 degree yaw) were made against the previous game
  rig, whose aimed pose had a small per-gun yaw baked into the gun bone (the M16A1's `Base` sat at
  179.7 instead of 180 degrees). The current rig is dead straight, so those offsets pushed every
  front sight left of the rear sight after the recompile. The ironsight animations themselves
  did not change (frame 1 of `ironsight.smd` is identical, bone for bone, in both decompiles, and
  its five frames differ by 0.02 units vertically and not at all sideways, so the frame choice
  cannot cause a lateral offset). `GetViewModelPosition` now applies the angles in Source order
  (pitch around Right, yaw around Up); `work/fix_sight_offsets.py` rewrites the four lines in
  every existing lua. Measured in the harness at 1600x900, the front post sits within 3 px of
  the rear sight centre on the M1911, AKM, M16A1, M14, Kar98, MP40 and SKS.

`work/fix_lua_flags.py` applies the eject, hammer and scope rules to every existing lua file
(dry run with `--dry-run`); `work/glua_check.py` syntax-checks GLua with LuaJIT (needs the
Windows `python` with `lupa`).

### Overrides and rifle grenade variants

`work/overrides/weapon_<name>.txt` holds KeyValues fragments that are merged over the game's
script before conversion. They are ours, so `rip_game.py --steps scripts` never touches them.
Any WeaponData key can be overridden; the custom tag `"MergeInto" "<base>"` folds a weapon into
another one instead of generating it. The game ships its rifle grenades as separate weapons
(`weapon_x_riflegrenade`) that reuse the base rifle's viewmodel; those are folded into the base
automatically (the base gets `HasRifleGrenade` when its viewmodel carries the grenade
animations, and a warning when it does not yet). The four override files for the M14L, MAS-36,
vz. 24 and vz. 54 make that explicit for the weapons added in 2025.

### Game effects instead of stock ones

The pack used GMod's stock muzzle flashes because the pcfs shipped without their materials.
With `particle_materials` in place, `effects_lua` points the weapons at the game's systems
(`vietnam_muzzleflash_*`, `vietnam_weaponeffect_shelleject_*`, `vietnam_tracer_*`). Tracers are
fired from `BulletAttack` with `util.ParticleTracerEx` from the world model's muzzle attachment
(GMod's own tracer is off). Projectiles call `MCV.ExplosionEffect(family, pos, normal, inwater)`
from `lua/mcv/shared/sh_explosions.lua`, which picks the per-surface variant of the game's
explosion system (`Vietnam_Explosion_RPGRocket_Brick` and so on) from the material under the
impact.

## Equipment bases (Sep 2026)

`lua/weapons/mcv_base_core` is the shared core (deploy / holster, predicted timers, movement
blends and hold types, viewmodel pose parameters, HUD, camera, bash). Every weapon type is a
thin base on top of it that fills in hooks (`ThinkWeapon`, `DoBodygroupsWeapon`, `IdleActivity`
/ `IdleSequence`, `GetHUDAmmo`, `GetFiremodeName`...). The game's equipment viewmodels use
activities GMod does not know (`ACT_VM_SLASH`, `ACT_VM_PLANT`, `ACT_VM_GIVE`...), so the
equipment bases play sequences by name (`PlaySequence`); the names are the same across the
game's models of one type.

| base | game types | behaviour |
| --- | --- | --- |
| `mcv_base` | guns | unchanged, now inherits the core |
| `mcv_throwable` | Grenade, SmokeGrenade, Incendiary | LMB overhand throw, RMB underhand (roll when crouched), USE+R fuse presets from FuseTimeMin/Max, entities `mcv_grenade_frag/wp/smoke/gas/molotov`, `mcv_firepool` |
| `mcv_melee` | Melee, Fists, wrench | LMB slash (hit / miss chosen up front), RMB stab, sprint+LMB charge, USE+LMB throws the blade (`mcv_thrown_melee`, pick up with USE), run / walk sequences while sprinting; the wrench repairs LVS (`GetHP/SetHP/GetMaxHP`, `SetDestroyed`, `OnRepaired`), simfphys and plain vehicles on RMB |
| `mcv_placeable` | C4, Mine | C4: plant (LMB), RMB detonates every charge, the weapon stays as the detonator; dynamite: plant lit or throw lit; mines: two steps, mine then stake, tripwire between them, translucent ghost preview drawn client side |
| `mcv_flamethrower` | Flamethrower | stream of `lpo50_flame` from the muzzle, hull-trace damage and ignition, fuel in the reserve, tank blows up when shot from behind |
| `mcv_equipment_box` | Equipment (ammo / medic box) | LMB gives to the player looked at, RMB self, USE+LMB drops `mcv_supply_box` |
| `mcv_binoculars` | Equipment (binoculars) | RMB zoom through the gun base's sight blend, USE+R steps 4x / 8x |
| guns with projectiles | Crossbow, Flaregun | `mcv_proj_bolt` (sticks, hitgroup damage, pick up), `mcv_proj_flare` (light, ignites) |

Ammo types `mcv_grenade`, `mcv_molotov`, `mcv_mine`, `mcv_explosive_charge`,
`mcv_flamethrower_fuel`, `mcv_crossbowbolt`, `mcv_flareround`, `mcv_ammobox`, `mcv_medicbox` are
registered in `sh_common.lua`. `port_weapon.py` writes all of these from the game scripts
(`EQUIPMENT_GENERATORS`); not covered: artillery / napalm / barrage binoculars (need a strike
system), gas masks, parachute, chainsaw, lunge mine, the objective-only C4 and the scripts without
a WeaponType (stielhandgranate, m18 duplicates).

## Test harness (`work/harness.py`, `lua/autorun/sh_mcv_harness.lua`)

A singleplayer game can be driven from outside: `python work/harness.py start [map]` launches
GMod with the harness armed (it is inert unless `garrysmod/data/mcv_harness/enable.txt` exists),
`run tests/<file>.txt` sends a command script and waits, `send "give mcv_sks" "wait 1" "shot x marker"`
runs ad-hoc commands. Commands: give / select / strip, pos / ang, key +attack2 (real key presses
through the local player's console), tap, wait, shot <name> [marker] (PNG with a centre cross
and the sight / sequence state), report <name> (weapon and viewmodel state from both realms as
JSON), spawn, lua / clua, cmd / ccmd, quit. Results go to `data/mcv_harness/results`, shots to
`data/mcv_harness/shots`. One GMod instance per account: `start` refuses while gmod.exe runs.
`work/tests/` holds the scripts used so far (sights, equipment, grenade timing, flame, binoculars).

Lessons: everything client side must be driven by networked state in singleplayer (Think never
runs on the client there), a `report` while the flamethrower streamed once hung the game, and
weapon and entity classes must not share a name (`ents.Create("mcv_c4")` made the weapon).

## Weapon Lua from the game scripts (`port_weapon.py`)

```
python port_weapon.py cscripts/weapon_sks.txt         # -> lua_port/mcv_sks.lua
python port_weapon.py cscripts --all                  # all 232 scripts
python port_weapon.py cscripts --all --only-new       # only weapons without a lua file yet
```

The old `weapondata_to_lua.py` asked an LLM to translate the KeyValues; this one is a
deterministic converter whose tables were derived by correlating all 141 script/lua pairs:

| lua field | source |
| --- | --- |
| Slot, SubCategory, HoldType/AimHoldType/SprintHoldType | `WeaponType` table |
| Primary.Ammo (GMod ammo type), Caliber | `primary_ammo` table |
| Country | `origin` table |
| Firemodes | `SupportedFireModes`, overridden from the model: `ACT_VM_RELOAD_INSERT_PULL` on a rifle = bolt, on a shotgun = pump, `ACT_VM_HAULBACK` on a revolver = SA/DA(/FAN), `ACT_VM_RECOIL1` adds volley |
| FireRate | script value when it is RPM; for semi-auto the game stores a cadence cap (40-50), replaced by 300 (250 revolvers, 120 bolt/pump) |
| ClipSize / DefaultClip / Chamber | `clip_size "a/b"`, `ExtraBulletChamber` |
| EjectBrassType | game brass id mapped by shell model to `MCV.ShellTypes` |
| LastShotAnimation, MagInClip, PlayCycleAnimation, ShotgunReload, ShotgunAltReload, HasEmptyReload, ShotgunReloadEmptyStartAnimation, RevolverFiremodePose, AnimationHandlesHammer, RifleGrenadeIsUBGL | presence of the corresponding activities / pose parameters / events in the viewmodel QC |
| Bayonet / GrenadeLauncher / Grenade bodygroup indices | `$bodygroup` names in the viewmodel QC |
| HasBayonet | script `HasBayonet` |
| HasRifleGrenade | script secondary ammo, or the model has grenade animations and a `*_riflegrenade` script variant exists (the addon merges those into the base rifle) |
| HasAkimbo, ViewModelAkimbo | a `v_dual_*` model or `weapon_dual_*` script exists; the `weapon_dual_*` scripts themselves are never converted, dual wield is a mode of the single-wield weapon |
| damage, spread, recoil, shake, penetration, crosshair, weight | copied |
| sounds | `SoundData` with the `MCV_` prefix |
| muzzle flash | GMod stock effect chosen by weapon type (the game's particles need ARC9) |

Values that cannot be derived are copied from an existing `lua/weapons/mcv_X.lua` when there is
one (matched through the viewmodel path): PrintName, IronsightPos/Ang, CustomPos, scope
material, cycle timings, and every gameplay flag above, so regenerating an existing weapon keeps
its hand tuning. For a new weapon those fields carry a `-- TODO tune` marker. `--no-reuse` turns
this off.

Two bugs in the existing files were found this way and fixed in place: all 146 used
`Vietnam_Weapon_Generic.ClipEmpty_01` for the empty click, which is not defined in the
soundscripts (only the `MCV_` names are), and 86 spelled `WoodDamageModifier` wrong. The
existing `EjectBrassType` values also copy the game's brass ids without remapping, so about 80
guns eject the wrong shell model; the generator's values are right, the old files were left
alone since the field has no gameplay effect.

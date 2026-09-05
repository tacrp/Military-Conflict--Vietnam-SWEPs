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
how the MD63/M203 fixes are picked up; put any future Blender-fixed SMD there and the script will
prefer it. The 2024 hand-edited pump animations (M1897, M870, M37, China Lake) were made on the
old rig and, subtracted against the Crowbar 0.74 correctives, threw the gun out of the hands for
the length of the pump; they sit in `MCV_SMD/disabled_pump_overrides/` and the game's own pump
deltas are used.

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
  Fixed Sep 2026: `ACT_VM_PRIMARYATTACK_DEPLOYED` bases are scaled to keep the pose's ratio to
  the hip shot (10 over 20 frames gives a 30 frame base), the hip shot stays on 60.
* The 60 frames are meant at 30 fps. Crowbar writes static poses as `fps 1` (the PTRD's
  `deploy_a` is 5 frames), and a 60-frame copy at 1 fps is a one-minute base: the PTRD's
  deployed shot took a minute. `make_len_variant` now forces `fps 30` on every length variant.
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
* **Bodygroups** (`bodygroups_string`): `SWEP.BodyGroups` comes from the script's `BodygroupData`
  block laid over the model's bodygroup order (`"scope" "1"` = blank on the plain CAR-15 / XM177 /
  M14 early, which otherwise carried the scope body over their iron sights). Unlisted groups are 0.
  `work/fix_sight_offsets.py` applies it to existing lua files as well.
* **Dual Blackhawk run layer**: the dual revolvers' `run_a` animates only the root-level `Base`
  bone (7-10 units of bob) and the game's IK drags the hands after it. On the M1917 / S&W / Lebel
  duals `Base` is a dummy, so without IK the run layer moves nothing and the sprint looks right.
  The dual Blackhawk's gun meshes hang off root-level `BaseLeftMesh` / `BaseMesh`, so the same
  data flew the guns out of the hands. `MCV_SMD/weapons/v_dual_blackhawk/anims/run_a.smd` holds
  those two bones at the corrective's frame 0 (zero delta).
* **Two-axis blend grids**: a pose-split main sequence over an idle that blends `ironsight` x
  `revolver_firemode_pose` has 6 (dual revolvers) or 9 (single) anims and is 3 wide, the
  ironsight axis having three knots. `sqrt(6)` rounded to 2 and the rows slid: the dual revolvers
  fired with the aimed animation when not aiming. Width is 3 whenever the count is a multiple of 3.
* **Crowbar correctives** (`step_fix_correctives` in `port_qc.py`): the `*_corrective_animation.smd`
  files Crowbar writes are subtracted from the delta animations to cancel the constant -90 degree
  rotation it puts on every root-level bone. On the K-50M, K-50M VC and L1A1 SOG it accumulated
  that angle per root bone (-90, -180, -270), so the subtraction left +180 on `BaseRoot`; the walk
  and run layers each added it and the gun sat 28 units behind the camera (nothing visible when
  aimed). Where a corrective disagrees with a bone that is constant in its delta animation, the
  corrective is rewritten to that value in `MCV_SMD_PORT/weapons/<name>/fixed_anims/` and used
  instead. A weapon that is invisible or wildly displaced only when its viewmodel is drawn is
  worth checking against this first (dump the bones with the harness: `BaseRoot` yaw 0 instead
  of 180).
* **Two-axis blends** (`step_pose_split`): a fire sequence rebuilt from a two-axis idle
  (`ironsight` x `revolver_firemode_pose`, 9 anims) gets `blendwidth 3`, one row per axis.
  `blendwidth 9` (the anim count) made the ironsight axis run through all nine poses, which is
  why the revolvers went wild when aimed during the hammer animation.
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

## Scopes (Sep 2026)

`lua/weapons/mcv_base/cl_pipscope.lua` + `materials/mcv/scope_lens.vmt` + `work/shaders/mcv_scope_*.hlsl`.
The scope picture is a **screen reprojection done by the lens material's own shader**. While
aiming, the lens submaterial (`RTScopeMaterialIndex`, the first `lens_*` / `crosshair_*` material
of the model) is swapped for a `screenspace_general` material whose pixel shader samples the frame
captured just before the viewmodel was drawn (`render.UpdateScreenEffectTexture` in
`PreDrawViewModels`, `lua/mcv/client/cl_rendertarget.lua`) and magnifies it around the point where
the scope axis meets the screen. The world is never rendered a second time; per frame that is one
frame copy and two floats. Magnification is `IronsightFov / ScopeLensFov` (`ScopeFOV`, second level
`ScopeFOV2` = `ScopeLensFov2`, from the scripts); the screen keeps the ironsight FOV; mouse
sensitivity follows the scope magnification.

* **Axis point** (`UpdateScopeAxis`): the muzzle attachment's forward (axis closest to the eye's,
  read in PreDrawViewModel where attachments are in world space) projected 4096 units out and
  `ToScreen`, sent as `$c3_x/$c3_y`. The pixel under it shows exactly what is behind it, so the
  picture follows the gun's sway and recoil with no parallax at the centre.
* **In the shader**: exit pupil (bright disc centred on the eyepiece, so the shadow moves with
  the gun; `ScopePupilSlide` can make it slide against the aim point's offset but that reads as
  the shadow wandering and is 0), tube rim, reticle from `$texture1` drawn centred on the aim
  point (not on the lens mesh: the crosshair shows where the shot goes while the gun sways
  around it; the weapon's `ScopeMaterial` texture; the game's crosshair VMTs are model
  materials, some Refract, so only the texture is read), barrel distortion, chromatic
  aberration, edge blur. `ScopeDebug = 1` shows the lens uv, `2` solid red.
  Look constants (`ScopeShadow*`, `ScopeDistortion`, `ScopeAberration`, `ScopeEdgeBlur`,
  `ScopeBrightness`, `ReticleStrength`, `ScopePupilSlide`) are per weapon and pushed once when the
  lens is swapped in (`ApplyScopeMaterial`).
* **Model shader facts found by testing**: `screenspace_general` on a model needs `$model 1`,
  `$softwareskin 1`, `$vertexnormal 1`; with `$softwareskin 1` the vertices arrive pre-skinned and
  `SkinPositionAndNormal(false, ...)` is the right call (the hardware-skinned variant with
  `BLENDWEIGHT/BLENDINDICES` put the lens somewhere else). Its depth state is unreliable: on the
  SVD the scope body, drawn after the lens, painted over it, so `render.OverrideDepthEnable(true,
  true)` is set for the viewmodel pass while the lens is active and reset in
  `PostDrawViewModelWeapon`. `$depthtest 1` alone did not help; `$mostlyopaque` was not the cause.
  Shader model 3 (`_ps3x`/`_vs3x`, `-ver 30`); every `$cN_x` constant must be declared in the
  VMT or `SetFloat` is ignored. Build notes in `work/shaders/README.md`.
* **Eyepiece distance**: the script's `ironsightforward` is not usable as is on most scoped
  models in GMod: on ten of them the eyepiece lens sat behind the camera near plane (you see the
  front sight post through the tube), on six others the eyepiece was larger than the screen.
  `work/tests/scope_fwd_sweep.txt` / `scope_near_sweep.txt` step the forward offset with
  `ScopeDebug = 1` (lens in debug colours) and count lens pixels per step; since the lens disc
  scales with 1/distance, 1/sqrt(count) is linear in the offset and the offset for a target disc
  of 0.55 of the screen height falls out (`work/overrides/weapon_<script>.txt`,
  `ironsightforward`). Every scoped weapon except the two OEGs has one. Judge framing on full
  frames (`work/sight_survey.py`), never on centre crops.
* **Optics materials** (`work/fix_optics_vmts.py`): the game's `lens_*.vmt` and some
  `crosshair_*.vmt` are `Refract` shaders fed by `_rt_SniperScope`, black in GMod; they become the
  glass material the game left commented out in its own files, and translucent reticles.
* **OEG** (`mcv_base/sh_vm.lua`): the frame before the viewmodel is copied into a render target
  and composited over the opaque gun at `OEGSceneAlpha` (0.5), so the gun reads as one
  half-transparent plane instead of a per-face blend that showed its innards. The gun's own
  Refract lens materials refresh `_rt_FullFrameFB` during the draw, hence the private copy.
* Tests: `work/tests/scopes.txt` (all 16 scoped weapons aimed), `scope_sway.txt`, `scope_mats.txt`
  (material list per model against the lens index), `scope_fwd_sweep.txt`.

### `self.BaseClass` is a trap with three levels of inheritance

A weapon's `BaseClass` is its *own* base, not the base of the file the function was written
in. `mcv_flamethrower/sh_flame.lua` called `self.BaseClass.Holster(self, wep)`; for an LPO-50
(`Base = "mcv_flamethrower"`) `self.BaseClass` is the flamethrower class, so the tail call ran
into itself forever without growing the stack: the game froze on every weapon switch after
firing, with nothing in the console. Call the intended class explicitly
(`baseclass.Get("mcv_base").Holster(self, wep)`) or split the shared code into a helper. The
harness reproduces a freeze as a job that never logs `done`; instrument with `lua`/`clua`
wrappers that print before and after each step to find the last one that ran.

## Convars (`lua/mcv/shared/sh_convars.lua`)

Gameplay toggles are server convars (replicated, archived, notify) registered in one place with
`MCV.RegisterConVar` and read through accessors, so the predicted weapon code sees the same value
on both realms. `mcv_realistic_shooting` (default 0, the game's numbers) at 1 picks the addon's own recoil and spread: hip
fire is barrel-accurate (the sighted spread applies at all times, the miss comes from the gun not
being lined up with the eye), recoil from the hip kicks in a random direction and harder, CalcView
takes 75% of the view punch back out so the kick moves the aim rather than the picture, and the
view pulls back a little through a burst. At 0 the game's numbers apply as the scripts have them:
`Lerp(sightamount, BulletSpreadDegrees, BulletSpreadDegreesIronsighted)` times the stance and
movement multipliers, and a fixed view slide of `ViewSlideRecoil.Up` / `.Right` per shot (the
ironsight pair when aiming). The game's `ViewKick*` random kick keys only exist on the melee
scripts, so nothing reads them. Client-only preferences (`mcv_hud_hints`) stay
`CreateClientConVar` in the client files.

## Movement pose (`player_movement`)

The game's walk / run layers blend on `player_movement` in the game's speed units. The walk
layer runs over the whole range, the run layer (the sprint carry, gun swung across the body)
starts at a per-class speed and is full at that class's sprint speed: 148-245 on rifles, 106-195
on the M60, 99-186 on the PK, 80-160 on the LPO-50 (the `runlayer` blend line). The hand port
drove the pose with a flat 100 when walking (and 273 sprinting, above every model's top), which
every rifle is happy with but which put the PK and the flamethrowers a way into their sprint
pose: the gun points left while walking. `port_weapon.anim_timing` reads the run layer range
into `MovementPoseWalk` / `MovementPoseSprint` and `SWEP:GetMovementPose`
(mcv_base_core/sh_think.lua) keeps the walk at 100 but caps it at 95% of the model's run layer
start, and sprints to the model's top. Blending part of the run layer into plain walking (tried
first) reads as "starting to sprint" on every gun; do not. Aiming multiplies the pose by
`1 + IronsightWalkBobbingStrength` (0.75 on most guns), as the hand port did.

## Burst fire

`MCV.FIREMODE_BURST` (scripts with `Burst` in `SupportedFireModes`: M605, T223) fires
`BurstRounds` (3) at the gun's FireRate per trigger pull, counted on the existing `BurstCount`
(rounds fired on this pull). It is a runaway burst: on a burst-fire gun the release of the
trigger does not reset `BurstCount` while it is between 1 and `BurstRounds`, and `ThinkWeapon`
keeps calling `PrimaryAttack` until it gets there, so a burst cannot be paused; it also ignores
the sprint gate and the bash key while it runs and stops only when the magazine empties, the mode
changes or the weapon is switched. When the last round goes out there is a `BurstRecovery`
(0.2 s) wait and, if the trigger is still held, `NeedTriggerPress` (a trigger let go mid-burst
already counts as released, so the next pull starts a fresh burst at once).

## Revolver modes and slam fire

Revolvers cycle hammer (single action), western (fan) and delayed (double action) in that
order, the game's; the switch plays the animation for the target mode (`changefiremode_towestern`
= `ACT_VM_FIREMODE`, `_todelayed` = `ACT_VM_IFIREMODE`, `_tohammer` = `ACT_VM_FIREMODE2`; the dual
models have no western and skip fan). `revolver_firemode_pose` is 0 / 1 / 0.5 for hammer / fan /
delayed (the game's `AE_WPN_SET_POSEPARAM` events). `SWEP.SlamFire` (M1897, M37) lets the pump
cycle run with the trigger held so the gun fires as the action closes.

## Magazine / belt swap times

`MagInTime` / `MagInTimeEmpty` (and `MagOutTime` / `MagOutTimeEmpty`) come from the reload
animations: the frame of the game's `AE_CL_BODYGROUP_SET_TO_NEXTCLIP` event (`_EMPTY` when the
old belt comes out; the mag-in / mag-out foley events as a fallback) over the sequence fps. `AE_WPN_NEXTCLIP_TO_POSEPARAM` (M14 family) and a late `AE_WPN_CLIP_TO_POSEPARAM` (the
crossbow's string is drawn at frame 56) count as mag-in events too. The rounds shown on the
model (`ammo_fraction`, `BulletBodygroups`) keep the old count until the mag-out time, show none
until the mag-in time, then the new count; the `empty` pose (locked-back bolt) drops at the
mag-in time as well, which is what stopped the M14 / XM21 / vz.58 bolts closing and reopening on
empty reloads. The belt LMGs (PK, MG43,
vz59...) had no times at all, so the belt refilled at the first frame of the reload.

## Fire without Ignite() (`lua/mcv/shared/sh_burn.lua`)

`Entity:Ignite` hands the damage to an entity_flame that cannot be shortened and draws its own
sprite. `MCV.Burn(ent, seconds, attacker, inflictor, dps)` keeps a timer per entity, ticks
DMG_BURN every quarter second (the way the M202's fire does) and plays the game's
`burning_character` particle; water or death puts it out. The flamethrowers, flares, fire pools and
incendiary grenades use it. An incendiary grenade (`IgniteRadius` in the script, the M34) spawns a
short `mcv_firepool` (`BurnDuration` 3 s, the M34 effect does not linger) over
`ExplosionRadius + IgniteRadius` instead of igniting everything in range.

## Grenade cooking

The fuse runs from the pin pull (start of the windup): `LaunchThrowable` takes the time already
spent off the fuse, and holding past the fuse forces the throw with detonation in the hand. The
windup animation has to finish before a release throws (`WindupEnd`), and the crosshair pulses a
ring every half second while cooking (`GetCookPulse`).

## Sight survey (`work/sight_survey.py`)

`work/tests/sights_all_*.txt` aim every iron-sight gun with the centre marker and a report;
`scopes.txt` does the scoped ones. `python work/sight_survey.py is_` (or `scope_`) writes
full-frame contact sheets to `work/survey/` and a table of where the bore axis (muzzle attachment
forward, projected 4096 units) meets the screen relative to the centre, worst first. Iron sights
sit within about 25 px of centre; grenade and rocket launchers read 30-150 px below because their
ladder sights are meant to sit above the bore. The Sep 2026 pass found the K-50M invisible when
aimed (corrective animations, above), the CAR-15 / XM177 / M14 early with a scope body over their
sights (bodygroups, above), and the six oversized and four undersized scopes (eyepiece distance).

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
| FireRate | script value when it is RPM; below 20 it is a cadence cap, replaced by 300 (250 revolvers). Bolt/pump guns with a cycle animation get 600: the cycle (`NeedCycle`, released by the hammerpos event) is the delay, the script's 40-100 RPM would add a dead wait on top of it. `ManualAction` guns (cycling inside the shot animation) are capped to one shot per shot animation |
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

# Cosmetic bullet ricochets

## Missing sparks: verified shader fix (2026-09-25)

Authorized live testing on a disposable local MP `gm_flatgrass` instance (port
27018) reproduced invisible original and private sparks beside visible stock
sparks. Particle bounds moved and the systems stayed alive; forcing Render did
not help. Removing the radius initializer did not help either. The same trail
renderer drew with stock `effects/spark`, and the imported material drew with
`render_animated_sprites`, isolating the renderer/material combination.

The original VPK uses **UnlitGeneric** for
`effects/vietnam/vietnam_sparktrails_1`. Our importer had changed it to SpriteCard
because its VTF contains a sprite sheet. Restoring UnlitGeneric immediately made
both original and private sparks visible. The importer now preserves this
material's native shader; other sheet conversions remain unchanged.

Actual RPK bursts against concrete then produced visible flying sparks with
physical bullets (3 ricochet systems) and hitscan (5). Counts were observed without
altering chance or direction. Screenshots are retained in
`work/ricochet_diagnostics/`: `ricochet_compare_1.png` (before),
`ricochet_unlit_restored.png`, `ricochet_physical_afterburst.png`, and
`ricochet_hitscan_afterburst.png`. The earlier emission/orientation fixes alone
did not solve the invisible rendering. Offline mocks could not detect this shader
incompatibility; the fixture now also checks the shipped material shader.

Restart GMod to load the complete material/PCF changes reliably.

To repeat the basic visual comparison, start a harness MP instance on port 27018,
then send `clua include([[mcv_harness/ricochet.lua]]); MCVRicTest.Start()`.
It labels the original flying spark, private ricochet, ordinary metal sparks,
and stock Sparks side by side. `MCVRicTest.Stop()` removes the diagnostic timer,
labels and particles. The renderer/material probe builder is
`work/ricochet_diagnostics/build_probe.py`; its generated PCF was moved out of
runtime `particles/` after testing and is not part of the shipped effects.

## Behavior

Terminal hitscan and physical tracer rounds can add the original flying spark/trail
and an original positional ricochet sound to a normal impact. This is presentation
only: bullet damage, direction, penetration and continuation remain unchanged.
The existing **The game's bullet impacts** setting controls it; stock effects keep
their existing behavior.

Probability uses an artistic hardness weight and incidence angle. Let `i` be
`-dot(incoming, normal)` with unit vectors. Only back-facing/tangent contacts
are excluded; direct hits are eligible. The chance is
`(0.2 + 0.8 * hardness) * (0.35 + 0.65 * (1 - i)^2)`:

| Surface | Hardness weight |
| --- | ---: |
| Metal, metalsteam, metalwater | 0.90 |
| Computer | 0.75 |
| Rock | 0.65 |
| Concrete | 0.55 |
| Tile | 0.50 |
| Brick | 0.40 |
| Asphalt | 0.35 |
| Other surfaces (including flesh) | 0.10 |

Metal has about an 82% dispatch chance at 5 degrees from the surface and 32%
on direct hits. Soft surfaces range from about 28% at grazing to 10% direct.
These are port tuning choices, not
verified original-game probabilities. Once this decision succeeds, the private
`mcv_ricochet` particle emits exactly one flying spark and its original trail.

The extra particle's control points face the reflected direction, with up aligned
to the hit surface using [Vector:AngleEx](https://wiki.facepunch.com/gmod/Vector:AngleEx),
and start 0.25 HU outside the face. Its owner survives five seconds for the trail to finish.
Normal impact control points still face the normal, and the original decal is
always delivered. The separate small flash is not layered onto these impacts.

One accepted ricochet per 125 ms per client bounds audio/particle bursts without
limiting normal effects or decals. Clock rollback resets that cosmetic limit.
Sounds use the original metal/concrete variants, 87 dB, pitch 100, volume 0.7,
through clientside [sound.Play](https://wiki.facepunch.com/gmod/sound.Play).
They do not occupy the firing weapon's channels.

## Ownership and validation

Follow-up live validation used a separate multirun MP instance, restarted after
building the final private material/PCF. Red, green, blue and amber all rendered
in the comparison. RPK fire at 60 degrees from concrete produced 2 physical
ricochets and 3 hitscan ricochets; a tracer-frequency-suppressed burst produced 0.
The physical screenshot visibly shows the blue bouncing trail. These runs used
the ordinary probability rule, not a forced random result. Evidence is retained
as `ricochet_shipped_colors.png`, `ricochet_final_blue_hit.png` and
`ricochet_final_blue_hitscan.png` in `work/ricochet_diagnostics/`.
Offline tests cover exact direct incidence, soft/unknown surfaces, native/player/
physgun colours, damage scaling, successful penetration exclusion and no-tracer
rounds, alongside the existing prediction/deduplication and asset checks.

`BulletImpact` has an optional fourth, positive ricochet opt-in and fifth RGB colour.
Only terminal hits from rounds with a visible tracer opt in. Tracer frequency,
missing tracer families and smoke-only families are respected. Successful
penetration entries, penetration exits, melee, chainsaw
and crossbow surface contacts retain their existing effects. `SurfaceImpact`
carries the start point, bullet marker and colour in the existing effect payload.
RGB uses Magnitude, Radius and Color; CP3 drives both the spark and its trail
through the native smoke-colour operator, normalized to 0..1 as in the smoke
grenade code. A private neutral texture preserves the original sheet, mipmaps,
pixel indices and DXT1 transparency modes while removing the baked yellow colour,
which otherwise suppresses blue tracers. Ordinary impact textures are unchanged.
The builder generates this texture reproducibly with the PCF.
CP2 scales their radii with impact
damage: 0.5x at 10 damage, 1x at 40, 2x at 160, clamped to that range.
The shared tracer resolver handles native amber/green, player and physgun modes.
Physical bullets retain their colour from launch through terminal impact, even
after switching weapons; authoritative contacts carry RGB without needing the
firing weapon in the receiving client's PVS. Unknown surface families keep their
stock impact/blood and can additionally produce a tracer ricochet.
The effect emits locally after the existing SP/MP/NPC recipient filtering and
physical-contact confirmation deduplication; there is no extra network message,
trace or damage call. Cosmetic random choices can differ between viewers.

`python work/test_ricochet_impacts.py` exercises actual Lua with 11,000 deterministic
probability samples, floor/wall/ceiling reflection, control-point initialization,
decals, rate limits, rollback, lifecycle, invalid/stock/non-bullet/exit rejection,
particle creation failure, and physical confirmation deduplication. It checks the
particle child/material and all eight selected sound variants too. The dedicated
PCF is checked for exactly one parent spark, valid child references, deterministic
rebuilding and donor parity outside the intended edits. Combining its actual
velocity ranges with the Lua control-point basis covers 200 extreme velocity,
angle and surface cases, all initially travelling outside the hit face.
Hitscan and physical-bullet regression fixtures cover entry/exit opt-in and
SP/MP/NPC routing, as well as unchanged flight and damage behavior.

No in-game verification. **Fully restart GMod** to load the new particle definition
as well as the Lua changes; a map change alone is not the reload procedure for this fix.

## Missing-spark follow-up

Report: ricochet sounds play with physical bullets enabled, but sparks are not
visible. Sound occurs only after the particle handle is valid, so chance/dispatch
and precaching are not the immediate failure in that path.

Two concrete problems in the previous visual configuration:

- The donor instantaneous emitter chooses 0-1 particles. A zero result leaves
  its `Position From Parent Particles` trail without a parent too, even though
  Lua already accepted the ricochet and plays its sound.
- Its local Y/Z launch variation is -100..100 HU/s. Facing that distribution
  along a grazing reflection using world-up can send the spark into the surface.

`python work/build_ricochet.py` extracts only the scaled flying spark and its trail
into `particles/mcv_ricochet.pcf`. It changes the minimum emitted count to 1 and
local Z velocity to 25..100 HU/s. The reflected basis now uses surface-relative up;
forward/sideways speed, texture, size, lifetime, gravity, collision and trail stay
as authored. Ordinary impact graphs and their emission counts stay untouched.
Re-run this builder after regenerating the scaled impacts.

These fixes eliminate the identified empty-emission and inward-launch cases.
Offline tests do not run GMod's particle renderer, so the reported visual result
still requires confirmation after restarting.

### Direction follow-up

The first emission fix did **not** resolve the report. The user then suspected
the sparks' direction. The old helper created both systems with an owner facing
the surface normal, attached CP0 with `PATTACH_ABSORIGIN_FOLLOW`, and set a manual
reflected pose afterwards. The ricochet's launch initializer read CP1 instead of
the CP0 initialized inside particle creation. The previous Lua test only recorded
setter arguments; it did not check creation pose or subsequent attachment updates.

The helper now positions/orients the owner before each creation and uses
`PATTACH_ABSORIGIN`. The private ricochet graph launches from CP0. Both particle
systems therefore have their correct pose at creation, and neither follows the
owner when its pose changes for the other system. CP1 still supplies the original
surface effects. Source's
[attachment update implementation](https://github.com/ValveSoftware/source-sdk-2013/blob/master/src/game/shared/particle_property.cpp)
initializes fixed attachments once but continually updates following attachments.

The fixture now captures the engine-established CP0 pose at creation and models
attachment updates after both systems exist and after moving/turning their shared
owner. It also reads the launch control point from the actual PCF for its velocity
checks. The installed client DLL was inspected statically (never loaded/executed)
to check the orientation binding's argument order and the initializer's use of
the selected control point. No reversed reflection sign was found.

This corrects the launch setup; it is not confirmation that the reported missing
visual is resolved. A full GMod restart is required for this updated PCF too.

## Original asset investigation

Inspected the installed original game's `vietnam/pak01_dir.vpk`, its client/server
DLL string tables, and our shipped PCFs/Lua without launching the game.

## Confirmed assets

- `particles/vietnam_impact_effects.pcf`: `impact_metal_flying`, with child
  `impact_metal_flying_trail`. The original client DLL contains the parent name.
  It emits 0-1 long-lived sparks, travelling along control point 1's local X
  (25-400 HU/s forward plus lateral variation), with gravity, brush collision
  and bounce. The spark lasts 3-4 seconds; its trail emits for 2 seconds.
- `particles/vietnam_sourceengine_effects.pcf`:
  `ricochet_sparks_contrast_glow_soft`. This is a small, short flash (0.1-0.15 s),
  not a complete flying-bullet effect. Its presence is confirmed, but there was
  no direct reference to this name in the original client DLL string table.
- `scripts/vietnam_sounds.txt`: `Bullet.RicochetMetal`, `Water`, `Concrete`,
  `Dirt`, `Grass`, plus `FX_RicochetSound.Ricochet` and its Legacy alias.
  They use CHAN_STATIC, volume 0.7, SNDLVL_87dB, four variants per sound entry,
  and a five-entry limit in the original game's audio operator stack.
  The Dirt entry actually references the concrete recordings in this install.
- All 24 original WAVs (generic/metal/water/concrete/dirt/grass, four each) are
  already copied into `sound/mcv/weapons/fx/rics/`.
- Both original DLLs contain `vietnam_ricochets_enabled`. The client also contains
  the material sound-entry names above. This establishes native ricochet-related
  code, but does not tell us its angle/chance/damage rules.

Our original impact PCF is byte-identical to the installed game's VPK copy.
The particles already exist in our loaded PCFs; the scaled impact builder also
copies the flying spark under `mcv_scaled_impact_metal_flying` and its child.

## Previous impact path

`lua/mcv/shared/sh_impacts.lua` selects a surface family and sends `mcv_impact`.
`lua/effects/mcv_impact.lua` draws a decal and one numbered family effect.
The ordinary `impact_metal_1/2/3` graphs contain sparks, but none references
`impact_metal_flying`. A scan of all child links confirms that its only connected
system is its own trail. Before this addition, our Lua never explicitly dispatched
the flying spark, ricochet flash or those original ricochet sound entries.

Both ordinary impact control points face the surface normal. The old payload
did not include the incoming shot direction. The original sound operator stacks
are game-specific; simply registering their names does not reproduce those
limits in GMod.

Actual damaging bullet bounces would additionally need shared flight/hitscan
continuation rules, energy loss and a bounce limit. The particle's own bounce
does not provide gameplay ricochets. Exact original-game thresholds remain
unverified from these assets alone.

# Retained weapon clocks and HUD transitions

`mcv_base_core/sh_clock.lua` cancels pending actions and resets absolute deadlines on
Source restore, transition player spawn and map initialization. A global server Think
check also handles a backwards clock jump while the Lua environment remains alive.
It deliberately does not detect rollbacks inside predicted weapon hooks: older command
times there are normal and must be replayed without clearing gameplay state.

The reset covers primary/secondary fire, animation and idle deadlines, deferred actions,
reload stages, delayed weapon switches, recoil, trigger windup and equipment actions.
It preserves clips, reserve ammo, weapon modes and bolt/pump readiness. Datatable setup
only seeds unset fire/scope modes, so repeating setup cannot replace a retained choice.
Client rendering caches are cleared through map initialization and a networked reset
serial. No client gameplay fields are written by the reset.

`lua/mcv_harness/clock_restore_tests.lua` poisons the deadlines with values ten hours in
the future on seven weapon families, then restores each twice. It checks that actions
are cancelled without giving ammunition or changing equipment/modes. All seven pass.
The test covers M16A1, M16A1 M203, M37, Mk2 grenade, C4, wrench and LPO-50.

The map fixtures built by `build_clock_transition_maps.py` use a shared landmark and
transition volume. `clock_transition_seed.lua` marks the weapon Lua tables and seeds
future locks; `clock_transition_watch.lua` records the retained instances after loading.
Run on the isolated harness port 27016, using `changelevel2 <destination> mcv_clock_origin`.
The engine only supports this form of entity-preserving transition in singleplayer.
An ordinary multiplayer changelevel is not evidence that weapon Lua tables were retained.

The real A-to-B and B-to-A transitions retained the marked Lua tables. The final return
check preserved all three clips and fire modes, replaced the ten-hour locks with the
new map's clock and cleared reloading. Subsequent input fired the M16A1 from 7 to 6 rounds
and reloaded to 21. The saved records and `check_clock_transition.py` verify this result.
`tests/clock_transition_after.txt` captures the post-transition state and input sequence;
use it after the new map is ready (the map's lua_run only observes a map's first visit).

The HUD tracks the active weapon before drawing. Incoming weapons begin at blend zero;
outgoing HUDs remain hidden between holster completion and the active-weapon handover.
This removes the one-frame fully-visible flash. The crosshair fades during reload and
stays hidden through the shotgun finishing/pump animation.

`tests/hud_transitions.txt` captures actual rendered multiplayer HUD frames with an M16A1,
M37 and stock gravity gun in the switching sequence. `check_hud_transitions.py` validates
5,051 frames: all four incoming MCV switches start at zero, the 239 outgoing holster
frames never brighten again, and the crosshair remains hidden through reload and the
110 observed frames of the finishing animation before returning to full visibility.
Compact results and the seven-family restore checks are in `work/validation/`.

These are Lua changes, including one new datatable field: change map to load them.
The separate worldmodel rebuild requires a full game restart.

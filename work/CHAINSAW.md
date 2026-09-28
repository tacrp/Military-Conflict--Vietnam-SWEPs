# Chainsaw

`mcv_chainsaw` is in Part 1, under **Melee**, alongside its existing assets.
Hold primary attack to cut. Releasing it plays the original wind-down; sprinting,
safety, using another object and holstering also interrupt cutting. There is no
secondary attack, throwing, fuel requirement or NPC support in this first version.

No original gameplay script or chainsaw-specific sound was found in the available
MCV files. Balance is provisional: 12 slash damage every 0.1 seconds (120 damage per
second while in contact), 128 HU reach, a 6 HU trace hull and 0.15 seconds of spin-up.
Melee and All damage/fire-rate multipliers apply. The weapon info lists damage per
tick, cut rate and reach. Audio now uses the supplied L4D2 chainsaw recordings.

## Implementation

- `lua/weapons/mcv_chainsaw.lua` inherits shared movement, deploy, animation,
  clock-reset and trace behavior from `mcv_melee`. It replaces discrete melee swings
  with predicted held-input state and cooldowns; damage/impact dispatch is server-only.
- Chainsaw and melee modules explicitly load `sh_melee_effects.lua` if its helpers
  are missing, so live weapon refresh cannot call a new helper before the shared
  autorun loader has seen it. The dependency sends itself to clients; already-loaded
  helpers are reused. The regression fixture starts without preloading the helper.
- Flesh hits use the original MCV red/green/orange blood through the shared melee
  effect helper, using the target's blood colour captured before damage (including
  lethal hits). The existing in-game impact setting controls this, with stock
  `BloodImpact` as the fallback. Non-bleeding and mechanical targets retain surface
  impacts. The server includes the shooter in delivery; client prediction never
  dispatches a duplicate effect.
- Idle, cutting and wind-down use the original animations. The original worldmodel
  skins select stationary, slow and fast chain materials for other players.
- `lua/mcv/client/cl_chainsaw.lua` owns the active loop and a startup/shutdown patch.
  It changes recordings only on state transitions, outside command
  replay, and stops on holster, death, PVS loss, removal, ownership changes, cleanup
  and Lua refresh. All obsolete patches are stopped before creating replacements:
  [CreateSound permits one patch per sound file per entity](https://wiki.facepunch.com/gmod/Global.CreateSound).
- The HUD/spawn icon comes from the original game's `weapon_chainsaw.svg`.

## Rebuild

From the Part 1 addon directory:

```powershell
python work/build_chainsaw.py --compile
python work/test_chainsaw.py
python work/build_melee_blood.py
python work/test_melee_blood.py
python work/glua_check.py "lua/weapons/*.lua" "../mcv-2/lua/weapons/*.lua" "lua/mcv/client/cl_chainsaw.lua"
```

The builder accepts `--game` for the original MCV `vietnam` directory. Without
`--compile`, it imports the icon and prepares the QC only. Compile sources remain in
`work/MCV_SMD_OG/weapons/v_chainsaw/` and
`work/MCV_SMD_PORT/weapons/v_chainsaw/`; no sources are deleted.

The ported cutting/wind-down deltas sit over a 61-frame idle parent. The parent needs
90 FPS for the original 21-frame/30 FPS cutting cycle, and 120 FPS for the original
16-frame/30 FPS wind-down. Cutting also needs its loop flag restored. `prepare()`
applies these corrections idempotently; `port_qc.py` calls it on future ports.
Only the chainsaw viewmodel is recompiled. The extracted icon, compiler log and
installed file hashes live in `work/chainsaw/`.

Offline checks execute the actual weapon/animation/trace code and audio manager,
including prediction replay, cadence, blocked input, sound ownership and cleanup.
They also inspect compiled loop flags/timing, model companions, textures, icon and
sound loop markers. No game was launched; appearance, audible mix and balance still
need playtesting. **Fully restart Garry's Mod** to load the rebuilt model and new weapon.

`build_melee_blood.py` extracts only the three native blood impact systems and
their dependencies into `particles/mcv_melee_blood.pcf`, with private names/IDs.
This prevents the original red particle's name from colliding with Source's
`blood_impact_red_01`. Operators, colours, opacity, materials and timing remain
unchanged; `test_melee_blood.py` checks them against the shipped donor PCFs.
Both chainsaw and ordinary melee hits use these particles. Their effect entity
owns them independently of the victim, initializes position/direction control
points and the zero-velocity CP2, and expires after four seconds. **Restart the
game after adding/rebuilding the PCF**; Lua-only follow-ups need a map change.
## L4D2 audio

The chainsaw uses the supplied `sound/mcv/weapons/weapon_l4d2_chainsaw/`
recordings: idle and high-speed loops at their original pitch, startup 02 on
activation, and die 01 on holster. Revving interrupts the startup clip. Audio
changes follow the final client state rather than replayed prediction commands.
Both loops and transition handles are cleaned up on death, PVS loss, owner
changes, removal, map cleanup and Lua refresh. Offline lifecycle and WAV/loop
marker checks pass; no in-game audio verification was run for this change.
Change maps to load the Lua changes.


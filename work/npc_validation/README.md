# NPC support validation — September 14, 2026

Reference: the locally installed TacRP NPC path and weapon menu. MCV uses the same
separation of server AI fire from player prediction, with the native reload event
refilling the clip. The menu uses sandbox's existing userinfo selection rather than
an extra network message. Individual weapons, random categories and random all are
available in **MCV NPC Weapons** on the spawn-menu bar.

Fresh local multiplayer on gm_flatgrass, multirun port 27017. Combat test targets
were isolated outdoors, with native NPC AI deciding when to fire/reload. No forced
shoot calls. Targets record damage but do not die or flinch out of their lanes.

| NPC | Weapon | Shots | Native refills | Damage recorded |
| --- | --- | ---: | ---: | ---: |
| Combine | AKM | 115 | 5 | 1,684 |
| Citizen | XM21 | 45 | 4 | 580 |
| Combine | M37 | 19 | 7 | 486 |
| Combine | vz. 24 | 24 | 6 | 850 |
| Metropolice | Blackhawk | 27 | 5 | 598 |
| Combine | RPG-7 | 15 | 15 | 7,408 |
| Citizen | Crossbow | 11 | 10 | 392 |
| Combine | M79 | 15 | 15 | 3,598 |

All eight shot, damaged their target and replenished their clips. The final menu
has **201 eligible classes**, after excluding both binoculars from the gun base's
inherited NPC flag. Selection tests covered a random shotgun,
random all, invalid category, explicit weapon overriding random, and menu reuse
after closing. Unsupported bases were absent. Files: `npc_combat_93568557.json`,
`npc_combat_35.json`, `npc_menu_player_93570248.json`, `npc_menu.json` and the final
`npc_menu_only_93587944.json`. The original combat snapshot predates the two
binocular exclusions; final menu validation ran in a freshly restarted instance.

Player smoke: AKM empty reload and fire at net_fakelag 100, then picking up and
firing a dropped NPC AKM. Server/client clips agreed (22 and 27). The warmed-up
repeat logged one engine C_BasePlayer::m_nTickBase correction of four ticks, with
no weapon-field corrections during that capture. This is not a claim of zero
prediction errors across all conditions. console.log is shared by multirun sessions.

Shared edits and new modules passed the GLua checker (277 files). Crossbow sticking
now defers parenting/motion changes until after the physics callback, eliminating
the collision-rule warning seen in the initial NPC test. Flamethrower AI, melee and
thrown equipment are deliberately not registered; alternate fire modes/launchers,
akimbo and bipod operation remain player controls.

Repeat with `work/tests/npc_combat.txt` and `work/tests/npc_menu_player.txt` using
`python work/harness.py run <fixture> --port <test-port>`; set fixture output paths
to that port if changed. A Lua-only update needs a map change.

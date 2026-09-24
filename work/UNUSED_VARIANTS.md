# Additional weapon variants

The M16 Flamer is disabled (`Spawnable = false`, `NPCUsable = false`) because it
is incomplete. Its implementation/assets remain for development; it is excluded
from the spawn menu and random weapon pools.

Lunge Mine throwing is disabled (`CanThrow = false`) because its throw animations
are unfinished. Only contact strike/thrust attacks are available; the throwing
implementation below is retained for development.

Implemented from the available meshes and animation sets. The numbers below are
addon balance estimates, not recovered original-game stats or historical claims.

| Weapon/class | Starting configuration | Basis |
| --- | --- | --- |
| X2F2A2 FAL / `mcv_x2f2a2` | 25-round magazine + chamber, 650 RPM, 45 base damage, auto/semi | L1A1 ballistics/foley; lightweight handling: 3.6 weight, 1.2 aim-speed scale, roughly 15% more vertical/30% more lateral recoil, 6.75 hip spread and reduced movement penalties; no supported bayonet mesh or bipod |
| Uk vz. 59 Belt / `mcv_vz59b` | 100-round belt, 750 RPM, 45 base damage, bipod | Existing vz. 59 handling; 21 visible round bodygroups and one belt group; reload refresh at frames 64/89 |
| Type 56 XM148 / `mcv_type56xm148` | 30-round magazine + chamber; one 40mm grenade | Type 56 ballistics; unfolded-stock handling midway between Type 56-1 and AK-47; XM148 reload/transitions and existing 40mm projectile/spawn-ammo setting |
| M16 Flamer / `mcv_m16_flamer` | Standard 20-round M16 + chamber; one flame cartridge, four total starting cartridges | Rifle and secondary reloads, launcher transitions and muzzle2; 0.8-second burst, 240-unit reach, 8 burn damage per 0.1-second pulse plus brief afterburn |
| Lunge Mine / `mcv_lunge_mine` | One contact explosive; 250 blast damage, 160-unit radius | Strike/stab and hold/throw animations; 90/100-unit reach, 650-unit throw speed; a miss preserves it, a hit or throw consumes it |

M16 flame cartridges use a separate ammo type, so backpack fuel does not become a
large free supply of cartridges. Use + Walk switches rifle/secondary modes, and
Reload replaces the cartridge. The Lunge Mine explodes on contact with a solid
surface or target and can injure its wielder. Use + Attack prepares a throw.

NPCs can use the FAL, belt vz. 59 and Type 56 rifle. AI does not operate their
secondary launchers. The M16 Flamer and Lunge Mine are excluded from NPC selection
until dedicated AI behavior exists.

Eastern definitions and all implementation code are in Part 1. The Type 56 XM148
is explicitly assigned to Part 2, including its icon and view/worldmodel files,
because of its Western launcher. Its Chinese country classification is retained.
FAL/M16 definitions
and their new icons are in Part 2; their pre-existing model assets remain in Part 1.
The belt vz. 59 reuses the supplied standard vz. 59 worldmodel because no dedicated
belt worldmodel was found. Sights/handling are inherited from comparable guns and
have not been visually verified in-game.

The two launcher QCs now give `gl_shoot` the `ACT_VM_ISHOOT_M203` activity and layer
the shot over their launcher idle poses. No Lua activity exception is needed.
`work/build_unused_launcher_activities.py` patches/rebuilds only these QCs and checks
that other sequence activities/events remain unchanged. The importer maps the
activities before its pose split as well. Original SMDs are untouched.

Offline checks:

```
python work/test_unused_variants.py
python work/audit_unused_variants.py
python work/test_npc_pickup.py
python work/test_prediction_replay.py
```

Icons are actual mesh renders, white with translucent dark detail; reproduce with
`python work/build_unused_variant_icons.py`. The belt/magazine bodygroup meshes are
included in the corresponding renders. No image generator or in-game capture used.

Both launcher models were recompiled: fully restart Garry's Mod to load them.
No in-game testing was performed; offline tests do not validate engine collision,
visual alignment, multiplayer particle presentation or balance.

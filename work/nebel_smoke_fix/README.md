# Nebelhandgranate smoke correction

The imported source script incorrectly sets WeaponType=Grenade, ExplosionDamage=225
and ExplosionRadius=250. The shipped Lua now uses mcv_grenade_smoke with zero blast
damage/radius. `work/overrides/weapon_stielhand_smoke.txt` preserves that correction
across script imports and generation. A generation preview confirmed all three
fields; the explosive Stielhandgranate remains a fragmentation grenade.

Fresh map, local multiplayer port 27017, actual primary-attack throw:

- Spawned the smoke entity with the original stick-grenade model.
- Fuse ignited the smoke; its client particle system was valid.
- Effect duration: 25 seconds. Ammo: 2 before, 1 after.
- No blast damage events; a nearby 1,000-health test target remained unharmed.

Fixture: `work/tests/nebel_smoke.txt`. The thrown grenade is held near a target by
the fixture after launch so damage could not be missed by flight out of range.
Results and screenshot are retained here. A Lua-only update needs a map change.

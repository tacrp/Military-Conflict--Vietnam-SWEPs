# Impact scaling and melee ownership

Particle radius = clamp(sqrt(damage / 40), 0.5, 2).
10 damage gives 0.5x, 40 gives 1x, 90 gives 1.5x, 160+ gives 2x.
Gun impacts use DamageGeneric times the damage category multiplier (including All).
This is nominal per-bullet damage, not final health loss or total shotgun/volley
damage. It does not account for distance, hitgroup or penetration attenuation.
Melee/bashes pass their actual strike damage argument, including stab/charge values.

`work/build_scaled_impacts.py` creates namespaced copies of both impact PCFs.
Each system gains MCV's existing rain initializer, Remap Control Point to Scalar,
configured to multiply initial radius (field 3) by CP2.x. Child systems inherit
the control point. GUIDs and fallback names are isolated from original effects.
The Lua effect supplies CP2 before emission. Counts, lifetime, velocity and the
original-game bullet-hole decal sizes are unchanged. Full and cheap effects both
support the scale; the original systems remain untouched.

The melee and bash code previously fired a cosmetic zero-damage bullet on both
realms. The custom effect deliberately bypasses host filtering (needed for the
authoritative bullet impact hook), so giving both realms impact ownership could
duplicate it. Both strike paths now request the custom surface effect only on
the server, using the existing contact trace. They fire a cosmetic bullet only
when the custom handler declines the hit. Misses no longer fire a bash cosmetic
bullet. Predicted attack/animation state still runs on both realms.

Offline checks:

```
python work/build_scaled_impacts.py
python work/test_impact_scaling_melee.py
python work/test_custom_variants_impacts.py
```

These verify PCF initializer wiring, emitter preservation, effect scale delivery,
server-only impact ownership and stock fallback across hits/misses. They do not
emulate Source particle rendering or networking. No game was launched. Fully
restart GMod to load the new PCFs; Lua-only revisions normally need a map change.

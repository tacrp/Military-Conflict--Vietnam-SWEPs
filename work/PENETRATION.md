# Material penetration: first implementation

Hitscan bullets now use the material stats already imported from the game's
`work/cscripts/weapon_*.txt` files. Projectile weapons keep their existing path.
The replicated `mcv_bullet_penetration` switch defaults to 1 and appears under
Options > Military Conflict: Vietnam > Server > Bullet penetration.

The category modification sliders include **Bullet penetration**, including **All**.
Each material depth is multiplied by All and the weapon's own category multiplier;
for example, All 2 and Assault Rifles 0.5 leave assault-rifle depths unchanged. Zero stops penetration.
The material's damage-loss exponent stays unchanged; increasing depth also reduces the
fraction of the penetration budget spent on a wall of the same thickness.

The source script comments explicitly define penetration depth as the maximum
travel inside that material, in Hammer units, and say that larger damage
modifiers leave less damage. The [game's mechanics reference](https://wiki.militaryconflictvietnam.com/index.php?title=Mechanics)
also describes material-dependent loss through walls and objects. Neither source
provides the exact C++ damage-loss equation. This is therefore a documented
first-pass port rule, not a claim of exact original-game damage parity.

## Rules

Metal/grates/vents use Metal, glass uses Glass, concrete/tile use Concrete, wood
uses Wood, and remaining solid-cover materials use Other. The weapon's own
`<Material>PenetrationDepth` and `<Material>DamageModifier` are read directly.

A pellet starts with a depth budget of 1. Crossing thickness `t` costs
`t / materialDepth`. Costs accumulate across cover, so separating two walls
does not give the projectile another full allowance. Damage is multiplied by
`(remainingBudget / previousBudget) ^ DamageModifier` at each exit. A fully spent
budget stops the bullet; damage below 1 also stops. Four exits per pellet is the
upper bound on work, with at most one outward probe per permitted Hammer unit.

Outward probes followed by reverse collision traces locate the actual back face.
The implementation checks that it is the same entity and an outward-facing
surface; it never guesses an exit from a bounding box. BSP traces include the
engine's small collision padding (about 1/32 unit per face). Oblique shots therefore
travel farther through cover. Range falloff uses the complete travelled path,
including the material thickness. Hitgroup scaling and buckshot flags stay in
the existing damage path. Attacker and weapon inflictor are preserved.

Continuations run only on the server, after each preceding FireBullets call has
finished, inside the original shot's lag-compensation window. Per-pellet state
lives in the current shot's local queue. No timers, persistent weapon counters,
extra ammunition consumption, firing animations or muzzle tracers are created.
Each continuation is a single ray with no second random spread roll.

The current scope is solid cover. Characters, flesh, sky and displacement terrain
stop the continuation. Body penetration, ricochets, custom exit effects and a
special penetration killfeed badge are not implemented in this first pass.

## Validation

`lua/mcv_harness/penetration_tests.lua` uses real VPhysics collision volumes and
damage hooks in the local game, not mocked trace results. All 16 cases pass:
five materials, over-limit cover, exact limit, oblique thickness, layered cover,
shared budget across different materials, eight independently budgeted pellets,
attacker/inflictor attribution and disabling the option. The thick world-floor
check also passes. Physics fixtures enable custom collision traces, so the
measurement uses the test volume rather than the display model's hull.

`work/build_penetration_map.py` builds three actual BSP lanes (4-unit metal,
20-unit metal and two 3-unit metal slabs). `work/tests/penetration_multiplayer.txt`
checks the world exit measurements and actual input at 100 ms fakelag.
All three BSP cases pass: thin metal passes reduced damage, thick metal stops
the shot, and the two thin slabs consume the same shared budget. The multiplayer
input interval recorded seven fired rounds and seven target hits through the
thin wall. Saved results are in `work/penetration_map/results/`.

These are functional penetration checks, not a clean native prediction result.
The shared console log contained tick-base and weapon-field corrections and
also activity from the other running game instance, so it cannot establish a
zero-error prediction claim for this run.

`lua/mcv_harness/penetration_multiplier_tests.lua` additionally checks six combinations
against all five material depths in the live game: default, All alone, category alone,
both multiplied, All zero, and category zero. An unrelated category does not affect
the tested weapon. All 30 depth comparisons pass; the test restores the convars.

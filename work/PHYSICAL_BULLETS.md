# Physical bullets

Enable in **Options > Military Conflict: Vietnam > Physical Bullets**. These are
server settings, also available on the Server page. Disabled by default.

| Setting | Default | Meaning |
| --- | --- | --- |
| `mcv_physbullets` | 0 | Travelling bullets for supported firearms |
| `mcv_physbullets_npcs` | 0 | Include NPC fire |
| `mcv_physbullets_pellets` | 0 | Include individual buckshot pellets |
| `mcv_physbullets_velocity` | 1 | Multiply weapon MuzzleVelocity |
| `mcv_physbullets_gravity` | 1 | Multiply Earth gravity |
| `mcv_physbullets_drag` | 0 | Linear drag coefficient, per second |
| `mcv_physbullets_lifetime` | 5 | Maximum lifetime, seconds |

MuzzleVelocity is metres/second; flight converts using 1 HU = 1 inch. Missing
values were copied from matching original game scripts, preserving existing
weapon values. All 201 firearm definitions in the velocity audit resolve a
positive value. Future guns without one retain hitscan. Projectile weapons
retain their existing simulation; this includes HE launcher rounds. A buckshot
mode needs a muzzle velocity to participate, as well as the pellet option.

The server owns damage and traces swept segments at most 1/120 second long.
Gravity and optional linear drag use analytic integration. Existing range
falloff, hitgroups, armor piercing, damage hooks, impact decals and material
penetration remain in use. Penetration attenuates damage but currently retains
speed. Bullets expire at the configured lifetime or 56756 HU of travel, and stop
at sky/solid starts. Invalid owners/weapons and map cleanup remove them.

Flight tests current positions, without hitscan lag compensation. Clients receive
spawn, penetration and termination messages and simulate cosmetic flight with
the existing particle tracer families and beam streaks. Tracer colour preferences
still apply. Messages are broadcast so flight is not limited to the shooter's
PVS; enabling physical pellets increases network and simulation work.

The firing client immediately predicts cosmetic bullets once per command and
pellet, using shared deterministic spread. Server confirmation adopts those
visuals instead of creating another shot; expired predictions retain temporary
tombstones to suppress late echoes. Server penetration updates catch up to the
predicted visual age. Cosmetic contact immediately shows impact effects and
decals; clients also trace material penetration with the shared exit-probing
code. Only the server applies damage. Both flight simulations use substeps of
at most 1/120 second. Unconfirmed predictions expire normally.
Singleplayer/out-of-command fire and other shooters use server spawn messages.

Physical impacts have one effect path. The short server damage bullet suppresses
all engine effects and sends a contact confirmation instead. Clients deduplicate
contacts by shooter/command/weapon/round/pellet/penetration-layer identity.
Matching confirmations within 32 HU do not replay the predicted effect; a
different authoritative hit is displayed as a correction. Impact records expire
and are cleared on map cleanup/clock rollback. Custom surfaces and stock/flesh
fallback share this routing. Already-rendered incorrect decals cannot be undone.

First-time prediction gates MP launch effects, with a singleplayer exception.
Contact effects run later in Think/network callbacks, so they use the contact
identity filter instead of IsFirstTimePredicted (which can be false there even
for a new impact). Singleplayer confirmations are always allowed through this
same exactly-once path. Bullet callback suppression is documented at
https://wiki.facepunch.com/gmod/Structures/Bullet.

The smoke and streak start at the rendered barrel attachment (including the
appropriate dual-wield muzzle), with the captured muzzle offset fading linearly
to zero over the first 1000 HU of flight. This changes only presentation, never
the collision path. Emitted smoke fades after contact instead of being destroyed
immediately; leftover handles are bounded and cleared on cleanup/shutdown.

Smoke uses `particles/mcv_physical_smoke.pcf`, rebuilt with
`python work/build_physical_smoke.py`. The 11 original smoke families retain
their rope renderer, material, colour, lifetime and motion. Their parent-particle
initializer is replaced with emission at moving CP0, and continuous emission
lasts until flight stops. The original parent tracer's smoke depended on native
parent particles, which the Lua flight simulation does not supply. The new
systems are explicitly loaded and precached; CP0 follows the muzzle-blended
bullet head rather than the beam's trailing endpoint.
Smoke uses the original radius, emission-rate setting and position-offset
variation, replacing the earlier half-radius and 120-particles/second overrides.
The original `Remap Initial Scalar` opacity initializer is retained intact:
output field 7 is alpha, with output maximum 0.35 (0.40 for silenced smoke).
The builder checks all original colour/alpha initializer settings byte-for-byte.
An earlier standalone build mistakenly removed this opacity remapping along
with the parent-position initializer, making the trail overly prominent.
All smoke creation/restart paths now initialize both control points and their
orientations before simulation. Emission starts after 20 ms to prime CP history
on a fresh system; an empty effect is never stopped during this warmup. Stale
muzzle attachments fall back to the shot position, and discontinuous server
corrections start a separate rope. These address plausible cold-start/origin
paths; the reported in-game origin artifact has not been reproduced offline.

Water entry/exit traces generate server-only water/slime splashes without
stopping flight. Actual high-latency presentation and particle appearance still
require in-game evaluation. No game was launched for this implementation.

## Offline validation

`python work/test_physbullets.py` checks integration, velocity conversion,
routing, delayed contact, single damage dispatch, penetration continuation,
sky/expiry, water crossings, and client particle lifecycle including map-clock
rollback. It also checks immediate local launches, replay suppression, matching
server echoes, cosmetic contact and the 1000-HU muzzle blend.
These use mocked engine services, not an engine simulation.

`python work/audit_muzzle_velocity.py` reports coverage. `--apply` fills missing
fields only from the matching game script (including recorded source aliases).
`port_weapon.py` now emits this field and preserves existing tuned values.

The particle API is documented at
https://wiki.facepunch.com/gmod/Global.CreateParticleSystemNoEntity.

Restart GMod after installing the new smoke PCF so cached particle definitions
are refreshed. Later Lua-only changes need a map change; no model recompilation
is required.

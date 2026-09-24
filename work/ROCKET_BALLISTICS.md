# Launcher flight profiles

All seven rocket launchers now opt into server-side swept flight. Weapon definitions own
launch speed, gravity and optional boost settings, including when an NPC fires them.
The existing category and All projectile-speed multipliers scale launch and boosted speeds.
Other projectiles (rifle grenades, 40 mm rounds, bolts, flares) retain their existing physics.

| Launcher | Launch speed (m/s) | Boosted speed (m/s) | Basis |
| --- | ---: | ---: | --- |
| M9 Bazooka | 82 | — | Midpoint of the 265–275 ft/s ammunition-dependent range in TM 9-294; not M20 data |
| RPG-2 | 84 | — | RPG-2 manual / Small Arms Survey identification sheet |
| Panzerschreck | 110 | — | Netherlands National Military Museum collection description |
| M202 FLASH | 114 | — | Rounded 375 ft/s, TM 43-0001-26-2 |
| M72 LAW | 144.8 | — | FM 23-25, M72A2/A3 technical data |
| RPG-7 | 115 | 300 | FM 100-2-3; simplified boost timing below |
| Kolos | 110 | 560 | Provisional prototype profile, not primary-source verified |

Sources consulted (historical numbers, not a complete ballistic simulation):

- [TM 9-294, M9/M9A1/M18](https://fr.scribd.com/document/775991658/2-36-Inch-Rocket-Launchers-M9-M9A1-M18)
- [RPG-2 identification sheet](https://www.smallarmssurvey.org/sites/default/files/SAS_weapons-rocket-launchers-RPG2.pdf)
- [National Military Museum: comparison with Panzerschreck](https://collectie.nmm.nl/nl/collectie/detail/257586/)
- [TM 43-0001-26-2](https://uxoinfo.com/uxofiles/enclosures/TM_43-0001-26-2.pdf)
- [FM 23-25, chapter 2](https://www.globalsecurity.org/military/library/policy/army/fm/23-25/FM232_3.htm)
- [FM 100-2-3](https://www.trngcmd.marines.mil/Portals/207/Docs/MCIS/ITEP/RITC-East/FM%20100-2-3.pdf)

Gravity is 9.80665 m/s² for all seven: slower flight produces more drop at the same distance.
Meters convert at 39.3700787 Source units per meter. No arbitrary weapon-specific gravity
cheats. Launchers intentionally use this gravity rather than sv_gravity (which defaults to a
different physical scale). RPG-7 starts a linear 0.4-second boost after 0.1 seconds; this is a
game approximation, not a measured thrust curve. Kolos provisionally boosts for 0.3 seconds
after 0.18 seconds. Wind, aerodynamic drag, temperature and changing mass are not simulated.
These are unguided trajectories; boost stays along the initial firing direction.

Flight uses absolute elapsed time so the sampled positions are independent of tick rate.
Each tick uses `util.TraceEntity` to sweep the same 2-unit-radius sphere for every rocket
from the last position to the new one, then points the visual model
along its current velocity. Collision calls the projectile's existing impact/detonation
behavior with the trace position and normal. Solid hits, including sky surfaces, detonate;
flights older than 30 seconds remove the entity. This explicit path bypasses VPhysics speed limits without
changing global physics settings. Between samples, collision uses a straight segment, not an
exact curved sweep. The native projectile model, effects, blast damage/radius and M202 burning
behavior remain on their existing entities. Collision with breakable glass now counts as an
impact in this swept path rather than the old physics-only glass passthrough special case.

Offline checks: `python work/test_rocket_ballistics.py` tests gravity/drop, boost boundaries,
tick-rate consistency, high-speed impact, sky/lifetime cleanup, client exclusion, speed
scaling, NPC origin/direction and isolation of ordinary/secondary projectile physics.
GLua syntax checks passed. No in-game verification or prediction tests were run.
Change maps to load the Lua changes. Visual interpolation and real engine collision remain
unverified until an explicitly requested in-game test.

Collision uses [PhysicsInitSphere](https://wiki.facepunch.com/gmod/Entity:PhysicsInitSphere)
and [TraceEntity](https://wiki.facepunch.com/gmod/util.TraceEntity), rather than a box trace.
Swept entities retain SOLID_VPHYSICS for the collision model but use SetNotSolid(true)
and disabled physics motion so only the scripted sweep owns flight impacts.

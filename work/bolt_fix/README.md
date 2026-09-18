# Crossbow bolt flight and sticking

The old bolt `OnThink` called `SetAngles(velocity:Angle())` on its flying
VPhysics entity. That cleared the physics velocity approximately every 0.2
seconds. The baseline recorded 1781 units/s of horizontal speed becoming zero
inside one call; subsequent updates repeatedly reset its fall speed. An
otherwise identical control without those angle writes kept moving normally.
The retained `bolt_baseline.json` records both trajectories.

`lua/entities/mcv_proj_bolt.lua` now aligns only the rendered model in flight.
Client VPhysics velocity is not dependable here, so successive interpolated
render positions supply the flight direction. Frames without movement retain
the previous direction. The render override is cleared after drawing; the
physics trajectory is never rotated or reset by this visual adjustment.

Sticking uses the incoming collision velocity, retires flight physics outside
the collision callback, and places the model tip two units into the surface.
The model's compiled idle-pose tip is approximately `(20.03, 0, 0)`, not its
origin. Raw mesh vertices need the bind and current bone transforms before
measuring this: `bolt_model_posed.json` records the transformed bounds. The
model is already oriented along +X in its idle pose.

World bolts stop in place; prop bolts parent to the struck entity after flight
physics is destroyed. The existing glass continuation path remains in use.
`FVPHYSICS_NO_IMPACT_DMG` prevents an additional 5-point crush hit observed in
the NPC test; `Impact` still applies the intended damage and hitgroup scaling.
Pickup and the 60-second lifetime remain. Player/NPC/NextBot body hits remove
the bolt. No model recompilation or weapon-stat change is involved.

## Reproducing and validating

Use a disposable local MP instance, with `sv_cheats 1` (set by the harness):

```powershell
python work/harness.py start gm_flatgrass --mp --multirun --port 27018
python work/harness.py run work/tests/bolt_baseline.txt --port 27018
python work/harness.py run work/tests/bolt_fixed.txt --port 27018
python work/harness.py run work/tests/bolt_lag.txt --port 27018
```

The baseline fixture recreates the old angle-write behavior on one test bolt
only, alongside a control. The fixed fixtures cover:

- Uninterrupted free flight and the actual crossbow's `LaunchProjectile` path.
- Normal and oblique world impacts, each processed once.
- Prop attachment preserved after translating and rotating the target.
- A single intended damage event on an NPC and removal of the body-hit bolt.
- Stable world placement and one round returned through the pickup method.
- Client render direction matching the interpolated flight path.

All seven server cases passed at both zero lag and `net_fakelag 100`, after a
fresh map load. The final client checks recorded 21 and 26 moving render
samples, respectively, all aligned with the flight direction (dot > 0.99999).
Harness job error lists are empty; client checks also write explicit results
and are asserted by the server fixture. Lua syntax checks passed.

Results and screenshots are retained beside this file. `bolt_fixed_93890937.json`
and `bolt_lag_93890407.json` are the final harness jobs. The lag fixture restores
`net_fakelag 0` and both fixtures clean up their own entities and hooks.
Change maps to load the Lua fix; no full game restart is required.

API references: [render angle override](https://wiki.facepunch.com/gmod/Entity:SetRenderAngles),
[physics destruction outside callbacks](https://wiki.facepunch.com/gmod/Entity:PhysicsDestroy),
[raw model meshes and bind transforms](https://wiki.facepunch.com/gmod/util.GetModelMeshes).

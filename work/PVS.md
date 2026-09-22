# Weapon PVS and attachment lifetime

The observer reproduction uses two actual clients on one LAN listen server, not two
independent listen servers. On gm_construct the shooter and observer stand in the
white room at (-2000,-3000,-100) and (-2150,-3000,-100). The observer's PVS includes
the shooter but excludes (0,0,0). Moving the shooter to (1000,2000,100) makes it
dormant on the observer; returning exercises the clientside model lifecycle.

## Findings and fixes

- The cached `WM` tracked a Lua owner but never checked its actual parent. GMod
  detaches clientside children on PVS loss. The baseline observer recorded a
  detached model and a muzzle 253 units from its owner. Check/reapply the parent,
  reset local transforms, and retire both copies on `NotifyShouldTransmit(false)`.
  Reset the dual's bind matrix whenever its model is recreated.
- Only DrawWorldModel prepared the drawn copy's transforms. Particle/shell/tracer
  attachment reads could precede that draw or read a stale copy off screen. They
  now share UpdateWorldModels with drawing, without drawing the gun from effects.
- Muzzle and shell EffectData had the default zero origin. Give them the owner's
  shoot position and an explicit shooter-PVS recipient filter; exclude the firing
  player in MP because that client predicts its own effects. Singleplayer and NPC
  effects retain server delivery. Reject stale effects for dormant owners/weapons.
  The baseline still received muzzle particles during the outside phase, so the
  evidence does **not** establish zero origin as the sole cause of missing effects.
- Flamethrowers bypassed the custom world-model renderer and attached the stream
  to the original weapon. They now use the drawn model and restart if the emitter
  changes. PVS loss stops the old stream. The test also found a zero-length cross
  product in the impact control-point orientation when aiming squarely at a wall;
  that basis is now orthonormal.

No forced global transmission, expanded player PVS, or permanent broadcast was added.

## Reproduction

Use an unused server port and leave at least one port between instances (Source
also occupies a neighbouring socket). Substitute the machine's LAN IPv4 address:

```
python work/harness.py start gm_construct --mp --multirun --port 27019
python work/harness.py start --mp --multirun --port 27025 --connect LAN_IP:27019
python work/harness.py run work/tests/pvs_fixed.txt --port 27019
python work/harness.py run work/tests/pvs_extended.txt --port 27019
python work/harness.py run work/tests/pvs_lifecycle.txt --port 27019
python work/pvs_report.py fixed
python work/pvs_report.py extended
```

The observer is controlled by the host fixture, not its own server queue. `connect`
and `quit` are blocked through Lua in this installation; connect at process launch.
Loopback connection retries failed here; the LAN address worked. Wait for both
clients before starting. Probe Lua is explicitly included and is never autorun.

Raw reports and screenshots: `garrysmod/data/mcv_harness/pvs/`. Fixtures overwrite
their named report sets; archive them before comparing another version. The
baseline fixture is retained for reproducing the same path on older code.
This run's JSON evidence is archived in `work/pvs_validation/`; `fixed` and
`extended` contain the final fresh-map 100 ms run, `baseline` the pre-fix run,
and `lifecycle` the forced-repair/NPC run. Final jobs: `pvs_fixed_00662965` and
`pvs_extended_00663165`; the earlier zero-lag job was `pvs_fixed_00659471`.

## Validation

- Fresh-map AKM runs at net_fakelag 0 and 100: observer receives 10/10 muzzle
  particles before exit and 10/10 on return, none outside PVS. Parent remains
  correct; muzzle distance is about 65–68 units. The firing client still gets its
  own predicted flash/smoke. Server records muzzle and shell dispatches.
- Dual M1911 and sustained LPO-50 exercise PVS transitions at 100 ms lag. Screenshots
  show the guns in hand after return; the flame emitter is rebuilt on re-entry.
  The left muzzle stays within 58 units of the owner. All six observer particle
  creations in the final extended run are valid, and that run logs no Lua errors
  or invalid-orientation warnings.
- Forced clientside detach and removal recover through GetWorldModelFor before
  drawing. NPC Combine/AKM leaves and returns, resumes particles, and has attached
  world models with muzzle distances around 79–81 units.
- Lua syntax checks cover both packs and the edited nested files. Live engine
  logging still includes pre-existing `GetInterpolationData got 0 values` spew;
  this is not a claim that all engine/addon warnings are eliminated.

Lua-only change: change maps. No model recompilation or game restart is required.

Primary reference: [ClientsideModel](https://wiki.facepunch.com/gmod/Global.ClientsideModel)
documents clientside-parent detachment on PVS loss;
[util.Effect](https://wiki.facepunch.com/gmod/util.Effect) supports recipient filters.

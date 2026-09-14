# NPC semi-auto cadence

`lua/weapons/mcv_base/sh_npc.lua` caps NPC semi-auto fire by the owner's current
weapon proficiency, as returned by `GetCurrentWeaponProficiency`:

| Proficiency | Maximum RPM | Minimum interval |
| --- | ---: | ---: |
| Poor | 60 | 1 second |
| Average | 90 | 2/3 second |
| Good | 120 | 1/2 second |
| Very Good | 180 | 1/3 second |
| Perfect | 240 | 1/4 second |

The cap applies after category fire-rate multipliers. Slower weapon rates and
explicit NPCShotInterval/action delays take precedence. Proficiency is read
each time, so changes apply without re-equipping. The same interval controls
AI burst/rest timing and the actual NextPrimaryFire check. Automatic and burst
fire rates are unchanged; player firing is unaffected. The global `skill`
difficulty convar is separate from weapon proficiency.

## Validation

Run in a disposable local multiplayer session:

```powershell
python work/harness.py start gm_flatgrass --mp --multirun --port 27018
python work/harness.py run work/tests/npc_cadence.txt --port 27018
```

`lua/mcv_harness/npc_cadence.lua` first audits all five levels, AI scheduling,
10x and 0.1x rate multipliers, a slower explicit override, AKM auto/semi mode
changes, and existing M37/vz. 24 action floors.

It then records real clip-consuming attacks over 22 seconds. Five frozen NPCs
request semi-auto fire every Think, exercising the hard timing gate. An AKM
provides the automatic control; two other NPCs fire/reload through native AI.

| Case | Proficiency | Shots | Required minimum interval | Result |
| --- | --- | ---: | ---: | --- |
| M1911A1, frequent requests | Poor | 22 | 1 s | Pass |
| M1911A1, frequent requests | Average | 33 | 2/3 s | Pass |
| M1911A1, frequent requests | Good | 44 | 1/2 s | Pass |
| M1911A1, frequent requests | Very Good | 65 | 1/3 s | Pass |
| M1911A1, frequent requests | Perfect | 87 | 1/4 s | Pass |
| AKM, frequent requests | Perfect | 200 | 0.1 s | Pass |
| M1911A1, native AI | Poor | 15 | 1 s | Pass |
| M1911A1, native AI | Perfect | 28 | 1/4 s | Pass |

All 494 recorded shots respected the interval. Native AI may fire more slowly
because of schedules, aiming, rest times and reloads. Results are retained in
`npc_cadence_audit.json`, `npc_cadence_runtime.json` and the harness job JSON.
Lua syntax checks passed. No prediction regression test is needed for this
server-only NPC change. Change maps to load it; no models were changed.

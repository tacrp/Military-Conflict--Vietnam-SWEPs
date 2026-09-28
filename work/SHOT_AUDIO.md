# Automatic-fire reports cut off

Reported: Vz. 59, M60 and MG34 sound mostly distant after even two shots; one shot
sounds normal, and the RPK sounds normal during bursts.

The shared dispatcher reused one replacement channel per layer. Several original
recordings begin with mechanical noise before their main report. At automatic-fire
cadence, the next shot could replace the preceding sample before that report began.
All 960 unique registered `.Single*` sample references exist across the two packs;
the affected files are valid 44.1 kHz, 16-bit PCM WAVs.

Measured in the installed near-report samples (first absolute sample above 0.5):

| Weapon | Main report begins | Time between shots | Result with one channel |
| --- | --- | --- | --- |
| MG34 (`MG43` assets) | 98–102 ms | 75 ms | Report overwritten before onset |
| Vz. 59 (original script uses PK sound) | 86–90 ms | 80 ms | Report overwritten before onset |
| M60 | 64–66 ms | 100 ms | Most of report body truncated |
| RPK, reported good control | 2–6 ms | 100 ms | Initial report survives |

The Vz. 59's PK sound assignment agrees with `work/cscripts/weapon_vz59.txt` and is
unchanged. No sound assets or weapon rates were altered.

## Change

`sh_common.lua` reserves four user channels for the near layer and four distinct
channels for the distant layer. `EmitShotSound` rotates a per-weapon cosmetic cursor
only after the first-predicted guard. Consecutive shots overlap; the fifth replaces
the first in each layer, bounding voices rather than keeping every multi-second
tail alive. No timers, net messages or additional soundscript registrations are used.
The cursor does not depend on `BurstCount`, so releasing/repressing the trigger does
not reset it and truncate the previous tap. NPCs use the same path.

This uses the documented [user-channel range and replacement semantics](https://wiki.facepunch.com/gmod/Enums/CHAN).
Raw WAV emission retains the original sound level, volume, pitch range and sample
selection; it avoids [soundscript parameters overriding EmitSound arguments](https://wiki.facepunch.com/gmod/Entity:EmitSound).

## Offline verification

```powershell
python work/audit_shot_audio.py
python work/test_shot_sound.py
python work/glua_check.py "lua/weapons/*.lua" "../mcv-2/lua/weapons/*.lua" "lua/weapons/mcv_base/sh_shoot.lua" "lua/mcv/shared/sh_common.lua"
```

The audit measures the installed WAVs; `--all` prints every sample and `--anomalies`
includes other delayed attacks or unsupported encodings. The test runs the actual
dispatcher and its channel constants, checking 1,000-shot bounds, independent
weapons/layers, NPCs, repeated taps, replay suppression and original mix parameters.
It then uses emitted channel sequences to calculate PCM report energy retained
before replacement in two-shot and 1,000-shot bursts at the weapons' default rates.
In the first 80 ms after main-report onset, average retained energy changes from
0% to 100% for MG34/PK, 35.4% to 100% for M60, and stays 100% for RPK.

This is an offline channel/PCM model, not an engine listening test. It does not model
global mixer pressure, DSP, device configuration or sound modifications from other
addons. Extreme fire-rate multipliers can still shorten reports because the pool is
deliberately finite. No in-game verification was run. **Change maps** to load the Lua
changes; no model or sound asset reload is needed for this fix.

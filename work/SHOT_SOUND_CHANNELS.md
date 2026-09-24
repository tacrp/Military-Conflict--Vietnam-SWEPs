# Automatic-fire sound channels

The previous dispatcher resolved sound scripts to raw WAVs but emitted both shot
layers on CHAN_STATIC. That avoided immediate replacement, yet let each report and
distant tail overlap all preceding shots. Our files include gunshot tails lasting
many seconds. Voice pressure is a plausible cause of the reported long-burst
dropouts; this has not been reproduced or audibly verified in game.

The local ARC-9 checkout uses CHAN_WEAPON (1) for its primary report and a custom
channel (136) for the distant layer, via Entity:EmitSound:

- `../ARC-9/lua/arc9/common/sh_common.lua`: channel definitions.
- `../ARC-9/lua/weapons/arc9_base/sh_shoot.lua`: DoShootSounds.
- `../ARC-9/lua/weapons/arc9_base/sh_util.lua`: PlayTranslatedSound.
- History: 1709fd17 introduced custom channels; 526d9e9d explicitly addressed
  sound-bank overflow; a9576b59 adjusted another layer's channel assignment.

MCV now follows that separation through MCV.CHAN_SHOT and
MCV.CHAN_SHOT_DISTANT. Each new shot replaces its own prior layer on the same
weapon, instead of accumulating tails. The two layers cannot replace one another,
and different weapon entities have separate channel identities. The final shot's
tail remains. Report/distant mixing, attenuation, pitch, sample selection and
prediction suppression are unchanged. The near-empty click remains disabled.

Raw sample resolution is retained because the registered scripts still contain
their original channel setting. This avoids relying on a script-name EmitSound
call to override it. No sound assets or other addons were modified.

Reference: https://wiki.facepunch.com/gmod/Enums/CHAN documents CHAN_STATIC's
overlap behavior and the game-code channel range starting at CHAN_USER_BASE (136).

Offline validation: `python work/test_shot_sound.py` exercises 1,000 dispatches,
layer/weapon separation, replay suppression and raw-file fallback. It models
channel identities, not the engine mixer; an audible in-game check remains needed
to confirm the reported symptom is gone. No game was launched. Change maps to load.

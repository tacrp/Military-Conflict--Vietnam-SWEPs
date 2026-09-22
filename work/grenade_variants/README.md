# AN-M8, M18 and M6A1

All three use v_m18/w_m18, whose compiled skin tables agree:

| Weapon | Class | Skin | Material | Effect |
| --- | --- | --- | --- | --- |
| AN-M8 Smoke | mcv_anm8 | 4 | m18 / w_m18 | White smoke |
| M18 Smoke (Red) | mcv_m18 | 0 | m18_red / w_m18_red | Red smoke |
| M6A1 Gas | mcv_m6a1 | 7 | riot / w_riot | Existing harmful gas |

The M6A1 source game's weapon script explicitly selects the shared M18 model and
skin 7. Its diffuse texture is marked GAS CN-DM. The older dedicated v_m6a1 model
is no longer used. Gas entity defaults also use the matching model and skin.

Skin propagation already covers held weapons, viewmodels and thrown canisters.
AN-M8 uses the former white-smoke spawn icon; M18 now uses the red variant's icon.
The new AN-M8 definition is hand-maintained. Import overrides retain the corrected
M18 red and M6 gas selections; do not regenerate tuned weapons for these changes.

Run `python work/grenade_variants/check.py` for the offline compiled-model/material
and weapon checks. No in-game verification or model recompilation was performed.
Change maps for the Lua update.

# Restored source-game variants

Compared the installed game's loose weapon scripts with `work/cscripts` (identical), then
checked distinct model/bodygroup configurations against the addon's classes. The importer
resolved several variants to an existing gun sharing the model; `--only-new` skipped them.
Explicit `SCRIPT_ALIASES` now keep these identities separate:

| Game script | Addon class | Configuration |
| --- | --- | --- |
| weapon_m16a1_xm3 | mcv_m16a1_xm3 | M16 LMG: 30-round magazine, XM3 bipod, 120 reserve |
| weapon_m16a1_sog | mcv_m16a1_sog | Taped 30-round magazine, 60 reserve |
| weapon_kar98k_zf41 | mcv_kar98_zf41 | Forward low-power ZF41 optic, 5-round capacity |
| weapon_stg44_zf41 | mcv_stg44_zf41 | ZF41 optic, 20-round magazine, 100 reserve |

The Kar98 **ZF39 4x** already exists as `mcv_kar98_s` under Sniper Rifles. The ZF41 variants
use the game's 37.5-degree scope FOV; they are a separate low-power optic. Existing hand-tuned
sights are unchanged. The new ZF41 guns use their source script positions and a 75-degree
sighted viewmodel FOV for long eye relief.

ZF41 models have separate `crosshair_zf41` reticle and `crosshair_zf41a` glass surfaces.
Apply the RT lens to the latter (Kar98 index 9, StG index 6); overriding the reticle leaves
the game's Refract glass black. The importer now recognizes this distinction.

New classes inherit their established gun implementations and override source differences.
`Category` must still be explicit for GMod's raw spawn-menu list. Category/country selectors
discover them automatically; the explicit German WW2 pool includes both ZF41 guns. The
existing XM177 OEG also has an explicit importer alias now.

This audit covers four missing standalone gun variants. Dual wield and rifle-grenade scripts
are modes already folded into host guns. Mounted M2 Browning, gas-mask and cubemap scripts
are not additional handheld guns added by this pass.

## Reproduce

```powershell
python work/missing_variants/build_icons.py
python work/harness.py run work/tests/missing_variants.txt --port 27018
```

Icon generation reads only these four original SVGs from the installed game's VPK. The SVG
copies are kept here; the outputs use the existing 512-pixel spawn-icon layout.
Run the fixture on a fresh local MP map. It checks client/server registration, NPC eligibility,
spawn categories, capacities, bodygroups and material loading, then fires/reloads all four,
deploys the XM3 bipod with real input and captures both aimed ZF41 lenses for visual inspection.
The bipod placement predicate is forced on that test instance to isolate deployment from terrain.

Validation: `missing_variants_93934051` completed with no harness or client Lua errors.
Both realm audits passed, all four guns fired and reloaded, XM3 deployed, and the two
aimed ZF41 screenshots show a clear magnified scene and centered reticle.

The new classes need a map change; the cycle model changes from the same pass need a full restart.

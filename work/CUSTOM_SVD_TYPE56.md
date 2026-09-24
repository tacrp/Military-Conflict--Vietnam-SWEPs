# SVD Irons and Type 56-1 Drum

Both live in Part 1. Their Lua inherits the original weapon's handling, damage,
firing and movement behavior. Both have dedicated white/alpha spawn icons and
are included in the Custom random pool.

SVD Irons removes `optics_pso_1` and `lens_svd` from the view mesh and
`w_svd_scope` from all three world LODs. The original rifle meshes and animations
are retained. Its separate Lua disables scopes/adjustable magnification and uses
the ordinary 40-degree aimed viewmodel FOV. Bare-sight offsets are estimated from
the front post and rear notch in the aimed SMD: approximately Base-local
(-32.95, -0.0048, 1.593) and (-5.405, -0.0048, 1.720). These give 0.264 degrees of
pitch and 1.284 units of lift. Existing scoped SVD hand tuning is untouched.
Visual alignment still needs in-game confirmation.

Type 56-1 Drum replaces only magazine-weighted mesh triangles with the RPK drum,
on the viewmodel and all world LODs. Bind transforms are checked before swapping.
The Type 56 folded stock, bayonet bodygroup, other animations and attachment
positions remain intact. Both reload blend sequences, their sounds and events
come from the RPK. Capacity is 75 + 1 chambered, starting reserve setting 150,
matching the RPK. Handling remains Type 56-1. The drum is circular viewed from
behind; its narrow side silhouette is correct for the donor mesh.

## Rebuild

Normal editing: edit QCs/SMDs inside either bundle and run its `compile.py`:

```
python work/MCV_SMD/weapons/v_svd_irons/compile.py
python work/MCV_SMD/weapons/v_type56_drum/compile.py
```

Each bundle includes local animation and mesh sources plus `COMPILE.md`.
To reconstruct the initial kitbashes from current donor QCs (overwrites generated
kitbash meshes and port QCs; back up your edits first):

```
python work/build_svd_irons_type56_drum.py --install
python work/test_custom_variants_impacts.py
```

The builder installs model companions and icons in Part 1 and exports local
compile dependencies. All four models compiled, and compiled materials,
sequence/event metadata and asset dependencies passed offline checks. No game
was launched. A full restart is required for new models.

## Impact dispatch regression

`sh_impacts.lua` previously returned false after requesting its particle and had
the replacement decal commented out. It also sent its effect using normal host
prediction filtering. The [DoImpactEffect hook documentation](https://wiki.facepunch.com/gmod/WEAPON:DoImpactEffect)
states that predicted bullets skip the client hook, so the custom effect now
bypasses that filter in both realms. The first attempted fix wrongly retained
an IsFirstTimePredicted gate: the user reported no effects in singleplayer,
where this authoritative hook runs outside client prediction. The gate is now
removed. Flesh, sky, unknown surfaces and the disabled setting retain the engine
fallback. Mock tests deliberately reject prediction queries from this hook.

Original MCV bullet decals are imported by `work/import_impact_decals.py`:
23 surface groups, 62 materials/textures (124 files), about 175 KB total. The
game's standalone DecalModulate materials preserve texture and scale without
requiring its atlas Subrect shader. All paths live under `mcv/decals`, registered
as `MCV.Impact.<surface>`, leaving other addons' decals untouched. Decals travel
with the client effect and don't exclude the hit prop. Water receives no decal.
Mock tests verify dispatch arguments/branches and dependencies, not actual
engine networking/rendering. Change maps to load the Lua and register materials.

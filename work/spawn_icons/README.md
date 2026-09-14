# Rebuilding the custom weapon icons

The RHOGUN, Cobra Mk1, PTRD-41 Sniper, M635 and XM16 Super use transparent line-art
icons rendered directly from their SMD meshes. White fills have thin black outlines
and internal details at 65% opacity, softened from the initial opaque strokes.
The lines replace the fill beneath them so the background can show through;
they are not opaque grey paint. Depth/normal edges retain the actual gun's detail. No image generator,
textures, game session, model compiler or GPU is required.

## One command

Open PowerShell in the addon folder and run:

```powershell
python work/build_spawn_icons.py
```

This rebuilds all five icons. To rebuild just the three custom guns:

```powershell
python work/build_spawn_icons.py ptrd_sniper m635 xm16super
```

Or rebuild one after editing its mesh:

```powershell
python work/build_spawn_icons.py m635
```

The script needs Python 3.10+, NumPy and Pillow (already installed on this machine).
On another machine: `python -m pip install numpy pillow`. Keep `bake_ik.py` beside
the script; it supplies the SMD skeleton reader. Preset mesh paths are resolved
relative to the script, so an absolute script path also works from another folder.

## Outputs and source meshes

| Preset | Mesh under `work/` | Installed PNG under `materials/entities/` |
| --- | --- | --- |
| `rhogun` | `MCV_SMD_OG/weapons/v_rhogun/Ref_new.smd` | `mcv_rhogun.png` |
| `cobra` | `MCV_SMD_OG/weapons/v_cobra/Ref_new.smd` | `mcv_cobra.png` |
| `ptrd_sniper` | `MCV_SMD/weapons/v_ptrd41_s/Ref_new.smd` | `mcv_ptrd_sniper.png` |
| `m635` | `MCV_SMD/weapons/v_m635/m635.smd` | `mcv_m635.png` |
| `xm16super` | `MCV_SMD/weapons/v_xm16super/xm16super.smd` | `mcv_xm16super.png` |

Default output is RGBA 512x512, with the gun centered in the middle half-height
band used by the original game's icons. The class-based filenames serve both the
spawn menu and weapon HUD. The standard unscoped PTRD retains its original icon.

Each installed image is also copied here as an import override. `rip_game.py
--steps icons` reapplies these five overrides after importing the game's SVGs.
`manifest.json` records source/output hashes, mesh triangle counts and settings;
rebuilding a subset retains the other records. `preview.png` shows the most
recent selection on a dark background. It is not a shipped spawn texture.

The three custom build scripts use this renderer too, so a subsequent model
build won't restore the old solid silhouettes. Rebuilding icons does not change
weapon Lua, compile files, animations or models. Restart GMod to refresh icons
that the material cache already loaded.

## Preview without installing

```powershell
python work/build_spawn_icons.py m635 --out work/icon_preview
python work/build_spawn_icons.py xm16super --side right --size 1024 --out work/icon_preview
python work/build_spawn_icons.py m635 --line-opacity 0.5 --out work/icon_preview
```

`--out` writes the PNG, manifest and preview only into that directory. It leaves
the live addon and import overrides alone. `--side` selects the visible side,
keeping the barrel pointing right; `--size` accepts 256, 512 or 1024.
`--line-opacity` accepts 0 to 1 (default 0.65) and changes only the dark strokes,
leaving the white fill opaque. The manifest records the selected opacity.

## Another kitbash

```powershell
python work/build_spawn_icons.py --source "work/MCV_SMD/weapons/v_myweapon/Ref_new.smd" --name myweapon --out work/icon_preview
```

The SMD must contain triangles and a bind-pose skeleton. It uses the `Base` bone's
coordinates: -X points down the barrel, Z points up. Choose another equivalent
bone with `--bone WeaponRoot` if needed. It renders the meshes in this SMD only;
separate QC bodygroups are not assembled automatically. Shell materials are
excluded; add e.g. `--exclude-material hands` to omit another material substring.
Use `--name mcv_myweapon` or `--name myweapon` for `mcv_myweapon.png`.

Use `--list` for presets and `--help` for options. Once happy with a preview,
omit `--out` to install it. New generic icons are retained here but must be added
to `rip_game.py`'s local-icon list if they should survive the original-icon import.

## Validation

The images are rendered with a depth buffer at three times the output resolution
and downsampled with Lanczos filtering. `preview.png` shows the current icons with
translucent outlines. `validation.json` records line transparency, dimensions, output hashes
and agreement between all five installed files and their retained import overrides.

`spawn_icons.png` and `spawn_icons.json` retain the earlier in-game ContentIcon
layout/material check, before the stroke-opacity correction. The images in
`rebuild_check` and `options_check` likewise record the earlier renderer checks;
they are not installed or used as import overrides.

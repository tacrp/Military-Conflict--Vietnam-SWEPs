# Eastern/base and Western/content split

The addon is now installed as two sibling folders:

| Folder | Content | Spawnable classes |
| --- | --- | ---: |
| `mcv` | Part 1 — Eastern weapons and all shared implementation/assets | 87 |
| `mcv-2` | Part 2 — Western weapon definitions and exclusive assets | 157 |

Part 2 requires Part 1. Part 1 has no dependency on Part 2. No weapon base, entity,
autorun loader, settings, shared sound-script registry, effect code or shader is duplicated
in Part 2. Mounted filenames and weapon class names are unchanged. Existing hand-tuned
weapon files were moved byte-for-byte; no weapon Lua was regenerated.

The user moved Part 2 to `addons/disable/mcv-2` during this work. It has been left there.
Offline tools also recognize that location, without re-enabling the pack. The normal
enabled install location remains `addons/mcv-2` alongside Part 1.

Eastern covers Soviet/Russian, Eastern European, Chinese, Korean, Vietnamese and Japanese
origins. Western covers US, Commonwealth and Western European origins, including Germany,
plus Israeli/Rhodesian weapons. US/VC supplies and binoculars follow their suffix; generic
fists, wrench and crowbar stay in the base. Random country/service pools still overlap as
before; those menu memberships do not duplicate installed classes.

## Assets and recovery

`plan.json` contains the class catalog, every asset assignment, dependency sets, shared
assets and references that were already unresolved before the split (including stock-game
resources). The graph follows inherited weapon definitions, compiled model material tables,
VMT patches and texture references, animation-event sounds and registered sound scripts.
Shared effects and dependencies needed by Eastern weapons remain in Part 1. Unused skins
follow an exclusively Western material family; other legacy/shared content stays in Part 1.

`moved_files.json` records every one of the 9,923 original runtime files with its path, size
and SHA-256 before moving. 4,086 files moved to `mcv-2`. `verification.json` confirms contents,
unique mounted paths and that the Eastern dependency sets are contained in Part 1.
For recovery, reverse only the `western` entries in this manifest after verifying their
hashes and checking for an existing destination. Never clean/reset the whole weapon tree.

The sibling folder is outside the original Git repository. Preserve/back up **both** folders;
the original repository's deleted-file status alone does not capture Part 2's contents.
Nothing has been staged or committed by this operation.

## Packaging

```powershell
python work/split_packs.py --verify
python work/build_packs.py --out work/pack_split/release-new
python work/build_packs.py --format-check --out work/pack_split/release-new
```

Choose a fresh output directory to preserve previous release artifacts. The builder emits
standard GMAD v3 archives using bounded memory, respecting `addon.json` exclusions and the
runtime whitelist. It extracts every file, verifies file and archive CRCs, then compares
each extracted file's SHA-256 with its source. Both archives must stay below a conservative
4,000,000,000-byte ceiling. The format check uses native `gmad.exe` on a small archive.

The installed `gmad.exe` failed building Part 1 with “Can't grow buffer?” before producing
an archive. Its in-memory assembly is unsuitable for this pack on this machine; use the
streaming script. The format follows the [official GMad writer](https://github.com/Facepunch/gmad/blob/master/src/create_gmad.cpp).
This is file/archive verification only. **Do not run in-game verification unless the user
explicitly requests it.** The optional harness fixture is retained for such a request.

Current output: `release/mcv-part1-eastern.gma` and `release/mcv-part2-western.gma`, with
extraction folders and JSON verification reports beside them. Development sources, harness
code, documentation, unused software/console VTX variants and root artwork are excluded.
Current flag-license/attribution text is included under `data_static/mcv/licenses` in Part 1.

Verified release sizes: **2,952,176,261 bytes** / 5,589 files in Part 1, and
**2,566,715,415 bytes** / 3,875 files in Part 2. Both full archives extracted successfully
with every CRC and SHA-256 matching. Native GMad also extracted the streaming-format
fixture successfully. No completed in-game validation is claimed for this split.

## Workshop dependency

`workshop.json` records `western.required_parts = ["eastern"]`. Part 2's description must
state that it requires Part 1. On Part 2's Workshop page, add Part 1 under **Add/Remove
Required Items**. That relationship is a Workshop setting; it is not established by
`addon.json` or the currently unused required-content field in the GMA header.
Workshop IDs are intentionally unset until supplied/published. No upload or Workshop
dependency edit has been performed by these scripts.

## Icons and maintenance

```powershell
python work/compose_addon_icon.py
```

This rebuilds both mosaics from the actual weapon classes in each pack. Original-game gun
icons only; no custom kitbashes, grenade/equipment or melee tiles. The original wordmark
and **An Arctic Mod** credit remain. Subheadings are **Part 1 - Eastern** and **Part 2 - Western**.
Each folder receives a baseline 4:2:0 JPEG `icon.jpg` for Workshop. The 2048px PNGs, 512px
previews, seeds and placements live under `work/artwork/part1-eastern` and `part2-western`.
`work/artwork/pack-icons-preview.png` shows both side by side.

Keep source and editable compile files in `mcv/work`, including the three custom bundles.
`pack_paths.py` resolves existing files across both packs and routes rebuilt companions to
their recorded pack. The main weapon importer, hammer-event generator, custom build/install
scripts, cycle installer and custom-icon tools use it. Older one-off scripts may still assume
a single root: update them to use this helper before applying them. Never broadly regenerate
the weapon Lua to accommodate the split.

**Fully restart GMod** after installing the sibling folders so Part 2 is mounted.

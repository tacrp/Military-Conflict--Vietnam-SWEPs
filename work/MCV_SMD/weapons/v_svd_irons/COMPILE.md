# Editable compile files

The QCs in this folder use the original kitbash mesh here and local dependencies
in `assets/`, including the animation SMDs, hand-rig QCI and world-model sources.
The PTRD bundle also includes the separate `assets/Ref_Bullet.smd` cartridge.

Edit these QCs or SMDs, then run `python compile.py` from this folder, or select
the QC in Crowbar with Garry's Mod as the game. The Python command builds into
`compiled/` here and copies the results into this addon's `models/weapons/mcv/`.
Source files are never regenerated. Fully restart the game after compiling.

The existing addon supplies textures, sounds, Lua and the common compiled
gesture animation model. Pass `--game "path/to/GarrysMod/garrysmod"` when using
the folder outside this addon; then copy the outputs into your addon manually.
Output logs remain beside each QC. When using Crowbar, set its output to the
addon's model folder to avoid a second model copy overriding it in the game root.

`work/build_*.py` are separate generation tools for reconstructing the initial
port; normal hand editing uses the local QCs instead. The export tool refuses
to replace files changed since its last export. The original input mesh is never
overwritten by the exporter. The viewmodel and worldmodel meshes are independent.

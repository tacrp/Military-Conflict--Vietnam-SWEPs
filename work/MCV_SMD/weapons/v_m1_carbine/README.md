# Custom M1 Carbine

M2 fixed-stock receiver, rig and animations with the M1A1 Para's 15-round
magazine. Both viewmodel and all three worldmodel LODs have the magazine swap.
The Lua definition and installed models/icon live in Part 2 (`mcv-2`).
Class: `mcv_m1_carbine`. Semi-auto only, 15 rounds plus one chambered,
75 starting reserve (matching the Para); other handling follows the M2.

Edit the local QCs/SMDs and run `python compile.py` from this directory.
This preserves manual source edits and installs into Part 2. Restart GMod fully.
`v_m1_carbine_mesh0.smd` is the main view mesh; `w_m1_carbine_mesh0.smd`
through `mesh2.smd` are the worldmodel LODs. Dependencies are in `assets/`.

To reconstruct from the original donors, run `python work/build_m1_carbine.py
--install` from the mcv addon root. That deliberately regenerates the four
kitbash meshes, so preserve manual mesh edits first. Original donor files are
never modified. The magazine uses the donors' shared bind pose and magazine bone.

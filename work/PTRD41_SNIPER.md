# PTRD-41 Sniper

Spawn class `mcv_ptrd_sniper`, in Sniper Rifles. The user's
`MCV_SMD/weapons/v_ptrd41_s/Ref_new.smd` combines the PTRD with a canted Meopta
optic. The actual optic material is the one used by the addon's vz. 54 Meopta.
The mesh and its rig are preserved; shared bind transforms match the PTRD donor.

The weapon inherits PTRD damage, penetration, ammunition, firing/reload sounds
and bipod requirements. It retains the separate `Ref_Bullet.smd` cartridge in
the `bulletDisplay` bodygroup. Shared ammo/reload state drives its visibility,
matching the donor's frame-13 reload reveal and hiding the cartridge after firing.
The lens uses the Meopta reticle, glass idle material and magnification settings.
Its compiled lens submaterial is index 2. The new weapon's sight offset
`(-2.38, 0, 0.755)` centers the canted optic in the deployed PTRD pose.

The worldmodel retains the existing PTRD geometry, collision and hand placement,
with the kitbashed optic added in matching weapon coordinates. It has no LODs.

`python work/build_ptrd41_sniper.py --install` reconstructs the initial port,
compiles both models and writes its silhouette HUD icon.

For manual editing, use `work/MCV_SMD/weapons/v_ptrd41_s/`: the two QCs, original
mesh, local `assets/` (including the cartridge, animations and hand-rig QCI) and
`compile.py` are kept together. Run `python compile.py` there or compile the QCs
with Crowbar. `COMPILE.md` in the folder explains output locations.

The exporter keeps the corresponding editable folders for this gun, XM16 Super
and M635. It records hashes and refuses to replace files changed since export.
Normal recompilation never regenerates the source QCs or SMDs.

Validated in a fresh local multiplayer game with `ptrd_sniper_preview.txt` and
`custom_weapon_assets.txt`: deployed scope alignment, all view/world materials,
one shot (1 to 0), a completed reload (0 to 1), and cartridge bodygroup transitions
(hidden after firing, visible during insertion and once loaded). The side-view
fixture `custom_weapon_world.txt` verified the mounted optic and hand placement.
Results and screenshots are retained in `work/custom_weapon_validation/`.

Fully restart Garry's Mod after rebuilding models. Lua-only changes need a map change.

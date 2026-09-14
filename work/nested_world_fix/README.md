# Garand and flamethrower worldmodels — September 14, 2026

Corrected `w_m1g_s` (M1/M1D), `w_lpo50` and `w_m9a1`. Their original nested MCV
hand/root rigs bypassed ordinary worldmodel alignment. An initial Garand rotation
fixed barrel direction but retained an incorrect hand anchor; this replaces it.

The port now normalizes meshes, LODs, physics and animations into the weapon frame,
then uses the original game's class-specific hand transform calibrated to GMod's
rifle hold. The gun bone is private (`MCV.weapon_bone`) so NPC bone merging cannot
override its placement. All source geometry is preserved in weapon-local space,
checked within 0.00001 units. The original Garand world body is 2,682 triangles,
with its two original LOD levels and scope bodygroups; no viewmodel substitution.

All three compiled and were installed. Freshly started local multiplayer on port
27017: player M1, M1D, LPO-50 and M9A1 plus Combine-held Garand/LPO-50/M9A1 were
visually inspected. Barrel direction and grip contact are corrected in both cases.
Player and NPC gun transforms relative to the right hand agree to about 0.001 units.
Support-hand contact still follows generic GMod hold animations, not per-gun IK.

Evidence: `*_rig.png`, `*_rig.json`, `build.json` and per-model geometry manifests.
Rebuild with `python work/build_nested_world_models.py`; original source meshes
remain under MCV_SMD_OG, normalized inputs under MCV_SMD_PORT/.../fixed_anims/world_rig.
**Fully restart Garry's Mod** to load these model changes.

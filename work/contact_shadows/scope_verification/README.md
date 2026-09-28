# Scope / Contact Shadows GPU regression — 2026-09-28

User-authorized, isolated 64-bit multirun (port 27026), singleplayer gm_construct,
1280x720, Contact Shadows Workshop 3645490126 and installed GShader dependencies.
Position (-1000,1300,-100), angle (-10,90,0): toward the water, where the shadows appear.
The final matrix was run after changing maps, without temporary render-function detours.

Run `work/tests/scope_contact.txt` then `work/tests/scope_variants.txt` through the harness
on an explicitly authorized local test instance. The first script loads the diagnostic
helper and the second reuses it. These scripts change the selected weapon, position,
aim/input, Contact Shadows toggle, and sighted FOV preference (restored to 0).
For a session with different preferences, save and restore those before/after running.

Each case saves the final screen, `_layer` (RGBA lens mask/pixels), `_saved` (completed
viewmodel frame before postprocessing), `_scene` (world input to the scope shader), and
`_passes.json` (observed hook order). The companion checker uses actual PNG pixel data:

    python work/check_scope_buffers.py work/contact_shadows/scope_verification

All eight checked cases have nonempty alpha masks and **zero pixel difference** inside
the opaque lens. Results: `pixel_checks.json`. The SVD overlay-disabled comparison shows
the front-sight shadow return; enabling the overlay removes it while leaving gun shading.
The OEG comparison also verifies that its transparent cover no longer blocks the mask.
HUD-hidden OEG was checked separately and also had zero pixel difference (67,405 pixels).

Offline checks: scope capture ordering/migration, overlay lifecycle/translucent-cover
occlusion/completed-pixel guard, particle refraction preservation and viewmodel depth.
GLua syntax check: 265 files, zero errors.

This is not a promise of compatibility with arbitrary shaders drawing after PreDrawHUD.
The earlier capture-order and all-transparent-alpha implementations were not sufficient;
these images and mask assertions are the regression evidence for the replacement.

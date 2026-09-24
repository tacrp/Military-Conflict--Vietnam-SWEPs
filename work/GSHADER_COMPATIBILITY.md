# Viewmodel depth projection — 2026-09-22

## Current status after user visual feedback

The scoped screen-depth exclusion described below was rolled back: the user observed AO
through the gun. All viewmodels again participate in screen depth. The late scope capture
remains, so gun occlusion inside the lens is not yet resolved. Offline depth/capture/refraction
checks pass; this is not a completed visual compatibility fix.

Proposed replacement: render a separate world-only colour/depth target before the main scene,
including world translucency and particles, with recursion guards and no HUD/viewmodel. Then
allow the main view to rebuild its normal depth with the gun included. The lens samples only
the independent image. Preserve existing reticle/optical styling initially. Audit gShader's
shared buffers, temporal caches and hook ordering before implementation; a separate target
alone does not isolate global addon state. This adds a world render while aiming. Do not
invoke RenderView inside the viewmodel draw (Facepunch documents flicker for that arrangement).
The user redirected work to rocket-launcher ballistics before this redesign was implemented.

The following sections record earlier attempts, not the current completed behavior.

The screen-depth pass previously returned from `PreDrawViewModel` before opening the custom
camera, while the colour pass used the weapon's blended hip/aim FOV and optional near plane.
The depth silhouette could therefore differ from the visible weapon. This was the initial
diagnosis before the scope screenshot below arrived. No in-game verification was performed.

Screen-depth rendering now uses the same camera setup and compressed depth range as colour
rendering. Scope material/composite updates, OEG screen copies, lights, particles and shells
remain excluded from depth-only passes. Post-draw closes the camera and restores the depth
range in both paths. Shadow-depth rendering retains the engine's light-space camera.

`python work/test_viewmodel_depth.py` checks camera argument parity at hip, half-aim and full
aim, with/without a near-plane override, balanced camera lifetime, no colour composites during
screen-depth rendering, hidden viewmodels and untouched shadow passes.
`python work/test_particle_refraction.py` still passes. These are stubbed Lua rendering tests,
not visual/GPU validation. Change maps to load the Lua change.

References consulted:
- [gShader depth buffer implementation](https://github.com/Akabenko/GShader-library/blob/main/lua/autorun/client/depthbuffer.lua)
  requests the engine depth pass through `NeedsDepthPass`.
- [cam.Start3D](https://wiki.facepunch.com/gmod/cam.Start3D) documents the FOV and clipping arguments.
- [cam.IgnoreZ](https://wiki.facepunch.com/gmod/cam.IgnoreZ) documents the 0..0.01 depth range.

## Gun silhouette inside the scope picture

The subsequently supplied screenshot shows a smaller elongated gun/scope silhouette inside
the lens, rather than simply AO darkening the lens geometry. Inspection of the installed
gShader Library (3542644649), SSAO (3453258660), SSDO (3707449642) and HBAO (3722503099)
found reconstruction on `PreDrawTranslucentRenderables` with effect hooks immediately after
it. The depth texture already includes the viewmodel. With early effects enabled, the
`PreDrawViewModels` colour capture can therefore contain occlusion from the gun, before
the visible gun has even been drawn. The scope magnifies that contaminated colour picture.
The old lens also referenced the shared screen-effect texture, which these effects overwrite.

The initial fix copied the frame at `PreDrawReconstruction` and blocked the later capture.
That avoided the gun silhouette but also excluded world particles and translucent objects.
The reported missing effects while scoped are consistent with this ordering.

The scope now captures only at `PreDrawViewModels`, after world translucency. Its private
full-frame texture still protects against later shared-buffer updates. While the shader scope
is active, `PreDrawViewModel` suppresses only the screen-depth viewmodel draw. Reconstruction
therefore sees world depth without a gun silhouette to magnify. Colour rendering, manual
particles and shadow rendering retain their existing paths; unscoped depth is unchanged.
No external addon hooks or settings are changed; our obsolete early capture hook is removed.

Tradeoff: screen-depth effects do not shade the viewmodel itself while the scope is active.
Effects drawn after the pre-viewmodel capture are still outside the lens's source picture;
this remains screen reprojection rather than a separate world render.

`python work/test_scope_capture.py`, `python work/test_viewmodel_depth.py` and
`python work/test_particle_refraction.py` pass. They check capture isolation, active-scope
depth exclusion, colour/depth camera cleanup and particle refraction ordering with Lua stubs.
They cannot validate actual GPU/addon behavior. No game was launched; change maps to load Lua.

# Viewmodel depth projection — 2026-09-22

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

The scope now copies to its own full-frame texture. When gShader invokes
`PreDrawReconstruction`, we capture there and retain that picture for this frame;
without that hook, capture still occurs at `PreDrawViewModels`. Other render view IDs
(reflections/cameras) are excluded. No external addon hooks or settings are changed.

Tradeoff: the early gShader capture precedes translucent objects and reconstruction effects,
so those are not present in that scope picture. Fully shaded/translucent independent scope
rendering would require a separate world pass, which this screen-reprojection scope avoids.
The weapon and main view retain their effects.

`python work/test_scope_capture.py` checks clean early capture, preservation against the
later contaminated frame and shared-buffer rewrites, next-frame fallback when gShader stops,
and inactive scopes. This is an offline check; visual confirmation remains outstanding.

# Delayed muzzle heat haze investigation — 2026-09-19

Status: likely cause patched; reported visual artifact has not been reproduced or verified
in game. No game was launched for this investigation.

## Findings

- First-person muzzle systems are created in `lua/effects/mcv_muzzleeffect.lua`, marked
  `SetShouldDraw(false)`, and queued in the weapon's `PCFs` table.
- `mcv_base_core/sh_vm.lua` manually renders that queue after the viewmodel, inside its
  camera. Before this change there was no explicit refraction-buffer refresh in that path.
- The binary `particles/vietnam_muzzleflash_effects.pcf` contains distortion children such
  as `vietnam_muzzleflash_machinegun_type1_fp_smoke_distpuff` using
  `effects/vietnam/vietnam_ae_muzzleflash_cinesmoke_distort_2.vmt`. That VMT uses `Refract`.
- Scope capture calls `render.UpdateScreenEffectTexture`, which is separate from the
  power-of-two/refraction texture. Refreshing the scope picture therefore does not establish
  that the manually drawn haze has a current source image.

The working hypothesis is that manual particles can sample an older refraction copy when
the normal scene rendering has not refreshed it at the required point. Other refractive
objects or rendering addons could change when that texture was last populated, explaining
why reports might be scene-dependent. That explanation remains an inference, not a confirmed
reproduction or an identified engine bug.

## Change

Refresh with `render.UpdateRefractTexture()` immediately before the first valid viewmodel
particle, after the gun has been drawn. All particles in that batch share one capture;
copying again for every particle would feed preceding particles back into the haze. The
separate manually drawn world-projection batch (flamethrower jet) gets its own refresh.
No copy occurs for empty/invalid queues, depth-only passes or a closed viewmodel camera.
The refresh is per draw pass, not globally once per frame, so additional views cannot
reuse a frame-number guard with the wrong scene image. Third-person muzzle particles remain
on their existing automatic engine rendering path.

No materials, particle definitions, convars or prediction code were changed. Change maps
to load this Lua change.

## Checks and remaining verification

`python work/test_particle_refraction.py` runs the actual translated Lua draw function with
stubbed rendering calls. It checks copy-before-draw order, one copy per batch, repeated views,
mixed viewmodel/world effects, invalid/empty queues and depth/closed-camera exclusions.
The 246 weapon/changed Lua files passed syntax checks. These tests do not exercise a GPU.

If explicitly requested later, compare the old and patched draw paths while firing an AKM
or M16A1 and panning past a sharp wall edge or moving prop. Compare hip/aimed, scoped/unscoped,
first/third person, water/refractive objects present/absent, and rendering addons enabled/disabled.
Useful reporter details: weapon, perspective, map, rendering addons, game branch and a video
showing camera movement through the haze. This is a proposed comparison, not a known repro.

## API references

- [Manual particle Render](https://wiki.facepunch.com/gmod/CNewParticleEffect:Render)
- [SetShouldDraw](https://wiki.facepunch.com/gmod/CNewParticleEffect:SetShouldDraw)
- [UpdateRefractTexture](https://wiki.facepunch.com/gmod/render.UpdateRefractTexture)
  is documented as an alias of the power-of-two texture update.
- [GetPowerOfTwoTexture](https://wiki.facepunch.com/gmod/render.GetPowerOfTwoTexture)
  identifies the default texture as `_rt_PowerOfTwoFB`.
- [UpdateScreenEffectTexture](https://wiki.facepunch.com/gmod/render.UpdateScreenEffectTexture)
  covers the separate screen-effect capture used by scopes.

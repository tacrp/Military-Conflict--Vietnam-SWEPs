# Custom shaders

HLSL sources for the addon's shaders. Compiled `.vcs` files live in `shaders/fxc/` at the addon
root, which GMod loads like `garrysmod/shaders/fxc`.

Build (ShaderCompile from the gmod_shader_guide addon, or https://github.com/SCell555/ShaderCompile):

    cd work/shaders
    ShaderCompile.exe /O 3 -ver 30 -shaderpath "%cd%" ./mcv_scope_ps3x.hlsl
    ShaderCompile.exe /O 3 -ver 30 -shaderpath "%cd%" ./mcv_scope_vs3x.hlsl
    copy shaders\fxc\*.vcs ..\..\shaders\fxc\

`_ps3x.hlsl` / `_vs3x.hlsl` compile to shader model 3 (`_ps30.vcs` / `_vs30.vcs`); vertex and
pixel shader must be the same model. The `common_*.h` headers are the guide's copies
(`SkinPositionAndNormal`, `cViewProj`). A shader edit needs a game restart.

* `mcv_scope_vs3x.hlsl` / `mcv_scope_ps3x.hlsl` - scope lens on the viewmodel: screen
  reprojection magnified around the projected scope axis, exit pupil, tube rim, reticle, barrel
  distortion, chromatic aberration, edge blur. Material `materials/mcv/scope_lens.vmt`, driven by
  `lua/weapons/mcv_base/cl_pipscope.lua`. See PORTING.md "Scopes" for the pitfalls.

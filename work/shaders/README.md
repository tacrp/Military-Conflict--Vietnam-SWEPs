# Custom shaders

HLSL sources for the addon's shaders. Compiled `.vcs` files live in `shaders/fxc/` at the addon
root, which GMod loads like `garrysmod/shaders/fxc`.

Build (ShaderCompile from the gmod_shader_guide addon, or https://github.com/SCell555/ShaderCompile):

    cd work/shaders
    ShaderCompile.exe /O 3 -ver 20b -shaderpath "%cd%" ./mcv_lens_ps2x.hlsl
    copy shaders\fxc\mcv_lens_ps20b.vcs ..\..\shaders\fxc\

`_ps2x.hlsl` compiles to shader model 2.0b (`_ps20b.vcs`), which pairs with screenspace_general's
default vertex shader; a `30` shader would need its own `vs30`. The `common_*.h` headers are the
guide's copies for shaders that include them. A shader edit needs a game restart.

* `mcv_lens_ps2x.hlsl` - scope eyepiece: barrel distortion, chromatic aberration, edge blur,
  sliding exit pupil and tube rim. Material `materials/mcv/lens_pass.vmt`.

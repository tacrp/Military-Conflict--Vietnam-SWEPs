// Vertex shader for the scope lens pass: transforms the quad like any material and hands the
// quad's texture coordinates to the pixel shader untouched. screenspace_general's default
// vertex shader does not pass them through, which sampled the render target at one point.
#include "common_vs_fxc.h"

struct VS_INPUT {
    float4 vPos      : POSITION;
    float4 vTexCoord : TEXCOORD0;
};

struct VS_OUTPUT {
    float4 proj_pos : POSITION;
    float2 uv       : TEXCOORD0;
};

VS_OUTPUT main(VS_INPUT vert) {
    float3 world_pos;
    SkinPosition(0, vert.vPos, 0, 0, world_pos);

    VS_OUTPUT o = (VS_OUTPUT)0;
    o.proj_pos = mul(float4(world_pos, 1), cViewProj);
    o.uv = vert.vTexCoord.xy;
    return o;
}

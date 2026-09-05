// Vertex shader for the scope lens material (screenspace_general on the viewmodel's lens
// submaterial, $model 1 $softwareskin 1). Passes the lens texture coordinates and the clip
// space position on to the pixel shader, which reprojects the screen through the lens.
#include "common_vs_fxc.h"

struct VS_INPUT {
    float4 vPos      : POSITION;
    float4 vTexCoord : TEXCOORD0;
    float3 vNormal   : NORMAL0;
};

struct VS_OUTPUT {
    float4 proj_pos : POSITION;
    float2 uv       : TEXCOORD0;
    float4 clip     : TEXCOORD1;
};

VS_OUTPUT main(VS_INPUT vert) {
    float3 world_pos;
    float3 world_normal;
    SkinPositionAndNormal(0, vert.vPos, vert.vNormal, 0, 0, world_pos, world_normal);

    float4 proj_pos = mul(float4(world_pos, 1), cViewProj);

    VS_OUTPUT o = (VS_OUTPUT)0;
    o.proj_pos = proj_pos;
    o.uv = vert.vTexCoord.xy;
    o.clip = proj_pos;
    return o;
}

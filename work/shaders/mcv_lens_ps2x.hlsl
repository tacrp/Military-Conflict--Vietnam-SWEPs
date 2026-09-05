// Scope lens pass. Runs over the square scope render target (scene at the scope FOV plus the
// reticle) and turns it into what an eye sees through an eyepiece: barrel distortion,
// chromatic aberration and softening towards the edge, a bright exit pupil that slides
// against the gun's sway, and the dark rim of the eyepiece tube.
//
// Constants come from the material ($c0_x ... $c2_w), set every frame in cl_pipscope.lua.
//   c0: x, y exit pupil centre (uv)   z pupil radius (uv)      w pupil edge softness (uv)
//   c1: x barrel distortion k         y chromatic aberration   z edge blur (uv)   w tube radius (uv)
//   c2: x, y tube centre (uv)         z tube edge softness     w brightness
sampler SCENE : register(s0);
float4 C0 : register(c0);
float4 C1 : register(c1);
float4 C2 : register(c2);

struct PS_INPUT {
    float2 uv : TEXCOORD0;
};

float4 main(PS_INPUT frag) : COLOR {
    float2 uv = frag.uv;

    // barrel distortion around the lens centre
    float2 d = uv - 0.5;
    float r2 = dot(d, d);
    float2 duv = 0.5 + d * (1.0 + C1.x * r2);
    float r = sqrt(r2);
    float2 dir = d / max(r, 0.0001);

    // chromatic aberration grows with the square of the distance from the centre
    float ca = C1.y * r2;
    float3 col;
    col.r = tex2D(SCENE, duv + dir * ca).r;
    col.g = tex2D(SCENE, duv).g;
    col.b = tex2D(SCENE, duv - dir * ca).b;

    // softening towards the edge: four extra taps blended in by distance
    float bl = C1.z * r2;
    float3 blur = tex2D(SCENE, duv + float2(bl, 0.0)).rgb
                + tex2D(SCENE, duv - float2(bl, 0.0)).rgb
                + tex2D(SCENE, duv + float2(0.0, bl)).rgb
                + tex2D(SCENE, duv - float2(0.0, bl)).rgb;
    col = lerp(col, blur * 0.25, saturate(r * 2.0));

    // exit pupil: the bright disc, off centre when the eye is off the scope axis
    float dp = length(uv - C0.xy);
    float pupil = 1.0 - smoothstep(C0.z - C0.w, C0.z, dp);

    // eyepiece tube rim, nearly fixed
    float dt = length(uv - C2.xy);
    float tube = 1.0 - smoothstep(C1.w - C2.z, C1.w, dt);

    col *= min(pupil, tube) * C2.w;
    return float4(col, 1.0);
}

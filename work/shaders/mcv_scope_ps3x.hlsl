// Scope lens: screen reprojection, entirely in the shader.
//
// The lens submaterial samples the frame captured before the viewmodel was drawn (the world
// only) and magnifies it around the point where the scope axis meets the screen (A, from Lua
// each frame: the muzzle direction projected, so it follows the gun's sway). No second render
// of the world. The pixel at A shows exactly what lies behind it; everything else moves in by
// the magnification. On top, in lens coordinates: the reticle (second texture), an exit pupil
// that slides against the axis offset from the screen centre, the eyepiece tube rim, barrel
// distortion, chromatic aberration and edge blur.
//
//   c0: x 1/magnification   y pupil slide per unit of axis offset   z pupil radius (lens units)   w pupil softness
//   c1: x barrel distortion y chromatic aberration                  z edge blur                   w tube radius
//   c2: x tube softness     y brightness                            z screen aspect (w/h)         w reticle strength
//   c3: x, y scope axis on screen (0..1, y down)                    z debug (1: show lens uv)
sampler SCREEN  : register(s0);
sampler RETICLE : register(s1);
float4 C0 : register(c0);
float4 C1 : register(c1);
float4 C2 : register(c2);
float4 C3 : register(c3);

struct PS_INPUT {
    float2 uv   : TEXCOORD0;
    float4 clip : TEXCOORD1;
};

float4 main(PS_INPUT frag) : COLOR {
    if (C3.z > 0.5) return float4(frag.uv, 0.0, 1.0);

    float aspect = C2.z;
    // this pixel on screen, 0..1 with y down, then in square units (x scaled by the aspect)
    float2 P = frag.clip.xy / frag.clip.w;
    P = float2(P.x * 0.5 + 0.5, 0.5 - P.y * 0.5);
    float2 Ps = float2(P.x * aspect, P.y);
    float2 As = float2(C3.x * aspect, C3.y);

    // lens coordinates, centred
    float2 d = frag.uv - 0.5;
    float r2 = dot(d, d);
    float r = sqrt(r2);

    // magnify the screen around the axis; barrel distortion bends it by the lens radius
    float2 rel = (Ps - As) * C0.x * (1.0 + C1.x * r2);
    float2 base = As + rel;
    float2 dir = rel / max(length(rel), 1e-4);

    float ca = C1.y * r2;
    float3 col;
    col.r = tex2D(SCREEN, float2((base.x + dir.x * ca) / aspect, base.y + dir.y * ca)).r;
    col.g = tex2D(SCREEN, float2(base.x / aspect, base.y)).g;
    col.b = tex2D(SCREEN, float2((base.x - dir.x * ca) / aspect, base.y - dir.y * ca)).b;

    float bl = C1.z * r2;
    float3 blur = tex2D(SCREEN, float2((base.x + bl) / aspect, base.y)).rgb
                + tex2D(SCREEN, float2((base.x - bl) / aspect, base.y)).rgb
                + tex2D(SCREEN, float2(base.x / aspect, base.y + bl)).rgb
                + tex2D(SCREEN, float2(base.x / aspect, base.y - bl)).rgb;
    col = lerp(col, blur * 0.25, saturate(r * 2.0));

    // reticle: opaque where the crosshair lines are
    float ret = tex2D(RETICLE, frag.uv).a * C2.w;
    col *= 1.0 - ret;

    // exit pupil slides against the axis offset from the screen centre (eye off the scope axis)
    float2 off = As - float2(0.5 * aspect, 0.5);
    float dp = length(d + off * C0.y);
    float pupil = 1.0 - smoothstep(C0.z - C0.w, C0.z, dp);

    // eyepiece tube rim
    float tube = 1.0 - smoothstep(C1.w - C2.x, C1.w, r);

    col *= min(pupil, tube) * C2.y;
    return float4(col, 1.0);
}

// Scope lens: screen reprojection, entirely in the shader.
//
// The lens submaterial samples the frame captured before the viewmodel was drawn (the world
// only) and magnifies it around the point where the shot goes (A, from Lua each frame: the
// gun base's aim vector projected, so it follows the kick and the sway). No second render of
// the world. The pixel at A shows exactly what lies behind it; everything else moves in by the
// magnification. On top, on a reticle plane centred on A: the reticle (second texture), the
// shadow ring and the black surround; in lens coordinates: the eyepiece tube rim, barrel
// distortion, chromatic aberration and edge blur.
//
//   c0: x 1/magnification   y (unused)                             z shadow radius (reticle plane units, 0.5 = its edge)   w shadow softness
//   c1: x barrel distortion y chromatic aberration                  z edge blur                   w (unused)
//   c2: x (unused)           y brightness                            z screen aspect (w/h)         w reticle strength
//   c3: x, y scope axis on screen (0..1, y down)   z debug (1: show lens uv, 2: solid red)   w lens diameter on screen (fraction of height)
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
    if (C3.z > 1.5) return float4(1.0, 0.0, 0.0, 1.0);
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

    // outside the captured frame there is nothing to show: black, not the clamped edge pixels
    // (a hard kick or a wide sway pushes the magnified window past the screen)
    float2 fuv = float2(base.x / aspect, base.y);
    col *= step(0.0, fuv.x) * step(fuv.x, 1.0) * step(0.0, fuv.y) * step(fuv.y, 1.0);

    // The reticle plane: a square C3.w of the screen height across, centred on the aim point
    // (where the shot goes), so the reticle, the shadow and the black surround all move
    // together with the kick and the sway; the lens mesh only clips them.
    float2 pl = (Ps - As) / max(C3.w, 1e-3);
    float2 ruv = 0.5 + pl;
    float inplane = step(0.0, ruv.x) * step(ruv.x, 1.0) * step(0.0, ruv.y) * step(ruv.y, 1.0);

    // the shadow: the far end of the tube, a dark ring closing in from the plane's edge, drawn
    // over the picture; everything past it is black (several reticle textures have no black
    // border of their own)
    float dp = length(pl);
    float pupil = 1.0 - smoothstep(C0.z - C0.w, C0.z, dp);
    col *= pupil * inplane;

    // reticle on top, opaque where the crosshair lines are, inside the plane only
    float ret = tex2D(RETICLE, ruv).a * C2.w * inplane;
    col *= 1.0 - ret;

    // no rim in lens coordinates any more: the shadow and the black surround live on the
    // reticle plane above, so nothing moves with the lens mesh itself
    col *= C2.y;
    return float4(col, 1.0);
}

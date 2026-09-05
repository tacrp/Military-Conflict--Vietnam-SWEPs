"""Rewrite the game's optics materials into forms GMod can draw.

    python fix_optics_vmts.py            # report and apply
    python fix_optics_vmts.py --dry-run  # report only

The game's lens_*.vmt and some crosshair_*.vmt (Vz.54 Meopta, ZF41) are `Refract` shaders in
"$scopelensmode", fed by a render target only the game creates (_rt_SniperScope). GMod renders
them as a black disc. They become:

* lens_*        VertexLitGeneric glass (the alternative the game left commented out in its own
                files): scope_glass_diffuse, the normal map, cubemap reflection, translucent.
                The RT scope swaps the lens submaterial for its picture while aiming, so this
                is what shows when not aiming.
* crosshair_*   VertexLitGeneric, translucent, the reticle texture itself (what
                port_weapon.ensure_reticle_vmt writes for reticles the game shipped no VMT for).

Run after `rip_game.py --steps materials`; existing optics files are never overwritten by the
rip, so this only has to be repeated when new optics arrive.
"""
import argparse
import glob
import os
import re

HERE = os.path.dirname(os.path.abspath(__file__))
ADDON = os.path.dirname(HERE)
OPTICS = os.path.join(ADDON, "materials", "models", "weapons", "mcv", "optics")

GLASS = '''"VertexLitGeneric"
{
	// GMod form of the game's Refract scope lens (see work/fix_optics_vmts.py)
	"$basetexture" "models\\weapons\\mcv\\optics\\scope_glass_diffuse"
	"$bumpmap" "models\\weapons\\mcv\\optics\\scope_glass_normal"
	"$surfaceprop" "glass"
	"$phong" "1"
	"$phongboost" "2"
	"$phongexponent" "7"
	"$phongfresnelranges" "[0.05 0.7 1]"
	"$normalmapalphaenvmapmask" "1"
	"$envmap" "env_cubemap"
	"$envmaptint" "[0.5 0.5 0.5]"
	"$envmapfresnel" "1"
	// opaque: the glass texture's alpha is 5%, which made the eyepiece vanish when not aiming.
	// From outside a scope's eyepiece is a dark disc with reflections.
	"$color2" "[0.35 0.37 0.4]"
	"$nocsm" "1"
}
'''

RETICLE = '''"VertexLitGeneric"
{
	"$basetexture" "models\\weapons\\mcv\\optics\\%s"
	"$translucent" "1"
	"$nocsm" "1"
}
'''


def is_refract(src):
    return re.match(r'\s*"?Refract"?\s*\{', src, re.I) is not None


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()
    changed = 0
    for p in sorted(glob.glob(os.path.join(OPTICS, "*.vmt"))):
        base = os.path.basename(p)[:-4]
        src = open(p, encoding="utf-8", errors="replace").read()
        if not is_refract(src):
            continue
        if base.lower().startswith("lens_"):
            new = GLASS
        elif base.lower().startswith("crosshair_"):
            new = RETICLE % base
        else:
            print("%-28s Refract, left alone" % base)
            continue
        print("%-28s Refract -> %s" % (base, "glass" if new is GLASS else "reticle"))
        changed += 1
        if not args.dry_run:
            open(p, "w", encoding="utf-8", newline="\n").write(new)
    print("%d files %s" % (changed, "would change" if args.dry_run else "changed"))


if __name__ == "__main__":
    main()

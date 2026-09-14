"""Draw spawn icons from actual meshes in the game's line-art style.

White fill with translucent black details, transparent square, middle half-height
band. Orthographic depth/normal rendering preserves the weapons' real proportions.
No model compilation or weapon Lua regeneration.
"""
from pathlib import Path
import argparse
import hashlib
import json
import re
import tempfile
import numpy as np
from PIL import Image, ImageDraw, ImageFilter, ImageFont
from bake_ik import load_smd, fk

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
OUT = HERE / "spawn_icons"
PRESETS = {
    "rhogun": ("RHOGUN", "MCV_SMD_OG/weapons/v_rhogun/Ref_new.smd"),
    "cobra": ("Cobra Mk1", "MCV_SMD_OG/weapons/v_cobra/Ref_new.smd"),
    "ptrd_sniper": ("PTRD-41 Sniper", "MCV_SMD/weapons/v_ptrd41_s/Ref_new.smd"),
    "m635": ("M635", "MCV_SMD/weapons/v_m635/m635.smd"),
    "xm16super": ("XM16 Super", "MCV_SMD/weapons/v_xm16super/xm16super.smd"),
}


def make(name, source=None, *, out=None, bone="Base", side="left", size=512,
         exclude=("shell",), line_opacity=0.65):
    """Render one PNG. With out=None, install it and retain an import override."""
    name = name.removeprefix("mcv_")
    if not re.fullmatch(r"[a-z0-9_]+", name):
        raise ValueError("Icon name must contain only lowercase letters, digits and underscores")
    if not 0 <= line_opacity <= 1:
        raise ValueError("Line opacity must be between 0 and 1")
    source = Path(source).resolve() if source else HERE / PRESETS[name][1]
    nodes, frames, _ = load_smd(source)
    base = next((i for i, (label, _) in nodes.items() if label == bone), None)
    if base is None:
        raise ValueError(f"No bone {bone!r} in {source}")
    inverse = np.linalg.inv(fk(nodes, frames[0])[base])
    lines = source.read_text().split("triangles\n", 1)[1].splitlines()
    vertices, normals = [], []
    for offset in range(0, len(lines) - 1, 4):
        # The loaded round is inside the magazine; don't expose its hidden mesh.
        if any(term.lower() in lines[offset].lower() for term in exclude):
            continue
        triangle = [list(map(float, lines[offset + j].split()[1:7])) for j in (1, 2, 3)]
        vertices.append([v[:3] + [1] for v in triangle])
        normals.append([v[3:6] for v in triangle])
    if not vertices:
        raise ValueError(f"No triangles left in {source}")
    vertices = np.asarray(vertices) @ inverse.T
    normals = np.asarray(normals) @ inverse[:3, :3].T
    # The viewmodel Base's -X is the muzzle, Z is up. View along the left side.
    xy = np.stack((-vertices[:, :, 0], -vertices[:, :, 2]), axis=-1)
    lo, hi = xy.min(axis=(0, 1)), xy.max(axis=(0, 1))
    final_size, size = size, size * 3
    if np.any(hi - lo < 1e-6):
        raise ValueError("Mesh has no side profile in this bone's X/Z plane")
    padding = size / 64
    scale = min((size - padding) / (hi[0] - lo[0]), (size / 2 - padding) / (hi[1] - lo[1]))
    xy = (xy - (lo + hi) / 2) * scale + size / 2
    depth = np.full((size, size), -np.inf, dtype=np.float32)
    normal = np.zeros((size, size, 3), dtype=np.float32)
    for tri, position, vertex_normal in zip(xy, vertices, normals):
        x0, y0 = np.maximum(np.floor(tri.min(axis=0)).astype(int), 0)
        x1, y1 = np.minimum(np.ceil(tri.max(axis=0)).astype(int) + 1, size)
        if x1 <= x0 or y1 <= y0:
            continue
        a, b, c = tri
        determinant = (b[1] - c[1]) * (a[0] - c[0]) + (c[0] - b[0]) * (a[1] - c[1])
        if abs(determinant) < 1e-8:
            continue
        yy, xx = np.mgrid[y0:y1, x0:x1]
        xx, yy = xx + 0.5, yy + 0.5
        u = ((b[1] - c[1]) * (xx - c[0]) + (c[0] - b[0]) * (yy - c[1])) / determinant
        v = ((c[1] - a[1]) * (xx - c[0]) + (a[0] - c[0]) * (yy - c[1])) / determinant
        w = 1 - u - v
        z = (u * position[0, 1] + v * position[1, 1] + w * position[2, 1]) * (1 if side == "left" else -1)
        view = depth[y0:y1, x0:x1]
        visible = (u >= -1e-7) & (v >= -1e-7) & (w >= -1e-7) & (z > view)
        if not np.any(visible):
            continue
        view[visible] = z[visible]
        n = u[..., None] * vertex_normal[0] + v[..., None] * vertex_normal[1] + w[..., None] * vertex_normal[2]
        n /= np.maximum(np.linalg.norm(n, axis=-1, keepdims=True), 1e-9)
        normal[y0:y1, x0:x1][visible] = n[visible]
    mask = np.isfinite(depth)
    edges = np.zeros_like(mask)
    for axis in (0, 1):
        shifted_mask = np.roll(mask, 1, axis)
        both = mask & shifted_mask
        delta = np.zeros_like(depth)
        np.subtract(depth, np.roll(depth, 1, axis), out=delta, where=both)
        dot = np.sum(normal * np.roll(normal, 1, axis), axis=-1)
        edges |= both & ((np.abs(delta) > 0.11) | (dot < 0.82))
    coverage = Image.fromarray(np.uint8(mask) * 255)
    ink = Image.fromarray(np.uint8(edges) * 255).filter(ImageFilter.MaxFilter(3))
    line = (0, 0, 0, round(255 * line_opacity))
    result = Image.new("RGBA", (size, size))
    result.paste(line, mask=coverage.filter(ImageFilter.MaxFilter(5)))
    result.paste((255, 255, 255, 255), mask=coverage)
    # Replace white beneath the features with translucent ink. Alpha-compositing
    # ink over an opaque fill would make grey, fully opaque lines instead.
    result.paste(line, mask=ink)
    result = result.resize((final_size, final_size), Image.Resampling.LANCZOS)
    output_dir = Path(out).resolve() if out is not None else OUT
    output_dir.mkdir(parents=True, exist_ok=True)
    destination = output_dir / f"mcv_{name}.png"
    result.save(destination)
    installed = ROOT / "materials/entities" / destination.name
    if out is None:
        # Replace a completed PNG instead of truncating a texture the game may have open.
        with tempfile.NamedTemporaryFile(dir=installed.parent, prefix=installed.stem + "_",
                                         suffix=".tmp", delete=False) as handle:
            handle.write(destination.read_bytes())
            temporary = Path(handle.name)
        try:
            temporary.replace(installed)
        finally:
            temporary.unlink(missing_ok=True)
    def relative(path):
        return path.relative_to(ROOT).as_posix() if path.is_relative_to(ROOT) else str(path)
    record = {"name": name, "source": relative(source), "output": relative(destination),
              "installed": relative(installed) if out is None else None,
              "source_sha256": hashlib.sha256(source.read_bytes()).hexdigest(),
              "png_sha256": hashlib.sha256(destination.read_bytes()).hexdigest(),
              "triangles": len(vertices), "size": final_size, "bone": bone, "side": side,
              "style": "translucent_outline", "line_opacity": line_opacity,
              "exclude_materials": list(exclude), "alpha_bounds": result.getchannel("A").getbbox()}
    manifest = output_dir / "manifest.json"
    records = json.loads(manifest.read_text()) if manifest.exists() else []
    records = [r for r in records if r["name"] != name] + [record]
    manifest.write_text(json.dumps(records, indent=2) + "\n")
    return record


def preview(records, out):
    columns = min(3, len(records))
    rows = (len(records) + columns - 1) // columns
    sheet = Image.new("RGB", (columns * 512 + 40, rows * 330 + 20), (32, 36, 39))
    draw = ImageDraw.Draw(sheet)
    try:
        font = ImageFont.truetype("C:/Windows/Fonts/segoeui.ttf", 20)
    except OSError:
        font = ImageFont.load_default()
    for i, record in enumerate(records):
        name = record["name"]
        im = Image.open(out / f"mcv_{name}.png").resize((512, 512), Image.Resampling.LANCZOS)
        x, y = 20 + (i % columns) * 512, 20 + (i // columns) * 330
        im = im.crop((0, 120, 512, 392))
        sheet.paste(im, (x, y), im)
        draw.text((x + 16, y + 284), PRESETS.get(name, (name,))[0], fill="white", font=font)
    sheet.save(out / "preview.png")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("weapons", nargs="*", help="Preset names; omit to rebuild all five")
    parser.add_argument("--list", action="store_true", help="List presets and source meshes")
    parser.add_argument("--source", type=Path, help="Render a different SMD mesh")
    parser.add_argument("--name", help="Output slug for --source, e.g. my_weapon")
    parser.add_argument("--out", type=Path, help="Preview directory; skips addon installation")
    parser.add_argument("--bone", default="Base", help="Weapon-space bone (default: Base)")
    parser.add_argument("--side", choices=("left", "right"), default="left")
    parser.add_argument("--size", type=int, choices=(256, 512, 1024), default=512)
    parser.add_argument("--line-opacity", type=float, default=0.65, metavar="0..1",
                        help="Outline/detail opacity (default: 0.65); white fill stays opaque")
    parser.add_argument("--exclude-material", action="append", default=[], metavar="SUBSTRING",
                        help="Exclude an additional mesh material (shells already excluded)")
    args = parser.parse_args()
    if not 0 <= args.line_opacity <= 1:
        parser.error("--line-opacity must be between 0 and 1")
    if args.list:
        for name, (label, source) in PRESETS.items():
            print(f"{name:14} {label:16} {source}")
        return
    if bool(args.source) != bool(args.name) or (args.source and args.weapons):
        parser.error("Use --source and --name together, without preset names")
    names = [args.name] if args.source else list(dict.fromkeys(args.weapons or PRESETS))
    if not args.source and any(name not in PRESETS for name in names):
        parser.error("Unknown preset; use --list for available names")
    records = [make(name, args.source, out=args.out, bone=args.bone, side=args.side,
                    size=args.size, exclude=("shell", *args.exclude_material),
                    line_opacity=args.line_opacity) for name in names]
    preview(records, args.out.resolve() if args.out else OUT)
    print(json.dumps(records, indent=2))


if __name__ == "__main__":
    main()

"""Invert the alpha channel of a VTF in place, without recompressing.

Supports DXT5 (alpha blocks are remapped exactly: endpoints swapped/inverted and the 3-bit
indices permuted, both alpha modes), DXT3 (4-bit explicit alpha), and the uncompressed 32-bit
formats. DXT1 has no alpha channel to invert. All mip levels and frames are processed; the
low-res thumbnail is left alone.

    python vtf_invert_alpha.py file.vtf [file2.vtf ...]
    python vtf_invert_alpha.py --stats file.vtf ...   # alpha coverage of mip 0, flags un-inverted ones
"""
import struct
import sys

FMT_RGBA8888, FMT_ABGR8888, FMT_BGRA8888, FMT_DXT1, FMT_DXT3, FMT_DXT5, FMT_BGRX8888 = 0, 1, 12, 13, 14, 15, 16
FMT_ARGB8888 = 11


def _image_data_offset(d):
    vmaj, vmin, hsize = struct.unpack("<III", d[4:16])
    if vmin >= 3:
        nres = struct.unpack("<I", d[68:72])[0]
        for i in range(nres):
            tag = d[80 + 8 * i:80 + 8 * i + 3]
            if tag == b"\x30\x00\x00":
                return struct.unpack("<I", d[84 + 8 * i:88 + 8 * i])[0]
        raise ValueError("no image resource")
    # 7.0 - 7.2: header, then low-res thumbnail (DXT1), then image data
    lw, lh = d[61], d[62]
    lfmt = struct.unpack("<i", d[57:61])[0]
    thumb = 0
    if lfmt != -1 and lw and lh:
        thumb = max(1, (lw + 3) // 4) * max(1, (lh + 3) // 4) * 8
    return hsize + thumb


# index permutations for the two DXT5 alpha modes, see the docstring of invert_dxt5_block
_PERM8 = [1, 0, 7, 6, 5, 4, 3, 2]   # a0 > a1: 8 interpolated alphas
_PERM6 = [1, 0, 5, 4, 3, 2, 7, 6]   # a0 <= a1: 6 interpolated + transparent/opaque


def invert_dxt5_block(block):
    """16 byte DXT5 block -> same block with alpha inverted (color part untouched).

    Interpolated alpha value k of a block is a linear blend of the two endpoints, so inverting
    both endpoints and swapping them keeps the mode (a0 > a1 stays a0' > a1') and turns every
    interpolated value v into 255 - v at the mirrored index. In the 6-alpha mode the two fixed
    codes (0 and 255) simply swap."""
    a0, a1 = block[0], block[1]
    bits = int.from_bytes(block[2:8], "little")
    perm = _PERM8 if a0 > a1 else _PERM6
    na0, na1 = 255 - a1, 255 - a0
    nbits = 0
    for i in range(16):
        idx = (bits >> (3 * i)) & 7
        nbits |= perm[idx] << (3 * i)
    return bytes([na0, na1]) + nbits.to_bytes(6, "little") + block[8:16]


def invert_alpha(path):
    d = bytearray(open(path, "rb").read())
    if d[:4] != b"VTF\0":
        raise ValueError("not a vtf")
    fmt = struct.unpack("<I", d[52:56])[0]
    off = _image_data_offset(d)
    if fmt == FMT_DXT5:
        for p in range(off, len(d) - 15, 16):
            d[p:p + 16] = invert_dxt5_block(bytes(d[p:p + 16]))
    elif fmt == FMT_DXT3:
        for p in range(off, len(d) - 15, 16):
            d[p:p + 8] = bytes(b ^ 0xFF for b in d[p:p + 8])
    elif fmt in (FMT_RGBA8888, FMT_BGRA8888):
        for p in range(off + 3, len(d), 4):
            d[p] ^= 0xFF
    elif fmt in (FMT_ABGR8888, FMT_ARGB8888):
        for p in range(off, len(d), 4):
            d[p] ^= 0xFF
    elif fmt == FMT_DXT1:
        raise ValueError("DXT1 has no alpha channel")
    else:
        raise ValueError("unsupported format %d" % fmt)
    open(path, "wb").write(d)
    return fmt


def _dxt5_block_alphas(block):
    a0, a1 = block[0], block[1]
    if a0 > a1:
        table = [a0, a1] + [((8 - k) * a0 + (k - 1) * a1) // 7 for k in range(2, 8)]
    else:
        table = [a0, a1] + [((6 - k) * a0 + (k - 1) * a1) // 5 for k in range(2, 6)] + [0, 255]
    bits = int.from_bytes(block[2:8], "little")
    return [table[(bits >> (3 * i)) & 7] for i in range(16)]


def alpha_stats(path):
    """(format, width, height, glass alpha, corner alpha) of mip 0.

    A reticle stored the addon's way has transparent glass and an opaque edge; one still in the
    game's convention (opaque glass, clear lines and edge) paints the whole lens black when
    drawn into the scope render target."""
    d = open(path, "rb").read()
    if d[:4] != b"VTF" + bytes([0]):
        raise ValueError("not a vtf")
    w, h = struct.unpack("<HH", d[16:20])
    fmt = struct.unpack("<I", d[52:56])[0]
    alphas = []
    if fmt == FMT_DXT5:
        n = max(1, (w + 3) // 4) * max(1, (h + 3) // 4) * 16
        mip0 = d[len(d) - n:]
        for p in range(0, n, 16):
            alphas.extend(_dxt5_block_alphas(mip0[p:p + 16]))
    elif fmt == FMT_DXT3:
        n = max(1, (w + 3) // 4) * max(1, (h + 3) // 4) * 16
        mip0 = d[len(d) - n:]
        for p in range(0, n, 16):
            v = int.from_bytes(mip0[p:p + 8], "little")
            alphas.extend([((v >> (4 * i)) & 15) * 17 for i in range(16)])
    elif fmt in (FMT_RGBA8888, FMT_BGRA8888, FMT_ABGR8888, FMT_ARGB8888):
        n = w * h * 4
        mip0 = d[len(d) - n:]
        a_off = 3 if fmt in (FMT_RGBA8888, FMT_BGRA8888) else 0
        alphas = list(mip0[a_off::4])
    elif fmt == FMT_DXT1:
        return fmt, w, h, None, None
    else:
        raise ValueError("unsupported format %d" % fmt)
    # glass off the crosshair lines (a diagonal sixth out from the centre) against the corner:
    # the addon's convention has clear glass and an opaque edge, the game's the reverse
    glass = alphas[(h // 2 + h // 6) * w + w // 2 + w // 6]
    corner = alphas[8 * w + 8]
    return fmt, w, h, glass, corner


if __name__ == "__main__":
    args = sys.argv[1:]
    if args and args[0] == "--stats":
        for p in args[1:]:
            try:
                fmt, w, h, glass, corner = alpha_stats(p)
                if glass is None:
                    print("%-60s fmt %2d %4dx%-4d no alpha (DXT1)" % (p, fmt, w, h))
                else:
                    print("%-60s fmt %2d %4dx%-4d glass alpha %3d  edge alpha %3d%s" % (
                        p, fmt, w, h, glass, corner, "   <- game convention, needs inverting" if glass > corner else ""))
            except Exception as e:
                print(p, "skipped:", e)
        sys.exit(0)
    for p in args:
        try:
            print(p, "format", invert_alpha(p))
        except Exception as e:
            print(p, "skipped:", e)

"""Contact sheets and an alignment table from a harness sight survey.

    python sight_survey.py is_     # iron sights (work/tests/sights_all_*.txt)
    python sight_survey.py scope_  # scopes (work/tests/scopes.txt)
    python sight_survey.py s1x_    # scopes at 1x (work/tests/scopes_1x.txt)

Reads garrysmod/data/mcv_harness/shots/<prefix>*.png and results/<prefix>*.client.json,
writes sheets (12 full frames each, no cropping) to work/survey/<prefix>sheet_N.png and prints, per
weapon, where the bore axis meets the screen relative to the centre (pixels at 1600x900) and
the sight amount, sorted by the worst offset. A bore axis more than about 40 px off centre
while fully sighted means the ironsight offsets do not put the eye on the sights.
"""
import glob
import json
import os
import sys

from PIL import Image, ImageDraw

HERE = os.path.dirname(os.path.abspath(__file__))
GM = os.path.dirname(os.path.dirname(os.path.dirname(HERE)))  # garrysmod
SHOTS = os.path.join(GM, "data", "mcv_harness", "shots")
RESULTS = os.path.join(GM, "data", "mcv_harness", "results")
OUT = os.path.join(HERE, "survey")


def main():
    prefix = sys.argv[1] if len(sys.argv) > 1 else "is_"
    os.makedirs(OUT, exist_ok=True)
    shots = sorted(glob.glob(os.path.join(SHOTS, prefix + "*.png")))
    rows = []
    for p in shots:
        name = os.path.basename(p)[len(prefix):-4]
        rp = os.path.join(RESULTS, prefix + name + ".client.json")
        ax, sight, seq = None, None, None
        if os.path.isfile(rp):
            j = json.load(open(rp, encoding="utf-8"))
            vm = j.get("vm") or {}
            a = vm.get("axis")
            sw, sh = (j.get("screen") or [1600, 900])
            if a:
                ax = (a[0] - sw / 2, a[1] - sh / 2)
            sight = j.get("sight_visual")
            seq = vm.get("sequence")
        rows.append((name, p, ax, sight, seq))

    # sheets
    # full frames, never crops: the point is how the sight sits in the player's whole view
    per = 12
    cols = 3
    cw, ch = 480, 270
    for i in range(0, len(rows), per):
        chunk = rows[i:i + per]
        sheet = Image.new("RGB", (cols * (cw + 4), ((len(chunk) + cols - 1) // cols) * (ch + 18)), "white")
        d = ImageDraw.Draw(sheet)
        for k, (name, p, ax, sight, seq) in enumerate(chunk):
            im = Image.open(p).convert("RGB")
            x, y = (k % cols) * (cw + 4), (k // cols) * (ch + 18)
            sheet.paste(im.resize((cw, ch)), (x, y + 16))
            label = name
            if ax:
                label += "  axis %+d,%+d" % (round(ax[0]), round(ax[1]))
            if sight is not None and sight < 0.95:
                label += "  sight %.2f" % sight
            d.text((x + 2, y + 2), label, fill="black")
        out = os.path.join(OUT, "%ssheet_%d.png" % (prefix, i // per + 1))
        sheet.save(out)
    print("%d weapons, %d sheets in %s" % (len(rows), (len(rows) + per - 1) // per, OUT))

    # table, worst first
    def key(r):
        ax = r[2]
        return -(abs(ax[0]) + abs(ax[1])) if ax else 0
    print("%-22s %8s %8s %6s  %s" % ("weapon", "axis_x", "axis_y", "sight", "sequence"))
    for name, p, ax, sight, seq in sorted(rows, key=key):
        print("%-22s %8s %8s %6s  %s" % (name, "%+d" % ax[0] if ax else "-", "%+d" % ax[1] if ax else "-",
                                          "%.2f" % sight if sight is not None else "-", seq or "-"))


if __name__ == "__main__":
    main()

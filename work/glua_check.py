"""Syntax-check GLua files with LuaJIT (lupa) after translating GMod's C-style syntax.

    python glua_check.py ../lua/weapons/*.lua ../lua/entities/*.lua
"""
import glob
import re
import sys

from lupa import LuaRuntime


def to_lua(src):
    out = []
    for line in src.splitlines():
        # strip // comments outside strings (good enough for these files)
        q = None
        buf = []
        i = 0
        while i < len(line):
            c = line[i]
            if q:
                buf.append(c)
                if c == "\\" and i + 1 < len(line):
                    buf.append(line[i + 1]); i += 2; continue
                if c == q:
                    q = None
            else:
                if c in "\"'":
                    q = c
                elif line.startswith("//", i):
                    buf.append("--")
                    buf.append(line[i + 2:])
                    break
                elif line.startswith("!=", i):
                    buf.append("~="); i += 2; continue
                elif c == "!" :
                    buf.append("not "); i += 1; continue
                elif line.startswith("&&", i):
                    buf.append(" and "); i += 2; continue
                elif line.startswith("||", i):
                    buf.append(" or "); i += 2; continue
                buf.append(c)
            i += 1
        l = "".join(buf)
        l = re.sub(r'\bcontinue\b', 'do end', l)
        out.append(l)
    return "\n".join(out)


def main():
    rt = LuaRuntime()
    files = []
    for a in sys.argv[1:]:
        files.extend(glob.glob(a))
    bad = 0
    for f in sorted(files):
        try:
            rt.compile(to_lua(open(f, encoding="utf-8", errors="replace").read()))
        except Exception as e:
            bad += 1
            print("%s: %s" % (f, str(e).splitlines()[0][:200]))
    print("%d files, %d with syntax errors" % (len(files), bad))
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()

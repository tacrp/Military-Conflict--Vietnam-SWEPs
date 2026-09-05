"""Drive a Garry's Mod singleplayer session from outside the game.

    python harness.py start [map]          launch GMod with the harness enabled (default gm_flatgrass)
    python harness.py run tests/x.txt      send a command file, wait, print results and screenshot paths
    python harness.py send "give mcv_sks" "wait 1" "shot sks marker"   ad-hoc commands
    python harness.py status               is the game up, what is queued, last log lines
    python harness.py stop                 ask the game to quit
    python harness.py disable              remove the enable marker (the harness Lua stays inert)

Commands are documented at the top of lua/autorun/sh_mcv_harness.lua. Results land in
garrysmod/data/mcv_harness/results/<job>.json (+ <name>.client.json / .server.json for reports)
and screenshots in garrysmod/data/mcv_harness/shots/<name>.png.

GMod runs one instance per Steam account: `start` refuses while a gmod.exe is running; `run`
and `send` work against whatever instance is up, as long as the harness marker existed when its
map loaded (otherwise reload the map, or run `mcv_harness_enable` in its console... which does
not exist: just `changelevel` after `start`'s marker is in place).
"""
import glob
import json
import os
import subprocess
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
GMOD = os.path.normpath(os.path.join(HERE, "..", "..", "..", ".."))
DATA = os.path.join(GMOD, "garrysmod", "data", "mcv_harness")
QUEUE = os.path.join(DATA, "queue")
RESULTS = os.path.join(DATA, "results")
SHOTS = os.path.join(DATA, "shots")


def ensure_dirs():
    for d in (DATA, QUEUE, RESULTS, SHOTS):
        os.makedirs(d, exist_ok=True)


def enable():
    ensure_dirs()
    with open(os.path.join(DATA, "enable.txt"), "w") as f:
        f.write("1")


def gmod_running():
    out = subprocess.run(["tasklist", "/FI", "IMAGENAME eq gmod.exe"], capture_output=True, text=True).stdout
    return "gmod.exe" in out


def find_exe():
    for p in (os.path.join(GMOD, "bin", "win64", "gmod.exe"), os.path.join(GMOD, "gmod.exe"), os.path.join(GMOD, "hl2.exe")):
        if os.path.isfile(p):
            return p
    hits = glob.glob(os.path.join(GMOD, "**", "gmod.exe"), recursive=True)
    return hits[0] if hits else None


def start(map_name="gm_flatgrass"):
    if gmod_running():
        print("gmod.exe is already running; use `run` against it (reload the map if the harness is not active)")
        return 1
    enable()
    ready = os.path.join(DATA, "ready.txt")
    if os.path.exists(ready):
        os.remove(ready)
    exe = find_exe()
    if not exe:
        print("gmod.exe not found under", GMOD)
        return 1
    args = [exe, "-console", "-novid", "-windowed", "-noborder", "-w", "1600", "-h", "900", "-condebug",
            "+sv_cheats", "1", "+map", map_name]
    print("launching", " ".join(args))
    subprocess.Popen(args, cwd=GMOD, creationflags=getattr(subprocess, "DETACHED_PROCESS", 0) | getattr(subprocess, "CREATE_NEW_PROCESS_GROUP", 0))
    t0 = time.time()
    while time.time() - t0 < 240:
        if os.path.exists(ready):
            print("ready:", open(ready).read().strip(), "after %.0fs" % (time.time() - t0))
            return 0
        time.sleep(2)
    print("timed out waiting for the map to load")
    return 1


def next_job_name(prefix="job"):
    n = int(time.time() * 10) % 100000000
    return "%s_%08d" % (prefix, n)


def send(lines, name=None, wait=True, timeout=120):
    ensure_dirs()
    name = name or next_job_name()
    done = os.path.join(RESULTS, name + ".done")
    res = os.path.join(RESULTS, name + ".json")
    for p in (done, res):
        if os.path.exists(p):
            os.remove(p)
    tmp = os.path.join(QUEUE, name + ".tmp")
    with open(tmp, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")
    os.replace(tmp, os.path.join(QUEUE, name + ".txt"))
    if not wait:
        return name, None
    t0 = time.time()
    while time.time() - t0 < timeout:
        if os.path.exists(done):
            time.sleep(0.2)
            with open(res, encoding="utf-8") as f:
                return name, json.load(f)
        time.sleep(0.25)
    return name, None


def print_results(name, results):
    if results is None:
        print("job", name, "did not finish (is the game up with the harness enabled?)")
        return 1
    if results.get("errors"):
        print("errors:")
        for e in results["errors"]:
            print("  ", e)
    for s in results.get("shots", []):
        p = os.path.join(SHOTS, s + ".png")
        print("shot:", p, "(%d bytes)" % os.path.getsize(p) if os.path.exists(p) else "(missing)")
    for r in results.get("reports", []):
        for side in ("client", "server"):
            p = os.path.join(RESULTS, "%s.%s.json" % (r, side))
            if os.path.exists(p):
                print("report:", p)
    return 1 if results.get("errors") else 0


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        return 1
    cmd = sys.argv[1]
    if cmd == "start":
        return start(sys.argv[2] if len(sys.argv) > 2 else "gm_flatgrass")
    if cmd == "run":
        lines = [l.rstrip("\n") for l in open(sys.argv[2], encoding="utf-8")]
        name, results = send(lines, name=next_job_name(os.path.splitext(os.path.basename(sys.argv[2]))[0]))
        return print_results(name, results)
    if cmd == "send":
        name, results = send(sys.argv[2:])
        return print_results(name, results)
    if cmd == "status":
        print("gmod running:", gmod_running())
        print("enabled:", os.path.exists(os.path.join(DATA, "enable.txt")))
        print("queued:", os.listdir(QUEUE) if os.path.isdir(QUEUE) else [])
        lp = os.path.join(DATA, "log.txt")
        if os.path.exists(lp):
            print("\n".join(open(lp, encoding="utf-8", errors="replace").read().splitlines()[-10:]))
        return 0
    if cmd == "stop":
        send(["quit"], wait=False)
        return 0
    if cmd == "disable":
        p = os.path.join(DATA, "enable.txt")
        if os.path.exists(p):
            os.remove(p)
        return 0
    print(__doc__)
    return 1


if __name__ == "__main__":
    sys.exit(main())

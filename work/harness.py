"""Drive a Garry's Mod session from outside the game.

    python harness.py start [map] [--mp] [--multirun] [--port N] [--connect host:port]
                                           launch GMod with the harness enabled (default gm_flatgrass).
                                           --mp starts a listen server (maxplayers 2) so the host
                                           client predicts as it would online; --multirun runs
                                           alongside another instance (needs its own --port)
                                           --connect joins an existing server as an observer;
                                           control that player through the host's Lua commands.
    python harness.py run tests/x.txt [--port N]
                                           send a command file, wait, print results and screenshot paths
    python harness.py send "give mcv_sks" "wait 1" "shot sks marker"   ad-hoc commands
    python harness.py status               is the game up, what is queued, last log lines
    python harness.py stop                 ask the game to quit
    python harness.py disable              remove the enable marker (the harness Lua stays inert)

Commands are documented at the top of lua/autorun/sh_mcv_harness.lua. Results land in
garrysmod/data/mcv_harness/results/<job>.json (+ <name>.client.json / .server.json for reports)
and screenshots in garrysmod/data/mcv_harness/shots/<name>.png.

GMod runs one instance per Steam account unless launched with -multirun: `start` refuses while
a gmod.exe is running without it; `run` and `send` work against whatever instance is up, as
long as the harness marker existed when its map loaded. An instance started with --port N
(anything but 27015) keeps its queue, results and shots under data/mcv_harness/pN/, so several
can run at once; pass the same --port to run/send/status to address it.

A `run` also reports the engine's own prediction complaints: it notes where console.log ends
before the job and prints any "pred error"-type lines written during it (the client has to have
cl_showerror on, which the tests do themselves).
"""
import glob
import json
import os
import re
import subprocess
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
GMOD = os.path.normpath(os.path.join(HERE, "..", "..", "..", ".."))
CONSOLE_LOG = os.path.join(GMOD, "garrysmod", "console.log")
DEFAULT_PORT = 27015


def take_opt(args, name, default=None, flag=False):
    """Pull --name [value] out of an argument list."""
    if name in args:
        i = args.index(name)
        if flag:
            del args[i]
            return True
        val = args[i + 1]
        del args[i:i + 2]
        return val
    return default


PORT = int(take_opt(sys.argv, "--port", DEFAULT_PORT))

DATA = os.path.join(GMOD, "garrysmod", "data", "mcv_harness")
INST = DATA if PORT == DEFAULT_PORT else os.path.join(DATA, "p%d" % PORT)
QUEUE = os.path.join(INST, "queue")
RESULTS = os.path.join(INST, "results")
SHOTS = os.path.join(INST, "shots")


def ensure_dirs():
    for d in (DATA, INST, QUEUE, RESULTS, SHOTS):
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


def start(map_name="gm_flatgrass", mp=False, multirun=False, connect=None):
    if gmod_running() and not multirun:
        print("gmod.exe is already running; use `run` against it (reload the map if the harness is not active), or start with --multirun")
        return 1
    enable()
    ready = os.path.join(INST, "client_ready.txt" if connect else "ready.txt")
    if os.path.exists(ready):
        os.remove(ready)
    exe = find_exe()
    if not exe:
        print("gmod.exe not found under", GMOD)
        return 1
    args = [exe, "-console", "-novid", "-windowed", "-noborder", "-w", "1600", "-h", "900", "-condebug"]
    if multirun:
        args.append("-multirun")
    if PORT != DEFAULT_PORT:
        # a second listen server needs its own server and client sockets
        args += ["-port", str(PORT), "-clientport", str(27005 + (PORT - DEFAULT_PORT))]
    args += ["+sv_cheats", "1"]
    if mp:
        # maxplayers above 1 is what makes the host's client predict, as any client online does
        args += ["+sv_lan", "1", "+maxplayers", "2"]
    else:
        args += ["+maxplayers", "1"]
    args += ["+connect", connect] if connect else ["+map", map_name]
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


def send(lines, name=None, wait=True, timeout=900):
    ensure_dirs()
    name = name or next_job_name()
    done = os.path.join(RESULTS, name + ".done.txt")
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


PRED_LINE = re.compile(r"pred(iction)?[ _]?err|mismatch|predict|\bdiffers\b", re.I)


def console_tail(offset):
    """Lines console.log gained since `offset`, and the new end offset."""
    if not os.path.exists(CONSOLE_LOG):
        return [], 0
    size = os.path.getsize(CONSOLE_LOG)
    if size < offset:
        offset = 0
    with open(CONSOLE_LOG, "rb") as f:
        f.seek(offset)
        data = f.read()
    return data.decode("utf-8", errors="replace").splitlines(), size


def print_results(name, results, log_offset=None):
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
    for t in results.get("ptraces", []):
        for side in ("client", "server"):
            p = os.path.join(RESULTS, "%s.ptrace.%s.json" % (t, side))
            print("ptrace:", p, "" if os.path.exists(p) else "(missing)")
    if log_offset is not None:
        lines, _ = console_tail(log_offset)
        hits = [l for l in lines if PRED_LINE.search(l)]
        print("console: %d new lines, %d prediction-related" % (len(lines), len(hits)))
        for l in hits[:40]:
            print("  ", l)
        if len(hits) > 40:
            print("   ... %d more" % (len(hits) - 40))
    return 1 if results.get("errors") else 0


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        return 1
    cmd = sys.argv[1]
    if cmd == "start":
        mp = take_opt(sys.argv, "--mp", flag=True)
        multirun = take_opt(sys.argv, "--multirun", flag=True)
        connect = take_opt(sys.argv, "--connect")
        return start(sys.argv[2] if len(sys.argv) > 2 else "gm_flatgrass", mp=bool(mp), multirun=bool(multirun), connect=connect)
    if cmd == "run":
        lines = [l.rstrip("\n") for l in open(sys.argv[2], encoding="utf-8")]
        offset = os.path.getsize(CONSOLE_LOG) if os.path.exists(CONSOLE_LOG) else 0
        name, results = send(lines, name=next_job_name(os.path.splitext(os.path.basename(sys.argv[2]))[0]))
        return print_results(name, results, log_offset=offset)
    if cmd == "send":
        offset = os.path.getsize(CONSOLE_LOG) if os.path.exists(CONSOLE_LOG) else 0
        name, results = send(sys.argv[2:])
        return print_results(name, results, log_offset=offset)
    if cmd == "status":
        print("gmod running:", gmod_running())
        print("instance:", INST)
        print("enabled:", os.path.exists(os.path.join(DATA, "enable.txt")))
        print("queued:", os.listdir(QUEUE) if os.path.isdir(QUEUE) else [])
        lp = os.path.join(INST, "log.txt")
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

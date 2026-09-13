"""Compare diagnostic samples by user command, entity and hook.

python work/ptrace_diff.py NAME --port 27016 [--show FIELD]

This is not an engine prediction-error counter. Think precedes movement on the client
and follows it on the server. Replays are normal; the last observed replay is not a
guaranteed settled state. Use cl_showerror 2 and prediction_suite.py for engine errors.
Old time-keyed traces are rejected rather than silently comparing different commands.
"""
import argparse
from collections import Counter, defaultdict
import json
from pathlib import Path

DATA = Path(__file__).resolve().parents[3] / "data" / "mcv_harness"
SKIP = {"tick", "ct", "first", "frame", "upct", "event", "cmd", "cmdtick", "ent", "phase",
        "pos", "vel", "eye", "punch", "ground", "crouch", "vm_cycle",
        "vm_model", "weapon_model_index"}  # cached name; index inaccessible server-side


def same(a, b):
    if type(a) in (int, float) and type(b) in (int, float):
        return abs(a - b) <= 0.001
    if isinstance(a, list) and isinstance(b, list):
        return len(a) == len(b) and all(same(x, y) for x, y in zip(a, b))
    return a == b


def index(records):
    out = defaultdict(list)
    for r in records:
        if r.get("cmd", 0) > 0:
            out[(r["cmd"], r["ent"], r["phase"])].append(r)
    return out


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("name")
    p.add_argument("--port", type=int, default=27015)
    p.add_argument("--show")
    p.add_argument("--all", action="store_true")
    a = p.parse_args()
    root = DATA if a.port == 27015 else DATA / f"p{a.port}"
    traces = [json.loads((root / "results" / f"{a.name}.ptrace.{s}.json").read_text())
              for s in ("client", "server")]
    if any(t.get("schema") != 2 for t in traces):
        p.error("trace lacks command identity; recapture with the updated harness")
    client, server = [index(t["records"]) for t in traces]
    both = sorted(client.keys() & server.keys())
    print(f"{a.name}: {len(both)} matching command/entity/hook samples; "
          f"client only {len(client.keys() - server.keys())}, server only {len(server.keys() - client.keys())}")
    print(f"Client replay samples: {sum(not r['first'] for rs in client.values() for r in rs)} (not an error count)")
    for title, choose in (("First prediction", lambda rs: next((r for r in rs if r["first"]), None)),
                          ("Last observed simulation", lambda rs: rs[-1])):
        counts, examples = Counter(), defaultdict(list)
        compared = 0
        for key in both:
            c, s = choose(client[key]), server[key][-1]
            if c is None:
                continue
            compared += 1
            fields = {a.show} if a.show else (c.keys() | s.keys()) - SKIP
            for field in fields:
                if not same(c.get(field), s.get(field)):
                    counts[field] += 1
                    examples[field].append((key, c.get(field), s.get(field)))
        print(f"\n{title}: diagnostic differences across {compared} samples")
        for field, n in counts.most_common():
            print(f"  {field}: {n}")
            for key, c, s in examples[field][:(None if a.all else 3)]:
                print(f"    {key}: client={c!r} server={s!r}")
        if not counts:
            print("  No differences in compared fields.")


if __name__ == "__main__":
    main()

"""Run local MP prediction scenarios; retain raw engine evidence and state reports.

python work/prediction_suite.py --port 27016 --label baseline --lag 100
Setup (give, teleport, ammo) occurs before the measured window. Only one suite may
use console.log at a time: GMod instances share it. The harness queue remains per port.
"""
import argparse
from collections import Counter
import json
from pathlib import Path
import re
import sys

ERROR = re.compile(r"^\s*\d+\s+(\S+::\S+)\s+-.*\bdiffers?\b", re.M)
DEFAULT = ["mcv_m1911a1", "mcv_ammobox_us", "weapon_pistol", "mcv_m14", "mcv_ak47", "mcv_m91", "mcv_m1897", "mcv_m605",
           "mcv_blackhawk", "mcv_m26", "mcv_m1942_machete", "mcv_c4", "mcv_m16mine",
           "mcv_dynamite", "mcv_lpo50", "mcv_medicbox_us", "mcv_binoculars_us", "mcv_m16_xm148",
           "mcv_m14_bayonet_test", "mcv_m60_bipod_test", "mcv_m14_air_test"]


def actions(cls):
    if cls == "mcv_m60_bipod_test":
        return ["key +duck", "wait 1", "tap +use 0.25", "wait 2",
                'lua assert(ply:GetActiveWeapon():GetBipod(), "bipod did not deploy")',
                "key +attack", "wait 1.5", "key -attack", "wait 1", "tap +reload 0.25", "wait 8",
                "key +forward", "wait 0.5", "key -forward", "key -duck", "wait 1"]
    if cls == "mcv_m14_air_test":
        return ["key +forward", "key +jump", "wait 0.2", "tap +attack 0.25", "key -jump",
                "key -forward", "wait 2", "key +attack2", "wait 1", "key +jump", "wait 0.2",
                "tap +attack 0.25", "key -jump", "key -attack2", "wait 2"]
    if cls in ("mcv_medicbox_us", "mcv_ammobox_us"):
        # Fill the carried rifle before dropping: touching the new server-owned
        # ground box is a separate authoritative pickup, not a predicted hand use.
        extra = ["tap +attack2 0.25", "wait 3"] * 2 if cls == "mcv_ammobox_us" else []
        return ["tap +attack2 0.1", "wait 3", "tap +attack2 0.1", "wait 3"] + extra + [
                "key +use", "tap +attack 0.1", "key -use", "wait 2"]
    if cls == "mcv_binoculars_us":
        return ["key +attack2", "wait 1", "key +use", "tap +reload 0.1", "key -use",
                "wait 1", "key -attack2", "wait 1"]
    if cls == "mcv_m1911a1":
        return ['clua print("[dual on]")', "key +walk", "tap +use 0.1", "key -walk", "wait 3",
                'lua assert(ply:GetActiveWeapon():GetAkimbo(), "dual wield did not enable")',
                "key +attack", "wait 0.5",
                "key -attack", "wait 0.5", "tap +attack 0.1", "wait 0.5", "tap +reload 0.1", "wait 5",
                'clua print("[dual off]")', "key +walk", "tap +use 0.1", "key -walk", "wait 3",
                'lua assert(not ply:GetActiveWeapon():GetAkimbo(), "dual wield did not disable")',
                'clua print("[switch rifle]") input.SelectWeapon(ply:GetWeapon("mcv_m14"))', "wait 3",
                'lua assert(ply:GetActiveWeapon():GetClass() == "mcv_m14", "switch to rifle failed")',
                'clua print("[switch pistol]") input.SelectWeapon(ply:GetWeapon("mcv_m1911a1"))', "wait 3"]
    if cls == "mcv_m16_xm148":
        return ["key +walk", "tap +use 0.1", "key -walk", "wait 3",
                'lua assert(ply:GetActiveWeapon():GetGrenadeLauncher(), "launcher did not enable")',
                "tap +attack 0.1", "wait 2",
                "tap +reload 0.1", "wait 4", "key +walk", "tap +use 0.1", "key -walk", "wait 3"]
    if cls == "mcv_m14_bayonet_test":
        return ["key +use", "tap +attack2 0.1", "key -use", "wait 2",
                'lua assert(ply:GetActiveWeapon():GetBayonet(), "bayonet did not attach")',
                "key +forward", "key +speed",
                "wait 0.5", "key +attack", "wait 1", "key -attack", "key -speed", "key -forward",
                "wait 2", "key +use", "tap +attack2 0.1", "key -use", "wait 2"]
    if cls == "mcv_m26":
        return ["key +attack", "wait 0.8", "key -attack", "wait 2", "key +attack2",
                "wait 0.8", "key -attack2", "wait 2", "key +attack", "wait 4", "key -attack", "wait 2"]
    if cls == "mcv_m1942_machete":
        return ["tap +attack 0.1", "wait 0.8", "tap +attack 0.1", "wait 0.8", "tap +attack2 0.1",
                "wait 1", "key +forward", "key +speed", "wait 0.6", "key +attack", "wait 1.5",
                "key -attack", "key -speed", "key -forward", "wait 1.5"]
    if cls in ("mcv_c4", "mcv_m16mine"):
        return ["tap +attack 0.1", "wait 2", "key +moveright", "wait 0.3", "key -moveright",
                "wait 0.5", "tap +attack 0.1", "wait 2", "tap +attack2 0.1", "wait 1.5"]
    if cls == "mcv_dynamite":
        return ["key +attack2", "wait 0.8", "key -attack2", "wait 2", "tap +attack 0.1", "wait 3"]
    return ["tap +attack 0.1", "wait 1.5", "key +attack", "wait 2", "key -attack", "wait 1.5",
            "key +attack2", "wait 0.8", "tap +attack 0.1", "wait 1.5", "key -attack2",
            "tap +reload 0.1", "wait 7", "key +forward", "key +speed", "wait 1",
            "key -speed", "key -forward", "wait 1"]


def validate_reports(root, name, cls):
    errors, states = [], {}
    for moment in ("before", "after"):
        for side in ("client", "server"):
            path = root / f"{name}_{moment}.{side}.json"
            if not path.exists():
                errors.append(f"missing {moment} {side} state")
            else:
                states[(moment, side)] = json.loads(path.read_text())
    if errors:
        return errors
    before, after = states[("before", "server")], states[("after", "server")]
    client = states[("after", "client")]
    for field in ("weapon", "clip", "reserve", "clip2", "reserve2", "health", "ammo", "action_state", "ironsight", "sighted", "akimbo", "launcher", "bayonet", "bipod"):
        if after.get(field) != client.get(field):
            errors.append(f"final {field}: client={client.get(field)} server={after.get(field)}")
    expected_class = actual_class(cls)
    if before.get("weapon") != expected_class or after.get("weapon") != expected_class:
        errors.append("wrong active weapon")
    if after.get("action_state", 0) != 0:
        errors.append(f"action did not finish: {after.get('action_state')}")
    if cls == "mcv_m26" and before["reserve"] - after["reserve"] != 3:
        errors.append("expected exactly three grenades consumed")
    if cls in ("mcv_c4", "mcv_dynamite") and before["reserve"] - after["reserve"] != 2:
        errors.append("expected exactly two charges consumed")
    if cls == "mcv_m16mine" and before["reserve"] - after["reserve"] != 1:
        errors.append("expected one completed mine/stake pair")
    if cls == "mcv_medicbox_us" and (after["health"] != 100 or before["reserve"] - after["reserve"] != 2):
        errors.append("expected one heal, one full-health refusal, and one dropped kit")
    if cls == "mcv_ammobox_us" and before["reserve"] - after["reserve"] != 4:
        errors.append("expected three resupplies, one full-ammo refusal, and one dropped box")
    if cls == "mcv_m16_xm148" and before["clip2"] + before["reserve2"] - after["clip2"] - after["reserve2"] != 1:
        errors.append("expected exactly one launcher round fired")
    if cls in ("weapon_pistol", "mcv_m14", "mcv_ak47", "mcv_m91", "mcv_m1897", "mcv_m605", "mcv_blackhawk", "mcv_lpo50", "mcv_m1911a1", "mcv_m14_air_test", "mcv_m60_bipod_test"):
        if after["clip"] + after["reserve"] >= before["clip"] + before["reserve"]:
            errors.append("firing did not consume ammunition")
    return errors


def actual_class(cls):
    return {"mcv_m14_bayonet_test": "mcv_m14", "mcv_m14_air_test": "mcv_m14",
            "mcv_m60_bipod_test": "mcv_m60"}.get(cls, cls)


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--port", type=int, default=27016)
    p.add_argument("--label", required=True)
    p.add_argument("--lag", type=int, default=100)
    p.add_argument("--optimize", type=int, default=2)
    p.add_argument("--classes", nargs="+", default=DEFAULT)
    p.add_argument("--trace", action="store_true")
    p.add_argument("--singleplayer", action="store_true", help="functional SP regression, not a prediction test")
    a = p.parse_args()
    # harness.py configures its port at import from argv. Pass the parsed value,
    # including our default and argparse's --port=N form, without losing arguments.
    original_argv = sys.argv
    sys.argv = [sys.argv[0], "--port", str(a.port)]
    try:
        import harness as h
    finally:
        sys.argv = original_argv
    assert h.PORT == a.port
    out = Path(h.RESULTS) / a.label
    out.mkdir(parents=True, exist_ok=True)
    summary = []
    for cls in a.classes:
        name = f"{a.label}_{cls}"
        begin, end = f"[prediction begin {name}]", f"[prediction end {name}]"
        lines = ["ccmd net_fakelag 0", "ccmd cl_showerror 0", "god"]
        lines += [f"key -{k}" for k in ("attack", "attack2", "reload", "use", "speed", "walk", "forward", "moveright", "duck", "jump")]
        lines += ["lua game.CleanUpMap()", "strip", "lua ply:RemoveAllAmmo()", "lua ply:SetHealth(ply:GetMaxHealth())", "pos -704 576 -12288", "ang 0 0 0"]
        if cls == "mcv_m14_air_test":
            # Exercise all three impulse components, including non-round input angles.
            lines += ["ang -12.34567 43.21098 0"]
        if cls in ("mcv_ammobox_us", "mcv_m1911a1"):
            lines += ['lua ply:Give("mcv_m14")', "wait 1"]
        if cls == "mcv_m14_bayonet_test":
            lines += ['lua ply:Give("mcv_m1905_bayonet")', "wait 1"]
        weapon_class = actual_class(cls)
        lines += [f"give {weapon_class}",
                  "lua local w=ply:GetActiveWeapon() if IsValid(w) and w:GetPrimaryAmmoType() >= 0 then ply:SetAmmo(40, w:GetPrimaryAmmoType()) end",
                  "lua local w=ply:GetActiveWeapon() if IsValid(w) and w:GetSecondaryAmmoType() >= 0 then ply:SetAmmo(10, w:GetSecondaryAmmoType()) end"]
        if cls == "mcv_m1911a1":
            lines += ['lua MCV.UnlockSecondWeapon(ply, "mcv_m1911a1")']
        if cls == "mcv_medicbox_us":
            lines += ["lua ply:SetHealth(50)"]
        if cls == "mcv_ammobox_us":
            lines += ['lua ply:SetAmmo(0, ply:GetWeapon("mcv_m14"):GetPrimaryAmmoType())']
            # This legacy scenario checks three rifle magazines then refusal/drop.
            # Keep other pools full; supply_deploy_prediction covers a mixed deficit.
            lines += ['lua local rifle=ply:GetWeapon("mcv_m14") for _,p in ipairs(MCV_AmmoSupplyPlan(ply,1,0)) do if p.ammo!=rifle:GetPrimaryAmmoType() then ply:SetAmmo(p.cap,p.ammo) end end']
        lines += ["wait 4", f"ccmd net_fakelag {a.lag}", f"ccmd cl_pred_optimize {a.optimize}",
                  "ccmd cl_predict 1", "ccmd cl_predictweapons 1", "wait 2",
                  f"report {name}_before"]
        observe = not a.singleplayer and cls != "weapon_pistol"
        if observe:
            lines += ['clua local w=ply:GetActiveWeapon() assert(w:GetPredictable(), "weapon is not predictable") MCVCmdStats={first=0,replay=0} local old=w.Think w.Think=function(self, ...) local ret=old(self, ...) if GetPredictionPlayer()==self:GetOwner() then local k=IsFirstTimePredicted() and "first" or "replay" MCVCmdStats[k]=MCVCmdStats[k]+1 end return ret end']
        if a.trace and cls != "weapon_pistol":
            lines.append(f"ptrace start {name}")
        lines += ["wait 1", f"ccmd cl_showerror {0 if a.singleplayer else 2}",
                  f'clua print("{begin}") assert(game.SinglePlayer() == {str(a.singleplayer).lower()}, "wrong test realm")']
        lines += [s.replace(" 0.1", " 0.25") if s.startswith("tap ") else s for s in actions(cls)]
        lines += ["wait 2", f"report {name}_after"]
        if observe:
            lines += ['clua print("[prediction calls]", util.TableToJSON(MCVCmdStats)) assert(MCVCmdStats.first > 0, "weapon never ran a new predicted command")']
            if a.optimize == 0:
                lines += ['clua assert(MCVCmdStats.replay > 0, "forced replay was not exercised")']
        lines += [f'clua print("{end}")', "wait 0.5", "ccmd cl_showerror 0"]
        if a.trace and cls != "weapon_pistol":
            lines.append("ptrace stop")
        lines += ["ccmd net_fakelag 0", "ccmd cl_pred_optimize 2"]
        (out / f"{cls}.txt").write_text("\n".join(lines) + "\n")
        offset = Path(h.CONSOLE_LOG).stat().st_size
        job, result = h.send(lines, name=name, timeout=180)
        loglines, _ = h.console_tail(offset)
        raw = "\n".join(loglines)
        (out / f"{cls}.console.txt").write_text(raw, encoding="utf-8")
        valid = raw.count(begin) == 1 and raw.count(end) == 1 and raw.index(begin) < raw.index(end)
        measured = raw.split(begin, 1)[1].split(end, 1)[0] if valid else ""
        counts = Counter(ERROR.findall(measured))
        calls = re.search(r"\[prediction calls\]\s*(\{[^\r\n]+\})", measured)
        state_errors = validate_reports(Path(h.RESULTS), name, cls)
        asset_errors = [s for s in loglines if s.startswith("Error: Patch material")]
        lua_errors = [s for s in loglines if s not in asset_errors and any(x in s for x in (" error", "Error", "[ERROR]", "called outside", "blocked!", "INVALID ACT", "INVALID SEQUENCE"))]
        entry = {"class": cls, "lag": a.lag, "optimize": a.optimize, "completed": result is not None,
                 "markers_valid": valid, "prediction_checked": not a.singleplayer,
                 "prediction_calls": json.loads(calls[1]) if calls else None,
                 "engine_errors": None if a.singleplayer else sum(counts.values()), "fields": dict(counts),
                 "lua_errors": lua_errors, "asset_errors": asset_errors, "state_errors": state_errors,
                 "harness_errors": result.get("errors", []) if result else ["timeout"]}
        summary.append(entry)
        (out / "summary.json").write_text(json.dumps(summary, indent=2))
        print(json.dumps(entry), flush=True)
        if result is None:
            break
    return int(any(not r["completed"] or not r["markers_valid"] or r["engine_errors"] or r["lua_errors"] or r["state_errors"] or r["harness_errors"] for r in summary))


if __name__ == "__main__":
    raise SystemExit(main())

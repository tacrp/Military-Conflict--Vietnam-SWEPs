"""Exercise launcher sight poses and fire-mode locking through real MP input."""
import argparse
from collections import Counter
import json
from pathlib import Path
import sys
from prediction_suite import ERROR


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--port', type=int, default=27016)
    p.add_argument('--label', required=True)
    p.add_argument('--lag', type=int, default=100)
    p.add_argument('--classes', nargs='+', default=['mcv_vz24', 'mcv_sks', 'mcv_m14', 'mcv_m16a1_m203', 'mcv_m16_xm148'])
    a = p.parse_args()
    sys.argv = [sys.argv[0], '--port', str(a.port)]
    import harness as h
    root = Path(h.RESULTS)
    out = root / a.label
    out.mkdir(parents=True, exist_ok=True)
    summaries = []
    for cls in a.classes:
        name = f'{a.label}_{cls}'
        begin, end = f'[launcher begin {name}]', f'[launcher end {name}]'
        lines = ['ccmd net_fakelag 0', 'ccmd cl_showerror 0']
        lines += [f'key -{k}' for k in ['attack', 'attack2', 'reload', 'use', 'walk', 'speed', 'forward', 'duck']]
        lines += ['lua ply:GodEnable() game.CleanUpMap()', 'strip', 'pos -704 576 -12288', 'ang 0 0 0',
                  f'give {cls}', 'wait 4', 'lua local w=ply:GetActiveWeapon() ply:SetAmmo(8,w:GetSecondaryAmmoType())',
                  'wait 2', f'ccmd net_fakelag {a.lag}', 'ccmd cl_pred_optimize 0', 'wait 2',
                  'clua assert(not game.SinglePlayer(),"MP required") gui.HideGameUI() if gui.IsConsoleVisible() then ply:ConCommand("toggleconsole") end',
                  'clua include("mcv_harness/visual_trace.lua")',
                  f'clua MCV.VisualHarness.StartVisualTrace("{name}",false)',
                  'ccmd cl_showerror 2', f'clua print("{begin}")']

        def phase(label):
            lines.append(f'clua MCV.VisualHarness.VisualPhase="{label}"')

        def state(label):
            for command, side in [('lua', 'server'), ('clua', 'client')]:
                lines.append(f'{command} local w=ply:GetActiveWeapon() local vm=ply:GetViewModel() local seq=vm:GetSequence() local s={{launcher=w:GetGrenadeLauncher(),clip2=w:Clip2(),mode_index=w:GetFiremode(),mode_count=#w.Firemodes,ubgl=w.RifleGrenadeIsUBGL,vm={{activity=vm:GetSequenceActivityName(seq),sequence=vm:GetSequenceName(seq)}}}} file.Write("mcv_harness/p{a.port}/results/{name}_{label}.{side}.json",util.TableToJSON(s))')

        phase('rifle_aim')
        lines += ['key +attack2', 'wait 1']
        state('rifle')
        lines += ['key -attack2', 'wait 0.5']
        phase('enable')
        lines += ['key +walk', 'tap +use 0.12', 'key -walk', 'wait 4', 'key +attack2', 'wait 1']
        phase('launcher_aim')
        lines += ['wait 0.5', f'shot {name}_aim marker']
        state('aim')
        phase('blocked_firemode')
        lines += ['key -attack2', 'wait 0.5', 'key +use', 'tap +reload 0.12', 'key -use', 'wait 1']
        state('blocked')
        lines += ['key +attack2', 'wait 1']
        phase('fire')
        lines += ['tap +attack 0.12', 'wait 4']
        state('fired')
        phase('reload')
        lines += ['key -attack2', 'tap +reload 0.12', 'wait 5', 'key +attack2', 'wait 1']
        state('reloaded')
        phase('disable')
        lines += ['key -attack2', 'wait 0.5', 'key +walk', 'tap +use 0.12', 'key -walk', 'wait 4']
        state('disabled')
        phase('rifle_firemode')
        lines += ['key +use', 'tap +reload 0.12', 'key -use', 'wait 1']
        state('changed')
        lines += [f'clua print("{end}")', 'ccmd cl_showerror 0', 'clua MCV.VisualHarness.StopVisualTrace()',
                  'ccmd net_fakelag 0', 'ccmd cl_pred_optimize 2', 'wait 1']
        (out / f'{cls}.txt').write_text('\n'.join(lines) + '\n')
        offset = Path(h.CONSOLE_LOG).stat().st_size
        _, result = h.send(lines, name=name, timeout=150)
        raw = '\n'.join(h.console_tail(offset)[0])
        (out / f'{cls}.console.txt').write_text(raw, encoding='utf-8')
        failures = list(result.get('errors', [])) if result else ['harness timeout']
        if begin not in raw or end not in raw:
            failures.append('missing measured console markers')
        states = {}
        for side in ['server', 'client']:
            s = {label: json.loads((root / f'{name}_{label}.{side}.json').read_text())
                 for label in ['rifle', 'aim', 'blocked', 'fired', 'reloaded', 'disabled', 'changed']}
            states[side] = s
            expected = 'ACT_VM_IIDLE_M203' if s['aim']['ubgl'] else 'ACT_VM_IDLE_M203'
            for label in ['aim', 'blocked', 'reloaded']:
                if not s[label]['launcher'] or s[label]['vm']['activity'] != expected:
                    failures.append(f'{side} {label}: wrong launcher idle {s[label]["vm"]["activity"]}')
            if s['aim']['mode_index'] != s['blocked']['mode_index']:
                failures.append(f'{side}: launcher changed rifle fire mode')
            if s['fired']['clip2'] != s['aim']['clip2'] - 1:
                failures.append(f'{side}: grenade did not fire')
            if s['reloaded']['clip2'] != 1:
                failures.append(f'{side}: grenade did not reload')
            if s['disabled']['launcher'] or s['disabled']['vm']['activity'] != 'ACT_VM_IDLE':
                failures.append(f'{side}: rifle idle not restored')
            if s['disabled']['mode_index'] != s['rifle']['mode_index']:
                failures.append(f'{side}: rifle mode not preserved')
            if s['changed']['mode_count'] > 1 and s['changed']['mode_index'] == s['disabled']['mode_index']:
                failures.append(f'{side}: rifle fire-mode switching remained blocked')
        trace = json.loads((root / f'{name}.visual.json').read_text())
        frames = [r for r in trace['records'] if r['stage'] == 'drawn']
        if not frames or not trace['movement_replay']:
            failures.append('no rendered frames or replay observed')
        native = dict(Counter(ERROR.findall(raw.partition(begin)[2].partition(end)[0])))
        summary = dict(weapon=cls, failures=failures, native=native, frames=len(frames),
                       replays=trace['movement_replay'],
                       firing_sequences=dict(Counter(r['seqname'] for r in frames if r['phase'] == 'fire')),
                       aimed_idle=states['client']['aim']['vm']['sequence'])
        summaries.append(summary)
        (out / 'summary.json').write_text(json.dumps(summaries, indent=2) + '\n')
        print(json.dumps(summary), flush=True)
    if any(s['failures'] or s['native'] for s in summaries):
        raise SystemExit(1)


if __name__ == '__main__':
    main()

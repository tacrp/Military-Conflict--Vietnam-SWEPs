"""Measure real reload input, animation replay, third-person sound and native errors."""
import argparse
from collections import Counter
import json
from pathlib import Path
import sys
from prediction_suite import ERROR


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--port',type=int,default=27016)
    p.add_argument('--label',required=True)
    p.add_argument('--lag',type=int,default=100)
    p.add_argument('--optimize',type=int,default=0)
    p.add_argument('--third',action='store_true')
    p.add_argument('--empty',action='store_true')
    p.add_argument('--capture',action='store_true')
    p.add_argument('--singleplayer',action='store_true')
    p.add_argument('--shoot',action='store_true')
    p.add_argument('--classes',nargs='+',default=['mcv_m870','mcv_m1897'])
    a=p.parse_args()
    sys.argv=[sys.argv[0],'--port',str(a.port)]
    import harness as h
    out=Path(h.RESULTS)/a.label
    out.mkdir(exist_ok=True,parents=True)
    summaries=[]
    for cls in a.classes:
        name=f'{a.label}_{cls}'
        begin=f'[reload begin {name}]'; end=f'[reload end {name}]'
        lines=['ccmd net_fakelag 0','ccmd cl_showerror 0','god']
        lines += [f'key -{k}' for k in ['attack','attack2','speed','forward','jump','duck','use','reload']]
        lines += ['strip','lua game.CleanUpMap()','lua collectgarbage()','clua collectgarbage()',
            'pos -704 576 -12288','ang 0 0 0',f'give {cls}','wait 3',
            f'lua local w=ply:GetActiveWeapon() w:SetClip1({"w:GetClip1Capacity()" if a.shoot else 0 if a.empty else 1}) ply:SetAmmo(60,w:GetPrimaryAmmoType())',
            'wait 2',f'ccmd net_fakelag {a.lag}',f'ccmd cl_pred_optimize {a.optimize}','wait 2',
            f'clua assert(game.SinglePlayer()=={str(a.singleplayer).lower()},"wrong SP/MP mode")',
            'clua gui.HideGameUI() if gui.IsConsoleVisible() then ply:ConCommand("toggleconsole") end',
            'clua include("mcv_harness/reload_trace.lua")',
            f'clua MCV.ReloadHarness.Start("{name}",{str(a.third).lower()})']
        if not a.third:
            lines += ['clua include("mcv_harness/visual_trace.lua")',
                f'clua MCV.VisualHarness.StartVisualTrace("{name}",{str(a.capture).lower()})']
        lines += [f'report {name}_before',f'ccmd cl_showerror {0 if a.singleplayer else 2}',f'clua print("{begin}")']
        if a.shoot:
            # Inject a precise number of real user commands; wall-clock key releases
            # arrive too late under simulated latency and turn taps into bursts.
            lines += ['clua MCVHarnessPulse=0 hook.Add("CreateMove","MCV_ShootPulse",function(cmd) if cmd:CommandNumber()==0 then return end if MCVHarnessPulse>0 then cmd:SetButtons(bit.bor(cmd:GetButtons(),IN_ATTACK)) MCVHarnessPulse=MCVHarnessPulse-1 end end)']
            tap='clua MCVHarnessPulse=1'
            if not a.third: lines += ['clua MCV.VisualHarness.VisualPhase="hip_fire"']
            for _ in range(6):
                lines += [tap,'wait 0.8']
            if not a.third: lines += ['clua MCV.VisualHarness.VisualPhase="burst_fire"']
            lines += ['clua MCVHarnessPulse=math.ceil(0.55/engine.TickInterval())','wait 2',
                      'key +attack2','wait 1']
            if not a.third: lines += ['clua MCV.VisualHarness.VisualPhase="aimed_fire"']
            for _ in range(4):
                lines += [tap,'wait 0.8']
            lines += ['key -attack2','wait 1','clua hook.Remove("CreateMove","MCV_ShootPulse")']
        else:
            lines += ['tap +reload 0.12','wait 12']
        lines += [
            f'clua print("{end}")','ccmd cl_showerror 0',f'report {name}_after']
        for prefix in ['lua','clua']:
            if not a.shoot:
                lines += [f'{prefix} local w=ply:GetActiveWeapon() assert(!w:GetReloading(),"reload did not finish") assert(w:Clip1()>{0 if a.empty else 1},"no rounds loaded") assert(w:Clip1()+w:Ammo1()=={60 if a.empty else 61},"reload changed total ammo")']
        if not a.third:
            lines += ['clua MCV.VisualHarness.StopVisualTrace()']
        lines += ['clua MCV.ReloadHarness.Stop()','ccmd net_fakelag 0','wait 1']
        (out/f'{cls}.txt').write_text('\n'.join(lines)+'\n')
        offset=Path(h.CONSOLE_LOG).stat().st_size
        _,result=h.send(lines,name=name,timeout=180)
        raw='\n'.join(h.console_tail(offset)[0])
        (out/f'{cls}.console.txt').write_text(raw,encoding='utf-8')
        if result is None:
            raise RuntimeError('reload test timed out')
        trace=json.loads((Path(h.RESULTS)/f'{name}.reload.json').read_text())
        sounds=trace['sounds']; animations=trace['animations']
        measured=raw.partition(begin)[2].partition(end)[0]
        after=[json.loads((Path(h.RESULTS)/f'{name}_after.{side}.json').read_text()) for side in ['client','server']]
        failures=list(result.get('errors',[]))
        if a.shoot:
            before=json.loads((Path(h.RESULTS)/f'{name}_before.server.json').read_text())
            if after[1]['clip']>=before['clip']: failures.append('shooting did not consume ammo')
        for field in ['weapon','clip','reserve','ammo','action_state']:
            if after[0].get(field)!=after[1].get(field): failures.append(f'client/server {field} differs')
        if a.third and any(not s['first'] and s['predicting'] for s in sounds):
            failures.append('reload sound emitted during prediction replay')
        entry={'weapon':cls,'native':None if a.singleplayer else dict(Counter(ERROR.findall(measured))),
            'sound_count':len(sounds),'replay_sounds':sum(not s['first'] for s in sounds),
            'animation_calls':len(animations),'animation_replays':sum(not r['first'] for r in animations),
            'replay_cycle_resets':sum(not r['first'] and r['before_cycle']>.05 and r['cycle']<.01 for r in animations),
            'first_sequences':[r['seqname'] for r in animations if r['first']],
            'after':[{k:r.get(k) for k in ['clip','reserve','reloading']} for r in after],
            'errors':failures}
        summaries.append(entry)
        (out/'summary.json').write_text(json.dumps(summaries,indent=2)+'\n')
        print(json.dumps(entry),flush=True)
        if failures: raise RuntimeError('reload/shoot assertions failed')


if __name__=='__main__':
    main()

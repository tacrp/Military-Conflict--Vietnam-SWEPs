"""Measure sprint/ADS at render hooks and retain the native console evidence."""
import argparse
import json
from pathlib import Path
import sys
from collections import Counter
from prediction_suite import ERROR
from visual_trace_report import analyze


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--port',type=int,default=27016)
    parser.add_argument('--label',required=True)
    parser.add_argument('--lag',type=int,default=100)
    parser.add_argument('--capture',action='store_true')
    parser.add_argument('--optimize',type=int,choices=[0,1,2],default=2)
    parser.add_argument('--trace',action='store_true',help='Also record command-aligned client/server state')
    parser.add_argument('--singleplayer',action='store_true',help='Functional visual check; native prediction diagnostics are disabled')
    parser.add_argument('--extended',action='store_true',help='Also jump, crouch, fire and rapidly reverse aim/sprint')
    parser.add_argument('--classes',nargs='+',default=['mcv_m2c','mcv_xm177_oeg'])
    a=parser.parse_args()
    if a.singleplayer and a.lag:
        parser.error('singleplayer checks require --lag 0')
    sys.argv=[sys.argv[0],'--port',str(a.port)]
    import harness as h
    out=Path(h.RESULTS)/a.label
    out.mkdir(parents=True,exist_ok=True)
    summaries=[]
    for cls in a.classes:
        name=f'{a.label}_{cls}'
        lines=['ccmd net_fakelag 0','ccmd cl_showerror 0','god']
        lines += [f'key -{k}' for k in ['attack','attack2','speed','walk','forward','back','moveleft','moveright','jump','duck','use']]
        lines += ['lua game.CleanUpMap()','strip','lua collectgarbage()','clua collectgarbage()',
                  'pos -704 576 -12288','ang 0 0 0',f'give {cls}',
                  'wait 5',f'ccmd net_fakelag {a.lag}',f'ccmd cl_pred_optimize {a.optimize}','wait 2',
                  f'clua assert(game.SinglePlayer()=={str(a.singleplayer).lower()},"wrong SP/MP mode")',
                  f'clua assert(GetConVar("net_fakelag"):GetInt()=={a.lag},"fake lag not applied")',
                  'clua gui.HideGameUI() if gui.IsConsoleVisible() then ply:ConCommand("toggleconsole") end',
                  'clua include("mcv_harness/visual_trace.lua")',
                  f'clua MCV.VisualHarness.StartVisualTrace("{name}",{str(a.capture).lower()})',
                  *([f'ptrace start {name}'] if a.trace else []),
                  f'ccmd cl_showerror {0 if a.singleplayer else 2}',f'clua print("[visual begin {name}]")','wait 2']
        phases=[('sprint_up',['+forward','+speed'],2),('sprint_down',['-speed','-forward'],2),
                ('aim_up',['+attack2'],2),('aim_down',['-attack2'],2),
                ('aim_up2',['+attack2'],2),('sprint_aim',['+forward','+speed'],2),
                ('resume_aim',['-speed','-forward'],2),('aim_down2',['-attack2'],2)]
        if a.extended:
            phases += [('aim_run',['+attack2','+forward'],1),('jump_aim',['+jump'],0.3),
                       ('land_aim',['-jump'],1.5),('crouch_aim',['+duck'],1),
                       ('fire_moving',['+attack'],0.4),('stand_aim',['-duck','-attack'],1),
                       ('quick_sprint',['+speed'],0.3),('quick_aim',['-speed'],0.3),
                       ('quick_sprint2',['+speed'],0.3),('quick_aim2',['-speed'],0.3),
                       ('settled',['-forward','-attack2'],2)]
        for phase,keys,duration in phases:
            code=f'MCV.VisualHarness.VisualPhase="{phase}" '
            code+=' '.join(f'ply:ConCommand("{key}")' for key in keys)
            lines += ['clua '+code,f'wait {duration}']
        lines += [f'clua print("[visual end {name}]")','ccmd cl_showerror 0',
                  'clua MCV.VisualHarness.StopVisualTrace()',
                  *(['ptrace stop'] if a.trace else []),
                  'wait 3','ccmd net_fakelag 0']
        (out/f'{cls}.txt').write_text('\n'.join(lines)+'\n')
        offset=Path(h.CONSOLE_LOG).stat().st_size
        _,result=h.send(lines,name=name,timeout=180)
        log,_=h.console_tail(offset)
        (out/f'{cls}.console.txt').write_text('\n'.join(log),encoding='utf-8')
        errors=[s for s in log if 'clua error' in s or '[ERROR]' in s or 'tick error' in s or 'ConCommand is blocked' in s]
        errors += result.get('errors',[]) if result else ['harness timeout']
        trace=Path(h.RESULTS)/f'{name}.visual.json'
        print(name,'complete',result is not None,'trace',trace.exists(),'errors',errors,flush=True)
        if result is None or errors or not trace.exists():
            (out/f'{cls}.failure.json').write_text(json.dumps({'completed':result is not None,
                'trace_exists':trace.exists(),'errors':errors},indent=2)+'\n')
            raise RuntimeError('visual test did not complete; inspect the retained console slice')
        report=analyze(trace)
        raw='\n'.join(log)
        begin=f'[visual begin {name}]'
        end=f'[visual end {name}]'
        if begin not in raw or end not in raw:
            errors.append('missing measured console markers')
        measured=raw.partition(begin)[2].partition(end)[0]
        report.update(lag=a.lag,optimize=a.optimize,prediction_checked=not a.singleplayer,
                      native_errors=None if a.singleplayer else dict(Counter(ERROR.findall(measured))),errors=errors)
        if report['dropped'] or not report['frames'] or report['prediction_consumed_render_cache'] or report['pose_changed_after_position']:
            errors.append('visual invariant failed')
        errors += report['exercise_errors']
        if not a.singleplayer and a.optimize==0 and not report['movement_replay']:
            errors.append('no movement replay observed')
        if not a.singleplayer and not report['movement_first']:
            errors.append('no new predicted movement observed')
        summaries.append(report)
        (out/'summary.json').write_text(json.dumps(summaries,indent=2)+'\n')
        print('frames',report['frames'],'FPS',report['median_fps'],'movement replays',report['movement_replay'],
              'native errors',report['native_errors'],'failures',errors,flush=True)
    if any(r['errors'] or r['native_errors'] for r in summaries):
        raise SystemExit(1)


if __name__=='__main__':
    main()

"""Check render-cache ownership and pose timing in an actual engine trace.

Use --check for fixed runs. Baselines are expected to violate these invariants.
Native engine error counts are separate: multiple instances share console.log.
"""
import argparse
from collections import Counter
import json
from pathlib import Path
import statistics


def analyze(path):
    trace=json.loads(path.read_text())
    rows=trace['records']
    drawn=[r for r in rows if r['stage']=='drawn']
    counts=trace.get('prediction_cache_writes',{})
    consumed=Counter(counts if isinstance(counts,dict) else {})
    pose_mismatch=0
    position={}
    for i,r in enumerate(rows):
        if r['stage']=='position_after':
            if r['predicting'] and i and rows[i-1]['stage']=='position_before':
                before=rows[i-1]
                for key in ('visual_frame','speed_frame'):
                    if r.get(key)!=before.get(key):
                        consumed[key]+=1
            elif not r['predicting']:
                position[r['frame']]=r
        elif r['stage']=='drawn':
            p=position.get(r['frame'])
            if p and any(abs(p[k]-r[k])>1e-6 for k in ('pose_aim','pose_move')):
                pose_mismatch+=1
    phases={}
    targets={'aim_up':1,'aim_up2':1,'resume_aim':1,'aim_down':0,'aim_down2':0,'sprint_aim':0}
    for phase in dict.fromkeys(r['phase'] for r in drawn):
        rr=[r for r in drawn if r['phase']==phase]
        p={'frames':len(rr),'max_aim_gap':round(max(abs(r['raw']-r.get('visual',r['raw'])) for r in rr),4)}
        if phase in targets:
            target=targets[phase]
            reach=next((r for r in rr if abs(r.get('visual',-99)-target)<1e-4),None)
            p['visual_reach_seconds']=round(reach['time']-rr[0]['time'],4) if reach else None
            direction=1 if target else -1
            p['visual_reversals']=sum((b.get('visual',0)-a.get('visual',0))*direction < -1e-5 for a,b in zip(rr,rr[1:]))
        phases[phase]=p
    exercised=[]
    byphase=lambda phase: [r for r in drawn if r['phase']==phase]
    if not byphase('sprint_up') or max(r['speed'] for r in byphase('sprint_up')) < 150:
        exercised.append('sprint blend did not rise')
    if not byphase('aim_up') or max(r['raw'] for r in byphase('aim_up')) < .999:
        exercised.append('aim did not reach full')
    if not byphase('aim_down') or min(r['raw'] for r in byphase('aim_down')) > .001:
        exercised.append('aim did not return to hip')
    if 'jump_aim' in phases and not any(r.get('move_grounded') is False for r in byphase('jump_aim')+byphase('land_aim')):
        exercised.append('jump did not leave the ground')
    if any(p.get('visual_reversals',0) for p in phases.values()):
        exercised.append('visual aim reversed within a steady input phase')
    return {'trace':str(path),'frames':len(drawn),'records':len(rows),'dropped':trace.get('dropped',0),
            'median_fps':round(1/statistics.median(r['rft'] for r in drawn),1),
            'prediction_consumed_render_cache':dict(consumed),
            'prediction_checks':trace.get('prediction_checks',sum(r['stage']=='position_after' and r['predicting'] for r in rows)),
            'pose_changed_after_position':pose_mismatch,
            'movement_first':trace.get('movement_first'),'movement_replay':trace.get('movement_replay'),
            'exercise_errors':exercised,'phases':phases}


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('traces',nargs='+',type=Path)
    p.add_argument('--check',action='store_true')
    args=p.parse_args()
    failed=False
    for path in args.traces:
        report=analyze(path)
        path.with_suffix('.report.json').write_text(json.dumps(report,indent=2)+'\n')
        print(json.dumps(report,indent=2))
        failed |= bool(report['dropped'] or not report['frames'] or report['prediction_consumed_render_cache'] or report['pose_changed_after_position'] or report['exercise_errors'])
    if args.check and failed:
        raise SystemExit(1)


if __name__=='__main__':
    main()

"""Check rendered animation continuity independently of native prediction spew."""
import argparse
import json
from pathlib import Path


def analyze(path):
    data=json.loads(path.read_text())
    frames=[r for r in data['records'] if r['stage']=='drawn']
    calls=json.loads(path.with_name(path.name.replace('.visual.json','.reload.json')).read_text())['animations']
    action_start=min(r['frame'] for r in calls if r['first'] and r['seqname']!='idle')
    backwards=[]; warmup_backwards=[]
    for a,b in zip(frames,frames[1:]):
        if a['seq']==b['seq'] and a.get('animstart')==b.get('animstart') and a.get('animduration',0)>0:
            if b['cycle'] < a['cycle']-0.005:
                entry={'frame':b['frame'],'seq':b['seqname'],'from':a['cycle'],'to':b['cycle']}
                (warmup_backwards if b['frame']<action_start else backwards).append(entry)
    return {'trace':path.name,'frames':len(frames),'movement_replays':data['movement_replay'],
            'max_clock_error':max(abs(r['animtime']-r['animstart']) for r in frames),
            'action_start_frame':action_start,'backwards':backwards,
            'warmup_backwards':warmup_backwards,'dropped':data['dropped']}


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('traces',nargs='+',type=Path)
    p.add_argument('--check',action='store_true')
    a=p.parse_args(); failed=False
    for path in a.traces:
        report=analyze(path)
        path.with_suffix('.continuity.json').write_text(json.dumps(report,indent=2)+'\n')
        print(json.dumps(report))
        failed |= bool(report['backwards'] or report['dropped'] or report['max_clock_error']>0.0001 or not report['frames'])
    if a.check and failed: raise SystemExit(1)

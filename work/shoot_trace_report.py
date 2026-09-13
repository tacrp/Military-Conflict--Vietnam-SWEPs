"""Measure mechanism travel relative to its parent, separately for every fired shot."""
import argparse
import json
import math
from pathlib import Path


def analyze(path):
    data=json.loads(path.read_text())
    anim=json.loads(path.with_name(path.name.replace('.visual.json','.reload.json')).read_text())
    frames=[r for r in data['records'] if r['stage']=='drawn']
    shots=[r for r in anim['animations'] if r['first'] and r['seqname'].startswith('shoot')]
    result=[]
    for i,shot in enumerate(shots):
        stop=shots[i+1]['frame'] if i+1<len(shots) else math.inf
        window=[r for r in frames if shot['frame']<=r['frame']<stop and r['ct']<shot['ct']+0.6]
        travel={}
        for bone in data['mechanisms']:
            vals=[r['mechanisms'][str(bone)]['pos'] for r in window if str(bone) in r['mechanisms']]
            if vals:
                ranges=[max(v[k] for v in vals)-min(v[k] for v in vals) for k in range(3)]
                travel[data['names'][str(bone)]]=round(math.sqrt(sum(x*x for x in ranges)),4)
        result.append(dict(frame=shot['frame'],seq=shot['seqname'],clip=shot['clip'],
            frames=len(window),first_cycle=round(window[0]['cycle'],4) if window else None,
            travel=travel))
    return {'trace':path.name,'shots':result}


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('traces',nargs='+',type=Path)
    a=p.parse_args()
    for path in a.traces:
        report=analyze(path)
        path.with_suffix('.bolts.json').write_text(json.dumps(report,indent=2)+'\n')
        print(json.dumps(report))

"""Summarize reload boundary motion captured after viewmodel rendering."""
import json
from pathlib import Path
import sys
import numpy as np
root=Path(__file__).resolve().parents[3]/'data/mcv_harness/p27016/results'
for label in sys.argv[1:] or ['before_m21']:
    data=json.loads((root/(label+'_render.json')).read_text())['frames']
    print(label,len(data),'frames')
    root_positions=np.array([row['bones']['BaseRoot'] for row in data if 'BaseRoot' in row['bones']])
    root_span=float(np.linalg.norm(np.ptp(root_positions,axis=0)))
    print('gun-root excursion',round(root_span,6),'units')
    if label.startswith('after_'):
        assert root_span<.02, 'gun root moved during the corrected reload'
    for name in ['BaseRoot','Base','hand_r','hand_l','Bolt']:
        diffs=[]
        for a,b in zip(data,data[1:]):
            if name not in a['bones'] or name not in b['bones']: continue
            if (a['seq']=='idle' and b['seq']=='reload_empty') or (a['seq']=='reload_empty' and (a['cycle']<.06 or a['cycle']>.94)):
                dist=float(np.linalg.norm(np.array(a['bones'][name])-b['bones'][name]))
                diffs.append((dist,a['seq'],a['cycle'],b['seq'],b['cycle'],b['time']-a['time']))
        print(name,sorted(diffs,reverse=True)[:3])

"""Summarize the two-client PVS fixture output."""
import collections
import json
import sys
from pathlib import Path

root = Path(__file__).resolve().parents[3] / 'data/mcv_harness/pvs'
for path in sorted(root.glob((sys.argv[1] if len(sys.argv)>1 else 'baseline') + '_*.json')):
    data = json.loads(path.read_text())
    print(path.name)
    print('events',dict(collections.Counter((e.get('phase'),e.get('name')) for e in data.get('events',[]))))
    print('samples (phase,dormant,parent)',dict(collections.Counter((e.get('phase'),e.get('dormant'),e.get('parent')) for e in data.get('samples',[]))))
    for phase in sorted({s['phase'] for s in data.get('samples',[])}):
        samples=[s for s in data['samples'] if s['phase']==phase and s.get('muzzle') and not s.get('dormant')]
        if samples:
            print(phase,'max muzzle distance',round(max(sum((a-b)**2 for a,b in zip(s['muzzle'],s['pos']))**.5 for s in samples),2))

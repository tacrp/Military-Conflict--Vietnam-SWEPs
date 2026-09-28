"""Audit every ported viewmodel's subtractive firing tracks for rest-then-jump tails."""
from pathlib import Path
import json
import re
from functools import lru_cache
import numpy as np
from bake_ik import load_smd, rmat
from port_qc import QC, FIRE_ACTS

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'work/firing_audit'

@lru_cache(None)
def smd(path):
    return load_smd(path)[:2]

def scan():
    report = {'models':0, 'tracks':0, 'tail_jumps':[], 'rig_mismatches':[], 'blend_lengths':[]}
    for path in sorted((ROOT/'work/MCV_SMD_PORT/weapons').glob('v_*/*.qc')):
        qc = QC(path.read_text())
        used = set()
        def visit(name):
            if name in used: return
            used.add(name)
            b = qc.find('sequence',name) or qc.find('animation',name)
            if b and b.kind == 'sequence':
                for a in b.anims()+b.layers(): visit(a)
        for b in qc.blocks('sequence'):
            if b.activity() in FIRE_ACTS:
                visit(b.name)
        if not used: continue
        report['models'] += 1
        for b in qc.blocks('animation'):
            if b.name not in used or not b.get('subtract'): continue
            # Movement layers are audited separately from firing recoil.
            if b.name.startswith(('walk','run')): continue
            source = (path.parent/b.path.replace('\\','/')).resolve()
            refname = re.search(r'"([^"]+)"',b.get('subtract')).group(1)
            ref = qc.find('animation',refname)
            if not ref or not source.exists(): continue
            refpath = (path.parent/ref.path.replace('\\','/')).resolve()
            if not refpath.exists(): continue
            nodes, frames = smd(source)
            cnodes, refs = smd(refpath)
            if len(frames) < 3: continue
            report['tracks'] += 1
            cbyname = {cnodes[i][0]: row for i,row in refs[0].items()}
            reference = {i:cbyname.get(n,np.zeros(6)) for i,(n,_) in nodes.items()}
            mismatch = [(n, nodes[parent][0] if parent>=0 else None)
                        for i,(n,parent) in nodes.items()
                        if n in {v[0] for v in cnodes.values()} and
                        (nodes[parent][0] if parent>=0 else None) != next(
                            (cnodes[p][0] if p>=0 else None) for _,(nm,p) in cnodes.items() if nm==n)]
            if mismatch: report['rig_mismatches'].append({'model':path.stem,'track':b.name,'bones':mismatch})
            errors=[]
            for frame in frames[-3:]:
                pos=rot=0.
                for i,row in frame.items():
                    base=reference[i]
                    pos=max(pos,float(np.linalg.norm(row[:3]-base[:3])))
                    rot=max(rot,float(np.degrees(np.arccos(np.clip((np.trace(rmat(row[3:]).T@rmat(base[3:]))-1)/2,-1,1)))))
                errors.append((pos,rot))
            if errors[-2][0]<.01 and errors[-2][1]<.1 and (errors[-1][0]>.05 or errors[-1][1]>1):
                report['tail_jumps'].append({'model':path.stem,'track':b.name,'frames':len(frames),
                    'path':str(source.relative_to(ROOT)), 'tail_errors':errors})
        for b in qc.blocks('sequence'):
            if b.name not in used or not b.has('delta'): continue
            lengths=[]
            for name in b.anims():
                a=qc.find('animation',name)
                if a and a.path:
                    p=(path.parent/a.path.replace('\\','/')).resolve()
                    if p.exists() and not a.get('frame') and not a.get('numframes'):
                        lengths.append((name,len(smd(p)[1])))
            if len({n for _,n in lengths})>1:
                report['blend_lengths'].append({'model':path.stem,'sequence':b.name,'lengths':lengths})
    return report

if __name__=='__main__':
    OUT.mkdir(exist_ok=True)
    report=scan()
    (OUT/'audit.json').write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps({k:len(v) if isinstance(v,list) else v for k,v in report.items()}))
    for item in report['tail_jumps']:
        print(item['model'],item['track'],item['tail_errors'][-1])

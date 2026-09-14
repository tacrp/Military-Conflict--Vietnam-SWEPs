"""Compare the M21 empty reload override against the source poses and animation."""
from pathlib import Path
import numpy as np
from bake_ik import load_smd, fk

root = Path(__file__).resolve().parent
og = root/'MCV_SMD_OG/weapons/v_m21/v_m21_anims'
overrides = root/'MCV_SMD/weapons/v_m21/anims'
for suffix, idle in [('', 'basePose_a'), ('_2', 'ironsight')]:
    nodes, frames, _ = load_smd(overrides/('reload_empty'+suffix+'.smd'))
    onodes, original, _ = load_smd(og/('reload_empty'+suffix+'.smd'))
    rnodes, rest, _ = load_smd(og/(idle+'.smd'))
    print('reload_empty'+suffix, 'frames', len(frames), 'original', len(original))
    for endpoint in [0, -1]:
        current = fk(nodes, frames[endpoint])
        source = fk(onodes, original[endpoint])
        target = fk(rnodes, rest[0])
        for name in ['root','cam_driver','Base','hand_r','hand_l','Bolt','Mag']:
            bone = next(i for i,n in nodes.items() if n[0].lower()==name.lower())
            obone = next(i for i,n in onodes.items() if n[0].lower()==name.lower())
            rbone = next(i for i,n in rnodes.items() if n[0].lower()==name.lower())
            rot = target[rbone][:3,:3].T @ current[bone][:3,:3]
            angle = np.degrees(np.arccos(np.clip((np.trace(rot)-1)/2,-1,1)))
            print(endpoint,name,'idle pos/angle',round(float(np.linalg.norm(current[bone][:3,3]-target[rbone][:3,3])),4),round(float(angle),4),
                  'original pos',round(float(np.linalg.norm(current[bone][:3,3]-source[obone][:3,3])),4))
    for name in ['cam_driver','Base','hand_r','hand_l','Bolt']:
        bone = next(i for i,n in nodes.items() if n[0].lower()==name.lower())
        xyz = np.array([fk(nodes,f)[bone][:3,3] for f in frames])
        speed = np.linalg.norm(np.diff(xyz,axis=0),axis=1)
        print(name,'largest step',int(np.argmax(speed)),round(float(max(speed)),4),'edge steps',np.round(speed[:4],3),np.round(speed[-4:],3))

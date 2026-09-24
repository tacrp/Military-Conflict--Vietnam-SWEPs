"""Offline C96 Carbine reload continuity report; does not change assets."""
from pathlib import Path
import numpy as np
from bake_ik import load_smd, fk

ROOT = Path(__file__).resolve().parent
folder = ROOT / 'MCV_SMD_OG/weapons/v_c96_stock/v_c96_stock_anims'

def angle(a, b):
    return float(np.degrees(np.arccos(np.clip((np.trace(a[:3,:3].T @ b[:3,:3])-1)/2, -1, 1))))

for suffix, rest in [('', 'idle_a'), ('_e', 'idle_a'), ('_i', 'ironsight'), ('_i_e', 'ironsight')]:
    rn, rf, _ = load_smd(folder / (rest + '.smd'))
    target = {rn[k][0]: v for k,v in fk(rn, rf[0]).items()}
    for count in [0, 10]:
        name = f'reload{count:02}{suffix}'
        nodes, frames, _ = load_smd(folder / (name + '.smd'))
        worlds = [{nodes[k][0]: v for k,v in fk(nodes, f).items()} for f in frames]
        print(name, 'frames', len(frames), 'hierarchy matches idle', nodes == rn)
        for bone in ['BaseRoot', 'Base', 'hand_r', 'hand_l', 'Bolt', 'cam_driver']:
            xyz = np.array([w[bone][:3,3] for w in worlds])
            steps = np.linalg.norm(np.diff(xyz, axis=0), axis=1)
            late = max(0, len(steps)-30)
            i = late + int(np.argmax(steps[late:]))
            print(' ', bone, 'late max step', i, round(float(steps[i]),3),
                  'end -> idle pos/deg', round(float(np.linalg.norm(xyz[-1]-target[bone][:3,3])),3),
                  round(angle(worlds[-1][bone],target[bone]),3))
        if count == 0:
            zero = worlds
        else:
            for bone in ['Base','hand_r','hand_l','Bolt']:
                diff = [np.linalg.norm(a[bone][:3,3]-b[bone][:3,3]) for a,b in zip(zero,worlds)]
                print('  00/10 blend difference',bone,'max',round(float(max(diff)),3),'end',round(float(diff[-1]),3))

nodes, frames, _ = load_smd(folder / 'reload10_e.smd')
worlds = [fk(nodes, f) for f in frames]
print('\nEmpty reload late rotation steps (degrees), largest per bone:')
for k, (bone, parent) in nodes.items():
    angles = [angle(worlds[i][k], worlds[i+1][k]) for i in range(65,len(frames)-1)]
    peak = max(angles)
    if peak > 15:
        print(bone, 'frame', 65 + int(np.argmax(angles)), 'angle', round(peak,3))
print('\nEmpty reload closing frames: local gun/hand motion')
for i in range(68,94):
    values = []
    for bone in ['Base', 'Bolt', 'hand_r', 'hand_l']:
        k = next(k for k,v in nodes.items() if v[0] == bone)
        values.append(f'{bone} step={np.linalg.norm(worlds[i][k][:3,3]-worlds[i-1][k][:3,3]):.3f} rot={angle(worlds[i-1][k],worlds[i][k]):.2f}')
    print(i, '; '.join(values))

print('\nHand versus authored IK target in empty reload:')
for hand, target in [('hand_r', 'Rhand_IKtarget'), ('hand_l', 'LHand_IKtarget')]:
    h = next(k for k,v in nodes.items() if v[0] == hand)
    t = next(k for k,v in nodes.items() if v[0] == target)
    for i in [0, 68, 73, 79, 80, 83, 86, 89, 92, 93]:
        print(hand, i, 'distance', round(float(np.linalg.norm(worlds[i][h][:3,3]-worlds[i][t][:3,3])),3),
              'angle', round(angle(worlds[i][h],worlds[i][t]),3))

print('\nAll reload variants: late hand/target positional drift')
for suffix in ['', '_i', '_e', '_i_e']:
    peaks = [[], []]
    for count in range(11):
        nn, ff, _ = load_smd(folder / f'reload{count:02}{suffix}.smd')
        ww = [fk(nn, f) for f in ff]
        for j, (hand, target) in enumerate([('hand_r','Rhand_IKtarget'),('hand_l','LHand_IKtarget')]):
            h = next(k for k,v in nn.items() if v[0] == hand)
            t = next(k for k,v in nn.items() if v[0] == target)
            ds = [np.linalg.norm(w[h][:3,3]-w[t][:3,3]) for w in ww[-14:]]
            peaks[j].append(float(max(ds)))
    print(suffix or 'normal hip', 'right range', np.round([min(peaks[0]),max(peaks[0])],3),
          'left range', np.round([min(peaks[1]),max(peaks[1])],3))

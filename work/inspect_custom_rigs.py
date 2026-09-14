"""Read-only bind/geometry inspection for the custom weapon builds."""
from pathlib import Path
from collections import Counter
import numpy as np
from bake_ik import load_smd, fk

root = Path(__file__).resolve().parent
paths = {
    'custom': root/'MCV_SMD/weapons/v_ptrd41_s/Ref_new.smd',
    'ptrd': root/'MCV_SMD_OG/weapons/v_ptrd41/Ref_new.smd',
    'vz54s': root/'MCV_SMD_OG/weapons/v_vz54s/Ref_new.smd',
}
rigs = {}
for name, path in paths.items():
    if not path.exists():
        print(name, 'missing', path)
        continue
    n, f, _ = load_smd(path)
    transforms = fk(n, f[0])
    rigs[name] = {bone:transforms[i] for i,(bone,_) in n.items()}
    mesh = path.read_text().split('triangles\n',1)[1].splitlines()
    materials = Counter(mesh[i] for i in range(0,len(mesh)-1,4))
    print(name, 'bones',len(n),'materials',materials)
    base = np.linalg.inv(rigs[name]['Base'])
    for material in materials:
        points = np.array([list(map(float, mesh[i+j].split()[1:4]))+[1]
                           for i in range(0,len(mesh)-1,4) if mesh[i]==material for j in (1,2,3)]) @ base.T
        print(' ',material,'Base bounds',np.round(points[:,:3].min(axis=0),3),np.round(points[:,:3].max(axis=0),3))
for name in ['ptrd','vz54s']:
    if name not in rigs: continue
    diff = [(bone, float(np.max(np.abs(matrix - rigs[name][bone])))) for bone,matrix in rigs['custom'].items() if bone in rigs[name]]
    print('custom vs',name,'bind differences',sorted(diff,key=lambda p:-p[1])[:12])

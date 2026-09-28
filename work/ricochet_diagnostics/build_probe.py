from pathlib import Path
import sys, copy, uuid
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from dmxlib import DMX
root = Path(__file__).resolve().parents[2]
donor = DMX((root / 'particles/mcv_ricochet.pcf').read_bytes())
out = copy.deepcopy(donor)
out.elements = [copy.deepcopy(donor.elements[0])]
out.elements[0].set('particleSystemDefinitions', [])
out.strings = []
for variant in range(5):
    offset = len(out.elements)-1
    elements = copy.deepcopy(donor.elements[1:])
    for e in elements:
        e.guid = uuid.uuid5(uuid.NAMESPACE_URL, f'ric-probe/{variant}/'+e.guid.hex()).bytes
        if e.type == 'DmeParticleSystemDefinition':
            e.name = e.name.replace('mcv_ricochet', f'mcv_ric_probe{variant}')
        for a in e.attrs:
            if a[1] == 1 and isinstance(a[2], int) and a[2] >= 0: a[2] += offset
            elif a[1] == 15: a[2] = [v+offset for v in a[2]]
    out.elements.extend(elements)
    parent = out.elements[1+offset]
    out.elements[0].get('particleSystemDefinitions').append(1+offset)
    parent.set('children', [])
    if variant == 1:
        parent.set('initializers', [i for i in parent.get('initializers') if out.elements[i].get('functionName') != 'Remap Control Point to Scalar'])
    if variant == 2: parent.set('material', 'effects/spark')
    if variant in (3,4):
        out.elements[parent.get('renderers')[0]].set('functionName', 'render_animated_sprites')
    if variant == 4: parent.set('material', 'sprites/light_glow02_add')
(root / 'particles/mcv_ric_probe.pcf').write_bytes(out.serialize())
print('built five renderer/material probes')

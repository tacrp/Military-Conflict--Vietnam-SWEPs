"""Create isolated impact systems whose particle radius reads scale from CP2.x.

Uses the Remap Control Point to Scalar initializer already shipped in MCV rain.
Original effects and emission counts remain unchanged. Run after refreshing PCFs.
"""
from pathlib import Path
import copy
import struct
import uuid
from dmxlib import DMX, AT_INT, AT_FLOAT, AT_BOOL

ROOT = Path(__file__).resolve().parents[1]
rain = DMX((ROOT/'particles/vietnam_precipitation_effects.pcf').read_bytes())
template = next(e for e in rain.elements if e.get('functionName') == 'Remap Control Point to Scalar'
                and e.get('output is scalar of initial random range') == b'\x01')

for suffix in ('', '_cheap'):
    source = ROOT/'particles'/('vietnam_impact_effects'+suffix+'.pcf')
    dmx = DMX(source.read_bytes())
    systems = dmx.by_type('DmeParticleSystemDefinition')
    names = {e.name: 'mcv_scaled_'+e.name for _, e in systems}
    for e in dmx.elements:
        e.guid = uuid.uuid5(uuid.NAMESPACE_URL, 'mcv-scaled-impact/'+e.guid.hex()).bytes
        if e.name in names:
            e.name = names[e.name]
        for attr in e.attrs:
            if attr[0] == 'fallback replacement definition' and attr[2]:
                attr[2] = 'mcv_scaled_'+attr[2]
    for _, system in systems:
        # CP2 is unused in the donor impacts. Children inherit it from the parent.
        op = copy.deepcopy(template)
        op.guid = uuid.uuid5(uuid.NAMESPACE_URL, system.name+'/radius-scale').bytes
        settings = {
            'input control point number': (AT_INT, 2),
            'output field': (AT_INT, 3),  # Source particle radius
            'input minimum': (AT_FLOAT, .5), 'input maximum': (AT_FLOAT, 2),
            'output minimum': (AT_FLOAT, .5), 'output maximum': (AT_FLOAT, 2),
            'output is scalar of initial random range': (AT_BOOL, True),
        }
        for key, (kind, value) in settings.items():
            packed = struct.pack({AT_INT:'<i', AT_FLOAT:'<f', AT_BOOL:'<?'}[kind], value)
            if op.get(key) is None:
                op.attrs.append([key, kind, packed])
            else:
                op.set(key, packed)
        system.get('initializers').append(len(dmx.elements))
        dmx.elements.append(op)
    target = ROOT/'particles'/('mcv_scaled_impacts'+suffix+'.pcf')
    target.write_bytes(dmx.serialize())
    check = DMX(target.read_bytes())
    assert len(check.by_type('DmeParticleSystemDefinition')) == len(systems)
    print(target.name, len(systems), 'systems with CP2 radius scaling')

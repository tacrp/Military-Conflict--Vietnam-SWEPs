"""Adapt the original tracer rope smoke to follow CP0 without a parent particle."""
from pathlib import Path
import struct
import uuid
from dmxlib import DMX, Element, AT_FLOAT, AT_INT, AT_BOOL, AT_STRING

root = Path(__file__).resolve().parents[1]
SMOKE_RADIUS_SCALE = 1.0
d = DMX((root / 'particles/vietnam_tracer_effects.pcf').read_bytes())
def setvalue(e, name, kind, value):
    value = struct.pack({AT_FLOAT:'<f', AT_INT:'<i', AT_BOOL:'<?'}[kind], value)
    if e.get(name) is None:
        e.attrs.append([name, kind, value])
    else:
        e.set(name, value)

smokes = []
for index, e in d.by_type('DmeParticleSystemDefinition'):
    old = e.name
    e.name = 'mcv_phys_' + old
    if not old.endswith('_smoke'):
        continue
    smokes.append(index)
    # Preserve original width now that the original opacity ramp is restored.
    for i in e.get('initializers'):
        initializer = d.elements[i]
        if initializer.get('functionName') == 'Radius Random':
            for key in ('radius_min', 'radius_max'):
                value = initializer.get(key)
                if value is not None:
                    setvalue(initializer, key, AT_FLOAT,
                             struct.unpack('<f', value)[0] * SMOKE_RADIUS_SCALE)
    # The old initializer samples particles in the one-shot tracer parent.
    position = Element('DmeParticleOperator', 'Position Within Sphere Random',
        uuid.uuid5(uuid.NAMESPACE_URL, e.name + '/position').bytes)
    position.attrs = [['functionName', AT_STRING, 'Position Within Sphere Random']]
    setvalue(position, 'distance_min', AT_FLOAT, 0)
    setvalue(position, 'distance_max', AT_FLOAT, 0)
    setvalue(position, 'control_point_number', AT_INT, 0)
    # Replace in place: preserve the original offset initializer and ordering.
    e.set('initializers', [len(d.elements) if d.elements[i].get('functionName') ==
        'Position From Parent Particles' else i for i in e.get('initializers')])
    d.elements.append(position)
    for i in e.get('emitters'):
        emitter = d.elements[i]
        # Prime moving control-point history before the first particle is born.
        # Keep the emitter scheduled/alive instead of stopping an empty system.
        setvalue(emitter, 'emission_start_time', AT_FLOAT, 0.02)
        if emitter.get('functionName') == 'emit_continuously':
            setvalue(emitter, 'emission_duration', AT_FLOAT, 0)
    setvalue(e, 'max_particles', AT_INT, 512)
    setvalue(e, 'draw in low res', AT_BOOL, False)

# Export only independent smoke systems, preserving original rope materials,
# lifetime, colour, radius, emission rate and motion operators.
d.elements[0].set('particleSystemDefinitions', smokes)
for e in d.elements:
    e.guid = uuid.uuid5(uuid.NAMESPACE_URL, 'mcv-physical-smoke/' + e.guid.hex()).bytes
output = root / 'particles/mcv_physical_smoke.pcf'
output.write_bytes(d.serialize())
check = DMX(output.read_bytes())
original = DMX((root / 'particles/vietnam_tracer_effects.pcf').read_bytes())
original_systems = {e.name: e for _, e in original.by_type('DmeParticleSystemDefinition')}
for i in check.elements[0].get('particleSystemDefinitions'):
    e = check.elements[i]
    assert all(check.elements[j].get('functionName') != 'Position From Parent Particles'
               for j in e.get('initializers'))
    assert (root / 'materials' / e.get('material').replace('\\', '/')).exists()
    donor = original_systems[e.name.removeprefix('mcv_phys_')]
    # Alpha remapping is part of the original appearance, not parent positioning.
    # Compare the complete settings, including omitted/default fields, byte-for-byte.
    for function in ('Color Random', 'Alpha Random', 'Remap Initial Scalar',
                     'Radius Random', 'Position Modify Offset Random'):
        actual = [check.elements[j].attrs for j in e.get('initializers')
                  if check.elements[j].get('functionName') == function]
        expected = [original.elements[j].attrs for j in donor.get('initializers')
                    if original.elements[j].get('functionName') == function]
        assert actual == expected and actual, (e.name, function)
print(f'Built and checked {len(smokes)} standalone original smoke families: {output.name}')

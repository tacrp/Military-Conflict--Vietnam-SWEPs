"""Isolate the scaled MCV flying spark, emitting once after Lua accepts a ricochet.

Run after build_scaled_impacts.py when refreshing the donor particles. Original
impact graphs/materials remain untouched. No game or particle editor is launched.
"""
import copy
from pathlib import Path
import struct
import uuid

from dmxlib import DMX, AT_ELEMENT, AT_ARRAY_BASE
from vtf_invert_alpha import _image_data_offset

ROOT = Path(__file__).resolve().parents[1]
OUTPUT = ROOT / 'particles/mcv_ricochet.pcf'
NAMES = {
    'mcv_scaled_impact_metal_flying': 'mcv_ricochet',
    'mcv_scaled_impact_metal_flying_trail': 'mcv_ricochet_trail',
}

def neutral_texture():
    """Neutralize DXT1 colour endpoints; retain sheet, mips, indices and alpha mode."""
    data = bytearray((ROOT / 'materials/effects/vietnam/vietnam_sparktrails_1.vtf').read_bytes())
    assert struct.unpack_from('<I', data, 52) == (13,)
    start = _image_data_offset(data)
    assert (len(data) - start) % 8 == 0
    def grey(c):
        level = max((c >> 11) / 31, ((c >> 5) & 63) / 63, (c & 31) / 31)
        v = round(level * 31)
        return (v << 11) | (round(level * 63) << 5) | v
    for at in range(start, len(data), 8):
        c0, c1 = struct.unpack_from('<HH', data, at)
        a, b = grey(c0), grey(c1)
        # DXT1 endpoint order selects transparency vs four-colour interpolation.
        if c0 > c1 and a <= b:
            if b < 65535: a = b + 1
            else: a, b = 65535, 65534
        elif c0 <= c1 and a > b:
            a = b
        struct.pack_into('<HH', data, at, a, b)
    return bytes(data)


def references(element):
    for _, kind, value in element.attrs:
        if kind == AT_ELEMENT and isinstance(value, int) and value >= 0:
            yield value
        elif kind == AT_ELEMENT + AT_ARRAY_BASE:
            yield from (i for i in value if isinstance(i, int) and i >= 0)


def build():
    donor = DMX((ROOT / 'particles/mcv_scaled_impacts.pcf').read_bytes())
    pending = [i for i, e in donor.by_type('DmeParticleSystemDefinition') if e.name in NAMES]
    reachable = set()
    while pending:
        index = pending.pop()
        if index in reachable:
            continue
        reachable.add(index)
        pending.extend(references(donor.elements[index]))

    output = copy.deepcopy(donor)
    output.strings = []
    output.elements = [copy.deepcopy(donor.elements[0])]
    root = output.elements[0]
    root.name = 'mcv_ricochet'
    root.guid = uuid.uuid5(uuid.NAMESPACE_URL, 'mcv-ricochet/root').bytes
    root.set('particleSystemDefinitions', [])
    remap = {old: i + 1 for i, old in enumerate(sorted(reachable))}
    for old in sorted(reachable):
        element = copy.deepcopy(donor.elements[old])
        element.guid = uuid.uuid5(uuid.NAMESPACE_URL, 'mcv-ricochet/' + element.guid.hex()).bytes
        if element.type == 'DmeParticleSystemDefinition':
            element.name = NAMES[element.name]
            root.get('particleSystemDefinitions').append(remap[old])
        for attr in element.attrs:
            _, kind, value = attr
            if kind == AT_ELEMENT and isinstance(value, int) and value >= 0:
                attr[2] = remap[value]
            elif kind == AT_ELEMENT + AT_ARRAY_BASE:
                attr[2] = [remap[i] if isinstance(i, int) and i >= 0 else i for i in value]
        output.elements.append(element)

    parent = next(e for e in output.elements if e.name == 'mcv_ricochet'
                  and e.type == 'DmeParticleSystemDefinition')
    emitter, = (output.elements[i] for i in parent.get('emitters'))
    assert emitter.get('functionName') == 'emit_instantaneously'
    assert struct.unpack('<i', emitter.get('num_to_emit')) == (1,)
    # The donor rolls 0..1 independently of Lua's hardness/angle decision.
    # Its trail needs a live parent particle, so zero suppresses both visuals.
    emitter.set('num_to_emit_minimum', struct.pack('<i', 1))
    position = next(output.elements[i] for i in parent.get('initializers')
                    if output.elements[i].get('functionName') == 'Position Within Sphere Random')
    # CP0 gets its position/orientation from the effect entity inside Create().
    # Avoid a manually populated CP1 for the single spark's initial launch.
    position.set('control_point_number', struct.pack('<i', 0))
    # Lua supplies reflected forward and surface-relative up. Keep the original
    # forward/sideways speeds, but never launch back into the face we just hit.
    x, y, _ = struct.unpack('<3f', position.get('speed_in_local_coordinate_system_min'))
    position.set('speed_in_local_coordinate_system_min', struct.pack('<3f', x, y, 25))
    # Reuse the game's smoke colour operator: CP3 carries normalized RGB (0..1).
    # Add it to both systems so the flying head and its bouncing trail agree.
    smoke = DMX((ROOT / 'particles/vietnam_smokegrenade_effects.pcf').read_bytes())
    template = next(e for e in smoke.elements
                    if e.get('functionName') == 'Remap Control Point to Vector')
    for system in list(output.elements):
        if system.type != 'DmeParticleSystemDefinition':
            continue
        system.set('material', 'effects/mcv/ricochet.vmt')
        tint = copy.deepcopy(template)
        tint.guid = uuid.uuid5(uuid.NAMESPACE_URL, 'mcv-ricochet/tint/' + system.name).bytes
        tint.set('input control point number', struct.pack('<i', 3))
        system.get('operators').append(len(output.elements))
        output.elements.append(tint)
    return output.serialize()


if __name__ == '__main__':
    texture = ROOT / 'materials/effects/mcv/ricochet.vtf'
    texture.parent.mkdir(parents=True, exist_ok=True)
    texture.write_bytes(neutral_texture())
    OUTPUT.write_bytes(build())
    print(f'Built {OUTPUT.name}: guaranteed flying spark + original trail, {OUTPUT.stat().st_size:,} bytes')

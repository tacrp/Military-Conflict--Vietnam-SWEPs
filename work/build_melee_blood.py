"""Isolate MCV's three blood impacts and their children without changing their art."""
import copy
import uuid
from pathlib import Path
from dmxlib import DMX, AT_ELEMENT, AT_ARRAY_BASE

ROOT = Path(__file__).resolve().parents[1]
DONORS = (
    ('vietnam_blood_effects.pcf', 'blood_impact_red_01'),
    ('vietnam_blood_effects_green.pcf', 'greenblood_impact_red_01'),
    ('vietnam_blood_effects_orange.pcf', 'orangeblood_impact_red_01'),
)
PREFIX = 'mcv_melee_'
OUTPUT = ROOT/'particles/mcv_melee_blood.pcf'


def references(element):
    for _, kind, value in element.attrs:
        if kind == AT_ELEMENT and isinstance(value, int) and value >= 0:
            yield value
        elif kind == AT_ELEMENT + AT_ARRAY_BASE:
            yield from (i for i in value if isinstance(i, int) and i >= 0)


def build():
    output = DMX((ROOT/'particles'/DONORS[0][0]).read_bytes())
    output.elements = [copy.deepcopy(output.elements[0])]
    output.elements[0].set('particleSystemDefinitions', [])
    output.elements[0].guid = uuid.uuid5(uuid.NAMESPACE_URL, 'mcv-melee-blood/root').bytes
    output.elements[0].name = 'mcv_melee_blood'
    for filename, root_name in DONORS:
        donor = DMX((ROOT/'particles'/filename).read_bytes())
        named = {e.name: i for i,e in donor.by_type('DmeParticleSystemDefinition')}
        pending = [named[root_name]]
        reachable = set()
        while pending:
            i = pending.pop()
            if i in reachable:
                continue
            reachable.add(i)
            element = donor.elements[i]
            pending.extend(references(element))
            fallback = element.get('fallback replacement definition')
            if fallback:
                pending.append(named[fallback])
        remap = {old: len(output.elements)+n for n,old in enumerate(sorted(reachable))}
        for old in sorted(reachable):
            element = copy.deepcopy(donor.elements[old])
            element.guid = uuid.uuid5(uuid.NAMESPACE_URL, 'mcv-melee-blood/'+element.guid.hex()).bytes
            if element.type == 'DmeParticleSystemDefinition':
                element.name = PREFIX+element.name
                output.elements[0].get('particleSystemDefinitions').append(remap[old])
            for attr in element.attrs:
                key, kind, value = attr
                if kind == AT_ELEMENT and isinstance(value, int) and value >= 0:
                    attr[2] = remap[value]
                elif kind == AT_ELEMENT + AT_ARRAY_BASE:
                    attr[2] = [remap[i] if isinstance(i, int) and i >= 0 else i for i in value]
                elif key == 'fallback replacement definition' and value:
                    attr[2] = PREFIX+value
            output.elements.append(element)
    OUTPUT.write_bytes(output.serialize())
    check = DMX(OUTPUT.read_bytes())
    names = {e.name for _,e in check.by_type('DmeParticleSystemDefinition')}
    assert all(PREFIX+name in names for _,name in DONORS)
    assert all(0 <= ref < len(check.elements) for e in check.elements for ref in references(e))
    print(f'Built {len(names)} original blood systems/children, {OUTPUT.stat().st_size:,} bytes')


if __name__ == '__main__':
    build()

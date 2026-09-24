"""Report missing velocity stats without inventing replacements or changing weapons."""
import re
import argparse
from pathlib import Path
from functools import lru_cache
from audit_weapon_trivia import catalog, resolver

files = catalog()
fields = resolver(files)
own = {name: re.search(r'^SWEP.MuzzleVelocity\s*=\s*([0-9.]+)', p.read_text(encoding='utf-8'), re.M)
       for name, p in files.items()}

@lru_cache(None)
def velocity(name):
    if name not in files:
        return 0
    found = own[name]
    return float(found[1]) if found else velocity(fields(name).get('Base'))

categories = {'Pistols', 'Revolvers', 'Machine Pistols', 'Submachine Guns', 'Assault Rifles',
              'Carbines', 'Battle Rifles', 'Bolt-Action Rifles', 'Sniper Rifles', 'Shotguns', 'Light-Machine Guns'}
guns = [name for name in files if fields(name).get('Spawnable') and fields(name).get('SubCategory') in categories
        and not fields(name).get('ShootEntity')]
missing = [name for name in guns if velocity(name) <= 0]
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--apply', action='store_true', help='Fill missing stats from matching game scripts only')
args = parser.parse_args()
if args.apply:
    for name in sorted(missing):
        source = Path(__file__).parent / 'cscripts' / ('weapon_' + name.removeprefix('mcv_') + '.txt')
        provenance = re.search(r'from cscripts/(weapon_[\w]+\.txt)', files[name].read_text(encoding='utf-8'))
        if provenance:
            source = Path(__file__).parent / 'cscripts' / provenance[1]
        if not source.exists():
            continue
        script = re.sub(r'//[^\n]*', '', source.read_text(encoding='utf-8'))
        match = re.search(r'"muzzle_velocity"\s*"([0-9.]+)"', script)
        if not match or float(match[1]) <= 0:
            continue
        path = files[name]
        data = path.read_bytes()
        nl = b'\r\n' if b'\r\n' in data else b'\n'
        temp = path.with_suffix('.lua.tmp')
        temp.write_bytes(data + nl + ('SWEP.MuzzleVelocity = ' + match[1] + ' // m/s, original game stat').encode() + nl)
        temp.replace(path)
        own[name] = re.search(r'([0-9.]+)', match[1])
        velocity.cache_clear()
        print(name + ': ' + match[1] + ' m/s')
    missing = [name for name in guns if velocity(name) <= 0]
print(f'{len(guns)} firearm definitions; {len(guns)-len(missing)} have inherited or explicit MuzzleVelocity.')
print('Retain hitscan (no velocity stat): ' + ', '.join(sorted(missing)))

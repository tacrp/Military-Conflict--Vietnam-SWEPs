"""Inspect registered shot WAVs across both packs without starting the game."""
import argparse
import struct

import numpy as np
from lupa import LuaRuntime
from glua_check import to_lua
from pack_paths import ROOT, asset_path


def scripts():
    lua = LuaRuntime()
    lua.execute('CHAN_STATIC=6; bank={}; sound={Add=function(t) bank[t.name]=t end}')
    lua.execute(to_lua((ROOT/'lua/mcv/shared/sh_soundscript_weapons.lua').read_text(encoding='utf-8')))
    result = {}
    for name, props in lua.globals().bank.items():
        if '.Single' not in name:
            continue
        samples = props.sound
        result[name] = [samples] if isinstance(samples, str) else list(samples.values())
    return result


def inspect(path):
    data = path.read_bytes()
    assert data[:4] == b'RIFF' and data[8:12] == b'WAVE', path
    at = 12
    chunks = {}
    while at + 8 <= len(data):
        name, size = struct.unpack_from('<4sI', data, at)
        chunks[name] = data[at+8:at+8+size]
        at += 8 + size + size % 2
    fmt, channels, rate, _, align, bits = struct.unpack_from('<HHIIHH', chunks[b'fmt '])
    result = {'format': fmt, 'channels': channels, 'rate': rate, 'bits': bits}
    if fmt == 1 and bits == 16:
        samples = np.frombuffer(chunks[b'data'], dtype='<i2').reshape(-1, channels).astype(float) / 32768
        peak = np.max(np.abs(samples), axis=1)
        loud = np.flatnonzero(peak > 0.1)
        attack = np.flatnonzero(peak > 0.5)
        result.update(seconds=round(len(samples)/rate, 3),
                      onset_ms=round(loud[0]*1000/rate, 2) if len(loud) else None,
                      attack_ms=round(attack[0]*1000/rate, 2) if len(attack) else None,
                      peak_ms=round(int(np.argmax(peak))*1000/rate, 2),
                      early_rms=round(float(np.sqrt(np.mean(samples[:int(rate*.06)]**2))), 4),
                      peak=round(float(np.max(peak)), 4))
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--all', action='store_true', help='Print all files, not only reported weapons and anomalies')
    parser.add_argument('--anomalies', action='store_true', help='Also print unsupported formats and delayed attacks')
    args = parser.parse_args()
    checked = {}
    missing = []
    for name, samples in sorted(scripts().items()):
        for sample in samples:
            path = asset_path('sound/' + sample.lstrip(')*^#@<>!'))
            if not path.exists():
                missing.append(sample)
                continue
            if path in checked:
                continue
            meta = inspect(path)
            checked[path] = meta
            suspect = meta['format'] != 1 or meta['bits'] != 16 or meta['rate'] not in (11025, 22050, 44100)
            suspect |= (meta.get('attack_ms') or 0) > 80
            if args.all or (args.anomalies and suspect) or any(f'_{weapon}.' in name for weapon in ('M60', 'MG43', 'PK', 'VZ59', 'RPK', 'AK47')):
                print(path.name, meta)
    for sample in missing:
        print('MISSING', sample)
    print(f'{len(checked)} unique shot files inspected, {len(missing)} missing references')


if __name__ == '__main__':
    main()

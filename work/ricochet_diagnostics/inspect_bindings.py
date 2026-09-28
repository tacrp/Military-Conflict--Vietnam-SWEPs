"""Read-only disassembly of installed client particle bindings; never loads the DLL."""
from pathlib import Path
import sys
import struct
sys.path.insert(0, str(Path(__file__).parent / 'deps'))
import capstone
import pefile

path = Path(__file__).resolve().parents[4] / 'bin/win64/client.dll'
pe = pefile.PE(str(path))
data = path.read_bytes()
base = pe.OPTIONAL_HEADER.ImageBase
dis = capstone.Cs(capstone.CS_ARCH_X86, capstone.CS_MODE_64)


def dump(va, length):
    offset = pe.get_offset_from_rva(va - base)
    for ins in dis.disasm(data[offset:offset + length], va):
        print(f'{ins.address:x}  {ins.mnemonic:8} {ins.op_str}')


if len(sys.argv) > 2 and sys.argv[1] == '--class':
    name = ('.?AV' + sys.argv[2] + '@@').encode()
    td = pe.get_rva_from_offset(data.index(name) - 16)
    print('type descriptor', hex(base + td))
    needle = struct.pack('<I', td)
    off = data.find(needle)
    while off >= 0:
        if off >= 12 and struct.unpack_from('<I', data, off - 12)[0] == 1:
            col = base + pe.get_rva_from_offset(off - 12)
            vptr = data.find(struct.pack('<Q', col))
            if vptr >= 0:
                print('vtable', hex(base + pe.get_rva_from_offset(vptr + 8)))
                for i, address in enumerate(struct.unpack_from('<24Q', data, vptr + 8)):
                    print(i, hex(address))
        off = data.find(needle, off + 1)
elif len(sys.argv) > 1:
    dump(int(sys.argv[1], 16), int(sys.argv[2], 0) if len(sys.argv) > 2 else 400)
else:
    for name in ('SetControlPointOrientation', 'SetControlPoint', 'SetControlPointForwardVector'):
        rva = pe.get_rva_from_offset(data.index(name.encode() + bytes([0])))
        print(name, hex(base + rva))
        needle = struct.pack('<Q', base + rva)
        off = data.find(needle)
        while off >= 0:
            print('pointer table', hex(base + pe.get_rva_from_offset(off)),
                  [hex(v) for v in struct.unpack_from('<8Q', data, off - 24)])
            off = data.find(needle, off + 1)
        for section in pe.sections:
            if not section.Characteristics & 0x20000000:
                continue
            code = section.get_data()
            for i in range(len(code) - 7):
                if code[i:i + 2] not in (bytes([0x48, 0x8d]), bytes([0x4c, 0x8d])):
                    continue
                if code[i + 2] & 0xc7 != 5:
                    continue
                if section.VirtualAddress + i + 7 + struct.unpack_from('<i', code, i + 3)[0] == rva:
                    dump(base + section.VirtualAddress + i - 24, 76)

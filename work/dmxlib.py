"""Minimal DMX binary v5 reader/writer, enough to edit Source particle files (pcf 2).

Round-trips the game's pcfs byte for byte. Attribute values are kept as raw tuples so anything
this code does not understand is preserved untouched.
"""
import struct

HEADER_PREFIX = b"<!-- dmx encoding binary "

# DmAttributeType_t
AT_ELEMENT, AT_INT, AT_FLOAT, AT_BOOL, AT_STRING, AT_VOID, AT_TIME, AT_COLOR = range(1, 9)
AT_VEC2, AT_VEC3, AT_VEC4, AT_QANGLE, AT_QUAT, AT_VMATRIX = range(9, 15)
AT_ARRAY_BASE = 14
FIXED = {AT_INT: 4, AT_FLOAT: 4, AT_BOOL: 1, AT_TIME: 4, AT_COLOR: 4, AT_VEC2: 8, AT_VEC3: 12, AT_VEC4: 16,
         AT_QANGLE: 12, AT_QUAT: 16, AT_VMATRIX: 64}


class Element:
    __slots__ = ("type", "name", "guid", "attrs")

    def __init__(self, type_, name, guid):
        self.type = type_
        self.name = name
        self.guid = guid
        self.attrs = []            # list of [name, type, value]

    def get(self, name):
        for a in self.attrs:
            if a[0] == name:
                return a[2]
        return None

    def set(self, name, value):
        for a in self.attrs:
            if a[0] == name:
                a[2] = value
                return
        raise KeyError(name)


class DMX:
    def __init__(self, data):
        self.strings = []
        self.elements = []
        self._parse(data)

    # ---- reading -------------------------------------------------------------------------
    def _parse(self, data):
        nl = data.index(b"\n\0")
        self.header = data[:nl + 2]
        m = self.header.split()
        self.version = int(m[4])
        if self.version != 5:
            raise ValueError("only dmx binary 5 is supported (got %d)" % self.version)
        pos = nl + 2
        nstr, = struct.unpack_from("<I", data, pos); pos += 4
        for _ in range(nstr):
            end = data.index(b"\0", pos)
            self.strings.append(data[pos:end].decode("latin-1"))
            pos = end + 1
        nelem, = struct.unpack_from("<I", data, pos); pos += 4
        for _ in range(nelem):
            t, n = struct.unpack_from("<ii", data, pos); pos += 8
            guid = data[pos:pos + 16]; pos += 16
            self.elements.append(Element(self.strings[t], self.strings[n], guid))
        for e in self.elements:
            nattr, = struct.unpack_from("<I", data, pos); pos += 4
            for _ in range(nattr):
                ni, = struct.unpack_from("<i", data, pos); pos += 4
                at = data[pos]; pos += 1
                val, pos = self._read_value(data, pos, at)
                e.attrs.append([self.strings[ni], at, val])
        self.trailer = data[pos:]

    def _read_value(self, data, pos, at):
        if at > AT_ARRAY_BASE:
            base = at - AT_ARRAY_BASE
            n, = struct.unpack_from("<I", data, pos); pos += 4
            items = []
            for _ in range(n):
                if base == AT_STRING:          # string arrays are inline, even in v5
                    end = data.index(b"\0", pos)
                    items.append(data[pos:end].decode("latin-1")); pos = end + 1
                else:
                    v, pos = self._read_value(data, pos, base)
                    items.append(v)
            return items, pos
        if at == AT_ELEMENT:
            v, = struct.unpack_from("<i", data, pos); pos += 4
            if v == -2:                        # external element: GUID as string
                end = data.index(b"\0", pos)
                v = ("guid", data[pos:end]); pos = end + 1
            return v, pos
        if at == AT_STRING:
            v, = struct.unpack_from("<i", data, pos); pos += 4
            return self.strings[v], pos
        if at == AT_VOID:
            n, = struct.unpack_from("<I", data, pos); pos += 4
            return data[pos:pos + n], pos + n
        size = FIXED[at]
        return data[pos:pos + size], pos + size

    # ---- writing -------------------------------------------------------------------------
    def serialize(self):
        strings = list(self.strings)
        index = {s: i for i, s in enumerate(strings)}

        def sidx(s):
            if s not in index:
                index[s] = len(strings); strings.append(s)
            return index[s]

        body = bytearray()
        # element headers first (they reference the string table, which may grow)
        heads = []
        for e in self.elements:
            heads.append(struct.pack("<ii", sidx(e.type), sidx(e.name)) + e.guid)
        attrs = bytearray()
        for e in self.elements:
            attrs += struct.pack("<I", len(e.attrs))
            for name, at, val in e.attrs:
                attrs += struct.pack("<i", sidx(name)) + bytes([at])
                attrs += self._write_value(at, val, sidx)
        out = bytearray(self.header)
        out += struct.pack("<I", len(strings))
        for s in strings:
            out += s.encode("latin-1") + b"\0"
        out += struct.pack("<I", len(self.elements))
        for h in heads:
            out += h
        out += attrs
        out += self.trailer
        return bytes(out)

    def _write_value(self, at, val, sidx):
        if at > AT_ARRAY_BASE:
            base = at - AT_ARRAY_BASE
            out = struct.pack("<I", len(val))
            for v in val:
                if base == AT_STRING:
                    out += v.encode("latin-1") + b"\0"
                else:
                    out += self._write_value(base, v, sidx)
            return out
        if at == AT_ELEMENT:
            if isinstance(val, tuple):
                return struct.pack("<i", -2) + val[1] + b"\0"
            return struct.pack("<i", val)
        if at == AT_STRING:
            return struct.pack("<i", sidx(val))
        if at == AT_VOID:
            return struct.pack("<I", len(val)) + val
        return bytes(val)

    # ---- helpers -------------------------------------------------------------------------
    def by_type(self, type_):
        return [(i, e) for i, e in enumerate(self.elements) if e.type == type_]


def strip_operators(dmx, system_pred, operator_names):
    """Remove operators whose functionName is in operator_names from every particle system
    definition for which system_pred(name) is true. Returns the number of operators removed."""
    removed = 0
    for i, e in dmx.by_type("DmeParticleSystemDefinition"):
        if not system_pred(e.name):
            continue
        for a in e.attrs:
            if a[1] == AT_ARRAY_BASE + AT_ELEMENT and a[0] in ("renderers", "operators", "initializers", "emitters", "forces", "constraints"):
                keep = []
                for idx in a[2]:
                    if isinstance(idx, int) and 0 <= idx < len(dmx.elements) and dmx.elements[idx].get("functionName") in operator_names:
                        removed += 1
                        continue
                    keep.append(idx)
                a[2] = keep
    return removed

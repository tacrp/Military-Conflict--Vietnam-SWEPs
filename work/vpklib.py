"""Minimal Valve VPK v1/v2 reader (directory + numbered archives). Used by rip_game.py."""
import os
import struct


class VPK:
    def __init__(self, dir_path):
        self.dir_path = dir_path
        self.base = dir_path[:-len("_dir.vpk")] if dir_path.endswith("_dir.vpk") else None
        self.entries = {}          # "path/file.ext" -> (archive_index, offset, length, preload_bytes)
        with open(dir_path, "rb") as f:
            sig, ver = struct.unpack("<II", f.read(8))
            if sig != 0x55AA1234:
                raise ValueError("not a VPK: %s" % dir_path)
            if ver == 1:
                tree_size, = struct.unpack("<I", f.read(4))
                header = 12
            elif ver == 2:
                tree_size, _, _, _, _ = struct.unpack("<IIIII", f.read(20))
                header = 28
            else:
                raise ValueError("unsupported VPK version %d" % ver)
            data = f.read(tree_size)
        self._tree_end = header + tree_size
        self._parse(data)
        self._handles = {}

    @staticmethod
    def _cstr(data, pos):
        end = data.index(b"\0", pos)
        return data[pos:end].decode("latin-1"), end + 1

    def _parse(self, data):
        pos = 0
        while True:
            ext, pos = self._cstr(data, pos)
            if ext == "":
                break
            while True:
                path, pos = self._cstr(data, pos)
                if path == "":
                    break
                while True:
                    name, pos = self._cstr(data, pos)
                    if name == "":
                        break
                    crc, preload_len, arch, off, length, term = struct.unpack_from("<IHHIIH", data, pos)
                    pos += 18
                    preload = data[pos:pos + preload_len]
                    pos += preload_len
                    full = ("%s/%s.%s" % (path, name, ext)) if path not in ("", " ") else ("%s.%s" % (name, ext))
                    self.entries[full] = (arch, off, length, preload, crc)

    def _archive(self, idx):
        if idx not in self._handles:
            if idx == 0x7FFF:
                self._handles[idx] = open(self.dir_path, "rb")
            else:
                self._handles[idx] = open("%s_%03d.vpk" % (self.base, idx), "rb")
        return self._handles[idx]

    def read(self, path):
        arch, off, length, preload, crc = self.entries[path]
        data = preload
        if length:
            f = self._archive(arch)
            if arch == 0x7FFF:
                off += self._tree_end
            f.seek(off)
            data += f.read(length)
        return data

    def extract(self, path, dest_root):
        dst = os.path.join(dest_root, path.replace("/", os.sep))
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        with open(dst, "wb") as f:
            f.write(self.read(path))
        return dst

    def crc(self, path):
        return self.entries[path][4]

    def close(self):
        for h in self._handles.values():
            h.close()
        self._handles = {}

"""Create and round-trip extract the two GMA files using bounded memory.

python work/build_packs.py [--out DIRECTORY] [--part eastern|western|both]
No uploading is performed. Part 2's Workshop item must require Part 1's item.
"""
import argparse
from fnmatch import fnmatchcase
import hashlib
import json
from pathlib import Path
import struct
import subprocess
import time
import zlib
from pack_paths import part2_root

ROOT = Path(__file__).resolve().parents[1]
PARTS = {"eastern":ROOT, "western":part2_root(ROOT)}
GMAD = ROOT.parents[2]/"bin/gmad.exe"
FOLDERS = ("lua","models","materials","sound","particles","shaders","data_static")
WHITELIST = ("lua/*.lua", "models/*.mdl", "models/*.phy", "models/*.ani", "models/*.vvd", "models/*.vtx",
             "materials/*.vmt", "materials/*.vtf", "materials/*.png", "materials/*.jpg", "materials/*.jpeg",
             "sound/*.wav", "sound/*.mp3", "sound/*.ogg", "particles/*.pcf", "shaders/fxc/*.vcs",
             "data_static/*.txt", "data_static/*.dat", "data_static/*.json", "data_static/*.xml", "data_static/*.csv")


def crc(path):
    value = 0
    with path.open("rb") as f:
        while block := f.read(1024*1024):
            value = zlib.crc32(block,value)
    return value & 0xffffffff


def entries(path):
    with path.open("rb") as f:
        def string():
            value = bytearray()
            while (b := f.read(1)) != b"\0":
                assert b, "Truncated GMA header"
                value.extend(b)
            return value.decode("utf8")
        assert f.read(4)==b"GMAD"
        version = f.read(1)[0]
        assert version==3, version
        f.read(16)
        assert string()=="", "Unexpected required-content field"
        title, description, author = string(), string(), string()
        f.read(4)
        result = {}
        while (index := struct.unpack("<I",f.read(4))[0]) != 0:
            name = string()
            size,checksum = struct.unpack("<qI",f.read(12))
            result[name] = {"bytes":size,"crc":checksum}
        return title,result,f.tell()


def create_stream(path, metadata, files):
    """GMAD v3, matching Facepunch/gmad's header, index and CRC format."""
    description = json.dumps({"description":metadata.get("description","Description"),
                              "type":metadata["type"],"tags":metadata["tags"]},separators=(",",":"))
    index = [(k,p,p.stat().st_size,crc(p)) for k,p in sorted(files.items())]
    temporary = path.with_suffix(".gma.tmp")
    assert not temporary.exists()
    with temporary.open("xb") as f:
        checksum = 0
        def write(data):
            nonlocal checksum
            f.write(data)
            checksum = zlib.crc32(data,checksum)
        def string(value):
            assert "\0" not in value
            write(value.encode("utf8")+b"\0")
        write(b"GMAD\x03"+struct.pack("<QQ",0,int(time.time()))+b"\0")
        string(metadata["title"])
        string(description)
        string("An Arctic Mod")
        write(struct.pack("<i",1))
        for i,(key,p,size,file_crc) in enumerate(index,1):
            assert size>0 and len(key)<180, key
            write(struct.pack("<I",i))
            string(key)
            write(struct.pack("<qI",size,file_crc))
        write(struct.pack("<I",0))
        for key,p,size,file_crc in index:
            written, check = 0,0
            with p.open("rb") as source:
                while block := source.read(1024*1024):
                    write(block)
                    written += len(block)
                    check = zlib.crc32(block,check)
            assert written==size and check==file_crc, f"File changed while building: {key}"
        f.write(struct.pack("<I",checksum & 0xffffffff))
    temporary.rename(path)


def extract_stream(path,target):
    _,index,offset = entries(path)
    target = target.resolve()
    target.mkdir(parents=True,exist_ok=False)
    with path.open("rb") as source:
        # Verify the archive CRC without retaining its contents in memory.
        checksum, left = 0,path.stat().st_size-4
        while left:
            block = source.read(min(left,1024*1024))
            assert block, "Truncated archive"
            checksum = zlib.crc32(block,checksum)
            left -= len(block)
        assert checksum==struct.unpack("<I",source.read(4))[0], "Archive CRC mismatch"
        assert offset+sum(v["bytes"] for v in index.values())+4==path.stat().st_size
        source.seek(offset)
        for key,row in index.items():
            dest = (target/key).resolve()
            assert dest.is_relative_to(target) and dest!=target, key
            dest.parent.mkdir(parents=True,exist_ok=True)
            left, check = row["bytes"],0
            with dest.open("xb") as f:
                while left:
                    block = source.read(min(left,1024*1024))
                    assert block, key
                    f.write(block)
                    check = zlib.crc32(block,check)
                    left -= len(block)
            assert check==row["crc"], key


def build(part,out):
    root = PARTS[part]
    name = "mcv-part1-eastern" if part=="eastern" else "mcv-part2-western"
    gma, extracted = out/(name+".gma"), out/(name+"-extracted")
    metadata = json.loads((root/"addon.json").read_text())
    expected = {}
    for folder in FOLDERS:
        for p in (root/folder).rglob("*"):
            if p.is_file():
                key = p.relative_to(root).as_posix().lower()
                if not any(fnmatchcase(key,pattern.lower()) for pattern in metadata["ignore"]):
                    assert any(fnmatchcase(key,p) for p in WHITELIST), "Unsupported GMA path: "+key
                    assert not key.endswith((".sw.vtx",".360.vtx",".xbox.vtx")), key
                    expected[key]=p
    size = sum(p.stat().st_size for p in expected.values())
    assert size < 4_000_000_000, f"{name} exceeds the conservative 4 GB ceiling"
    assert not gma.exists() and not extracted.exists(), "Use a fresh --out directory; existing builds are preserved"
    create_stream(gma,metadata,expected)
    title, actual, _ = entries(gma)
    assert title==metadata["title"]
    assert actual.keys()==expected.keys(), {"missing":sorted(expected.keys()-actual.keys()),"extra":sorted(actual.keys()-expected.keys())}
    assert all(actual[k]["bytes"]==p.stat().st_size for k,p in expected.items())
    print(f"Built {name}: {gma.stat().st_size:,} bytes, {len(actual)} files",flush=True)
    extract_stream(gma,extracted)
    for k,p in expected.items():
        copy = (extracted/k).resolve()
        assert copy.is_relative_to(extracted.resolve()) and copy.is_file(), k
        assert copy.stat().st_size==actual[k]["bytes"] and crc(copy)==actual[k]["crc"], k
        with p.open("rb") as a, copy.open("rb") as b:
            assert hashlib.file_digest(a,"sha256").digest()==hashlib.file_digest(b,"sha256").digest(), k
    report = {"part":part,"title":title,"gma":str(gma),"bytes":gma.stat().st_size,
              "files":len(actual),"extractPassed":True,"allFileHashesMatch":True,"method":"streaming GMAD v3",
              "requires":"eastern" if part=="western" else None}
    (out/(name+"-verification.json")).write_text(json.dumps(report,indent=2)+"\n")
    print(f"Extracted and verified every file in {name}",flush=True)
    return report


def compatibility(out):
    """Use native GMad to independently read the streaming writer's small fixture."""
    folder = out/"format-check"
    folder.mkdir(parents=True,exist_ok=False)
    files = {"lua/mcv/shared/sh_hammer_events.lua": ROOT/"lua/mcv/shared/sh_hammer_events.lua",
             "shaders/fxc/mcv_scope_ps30.vcs":ROOT/"shaders/fxc/mcv_scope_ps30.vcs",
             "materials/mcv/scope_lens.vmt":ROOT/"materials/mcv/scope_lens.vmt"}
    archive = folder/"streamed.gma"
    create_stream(archive,{"title":"MCV archive format check","type":"weapon","tags":["realism"]},files)
    with (folder/"native-extract.log").open("w") as log:
        r = subprocess.run([str(GMAD),"extract","-file",str(archive),"-out",str(folder/"native")],stdout=log,stderr=subprocess.STDOUT)
    assert r.returncode==0
    for key,original in files.items():
        assert (folder/"native"/key).read_bytes()==original.read_bytes(), key
    (folder/"verification.json").write_text(json.dumps({"nativeGmadReadStreamingArchive":True,"files":len(files)},indent=2)+"\n")
    print("Native GMad accepted the streaming writer's format and extracted every fixture file",flush=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--out",type=Path,default=ROOT/"work/pack_split/build")
    parser.add_argument("--part",choices=("eastern","western","both"),default="both")
    parser.add_argument("--format-check",action="store_true",help="Only cross-check archive format with native GMad")
    args = parser.parse_args()
    out = args.out.resolve()
    out.mkdir(parents=True,exist_ok=True)
    if args.format_check:
        compatibility(out)
    else:
        parts = PARTS if args.part=="both" else (args.part,)
        reports = [build(part,out) for part in parts]
        (out/"verification.json").write_text(json.dumps(reports,indent=2)+"\n")

"""Resolve mounted addon paths across Part 1 and its sibling content pack."""
from functools import lru_cache
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def part2_root(root=ROOT):
    """Offline tools can inspect a user-disabled pack without re-enabling it."""
    root = Path(root).resolve()
    enabled, disabled = root.parent/"mcv-2", root.parent/"disable/mcv-2"
    if enabled.exists() and disabled.exists():
        raise ValueError("Both enabled and disabled mcv-2 folders exist; choose one source")
    return disabled if disabled.exists() else enabled


PART2 = part2_root()


@lru_cache(None)
def assignments():
    plan = ROOT / "work/pack_split/plan.json"
    return json.loads(plan.read_text())["assignments"] if plan.exists() else {}


def asset_path(relative, root=ROOT):
    """Existing file, or its planned destination for a newly compiled companion file."""
    root = Path(root).resolve()
    relative = Path(relative)
    assert not relative.is_absolute() and ".." not in relative.parts, relative
    other = part2_root(root)
    found = [p for p in (root/relative, other/relative) if p.exists()]
    if len(found) > 1:
        raise ValueError(f"Duplicate mounted asset: {relative}")
    if found:
        return found[0]
    key = relative.as_posix().lower()
    part = assignments().get(key)
    if part is None and key.startswith("models/"):
        part = assignments().get(key.split(".")[0]+".mdl")
    return (other if part == "western" else root) / relative


def mounted_files(folder, pattern="*", root=ROOT):
    root = Path(root).resolve()
    seen = set()
    for base in (root, part2_root(root)):
        for p in sorted((base/folder).glob(pattern)):
            key = p.relative_to(base).as_posix().lower()
            if key in seen:
                raise ValueError(f"Duplicate mounted asset: {key}")
            seen.add(key)
            yield p

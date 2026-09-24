"""Move only the XM148 Type 56's dedicated runtime content; preserve source/shared assets."""
import hashlib
import json
from pack_paths import ROOT, PART2

relatives = ['lua/weapons/mcv_type56xm148.lua', 'materials/entities/mcv_type56xm148.png']
for stem in ('v_type56xm148', 'w_type56xm148'):
    relatives += [p.relative_to(ROOT).as_posix() for p in (ROOT/'models/weapons/mcv').glob(stem+'.*')]
records = []
for relative in relatives:
    src, dst = (ROOT/relative).resolve(), (PART2/relative).resolve()
    assert src.is_relative_to(ROOT.resolve()) and dst.is_relative_to(PART2.resolve())
    if not src.exists():
        assert dst.is_file(), relative
        continue
    assert not dst.exists(), dst
    digest = hashlib.sha256(src.read_bytes()).hexdigest()
    dst.parent.mkdir(parents=True, exist_ok=True)
    src.rename(dst)
    assert hashlib.sha256(dst.read_bytes()).hexdigest() == digest
    records.append({'path': relative, 'sha256': digest})

plan_path = ROOT/'work/pack_split/plan.json'
plan = json.loads(plan_path.read_text())
for relative in relatives:
    plan['assignments'][relative] = 'western'
plan_path.write_text(json.dumps(plan, indent=2)+'\n')
(ROOT/'work/pack_split/type56xm148_move.json').write_text(json.dumps(records, indent=2)+'\n')
print(f'Moved and hash-verified {len(records)} files to {PART2}')

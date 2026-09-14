"""Check that custom QCs resolve locally, then compile all three editable bundles."""
from concurrent.futures import ThreadPoolExecutor
import hashlib
import json
from pathlib import Path
import re
import subprocess
import sys
from export_custom_compile_files import BUNDLES, FILE_REF, HERE

results = []
def build(name):
    folder = HERE/'MCV_SMD/weapons'/name
    for path in [*folder.glob('*.qc'), *folder.rglob('*.qci')]:
        for ref in FILE_REF.findall(path.read_text()):
            target = (path.parent/ref.replace('\\','/')).resolve()
            assert target.is_relative_to(folder.resolve()) and target.is_file(), (path,ref)
    sources = {p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in folder.glob('*.smd')}
    run = subprocess.run([sys.executable,str(folder/'compile.py')],capture_output=True,text=True,timeout=300)
    if run.returncode: raise RuntimeError(run.stdout+run.stderr)
    assert sources == {p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in folder.glob('*.smd')}, 'input changed during compile'
    return dict(folder=name,ok=True,sources=sources,output=run.stdout)

with ThreadPoolExecutor(max_workers=3) as pool:
    for result in pool.map(build,BUNDLES):
        results.append(result)
        print(result['folder'],'local compile passed',flush=True)
(HERE/'custom_compile_validation.json').write_text(json.dumps(results,indent=2)+'\n')

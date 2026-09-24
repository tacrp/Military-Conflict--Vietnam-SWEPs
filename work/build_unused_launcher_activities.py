"""Correct the two new launcher activities/idle bases without regenerating their QCs."""
import json
import shutil
import subprocess
from types import SimpleNamespace
from pack_paths import ROOT, asset_path
from port_qc import QC, Block, make_len_variant
from fix_gyrojet_sprint import model_metadata

work = ROOT / 'work'
out = work / 'unused_launcher_activities'
out.mkdir(exist_ok=True)
compiler = ROOT.parents[2] / 'bin/studiomdl.exe'
records = []
for model in ('v_type56xm148', 'v_m16_flamer'):
    path = work / 'MCV_SMD_PORT/weapons' / model / (model + '.qc')
    backup = out / (model + '.before.qc')
    if not backup.exists(): shutil.copy2(path, backup)
    qc = QC(path.read_text())
    shot = qc.find('sequence', 'gl_shoot')
    idle = qc.find_by_activity('ACT_VM_IIDLE_M203')
    assert shot and idle
    created = {}
    ctx = SimpleNamespace(warn=lambda msg: (_ for _ in ()).throw(ValueError(msg)))
    bases = []
    for i, a in enumerate(idle.anims()):
        if a.lower().endswith('.smd'):
            name = 'mcv_launcher_idle_' + str(i)
            if not qc.find('animation', name):
                qc.insert_before(idle, Block('animation', name, a, ['fps 30']))
            a = name
        bases.append(a)
    anims = [a if qc.find('animation', a + '__f60') else make_len_variant(qc, ctx, a, 60, created)
             for a in bases]
    # Use the existing clone on repeated builds.
    anims = [a + '__f60' if qc.find('animation', a + '__f60') else a for a in anims]
    shot.lines = ['"'+a+'"' for a in anims] + ['activity "ACT_VM_ISHOOT_M203" 1']
    shot.lines += [line for line in idle.lines if line.startswith(('blend ', 'blendwidth ', 'addlayer '))]
    shot.lines += ['snap', 'addlayer "gl_shoot_pose"', 'node "0"']
    path.write_text(qc.render())
    before = model_metadata(asset_path(f'models/weapons/mcv/{model}.mdl'))
    run = subprocess.run([str(compiler), '-game', str(work/'compile_test_game'), '-nop4', str(path)],
                         cwd=compiler.parent, capture_output=True, text=True, timeout=240)
    log = run.stdout + run.stderr
    (out/(model+'.log')).write_text(log)
    assert run.returncode == 0 and 'Completed' in log and 'ERROR:' not in log, log[-3000:]
    compiled = work / 'compile_test_game/models/weapons/mcv' / (model+'.mdl')
    after = model_metadata(compiled)
    assert b'ACT_VM_ISHOOT_M203\0' in compiled.read_bytes()
    assert [s for s in before['sequences'] if s[0]!='gl_shoot'] == [s for s in after['sequences'] if s[0]!='gl_shoot']
    for ext in ('.mdl', '.vvd', '.dx90.vtx', '.dx80.vtx', '.sw.vtx'):
        src = compiled.with_name(model + ext)
        if src.exists(): shutil.copy2(src, asset_path('models/weapons/mcv/'+src.name))
    records.append({'model': model, 'shot': next(s for s in after['sequences'] if s[0]=='gl_shoot')})
(out/'verified.json').write_text(json.dumps(records, indent=2)+'\n')
print('Compiled and installed both launcher models; other sequence activities/events unchanged.')

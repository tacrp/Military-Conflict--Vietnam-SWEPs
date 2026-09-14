"""Build two local Source transition fixtures with a shared landmark/volume."""
from pathlib import Path
import subprocess
import shutil

HERE = Path(__file__).resolve().parent
OUT = HERE/'clock_transition'
OUT.mkdir(exist_ok=True)
GMOD = HERE.parents[3]
serial = 1


def ident():
    global serial
    serial += 1
    return serial


def brush(lo, hi, material):
    corners = [(x,y,z) for x in (lo[0],hi[0]) for y in (lo[1],hi[1]) for z in (lo[2],hi[2])]
    faces = [(0,1,3),(4,6,7),(0,4,5),(2,3,7),(0,2,6),(1,5,7)]
    parts = ['solid\n{',f'"id" "{ident()}"']
    for face in faces:
        plane = ' '.join('('+' '.join(str(v) for v in corners[i])+')' for i in reversed(face))
        parts += ['side\n{',f'"id" "{ident()}"',f'"plane" "{plane}"',f'"material" "{material}"',
                  '"uaxis" "[1 0 0 0] 0.25"','"vaxis" "[0 -1 0 0] 0.25"','"lightmapscale" "16"','}']
    return '\n'.join(parts+['}'])


def entity(properties, solid=None):
    return 'entity\n{\n'+f'"id" "{ident()}"\n'+'\n'.join(f'"{k}" "{v}"' for k,v in properties.items())+'\n'+(solid or '')+'\n}'


for name, destination in [('mcv_clock_a','mcv_clock_b'),('mcv_clock_b','mcv_clock_a')]:
    solids = []
    for lo,hi in [((-512,-512,-64),(512,512,0)),((-576,-576,-64),(-512,576,320)),((512,-576,-64),(576,576,320)),
                  ((-512,-576,-64),(512,-512,320)),((-512,512,-64),(512,576,320)),((-512,-512,256),(512,512,320))]:
        solids.append(brush(lo,hi,'concrete/concretefloor001a'))
    text = 'versioninfo\n{\n"editorversion" "400"\n"mapversion" "1"\n"formatversion" "100"\n}\nworld\n{\n"id" "1"\n"classname" "worldspawn"\n'+'\n'.join(solids)+'\n}\n'
    text += entity({'classname':'info_player_start','origin':'-256 0 16','angles':'0 0 0'})
    text += entity({'classname':'lua_run','spawnflags':'1','Code':'include([[mcv_harness/clock_transition_watch.lua]])'})
    text += entity({'classname':'info_landmark','targetname':'mcv_clock_origin','origin':'0 0 64'})
    text += entity({'classname':'trigger_transition','targetname':'mcv_clock_origin'},brush((-508,-508,1),(508,508,250),'tools/toolstrigger'))
    text += entity({'classname':'trigger_changelevel','targetname':'mcv_clock_exit','map':destination,'landmark':'mcv_clock_origin','spawnflags':'2'},brush((-508,-508,1),(508,508,250),'tools/toolstrigger'))
    vmf = OUT/(name+'.vmf')
    vmf.write_text(text)
    r = subprocess.run([str(GMOD/'bin/vbsp.exe'),'-game',str(GMOD/'garrysmod'),str(vmf)],cwd=GMOD/'bin',capture_output=True,text=True,timeout=120)
    (OUT/(name+'.log')).write_text(r.stdout+r.stderr)
    assert r.returncode == 0 and vmf.with_suffix('.bsp').exists(), r.stdout[-3000:]
    shutil.copy2(vmf.with_suffix('.bsp'),GMOD/'garrysmod/maps'/vmf.with_suffix('.bsp').name)
    print(name,'compiled')

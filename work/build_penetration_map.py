"""Tiny enclosed BSP collision fixture, installed only into the local test game."""
from pathlib import Path
import shutil
import subprocess

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'penetration_map'
OUT.mkdir(exist_ok=True)
GMOD=ROOT.parents[3]
serial=1
def ident():
    global serial
    serial+=1
    return serial
def brush(lo,hi,material):
    corners=[(x,y,z) for x in (lo[0],hi[0]) for y in (lo[1],hi[1]) for z in (lo[2],hi[2])]
    faces=[(0,1,3),(4,6,7),(0,4,5),(2,3,7),(0,2,6),(1,5,7)]
    body=['solid\n{',f'"id" "{ident()}"']
    for face in faces:
        points=' '.join('('+' '.join(str(v) for v in corners[i])+')' for i in reversed(face))
        body+=['side\n{',f'"id" "{ident()}"',f'"plane" "{points}"',f'"material" "{material}"',
               '"uaxis" "[1 0 0 0] 0.25"','"vaxis" "[0 -1 0 0] 0.25"','"rotation" "0"','"lightmapscale" "16"','"smoothing_groups" "0"','}']
    body.append('}')
    return '\n'.join(body)
solids=[]
for lo,hi in [((-512,-512,-64),(512,512,0)),((-576,-576,-64),(-512,576,320)),((512,-576,-64),(576,576,320)),
              ((-512,-576,-64),(512,-512,320)),((-512,512,-64),(512,576,320)),((-512,-512,256),(512,512,320))]:
    solids.append(brush(lo,hi,'tools/toolsnodraw'))
# Three lanes: thin, beyond the M16's metal limit, and two close thin world slabs.
for lo,hi in [((0,-350,0),(4,-150,128)),((0,-100,0),(20,100,128)),((0,150,0),(3,350,128)),((8,150,0),(11,350,128))]:
    solids.append(brush(lo,hi,'metal/metalwall048a'))
vmf=OUT/'mcv_penetration_test.vmf'
vmf.write_text('versioninfo\n{\n"editorversion" "400"\n"mapversion" "1"\n"formatversion" "100"\n}\nworld\n{\n"id" "1"\n"classname" "worldspawn"\n"skyname" "sky_day01_01"\n'+ '\n'.join(solids)+'\n}\nentity\n{\n"id" "1000"\n"classname" "info_player_start"\n"origin" "-400 -250 16"\n"angles" "0 0 0"\n}\n')
result=subprocess.run([str(GMOD/'bin/vbsp.exe'),'-game',str(GMOD/'garrysmod'),str(vmf)],capture_output=True,text=True,cwd=GMOD/'bin',timeout=120)
(OUT/'build.log').write_text(result.stdout+result.stderr)
print((result.stdout+result.stderr)[-3500:])
assert result.returncode==0 and vmf.with_suffix('.bsp').exists()
shutil.copy2(vmf.with_suffix('.bsp'),GMOD/'garrysmod/maps/mcv_penetration_test.bsp')

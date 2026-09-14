"""Verify insertion sound time in the compiled M635, not just the QC text."""
import json
from pathlib import Path
import struct
from bake_ik import load_smd

root=Path(__file__).resolve().parents[1]
data=(root/'models/weapons/mcv/v_m635.mdl').read_bytes()
count,offset=struct.unpack_from('<ii',data,188)
results=[]
for i in range(count):
    seq=offset+i*212
    p=seq+struct.unpack_from('<i',data,seq+4)[0]
    name=data[p:data.index(b'\0',p)].decode()
    if name not in ('reload','reload_empty'): continue
    n,start=struct.unpack_from('<ii',data,seq+24)
    for j in range(n):
        event=seq+start+j*80
        options=data[event+12:event+76].split(b'\0',1)[0].decode()
        if options!='MCV_Weapon_Foley_SWM76_Reload.MagIn': continue
        cycle=struct.unpack_from('<f',data,event)[0]
        _,frames,_=load_smd(root/f'work/MCV_SMD/weapons/v_m635/assets/{name}.smd')
        seconds=cycle*(len(frames)-1)/30
        assert abs(seconds-29/30)<1e-5,(name,seconds)
        results.append(dict(sequence=name,frame=29,seconds=seconds,advance=.5))
assert len(results)==2
out=root/'work/m635_build/insertion_events.json'
out.write_text(json.dumps(dict(ok=True,results=results),indent=2)+'\n')
print(out.read_text())

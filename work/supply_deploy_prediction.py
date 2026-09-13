"""Live mixed-inventory resupply and mode-aware deployment checks with real MP input."""
import argparse
from collections import Counter
import json
from pathlib import Path
import sys
from prediction_suite import ERROR


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--port',type=int,default=27016)
    p.add_argument('--lag',type=int,default=100)
    p.add_argument('--label',required=True)
    p.add_argument('--only',choices=['supply','deploy'],required=True)
    a=p.parse_args()
    sys.argv=[sys.argv[0],'--port',str(a.port)]
    import harness as h
    root=Path(h.RESULTS); out=root/a.label; out.mkdir(parents=True,exist_ok=True)
    name=a.label; begin=f'[lifecycle begin {name}]'; end=f'[lifecycle end {name}]'
    lines=['ccmd net_fakelag 0','ccmd cl_showerror 0','god']
    lines += [f'key -{k}' for k in ['attack','attack2','reload','use','walk','speed','forward','jump','duck']]
    lines += ['strip','lua game.CleanUpMap()','lua ply:RemoveAllAmmo()',
              'pos -704 576 -12288','ang 0 0 0']
    checks=[]
    if a.only=='supply':
        for cls in ['mcv_m2c','mcv_m16a1_m203','weapon_pistol','weapon_rpg','weapon_frag','mcv_ammobox_us']:
            lines += [f'lua ply:Give("{cls}")']
        lines += ['select mcv_ammobox_us','wait 3','lua ply:RemoveAllAmmo() ply:SetAmmo(20,"mcv_ammobox")','wait 2']
        lines += [f'ccmd net_fakelag {a.lag}','ccmd cl_pred_optimize 0','wait 2',
                  'ccmd cl_showerror 2',f'clua print("{begin}")',f'report {name}_0']
        for i in range(1,7):
            # Predict the plan before using it; later compare with the actual grant.
            for prefix,side in [('lua','server'),('clua','client')]:
                lines += [f'{prefix} local w=ply:GetActiveWeapon() local plan=MCV_AmmoSupplyPlan(ply,1,w:GetSupplyCursor()) file.Write("mcv_harness/p{a.port}/results/{name}_plan{i}.{side}.json",util.TableToJSON(plan))']
            lines += ['tap +attack2 0.12','wait 3',f'report {name}_{i}']
        lines += [f'clua print("{end}")','ccmd cl_showerror 0','ccmd net_fakelag 0','wait 1']
        lines += ['lua local w=ply:GetActiveWeapon() for _,p in ipairs(MCV_AmmoSupplyPlan(ply,1,w:GetSupplyCursor())) do ply:SetAmmo(p.cap,p.ammo) end',
                  'wait 2',f'ccmd net_fakelag {a.lag}','wait 2',f'report {name}_full_before',
                  'ccmd cl_showerror 2',f'clua print("[full begin {name}]")',
                  'tap +attack2 0.12','wait 3',f'clua print("[full end {name}]")',
                  'ccmd cl_showerror 0',f'report {name}_full_after','ccmd net_fakelag 0','wait 1']
    else:
        for cls in ['mcv_m2c','mcv_m1911a1','mcv_m16a1_m203','mcv_m16_xm148']:
            lines += [f'lua ply:Give("{cls}")']
        lines += ['lua MCV.UnlockSecondWeapon(ply,"mcv_m1911a1")','select mcv_m1911a1','wait 3',
                  f'ccmd net_fakelag {a.lag}','ccmd cl_pred_optimize 0','wait 2',
                  'ccmd cl_showerror 2',f'clua print("{begin}")']
        # Dual mode must survive switching away and back; both launchers retain their mode.
        for cls,mode in [('mcv_m1911a1','akimbo'),('mcv_m16a1_m203','launcher'),('mcv_m16_xm148','launcher')]:
            lines += [f'clua input.SelectWeapon(ply:GetWeapon("{cls}"))','wait 3',
                      'key +walk','tap +use 0.12','key -walk','wait 3',
                      'clua input.SelectWeapon(ply:GetWeapon("mcv_m2c"))','wait 3',
                      f'clua input.SelectWeapon(ply:GetWeapon("{cls}"))','wait 3',
                      f'report {name}_{cls}']
            checks.append((cls,mode))
        lines += [f'clua print("{end}")','ccmd cl_showerror 0','ccmd net_fakelag 0','wait 1']
        # Deliberate corruption is setup noise; verify Deploy restores even a lying alias.
        for cls,mode in checks+[('mcv_m2c',None)]:
            lines += [f'select {cls}','wait 3']
            for prefix in ['lua','clua']:
                lines += [f'{prefix} local w=ply:GetActiveWeapon() local vm=ply:GetViewModel() local mins,maxs=vm:GetCollisionBounds() vm:SetModel("models/weapons/mcv/v_m870.mdl") vm:SetCollisionBounds(mins,maxs) w:Deploy() assert(vm:GetModel()==w.ViewModel,"deploy did not restore model")']
            lines += ['wait 2',f'report {name}_corrupt_{cls}']
    (out/'commands.txt').write_text('\n'.join(lines)+'\n')
    offset=Path(h.CONSOLE_LOG).stat().st_size
    _,result=h.send(lines,name=name,timeout=250)
    raw='\n'.join(h.console_tail(offset)[0]); (out/'console.txt').write_text(raw,encoding='utf-8')
    if result is None: raise RuntimeError('lifecycle test timeout')
    failures=list(result.get('errors',[])); details=[]
    if a.only=='supply':
        received={}
        for i in range(1,7):
            plans=[json.loads((root/f'{name}_plan{i}.{side}.json').read_text()) for side in ['client','server']]
            states={}
            for side in ['client','server']:
                states[side]=[json.loads((root/f'{name}_{j}.{side}.json').read_text()) for j in [i-1,i]]
                plan=plans[['client','server'].index(side)]
                for pool in plan:
                    aid=str(pool['ammo']); before=states[side][0]['ammo'].get(aid,0); after=states[side][1]['ammo'].get(aid,0)
                    if after-before!=pool['amount']: failures.append(f'use {i} {side} ammo {aid}: {after-before} != {pool["amount"]}')
                    if side=='server': received[aid]=received.get(aid,0)+pool['amount']
                if states[side][0]['reserve']-states[side][1]['reserve']!=1: failures.append(f'use {i} charge consumption {side}')
            if plans[0]!=plans[1]: failures.append(f'use {i} client/server plan differs')
            if states['client'][1]['ammo']!=states['server'][1]['ammo']: failures.append(f'use {i} client/server ammo differs')
            cost=sum(p['amount']/p['per'] for p in plans[1])
            if cost>1+1e-8: failures.append(f'use {i} budget exceeded')
            details.append({'use':i,'cost':cost,'grant':{p['ammo']:p['amount'] for p in plans[1] if p['amount']}})
        if any(n==0 for n in received.values()): failures.append('an ammo pool never received its turn')
        for side in ['client','server']:
            before,after=[json.loads((root/f'{name}_full_{moment}.{side}.json').read_text()) for moment in ['before','after']]
            if before['ammo']!=after['ammo']: failures.append(f'full reserve consumed ammo/box on {side}')
    else:
        for cls,mode in checks+[('mcv_m2c',None)]:
            for corrupt in [False,True]:
                if cls=='mcv_m2c' and not corrupt: continue
                reports=[json.loads((root/f'{name}_{"corrupt_" if corrupt else ""}{cls}.{side}.json').read_text()) for side in ['client','server']]
                for r in reports:
                    if r['weapon']!=cls or (mode and not r[mode]): failures.append(f'{cls}: wrong weapon/mode')
                if reports[0]['vm']['model']!=reports[1]['vm']['model']: failures.append(f'{cls}: model disagreement')
                details.append({'weapon':cls,'corrupt':corrupt,'model':reports[0]['vm']['model'],'sequence':reports[0]['vm']['sequence']})
    measured=raw.partition(begin)[2].partition(end)[0]
    if a.only=='supply': measured+='\n'+raw.partition(f'[full begin {name}]')[2].partition(f'[full end {name}]')[0]
    summary={'native':dict(Counter(ERROR.findall(measured))),
             'failures':failures,'details':details}
    (out/'summary.json').write_text(json.dumps(summary,indent=2)+'\n'); print(json.dumps(summary),flush=True)
    if failures: raise SystemExit(1)


if __name__=='__main__': main()

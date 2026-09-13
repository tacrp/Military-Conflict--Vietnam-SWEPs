"""Plot measured aim progress before and after the render-cache fix."""
import argparse
import json
from pathlib import Path
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('before',type=Path)
    p.add_argument('after',type=Path)
    p.add_argument('output',type=Path)
    a=p.parse_args()
    fig,axs=plt.subplots(1,2,figsize=(10,3.5),sharex=True,sharey=True,layout='constrained')
    for ax,path,title in zip(axs,(a.before,a.after),('Before','After')):
        rows=json.loads(path.read_text())['records']
        rows=[r for r in rows if r['stage']=='drawn' and r['phase']=='aim_up']
        x=[r['time']-rows[0]['time'] for r in rows]
        ax.plot(x,[r['raw'] for r in rows],color='#677584',label='Predicted aim',linewidth=2)
        ax.plot(x,[r['visual'] for r in rows],color='#147d92',label='Rendered aim',linewidth=2,linestyle='--',marker='o',markersize=3)
        ax.set_title(title,loc='left',weight='bold')
        ax.set(xlabel='Seconds from first aim frame',xlim=(0,1.6),ylim=(-0.04,1.06))
        ax.grid(alpha=.18)
        ax.spines[['top','right']].set_visible(False)
    axs[0].set_ylabel('Aim progress (0 = hip, 1 = aimed)')
    axs[1].legend(loc='lower right',frameon=False)
    fig.suptitle('M2 Carbine · local multiplayer · net_fakelag 100\nMeasured at about 11 FPS; identical input phases',fontsize=12)
    fig.savefig(a.output,dpi=170)
    print(a.output.resolve())


if __name__=='__main__':
    main()

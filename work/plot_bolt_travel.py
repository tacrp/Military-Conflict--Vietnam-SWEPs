"""Plot per-shot bolt travel from the retained zero-lag engine traces."""
import argparse
from pathlib import Path
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from shoot_trace_report import analyze


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('results',type=Path)
    p.add_argument('output',type=Path)
    a=p.parse_args()
    fig,axes=plt.subplots(1,2,figsize=(10,3.6),sharey=True)
    for ax,cls,title in zip(axes,['mcv_m2c','mcv_xm177_oeg'],['M2 Carbine','XM177 OEG']):
        for label,prefix,color in [('Before','shoot_clock0_probe','#b95d4b'),('Fixed','shooting_verified0','#267b94')]:
            shots=analyze(a.results/f'{prefix}_{cls}.visual.json')['shots']
            ax.plot(range(1,len(shots)+1),[r['travel']['Bolt'] for r in shots],
                    marker='o',markersize=3,label=label,color=color,linewidth=1.4)
        ax.set_title(title,loc='left',fontweight='bold'); ax.set_xlabel('Shot in test sequence')
        ax.set_ylim(-0.1,3.9); ax.grid(axis='y',alpha=.2); ax.spines[['top','right']].set_visible(False)
        ax.set_xticks([1,5,10,15,19])
    axes[0].set_ylabel('Bolt travel relative to parent (units)'); axes[1].legend(frameon=False)
    fig.suptitle('Bolt motion in local multiplayer · net_fakelag 0',x=.065,ha='left',fontsize=14)
    fig.text(.065,.015,'Each point is one shot. Near zero means the bolt stayed almost stationary. Tests include taps and a burst.',fontsize=9,color='#444444')
    fig.tight_layout(rect=(0,.065,1,.94)); fig.savefig(a.output,dpi=160,facecolor='white')
    print(a.output.resolve())


if __name__=='__main__': main()

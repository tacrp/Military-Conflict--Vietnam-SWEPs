"""Export harness JPEG captures using their actual timestamps (about 20 captures/s)."""
import argparse
import json
from pathlib import Path
import shutil
import subprocess


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('trace',type=Path)
    p.add_argument('output',type=Path)
    a=p.parse_args()
    trace=json.loads(a.trace.read_text())
    times=trace['image_times']
    if not times:
        p.error('trace has no timestamped captures')
    shots=a.trace.resolve().parent.parent/'shots'/trace['name']
    lines=['ffconcat version 1.0']
    for i,t in enumerate(times):
        path=shots/f'{i+1:05d}.jpg'
        if not path.exists():
            raise FileNotFoundError(path)
        quoted=path.as_posix().replace("'", "'\\''")
        lines.append(f"file '{quoted}'")
        if i+1<len(times):
            lines.append(f"duration {times[i+1]['time']-t['time']:.9f}")
    manifest=a.output.with_suffix('.ffconcat')
    manifest.write_text('\n'.join(lines)+'\n')
    ffmpeg=shutil.which('ffmpeg') or r'C:\ffmpeg\bin\ffmpeg.exe'
    subprocess.run([ffmpeg,'-hide_banner','-loglevel','error','-y','-f','concat','-safe','0',
                    '-i',str(manifest),'-an','-c:v','libx264','-crf','23','-pix_fmt','yuv420p',
                    '-fps_mode','vfr','-movflags','+faststart',str(a.output)],check=True)
    print(a.output.resolve())


if __name__=='__main__':
    main()

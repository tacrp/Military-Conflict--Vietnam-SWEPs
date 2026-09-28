"""Check real GPU captures from scope_contact.txt / scope_variants.txt.

Usage: python work/check_scope_buffers.py <harness shots directory>
Every opaque lens pixel must equal the saved pre-postprocess picture; a blank
alpha mask must fail, which the old draw-call-only mocks could not detect.
"""
import json
from pathlib import Path
import sys
import numpy as np
from PIL import Image

root = Path(sys.argv[1])
names = ('scope_contact_on', 'vz54_scope', 'vz54_fov25', 'vz54_fovminus25',
         'vz54_fired', 'oeg_contact_on', 'oeg_contact_off', 'oeg_firing')
results = {}
for name in names:
    final = np.asarray(Image.open(root/f'{name}.png').convert('RGB')).astype(int)
    saved = np.asarray(Image.open(root/f'{name}_saved.png').convert('RGB')).astype(int)
    layer = np.asarray(Image.open(root/f'{name}_layer.png').convert('RGBA'))
    mask = layer[:, :, 3] == 255
    assert mask.sum() > 1000, f'{name}: missing/transparent lens mask'
    assert (~mask).sum() > 1000, f'{name}: mask covers whole screen'
    delta = np.abs(final - saved)
    results[name] = dict(lens_pixels=int(mask.sum()),
        mean_difference=float(delta[mask].mean()), max_difference=int(delta[mask].max()))
    assert delta[mask].max() == 0, f'{name}: postprocess changed saved lens pixels'
print(json.dumps(results, indent=2))

# Addon icon

`addon-icon-hd.png`: 2048 x 2048 RGB PNG. `addon-icon-512.png`: 512 x 512 preview.
The background uses the addon's actual HUD icons in tightly stacked horizontal
rows. Every other row faces left, with staggered row starts and cropped edges so
the pattern fills the square. The icons are dark olive grey with their internal
linework retained. The credit is exactly **An Arctic Mod**.

The title uses the game's actual wordmark, extracted from the installed MCV
`vietnam/pak01_dir.vpk`, entry `materials/panorama/images/mcv_logo.png`, saved as
`references/mcv_logo_original.png`. This preserves the original widely spaced
white sans-serif MILITARY / CONFLICT and yellow serif VIETNAM. It does not rely
on a guessed substitute font. The added WEAPONS and credit use Arial with tracking
to complement the wordmark. No font files need to be redistributed.

The pattern randomly selects 57 different icons from 189 eligible original-game
weapon icons. It resolves the same `IconOverride` paths as the HUD and removes
duplicate artwork before shuffling. Requiring a viewmodel present in the original
game scripts excludes the custom guns. Grenades, equipment and melee are omitted
from the firearm pattern. `hud-icon-layout.json` records the random seed and every
placement so the result can be rebuilt exactly. `weapon-pattern-background.png`
is the finished background without text.

The rejected rendered collage and its compositor are preserved under
`archive/render-collage/`. Its studio captures remain in `references/`, but the
current icon does not use them.

Rebuild with `python work/compose_addon_icon.py` (Pillow, NumPy and Windows Arial).
Pass `--seed <number>` to shuffle another arrangement. Source icons stay untouched
in `materials/entities/`; the original logo is saved beside the composition.

The [official MCV site](https://militaryconflictvietnam.com/) and the user's
Rainbow Herbicides artwork reference informed the title treatment.
No Workshop item has been published or updated.

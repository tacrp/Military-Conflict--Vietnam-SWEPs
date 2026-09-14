# Random weapon selectors

Under Weapons > Military Conflict: Vietnam, each of the 18 weapon sections starts
with a Random entry. Expand that tree node and select **Miscellaneous** for 23
country pools, six WW2 pools and six mixed groups (all MCV weapons, homemade,
custom kitbashes, scoped, dual-wield-capable and rifle-grenade-capable).

- Left-click: give yourself one random weapon from that pool and select it.
- Middle-click: spawn a random weapon pickup using the normal sandbox command.
- Right-click > Use for NPCs: choose this pool for subsequently spawned NPCs.
  Every new NPC gets a fresh roll, restricted to weapons supported by its weapon
  AI path. Groups without supported weapons disable this action.
- An explicit weapon chosen from an NPC icon's own menu takes precedence.

The MCV NPC Weapons menu also has a Miscellaneous submenu with the supported
country and themed pools. Default weapon / No weapon there clears a random choice.
These selectors do not add proxy SWEPs or change the 240-weapon list. The server
selects the result and routes player requests through sandbox's give/spawn checks;
random selection does not bypass admin, permission or spawn-limit rules.

## Editing groups

`lua/mcv/shared/sh_random_weapons.lua` owns the definitions and filters. National
pools use the resolved weapon's `Country` field, combining historical labels such
as Russian Empire/Soviet Union and the German/Vietnamese variants. Inherited
metadata works for kitbashes. Russia uses the Soviet flag, including its WW2 pool.
WW2 Germany uses the black-white-red Imperial flag; the general German pool
uses the black-red-gold flag.

`alsoCountry(key, "class class ...")` adds explicit classes to a national pool
alongside the metadata match. Overlap is intentional: a weapon can represent
its design origin and a recognizable service/configuration association. Every
class still appears once within each pool and retains its normal `Country`
display text and stat category. Current additions:

| Pool | Additional weapons |
| --- | --- |
| British | Base L1A1, Hi-Power |
| Australian | Bren, Hi-Power |
| Belgian | L1A1, L1A1 SASR, L2A1, Baby Browning, Auto 5 |
| Czechoslovak | CZ 52, vz. 24, both vz. 54 configurations, vz. 59, Bren |
| German | G3, H&R T223 |
| Russian | Nagant M1895 |
| French | Ruby, MAT-49K |
| US | M/45 SOG, both RPD SOG configurations |

These are curated gameplay pools, not exclusive manufacturing-country labels.
For example, the [Australian War Memorial's L1A1 record](https://www.awm.gov.au/collection/REL35170)
connects the Australian rifle to the British SLR and Belgian FAL. Hi-Power service
is recorded by the [National Army Museum](https://collection.nam.ac.uk/detail.php?acc=1985-02-83-1)
and [Australian War Memorial](https://www.awm.gov.au/collection/C1207385).
The Czech Military History Institute documents the
[vz. 24](https://vhu.cz/exhibit/vyukovy-obraz-pusky-vz-24/),
[CZ 52](https://www.vhu.cz/exhibit/762mm-pistole-vz-52/) and
[vz. 59](https://vhu.cz/en/univerzalni-kulomet-vz-59/).

WW2 pools are explicit lists of period weapon configurations for the US, Russia,
Germany, Britain, France and Japan. Modern derivatives and SOG conversions are
excluded except the wartime suppressed Sten variant. Edit the `theme(...)` lists
to change membership; entries use the class without the `mcv_` prefix. The
homemade pool contains the six homemade weapon/grenade classes, not every
Vietnamese weapon. Each eligible class has an equal chance, including variants.

`GetRandomWeaponChoices(key, player, npcOnly)` resolves a pool. `GetRandomWeaponGroups`
also returns player/NPC counts and omits empty groups. Nonspawnable and disallowed
admin weapons are excluded; NPC results additionally require `NPCUsable`.
There is no new convar. The NPC choice uses sandbox's existing `gmod_npcweapon`.

## Rebuilding icons

From the addon folder:

```powershell
python work/build_random_weapon_icons.py
```

Requires Python, Pillow and CairoSVG plus Windows' Segoe UI Bold font. The white
question mark is shared by category and unflagged selectors. National selectors
add a small flag badge. All 25 current PNGs are under `materials/mcv/random/`.
SVG sources are cached here; subsequent builds work offline. Sources and hashes
are recorded in `manifest.json`.

All flags have square corners and identical 128x88 badge dimensions/placement,
matching the flat historical artwork. The modern SVGs use flag-icons v7.5.0
(Panayiotis Lipiridis and contributors, MIT). Soviet, Rhodesian, Yugoslav and
Imperial German flags use public-domain Wikimedia Commons artwork. Attribution
and licenses are retained in `licenses/mcv_random_flags/`; the manifest links
every source. SVGs are rasterized, resized to the shared badge dimensions, then
combined with the question mark. Modern sources have their own versioned cache
directory to prevent reuse of old Twemoji files. The old cache/license and
earlier screenshots remain as historical build evidence.

## Validation / loading

`work/tests/random_weapons.txt` drives a disposable multiplayer harness session
on port 27018. It checks all pool counts/members, actual category/country/WW2
clicks, the NPC context-menu action, explicit NPC overrides, invalid selectors,
and sandbox give/pickup denial hooks. Results and menu screenshots are copied
beside this file. NPC pools currently cover 201 supported classes.

The follow-up `work/tests/random_countries.txt` checks all overlapping pool
memberships, no duplicates, matching NPC subsets, preservation of the L1A1's
Australian label, exclusion of that modern rifle from British WW2, and the
Imperial/Soviet flag selections. It also opens the live menu and spawns an NPC
from the British pool. Current evidence: `random_flat_countries.png`,
`random_flat_ww2.png`, `random_countries_93628848.json`, `flat_groups.json`,
`flat_npc.json`, and `preview.png`. Earlier menu screenshots show the old style.

Change maps to load the Lua/menu changes. Restart GMod if it already cached an
older PNG; these selectors do not require any model recompilation.

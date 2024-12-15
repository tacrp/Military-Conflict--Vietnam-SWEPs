All oddities, visual bugs and WIP elements that need addressing
(updated Dec. 12th, 2024)

- Pack is still dependent on ARC9/ArcCW/TacRP for muzzleflashes. ARC9 dependency for RT scope textures.

- Certain animations (especially sprint and ADS transitions) are affected by lack of IK chains. Unlikely to be fixed unless a breakthrough is made.

- Revolver firemodes are in the incorrect order and switch animations are buggy-looking. Right now it is single-double-fan when in MCV it is single-fan-double.

- Dual-wielded weapons' ironsight positions do not line up when configured correctly for single-wield. Perhaps implement a separate akimbo iron position.

- Dual-wielded revolvers have no reload animation when in double-action.

- M16A1 M203 and AKM GP25 have noticably disconnected hands when the underbarrel weapon is active. IK chain issue.

- Ithaca 37 and M1897 Trench Gun lack slam-fire.

- Sterling's animations are completely ruined by lack of IK chains.

- Certain manual-action weapons do not have proper shell ejection delay.

- M79 lacks its ammo switching feature.

- PTRD-41 can be aimed when not deployed.

- PTRD-41 idle jitters (likely due to not using "frame 1 1" in the QC)

- M14, XM21, M2 Carbine, VZ58, MAS-49 bolts visibly close then reopen on empty reloads.
NOTE: Please do not resort to using "snap" to fix this. "snap" should only be used on firing anims because it causes issues with weapons snapping directly to their sprint/ADS poses and vice versa when used on idles and reloads.

- Shanxi Type 17 + Hezipao lack their empty reload start animation.

- RPK and TUL-1 bolts move too slowly when firing while deployed.

- Some weapons have walk animations in ADS and others don't. Recommend all weapons dont play their walk animations in ADS for the sake of gameplay.
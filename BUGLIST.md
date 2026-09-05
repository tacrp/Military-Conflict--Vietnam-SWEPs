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

## Reported Sep 5 2026 (after the Crowbar 0.74 recompile, shader scopes and equipment)

- [ ] China Lake pump animation glitches: gun position leaves the hands (same for the M870)
- [ ] M1897 and Ithaca 37 can fire full-auto
- [ ] Kolos rockets are missing textures
- [x] Crosshair sway should be off in mid-air
- [ ] Scoped weapons: while the shader lens is not drawn (not aiming) the rear lens is invisible
- [x] Scope reticle should be drawn at the aim point, not sway with the weapon model
- [x] Scope shadow stays on the eyepiece (moves with the gun); only the reticle follows the aim point (`ScopePupilSlide = 0`)
- [x] Welrod and the 3-round Vietcong pistol are not bolt-action; bolt-action guns must be consistently bolt-action. Bolt/pump guns now all run FireRate 600: the cycle animation is the delay (the scripts' 40-100 RPM added a dead wait on top of the bolt)
- [ ] Dual single-action revolvers: hammers forward when they should be back; empty reload invisible and skipped; double-action uses the sighted shoot animation when unsighted
- [ ] Zooming in should reduce the view FOV so the scope picture is not as blurry
- [ ] Guns use the default GMod tracers instead of the custom ones; silenced weapons need invisible tracers
- [ ] Crossbow has a muzzle flash and no firing entity (both fixed: no flash, bolt gets a sphere physics shell since the model has no .phy); its string reverts to drawn back after firing empty (open)
- [x] Grenades can be thrown before the pin-pull animation finishes
- [ ] Dual pistols (semi-autos too): hammer problems; the akimbo pose-based animations are missing (Lua fields)
- [~] Sighted walking sway: should be a little, not zero (AVT-40 zero) and not full (M2 carbine full). The sighted walk now sits at `SightedMovementFraction` (0.55) of each model's walk speed; needs a look in game
- [x] PTRD cannot bash without the bipod and should not bash while bipodded. Moving or jumping folds the bipod.
- [ ] Bipod accuracy should work
- [x] Lit dynamite needs its effect on the entity and the fuse sound, on the fuze attachment (the game ships no dynamite-specific fuse sound; the C4 fuse loop is used)
- [x] Trip mine ropes should use cable/cable2
- [ ] Flamethrowers can fire while sprinting
- [x] Replace Ignite() with the M202-style fire damage method (`lua/mcv/shared/sh_burn.lua`: MCV.Burn ticks DMG_BURN with the game's burning_character particle; incendiary grenades make a short fire pool)
- [x] Smoke grenades should stop emitting and fade out, not vanish
- [ ] Pistol hammers wrong on many pistols including the Type 67
- [x] Flare gun flares should carry their effect, not just a light (env_flare_us_trail / env_flare_trail and the ground effects)
- [ ] StG-44 ZF-4 scope is off-centre
- [ ] Gyrojets have no empty-reload-in animation
- [ ] Medkit does not animate back in after the self-heal out animation; medkits should heal via touch (wide hull trigger)
- [ ] Ammo box only resupplies ammo boxes
- [ ] Binoculars use full sensitivity and should use the game's overlay
- [x] Flamethrowers aim left while walking (animation), fine when sighted (movement pose mapping, above)
- [ ] Vz.24: no empty reload start/finish animation; partial reload bolt position wrong
- [ ] M72 LAW: when deployed empty it should auto-reload with the full first-deploy animation instead of the throw-away-and-new-tube reload
- [x] Grenades should cook: fuse runs from the pin pull, so they explode sooner after the throw or in the hand when overcooked (force throw then instant detonation); crosshair pulses every half second while cooking; gas grenades lack GetPopped() (BaseClass recursion in the smoke grenade's SetupDataTables)
- [x] WP grenade fire should not linger; a very short post-effect like the M202's (3 s fire pool)

## Reported Sep 6 2026

- [x] LMGs (and the flamethrower) point left while walking: the walk drove `player_movement` into the model's run layer (Lua walked at 100, the M60 run layer starts at 106, the LPO-50 at 80). Mapped onto each model's run layer range (`MovementPoseWalk/Sprint`)
- [x] New LMGs never deplete their belt; mag replacement time now comes from the reload animation's `AE_CL_BODYGROUP_SET_TO_NEXTCLIP` event (`MagInTime`, `MagOutTime` and the empty pair, all guns)
- [x] Mk 22 lacks its silencer and reloads silently; it should share the M39's setup. The script name resolver folded weapon_mk22 (the M39) onto the Mk 22's lua and left the old hand-port `mcv_sw39.lua` (MLE 1935 world model) untouched; aliased mk22 -> sw39, both regenerated, the Mod 0 gets bodygroup 1 (silencer). The reload foley events do play (probe: magout / magin wavs heard)
- [x] Montagnard crossbow SubCategory "Bows" instead of "Rifle"

All oddities, visual bugs and WIP elements that need addressing
(updated Dec. 12th, 2024)

- Pack is still dependent on ARC9/ArcCW/TacRP for muzzleflashes. ARC9 dependency for RT scope textures.

- ~~Certain animations (especially sprint and ADS transitions) are affected by lack of IK chains. Unlikely to be fixed unless a breakthrough is made.~~ (Sep 6 2026: the IK touch rules are baked into the animations by the port, `work/bake_ik.py`)

- ~~Revolver firemodes are in the incorrect order and switch animations are buggy-looking. Right now it is single-double-fan when in MCV it is single-fan-double.~~ (Sep 6 2026: single-fan-double, each switch plays the animation for its target mode)

- ~~Dual-wielded weapons' ironsight positions do not line up when configured correctly for single-wield. Perhaps implement a separate akimbo iron position.~~ (Sep 6 2026: `IronsightPosAkimbo` / `IronsightAngAkimbo` from the weapon_dual_* scripts where they differ, 11 guns)

- ~~Dual-wielded revolvers have no reload animation when in double-action.~~ (Sep 6 2026: the dual reload falls back to the plain reload when the model lacks the empty variant)

- M16A1 M203 and AKM GP25 have noticably disconnected hands when the underbarrel weapon is active. IK chain issue. (Sep 6 2026: the IK bake covers animations with touch rules; check these after the recompile)

- ~~Ithaca 37 and M1897 Trench Gun lack slam-fire.~~ (Sep 6 2026: `SlamFire`)

- ~~Sterling's animations are completely ruined by lack of IK chains.~~ (Sep 6 2026: IK baked)

- Certain manual-action weapons do not have proper shell ejection delay.

- M79 lacks its ammo switching feature.

- ~~PTRD-41 can be aimed when not deployed.~~ (fixed Sep 6 2026)

- PTRD-41 idle jitters (likely due to not using "frame 1 1" in the QC)

- ~~M14, XM21, M2 Carbine, VZ58, MAS-49 bolts visibly close then reopen on empty reloads.~~ (Sep 6 2026: the `empty` pose drops at the mag-in event instead of the end of the reload)
NOTE: Please do not resort to using "snap" to fix this. "snap" should only be used on firing anims because it causes issues with weapons snapping directly to their sprint/ADS poses and vice versa when used on idles and reloads.

- ~~Shanxi Type 17 + Hezipao lack their empty reload start animation.~~ (Sep 6 2026: `ShotgunReloadEmptyStartAnimation`, and the start is locked so the first insert no longer cuts it off)

- ~~RPK and TUL-1 bolts move too slowly when firing while deployed.~~ (Sep 6 2026: deployed shot bases scaled to the pose; RPK, TUL-1, M60, DP-28, RP-46, BAR, L2A1, M14E2, M1919, Stoner recompiled)

- Some weapons have walk animations in ADS and others don't. Recommend all weapons dont play their walk animations in ADS for the sake of gameplay.

## Reported Sep 5 2026 (after the Crowbar 0.74 recompile, shader scopes and equipment)

- [x] China Lake pump animation glitches: gun position leaves the hands (same for the M870, and the M1897 / M37 did it too). The 2024 hand-edited pump animations do not fit the new rig; the game's own pump deltas are used (overrides parked in `work/MCV_SMD/disabled_pump_overrides/`)
- [x] M1897 and Ithaca 37 can fire full-auto (hammer event polarity per model; they slam fire deliberately now)
- [x] Kolos rockets are missing textures (materials copied to the paths the as-is game models ask for)
- [x] Crosshair sway should be off in mid-air
- [x] Scoped weapons: while the shader lens is not drawn (not aiming) the rear lens is invisible (glass VMTs opaque)
- [x] Scope reticle should be drawn at the aim point, not sway with the weapon model
- [x] Scope shadow stays on the eyepiece (moves with the gun); only the reticle follows the aim point (`ScopePupilSlide = 0`)
- [x] Welrod and the 3-round Vietcong pistol are not bolt-action; bolt-action guns must be consistently bolt-action. Bolt/pump guns now all run FireRate 600: the cycle animation is the delay (the scripts' 40-100 RPM added a dead wait on top of the bolt)
- [x] Dual single-action revolvers: empty reload invisible and skipped (no dual empty reload animation: falls back to the reload); double-action used the sighted shoot animation when unsighted (2x3 blend grid compiled 2 wide; revolvers recompiled). Hammer state: the game itself keeps the hammer down in hammer mode and cocks it in the shot; say which model looks wrong
- [x] Zooming in should reduce the view FOV so the scope picture is not as blurry (screen FOV tightens partway towards the scope FOV, `ScopeScreenZoom`)
- [x] Guns use the default GMod tracers instead of the custom ones; silenced weapons need invisible tracers
- [x] Crossbow has a muzzle flash and no firing entity (no flash, bolt gets a sphere physics shell since the model has no .phy); its string reverted to drawn back after firing empty because the reload's mag-in time was 0 (now 1.87 s from the animation's ammo event)
- [x] Grenades can be thrown before the pin-pull animation finishes
- [x] Dual pistols (semi-autos too): the akimbo pose-based animations are missing (`AkimboPoseRecoil` / `AkimboRecoilTime` now generated for every dual model with the recoil layers). Hammer problems: needs a named pistol
- [~] Sighted walking sway: should be a little, not zero (AVT-40 zero) and not full (M2 carbine full). The walk pose is back to the hand port's (100, times 0.75 when aiming), capped under each model's run layer; the per-model difference is in the models' walk layers (the SVT-40 family's walk peaks at pose 55 and is idle again by 110, the M2 carbine's peaks at 147)
- [x] PTRD cannot bash without the bipod and should not bash while bipodded. Moving or jumping folds the bipod.
- [x] Bipod accuracy should work (SpreadBipod / SpreadBipodIronsighted from the scripts)
- [x] Lit dynamite needs its effect on the entity and the fuse sound, on the fuze attachment (the game ships no dynamite-specific fuse sound; the C4 fuse loop is used)
- [x] Trip mine ropes should use cable/cable2
- [x] Flamethrowers can fire while sprinting
- [x] Replace Ignite() with the M202-style fire damage method (`lua/mcv/shared/sh_burn.lua`: MCV.Burn ticks DMG_BURN with the game's burning_character particle; incendiary grenades make a short fire pool)
- [x] Smoke grenades should stop emitting and fade out, not vanish
- [~] Pistol hammers wrong on many pistols including the Type 67. The Type 67 is a manually cycled silenced pistol in the game (boltpull after every shot, hammerpos 1 on the shot and 0 on the pull): now bolt-action like the Welrod with the hammer polarity inverted. Other pistols: the hammer lives in the animations; needs a named model
- [x] Flare gun flares should carry their effect, not just a light (env_flare_us_trail / env_flare_trail and the ground effects)
- [x] StG-44 ZF-4 scope is off-centre (the muzzle attachment's fixed tilt is filtered out of the scope axis)
- [x] Gyrojets have no empty-reload-in animation: the empty start (ACT_VM_RELOAD_INSERT_EMPTY) was played unlocked and cut off by the first insert; the empty reload now ends with the chambering animation (reload_endpump)
- [x] Medkit does not animate back in after the self-heal out animation (draw animation plays after it); dropped boxes serve anyone within 48 units
- [x] Ammo box only resupplies ammo boxes: it refilled itself, and a fresh gun (M16: 320 in reserve) was over the six-magazine cap so got nothing; boxes skip boxes and the cap is the gun's spawn ammo
- [x] Binoculars use full sensitivity and should use the game's overlay (`effects/screen_overlay_binoculars_01`; zoom levels are magnifications now)
- [x] Flamethrowers aim left while walking (animation), fine when sighted (movement pose mapping, above)
- [x] Vz.24: no empty reload start/finish animation; partial reload bolt position wrong. Clip-fed bolt rifles reload with the clip (reload / reload_empty) like the Kar98; the generator no longer puts them on the shell path (Vz.24, Kar98 silenced, Springfield silenced)
- [x] M72 LAW: when deployed empty it should auto-reload with the full first-deploy animation instead of the throw-away-and-new-tube reload
- [x] Grenades should cook: fuse runs from the pin pull, so they explode sooner after the throw or in the hand when overcooked (force throw then instant detonation); crosshair pulses every half second while cooking; gas grenades lack GetPopped() (BaseClass recursion in the smoke grenade's SetupDataTables)
- [x] WP grenade fire should not linger; a very short post-effect like the M202's (3 s fire pool)

## Reported Sep 6 2026

- [x] LMGs (and the flamethrower) point left while walking: the walk drove `player_movement` into the model's run layer (Lua walked at 100, the M60 run layer starts at 106, the LPO-50 at 80). Mapped onto each model's run layer range (`MovementPoseWalk/Sprint`)
- [x] New LMGs never deplete their belt; mag replacement time now comes from the reload animation's `AE_CL_BODYGROUP_SET_TO_NEXTCLIP` event (`MagInTime`, `MagOutTime` and the empty pair, all guns)
- [x] Mk 22 lacks its silencer and reloads silently; it should share the M39's setup. The script name resolver folded weapon_mk22 (the M39) onto the Mk 22's lua and left the old hand-port `mcv_sw39.lua` (MLE 1935 world model) untouched; aliased mk22 -> sw39, both regenerated, the Mod 0 gets bodygroup 1 (silencer). The reload foley events do play (probe: magout / magin wavs heard)
- [x] Montagnard crossbow SubCategory "Bows" instead of "Rifle"
- [x] Vz.54 (and M14L, MAS-36, Vz.24) rifle grenade had no sound: the generator guessed `MCV_Weapon_<GUN>.RifleGrenade`; the game plays another rifle's grenade shot for these (their script's single_shot)
- [x] Dual double-action revolvers played the shot animation on the pull: the pull now cocks the hammer of the hand that is up (prepare_delayed_right / _left), the shot plays on release
- [x] M9A1 flamethrower still walked into its sprint pose: its script has no viewmodel key, so the fixer never derived its run layer range (fallback to the lua's ViewModel; 80-160 like the LPO-50)
- [x] Dual Blackhawks look wrong when sprinting: the run layer moves only the root gun base bones and the game's IK dragged the hands along; the Blackhawk is the one dual whose gun meshes sit on those bones (the others' `Base` is a dummy). Override SMD holds them still; model recompiled
- [x] Scope reticle did not follow the view punch: it is drawn at the shot direction (aim angle including the punch) now; the lens paints black outside the captured frame instead of showing the border
- [x] Scope: reticle, shadow ring and black surround drawn on a plane centred on the shot's aim point (gun base GetAimVector, twice the punch); shadow no longer sits on the lens mesh
- [x] Hybrid reload back as a convar (`mcv_hybrid_reload`) on the stripper-clip rifles that have single-round animations
- [x] Both Sterlings had broken run animations: 2024 hand-edited run_a overrides on the new rig, retired like the pump ones (the M203's run_a override too); the three models recompiled
- [x] Tracers gone: the tracer was drawn from the client's FireBullets callback, which never runs in singleplayer. The server sends them now with the weapon's muzzle attachment as origin (viewmodel for the shooter), the `_smoke` trail on every round and the bright `_primary` every TracerFrequency-th; 16 luas still on the stock "tracer" name fixed (silenced ones: none)
- [x] Second weapon did not unlock dual wield: the engine calls EquipAmmo on the copy being picked up (then removes it) and the spawn menu never creates one; the carried weapon is flagged from PlayerCanPickupWeapon / PlayerGiveSWEP / EquipAmmo instead (`lua/mcv/server/sv_second_weapon.lua`). Availability icons under the ammo counter (mirrored, tilted 45 degrees) for dual wield and bayonet. Fists hints: Jab / Hook / Charge
- [x] OEG sights were black: the scope lens shader was applied to them and the single-point crosshair texture is opaque across the reticle plane; OEGs keep the model's own lens now. Scope shader: the lens-mesh rim is gone, the shadow ring and black surround are on the reticle plane only
- [~] Stoner 63 / belt LMGs: rounds vanished mid-reload (mag-out foley, fixed above) and the belt stayed when empty: the `clamped*` belt groups had no blank option; they get one (port_qc `step_belt_blank`) and hide with the last round. M60, M60 (bipod), MG43 (D), PK, PKM, RPD, Stoner 63 LMG, vz.59 recompiled; what exactly the M60's two clamped meshes are (the second is 9 MB) needs a look in game
- [~] Dual Blackhawk run: the rig now swings about its root (position and angle) following the guns' authored travel; needs a look after a restart
- [x] Sterling left hand off the magazine when sprinting, dual Blackhawk guns out of the hands: IK touch rules baked into every animation that has them (273 models), all viewmodels recompiled


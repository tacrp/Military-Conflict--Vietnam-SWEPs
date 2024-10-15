// Created by Crowbar 0.74

$modelname "weapons/mcv/v_mas49.mdl"

$bodygroup "studio"
{
	studio "ref_new.smd"
}
$bodygroup "bayonet"
{
	blank
	studio "v_bayonet_new.smd"
}
$bodygroup "mount"
{
	blank
	studio "mas49_mount.smd"
}
$bodygroup "grenade"
{
	blank
	studio "mas49_grenade.smd"
}
$bodygroup "scope"
{
	studio "mas49_scopes.smd"
	blank
}


$surfaceprop "default"

$contents "solid"

$illumposition -0.772 -24.254 -12.805

$cdmaterials "models\weapons\mcv\v_mas49\"
$cdmaterials "models\weapons\mcv\v_ak47_bayonet\"
$cdmaterials "models\weapons\mcv\shells\"
$cdmaterials "models\weapons\mcv\rif_gl\"
$cdmaterials "models\weapons\mcv\optics\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "Base" -24.3 0 1.65 rotate 0 180 0
$attachment "eject" "Base" 0.6 0 1.5 rotate -50 90 0

$cbox 0 0 0 0 0 0

$bbox -9.182 -12.177 -27.51 57.69 10.632 1.901

$definebone "root" "" 0 7.450089 -27.509027 0 0 0 0 0 0 0 0 0
$definebone "pelvis" "root" -0.000002 0 0 -89.790623 -89.997175 89.997175 0 0 0 0 0 0
$definebone "spine_01" "pelvis" 4.255466 -0.335183 -0.000002 0 -7.153262 0 0 0 0 0 0 0
$definebone "spine_02" "spine_01" 7.43125 1.496479 0.000002 0 14.063249 0 0 0 0 0 0 0
$definebone "spine_03" "spine_02" 5.278479 0.165544 0.000001 0 2.779475 0 0 0 0 0 0 0
$definebone "clavicle_r" "spine_03" 4.678655 -1.075638 1.488977 66.457884 -74.414959 113.208733 0 0 0 0 0 0
$definebone "upperarm_r" "clavicle_r" -6.214478 -0.000009 -0.000026 -39.361202 171.560801 166.195564 0 0 0 0 0 0
$definebone "lowerarm_r" "upperarm_r" 11.944885 0 0 -11.599014 34.295469 3.613484 0 0 0 0 0 0
$definebone "hand_r" "lowerarm_r" 10.620188 0 0 40.975077 158.047627 82.470989 0 0 0 0 0 0
$definebone "index_01_r" "hand_r" -4.751108 -0.694498 0.83058 -3.762675 25.538683 14.867227 0 0 0 0 0 0
$definebone "index_02_r" "index_01_r" -1.688068 0.000047 -0.000031 -0.475213 11.986115 1.337745 0 0 0 0 0 0
$definebone "index_03_r" "index_02_r" -1.33614 0.000055 -0.00001 0.996946 -9.496594 1.137554 0 0 0 0 0 0
$definebone "middle_01_r" "hand_r" -4.820494 -0.509464 -0.224759 -7.039535 22.827334 1.918093 0 0 0 0 0 0
$definebone "middle_02_r" "middle_01_r" -1.826984 -0.000069 0.000008 1.136744 12.280669 -2.025003 0 0 0 0 0 0
$definebone "middle_03_r" "middle_02_r" -1.436569 0.000004 0.000003 -4.389719 -15.399553 0.781576 0 0 0 0 0 0
$definebone "pinky_01_r" "hand_r" -3.992357 -0.891191 -1.827909 -18.932827 20.18743 -18.724426 0 0 0 0 0 0
$definebone "pinky_02_r" "pinky_01_r" -1.405918 -0.000025 -0.000002 -1.315574 11.208263 1.063867 0 0 0 0 0 0
$definebone "pinky_03_r" "pinky_02_r" -1.175358 0.000126 -0.000019 3.869406 1.038608 0.445644 0 0 0 0 0 0
$definebone "ring_01_r" "hand_r" -4.526751 -0.69058 -1.120741 -10.988246 23.293493 -13.509884 0 0 0 0 0 0
$definebone "ring_02_r" "ring_01_r" -1.744038 0.000032 -0.000008 -1.66989 13.315318 0.301259 0 0 0 0 0 0
$definebone "ring_03_r" "ring_02_r" -1.368771 0.000023 0.000002 2.987742 -12.899505 -0.360677 0 0 0 0 0 0
$definebone "thumb_01_r" "hand_r" -1.874796 -0.935125 0.999175 36.92026 27.057822 95.069526 0 0 0 0 0 0
$definebone "thumb_02_r" "thumb_01_r" -1.523447 0.000031 0.000031 9.832821 15.151525 1.613443 0 0 0 0 0 0
$definebone "thumb_03_r" "thumb_02_r" -1.599285 0.000011 0.000015 0.480713 -12.385745 2.414095 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" 5.51182 0.000008 -0.000002 -0.000423 179.999745 166.489945 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" 0.196846 -0.000002 0.000003 0.000359 -179.999117 160.050416 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 4.678655 -1.075635 -1.488978 66.457932 105.584814 113.208528 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.214486 0.000008 0.000019 39.360369 -8.439265 13.8045 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.944888 -0.000031 -0.0002 -11.598266 -34.295466 -3.613934 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620165 0.000002 0.000006 -40.973755 21.950705 -97.52808 0 0 0 0 0 0
$definebone "index_01_l" "hand_l" 4.751158 0.694374 -0.830474 -3.764682 25.536503 14.866772 0 0 0 0 0 0
$definebone "index_02_l" "index_01_l" 1.688065 -0.000022 0.000002 -0.475157 11.986512 1.337913 0 0 0 0 0 0
$definebone "index_03_l" "index_02_l" 1.336151 -0.000051 -0.000009 -1.907894 -9.554295 1.137835 0 0 0 0 0 0
$definebone "middle_01_l" "hand_l" 4.820515 0.509338 0.224866 -7.040164 22.8259 1.917695 0 0 0 0 0 0
$definebone "middle_02_l" "middle_01_l" 1.826992 0.000066 0.00001 1.136743 12.280665 -2.025001 0 0 0 0 0 0
$definebone "middle_03_l" "middle_02_l" 1.436581 -0.000006 0.00001 -0.387838 -15.345009 0.779228 0 0 0 0 0 0
$definebone "pinky_01_l" "hand_l" 3.992353 0.891087 1.827993 -18.934246 20.186228 -18.724943 0 0 0 0 0 0
$definebone "pinky_02_l" "pinky_01_l" 1.405926 0.000031 -0.000003 -1.315972 11.208145 1.063927 0 0 0 0 0 0
$definebone "pinky_03_l" "pinky_02_l" 1.175362 -0.000132 0.000001 7.050414 1.063467 0.448053 0 0 0 0 0 0
$definebone "ring_01_l" "hand_l" 4.526758 0.690464 1.120843 -10.989675 23.292055 -13.510282 0 0 0 0 0 0
$definebone "ring_02_l" "ring_01_l" 1.744041 -0.000031 -0.000002 -1.670173 13.315707 0.301554 0 0 0 0 0 0
$definebone "ring_03_l" "ring_02_l" 1.368767 -0.000031 -0.000018 9.085959 -12.938534 -0.365195 0 0 0 0 0 0
$definebone "thumb_01_l" "hand_l" 1.874857 0.935081 -0.999129 36.919095 27.057076 95.069581 0 0 0 0 0 0
$definebone "thumb_02_l" "thumb_01_l" 1.523453 -0.000032 -0.000002 9.832704 15.151419 1.612756 0 0 0 0 0 0
$definebone "thumb_03_l" "thumb_02_l" 1.599281 -0.000004 0.00001 4.129713 -12.231671 2.421142 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511806 -0.000002 0.000003 0.000292 0.000412 -13.510177 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.196849 0.000003 -0.000001 0.000862 -0.000112 -19.951824 0 0 0 0 0 0
$definebone "cam_driver" "" 0 0 0 0 -89.999982 0 0 0 0 0 0 0
$definebone "Base" "" -3.508908 -17.270517 -4.156531 0 89.999989 0 0 0 0 0 0 0
$definebone "Mag" "Base" -0.278561 -0.114805 0.03114 0 0 0 0 0 0 0 0 0
$definebone "Bullet" "Mag" 0.136045 0.055828 0.228212 0 0 0 0 0 0 0 0 0
$definebone "BulletMove" "Bullet" -0.193987 0.354528 0.273637 0 0 0 0 0 0 0 0 0
$definebone "MagRelease" "Mag" -0.056988 1.191641 -0.93928 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" 4.809457 -0.126625 -0.344739 0 0 0 0 0 0 0 0 0
$definebone "Bolt" "Base" -3.432674 0.242668 1.890474 0 0 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 12.664053 7.635776 -1.366428 0 0 0 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" 12.664049 -4.564517 -1.366428 0 0 0 0 0 0 0 0 0
$definebone "Bayonet" "Base" -26.714825 0.152467 0.294368 0 0 0 0 0 0 0 0 0
$definebone "Grenade" "Base" -30.342335 0.149004 1.675955 0 0 0 0 0 0 0 0 0

$bonemerge "root"
$bonemerge "pelvis"
$bonemerge "spine_01"
$bonemerge "spine_02"
$bonemerge "spine_03"
$bonemerge "clavicle_r"
$bonemerge "upperarm_r"
$bonemerge "lowerarm_r"
$bonemerge "hand_r"
$bonemerge "index_01_r"
$bonemerge "index_02_r"
$bonemerge "index_03_r"
$bonemerge "middle_01_r"
$bonemerge "middle_02_r"
$bonemerge "middle_03_r"
$bonemerge "pinky_01_r"
$bonemerge "pinky_02_r"
$bonemerge "pinky_03_r"
$bonemerge "ring_01_r"
$bonemerge "ring_02_r"
$bonemerge "ring_03_r"
$bonemerge "thumb_01_r"
$bonemerge "thumb_02_r"
$bonemerge "thumb_03_r"
$bonemerge "lowerarm_twist_01_r"
$bonemerge "upperarm_twist_01_r"
$bonemerge "clavicle_l"
$bonemerge "upperarm_l"
$bonemerge "lowerarm_l"
$bonemerge "hand_l"
$bonemerge "index_01_l"
$bonemerge "index_02_l"
$bonemerge "index_03_l"
$bonemerge "middle_01_l"
$bonemerge "middle_02_l"
$bonemerge "middle_03_l"
$bonemerge "pinky_01_l"
$bonemerge "pinky_02_l"
$bonemerge "pinky_03_l"
$bonemerge "ring_01_l"
$bonemerge "ring_02_l"
$bonemerge "ring_03_l"
$bonemerge "thumb_01_l"
$bonemerge "thumb_02_l"
$bonemerge "thumb_03_l"
$bonemerge "lowerarm_twist_01_l"
$bonemerge "upperarm_twist_01_l"
$bonemerge "Base"
$bonemerge "rhand_ikTarget"
$bonemerge "lhand_ikTarget"

$include "../../militaryconflict_vietnam_v2.qci"


$sectionframes 30 30

$poseparameter "ammo_fraction" 0 0.05 loop 0
$poseparameter "player_movement" 0 295 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "Slideback_corrective_animation" "v_mas49_anims\Slideback_corrective_animation.smd" {
}

$animation "Default_corrective_animation" "v_mas49_anims\Default_corrective_animation.smd" {
}

$animation "runIdle_a_corrective_animation" "v_mas49_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_mas49_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_mas49_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_mas49_anims\walk_a_corrective_animation.smd" {
}

$animation "boltShootNoMovementA_corrective_animation" "v_mas49_anims\boltShootNoMovementA_corrective_animation.smd" {
}

$animation "boltShootMovementA_corrective_animation" "v_mas49_anims\boltShootMovementA_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_mas49_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_mas49_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_a_corrective_animation" "v_mas49_anims\shoot2_a_corrective_animation.smd" {
}

$animation "shoot2_ironsight_a_corrective_animation" "v_mas49_anims\shoot2_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3_a_corrective_animation" "v_mas49_anims\shoot3_a_corrective_animation.smd" {
}

$animation "shoot3_ironsight_a_corrective_animation" "v_mas49_anims\shoot3_ironsight_a_corrective_animation.smd" {
}

$animation "gren_shoot1_a_corrective_animation" "v_mas49_anims\gren_shoot1_a_corrective_animation.smd" {
}

$animation "gren_shoot1_ironsight_a_corrective_animation" "v_mas49_anims\gren_shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "PoseDelta" "v_mas49_anims\PoseDelta.smd" {
	fps 30
	
	
}

$animation "Default" "v_mas49_anims\Default.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Default_corrective_animation" 0
}

$animation "Slideback" "v_mas49_anims\Slideback.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Slideback_corrective_animation" 0
}

$animation "basePose_a" "v_mas49_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "ironsight" "v_mas49_anims\ironsight.smd" {
	fps 0.5
	
	
}

$animation "ironsight_transition" "v_mas49_anims\ironsight_transition.smd" {
	fps 0.5
	
	
}

$animation "runIdle_a" "v_mas49_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_mas49_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_mas49_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_mas49_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "boltShootMovementA" "v_mas49_anims\boltShootMovementA.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "boltShootMovementA_corrective_animation" 0
}

$animation "boltShootNoMovementA" "v_mas49_anims\boltShootNoMovementA.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "boltShootNoMovementA_corrective_animation" 0
}

$animation "shoot1_a" "v_mas49_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_mas49_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "shoot2_a" "v_mas49_anims\shoot2_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_a_corrective_animation" 0
}

$animation "shoot2_ironsight_a" "v_mas49_anims\shoot2_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_ironsight_a_corrective_animation" 0
}

$animation "shoot3_a" "v_mas49_anims\shoot3_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_a_corrective_animation" 0
}

$animation "shoot3_ironsight_a" "v_mas49_anims\shoot3_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_ironsight_a_corrective_animation" 0
}

$animation "nearwall_start" "v_mas49_anims\nearwall_start.smd" {
	fps 30
	
	
}

$animation "nearwall_start_i" "v_mas49_anims\nearwall_start_i.smd" {
	fps 30
	
	
}

$animation "nearwall_loop" "v_mas49_anims\nearwall_loop.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_loop_i" "v_mas49_anims\nearwall_loop_i.smd" {
	fps 30
	
	
}

$animation "nearwall_end" "v_mas49_anims\nearwall_end.smd" {
	fps 30
	
	
}

$animation "nearwall_end_i" "v_mas49_anims\nearwall_end_i.smd" {
	fps 30
	
	
}

$animation "proneF" "v_mas49_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_mas49_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_mas49_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_mas49_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_start" "v_mas49_anims\pickup_start.smd" {
	fps 30
	
	
}

$animation "pickup_start_i" "v_mas49_anims\pickup_start_i.smd" {
	fps 30
	
	
}

$animation "pickup_loop" "v_mas49_anims\pickup_loop.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_loop_i" "v_mas49_anims\pickup_loop_i.smd" {
	fps 30
	
	
}

$animation "pickup_end" "v_mas49_anims\pickup_end.smd" {
	fps 30
	
	
}

$animation "pickup_end_i" "v_mas49_anims\pickup_end_i.smd" {
	fps 30
	
	
}

$animation "bayonet_unequip_a" "v_mas49_anims\bayonet_unequip_a.smd" {
	fps 30
	
	
}

$animation "bayonet_unequip_a_i" "v_mas49_anims\bayonet_unequip_a_i.smd" {
	fps 30
	
	
}

$animation "bayonet_equip_a" "v_mas49_anims\bayonet_equip_a.smd" {
	fps 30
	
	
}

$animation "bayonet_equip_a_i" "v_mas49_anims\bayonet_equip_a_i.smd" {
	fps 30
	
	
}

$animation "bayonet_bash_a" "v_mas49_anims\bayonet_bash_a.smd" {
	fps 30
	
	
}

$animation "bayonet_bash_a_i" "v_mas49_anims\bayonet_bash_a_i.smd" {
	fps 30
	
	
}

$animation "grenade_ironsight" "v_mas49_anims\grenade_ironsight.smd" {
	fps 0.5
	
	
}

$animation "gren_shoot1_a" "v_mas49_anims\gren_shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "gren_shoot1_a_corrective_animation" 0
}

$animation "gren_shoot1_ironsight_a" "v_mas49_anims\gren_shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "gren_shoot1_ironsight_a_corrective_animation" 0
}

$animation "gren_reload_a" "v_mas49_anims\gren_reload_a.smd" {
	fps 30
	
	
}

$animation "gren_reload_a_i" "v_mas49_anims\gren_reload_a_i.smd" {
	fps 30
	
	
}

$animation "scope_adjust_idle" "v_mas49_anims\scope_adjust_idle.smd" {
	fps 30
	
	
}

$animation "scope_adjust_iron" "v_mas49_anims\scope_adjust_iron.smd" {
	fps 30
	
	
}

$animation "ChargeStart_a" "v_mas49_anims\ChargeStart_a.smd" {
	fps 30
	
	
}

$animation "ChargeStart_a_i" "v_mas49_anims\ChargeStart_a_i.smd" {
	fps 30
	
	
}

$animation "ChargeLoop_a" "v_mas49_anims\ChargeLoop_a.smd" {
	fps 30
	loop
	
	
}

$animation "ChargeLoop_a_i" "v_mas49_anims\ChargeLoop_a_i.smd" {
	fps 30
	
	
}

$animation "ChargeEnd_a" "v_mas49_anims\ChargeEnd_a.smd" {
	fps 30
	
	
}

$animation "ChargeEnd_a_i" "v_mas49_anims\ChargeEnd_a_i.smd" {
	fps 30
	
	
}

$sequence "SlidePosition" {
	"Slideback"
	"Default"
	blend "ammo_fraction" 0 0.05
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
	hidden
	node "0"
}

$sequence "runlayer" {
	"runIdle_a"
	"run_a"
	blend "player_movement" 147 245
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
}

$sequence "walklayer" {
	"walkIdle_a"
	"walk_a"
	"walkIdle_a"
	blend "player_movement" 0 295
	blendwidth 3
	delta
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
}

$sequence "walklayerironsight" {
	"walkIdle_a"
	"walk_a"
	blend "player_movement" 0 130
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
}

$sequence "ironsight_test" {
	"ironsight"
	fadein 0.2
	fadeout 0.2
	hidden
	addlayer "walklayerironsight"
}

$sequence "idle" {
	"basePose_a"
	"ironsight_transition"
	activity "ACT_VM_IDLE" 1
	blend "ironsight" 0 0.5
	blendwidth 2
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	blendlayer "ironsight_test" 0 0 1 0 poseparameter ironsight
	addlayer "SlidePosition"
	node "0"
}

$sequence "FirstDraw" {
	"v_mas49_anims\FirstDraw.smd"
	"v_mas49_anims\FirstDraw_2.smd"
	activity "ACT_VM_READY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_MAS49.Draw" }
	{ event 5004 9 "MCV_Weapon_Foley_MAS49.DrawMetal" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$sequence "draw" {
	"v_mas49_anims\draw.smd"
	"v_mas49_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_MAS49.Draw" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "SlidePosition"
	fps 30
	
	
}

$sequence "BoltshootMovement" {
	"boltShootNoMovementA"
	"boltShootMovementA"
	blend "ammo_fraction" 0 0.05
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
	node "0"
}

$sequence "shoot1" {
	"shoot1_a"
	"shoot1_ironsight_a"
	activity "ACT_VM_PRIMARYATTACK" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	{ event AE_MUZZLEFLASH 0 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 0 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	addlayer "BoltshootMovement"
	node "Fire"
}

$sequence "shoot2" {
	"shoot2_a"
	"shoot2_ironsight_a"
	activity "ACT_VM_PRIMARYATTACK" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	{ event AE_MUZZLEFLASH 0 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 0 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	addlayer "BoltshootMovement"
	node "Fire"
}

$sequence "shoot3" {
	"shoot3_a"
	"shoot3_ironsight_a"
	activity "ACT_VM_PRIMARYATTACK" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	{ event AE_MUZZLEFLASH 0 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 0 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	addlayer "BoltshootMovement"
	node "Fire"
}

$sequence "reload" {
	"v_mas49_anims\reload.smd"
	"v_mas49_anims\reload_2.smd"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_MAS49_Reload.Hand" }
	{ event 5004 20 "MCV_Weapon_Foley_MAS49_Reload.MagOut" }
	{ event 5004 52 "MCV_Weapon_Foley_MAS49_Reload.MagIn" }
	{ event 5004 65 "MCV_Weapon_Foley_MAS49_Reload.HandEnd" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 33 "ammo_fraction" }
	{ event AE_WPN_COMPLETE_RELOAD 53 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "reload_empty" {
	"v_mas49_anims\reload_empty.smd"
	"v_mas49_anims\reload_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_MAS49_Reload.Hand" }
	{ event 5004 20 "MCV_Weapon_Foley_MAS49_Reload.MagOut" }
	{ event 5004 52 "MCV_Weapon_Foley_MAS49_Reload.MagIn" }
	{ event 5004 77 "MCV_Weapon_Foley_MAS49_Reload.Metal" }
	{ event 5004 90 "MCV_Weapon_Foley_MAS49_Reload.HandEnd" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 33 "ammo_fraction" }
	{ event AE_WPN_COMPLETE_RELOAD 82 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "idletonearwall" {
	"nearwall_start"
	"nearwall_start_i"
	activity "ACT_VM_IDLE_TO_LOWERED" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Nearwall.In" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "SlidePosition"
	node "0"
}

$sequence "nearwall" {
	"nearwall_loop"
	"nearwall_loop_i"
	activity "ACT_VM_IDLE_LOWERED" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "SlidePosition"
	node "0"
}

$sequence "nearwalltoidle" {
	"nearwall_end"
	"nearwall_end_i"
	activity "ACT_VM_LOWERED_TO_IDLE" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Nearwall.Out" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "SlidePosition"
	node "0"
}

$sequence "prone" {
	"proneF"
	"proneL"
	"proneB"
	"proneR"
	"proneF"
	activity "ACT_VM_CRAWL" 1
	blend "move_yaw" -180 180
	blendwidth 5
	{ event 5004 1 "MCV_Weapon_Foley_Movement.ProneCrawl" }
	{ event 5004 10 "MCV_Weapon_Foley_Movement.ProneCrawl_GunMedium" }
	fadein 0.3
	fadeout 0.3
	addlayer "SlidePosition"
	realtime
}

$sequence "bash" {
	"v_mas49_anims\bash.smd"
	"v_mas49_anims\bash_2.smd"
	activity "ACT_VM_HITCENTER" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 3200 3 "" }
	{ event 5004 1 "MCV_Weapon_Foley_Bash.Fast" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	addlayer "SlidePosition"
	node "0"
	fps 30
	
	
}

$sequence "pickupstart" {
	"pickup_start"
	"pickup_start_i"
	activity "ACT_VM_PICKUPSTART" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Pickup.In" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "SlidePosition"
}

$sequence "pickuploop" {
	"pickup_loop"
	"pickup_loop_i"
	activity "ACT_VM_PICKUPLOOP" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "SlidePosition"
}

$sequence "pickupend" {
	"pickup_end"
	"pickup_end_i"
	activity "ACT_VM_PICKUPEND" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Pickup.Out" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "SlidePosition"
}

$sequence "bayonet_unequip" {
	"bayonet_unequip_a"
	"bayonet_unequip_a_i"
	activity "ACT_VM_DETACH_SILENCER" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event AE_CL_SETUP_BAYONET 40 "0" }
	{ event 5004 1 "MCV_Weapon_Foley_Bayonet.HandMovement_2" }
	{ event 5004 24 "MCV_Weapon_Foley_Bayonet.KnifeMovement_Off" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "SlidePosition"
}

$sequence "bayonet_equip" {
	"bayonet_equip_a"
	"bayonet_equip_a_i"
	activity "ACT_VM_ATTACH_SILENCER" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event AE_CL_SETUP_BAYONET 5 "1" }
	{ event 5004 1 "MCV_Weapon_Foley_Bayonet.HandMovement_1" }
	{ event 5004 22 "MCV_Weapon_Foley_Bayonet.KnifeMovement_On" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "SlidePosition"
}

$sequence "bash_bayonet" {
	"bayonet_bash_a"
	"bayonet_bash_a_i"
	activity "ACT_VM_HITLEFT" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Bash.Fast" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	addlayer "SlidePosition"
	node "0"
}

$sequence "slash_bayonet" {
	"bayonet_bash_a"
	"bayonet_bash_a_i"
	activity "ACT_VM_HITRIGHT" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 3200 3 "" }
	{ event 5004 1 "MCV_Weapon_Foley_Bash.Fast" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	addlayer "SlidePosition"
	node "0"
}

$sequence "holster" {
	"v_mas49_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 0 "MCV_Weapon_Foley_MAS49.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "SlidePosition"
	fps 30
	
	
}

$sequence "gren_ironsight_test" {
	"grenade_ironsight"
	fadein 0.2
	fadeout 0.2
	hidden
	addlayer "walklayerironsight"
}

$sequence "grenade_idle" {
	"basePose_a"
	"ironsight_transition"
	activity "ACT_VM_IDLE_M203" 1
	blend "ironsight" 0 0.5
	blendwidth 2
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	blendlayer "gren_ironsight_test" 0 0 1 0 poseparameter ironsight
	node "0"
}

$sequence "grenade_shoot" {
	"gren_shoot1_a"
	"gren_shoot1_ironsight_a"
	activity "ACT_VM_ISHOOT_M203" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_MUZZLEFLASH 0 "" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "grenade_reload" {
	"gren_reload_a"
	"gren_reload_a_i"
	activity "ACT_VM_RELOAD_M203" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_RifleGrenade.Raise" }
	{ event 5004 5 "MCV_Weapon_Foley_RifleGrenade.Attach" }
	{ event 5004 35 "MCV_Weapon_Foley_RifleGrenade.Lower" }
	fadein 0
	fadeout 0.2
}

$sequence "grenade_draw" {
	"v_mas49_anims\grenade_draw.smd"
	"v_mas49_anims\grenade_draw_2.smd"
	activity "ACT_VM_DRAWFULL_M203" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_RifleGrenade.Raise" }
	{ event 5004 5 "MCV_Weapon_Foley_RifleGrenade.Attach" }
	{ event 5004 35 "MCV_Weapon_Foley_RifleGrenade.Lower" }
	{ event AE_WPN_SET_POSEPARAM 0 "ammo_fraction 1" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	fps 30
	
	
}

$sequence "grenade_draw_empty" {
	"v_mas49_anims\grenade_draw_empty.smd"
	"v_mas49_anims\grenade_draw_empty_2.smd"
	activity "ACT_VM_DRAW_M203" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_MAS49.Draw" }
	{ event AE_WPN_SET_POSEPARAM 0 "ammo_fraction 1" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$sequence "Scope_adjust" {
	"scope_adjust_idle"
	"scope_adjust_iron"
	activity "ACT_VM_FIDGET" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 0 "MCV_Weapon_Foley_Zoom.HandIn" }
	{ event 5004 13 "MCV_Weapon_Foley_Zoom.Adjust" }
	{ event 5004 20 "MCV_Weapon_Foley_Zoom.HandOut" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "SlidePosition"
}

$sequence "ChargeStart" {
	"ChargeStart_a"
	"ChargeStart_a_i"
	activity "ACT_VM_CHARGE_START" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0
	fadeout 0.2
	addlayer "SlidePosition"
	node "0"
}

$sequence "ChargeLoop" {
	"ChargeLoop_a"
	"ChargeLoop_a_i"
	activity "ACT_VM_CHARGE_LOOP" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0
	fadeout 0.2
	addlayer "SlidePosition"
	node "0"
}

$sequence "ChargeStab" {
	"ChargeEnd_a"
	"ChargeEnd_a_i"
	activity "ACT_VM_CHARGE_STAB" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0
	fadeout 0.2
	addlayer "SlidePosition"
	node "0"
}

$includemodel "weapons/gesture_animations.mdl"

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\sniper_mas49\mas49_new.qc"
//	}
}

// Created by Crowbar 0.74

$modelname "weapons/mcv/v_m50.mdl"

$bodygroup "studio"
{
	studio "Ref_new.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition -2.303 -13.722 -13.755

$cdmaterials "models\weapons\mcv\v_m50_madsen\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "Base" -15 0 0 rotate 0 -180 0
$attachment "eject" "Base" -4 0 0 rotate 0 90 0

$cbox 0 0 0 0 0 0

$bbox -9.182 -11.881 -27.51 36.626 7.274 0

$definebone "root" "" 0 7.450089 -27.509027 0 0 0 0 0 0 0 0 0
$definebone "pelvis" "root" -0.000002 0 0 -89.790575 -89.991335 89.991335 0 0 0 0 0 0
$definebone "spine_01" "pelvis" 4.255466 -0.33518 -0.000001 0 -7.153376 0 0 0 0 0 0 0
$definebone "spine_02" "spine_01" 7.431248 1.496499 0.000003 0 14.06342 0 0 0 0 0 0 0
$definebone "spine_03" "spine_02" 5.278478 0.165541 0.000002 0 2.779589 0 0 0 0 0 0 0
$definebone "clavicle_r" "spine_03" 4.678656 -1.075646 1.488978 66.457823 -74.415068 113.208733 0 0 0 0 0 0
$definebone "upperarm_r" "clavicle_r" -6.214481 -0.000007 -0.000027 -39.361246 171.560815 166.195605 0 0 0 0 0 0
$definebone "lowerarm_r" "upperarm_r" 11.944889 0 0 -11.598961 34.295493 -86.386566 0 0 0 0 0 0
$definebone "hand_r" "lowerarm_r" 10.620193 0 -0.000002 -16.394259 136.880529 7.275605 0 0 0 0 0 0
$definebone "index_01_r" "hand_r" -4.751101 -0.694498 0.830584 -3.76261 25.538627 14.867333 0 0 0 0 0 0
$definebone "index_02_r" "index_01_r" -1.688072 0.000046 -0.000031 -0.475205 11.986173 1.337739 0 0 0 0 0 0
$definebone "index_03_r" "index_02_r" -1.336143 0.000051 -0.00001 0.996895 -9.496597 1.137489 0 0 0 0 0 0
$definebone "middle_01_r" "hand_r" -4.82049 -0.509462 -0.224754 -7.039472 22.827394 1.9182 0 0 0 0 0 0
$definebone "middle_02_r" "middle_01_r" -1.826984 -0.000066 0.000007 1.136809 12.280677 -2.025068 0 0 0 0 0 0
$definebone "middle_03_r" "middle_02_r" -1.436565 0.000006 0.000003 -4.389659 -15.399491 0.781624 0 0 0 0 0 0
$definebone "pinky_01_r" "hand_r" -3.992355 -0.891188 -1.827907 -18.932991 20.187201 -18.724269 0 0 0 0 0 0
$definebone "pinky_02_r" "pinky_01_r" -1.405918 -0.000031 0.000001 -1.315456 11.208494 1.064032 0 0 0 0 0 0
$definebone "pinky_03_r" "pinky_02_r" -1.17535 0.000126 -0.000018 3.869355 1.038553 0.445409 0 0 0 0 0 0
$definebone "ring_01_r" "hand_r" -4.526745 -0.690578 -1.120739 -10.988241 23.293494 -13.509719 0 0 0 0 0 0
$definebone "ring_02_r" "ring_01_r" -1.744041 0.000027 -0.000009 -1.669886 13.315263 0.301311 0 0 0 0 0 0
$definebone "ring_03_r" "ring_02_r" -1.368774 0.000017 0.000004 2.987919 -12.899165 -0.360859 0 0 0 0 0 0
$definebone "thumb_01_r" "hand_r" -1.87479 -0.935123 0.999177 36.920212 27.057951 95.069628 0 0 0 0 0 0
$definebone "thumb_02_r" "thumb_01_r" -1.523449 0.000031 0.00003 9.83346 15.151571 1.613276 0 0 0 0 0 0
$definebone "thumb_03_r" "thumb_02_r" -1.599283 0.000013 -0.000007 0.480035 -12.38593 2.414438 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" 5.511824 0.000001 0.000008 -0.000282 -180.000005 76.489998 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" 0.196845 -0.000001 0.000004 0.00063 -179.999185 160.05047 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 4.678656 -1.075645 -1.488977 66.457918 105.584698 113.208582 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.214486 0.000013 0.000019 39.360379 -8.439319 13.804393 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.944891 -0.000024 -0.000198 -11.598194 -34.295418 -3.613819 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620169 -0.000006 0.00001 -40.97381 21.95071 -97.528251 0 0 0 0 0 0
$definebone "index_01_l" "hand_l" 4.751156 0.69438 -0.830469 -3.764857 25.536689 14.866772 0 0 0 0 0 0
$definebone "index_02_l" "index_01_l" 1.688068 -0.000025 0 -0.475099 11.986471 1.338024 0 0 0 0 0 0
$definebone "index_03_l" "index_02_l" 1.336159 -0.000048 -0.000009 -1.907895 -9.55434 1.137775 0 0 0 0 0 0
$definebone "middle_01_l" "hand_l" 4.820509 0.509346 0.224871 -7.040283 22.825966 1.917749 0 0 0 0 0 0
$definebone "middle_02_l" "middle_01_l" 1.826992 0.000065 0.000007 1.13674 12.280744 -2.025007 0 0 0 0 0 0
$definebone "middle_03_l" "middle_02_l" 1.436581 -0.000011 0.000006 -0.387902 -15.34493 0.779223 0 0 0 0 0 0
$definebone "pinky_01_l" "hand_l" 3.992348 0.89109 1.827996 -18.934541 20.186462 -18.724832 0 0 0 0 0 0
$definebone "pinky_02_l" "pinky_01_l" 1.405922 0.000023 -0.00001 -1.315808 11.208158 1.063929 0 0 0 0 0 0
$definebone "pinky_03_l" "pinky_02_l" 1.175362 -0.000131 0.000001 7.050464 1.063481 0.447828 0 0 0 0 0 0
$definebone "ring_01_l" "hand_l" 4.526752 0.690468 1.120847 -10.989853 23.292125 -13.510227 0 0 0 0 0 0
$definebone "ring_02_l" "ring_01_l" 1.744038 -0.00003 -0.000005 -1.669896 13.315669 0.301609 0 0 0 0 0 0
$definebone "ring_03_l" "ring_02_l" 1.368763 -0.00003 -0.000015 9.085669 -12.938405 -0.365313 0 0 0 0 0 0
$definebone "thumb_01_l" "hand_l" 1.874855 0.935083 -0.999127 36.918996 27.057147 95.069635 0 0 0 0 0 0
$definebone "thumb_02_l" "thumb_01_l" 1.523457 -0.000032 -0.000005 9.832717 15.151299 1.612642 0 0 0 0 0 0
$definebone "thumb_03_l" "thumb_02_l" 1.599285 -0.000002 0.00001 4.129776 -12.23138 2.421312 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511808 -0.000006 0.000007 0.000249 0.000239 -13.510235 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.196848 0.000004 -0.000001 0.000873 -0.000113 -19.951818 0 0 0 0 0 0
$definebone "cam_driver" "" 0 0 0 0 -89.999982 0 0 0 0 0 0 0
$definebone "Base" "" -3.338849 -22.14592 -2.479462 0 89.999989 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 16.351553 7.805828 -3.043497 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" 3.853237 0.126709 -0.785798 0 0 0 0 0 0 0 0 0
$definebone "Mag" "Base" -4.061096 -0.003366 -0.78741 0 0 0 0 0 0 0 0 0
$definebone "Bullets" "Mag" -0.000195 0 0.397731 0 0 0 0 0 0 0 0 0
$definebone "Bolt" "Base" -3.582266 0.216457 0.187458 0 0 0 0 0 0 0 0 0
$definebone "MagRelease" "Base" -3.32563 0.00372 -2.402156 0 0 0 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" -0.778698 -2.432378 -4.377182 -2.848944 -106.899591 167.363964 0 0 0 0 0 0

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

$poseparameter "ammo_fraction" 0 0.01 loop 0
$poseparameter "player_movement" 0 276 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "Slideback_corrective_animation" "v_m50_anims\Slideback_corrective_animation.smd" {
}

$animation "Default_corrective_animation" "v_m50_anims\Default_corrective_animation.smd" {
}

$animation "runIdle_a_corrective_animation" "v_m50_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_m50_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_m50_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_m50_anims\walk_a_corrective_animation.smd" {
}

$animation "ShootStill_corrective_animation" "v_m50_anims\ShootStill_corrective_animation.smd" {
}

$animation "ShootMove_corrective_animation" "v_m50_anims\ShootMove_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_m50_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_m50_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_a_corrective_animation" "v_m50_anims\shoot2_a_corrective_animation.smd" {
}

$animation "shoot2_ironsight_a_corrective_animation" "v_m50_anims\shoot2_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3_a_corrective_animation" "v_m50_anims\shoot3_a_corrective_animation.smd" {
}

$animation "shoot3_ironsight_a_corrective_animation" "v_m50_anims\shoot3_ironsight_a_corrective_animation.smd" {
}

$animation "PoseDelta" "v_m50_anims\PoseDelta.smd" {
	fps 30
	
	
}

$animation "PoseDelta2" "v_m50_anims\PoseDelta2.smd" {
	fps 30
	
	
}

$animation "Default" "v_m50_anims\Default.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Default_corrective_animation" 0
}

$animation "Slideback" "v_m50_anims\Slideback.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Slideback_corrective_animation" 0
}

$animation "ShootMove" "v_m50_anims\ShootMove.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "ShootMove_corrective_animation" 0
}

$animation "ShootStill" "v_m50_anims\ShootStill.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "ShootStill_corrective_animation" 0
}

$animation "basePose_a" "v_m50_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "ironsight" "v_m50_anims\ironsight.smd" {
	fps 0.5
	
	
}

$animation "ironsight_transition" "v_m50_anims\ironsight_transition.smd" {
	fps 0.5
	
	
}

$animation "runIdle_a" "v_m50_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_m50_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkDelta" "v_m50_anims\walkDelta.smd" {
	fps 30
	
	
}

$animation "walkIdle_a" "v_m50_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_m50_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "shoot1_a" "v_m50_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_m50_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "shoot2_a" "v_m50_anims\shoot2_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_a_corrective_animation" 0
}

$animation "shoot2_ironsight_a" "v_m50_anims\shoot2_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_ironsight_a_corrective_animation" 0
}

$animation "shoot3_a" "v_m50_anims\shoot3_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_a_corrective_animation" 0
}

$animation "shoot3_ironsight_a" "v_m50_anims\shoot3_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_ironsight_a_corrective_animation" 0
}

$animation "nearwall_s_a" "v_m50_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_m50_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_m50_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_m50_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_m50_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_m50_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "proneF" "v_m50_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_m50_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_m50_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_m50_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_m50_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_m50_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_m50_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_m50_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_m50_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_m50_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$sequence "SlidePosition" {
	"Slideback"
	"Default"
	blend "ammo_fraction" 0 0.01
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
	blend "player_movement" 141 237
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
	"walkIdle_a"
	"walkIdle_a"
	"walkIdle_a"
	blend "player_movement" 0 276
	blend "ironsight" 0 1
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

$sequence "SlideMovement" {
	"ShootStill"
	"ShootMove"
	blend "ammo_fraction" 0 0.01
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
	hidden
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
	addlayer "SlideMovement"
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
	addlayer "SlideMovement"
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
	addlayer "SlideMovement"
	node "Fire"
}

$sequence "draw" {
	"v_m50_anims\draw.smd"
	"v_m50_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M50.Draw" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 0 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	  
	
}

$sequence "Firstdraw" {
	"v_m50_anims\Firstdraw.smd"
	"v_m50_anims\Firstdraw_2.smd"
	activity "ACT_VM_READY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M50.Draw" }
	{ event 5004 9 "MCV_Weapon_Foley_M50_Reload.Metal" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 0 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$sequence "reload" {
	"v_m50_anims\reload.smd"
	"v_m50_anims\reload_2.smd"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M50_Reload.Hand" }
	{ event 5004 11 "MCV_Weapon_Foley_M50_Reload.MagOut" }
	{ event 5004 53 "MCV_Weapon_Foley_M50_Reload.MagIn" }
	{ event 5004 60 "MCV_Weapon_Foley_M50_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 65 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 65 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "reload_empty" {
	"v_m50_anims\reload_empty.smd"
	"v_m50_anims\reload_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M50_Reload.Hand" }
	{ event 5004 11 "MCV_Weapon_Foley_M50_Reload.MagOut" }
	{ event 5004 53 "MCV_Weapon_Foley_M50_Reload.MagIn" }
	{ event 5004 80 "MCV_Weapon_Foley_M50_Reload.Metal" }
	{ event 5004 80 "MCV_Weapon_Foley_M50_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 81 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 81 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "idletonearwall" {
	"nearwall_s_a"
	"nearwall_s_a_i"
	activity "ACT_VM_IDLE_TO_LOWERED" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.In" }
	fadein 0.2
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
	node "0"
}

$sequence "nearwall" {
	"nearwall_a"
	"nearwall_a_i"
	activity "ACT_VM_IDLE_LOWERED" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0.2
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
	node "0"
}

$sequence "nearwalltoidle" {
	"nearwall_e_a"
	"nearwall_e_a_i"
	activity "ACT_VM_LOWERED_TO_IDLE" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.Out" }
	fadein 0.2
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
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
	realtime
}

$sequence "bash" {
	"v_m50_anims\bash.smd"
	"v_m50_anims\bash_2.smd"
	activity "ACT_VM_HITCENTER" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 3200 3 "" }
	{ event 5004 1 "MCV_Weapon_Foley_Bash.Fast" }
	fadein 0
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
	node "0"
	fps 30
	
	
}

$sequence "pickupstart" {
	"pickup_s_a"
	"pickup_s_a_i"
	activity "ACT_VM_PICKUPSTART" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.In" }
	fadein 0.2
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
}

$sequence "pickuploop" {
	"pickup_a"
	"pickup_a_i"
	activity "ACT_VM_PICKUPLOOP" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0.2
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
}

$sequence "pickupend" {
	"pickup_e_a"
	"pickup_e_a_i"
	activity "ACT_VM_PICKUPEND" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.Out" }
	fadein 0.2
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
}

$sequence "holster" {
	"v_m50_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 0 "MCV_Weapon_Foley_M50.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$includemodel "weapons/gesture_animations.mdl"

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\smg_m50madsen\m50_madsen.qc"
//	}
}

// Created by Crowbar 0.74

$modelname "weapons/mcv/v_vz23.mdl"

$bodygroup "studio"
{
	studio "Ref_new.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition -2.224 -13.88 -13.755

$cdmaterials "models\weapons\mcv\v_vz23\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "Base" -15.8 0.25 0.8 rotate 0 180 0
$attachment "eject" "Base" -0.3 0.4 1.5 rotate -10 90 0

$cbox 0 0 0 0 0 0

$bbox -9.182 -11.354 -27.509 36.942 6.905 0

$definebone "root" "" 0 7.450089 -27.509027 0 0 0 0 0 0 0 0 0
$definebone "pelvis" "root" -0.000002 0 0 -89.790391 -89.991335 89.991335 0 0 0 0 0 0
$definebone "spine_01" "pelvis" 4.255468 -0.335186 -0.000001 0 -7.153321 0 0 0 0 0 0 0
$definebone "spine_02" "spine_01" 7.431248 1.496481 0.000003 0 14.063191 0 0 0 0 0 0 0
$definebone "spine_03" "spine_02" 5.278481 0.165551 0.000002 0 2.779533 0 0 0 0 0 0 0
$definebone "clavicle_r" "spine_03" 4.678658 -1.075633 1.488979 66.458007 -74.415362 113.208268 0 0 0 0 0 0
$definebone "upperarm_r" "clavicle_r" -6.214486 -0.000011 -0.000003 -39.361397 171.560855 166.195523 0 0 0 0 0 0
$definebone "lowerarm_r" "upperarm_r" 11.944895 0.000001 0 -11.599041 34.295432 3.613592 0 0 0 0 0 0
$definebone "hand_r" "lowerarm_r" 10.620185 0 -0.000001 40.975364 158.047504 82.470901 0 0 0 0 0 0
$definebone "index_01_r" "hand_r" -4.751104 -0.694517 0.830585 -3.762447 25.539097 14.867336 0 0 0 0 0 0
$definebone "index_02_r" "index_01_r" -1.688072 0.000047 -0.000036 -0.475384 11.985893 1.337629 0 0 0 0 0 0
$definebone "index_03_r" "index_02_r" -1.336151 0.000051 -0.000012 0.996774 -9.496753 1.137495 0 0 0 0 0 0
$definebone "middle_01_r" "hand_r" -4.820496 -0.509487 -0.22475 -7.039365 22.827636 1.918205 0 0 0 0 0 0
$definebone "middle_02_r" "middle_01_r" -1.826984 -0.000067 0.000004 1.136744 12.280621 -2.025008 0 0 0 0 0 0
$definebone "middle_03_r" "middle_02_r" -1.436577 0.000004 0 -4.389723 -15.399485 0.781514 0 0 0 0 0 0
$definebone "pinky_01_r" "hand_r" -3.992359 -0.891211 -1.827902 -18.93277 20.187616 -18.724375 0 0 0 0 0 0
$definebone "pinky_02_r" "pinky_01_r" -1.405918 -0.000031 -0.000003 -1.315695 11.2081 1.063858 0 0 0 0 0 0
$definebone "pinky_03_r" "pinky_02_r" -1.175365 0.000121 -0.00002 3.869573 1.038901 0.445691 0 0 0 0 0 0
$definebone "ring_01_r" "hand_r" -4.526754 -0.690601 -1.120736 -10.988075 23.293793 -13.509717 0 0 0 0 0 0
$definebone "ring_02_r" "ring_01_r" -1.744049 0.000033 -0.000011 -1.669778 13.315443 0.301138 0 0 0 0 0 0
$definebone "ring_03_r" "ring_02_r" -1.368771 0.000025 0 2.98762 -12.899725 -0.360625 0 0 0 0 0 0
$definebone "thumb_01_r" "hand_r" -1.874794 -0.935137 0.999178 36.92014 27.058237 95.069683 0 0 0 0 0 0
$definebone "thumb_02_r" "thumb_01_r" -1.523455 0.000036 0.000029 9.83346 15.151356 1.61321 0 0 0 0 0 0
$definebone "thumb_03_r" "thumb_02_r" -1.599285 0.000002 -0.000002 0.48055 -12.385685 2.414261 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" 5.511817 0.000006 -0.000002 -0.000186 179.999786 166.490109 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" 0.196847 -0.000001 0.000004 0.000106 -179.999035 160.05047 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 4.678658 -1.075633 -1.488978 66.457925 105.584814 113.208418 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.214488 0.000005 0.000019 39.360317 -8.43898 13.804676 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.944894 -0.000065 -0.000194 -11.598198 -34.295596 -3.613992 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620176 -0.000013 0.000006 -40.973816 21.950474 -97.527964 0 0 0 0 0 0
$definebone "index_01_l" "hand_l" 4.751163 0.694376 -0.830469 -3.76474 25.536511 14.866766 0 0 0 0 0 0
$definebone "index_02_l" "index_01_l" 1.688061 -0.00003 0.000002 -0.475099 11.986465 1.337915 0 0 0 0 0 0
$definebone "index_03_l" "index_02_l" 1.336151 -0.00005 -0.000007 -1.907723 -9.554458 1.137895 0 0 0 0 0 0
$definebone "middle_01_l" "hand_l" 4.820515 0.509338 0.224869 -7.040283 22.825959 1.91769 0 0 0 0 0 0
$definebone "middle_02_l" "middle_01_l" 1.826996 0.000065 0.000006 1.136799 12.280616 -2.025006 0 0 0 0 0 0
$definebone "middle_03_l" "middle_02_l" 1.436573 -0.000008 0.000009 -0.3879 -15.344945 0.779224 0 0 0 0 0 0
$definebone "pinky_01_l" "hand_l" 3.992355 0.891087 1.828 -18.934256 20.186175 -18.724948 0 0 0 0 0 0
$definebone "pinky_02_l" "pinky_01_l" 1.405922 0.000025 -0.000003 -1.315806 11.208098 1.063868 0 0 0 0 0 0
$definebone "pinky_03_l" "pinky_02_l" 1.175365 -0.000126 0.00001 7.050124 1.063654 0.448284 0 0 0 0 0 0
$definebone "ring_01_l" "hand_l" 4.52676 0.69046 1.120847 -10.989969 23.29235 -13.510287 0 0 0 0 0 0
$definebone "ring_02_l" "ring_01_l" 1.744045 -0.000039 -0.00001 -1.669667 13.315385 0.301602 0 0 0 0 0 0
$definebone "ring_03_l" "ring_02_l" 1.368767 -0.000025 -0.000012 9.08573 -12.938409 -0.365203 0 0 0 0 0 0
$definebone "thumb_01_l" "hand_l" 1.874857 0.935081 -0.999128 36.918883 27.057084 95.069512 0 0 0 0 0 0
$definebone "thumb_02_l" "thumb_01_l" 1.523453 -0.000038 -0.000008 9.832773 15.151351 1.612985 0 0 0 0 0 0
$definebone "thumb_03_l" "thumb_02_l" 1.599281 -0.000004 0.000011 4.12966 -12.231736 2.421082 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511808 -0.000013 0.000004 0.000299 0.000059 -13.510118 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.196847 0.000003 -0.000002 0.000867 -0.000289 -19.951766 0 0 0 0 0 0
$definebone "cam_driver" "" 0 0 0 0 -89.999982 0 0 0 0 0 0 0
$definebone "Base" "" -3.477342 -12.501931 -3.289384 0 89.999982 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 6.707568 7.667339 -2.233575 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" -2.586185 -0.011781 -0.789815 0 0 0 0 0 0 0 0 0
$definebone "Mag" "Base" 0.19077 -0.011782 0.390288 0 0 0 0 0 0 0 0 0
$definebone "Bullets" "Mag" -0.09271 0 -0.203218 0 0 0 0 0 0 0 0 0
$definebone "Bolt" "Base" -0.30169 -0.011782 1.25379 0 0 0 0 0 0 0 0 0
$definebone "Boltpuller" "Bolt" 1.770586 -0.000001 0 0 0 0 0 0 0 0 0 0
$definebone "MagRelease" "Base" 0.736661 0.229826 -4.333248 0 0 0 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" -3.829012 -2.364995 -3.360025 57.183747 -135.0749 -175.439146 0 0 0 0 0 0

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




$animation "Slideback_corrective_animation" "v_vz23_anims\Slideback_corrective_animation.smd" {
}

$animation "Default_corrective_animation" "v_vz23_anims\Default_corrective_animation.smd" {
}

$animation "runIdle_a_corrective_animation" "v_vz23_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_vz23_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_vz23_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_vz23_anims\walk_a_corrective_animation.smd" {
}

$animation "ShootStill_corrective_animation" "v_vz23_anims\ShootStill_corrective_animation.smd" {
}

$animation "ShootMove_corrective_animation" "v_vz23_anims\ShootMove_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_vz23_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_vz23_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_a_corrective_animation" "v_vz23_anims\shoot2_a_corrective_animation.smd" {
}

$animation "shoot2_ironsight_a_corrective_animation" "v_vz23_anims\shoot2_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3_a_corrective_animation" "v_vz23_anims\shoot3_a_corrective_animation.smd" {
}

$animation "shoot3_ironsight_a_corrective_animation" "v_vz23_anims\shoot3_ironsight_a_corrective_animation.smd" {
}

$animation "PoseDelta" "v_vz23_anims\PoseDelta.smd" {
	fps 30
	
	
}

$animation "PoseDelta2" "v_vz23_anims\PoseDelta2.smd" {
	fps 30
	
	
}

$animation "Default" "v_vz23_anims\Default.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Default_corrective_animation" 0
}

$animation "Slideback" "v_vz23_anims\Slideback.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Slideback_corrective_animation" 0
}

$animation "ShootMove" "v_vz23_anims\ShootMove.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "ShootMove_corrective_animation" 0
}

$animation "ShootStill" "v_vz23_anims\ShootStill.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "ShootStill_corrective_animation" 0
}

$animation "basePose_a" "v_vz23_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "ironsight" "v_vz23_anims\ironsight.smd" {
	fps 30
	frame 0 1
	numframes 60
	
	
}

$animation "ironsight_transition" "v_vz23_anims\ironsight_transition.smd" {
	fps 30
	frame 0 1
	numframes 60
	
	
}

$animation "runIdle_a" "v_vz23_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_vz23_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_vz23_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_vz23_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "shoot1_a" "v_vz23_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_vz23_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "shoot2_a" "v_vz23_anims\shoot2_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_a_corrective_animation" 0
}

$animation "shoot2_ironsight_a" "v_vz23_anims\shoot2_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_ironsight_a_corrective_animation" 0
}

$animation "shoot3_a" "v_vz23_anims\shoot3_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_a_corrective_animation" 0
}

$animation "shoot3_ironsight_a" "v_vz23_anims\shoot3_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_ironsight_a_corrective_animation" 0
}

$animation "nearwall_s_a" "v_vz23_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_vz23_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_vz23_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_vz23_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_vz23_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_vz23_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "proneF" "v_vz23_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_vz23_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_vz23_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_vz23_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_vz23_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_vz23_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_vz23_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_vz23_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_vz23_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_vz23_anims\pickup_e_a_i.smd" {
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
	blend "player_movement" 141 236
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
	"ironsight"
	activity "ACT_VM_IDLE" 1
	blend "ironsight" 0 1
	blendwidth 3
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
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
	{ event AE_CLIENT_EJECT_BRASS 1 "eject" }
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
	{ event AE_CLIENT_EJECT_BRASS 1 "eject" }
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
	{ event AE_CLIENT_EJECT_BRASS 1 "eject" }
	{ event AE_MUZZLEFLASH 0 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 0 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	addlayer "SlideMovement"
	node "Fire"
}

$sequence "draw" {
	"v_vz23_anims\draw.smd"
	"v_vz23_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_VZ23.Draw" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 0 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	  
	
}

$sequence "Firstdraw" {
	"v_vz23_anims\Firstdraw.smd"
	"v_vz23_anims\Firstdraw_2.smd"
	activity "ACT_VM_READY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_VZ23.Draw" }
	{ event 5004 10 "MCV_Weapon_Foley_VZ23_Reload.Metal" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 0 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$sequence "reload" {
	"v_vz23_anims\reload.smd"
	"v_vz23_anims\reload_2.smd"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_VZ23_Reload.Hand" }
	{ event 5004 10 "MCV_Weapon_Foley_VZ23_Reload.MagOut" }
	{ event 5004 38 "MCV_Weapon_Foley_VZ23_Reload.MagIn" }
	{ event 5004 55 "MCV_Weapon_Foley_VZ23_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 47 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 47 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "reload_empty" {
	"v_vz23_anims\reload_empty.smd"
	"v_vz23_anims\reload_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_VZ23_Reload.Hand" }
	{ event 5004 10 "MCV_Weapon_Foley_VZ23_Reload.MagOut" }
	{ event 5004 38 "MCV_Weapon_Foley_VZ23_Reload.MagIn" }
	{ event 5004 55 "MCV_Weapon_Foley_VZ23_Reload.HandEnd" }
	{ event 5004 65 "MCV_Weapon_Foley_VZ23_Reload.Metal" }
	{ event 5004 75 "MCV_Weapon_Foley_VZ23_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 71 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 71 "ammo_fraction" }
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
	"v_vz23_anims\bash.smd"
	"v_vz23_anims\bash_2.smd"
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
	"v_vz23_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 0 "MCV_Weapon_Foley_VZ23.Holster" }
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
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\smg_vz23\vz23.qc"
//	}
}

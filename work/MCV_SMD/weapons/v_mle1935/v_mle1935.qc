// Created by Crowbar 0.74

$modelname "weapons/mcv/v_mle1935.mdl"

$bodygroup "studio"
{
	studio "RefMLE1935_new.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition -3.095 -9.198 -13.755

$cdmaterials "models\weapons\mcv\v_mle1935\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "Base" -7.3 0 2 rotate 0 -180 0
$attachment "eject" "Base" -0.2 0 2.1 rotate -20 90 0

$cbox 0 0 0 0 0 0

$bbox -9.182 -14.564 -27.51 27.578 8.373 0

$definebone "root" "" 0 7.450089 -27.509027 0 0 0 0 0 0 0 0 0
$definebone "pelvis" "root" -0.000002 0 0 -89.790336 -89.996943 89.996943 0 0 0 0 0 0
$definebone "spine_01" "pelvis" 4.255468 -0.335183 -0.000002 0 -7.153264 0 0 0 0 0 0 0
$definebone "spine_02" "spine_01" 7.431248 1.496477 0.000002 0 14.063251 0 0 0 0 0 0 0
$definebone "spine_03" "spine_02" 5.278479 0.165541 0.000001 0 2.779477 0 0 0 0 0 0 0
$definebone "clavicle_r" "spine_03" 4.678654 -1.075636 1.488977 66.457877 -74.414959 113.208678 0 0 0 0 0 0
$definebone "upperarm_r" "clavicle_r" -6.214482 -0.000007 -0.000027 -17.285762 100.610947 -158.881279 0 0 0 0 0 0
$definebone "lowerarm_r" "upperarm_r" 11.944885 0 0 -17.318628 58.87147 -2.620262 0 0 0 0 0 0
$definebone "hand_r" "lowerarm_r" 10.62018 -0.000001 -0.000001 -17.390541 154.858994 115.958184 0 0 0 0 0 0
$definebone "index_01_r" "hand_r" -4.751108 -0.694492 0.830575 -3.762682 25.538663 14.867227 0 0 0 0 0 0
$definebone "index_02_r" "index_01_r" -1.688068 0.000045 -0.000034 -0.475224 11.986097 1.33774 0 0 0 0 0 0
$definebone "index_03_r" "index_02_r" -1.336138 0.000054 -0.000012 0.996933 -9.49661 1.137549 0 0 0 0 0 0
$definebone "middle_01_r" "hand_r" -4.820497 -0.509459 -0.224759 -7.039541 22.827317 1.918093 0 0 0 0 0 0
$definebone "middle_02_r" "middle_01_r" -1.826991 -0.000065 0.000006 1.136737 12.280644 -2.025002 0 0 0 0 0 0
$definebone "middle_03_r" "middle_02_r" -1.436577 0.000011 0.000004 -4.389721 -15.399572 0.781576 0 0 0 0 0 0
$definebone "pinky_01_r" "hand_r" -3.992359 -0.891186 -1.827908 -18.932822 20.18741 -18.724433 0 0 0 0 0 0
$definebone "pinky_02_r" "pinky_01_r" -1.40592 -0.000024 -0.000003 -1.315563 11.208242 1.063875 0 0 0 0 0 0
$definebone "pinky_03_r" "pinky_02_r" -1.175364 0.000127 -0.000019 3.869417 1.038582 0.445653 0 0 0 0 0 0
$definebone "ring_01_r" "hand_r" -4.526755 -0.690574 -1.120743 -10.988249 23.293472 -13.509884 0 0 0 0 0 0
$definebone "ring_02_r" "ring_01_r" -1.744044 0.000039 -0.000008 -1.669888 13.315291 0.301262 0 0 0 0 0 0
$definebone "ring_03_r" "ring_02_r" -1.368763 0.000024 0.000004 2.987743 -12.899527 -0.360675 0 0 0 0 0 0
$definebone "thumb_01_r" "hand_r" -1.874802 -0.935125 0.999173 36.920239 27.057801 95.069526 0 0 0 0 0 0
$definebone "thumb_02_r" "thumb_01_r" -1.523451 0.00003 0.000029 9.832801 15.151547 1.613454 0 0 0 0 0 0
$definebone "thumb_03_r" "thumb_02_r" -1.599283 0.000003 0.000013 0.480701 -12.385724 2.414109 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" 5.511815 0.000004 -0.000003 -0.000407 179.999745 166.489945 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" 0.19685 -0.000003 0.000003 0.000347 -179.999117 160.050416 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 4.678655 -1.075636 -1.488978 66.457918 105.584814 113.208535 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.214485 0.000006 0.00002 23.505872 -122.013243 -45.028872 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.944891 -0.000034 -0.00019 -14.983593 -47.287111 -0.61369 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620169 0.000006 0.00001 10.370842 -141.974293 -168.145898 0 0 0 0 0 0
$definebone "index_01_l" "hand_l" 4.751155 0.694375 -0.830473 -3.764669 25.536493 14.866769 0 0 0 0 0 0
$definebone "index_02_l" "index_01_l" 1.688066 -0.000026 0.000002 -0.475149 11.986493 1.337915 0 0 0 0 0 0
$definebone "index_03_l" "index_02_l" 1.336144 -0.000053 -0.000009 -1.907886 -9.554311 1.137836 0 0 0 0 0 0
$definebone "middle_01_l" "hand_l" 4.820513 0.509339 0.224865 -7.040153 22.825888 1.917694 0 0 0 0 0 0
$definebone "middle_02_l" "middle_01_l" 1.826997 0.000066 0.000008 1.136755 12.280649 -2.024999 0 0 0 0 0 0
$definebone "middle_03_l" "middle_02_l" 1.436581 -0.00001 0.000007 -0.387827 -15.345019 0.779225 0 0 0 0 0 0
$definebone "pinky_01_l" "hand_l" 3.99235 0.891089 1.827995 -18.934234 20.186218 -18.724945 0 0 0 0 0 0
$definebone "pinky_02_l" "pinky_01_l" 1.405921 0.000024 -0.000005 -1.315954 11.208136 1.063924 0 0 0 0 0 0
$definebone "pinky_03_l" "pinky_02_l" 1.175363 -0.000131 0.000002 7.050433 1.063457 0.448052 0 0 0 0 0 0
$definebone "ring_01_l" "hand_l" 4.526753 0.690459 1.120842 -10.989663 23.292045 -13.510283 0 0 0 0 0 0
$definebone "ring_02_l" "ring_01_l" 1.744043 -0.000031 -0.000002 -1.67016 13.315699 0.301555 0 0 0 0 0 0
$definebone "ring_03_l" "ring_02_l" 1.368764 -0.000033 -0.000017 9.085974 -12.93854 -0.365195 0 0 0 0 0 0
$definebone "thumb_01_l" "hand_l" 1.87485 0.93508 -0.999129 36.919095 27.057062 95.069581 0 0 0 0 0 0
$definebone "thumb_02_l" "thumb_01_l" 1.523454 -0.000033 -0.000003 9.832687 15.151415 1.612764 0 0 0 0 0 0
$definebone "thumb_03_l" "thumb_02_l" 1.59928 0.000002 0.000005 4.129692 -12.231666 2.421155 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511807 -0.000003 0.000003 0.000283 0.00047 -13.510176 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.19685 0 -0.000001 0.000851 -0.000117 -19.951824 0 0 0 0 0 0
$definebone "cam_driver" "" 0 0 0 0 -89.999982 0 0 0 0 0 0 0
$definebone "Base" "" -2.98601 -14.49044 -3.838641 0 89.999989 0 0 0 0 0 0 0
$definebone "Mag" "Base" -0.420465 -0.018744 1.271445 0 0 0 0 0 0 0 0 0
$definebone "Bullet.001" "Mag" 0.516761 0 0.128686 0 0 0 0 0 0 0 0 0
$definebone "Bullet.002" "Mag" 0.557413 0 -0.302897 0 0 0 0 0 0 0 0 0
$definebone "Hammer" "Base" 1.38858 -0.009689 0.998073 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" -1.500305 -0.009689 0.357643 0 0 0 0 0 0 0 0 0
$definebone "Slide" "Base" -2.978543 -0.009689 2.091137 0 0 0 0 0 0 0 0 0
$definebone "Rhand_IKtarget" "Base" 5.797157 8.158673 -1.61676 -5.623409 89.810506 -8.287662 0 0 0 0 0 0
$definebone "LHand_IKtarget" "Base" 5.594572 -3.209471 -1.447657 -74.11495 55.708686 -136.893766 0 0 0 0 0 0
$definebone "MagRelease" "Base" -1.126227 -0.584941 -0.293134 0 0 0 0 0 0 0 0 0

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

$include "../../militaryconflict_vietnam.qci"


$sectionframes 30 30

$poseparameter "empty" 0 1 loop 0
$poseparameter "player_movement" 0 260 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "Default_corrective_animation" "v_mle1935_anims\Default_corrective_animation.smd" {
}

$animation "Slideback_corrective_animation" "v_mle1935_anims\Slideback_corrective_animation.smd" {
}

$animation "runIdle_a_corrective_animation" "v_mle1935_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_mle1935_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_mle1935_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_mle1935_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_mle1935_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_mle1935_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_a_corrective_animation" "v_mle1935_anims\shoot2_a_corrective_animation.smd" {
}

$animation "shoot2_ironsight_a_corrective_animation" "v_mle1935_anims\shoot2_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3_a_corrective_animation" "v_mle1935_anims\shoot3_a_corrective_animation.smd" {
}

$animation "shoot3_ironsight_a_corrective_animation" "v_mle1935_anims\shoot3_ironsight_a_corrective_animation.smd" {
}

$animation "shootlast_a_corrective_animation" "v_mle1935_anims\shootlast_a_corrective_animation.smd" {
}

$animation "shootlast_ironsight_a_corrective_animation" "v_mle1935_anims\shootlast_ironsight_a_corrective_animation.smd" {
}

$animation "PoseDelta" "v_mle1935_anims\PoseDelta.smd" {
	fps 30
	
	
}

$animation "Default" "v_mle1935_anims\Default.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Default_corrective_animation" 0
}

$animation "Slideback" "v_mle1935_anims\Slideback.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Slideback_corrective_animation" 0
}

$animation "basePose_a" "v_mle1935_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "ironsight" "v_mle1935_anims\ironsight.smd" {
	fps 0.5
	
	
}

$animation "ironsight_transition" "v_mle1935_anims\ironsight_transition.smd" {
	fps 0.5
	
	
}

$animation "runIdle_a" "v_mle1935_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_mle1935_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_mle1935_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_mle1935_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "shoot1_a" "v_mle1935_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_mle1935_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "shoot2_a" "v_mle1935_anims\shoot2_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_a_corrective_animation" 0
}

$animation "shoot2_ironsight_a" "v_mle1935_anims\shoot2_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_ironsight_a_corrective_animation" 0
}

$animation "shoot3_a" "v_mle1935_anims\shoot3_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_a_corrective_animation" 0
}

$animation "shoot3_ironsight_a" "v_mle1935_anims\shoot3_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_ironsight_a_corrective_animation" 0
}

$animation "shootlast_a" "v_mle1935_anims\shootlast_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_a_corrective_animation" 0
}

$animation "shootlast_ironsight_a" "v_mle1935_anims\shootlast_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_ironsight_a_corrective_animation" 0
}

$animation "nearwall_s_a" "v_mle1935_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_mle1935_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_mle1935_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_mle1935_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_mle1935_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_mle1935_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "proneF" "v_mle1935_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_mle1935_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_mle1935_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_mle1935_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_mle1935_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_mle1935_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_mle1935_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_mle1935_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_mle1935_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_mle1935_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$sequence "SlidePosition" {
	"Default"
	"Slideback"
	blend "empty" 0 1
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
	blend "player_movement" 161 260
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
	blend "player_movement" 0 260
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

$sequence "draw" {
	"v_mle1935_anims\draw.smd"
	"v_mle1935_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_MLE1935.Draw" }
	fadein 0
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
	fps 30
	  
	
}

$sequence "Firstdraw" {
	"v_mle1935_anims\Firstdraw.smd"
	"v_mle1935_anims\Firstdraw_2.smd"
	activity "ACT_VM_FIRSTDRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_MLE1935.Draw" }
	{ event 5004 9 "MCV_Weapon_Foley_MLE1935.DrawMetal" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	node "0"
	fps 30
	
	
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
	fadein 0
	fadeout 0.2
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
	fadein 0
	fadeout 0.2
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
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "shootlast" {
	"shootlast_a"
	"shootlast_ironsight_a"
	activity "ACT_VM_SHOOTLAST" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_CLIENT_EJECT_BRASS 1 "eject" }
	{ event AE_MUZZLEFLASH 0 "" }
	{ event 5004 1 "MCV_Weapon_Foley_MLE1935_ShootLast.Metal" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "reload" {
	"v_mle1935_anims\reload.smd"
	"v_mle1935_anims\reload_2.smd"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_MLE1935_Reload.Hand" }
	{ event 5004 14 "MCV_Weapon_Foley_MLE1935_Reload.MagOut" }
	{ event 5004 42 "MCV_Weapon_Foley_MLE1935_Reload.MagIn" }
	{ event 5004 52 "MCV_Weapon_Foley_MLE1935_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 43 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "reload_empty" {
	"v_mle1935_anims\reload_empty.smd"
	"v_mle1935_anims\reload_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_MLE1935_Reload.Hand" }
	{ event 5004 14 "MCV_Weapon_Foley_MLE1935_Reload.MagOut" }
	{ event 5004 42 "MCV_Weapon_Foley_MLE1935_Reload.MagIn" }
	{ event 5004 60 "MCV_Weapon_Foley_MLE1935_Reload.Metal" }
	{ event 5004 65 "MCV_Weapon_Foley_MLE1935_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 51 "" }
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
	{ event 5004 10 "MCV_Weapon_Foley_Movement.ProneCrawl_GunLight" }
	fadein 0.2
	fadeout 0.2
	addlayer "SlidePosition"
	realtime
}

$sequence "bash" {
	"v_mle1935_anims\bash.smd"
	"v_mle1935_anims\bash_2.smd"
	activity "ACT_VM_BASH" 1
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
	"v_mle1935_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 1 "MCV_Weapon_Foley_M1911.Holster" }
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
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\pistol_m1911\mle1935_new.qc"
//	}
}

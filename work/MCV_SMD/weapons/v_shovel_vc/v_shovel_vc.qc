// Created by Crowbar 0.74

$modelname "weapons/mcv/v_shovel_vc.mdl"

$bodygroup "studio"
{
	studio "Ref_VC.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition -3.034 -10.37 -12.134

$cdmaterials "models\weapons\mcv\v_shovel\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -9.182 -23.979 -28.732 29.922 17.911 4.463

$definebone "root" "" 0 7.450089 -27.509027 0 0 0 0 0 0 0 0 0
$definebone "pelvis" "root" -0.000002 0 0 -89.790336 -89.996943 89.996943 0 0 0 0 0 0
$definebone "spine_01" "pelvis" 4.255468 -0.335183 -0.000002 0 -7.153264 0 0 0 0 0 0 0
$definebone "spine_02" "spine_01" 7.431248 1.496477 0.000002 0 14.063251 0 0 0 0 0 0 0
$definebone "spine_03" "spine_02" 5.278479 0.165541 0.000001 0 2.779477 0 0 0 0 0 0 0
$definebone "clavicle_r" "spine_03" 4.678654 -1.075636 1.488977 66.457877 -74.414959 113.208678 0 0 0 0 0 0
$definebone "upperarm_r" "clavicle_r" -6.214482 -0.000007 -0.000027 -39.361178 171.560801 166.195592 0 0 0 0 0 0
$definebone "lowerarm_r" "upperarm_r" 11.944882 0 0.000001 -11.599012 34.295442 3.6135 0 0 0 0 0 0
$definebone "hand_r" "lowerarm_r" 10.620181 0.000002 0 40.975049 158.047654 82.471003 0 0 0 0 0 0
$definebone "index_01_r" "hand_r" -4.751106 -0.694494 0.830577 -3.762671 25.538678 14.867215 0 0 0 0 0 0
$definebone "index_02_r" "index_01_r" -1.688068 0.000046 -0.000032 -0.475212 11.986098 1.337746 0 0 0 0 0 0
$definebone "index_03_r" "index_02_r" -1.33614 0.000057 -0.000012 0.996947 -9.496605 1.137555 0 0 0 0 0 0
$definebone "middle_01_r" "hand_r" -4.820494 -0.50946 -0.224759 -7.039534 22.827331 1.918084 0 0 0 0 0 0
$definebone "middle_02_r" "middle_01_r" -1.826992 -0.000064 0.000006 1.136747 12.280665 -2.025011 0 0 0 0 0 0
$definebone "middle_03_r" "middle_02_r" -1.436573 0.000006 0.000002 -4.389719 -15.399549 0.781563 0 0 0 0 0 0
$definebone "pinky_01_r" "hand_r" -3.992355 -0.891188 -1.827909 -18.932828 20.187423 -18.724439 0 0 0 0 0 0
$definebone "pinky_02_r" "pinky_01_r" -1.405918 -0.000025 -0.000003 -1.315572 11.208255 1.063854 0 0 0 0 0 0
$definebone "pinky_03_r" "pinky_02_r" -1.175358 0.000128 -0.00002 3.869413 1.038596 0.445632 0 0 0 0 0 0
$definebone "ring_01_r" "hand_r" -4.526751 -0.690575 -1.120744 -10.988245 23.293488 -13.509892 0 0 0 0 0 0
$definebone "ring_02_r" "ring_01_r" -1.744038 0.000033 -0.000008 -1.669886 13.315304 0.301246 0 0 0 0 0 0
$definebone "ring_03_r" "ring_02_r" -1.368771 0.000025 0.000002 2.987742 -12.899513 -0.360692 0 0 0 0 0 0
$definebone "thumb_01_r" "hand_r" -1.8748 -0.935125 0.999174 36.92027 27.057825 95.069512 0 0 0 0 0 0
$definebone "thumb_02_r" "thumb_01_r" -1.523453 0.000032 0.000031 9.832817 15.151508 1.613452 0 0 0 0 0 0
$definebone "thumb_03_r" "thumb_02_r" -1.599285 0.000004 0.000016 0.480711 -12.385758 2.414098 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" 5.511815 0.000008 -0.000001 -0.000447 179.999759 166.489945 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" 0.196847 -0.000001 0.000003 0.00034 -179.999103 160.050416 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 4.678655 -1.075636 -1.488978 66.457918 105.584814 113.208535 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.214485 0.000006 0.00002 39.360369 -8.439261 13.804507 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.944885 -0.000029 -0.000194 -11.598263 -34.295486 -3.613932 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620166 0.000002 0.00001 -40.973745 21.950707 -97.528066 0 0 0 0 0 0
$definebone "index_01_l" "hand_l" 4.751156 0.694376 -0.830473 -3.764678 25.536505 14.866759 0 0 0 0 0 0
$definebone "index_02_l" "index_01_l" 1.688065 -0.000026 0.000002 -0.475152 11.986508 1.337909 0 0 0 0 0 0
$definebone "index_03_l" "index_02_l" 1.336151 -0.000051 -0.000009 -1.907891 -9.554292 1.137832 0 0 0 0 0 0
$definebone "middle_01_l" "hand_l" 4.820513 0.50934 0.224865 -7.040163 22.825901 1.917681 0 0 0 0 0 0
$definebone "middle_02_l" "middle_01_l" 1.826996 0.000066 0.000008 1.136747 12.280669 -2.025013 0 0 0 0 0 0
$definebone "middle_03_l" "middle_02_l" 1.436577 -0.00001 0.000007 -0.387839 -15.345002 0.779212 0 0 0 0 0 0
$definebone "pinky_01_l" "hand_l" 3.992353 0.891087 1.827994 -18.934251 20.186231 -18.724955 0 0 0 0 0 0
$definebone "pinky_02_l" "pinky_01_l" 1.405918 0.000021 -0.000007 -1.315972 11.208145 1.063906 0 0 0 0 0 0
$definebone "pinky_03_l" "pinky_02_l" 1.175369 -0.000131 0.000002 7.050415 1.063473 0.448036 0 0 0 0 0 0
$definebone "ring_01_l" "hand_l" 4.526756 0.69046 1.120842 -10.989676 23.292058 -13.510295 0 0 0 0 0 0
$definebone "ring_02_l" "ring_01_l" 1.744041 -0.000031 -0.000002 -1.67017 13.315712 0.301533 0 0 0 0 0 0
$definebone "ring_03_l" "ring_02_l" 1.368763 -0.000031 -0.000017 9.085962 -12.938527 -0.365219 0 0 0 0 0 0
$definebone "thumb_01_l" "hand_l" 1.874855 0.935081 -0.99913 36.919112 27.057091 95.069567 0 0 0 0 0 0
$definebone "thumb_02_l" "thumb_01_l" 1.523449 -0.000034 -0.000003 9.83271 15.151402 1.612764 0 0 0 0 0 0
$definebone "thumb_03_l" "thumb_02_l" 1.599281 -0.000002 0.000009 4.129716 -12.231686 2.421144 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511806 -0.000002 0.000006 0.000295 0.000398 -13.51017 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.19685 0.000003 -0.000002 0.000861 -0.00011 -19.951824 0 0 0 0 0 0
$definebone "cam_driver" "" 0 0 0 0 -89.999982 0 0 0 0 0 0 0
$definebone "Base" "" -4.33264 -16.435041 -3.391094 0 89.999989 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 10.640673 6.812044 -2.131865 0 0 0 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" 2.588485 -2.576259 -11.284609 -4.973998 -107.401658 158.314755 0 0 0 0 0 0

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

$poseparameter "player_movement" 0 334 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "runIdle_a_corrective_animation" "v_shovel_vc_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_shovel_vc_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_shovel_vc_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_shovel_vc_anims\walk_a_corrective_animation.smd" {
}

$animation "basePose_a" "v_shovel_vc_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "runIdle_a" "v_shovel_vc_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_shovel_vc_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_shovel_vc_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_shovel_vc_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "proneF" "v_shovel_vc_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_shovel_vc_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_shovel_vc_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_shovel_vc_anims\proneR.smd" {
	fps 30
	
	
}

$sequence "runlayer" {
	"runIdle_a"
	"run_a"
	blend "player_movement" 167 268
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
	blend "player_movement" 0 334
	blendwidth 3
	delta
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
}

$sequence "walklayeronly" {
	"walkIdle_a"
	"walk_a"
	"walk_a"
	blend "player_movement" 0 334
	blendwidth 3
	delta
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
}

$sequence "idle" {
	"v_shovel_vc_anims\idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
	fps 30
	loop
	
	
}

$sequence "draw" {
	"v_shovel_vc_anims\draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 1 "Weapon_Shovel.Deploy" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
	fps 30
	  
	
}

$sequence "slash" {
	"v_shovel_vc_anims\slash.smd"
	activity "ACT_VM_SLASH" 1
	{ event 5004 1 "Weapon_Shovel.Swipe" }
	fadein 0
	fadeout 0.1
	addlayer "walklayeronly"
	node "2"
	fps 30
	
	
}

$sequence "miss" {
	"v_shovel_vc_anims\miss.smd"
	activity "ACT_VM_MISSCENTER" 1
	{ event 5004 1 "Weapon_Shovel.Swipe" }
	fadein 0
	fadeout 0.1
	addlayer "walklayeronly"
	node "2"
	fps 30
	
	
}

$sequence "stab_charge" {
	"v_shovel_vc_anims\stab_charge.smd"
	activity "ACT_VM_FISTS_CHARGE_START" 1
	{ event 5004 1 "Weapon_Shovel.Charge" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayeronly"
	node "2"
	fps 30
	
	
}

$sequence "stab_charge_loop" {
	"v_shovel_vc_anims\stab_charge_loop.smd"
	activity "ACT_VM_FISTS_CHARGE_LOOP" 1
	fadein 0.2
	fadeout 0.2
	addlayer "walklayeronly"
	node "2"
	fps 30
	loop
	
	
}

$sequence "stab" {
	"v_shovel_vc_anims\stab.smd"
	activity "ACT_VM_FISTS_CHARGE_END" 1
	{ event 5004 1 "Weapon_Shovel.SwipeCharge" }
	fadein 0
	fadeout 0.1
	addlayer "walklayeronly"
	node "2"
	fps 30
	
	
}

$sequence "idletorun" {
	"basePose_a"
	activity "ACT_VM_IDLETORUN" 1
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
}

$sequence "run" {
	"basePose_a"
	activity "ACT_VM_RUN" 1
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
}

$sequence "runtoidle" {
	"basePose_a"
	activity "ACT_VM_RUNTOIDLE" 1
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
}

$sequence "walk" {
	"basePose_a"
	activity "ACT_VM_WALK" 1
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
}

$sequence "idletonearwall" {
	"v_shovel_vc_anims\idletonearwall.smd"
	activity "ACT_VM_IDLE_TO_LOWERED" 1
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.In" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
	fps 30
	
	
}

$sequence "nearwall" {
	"v_shovel_vc_anims\nearwall.smd"
	activity "ACT_VM_IDLE_LOWERED" 1
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
	fps 30
	loop
	
	
}

$sequence "nearwalltoidle" {
	"v_shovel_vc_anims\nearwalltoidle.smd"
	activity "ACT_VM_LOWERED_TO_IDLE" 1
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.Out" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
	fps 30
	
	
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
	{ event 5004 12 "MCV_Weapon_Foley_Movement.ProneCrawl" }
	fadein 0.3
	fadeout 0.3
	realtime
}

$sequence "pickupstart" {
	"v_shovel_vc_anims\pickupstart.smd"
	activity "ACT_VM_PICKUPSTART" 1
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.In" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayeronly"
	fps 30
	  
	
}

$sequence "pickuploop" {
	"v_shovel_vc_anims\pickuploop.smd"
	activity "ACT_VM_PICKUPLOOP" 1
	fadein 0.2
	fadeout 0.2
	addlayer "walklayeronly"
	fps 30
	loop
	
	
}

$sequence "pickupend" {
	"v_shovel_vc_anims\pickupend.smd"
	activity "ACT_VM_PICKUPEND" 1
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.Out" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	  
	
}

$sequence "holster" {
	"v_shovel_vc_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 1 "Weapon_Shovel.Holster" }
	fadein 0.2
	fadeout 0.2
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\guns\melee_shovel\shovelVC.qc"
//	}
}

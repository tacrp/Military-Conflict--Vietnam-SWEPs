// Created by Crowbar 0.74

$modelname "weapons/mcv/v_fist.mdl"

$bodygroup "studio"
{
	studio "savedBones.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition -1.885 6.958 -19.378

$cdmaterials "models\guns\melee_fist\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -38.677 -18.688 -38.756 24.761 14.918 0

$definebone "root" "" 0 7.450089 -27.509027 0 0 0 0 0 0 0 0 0
$definebone "pelvis" "root" -0.000002 0 0 -89.790336 -89.996943 89.996943 0 0 0 0 0 0
$definebone "spine_01" "pelvis" 4.255468 -0.335183 -0.000002 0 -7.153264 0 0 0 0 0 0 0
$definebone "spine_02" "spine_01" 7.43125 1.496477 0.000002 0 14.063248 0 0 0 0 0 0 0
$definebone "spine_03" "spine_02" 5.278481 0.165541 0.000001 0 2.779475 0 0 0 0 0 0 0
$definebone "clavicle_r" "spine_03" 4.678658 -1.075636 1.488978 66.457891 -74.414952 113.208671 0 0 0 0 0 0
$definebone "upperarm_r" "clavicle_r" -6.214486 -0.000006 -0.000026 -39.224714 171.57942 165.731603 0 0 0 0 0 0
$definebone "lowerarm_r" "upperarm_r" 11.944888 0 -0.000001 -11.599063 34.295715 3.613503 0 0 0 0 0 0
$definebone "hand_r" "lowerarm_r" 10.620186 0 0.000001 40.946069 157.604826 81.848076 0 0 0 0 0 0
$definebone "index_01_r" "hand_r" -4.751108 -0.694487 0.830575 -3.762668 25.53868 14.867227 0 0 0 0 0 0
$definebone "index_02_r" "index_01_r" -1.688072 0.000043 -0.000032 -0.475207 11.986111 1.337741 0 0 0 0 0 0
$definebone "index_03_r" "index_02_r" -1.336136 0.000055 -0.000013 0.996951 -9.496654 1.137548 0 0 0 0 0 0
$definebone "middle_01_r" "hand_r" -4.820498 -0.509457 -0.22476 -7.039528 22.827329 1.918093 0 0 0 0 0 0
$definebone "middle_02_r" "middle_01_r" -1.826988 -0.000064 0.000006 1.136751 12.280667 -2.025003 0 0 0 0 0 0
$definebone "middle_03_r" "middle_02_r" -1.436581 0.000008 0.000003 -4.389712 -15.399553 0.781572 0 0 0 0 0 0
$definebone "pinky_01_r" "hand_r" -3.992359 -0.891186 -1.827909 -18.932815 20.18743 -18.724429 0 0 0 0 0 0
$definebone "pinky_02_r" "pinky_01_r" -1.40593 -0.000027 -0.000005 -1.315567 11.208267 1.063874 0 0 0 0 0 0
$definebone "pinky_03_r" "pinky_02_r" -1.175362 0.000127 -0.000021 3.869413 1.038613 0.445652 0 0 0 0 0 0
$definebone "ring_01_r" "hand_r" -4.526754 -0.690571 -1.120746 -10.988238 23.293489 -13.509884 0 0 0 0 0 0
$definebone "ring_02_r" "ring_01_r" -1.744045 0.000035 -0.00001 -1.669883 13.315315 0.301266 0 0 0 0 0 0
$definebone "ring_03_r" "ring_02_r" -1.368767 0.000024 0.000003 2.98775 -12.899511 -0.360672 0 0 0 0 0 0
$definebone "thumb_01_r" "hand_r" -1.8748 -0.935123 0.999172 36.920246 27.057823 95.069512 0 0 0 0 0 0
$definebone "thumb_02_r" "thumb_01_r" -1.523455 0.000031 0.000031 9.832821 15.151525 1.613448 0 0 0 0 0 0
$definebone "thumb_03_r" "thumb_02_r" -1.599281 0.000004 0.000013 0.480716 -12.38574 2.414098 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" 5.511818 0.000004 0 -0.000388 179.999759 166.489945 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" 0.196849 -0.000002 0.000002 0.000335 -179.999117 160.050416 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 4.678658 -1.075636 -1.488979 66.457925 105.584814 113.208541 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.214489 0.000005 0.000019 39.301752 -8.431132 14.003665 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.944897 -0.000032 -0.000194 -11.598268 -34.295425 -3.61393 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620171 0.000004 0.00001 -40.961676 22.140695 -97.795523 0 0 0 0 0 0
$definebone "index_01_l" "hand_l" 4.751163 0.694378 -0.830471 -3.764675 25.5365 14.866766 0 0 0 0 0 0
$definebone "index_02_l" "index_01_l" 1.688068 -0.000027 0.000003 -0.475153 11.986505 1.337909 0 0 0 0 0 0
$definebone "index_03_l" "index_02_l" 1.336151 -0.000051 -0.000009 -1.907892 -9.554303 1.137831 0 0 0 0 0 0
$definebone "middle_01_l" "hand_l" 4.820518 0.509344 0.224867 -7.04016 22.825891 1.917689 0 0 0 0 0 0
$definebone "middle_02_l" "middle_01_l" 1.827 0.000067 0.000009 1.136749 12.280665 -2.025006 0 0 0 0 0 0
$definebone "middle_03_l" "middle_02_l" 1.436577 -0.00001 0.000007 -0.387834 -15.345021 0.779223 0 0 0 0 0 0
$definebone "pinky_01_l" "hand_l" 3.992355 0.891092 1.827998 -18.934246 20.186216 -18.724948 0 0 0 0 0 0
$definebone "pinky_02_l" "pinky_01_l" 1.405922 0.000023 -0.000002 -1.315971 11.208145 1.063931 0 0 0 0 0 0
$definebone "pinky_03_l" "pinky_02_l" 1.175365 -0.000128 0.000004 7.050421 1.063469 0.448062 0 0 0 0 0 0
$definebone "ring_01_l" "hand_l" 4.526762 0.69046 1.120843 -10.989672 23.292048 -13.510287 0 0 0 0 0 0
$definebone "ring_02_l" "ring_01_l" 1.744045 -0.000028 -0.000002 -1.67017 13.315712 0.301551 0 0 0 0 0 0
$definebone "ring_03_l" "ring_02_l" 1.368763 -0.000037 -0.000017 9.085968 -12.938537 -0.365198 0 0 0 0 0 0
$definebone "thumb_01_l" "hand_l" 1.874853 0.935083 -0.999128 36.919109 27.057074 95.069567 0 0 0 0 0 0
$definebone "thumb_02_l" "thumb_01_l" 1.523457 -0.000032 0.000001 9.832701 15.151412 1.612767 0 0 0 0 0 0
$definebone "thumb_03_l" "thumb_02_l" 1.599285 0.000002 0.000008 4.129711 -12.231674 2.421155 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511808 -0.000002 0.000005 0.000289 0.0004 -13.51017 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.19685 0.000003 0 0.000862 -0.000115 -19.951821 0 0 0 0 0 0
$definebone "cam_driver" "" 0 0 0 0 -89.999982 0 0 0 0 0 0 0
$definebone "Base" "" -4.33264 -16.435041 -3.391094 0 89.999982 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 23.602512 17.970737 -18.23852 -5.623409 -0.189477 -8.287664 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" -35.020477 -8.601431 11.495228 -33.022308 -81.748758 122.464909 0 0 0 0 0 0

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




$animation "runIdle_a_corrective_animation" "v_fist_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_fist_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_fist_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_fist_anims\walk_a_corrective_animation.smd" {
}

$animation "basePose_a" "v_fist_anims\basePose_a.smd" {
	fps 30
	
	
}

$animation "runIdle_a" "v_fist_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
}

$animation "run_a" "v_fist_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
}

$animation "walkIdle_a" "v_fist_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
}

$animation "walk_a" "v_fist_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
}

$animation "proneF" "v_fist_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_fist_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_fist_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_fist_anims\proneR.smd" {
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

$sequence "idle" {
	"v_fist_anims\idle.smd"
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
	"v_fist_anims\draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 1 "MCV_Weapon_Foley_Fists.Draw" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
	fps 30
	  
	
}

$sequence "slash" {
	"v_fist_anims\slash.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	{ event 5004 1 "MCV_Weapon_Foley_Fists.Punch" }
	fadein 0
	fadeout 0.1
	addlayer "walklayer"
	node "2"
	fps 30
	
	
}

$sequence "slash2" {
	"v_fist_anims\slash2.smd"
	activity "ACT_VM_SECONDARYATTACK" 1
	{ event 5004 1 "MCV_Weapon_Foley_Fists.Punch" }
	fadein 0
	fadeout 0.1
	addlayer "walklayer"
	node "2"
	fps 30
	
	
}

$sequence "miss" {
	"v_fist_anims\miss.smd"
	activity "ACT_VM_MISSCENTER1" 1
	{ event 5004 1 "MCV_Weapon_Foley_Fists.MissPunch" }
	fadein 0
	fadeout 0.1
	addlayer "walklayer"
	node "2"
	fps 30
	
	
}

$sequence "miss2" {
	"v_fist_anims\miss2.smd"
	activity "ACT_VM_MISSCENTER2" 1
	{ event 5004 1 "MCV_Weapon_Foley_Fists.MissPunch" }
	fadein 0
	fadeout 0.1
	addlayer "walklayer"
	node "2"
	fps 30
	
	
}

$sequence "stab_charge" {
	"v_fist_anims\stab_charge.smd"
	activity "ACT_VM_FISTS_CHARGE_START" 1
	{ event 5004 1 "MCV_Weapon_Foley_Fists.PowerPunchCharge" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	node "2"
	fps 30
	
	
}

$sequence "stab_charge_loop" {
	"v_fist_anims\stab_charge_loop.smd"
	activity "ACT_VM_FISTS_CHARGE_LOOP" 1
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	node "2"
	fps 30
	loop
	
	
}

$sequence "stab" {
	"v_fist_anims\stab.smd"
	activity "ACT_VM_FISTS_CHARGE_END" 1
	{ event 5004 1 "MCV_Weapon_Foley_Fists.PowerPunch" }
	fadein 0
	fadeout 0.1
	addlayer "walklayer"
	node "2"
	fps 30
	
	
}

$sequence "idletonearwall" {
	"v_fist_anims\idletonearwall.smd"
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
	"v_fist_anims\nearwall.smd"
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
	"v_fist_anims\nearwalltoidle.smd"
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
	"v_fist_anims\pickupstart.smd"
	activity "ACT_VM_PICKUPSTART" 1
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.In" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	  
	
}

$sequence "pickuploop" {
	"v_fist_anims\pickuploop.smd"
	activity "ACT_VM_PICKUPLOOP" 1
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	loop
	
	
}

$sequence "pickupend" {
	"v_fist_anims\pickupend.smd"
	activity "ACT_VM_PICKUPEND" 1
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.Out" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$sequence "holster" {
	"v_fist_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 1 "MCV_Weapon_Foley_Fists.Holster" }
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
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\melee_fist\fist.qc"
//	}
}

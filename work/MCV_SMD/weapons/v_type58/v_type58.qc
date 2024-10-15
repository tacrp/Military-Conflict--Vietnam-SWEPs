// Created by Crowbar 0.74

$modelname "weapons/mcv/v_type58.mdl"

$bodygroup "studio"
{
	studio "type58.smd"
}
$bodygroup "bayonet"
{
	blank
	studio "v_bayonetAK.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 4.343 -17.192 -12.717

$cdmaterials "models\weapons\mcv\v_ak47\"
$cdmaterials "models\weapons\mcv\v_ak47_bayonet\"
$cdmaterials "models\weapons\mcv\v_akm\"
$cdmaterials "models\weapons\mcv\shells\"
$cdmaterials "models\weapons\mcv\v_kbkg60\"

$attachment "muzzle" "Base" -20 0 0.15 rotate 1 180 0
$attachment "eject" "Base" -1 0 0.7 rotate 0 90 0
$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -10.182 -15.541 -27.51 44.566 24.226 2.077

$definebone "root" "" 0 7.450089 -27.509027 0 0 0 0 0 0 0 0 0
$definebone "pelvis" "root" -0.000002 0 0 -89.790623 -89.997175 89.997175 0 0 0 0 0 0
$definebone "spine_01" "pelvis" 4.255466 -0.335183 -0.000002 0 -7.153262 0 0 0 0 0 0 0
$definebone "spine_02" "spine_01" 7.43125 1.496479 0.000002 0 14.063249 0 0 0 0 0 0 0
$definebone "spine_03" "spine_02" 5.278479 0.165544 0.000001 0 2.779475 0 0 0 0 0 0 0
$definebone "clavicle_r" "spine_03" 4.678655 -1.075638 1.488977 66.457884 -74.414959 113.208733 0 0 0 0 0 0
$definebone "upperarm_r" "clavicle_r" -6.214478 -0.000009 -0.000026 -39.361209 171.560801 166.195592 0 0 0 0 0 0
$definebone "lowerarm_r" "upperarm_r" 11.944882 0 0 -11.599005 34.295479 3.613483 0 0 0 0 0 0
$definebone "hand_r" "lowerarm_r" 10.620186 0 0 40.97509 158.047599 82.470983 0 0 0 0 0 0
$definebone "index_01_r" "hand_r" -4.75111 -0.694494 0.830582 -3.762675 25.538683 14.867227 0 0 0 0 0 0
$definebone "index_02_r" "index_01_r" -1.688068 0.000047 -0.000031 -0.475213 11.986115 1.337745 0 0 0 0 0 0
$definebone "index_03_r" "index_02_r" -1.336143 0.000055 -0.00001 0.996946 -9.496594 1.137554 0 0 0 0 0 0
$definebone "middle_01_r" "hand_r" -4.820496 -0.509464 -0.224758 -7.039535 22.827334 1.918093 0 0 0 0 0 0
$definebone "middle_02_r" "middle_01_r" -1.826981 -0.000067 0.000009 1.136744 12.280669 -2.025003 0 0 0 0 0 0
$definebone "middle_03_r" "middle_02_r" -1.436569 0.000004 0.000002 -4.389719 -15.399553 0.781576 0 0 0 0 0 0
$definebone "pinky_01_r" "hand_r" -3.992357 -0.89119 -1.827907 -18.932827 20.18743 -18.724426 0 0 0 0 0 0
$definebone "pinky_02_r" "pinky_01_r" -1.40591 -0.000025 -0.000001 -1.315574 11.208263 1.063867 0 0 0 0 0 0
$definebone "pinky_03_r" "pinky_02_r" -1.175358 0.000127 -0.000018 3.869406 1.038608 0.445644 0 0 0 0 0 0
$definebone "ring_01_r" "hand_r" -4.526751 -0.69058 -1.120739 -10.988246 23.293493 -13.509884 0 0 0 0 0 0
$definebone "ring_02_r" "ring_01_r" -1.744041 0.000036 -0.000003 -1.66989 13.315318 0.301259 0 0 0 0 0 0
$definebone "ring_03_r" "ring_02_r" -1.368771 0.000025 0.000005 2.987742 -12.899505 -0.360677 0 0 0 0 0 0
$definebone "thumb_01_r" "hand_r" -1.874802 -0.935129 0.999175 36.92026 27.057822 95.069526 0 0 0 0 0 0
$definebone "thumb_02_r" "thumb_01_r" -1.523447 0.000032 0.000031 9.832821 15.151525 1.613443 0 0 0 0 0 0
$definebone "thumb_03_r" "thumb_02_r" -1.599281 0.00001 0.000015 0.480713 -12.385745 2.414095 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" 5.511814 0.000006 0.000001 -0.000415 179.999718 166.489945 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" 0.196845 -0.000001 0.000003 0.000362 -179.999117 160.050416 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 4.678655 -1.075635 -1.488978 66.457932 105.584814 113.208528 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.214486 0.000008 0.000019 39.360369 -8.439265 13.8045 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.944884 -0.000031 -0.000196 -11.598266 -34.295466 -3.613934 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620163 0.000004 0.000003 -40.973755 21.950705 -97.52808 0 0 0 0 0 0
$definebone "index_01_l" "hand_l" 4.751156 0.694376 -0.830476 -3.764682 25.536503 14.866772 0 0 0 0 0 0
$definebone "index_02_l" "index_01_l" 1.688068 -0.000027 0.000003 -0.475157 11.986512 1.337913 0 0 0 0 0 0
$definebone "index_03_l" "index_02_l" 1.336151 -0.000053 -0.00001 -1.907894 -9.554295 1.137835 0 0 0 0 0 0
$definebone "middle_01_l" "hand_l" 4.820515 0.509342 0.224863 -7.040164 22.8259 1.917695 0 0 0 0 0 0
$definebone "middle_02_l" "middle_01_l" 1.826996 0.000063 0.00001 1.136743 12.280665 -2.025001 0 0 0 0 0 0
$definebone "middle_03_l" "middle_02_l" 1.436573 -0.000004 0.000009 -0.387838 -15.345009 0.779228 0 0 0 0 0 0
$definebone "pinky_01_l" "hand_l" 3.99235 0.891087 1.827991 -18.934246 20.186228 -18.724943 0 0 0 0 0 0
$definebone "pinky_02_l" "pinky_01_l" 1.405914 0.000026 -0.000006 -1.315972 11.208145 1.063927 0 0 0 0 0 0
$definebone "pinky_03_l" "pinky_02_l" 1.175362 -0.000132 0.000003 7.050414 1.063467 0.448053 0 0 0 0 0 0
$definebone "ring_01_l" "hand_l" 4.526758 0.690462 1.12084 -10.989675 23.292055 -13.510282 0 0 0 0 0 0
$definebone "ring_02_l" "ring_01_l" 1.744049 -0.000031 -0.000003 -1.670173 13.315707 0.301554 0 0 0 0 0 0
$definebone "ring_03_l" "ring_02_l" 1.368755 -0.000032 -0.000014 9.085959 -12.938534 -0.365195 0 0 0 0 0 0
$definebone "thumb_01_l" "hand_l" 1.874851 0.93508 -0.999133 36.919095 27.057076 95.069581 0 0 0 0 0 0
$definebone "thumb_02_l" "thumb_01_l" 1.523453 -0.000032 -0.000001 9.832704 15.151419 1.612756 0 0 0 0 0 0
$definebone "thumb_03_l" "thumb_02_l" 1.599281 -0.000002 0.00001 4.129713 -12.231671 2.421142 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511803 -0.000006 0 0.000292 0.000412 -13.510177 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.196849 0.000001 -0.000002 0.000862 -0.000112 -19.951824 0 0 0 0 0 0
$definebone "cam_driver" "" 0 0 0 0 -89.999982 0 0 0 0 0 0 0
$definebone "Base" "" -3.180958 -17.779638 -3.275469 0 89.999989 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 11.985273 7.963726 -2.247489 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" 3.735498 0.001257 -1.323762 0 0 0 0 0 0 0 0 0
$definebone "Mag" "Base" -0.000669 -0.000546 -1.339116 0 0 0 0 0 0 0 0 0
$definebone "Bullets" "Mag" 0.047661 0 0.671442 0 0 0 0 0 0 0 0 0
$definebone "Lock" "Base" 4.80553 0.899266 -0.325907 0 0 0 0 0 0 0 0 0
$definebone "Bolt" "Base" -1.555565 -0.000546 0.655778 0 0 0 0 0 0 0 0 0
$definebone "Bayonet" "Base" -17.412369 0.316513 -0.959334 0 0 0 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" -3.72439 -2.136778 -2.093782 66.092831 -137.02037 177.158592 0 0 0 0 0 0

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

$poseparameter "player_movement" 0 276 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "runIdle_a_corrective_animation" "v_type58_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_type58_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_type58_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_type58_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_type58_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_type58_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_a_corrective_animation" "v_type58_anims\shoot2_a_corrective_animation.smd" {
}

$animation "shoot2_ironsight_a_corrective_animation" "v_type58_anims\shoot2_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3_a_corrective_animation" "v_type58_anims\shoot3_a_corrective_animation.smd" {
}

$animation "shoot3_ironsight_a_corrective_animation" "v_type58_anims\shoot3_ironsight_a_corrective_animation.smd" {
}

$animation "basePose_a" "v_type58_anims\basePose_a.smd" {
	fps 30
	numframes 60
	
	
}

$animation "ironsight" "v_type58_anims\ironsight.smd" {
	fps 30
	frame 1 1
	numframes 60
	
	
}

$animation "ironsight_transition" "v_type58_anims\ironsight_transition.smd" {
	fps 30
	numframes 60
	
	
}

$animation "runIdle_a" "v_type58_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_type58_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_type58_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_type58_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "shoot1_a" "v_type58_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_type58_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "shoot2_a" "v_type58_anims\shoot2_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_a_corrective_animation" 0
}

$animation "shoot2_ironsight_a" "v_type58_anims\shoot2_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_ironsight_a_corrective_animation" 0
}

$animation "shoot3_a" "v_type58_anims\shoot3_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_a_corrective_animation" 0
}

$animation "shoot3_ironsight_a" "v_type58_anims\shoot3_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_ironsight_a_corrective_animation" 0
}

$animation "nearwall_s_a" "v_type58_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_type58_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_type58_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_type58_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_type58_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_type58_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "proneF" "v_type58_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_type58_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_type58_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_type58_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_type58_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_type58_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_type58_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_type58_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_type58_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_type58_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "bayonet_e_a" "v_type58_anims\bayonet_e_a.smd" {
	fps 30
	
	
}

$animation "bayonet_e_a_i" "v_type58_anims\bayonet_e_a_i.smd" {
	fps 30
	
	
}

$animation "bayonet_s_a" "v_type58_anims\bayonet_s_a.smd" {
	fps 30
	
	
}

$animation "bayonet_s_a_i" "v_type58_anims\bayonet_s_a_i.smd" {
	fps 30
	
	
}

$animation "change_firemode_idle" "v_type58_anims\change_firemode_idle.smd" {
	fps 30
	
	
}

$animation "change_firemode_iron" "v_type58_anims\change_firemode_iron.smd" {
	fps 30
	
	
}

$animation "bayonet_attack_a" "v_type58_anims\bayonet_attack_a.smd" {
	fps 30
	
	
}

$animation "bayonet_attack_a_i" "v_type58_anims\bayonet_attack_a_i.smd" {
	fps 30
	
	
}

$animation "Charge_s_a" "v_type58_anims\Charge_s_a.smd" {
	fps 30
	
	
}

$animation "Charge_s_a_i" "v_type58_anims\Charge_s_a_i.smd" {
	fps 30
	
	
}

$animation "Charge_l_a" "v_type58_anims\Charge_l_a.smd" {
	fps 30
	loop
	
	
}

$animation "Charge_l_a_i" "v_type58_anims\Charge_l_a_i.smd" {
	fps 30
	
	
}

$animation "Charge_e_a" "v_type58_anims\Charge_e_a.smd" {
	fps 30
	
	
}

$animation "Charge_e_a_i" "v_type58_anims\Charge_e_a_i.smd" {
	fps 30
	
	
}

$sequence "runlayer" {
	"runIdle_a"
	"run_a"
	blend "player_movement" 138 232
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
	blend "ironsight" 0 0.5
	blendwidth 3
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
}

$sequence "draw" {
	"v_type58_anims\draw.smd"
	"v_type58_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_AK47.Draw" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	fps 30
	  
	
}

$sequence "Firstdraw" {
	"v_type58_anims\Firstdraw.smd"
	"v_type58_anims\Firstdraw_2.smd"
	activity "ACT_VM_READY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_AK47.Draw" }
	{ event 5004 11 "MCV_Weapon_Foley_AK47.DrawMetal" }
	{ event 5004 22 "MCV_Weapon_Foley_AK47_Reload.MetalStart" }
	{ event 5004 29 "MCV_Weapon_Foley_AK47_Reload.MetalEnd" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	fps 30
	
	
}

$sequence "shoot1" {
	"basePose_a"
	"ironsight_transition"
	"ironsight"
	activity "ACT_VM_PRIMARYATTACK" 1
	blend "ironsight" 0 0.5
	blendwidth 3
	snap
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "shootpose1"
	node "0"
}

$sequence "shoot2" {
	"basePose_a"
	"ironsight_transition"
	"ironsight"
	activity "ACT_VM_PRIMARYATTACK" 1
	blend "ironsight" 0 0.5
	blendwidth 3
	snap
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "shootpose2"
	node "0"
}

$sequence "shoot3" {
	"basePose_a"
	"ironsight_transition"
	"ironsight"
	activity "ACT_VM_PRIMARYATTACK" 1
	blend "ironsight" 0 0.5
	blendwidth 3
	snap
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "shootpose3"
	node "0"
}

$sequence "shootpose1" {
	"shoot1_a"
	"shoot1_ironsight_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	snap
	hidden
}

$sequence "shootpose2" {
	"shoot2_a"
	"shoot2_ironsight_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	snap
	hidden
}

$sequence "shootpose3" {
	"shoot3_a"
	"shoot3_ironsight_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	snap
	hidden
}

$sequence "reload" {
	"v_type58_anims\reload.smd"
	"v_type58_anims\reload_2.smd"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_AK47_Reload.Hand" }
	{ event 5004 12 "MCV_Weapon_Foley_AK47_Reload.MagOut" }
	{ event 5004 45 "MCV_Weapon_Foley_AK47_Reload.MagIn" }
	{ event 5004 60 "MCV_Weapon_Foley_AK47_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 54 "" }
	fadein 0.2
	fadeout 0.2
	//addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "reload_empty" {
	"v_type58_anims\reload_empty.smd"
	"v_type58_anims\reload_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_AK47_Reload.Hand" }
	{ event 5004 12 "MCV_Weapon_Foley_AK47_Reload.MagOut" }
	{ event 5004 45 "MCV_Weapon_Foley_AK47_Reload.MagIn" }
	{ event 5004 60 "MCV_Weapon_Foley_AK47_Reload.HandEnd" }
	{ event 5004 70 "MCV_Weapon_Foley_AK47_Reload.MetalStart" }
	{ event 5004 78 "MCV_Weapon_Foley_AK47_Reload.MetalEnd" }
	{ event 5004 80 "MCV_Weapon_Foley_AK47_Reload.Hand" }
	{ event AE_WPN_COMPLETE_RELOAD 81 "" }
	fadein 0.2
	fadeout 0.2
	//addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "idletonearwall" {
	"nearwall_s_a"
	"nearwall_s_a_i"
	activity "ACT_VM_IDLE_TO_LOWERED" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Nearwall.In" }
	fadein 0.2
	fadeout 0.2
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
	addlayer "walklayer"
	node "0"
}

$sequence "nearwalltoidle" {
	"nearwall_e_a"
	"nearwall_e_a_i"
	activity "ACT_VM_LOWERED_TO_IDLE" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Nearwall.Out" }
	fadein 0.2
	fadeout 0.2
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
	"v_type58_anims\bash.smd"
	"v_type58_anims\bash_2.smd"
	activity "ACT_VM_HITCENTER" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 3200 3 "" }
	{ event 5004 1 "MCV_Weapon_Foley_Bash.Fast" }
	fadein 0
	fadeout 0.2
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
	{ event 5004 1 "MCV_Weapon_Foley_Pickup.In" }
	fadein 0.2
	fadeout 0.2
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
	addlayer "walklayer"
}

$sequence "pickupend" {
	"pickup_e_a"
	"pickup_e_a_i"
	activity "ACT_VM_PICKUPEND" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Pickup.Out" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
}

$sequence "bayonet_unequip" {
	"bayonet_e_a"
	"bayonet_e_a_i"
	activity "ACT_VM_DETACH_SILENCER" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event AE_CL_SETUP_BAYONET 40 "0" }
	{ event 5004 1 "MCV_Weapon_Foley_Bayonet.HandMovement_2" }
	{ event 5004 24 "MCV_Weapon_Foley_Bayonet.KnifeMovement_Off" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
}

$sequence "bayonet_equip" {
	"bayonet_s_a"
	"bayonet_s_a_i"
	activity "ACT_VM_ATTACH_SILENCER" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event AE_CL_SETUP_BAYONET 5 "1" }
	{ event 5004 1 "MCV_Weapon_Foley_Bayonet.HandMovement_1" }
	{ event 5004 22 "MCV_Weapon_Foley_Bayonet.KnifeMovement_On" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
}

$sequence "change_firemode" {
	"change_firemode_idle"
	"change_firemode_iron"
	activity "ACT_VM_FIREMODE" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 6 "MCV_Weapon_Foley_AK47.DrawMetal" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
}

$sequence "holster" {
	"v_type58_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 0 "MCV_Weapon_Foley_AK47.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	fps 30
	
	
}

$sequence "bash_bayonet" {
	"bayonet_attack_a"
	"bayonet_attack_a_i"
	activity "ACT_VM_HITLEFT" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Bash.Fast" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	node "0"
}

$sequence "slash_bayonet" {
	"bayonet_attack_a"
	"bayonet_attack_a_i"
	activity "ACT_VM_HITRIGHT" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 3200 3 "" }
	{ event 5004 1 "MCV_Weapon_Foley_Bash.Fast" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	node "0"
}

$sequence "ChargeStart" {
	"Charge_s_a"
	"Charge_s_a_i"
	activity "ACT_VM_CHARGE_START" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0
	fadeout 0.2
	node "0"
}

$sequence "ChargeLoop" {
	"Charge_l_a"
	"Charge_l_a_i"
	activity "ACT_VM_CHARGE_LOOP" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0
	fadeout 0.2
	node "0"
}

$sequence "ChargeStab" {
	"Charge_e_a"
	"Charge_e_a_i"
	activity "ACT_VM_CHARGE_STAB" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0
	fadeout 0.2
	node "0"
}

$includemodel "weapons/gesture_animations.mdl"

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\guns\rifle_ak47\type58.qc"
//	}
}

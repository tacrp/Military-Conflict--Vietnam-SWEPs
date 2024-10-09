// Created by Crowbar 0.74

$modelname "weapons/mcv/v_t223.mdl"

$bodygroup "studio"
{
	studio "HK33_ref.smd"
}
$bodygroup "bayonet"
{
	blank
	studio "hk33_v_bayonet.smd"
}
$bodygroup "magazine"
{
	studio "magazine_25.smd"
	studio "magazine_40.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition 2.879 -18.644 -12.161

$cdmaterials "models\weapons\mcv\v_t223\"
$cdmaterials "models\weapons\mcv\shells\"
$cdmaterials "models\weapons\mcv\v_bayonet\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "Base" -23.8 0 0.4 rotate 0 180 0
$attachment "eject" "Base" -2 0.5 1 rotate -15 90 0

$cbox 0 0 0 0 0 0

$bbox -9.182 -15.599 -27.51 46.469 21.356 3.189

$definebone "root" "" 0 7.450089 -27.509027 0 0 0 0 0 0 0 0 0
$definebone "pelvis" "root" -0.000002 0 0 -89.790623 -89.990645 89.990645 0 0 0 0 0 0
$definebone "spine_01" "pelvis" 4.255465 -0.335182 -0.000001 0 -7.15309 0 0 0 0 0 0 0
$definebone "spine_02" "spine_01" 7.431253 1.496462 0.000003 0 14.063134 0 0 0 0 0 0 0
$definebone "spine_03" "spine_02" 5.278479 0.165541 0.000002 0 2.779591 0 0 0 0 0 0 0
$definebone "clavicle_r" "spine_03" 4.678656 -1.075645 1.488978 66.457829 -74.414843 113.209019 0 0 0 0 0 0
$definebone "upperarm_r" "clavicle_r" -6.214479 -0.000005 -0.000034 -39.361161 171.560746 166.195674 0 0 0 0 0 0
$definebone "lowerarm_r" "upperarm_r" 11.944891 0 0 -11.598964 34.295497 -86.386532 0 0 0 0 0 0
$definebone "hand_r" "lowerarm_r" 10.620182 -0.000001 -0.000002 -16.394129 136.880666 7.275615 0 0 0 0 0 0
$definebone "index_01_r" "hand_r" -4.751104 -0.694489 0.830571 -3.762617 25.538738 14.867222 0 0 0 0 0 0
$definebone "index_02_r" "index_01_r" -1.688061 0.00005 -0.000033 -0.47533 11.985929 1.337626 0 0 0 0 0 0
$definebone "index_03_r" "index_02_r" -1.336143 0.000053 -0.000011 0.996828 -9.496723 1.137607 0 0 0 0 0 0
$definebone "middle_01_r" "hand_r" -4.820492 -0.509453 -0.224765 -7.039534 22.827155 1.918088 0 0 0 0 0 0
$definebone "middle_02_r" "middle_01_r" -1.826981 -0.000072 0.000004 1.136746 12.280771 -2.025065 0 0 0 0 0 0
$definebone "middle_03_r" "middle_02_r" -1.436581 0.00001 0.000001 -4.389718 -15.399618 0.781568 0 0 0 0 0 0
$definebone "pinky_01_r" "hand_r" -3.992353 -0.891186 -1.827913 -18.932823 20.187307 -18.724494 0 0 0 0 0 0
$definebone "pinky_02_r" "pinky_01_r" -1.40591 -0.000024 -0.000001 -1.315571 11.20831 1.063807 0 0 0 0 0 0
$definebone "pinky_03_r" "pinky_02_r" -1.175354 0.000129 -0.000021 3.86947 1.038653 0.445813 0 0 0 0 0 0
$definebone "ring_01_r" "hand_r" -4.526745 -0.690569 -1.120748 -10.988188 23.29337 -13.509828 0 0 0 0 0 0
$definebone "ring_02_r" "ring_01_r" -1.744034 0.000031 -0.000008 -1.669889 13.315358 0.301147 0 0 0 0 0 0
$definebone "ring_03_r" "ring_02_r" -1.368778 0.000027 -0.000001 2.987683 -12.899576 -0.36079 0 0 0 0 0 0
$definebone "thumb_01_r" "hand_r" -1.874798 -0.935127 0.999171 36.92014 27.058281 95.069683 0 0 0 0 0 0
$definebone "thumb_02_r" "thumb_01_r" -1.523453 0.000038 0.000012 9.832641 15.151526 1.613396 0 0 0 0 0 0
$definebone "thumb_03_r" "thumb_02_r" -1.599285 0.000006 0.000007 0.480249 -12.385859 2.414276 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" 5.511814 0.000002 0.000006 -0.000324 -179.999308 76.489888 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" 0.196848 -0.000002 0.000006 0.000598 -179.999172 160.050348 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 4.678655 -1.075644 -1.488977 66.457925 105.584698 113.208582 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.214487 0.00001 0.00002 39.360369 -8.43921 13.80445 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.944893 -0.000035 -0.000201 -11.598202 -34.295527 -3.613813 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620174 0.00001 -0.000007 -40.973803 21.950768 -97.528244 0 0 0 0 0 0
$definebone "index_01_l" "hand_l" 4.751154 0.694378 -0.830468 -3.764966 25.536691 14.866764 0 0 0 0 0 0
$definebone "index_02_l" "index_01_l" 1.688072 -0.000034 -0.000002 -0.474981 11.986294 1.338025 0 0 0 0 0 0
$definebone "index_03_l" "index_02_l" 1.336155 -0.000051 -0.000009 -1.907777 -9.554401 1.137776 0 0 0 0 0 0
$definebone "middle_01_l" "hand_l" 4.820507 0.50934 0.224872 -7.040222 22.826023 1.917801 0 0 0 0 0 0
$definebone "middle_02_l" "middle_01_l" 1.826988 0.000063 0.00001 1.137032 12.280504 -2.025067 0 0 0 0 0 0
$definebone "middle_03_l" "middle_02_l" 1.436584 -0.000008 0.000013 -0.388068 -15.344831 0.779276 0 0 0 0 0 0
$definebone "pinky_01_l" "hand_l" 3.992348 0.891083 1.828003 -18.934427 20.186349 -18.724779 0 0 0 0 0 0
$definebone "pinky_02_l" "pinky_01_l" 1.405922 0.000021 -0.000007 -1.316032 11.208214 1.06392 0 0 0 0 0 0
$definebone "pinky_03_l" "pinky_02_l" 1.175362 -0.000134 -0.000001 7.050752 1.063249 0.447935 0 0 0 0 0 0
$definebone "ring_01_l" "hand_l" 4.526749 0.69046 1.120851 -10.989678 23.292016 -13.510231 0 0 0 0 0 0
$definebone "ring_02_l" "ring_01_l" 1.744049 -0.000025 0 -1.67041 13.315899 0.301602 0 0 0 0 0 0
$definebone "ring_03_l" "ring_02_l" 1.368752 -0.000031 -0.000017 9.086242 -12.938746 -0.365317 0 0 0 0 0 0
$definebone "thumb_01_l" "hand_l" 1.874849 0.935081 -0.99913 36.918815 27.057262 95.069738 0 0 0 0 0 0
$definebone "thumb_02_l" "thumb_01_l" 1.523453 -0.00004 -0.000007 9.832717 15.151134 1.612585 0 0 0 0 0 0
$definebone "thumb_03_l" "thumb_02_l" 1.599295 -0.000002 0.000006 4.129836 -12.231611 2.42143 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511808 0.000002 -0.000002 0.000242 0.00035 -13.510341 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.196848 0.000001 -0.000003 0.000861 -0.000114 -19.951763 0 0 0 0 0 0
$definebone "cam_driver" "" 0 0 0 0 -89.999982 0 0 0 0 0 0 0
$definebone "Base" "" -3.747713 -17.896368 -3.297164 0 89.999989 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 12.102001 7.396967 -2.225795 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" 2.342424 0.001256 -1.808252 0 0 0 0 0 0 0 0 0
$definebone "Mag" "Base" -2.262188 -0.00628 0.149031 0 0 0 0 0 0 0 0 0
$definebone "Bullet" "Mag" 0.058435 0.000669 0.097283 0 0 0 0 0 0 0 0 0
$definebone "Bolt" "Base" -1.679785 0.046172 1.315665 0 0 0 0 0 0 0 0 0
$definebone "MagRelease" "Base" -0.093019 -0.032775 -2.117049 0 0 0 0 0 0 0 0 0
$definebone "Boltpuller" "Base" -13.154221 -0.010034 1.492174 0 0 0 0 0 0 0 0 0
$definebone "BoltpullerRotator" "Boltpuller" 0.868309 0 0 0 0 0 0 0 0 0 0 0
$definebone "Bayonet" "Base" -19.644432 0.168059 -1.459648 0 0 0 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" -5.558571 -2.252018 -1.073878 72.793861 -123.287428 -168.323933 0 0 0 0 0 0

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

$poseparameter "player_movement" 0 241 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "runIdle_a_corrective_animation" "v_t223_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_t223_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_t223_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_t223_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_t223_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_t223_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_a_corrective_animation" "v_t223_anims\shoot2_a_corrective_animation.smd" {
}

$animation "shoot2_ironsight_a_corrective_animation" "v_t223_anims\shoot2_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3_a_corrective_animation" "v_t223_anims\shoot3_a_corrective_animation.smd" {
}

$animation "shoot3_ironsight_a_corrective_animation" "v_t223_anims\shoot3_ironsight_a_corrective_animation.smd" {
}

$animation "basePose_a" "v_t223_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "ironsight" "v_t223_anims\ironsight.smd" {
	fps 0.5
	
	
}

$animation "ironsight_transition" "v_t223_anims\ironsight_transition.smd" {
	fps 0.5
	
	
}

$animation "runIdle_a" "v_t223_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_t223_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_t223_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_t223_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "shoot1_a" "v_t223_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_t223_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "shoot2_a" "v_t223_anims\shoot2_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_a_corrective_animation" 0
}

$animation "shoot2_ironsight_a" "v_t223_anims\shoot2_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_ironsight_a_corrective_animation" 0
}

$animation "shoot3_a" "v_t223_anims\shoot3_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_a_corrective_animation" 0
}

$animation "shoot3_ironsight_a" "v_t223_anims\shoot3_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_ironsight_a_corrective_animation" 0
}

$animation "nearwall_s_a" "v_t223_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_t223_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_t223_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_t223_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_t223_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_t223_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "proneF" "v_t223_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_t223_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_t223_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_t223_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_t223_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_t223_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_t223_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_t223_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_t223_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_t223_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "change_firemode_idle" "v_t223_anims\change_firemode_idle.smd" {
	fps 30
	
	
}

$animation "change_firemode_iron" "v_t223_anims\change_firemode_iron.smd" {
	fps 30
	
	
}

$animation "bayonet_attack_a" "v_t223_anims\bayonet_attack_a.smd" {
	fps 30
	
	
}

$animation "bayonet_attack_a_i" "v_t223_anims\bayonet_attack_a_i.smd" {
	fps 30
	
	
}

$animation "bayonet_e_a" "v_t223_anims\bayonet_e_a.smd" {
	fps 30
	
	
}

$animation "bayonet_e_a_i" "v_t223_anims\bayonet_e_a_i.smd" {
	fps 30
	
	
}

$animation "bayonet_s_a" "v_t223_anims\bayonet_s_a.smd" {
	fps 30
	
	
}

$animation "bayonet_s_a_i" "v_t223_anims\bayonet_s_a_i.smd" {
	fps 30
	
	
}

$sequence "runlayer" {
	"runIdle_a"
	"run_a"
	blend "player_movement" 145 241
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
	blend "player_movement" 0 241
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
	blend "player_movement" 0 145
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
	node "0"
}

$sequence "draw" {
	"v_t223_anims\draw.smd"
	"v_t223_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_T223.Draw" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$sequence "Firstdraw" {
	"v_t223_anims\Firstdraw.smd"
	"v_t223_anims\Firstdraw_2.smd"
	activity "ACT_VM_READY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_T223.Draw" }
	{ event 5004 9 "MCV_Weapon_Foley_T223.DrawMetal" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
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
	node "Fire"
}

$sequence "reload" {
	"v_t223_anims\reload.smd"
	"v_t223_anims\reload_2.smd"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_T223_Reload.Hand" }
	{ event 5004 15 "MCV_Weapon_Foley_T223_Reload.MagOut" }
	{ event 5004 65 "MCV_Weapon_Foley_T223_Reload.MagIn" }
	{ event 5004 80 "MCV_Weapon_Foley_T223_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 50 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "reload_empty" {
	"v_t223_anims\reload_empty.smd"
	"v_t223_anims\reload_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_T223_Reload.Hand" }
	{ event 5004 8 "MCV_Weapon_Foley_T223_Reload.MetalStart" }
	{ event 5004 14 "MCV_Weapon_Foley_T223_Reload.MetalMid" }
	{ event 5004 21 "MCV_Weapon_Foley_T223_Reload.MetalEnd" }
	{ event 5004 33 "MCV_Weapon_Foley_T223_Reload.Hand" }
	{ event 5004 47 "MCV_Weapon_Foley_T223_Reload.MagOut" }
	{ event 5004 95 "MCV_Weapon_Foley_T223_Reload.MagIn" }
	{ event 5004 115 "MCV_Weapon_Foley_T223_Reload.HandEnd" }
	{ event 5004 122 "MCV_Weapon_Foley_T223.DrawMetal" }
	{ event AE_WPN_COMPLETE_RELOAD 79 "" }
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
	"v_t223_anims\bash.smd"
	"v_t223_anims\bash_2.smd"
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

$sequence "bayonet_unequip" {
	"bayonet_e_a"
	"bayonet_e_a_i"
	activity "ACT_VM_DETACH_SILENCER" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event AE_CL_BODYGROUP_SET_VALUE 35 "bayonet 0" }
	{ event 5004 1 "MCV_Weapon_Foley_Bayonet.HandMovement_3" }
	{ event 5004 25 "MCV_Weapon_Foley_Bayonet.KnifeMovement_Off" }
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
	{ event AE_CL_BODYGROUP_SET_VALUE 5 "bayonet 1" }
	{ event 5004 1 "MCV_Weapon_Foley_Bayonet.HandMovement_1" }
	{ event 5004 21 "MCV_Weapon_Foley_Bayonet.KnifeMovement_On" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
}

$sequence "holster" {
	"v_t223_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 0 "MCV_Weapon_Foley_T223.Holster" }
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\guns\rifle_hk33\hk33.qc"
//	}
}

// Created by Crowbar 0.74

$modelname "weapons/mcv/v_mk4mod0.mdl"

$bodygroup "studio"
{
	studio "mk4mod0.smd"
}
$bodygroup "magazine"
{
	studio "magazine_20.smd"
}
$bodygroup "tape"
{
	blank
	studio "tape.smd"
}
$bodygroup "clamped1"
{
	studio "body3_model0.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 6.88 -19.162 -12.851

$cdmaterials "models\weapons\mcv\v_m16a1\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "Base" -33.5 0 1 rotate 0 -180 0
$attachment "eject" "Base" 0.5 0.4 1 rotate 0 90 0

$cbox 0 0 0 0 0 0

$bbox -11.182 -15.939 -27.51 49.506 29.699 1.808

$definebone "root" "" 0 7.450089 -27.509027 0 0 0 0 0 0 0 0 0
$definebone "pelvis" "root" -0.000002 0 0 -89.790623 -89.997175 89.997175 0 0 0 0 0 0
$definebone "spine_01" "pelvis" 4.255465 -0.335186 -0.000002 0 -7.153262 0 0 0 0 0 0 0
$definebone "spine_02" "spine_01" 7.431252 1.496481 0.000002 0 14.063249 0 0 0 0 0 0 0
$definebone "spine_03" "spine_02" 5.278479 0.165545 0.000001 0 2.779475 0 0 0 0 0 0 0
$definebone "clavicle_r" "spine_03" 4.678655 -1.075636 1.488977 66.457884 -74.414904 113.208787 0 0 0 0 0 0
$definebone "upperarm_r" "clavicle_r" -6.214477 -0.000011 -0.000029 -20.29233 105.915327 -160.563527 0 0 0 0 0 0
$definebone "lowerarm_r" "upperarm_r" 11.944897 0 -0.000001 -19.041261 71.343368 -6.525943 0 0 0 0 0 0
$definebone "hand_r" "lowerarm_r" 10.620189 0 0 -19.36066 148.881854 116.034641 0 0 0 0 0 0
$definebone "index_01_r" "hand_r" -4.751113 -0.694494 0.830564 -3.762671 25.538666 14.867232 0 0 0 0 0 0
$definebone "index_02_r" "index_01_r" -1.68807 0.000046 -0.000032 -0.475216 11.986088 1.337751 0 0 0 0 0 0
$definebone "index_03_r" "index_02_r" -1.336142 0.000053 -0.000012 0.996943 -9.496617 1.13756 0 0 0 0 0 0
$definebone "middle_01_r" "hand_r" -4.820506 -0.50946 -0.224766 -7.039531 22.827317 1.918099 0 0 0 0 0 0
$definebone "middle_02_r" "middle_01_r" -1.826996 -0.000067 0.000009 1.136746 12.280653 -2.024996 0 0 0 0 0 0
$definebone "middle_03_r" "middle_02_r" -1.436584 0.00001 0.000002 -4.389714 -15.399561 0.78158 0 0 0 0 0 0
$definebone "pinky_01_r" "hand_r" -3.992369 -0.891186 -1.827909 -18.93282 20.187415 -18.724426 0 0 0 0 0 0
$definebone "pinky_02_r" "pinky_01_r" -1.405922 -0.000025 -0.000001 -1.315567 11.208247 1.06387 0 0 0 0 0 0
$definebone "pinky_03_r" "pinky_02_r" -1.175365 0.000127 -0.000018 3.869416 1.038531 0.445649 0 0 0 0 0 0
$definebone "ring_01_r" "hand_r" -4.526762 -0.690576 -1.120749 -10.98824 23.293474 -13.50988 0 0 0 0 0 0
$definebone "ring_02_r" "ring_01_r" -1.744053 0.000039 -0.000011 -1.66988 13.315298 0.301264 0 0 0 0 0 0
$definebone "ring_03_r" "ring_02_r" -1.368765 0.000021 0.000006 2.987751 -12.899522 -0.360674 0 0 0 0 0 0
$definebone "thumb_01_r" "hand_r" -1.87481 -0.935125 0.999169 36.920253 27.057801 95.069533 0 0 0 0 0 0
$definebone "thumb_02_r" "thumb_01_r" -1.523455 0.00003 0.000028 9.832798 15.15153 1.613445 0 0 0 0 0 0
$definebone "thumb_03_r" "thumb_02_r" -1.599287 -0.000002 0.000013 0.480696 -12.385736 2.4141 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" 5.511818 0.000007 -0.000003 -0.000435 179.999855 166.489945 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" 0.196846 -0.000004 0.000003 0.000362 -179.999144 160.050416 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 4.678653 -1.075635 -1.488978 66.457932 105.584814 113.208528 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.214489 0.00001 0.000021 29.318427 -121.108775 -45.330306 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.944905 -0.000028 -0.000181 -17.670534 -60.993931 3.257665 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620168 0.00001 0.000014 10.551391 -134.695879 -170.436989 0 0 0 0 0 0
$definebone "index_01_l" "hand_l" 4.751158 0.694371 -0.830469 -3.764674 25.536496 14.866764 0 0 0 0 0 0
$definebone "index_02_l" "index_01_l" 1.688066 -0.000028 0.000002 -0.475152 11.986502 1.337912 0 0 0 0 0 0
$definebone "index_03_l" "index_02_l" 1.336142 -0.000052 -0.000009 -1.907891 -9.554309 1.137834 0 0 0 0 0 0
$definebone "middle_01_l" "hand_l" 4.820516 0.509334 0.224868 -7.04016 22.825888 1.917689 0 0 0 0 0 0
$definebone "middle_02_l" "middle_01_l" 1.827001 0.000062 0.000009 1.136749 12.280657 -2.025004 0 0 0 0 0 0
$definebone "middle_03_l" "middle_02_l" 1.436585 -0.000012 0.000007 -0.387835 -15.345012 0.779223 0 0 0 0 0 0
$definebone "pinky_01_l" "hand_l" 3.992354 0.891086 1.827996 -18.934193 20.186216 -18.72495 0 0 0 0 0 0
$definebone "pinky_02_l" "pinky_01_l" 1.405922 0.00002 -0.000007 -1.315968 11.208142 1.063923 0 0 0 0 0 0
$definebone "pinky_03_l" "pinky_02_l" 1.175364 -0.000131 0.000005 7.050423 1.063463 0.448049 0 0 0 0 0 0
$definebone "ring_01_l" "hand_l" 4.526761 0.690455 1.120844 -10.989672 23.292045 -13.510293 0 0 0 0 0 0
$definebone "ring_02_l" "ring_01_l" 1.744045 -0.000033 -0.000003 -1.670167 13.315704 0.301541 0 0 0 0 0 0
$definebone "ring_03_l" "ring_02_l" 1.368765 -0.000033 -0.000016 9.085969 -12.93854 -0.365213 0 0 0 0 0 0
$definebone "thumb_01_l" "hand_l" 1.874849 0.93508 -0.999128 36.919119 27.05707 95.069574 0 0 0 0 0 0
$definebone "thumb_02_l" "thumb_01_l" 1.523454 -0.000029 -0.000001 9.832696 15.151402 1.612762 0 0 0 0 0 0
$definebone "thumb_03_l" "thumb_02_l" 1.59928 0.000004 0.000008 4.129702 -12.231685 2.421148 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511807 0 0.000007 0.00029 0.000404 -13.510173 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.196851 -0.000002 -0.000001 0.000862 -0.000116 -19.951823 0 0 0 0 0 0
$definebone "cam_driver" "" 0 0 0 0 -89.999982 0 0 0 0 0 0 0
$definebone "Base" "" -4.186056 -19.136522 -4.481611 0 89.999989 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 11.760715 6.958622 -0.973792 -5.623409 89.810506 -8.287662 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" 11.558132 -4.409515 -0.804688 -74.11495 55.708809 -136.893834 0 0 0 0 0 0
$definebone "Mag" "Base" 0.050734 -0.015066 -0.906442 0 0 0 0 0 0 0 0 0
$definebone "Bullet" "Mag" 0.026926 -0.17447 1.260252 0 0 0 0 0 0 0 0 0
$definebone "BulletMove" "Bullet" 0 0.345212 0.242352 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" 3.332498 -0.00328 -0.934897 0 0 0 0 0 0 0 0 0
$definebone "Bolt" "Base" 0.381264 0.001025 0.888928 0 0 0 0 0 0 0 0 0
$definebone "MagRelease" "Base" 1.813139 0.139036 -0.745562 0 0 0 0 0 0 0 0 0
$definebone "BoltCover" "Base" 0.381264 0.630692 0.557508 0 0 0 0 0 0 0 0 0
$definebone "Boltpuller" "Base" 6.501181 0.256563 2.048409 0 0 0 0 0 0 0 0 0

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




$animation "runIdle_a_corrective_animation" "v_mk4mod0_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_mk4mod0_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_mk4mod0_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_mk4mod0_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_mk4mod0_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_mk4mod0_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_a_corrective_animation" "v_mk4mod0_anims\shoot2_a_corrective_animation.smd" {
}

$animation "shoot2_ironsight_a_corrective_animation" "v_mk4mod0_anims\shoot2_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3_a_corrective_animation" "v_mk4mod0_anims\shoot3_a_corrective_animation.smd" {
}

$animation "shoot3_ironsight_a_corrective_animation" "v_mk4mod0_anims\shoot3_ironsight_a_corrective_animation.smd" {
}

$animation "basePose_a" "v_mk4mod0_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "ironsight" "v_mk4mod0_anims\ironsight.smd" {
	fps 0.5
	
	
}

$animation "ironsight_transition" "v_mk4mod0_anims\ironsight_transition.smd" {
	fps 0.5
	
	
}

$animation "runIdle_a" "v_mk4mod0_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_mk4mod0_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_mk4mod0_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_mk4mod0_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "shoot1_a" "v_mk4mod0_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_mk4mod0_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "shoot2_a" "v_mk4mod0_anims\shoot2_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_a_corrective_animation" 0
}

$animation "shoot2_ironsight_a" "v_mk4mod0_anims\shoot2_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_ironsight_a_corrective_animation" 0
}

$animation "shoot3_a" "v_mk4mod0_anims\shoot3_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_a_corrective_animation" 0
}

$animation "shoot3_ironsight_a" "v_mk4mod0_anims\shoot3_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_ironsight_a_corrective_animation" 0
}

$animation "nearwall_s_a" "v_mk4mod0_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_mk4mod0_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_mk4mod0_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_mk4mod0_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_mk4mod0_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_mk4mod0_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "proneF" "v_mk4mod0_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_mk4mod0_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_mk4mod0_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_mk4mod0_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_mk4mod0_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_mk4mod0_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_mk4mod0_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_mk4mod0_anims\pickup_a_i.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_e_a" "v_mk4mod0_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_mk4mod0_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "change_firemode_idle" "v_mk4mod0_anims\change_firemode_idle.smd" {
	fps 30
	
	
}

$animation "change_firemode_iron" "v_mk4mod0_anims\change_firemode_iron.smd" {
	fps 30
	
	
}

$animation "bayonet_attack_a" "v_mk4mod0_anims\bayonet_attack_a.smd" {
	fps 30
	
	
}

$animation "bayonet_attack_a_i" "v_mk4mod0_anims\bayonet_attack_a_i.smd" {
	fps 30
	
	
}

$animation "bayonet_e_a" "v_mk4mod0_anims\bayonet_e_a.smd" {
	fps 30
	
	
}

$animation "bayonet_e_a_i" "v_mk4mod0_anims\bayonet_e_a_i.smd" {
	fps 30
	
	
}

$animation "bayonet_s_a" "v_mk4mod0_anims\bayonet_s_a.smd" {
	fps 30
	
	
}

$animation "bayonet_s_a_i" "v_mk4mod0_anims\bayonet_s_a_i.smd" {
	fps 30
	
	
}

$animation "Charge_s_a" "v_mk4mod0_anims\Charge_s_a.smd" {
	fps 30
	
	
}

$animation "Charge_s_a_i" "v_mk4mod0_anims\Charge_s_a_i.smd" {
	fps 30
	
	
}

$animation "Charge_l_a" "v_mk4mod0_anims\Charge_l_a.smd" {
	fps 30
	loop
	
	
}

$animation "Charge_l_a_i" "v_mk4mod0_anims\Charge_l_a_i.smd" {
	fps 30
	
	
}

$animation "Charge_e_a" "v_mk4mod0_anims\Charge_e_a.smd" {
	fps 30
	
	
}

$animation "Charge_e_a_i" "v_mk4mod0_anims\Charge_e_a_i.smd" {
	fps 30
	
	
}

$sequence "runlayer" {
	"runIdle_a"
	"run_a"
	blend "player_movement" 148 245
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
	node "0"
}

$sequence "draw" {
	"v_mk4mod0_anims\draw.smd"
	"v_mk4mod0_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M16A1.Draw" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	  
	
}

$sequence "Firstdraw" {
	"v_mk4mod0_anims\Firstdraw.smd"
	"v_mk4mod0_anims\Firstdraw_2.smd"
	activity "ACT_VM_FIRSTDRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M16A1.Draw" }
	{ event 5004 9 "MCV_Weapon_Foley_M16A1.DrawMetalStart" }
	{ event 5004 15 "MCV_Weapon_Foley_M16A1.DrawMetalEnd" }
	fadein 0
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
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "reload" {
	"v_mk4mod0_anims\reload.smd"
	"v_mk4mod0_anims\reload_2.smd"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M16A1_Reload.Hand" }
	{ event 5004 6 "MCV_Weapon_Foley_M16A1_Reload.MagOut" }
	{ event 5004 44 "MCV_Weapon_Foley_M16A1_Reload.MagIn" }
	{ event 5004 50 "MCV_Weapon_Foley_M16A1_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 48 "" }
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
	
	
}

$sequence "reload_empty" {
	"v_mk4mod0_anims\reload_empty.smd"
	"v_mk4mod0_anims\reload_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M16A1_Reload.Hand" }
	{ event 5004 6 "MCV_Weapon_Foley_M16A1_Reload.MagOut" }
	{ event 5004 44 "MCV_Weapon_Foley_M16A1_Reload.MagIn" }
	{ event 5004 57 "MCV_Weapon_Foley_M16A1_Reload.HandEnd" }
	{ event 5004 67 "MCV_Weapon_Foley_M16A1_Reload.MetalStart" }
	{ event 5004 75 "MCV_Weapon_Foley_M16A1_Reload.MetalEnd" }
	{ event 5004 80 "MCV_Weapon_Foley_M16A1_Reload.Hand" }
	{ event AE_WPN_COMPLETE_RELOAD 79 "" }
	fadein 0.2
	fadeout 0.2
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
	"v_mk4mod0_anims\bash.smd"
	"v_mk4mod0_anims\bash_2.smd"
	activity "ACT_VM_BASH" 1
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

$sequence "holster" {
	"v_mk4mod0_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 0 "MCV_Weapon_Foley_M16A1.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$sequence "bash_bayonet" {
	"bayonet_attack_a"
	"bayonet_attack_a_i"
	activity "ACT_VM_BASH_BAYONET" 1
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
	activity "ACT_VM_SLASH_BAYONET" 1
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
	activity "ACT_VM_BAYONET_UNEQUIP" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event AE_CL_SETUP_BAYONET 40 "0" }
	{ event 5004 1 "MCV_Weapon_Foley_Bayonet.HandMovement_3" }
	{ event 5004 24 "MCV_Weapon_Foley_Bayonet.KnifeMovement_Off" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
}

$sequence "bayonet_equip" {
	"bayonet_s_a"
	"bayonet_s_a_i"
	activity "ACT_VM_BAYONET_EQUIP" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event AE_CL_SETUP_BAYONET 5 "1" }
	{ event 5004 1 "MCV_Weapon_Foley_Bayonet.HandMovement_2" }
	{ event 5004 22 "MCV_Weapon_Foley_Bayonet.KnifeMovement_On" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
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
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\rifle_m16a1\mk4mod0.qc"
//	}
}

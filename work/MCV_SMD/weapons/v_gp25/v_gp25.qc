// Created by Crowbar 0.74

$modelname "weapons/mcv/v_gp25.mdl"

$bodygroup "studio"
{
	studio "RefGP25_new.smd"
}
$bodygroup "bayonet"
{
	blank
	studio "v_bayonetAKM.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 3.837 -16.424 -12.415

$cdmaterials "models\weapons\mcv\v_akm\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "Base" -20 0 0.15 rotate 0 180 0
$attachment "muzzle2" "Base" -14 0 -1.95 rotate 0 -180 0
$attachment "eject" "Base" -1 0 0.7 rotate 0 90 0

$cbox 0 0 0 0 0 0

$bbox -10.182 -15.437 -27.51 43.031 23.112 2.68

$definebone "root" "" 0 7.450089 -27.509027 0 0 0 0 0 0 0 0 0
$definebone "pelvis" "root" -0.000002 0 0 -89.790623 -89.997175 89.997175 0 0 0 0 0 0
$definebone "spine_01" "pelvis" 4.255465 -0.335184 -0.000002 0 -7.153262 0 0 0 0 0 0 0
$definebone "spine_02" "spine_01" 7.43125 1.496479 0.000002 0 14.063249 0 0 0 0 0 0 0
$definebone "spine_03" "spine_02" 5.278479 0.165543 0.000001 0 2.779475 0 0 0 0 0 0 0
$definebone "clavicle_r" "spine_03" 4.678654 -1.075638 1.488977 66.457884 -74.414904 113.208787 0 0 0 0 0 0
$definebone "upperarm_r" "clavicle_r" -6.214478 -0.00001 -0.000027 -39.361195 171.560801 166.195592 0 0 0 0 0 0
$definebone "lowerarm_r" "upperarm_r" 11.944889 0 0 -11.599025 34.295469 3.613493 0 0 0 0 0 0
$definebone "hand_r" "lowerarm_r" 10.62019 0 0 40.97506 158.04764 82.471003 0 0 0 0 0 0
$definebone "index_01_r" "hand_r" -4.75111 -0.694494 0.830579 -3.762674 25.538677 14.867227 0 0 0 0 0 0
$definebone "index_02_r" "index_01_r" -1.688076 0.000043 -0.000031 -0.475215 11.986106 1.337745 0 0 0 0 0 0
$definebone "index_03_r" "index_02_r" -1.336143 0.000053 -0.00001 0.996943 -9.4966 1.137553 0 0 0 0 0 0
$definebone "middle_01_r" "hand_r" -4.820496 -0.509459 -0.224761 -7.039534 22.827327 1.918092 0 0 0 0 0 0
$definebone "middle_02_r" "middle_01_r" -1.826992 -0.000072 0.000008 1.136745 12.280659 -2.025004 0 0 0 0 0 0
$definebone "middle_03_r" "middle_02_r" -1.436573 0.000008 0.000004 -4.389717 -15.399551 0.781572 0 0 0 0 0 0
$definebone "pinky_01_r" "hand_r" -3.992359 -0.891186 -1.82791 -18.932823 20.187427 -18.724429 0 0 0 0 0 0
$definebone "pinky_02_r" "pinky_01_r" -1.405922 -0.000027 0 -1.315569 11.208258 1.063868 0 0 0 0 0 0
$definebone "pinky_03_r" "pinky_02_r" -1.175358 0.000128 -0.000021 3.869413 1.038599 0.445646 0 0 0 0 0 0
$definebone "ring_01_r" "hand_r" -4.526752 -0.690575 -1.120744 -10.988245 23.293488 -13.509885 0 0 0 0 0 0
$definebone "ring_02_r" "ring_01_r" -1.744038 0.000033 -0.000004 -1.669884 13.315302 0.301258 0 0 0 0 0 0
$definebone "ring_03_r" "ring_02_r" -1.368774 0.000025 0.000004 2.987748 -12.899518 -0.36068 0 0 0 0 0 0
$definebone "thumb_01_r" "hand_r" -1.874798 -0.935122 0.999175 36.920253 27.057822 95.069526 0 0 0 0 0 0
$definebone "thumb_02_r" "thumb_01_r" -1.523449 0.000034 0.000031 9.832816 15.151526 1.613447 0 0 0 0 0 0
$definebone "thumb_03_r" "thumb_02_r" -1.599276 0.000008 0.000015 0.480713 -12.385745 2.4141 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" 5.511824 0.000008 -0.000004 -0.000442 179.999745 166.489945 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" 0.196846 -0.000001 0.000004 0.000353 -179.999117 160.050416 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 4.678654 -1.075636 -1.488978 66.457932 105.584814 113.208528 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.214485 0.00001 0.00002 39.360369 -8.439265 13.8045 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.944885 -0.000032 -0.000199 -11.598266 -34.295466 -3.613934 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620169 -0.000002 0.000008 -40.973755 21.950705 -97.52808 0 0 0 0 0 0
$definebone "index_01_l" "hand_l" 4.751165 0.694376 -0.830474 -3.764682 25.536503 14.866772 0 0 0 0 0 0
$definebone "index_02_l" "index_01_l" 1.688061 -0.000024 0.000002 -0.475157 11.986512 1.337913 0 0 0 0 0 0
$definebone "index_03_l" "index_02_l" 1.336151 -0.00005 -0.00001 -1.907894 -9.554295 1.137835 0 0 0 0 0 0
$definebone "middle_01_l" "hand_l" 4.820517 0.509342 0.224866 -7.040164 22.8259 1.917695 0 0 0 0 0 0
$definebone "middle_02_l" "middle_01_l" 1.827003 0.000062 0.00001 1.136743 12.280665 -2.025001 0 0 0 0 0 0
$definebone "middle_03_l" "middle_02_l" 1.436581 -0.000006 0.00001 -0.387838 -15.345009 0.779228 0 0 0 0 0 0
$definebone "pinky_01_l" "hand_l" 3.992355 0.89109 1.827995 -18.934246 20.186228 -18.724943 0 0 0 0 0 0
$definebone "pinky_02_l" "pinky_01_l" 1.405922 0.000031 -0.000004 -1.315972 11.208145 1.063927 0 0 0 0 0 0
$definebone "pinky_03_l" "pinky_02_l" 1.175362 -0.000132 0.000004 7.050414 1.063467 0.448053 0 0 0 0 0 0
$definebone "ring_01_l" "hand_l" 4.526762 0.690468 1.120842 -10.989675 23.292055 -13.510282 0 0 0 0 0 0
$definebone "ring_02_l" "ring_01_l" 1.744041 -0.000027 0.000001 -1.670173 13.315707 0.301554 0 0 0 0 0 0
$definebone "ring_03_l" "ring_02_l" 1.368763 -0.000031 -0.00002 9.085959 -12.938534 -0.365195 0 0 0 0 0 0
$definebone "thumb_01_l" "hand_l" 1.874863 0.935083 -0.999129 36.919095 27.057076 95.069581 0 0 0 0 0 0
$definebone "thumb_02_l" "thumb_01_l" 1.523457 -0.000031 0 9.832704 15.151419 1.612756 0 0 0 0 0 0
$definebone "thumb_03_l" "thumb_02_l" 1.599277 -0.000004 0.00001 4.129713 -12.231671 2.421142 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511808 -0.000006 0.000004 0.000292 0.000412 -13.510177 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.196846 0.000006 0 0.000862 -0.000112 -19.951824 0 0 0 0 0 0
$definebone "cam_driver" "" 0 0 0 0 -89.999982 0 0 0 0 0 0 0
$definebone "Base" "" -3.180958 -17.779638 -3.275469 0 89.999989 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 11.985277 7.963726 -2.247489 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" 3.7355 0.001257 -1.323762 0 0 0 0 0 0 0 0 0
$definebone "Mag" "Base" -0.000669 -0.000546 -1.339116 0 0 0 0 0 0 0 0 0
$definebone "Bullets" "Mag" 0.047661 0 0.671442 0 0 0 0 0 0 0 0 0
$definebone "Lock" "Base" 4.805532 0.899265 -0.325907 0 0 0 0 0 0 0 0 0
$definebone "Bolt" "Base" -1.555565 -0.000546 0.655778 0 0 0 0 0 0 0 0 0
$definebone "Grenade" "Base" -11.039553 -0.015078 -2.007546 0 0 0 0 0 0 0 0 0
$definebone "Grenade_Aimer" "Base" -12.843279 -0.840861 -0.017368 0 0 0 0 0 0 0 0 0
$definebone "Grenade_AimerRot" "Grenade_Aimer" 3.709639 -0.392178 -0.156463 0 0 0 0 0 0 0 0 0
$definebone "GrenTrigger" "Base" -6.094952 -0.015078 -1.880707 0 0 0 0 0 0 0 0 0
$definebone "Bayonet" "Base" -17.412369 0.316513 -0.959334 0 0 0 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" -1.276867 -2.473417 -4.534741 16.380727 -116.909315 174.049544 0 0 0 0 0 0

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


$sectionframes 30 29

$poseparameter "player_movement" 0 276 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "runIdle_a_corrective_animation" "v_gp25_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_gp25_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_gp25_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_gp25_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_gp25_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_gp25_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_a_corrective_animation" "v_gp25_anims\shoot2_a_corrective_animation.smd" {
}

$animation "shoot2_ironsight_a_corrective_animation" "v_gp25_anims\shoot2_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3_a_corrective_animation" "v_gp25_anims\shoot3_a_corrective_animation.smd" {
}

$animation "shoot3_ironsight_a_corrective_animation" "v_gp25_anims\shoot3_ironsight_a_corrective_animation.smd" {
}

$animation "gl_shoot_a_corrective_animation" "v_gp25_anims\gl_shoot_a_corrective_animation.smd" {
}

$animation "gl_shoot_ironsight_a_corrective_animation" "v_gp25_anims\gl_shoot_ironsight_a_corrective_animation.smd" {
}

$animation "basePose_a" "v_gp25_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "ironsight" "v_gp25_anims\ironsight.smd" {
	fps 0.5
	
	
}

$animation "ironsight_transition" "v_gp25_anims\ironsight_transition.smd" {
	fps 0.5
	
	
}

$animation "runIdle_a" "v_gp25_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_gp25_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_gp25_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_gp25_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "shoot1_a" "v_gp25_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_gp25_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "shoot2_a" "v_gp25_anims\shoot2_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_a_corrective_animation" 0
}

$animation "shoot2_ironsight_a" "v_gp25_anims\shoot2_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_ironsight_a_corrective_animation" 0
}

$animation "shoot3_a" "v_gp25_anims\shoot3_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_a_corrective_animation" 0
}

$animation "shoot3_ironsight_a" "v_gp25_anims\shoot3_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_ironsight_a_corrective_animation" 0
}

$animation "nearwall_s_a" "v_gp25_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_gp25_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_gp25_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_gp25_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_gp25_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_gp25_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "proneF" "v_gp25_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_gp25_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_gp25_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_gp25_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_gp25_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_gp25_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_gp25_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_gp25_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_gp25_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_gp25_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "change_firemode_idle" "v_gp25_anims\change_firemode_idle.smd" {
	fps 30
	
	
}

$animation "change_firemode_iron" "v_gp25_anims\change_firemode_iron.smd" {
	fps 30
	
	
}

$animation "gl_a" "v_gp25_anims\gl_a.smd" {
	fps 30
	loop
	
	
}

$animation "irongl" "v_gp25_anims\irongl.smd" {
	fps 0.5
	
	
}

$animation "gl_s_a" "v_gp25_anims\gl_s_a.smd" {
	fps 30
	
	
}

$animation "gl_s_a_i" "v_gp25_anims\gl_s_a_i.smd" {
	fps 30
	
	
}

$animation "gl_e_a" "v_gp25_anims\gl_e_a.smd" {
	fps 30
	
	
}

$animation "gl_e_a_i" "v_gp25_anims\gl_e_a_i.smd" {
	fps 30
	
	
}

$animation "gl_shoot_a" "v_gp25_anims\gl_shoot_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "gl_shoot_a_corrective_animation" 0
}

$animation "gl_shoot_ironsight_a" "v_gp25_anims\gl_shoot_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "gl_shoot_ironsight_a_corrective_animation" 0
}

$animation "gl_reload_a" "v_gp25_anims\gl_reload_a.smd" {
	fps 30
	
	
}

$animation "gl_reload_a_i" "v_gp25_anims\gl_reload_a_i.smd" {
	fps 30
	
	
}

$animation "gl_draw_a" "v_gp25_anims\gl_draw_a.smd" {
	fps 30
	
	
}

$animation "gl_draw_a_i" "v_gp25_anims\gl_draw_a_i.smd" {
	fps 30
	
	
}

$sequence "runlayer" {
	"runIdle_a"
	"run_a"
	blend "player_movement" 131 225
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
	"v_gp25_anims\draw.smd"
	"v_gp25_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_AK47.Draw" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	  
	
}

$sequence "Firstdraw" {
	"v_gp25_anims\Firstdraw.smd"
	"v_gp25_anims\Firstdraw_2.smd"
	activity "ACT_VM_FIRSTDRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_AK47.Draw" }
	{ event 5004 11 "MCV_Weapon_Foley_AK47.DrawMetal" }
	{ event 5004 22 "MCV_Weapon_Foley_AK47_Reload.MetalStart" }
	{ event 5004 29 "MCV_Weapon_Foley_AK47_Reload.MetalEnd" }
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
	"v_gp25_anims\reload.smd"
	"v_gp25_anims\reload_2.smd"
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
	addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "reload_empty" {
	"v_gp25_anims\reload_empty.smd"
	"v_gp25_anims\reload_empty_2.smd"
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
	"v_gp25_anims\bash.smd"
	"v_gp25_anims\bash_2.smd"
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

$sequence "holster" {
	"v_gp25_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 0 "MCV_Weapon_Foley_AK47.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$sequence "gl_ironsight_test" {
	"irongl"
	fadein 0.2
	fadeout 0.2
	hidden
	addlayer "walklayerironsight"
}

$sequence "gl" {
	"gl_a"
	"ironsight_transition"
	activity "ACT_VM_GL" 1
	blend "ironsight" 0 0.5
	blendwidth 2
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	blendlayer "gl_ironsight_test" 0 0 1 0 poseparameter ironsight
	node "0"
}

$sequence "idle_to_gl" {
	"gl_s_a"
	"gl_s_a_i"
	activity "ACT_VM_IDLETOGL" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Ironsights.In" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
}

$sequence "gl_to_idle" {
	"gl_e_a"
	"gl_e_a_i"
	activity "ACT_VM_GLTOIDLE" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Ironsights.Out" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
}

$sequence "gl_shoot" {
	"gl_shoot_a"
	"gl_shoot_ironsight_a"
	activity "ACT_VM_SECONDARYATTACK" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "reload_secondary" {
	"gl_reload_a"
	"gl_reload_a_i"
	activity "ACT_VM_RELOAD_SECONDARY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_AK47_Reload.Hand" }
	{ event 5004 33 "MCV_Weapon_Foley_AK47_Reload.Grenade" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	node "0"
}

$sequence "gl_draw" {
	"gl_draw_a"
	"gl_draw_a_i"
	activity "ACT_VM_GL_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_AK47.Draw" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
}

$sequence "gl_prone" {
	"proneF"
	"proneL"
	"proneB"
	"proneR"
	"proneF"
	activity "ACT_VM_CRAWL_GL" 1
	blend "move_yaw" -180 180
	blendwidth 5
	{ event 5004 1 "MCV_Weapon_Foley_Movement.ProneCrawl" }
	{ event 5004 12 "MCV_Weapon_Foley_Movement.ProneCrawl" }
	fadein 0.3
	fadeout 0.3
	realtime
}

$includemodel "weapons/gesture_animations.mdl"

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\guns\rifle_ak47\GP25_new.qc"
//	}
}

// Created by Crowbar 0.74

$modelname "weapons/mcv/v_type56.mdl"

$bodygroup "studio"
{
	studio "type56_ref.smd"
}
$bodygroup "bayonet"
{
	blank
	studio "v_bayonetAK.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 7.062 -17.192 -13.755

$cdmaterials "models\weapons\mcv\v_ak47\"
$cdmaterials "models\weapons\mcv\v_ak47_bayonet\"
$cdmaterials "models\weapons\mcv\v_akm\"
$cdmaterials "models\weapons\mcv\shells\"
$cdmaterials "models\weapons\mcv\v_kbkg60\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "Base" -20 0 0.15 rotate 1 180 0
$attachment "eject" "Base" -1 0 0.7 rotate 0 90 0

$cbox 0 0 0 0 0 0

$bbox -10.182 -10.125 -27.509 44.565 24.248 0

$definebone "root" "" 0 7.450089 -27.509027 0 0 0 0 0 0 0 0 0
$definebone "pelvis" "root" -0.000002 0 0 -89.790623 -89.997175 89.997175 0 0 0 0 0 0
$definebone "spine_01" "pelvis" 4.255466 -0.335186 -0.000002 0 -7.153263 0 0 0 0 0 0 0
$definebone "spine_02" "spine_01" 7.431255 1.496481 0.000002 0 14.063249 0 0 0 0 0 0 0
$definebone "spine_03" "spine_02" 5.278481 0.165544 0.000001 0 2.779475 0 0 0 0 0 0 0
$definebone "clavicle_r" "spine_03" 4.678661 -1.075637 1.488978 66.457891 -74.414904 113.20878 0 0 0 0 0 0
$definebone "upperarm_r" "clavicle_r" -6.214481 -0.00001 -0.000028 -24.007524 97.614782 -158.051397 0 0 0 0 0 0
$definebone "lowerarm_r" "upperarm_r" 11.944895 0.000001 0 -19.368798 74.807258 -7.665702 0 0 0 0 0 0
$definebone "hand_r" "lowerarm_r" 10.620182 0.000001 0 -14.11341 140.143242 121.556959 0 0 0 0 0 0
$definebone "index_01_r" "hand_r" -4.751115 -0.694494 0.830565 -3.762664 25.538678 14.867227 0 0 0 0 0 0
$definebone "index_02_r" "index_01_r" -1.688068 0.000048 -0.000034 -0.475203 11.986108 1.337738 0 0 0 0 0 0
$definebone "index_03_r" "index_02_r" -1.336141 0.000057 -0.000013 0.996953 -9.496657 1.137544 0 0 0 0 0 0
$definebone "middle_01_r" "hand_r" -4.820502 -0.509462 -0.224771 -7.039523 22.827327 1.918092 0 0 0 0 0 0
$definebone "middle_02_r" "middle_01_r" -1.826997 -0.000065 0.000009 1.136756 12.280661 -2.025002 0 0 0 0 0 0
$definebone "middle_03_r" "middle_02_r" -1.436584 0.000009 0.000001 -4.389708 -15.399553 0.781573 0 0 0 0 0 0
$definebone "pinky_01_r" "hand_r" -3.992365 -0.891187 -1.827918 -18.93281 20.187427 -18.724433 0 0 0 0 0 0
$definebone "pinky_02_r" "pinky_01_r" -1.405924 -0.000023 -0.000005 -1.315561 11.208264 1.063875 0 0 0 0 0 0
$definebone "pinky_03_r" "pinky_02_r" -1.175364 0.00013 -0.000019 3.869421 1.038606 0.445654 0 0 0 0 0 0
$definebone "ring_01_r" "hand_r" -4.526762 -0.690576 -1.120752 -10.988232 23.293486 -13.509885 0 0 0 0 0 0
$definebone "ring_02_r" "ring_01_r" -1.744053 0.000041 -0.00001 -1.66982 13.315318 0.301272 0 0 0 0 0 0
$definebone "ring_03_r" "ring_02_r" -1.368768 0.000025 0 2.987755 -12.899511 -0.360669 0 0 0 0 0 0
$definebone "thumb_01_r" "hand_r" -1.874806 -0.935127 0.999166 36.920246 27.057822 95.069512 0 0 0 0 0 0
$definebone "thumb_02_r" "thumb_01_r" -1.523453 0.000031 0.000031 9.832818 15.151523 1.613449 0 0 0 0 0 0
$definebone "thumb_03_r" "thumb_02_r" -1.599283 0.000005 0.000014 0.480715 -12.385735 2.414101 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" 5.511815 0.000002 -0.000006 -0.000421 179.999814 166.489945 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" 0.19685 -0.000003 0.000004 0.000348 -179.999131 160.050416 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 4.678659 -1.075637 -1.488979 66.457925 105.584814 113.208541 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.214493 0.000012 0.000021 29.318416 -121.108775 -45.330306 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.944914 -0.000027 -0.000183 -17.670533 -60.993924 3.257669 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620182 0.00001 0.000014 10.55139 -134.695879 -170.436989 0 0 0 0 0 0
$definebone "index_01_l" "hand_l" 4.751163 0.694371 -0.830472 -3.764673 25.536491 14.866767 0 0 0 0 0 0
$definebone "index_02_l" "index_01_l" 1.688071 -0.000029 0.000002 -0.475154 11.9865 1.337914 0 0 0 0 0 0
$definebone "index_03_l" "index_02_l" 1.336146 -0.000053 -0.000009 -1.907892 -9.554311 1.137837 0 0 0 0 0 0
$definebone "middle_01_l" "hand_l" 4.820521 0.509338 0.224868 -7.040159 22.825883 1.917692 0 0 0 0 0 0
$definebone "middle_02_l" "middle_01_l" 1.827002 0.000066 0.000008 1.136751 12.280655 -2.025001 0 0 0 0 0 0
$definebone "middle_03_l" "middle_02_l" 1.436584 -0.000012 0.000007 -0.387832 -15.345022 0.779226 0 0 0 0 0 0
$definebone "pinky_01_l" "hand_l" 3.99236 0.891086 1.828 -18.934189 20.186209 -18.724948 0 0 0 0 0 0
$definebone "pinky_02_l" "pinky_01_l" 1.405924 0.000022 -0.000007 -1.315965 11.208142 1.063935 0 0 0 0 0 0
$definebone "pinky_03_l" "pinky_02_l" 1.175366 -0.000131 0.000003 7.050423 1.063461 0.44806 0 0 0 0 0 0
$definebone "ring_01_l" "hand_l" 4.526764 0.690456 1.120845 -10.989672 23.292038 -13.510287 0 0 0 0 0 0
$definebone "ring_02_l" "ring_01_l" 1.744046 -0.000033 -0.000002 -1.670168 13.315707 0.301553 0 0 0 0 0 0
$definebone "ring_03_l" "ring_02_l" 1.368767 -0.000033 -0.000016 9.085969 -12.938541 -0.365196 0 0 0 0 0 0
$definebone "thumb_01_l" "hand_l" 1.874855 0.935081 -0.999129 36.919109 27.057064 95.069567 0 0 0 0 0 0
$definebone "thumb_02_l" "thumb_01_l" 1.523455 -0.000029 -0.000002 9.832695 15.151414 1.612767 0 0 0 0 0 0
$definebone "thumb_03_l" "thumb_02_l" 1.599283 0.000002 0.000007 4.129705 -12.231668 2.421156 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511817 0 0.000007 0.000287 0.000411 -13.510173 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.196849 -0.000001 -0.000001 0.000855 -0.000116 -19.951828 0 0 0 0 0 0
$definebone "cam_driver" "" 0 0 0 0 -89.999982 0 0 0 0 0 0 0
$definebone "Base" "" -3.180958 -17.779638 -3.275469 0 89.999982 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 10.403842 5.299539 -2.179939 -5.623409 89.810506 -8.287664 0 0 0 0 0 0
$definebone "Trigger" "Base" 3.735505 0.001257 -1.323763 0 0 0 0 0 0 0 0 0
$definebone "Mag" "Base" -0.000669 -0.000546 -1.339116 0 0 0 0 0 0 0 0 0
$definebone "Bullets" "Mag" 0.047661 0 0.671442 0 0 0 0 0 0 0 0 0
$definebone "Lock" "Base" 4.805539 0.899264 -0.325907 0 0 0 0 0 0 0 0 0
$definebone "Bolt" "Base" -1.555565 -0.000546 0.655778 0 0 0 0 0 0 0 0 0
$definebone "Bayonet" "Base" -17.412373 0.316513 -0.959334 0 0 0 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" -4.425457 -2.156439 -2.380636 66.092831 -137.02037 177.158592 0 0 0 0 0 0

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

$poseparameter "player_movement" 0 276 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "runIdle_a_corrective_animation" "v_type56_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_type56_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_type56_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_type56_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_type56_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_type56_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_a_corrective_animation" "v_type56_anims\shoot2_a_corrective_animation.smd" {
}

$animation "shoot2_ironsight_a_corrective_animation" "v_type56_anims\shoot2_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3_a_corrective_animation" "v_type56_anims\shoot3_a_corrective_animation.smd" {
}

$animation "shoot3_ironsight_a_corrective_animation" "v_type56_anims\shoot3_ironsight_a_corrective_animation.smd" {
}

$animation "basePose_a" "v_type56_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "ironsight" "v_type56_anims\ironsight.smd" {
	fps 0.5
	
	
}

$animation "ironsight_transition" "v_type56_anims\ironsight_transition.smd" {
	fps 0.5
	
	
}

$animation "runIdle_a" "v_type56_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_type56_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_type56_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_type56_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "shoot1_a" "v_type56_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_type56_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "shoot2_a" "v_type56_anims\shoot2_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_a_corrective_animation" 0
}

$animation "shoot2_ironsight_a" "v_type56_anims\shoot2_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_ironsight_a_corrective_animation" 0
}

$animation "shoot3_a" "v_type56_anims\shoot3_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_a_corrective_animation" 0
}

$animation "shoot3_ironsight_a" "v_type56_anims\shoot3_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_ironsight_a_corrective_animation" 0
}

$animation "nearwall_s_a" "v_type56_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_type56_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_type56_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_type56_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_type56_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_type56_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "proneF" "v_type56_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_type56_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_type56_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_type56_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_type56_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_type56_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_type56_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_type56_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_type56_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_type56_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "bayonet_e_a" "v_type56_anims\bayonet_e_a.smd" {
	fps 30
	
	
}

$animation "bayonet_e_a_i" "v_type56_anims\bayonet_e_a_i.smd" {
	fps 30
	
	
}

$animation "bayonet_s_a" "v_type56_anims\bayonet_s_a.smd" {
	fps 30
	
	
}

$animation "bayonet_s_a_i" "v_type56_anims\bayonet_s_a_i.smd" {
	fps 30
	
	
}

$animation "change_firemode_idle" "v_type56_anims\change_firemode_idle.smd" {
	fps 30
	
	
}

$animation "change_firemode_iron" "v_type56_anims\change_firemode_iron.smd" {
	fps 30
	
	
}

$animation "bayonet_attack_a" "v_type56_anims\bayonet_attack_a.smd" {
	fps 30
	
	
}

$animation "bayonet_attack_a_i" "v_type56_anims\bayonet_attack_a_i.smd" {
	fps 30
	
	
}

$animation "Charge_s_a" "v_type56_anims\Charge_s_a.smd" {
	fps 30
	
	
}

$animation "Charge_s_a_i" "v_type56_anims\Charge_s_a_i.smd" {
	fps 30
	
	
}

$animation "Charge_l_a" "v_type56_anims\Charge_l_a.smd" {
	fps 30
	loop
	
	
}

$animation "Charge_l_a_i" "v_type56_anims\Charge_l_a_i.smd" {
	fps 30
	
	
}

$animation "Charge_e_a" "v_type56_anims\Charge_e_a.smd" {
	fps 30
	
	
}

$animation "Charge_e_a_i" "v_type56_anims\Charge_e_a_i.smd" {
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
	"v_type56_anims\draw.smd"
	"v_type56_anims\draw_2.smd"
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
	"v_type56_anims\Firstdraw.smd"
	"v_type56_anims\Firstdraw_2.smd"
	activity "ACT_VM_FIRSTDRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_AK47.Draw" }
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
	"v_type56_anims\reload.smd"
	"v_type56_anims\reload_2.smd"
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
	"v_type56_anims\reload_empty.smd"
	"v_type56_anims\reload_empty_2.smd"
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
	"v_type56_anims\bash.smd"
	"v_type56_anims\bash_2.smd"
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

$sequence "bayonet_unequip" {
	"bayonet_e_a"
	"bayonet_e_a_i"
	activity "ACT_VM_BAYONET_UNEQUIP" 1
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
	activity "ACT_VM_BAYONET_EQUIP" 1
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
	"v_type56_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 0 "MCV_Weapon_Foley_AK47.Holster" }
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\guns\rifle_ak47\type56_new.qc"
//	}
}

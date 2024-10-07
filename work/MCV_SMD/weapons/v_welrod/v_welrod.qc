// Created by Crowbar 0.74

$modelname "weapons/mcv/v_welrod.mdl"

$bodygroup "studio"
{
	studio "welrod_ref.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition -3.567 -11.52 -13.755

$cdmaterials "models\weapons\mcv\v_welrod\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "Base" -13.1 0 1 rotate 0 180 0
$attachment "eject" "Base" 0.5 0.1 1.6 rotate -80 90 0

$cbox 0 0 0 0 0 0

$bbox -9.182 -14.564 -27.51 32.223 7.43 0

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
$definebone "Base" "" -2.98601 -15.08732 -2.685743 0 89.999989 0 0 0 0 0 0 0
$definebone "Mag" "Base" 0.62513 -0.018744 -0.272067 0 0 0 0 0 0 0 0 0
$definebone "Bullet" "Mag" -0.10533 0 0.212057 0 0 0 0 0 0 0 0 0
$definebone "Bullet.001" "Mag" -0.04584 0 -0.281765 0 0 0 0 0 0 0 0 0
$definebone "Bullet.002" "Mag" 0.068072 0 -0.709511 0 0 0 0 0 0 0 0 0
$definebone "Bullet.003" "Mag" 0.157202 0 -1.156196 0 0 0 0 0 0 0 0 0
$definebone "Bullet.004" "Mag" 0.245374 0 -1.587915 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" -2.41855 -0.009689 -0.81389 0 0 0 0 0 0 0 0 0
$definebone "Slide" "Base" -0.135722 -0.042175 0.499061 0 0 0 0 0 0 0 0 0
$definebone "Rhand_IKtarget" "Base" 8.95878 3.90124 -2.837215 0 0 0 0 0 0 0 0 0
$definebone "LHand_IKtarget" "Base" 8.918202 -5.924527 -2.600557 0 0 0 0 0 0 0 0 0

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

$poseparameter "ammo_fraction" 0 1 loop 0
$poseparameter "player_movement" 0 260 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "Bullet0_corrective_animation" "v_welrod_anims\Bullet0_corrective_animation.smd" {
}

$animation "Bullet1_corrective_animation" "v_welrod_anims\Bullet1_corrective_animation.smd" {
}

$animation "Bullet2_corrective_animation" "v_welrod_anims\Bullet2_corrective_animation.smd" {
}

$animation "Bullet3_corrective_animation" "v_welrod_anims\Bullet3_corrective_animation.smd" {
}

$animation "Bullet4_corrective_animation" "v_welrod_anims\Bullet4_corrective_animation.smd" {
}

$animation "Default_corrective_animation" "v_welrod_anims\Default_corrective_animation.smd" {
}

$animation "runIdle_a_corrective_animation" "v_welrod_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_welrod_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_welrod_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_welrod_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_welrod_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_welrod_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "boltpull_a_corrective_animation" "v_welrod_anims\boltpull_a_corrective_animation.smd" {
}

$animation "boltpullIron_a_corrective_animation" "v_welrod_anims\boltpullIron_a_corrective_animation.smd" {
}

$animation "PoseDelta" "v_welrod_anims\PoseDelta.smd" {
	fps 30
	
	
}

$animation "Default" "v_welrod_anims\Default.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Default_corrective_animation" 0
}

$animation "Bullet4" "v_welrod_anims\Bullet4.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet4_corrective_animation" 0
}

$animation "Bullet3" "v_welrod_anims\Bullet3.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet3_corrective_animation" 0
}

$animation "Bullet2" "v_welrod_anims\Bullet2.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet2_corrective_animation" 0
}

$animation "Bullet1" "v_welrod_anims\Bullet1.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet1_corrective_animation" 0
}

$animation "Bullet0" "v_welrod_anims\Bullet0.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet0_corrective_animation" 0
}

$animation "basePose_a" "v_welrod_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "ironsight" "v_welrod_anims\ironsight.smd" {
	fps 0.5
	
	
}

$animation "ironsight_transition" "v_welrod_anims\ironsight_transition.smd" {
	fps 0.5
	
	
}

$animation "runIdle_a" "v_welrod_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_welrod_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_welrod_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_welrod_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "shoot1_a" "v_welrod_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_welrod_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "boltpull_a" "v_welrod_anims\boltpull_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "boltpull_a_corrective_animation" 0
}

$animation "boltpullIron_a" "v_welrod_anims\boltpullIron_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "boltpullIron_a_corrective_animation" 0
}

$animation "nearwall_s_a" "v_welrod_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_welrod_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_welrod_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_welrod_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_welrod_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_welrod_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "proneF" "v_welrod_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_welrod_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_welrod_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_welrod_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_welrod_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_welrod_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_welrod_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_welrod_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_welrod_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_welrod_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$sequence "BulletCounter" {
	"Bullet0"
	"Bullet1"
	"Bullet2"
	"Bullet3"
	"Bullet4"
	"Default"
	"Default"
	blend "ammo_fraction" 0 1
	blendwidth 7
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
	addlayer "BulletCounter"
	node "0"
}

$sequence "draw" {
	"v_welrod_anims\draw.smd"
	"v_welrod_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Welrod.Draw" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	addlayer "BulletCounter"
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
	fps 30
	  
	
}

$sequence "Firstdraw" {
	"v_welrod_anims\Firstdraw.smd"
	"v_welrod_anims\Firstdraw_2.smd"
	activity "ACT_VM_FIRSTDRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_PM.Draw" }
	{ event 5004 9 "MCV_Weapon_Foley_Welrod_Reload.MetalSpecial" }
	{ event 5004 19 "MCV_Weapon_Foley_Welrod_Reload.MetalEnd" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	addlayer "BulletCounter"
	addlayer "walklayer"
	addlayer "runlayer"
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
	{ event AE_MUZZLEFLASH 0 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "boltpull" {
	"boltpull_a"
	"boltpullIron_a"
	activity "ACT_VM_BOLTPULL" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event 5004 6 "MCV_Weapon_Foley_Welrod_Reload.MetalStart" }
	{ event 5004 16 "MCV_Weapon_Foley_Welrod_Reload.MetalEnd" }
	{ event AE_CLIENT_EJECT_BRASS 12 "eject" }
	fadein 0.2
	fadeout 0.2
}

$sequence "reload" {
	"v_welrod_anims\reload.smd"
	"v_welrod_anims\reload_2.smd"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Welrod_Reload.Hand" }
	{ event 5004 6 "MCV_Weapon_Foley_Welrod_Reload.MagOut" }
	{ event 5004 30 "MCV_Weapon_Foley_Welrod_Reload.HandMid" }
	{ event 5004 48 "MCV_Weapon_Foley_Welrod_Reload.MagIn" }
	{ event 5004 60 "MCV_Weapon_Foley_Welrod_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 58 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 31 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	addlayer "BulletCounter"
	addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "reload_empty" {
	"v_welrod_anims\reload_empty.smd"
	"v_welrod_anims\reload_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Welrod_Reload.Hand" }
	{ event 5004 6 "MCV_Weapon_Foley_Welrod_Reload.MagOut" }
	{ event 5004 30 "MCV_Weapon_Foley_Welrod_Reload.HandMid" }
	{ event 5004 48 "MCV_Weapon_Foley_Welrod_Reload.MagIn" }
	{ event 5004 68 "MCV_Weapon_Foley_Welrod_Reload.MetalStart" }
	{ event 5004 80 "MCV_Weapon_Foley_Welrod_Reload.MetalEnd" }
	{ event 5004 90 "MCV_Weapon_Foley_Welrod_Reload.HandEnd" }
	{ event AE_CLIENT_EJECT_BRASS 75 "eject" }
	{ event AE_WPN_COMPLETE_RELOAD 77 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 31 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	addlayer "BulletCounter"
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
	addlayer "BulletCounter"
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
	addlayer "BulletCounter"
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
	addlayer "BulletCounter"
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
	addlayer "BulletCounter"
	realtime
}

$sequence "bash" {
	"v_welrod_anims\bash.smd"
	"v_welrod_anims\bash_2.smd"
	activity "ACT_VM_BASH" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 3200 3 "" }
	{ event 5004 1 "MCV_Weapon_Foley_Bash.Fast" }
	fadein 0
	fadeout 0.2
	addlayer "BulletCounter"
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
	addlayer "walklayer"
	addlayer "BulletCounter"
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
	addlayer "BulletCounter"
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
	addlayer "walklayer"
	addlayer "BulletCounter"
}

$sequence "holster" {
	"v_welrod_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 1 "MCV_Weapon_Foley_Welrod.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "BulletCounter"
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
//		"value" "models\guns\pistol_welrod\welrod.qc"
//	}
}

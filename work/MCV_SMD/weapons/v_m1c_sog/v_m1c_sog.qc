// Created by Crowbar 0.74

$modelname "weapons/mcv/v_m1c_sog.mdl"

$bodygroup "studio"
{
	studio "m1a1c_sog.smd"
}
$bodygroup "bayonet"
{
	blank
	studio "v_bayonet_new.smd"
}
$bodygroup "mount"
{
	blank
	studio "m1c_mount.smd"
}
$bodygroup "grenade"
{
	blank
	studio "m1c_grenade.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition 9.606 -21.37 -9.672

$cdmaterials "models\weapons\mcv\v_m1c\"
$cdmaterials "models\weapons\mcv\v_bayonet\"
$cdmaterials "models\weapons\mcv\shells\"
$cdmaterials "models\weapons\mcv\rif_gl\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "Base" -16.8 0 1.65 rotate 0 180 0
$attachment "eject" "Base" -0.3 0 1.5 rotate -50 114 0

$cbox 0 0 0 0 0 0

$bbox -10.839 -11.908 -27.51 53.579 31.12 8.165

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
$definebone "Base" "" -3.508908 -17.270517 -4.018227 0 89.999989 0 0 0 0 0 0 0
$definebone "Mag" "Base" -0.422634 -0.114805 -0.23509 0 0 0 0 0 0 0 0 0
$definebone "Bullet" "Mag" 0.088148 -0.001231 0.736235 0 0 0 0 0 0 0 0 0
$definebone "BulletMove" "Bullet" -0.002016 0.223316 0.364587 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" 3.502275 -0.126625 0.001379 0 0 0 0 0 0 0 0 0
$definebone "Bolt" "Base" -0.250383 0.788272 1.75217 0 0 0 0 0 0 0 0 0
$definebone "BoltRotate" "Bolt" -0.298975 -0.805908 -0.058363 0 0 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 12.664057 7.635776 -1.504732 0 0 0 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" 12.664049 -4.564517 -1.504732 0 0 0 0 0 0 0 0 0
$definebone "MagRelease" "Base" 1.072268 0.414685 -0.551039 0 0 0 0 0 0 0 0 0
$definebone "Bayonet" "Base" -23.100773 -0.038034 0.379461 0 0 0 0 0 0 0 0 0
$definebone "Grenade" "Base" -28.457813 -0.038034 1.692787 0 0 0 0 0 0 0 0 0

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

$poseparameter "player_movement" 0 295 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "runIdle_a_corrective_animation" "v_m1c_sog_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_m1c_sog_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_m1c_sog_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_m1c_sog_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_m1c_sog_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_m1c_sog_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_a_corrective_animation" "v_m1c_sog_anims\shoot2_a_corrective_animation.smd" {
}

$animation "shoot2_ironsight_a_corrective_animation" "v_m1c_sog_anims\shoot2_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3_a_corrective_animation" "v_m1c_sog_anims\shoot3_a_corrective_animation.smd" {
}

$animation "shoot3_ironsight_a_corrective_animation" "v_m1c_sog_anims\shoot3_ironsight_a_corrective_animation.smd" {
}

$animation "gren_shoot1_a_corrective_animation" "v_m1c_sog_anims\gren_shoot1_a_corrective_animation.smd" {
}

$animation "gren_shoot1_ironsight_a_corrective_animation" "v_m1c_sog_anims\gren_shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "basePose_a" "v_m1c_sog_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "ironsight" "v_m1c_sog_anims\ironsight.smd" {
	fps 0.5
	
	
}

$animation "ironsight_transition" "v_m1c_sog_anims\ironsight_transition.smd" {
	fps 0.5
	
	
}

$animation "runIdle_a" "v_m1c_sog_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_m1c_sog_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_m1c_sog_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_m1c_sog_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "shoot1_a" "v_m1c_sog_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_m1c_sog_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "shoot2_a" "v_m1c_sog_anims\shoot2_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_a_corrective_animation" 0
}

$animation "shoot2_ironsight_a" "v_m1c_sog_anims\shoot2_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_ironsight_a_corrective_animation" 0
}

$animation "shoot3_a" "v_m1c_sog_anims\shoot3_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_a_corrective_animation" 0
}

$animation "shoot3_ironsight_a" "v_m1c_sog_anims\shoot3_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_ironsight_a_corrective_animation" 0
}

$animation "nearwall_start" "v_m1c_sog_anims\nearwall_start.smd" {
	fps 30
	
	
}

$animation "nearwall_start_i" "v_m1c_sog_anims\nearwall_start_i.smd" {
	fps 30
	
	
}

$animation "nearwall_loop" "v_m1c_sog_anims\nearwall_loop.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_loop_i" "v_m1c_sog_anims\nearwall_loop_i.smd" {
	fps 30
	
	
}

$animation "nearwall_end" "v_m1c_sog_anims\nearwall_end.smd" {
	fps 30
	
	
}

$animation "nearwall_end_i" "v_m1c_sog_anims\nearwall_end_i.smd" {
	fps 30
	
	
}

$animation "proneF" "v_m1c_sog_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_m1c_sog_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_m1c_sog_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_m1c_sog_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_start" "v_m1c_sog_anims\pickup_start.smd" {
	fps 30
	
	
}

$animation "pickup_start_i" "v_m1c_sog_anims\pickup_start_i.smd" {
	fps 30
	
	
}

$animation "pickup_loop" "v_m1c_sog_anims\pickup_loop.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_loop_i" "v_m1c_sog_anims\pickup_loop_i.smd" {
	fps 30
	
	
}

$animation "pickup_end" "v_m1c_sog_anims\pickup_end.smd" {
	fps 30
	
	
}

$animation "pickup_end_i" "v_m1c_sog_anims\pickup_end_i.smd" {
	fps 30
	
	
}

$animation "bayonet_unequip_a" "v_m1c_sog_anims\bayonet_unequip_a.smd" {
	fps 30
	
	
}

$animation "bayonet_unequip_a_i" "v_m1c_sog_anims\bayonet_unequip_a_i.smd" {
	fps 30
	
	
}

$animation "bayonet_equip_a" "v_m1c_sog_anims\bayonet_equip_a.smd" {
	fps 30
	
	
}

$animation "bayonet_equip_a_i" "v_m1c_sog_anims\bayonet_equip_a_i.smd" {
	fps 30
	
	
}

$animation "bayonet_bash_a" "v_m1c_sog_anims\bayonet_bash_a.smd" {
	fps 30
	
	
}

$animation "bayonet_bash_a_i" "v_m1c_sog_anims\bayonet_bash_a_i.smd" {
	fps 30
	
	
}

$animation "grenade_ironsight" "v_m1c_sog_anims\grenade_ironsight.smd" {
	fps 0.5
	
	
}

$animation "gren_shoot1_a" "v_m1c_sog_anims\gren_shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "gren_shoot1_a_corrective_animation" 0
}

$animation "gren_shoot1_ironsight_a" "v_m1c_sog_anims\gren_shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "gren_shoot1_ironsight_a_corrective_animation" 0
}

$animation "gren_reload_a" "v_m1c_sog_anims\gren_reload_a.smd" {
	fps 30
	
	
}

$animation "gren_reload_a_i" "v_m1c_sog_anims\gren_reload_a_i.smd" {
	fps 30
	
	
}

$animation "ChargeStart_a" "v_m1c_sog_anims\ChargeStart_a.smd" {
	fps 30
	
	
}

$animation "ChargeStart_a_i" "v_m1c_sog_anims\ChargeStart_a_i.smd" {
	fps 30
	
	
}

$animation "ChargeLoop_a" "v_m1c_sog_anims\ChargeLoop_a.smd" {
	fps 30
	loop
	
	
}

$animation "ChargeLoop_a_i" "v_m1c_sog_anims\ChargeLoop_a_i.smd" {
	fps 30
	
	
}

$animation "ChargeEnd_a" "v_m1c_sog_anims\ChargeEnd_a.smd" {
	fps 30
	
	
}

$animation "ChargeEnd_a_i" "v_m1c_sog_anims\ChargeEnd_a_i.smd" {
	fps 30
	
	
}

$sequence "runlayer" {
	"runIdle_a"
	"run_a"
	blend "player_movement" 147 245
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
	blend "player_movement" 0 295
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

$sequence "FirstDraw" {
	"v_m1c_sog_anims\FirstDraw.smd"
	"v_m1c_sog_anims\FirstDraw_2.smd"
	activity "ACT_VM_FIRSTDRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M1C.Draw" }
	{ event 5004 9 "MCV_Weapon_Foley_M1C.DrawMetal" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$sequence "draw" {
	"v_m1c_sog_anims\draw.smd"
	"v_m1c_sog_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M1C.Draw" }
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
	"v_m1c_sog_anims\reload.smd"
	"v_m1c_sog_anims\reload_2.smd"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M1C_Reload.Hand" }
	{ event 5004 14 "MCV_Weapon_Foley_M1C_Reload.MagOut" }
	{ event 5004 45 "MCV_Weapon_Foley_M1C_Reload.MagIn" }
	{ event AE_WPN_COMPLETE_RELOAD 53 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "reload_empty" {
	"v_m1c_sog_anims\reload_empty.smd"
	"v_m1c_sog_anims\reload_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M1C_Reload.Hand" }
	{ event 5004 14 "MCV_Weapon_Foley_M1C_Reload.MagOut" }
	{ event 5004 45 "MCV_Weapon_Foley_M1C_Reload.MagIn" }
	{ event 5004 73 "MCV_Weapon_Foley_M1C.DrawMetal" }
	{ event AE_WPN_COMPLETE_RELOAD 82 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "idletonearwall" {
	"nearwall_start"
	"nearwall_start_i"
	activity "ACT_VM_IDLE_TO_LOWERED" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Nearwall.In" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
}

$sequence "nearwall" {
	"nearwall_loop"
	"nearwall_loop_i"
	activity "ACT_VM_IDLE_LOWERED" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	node "0"
}

$sequence "nearwalltoidle" {
	"nearwall_end"
	"nearwall_end_i"
	activity "ACT_VM_LOWERED_TO_IDLE" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.Out" }
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
	"v_m1c_sog_anims\bash.smd"
	"v_m1c_sog_anims\bash_2.smd"
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
	"pickup_start"
	"pickup_start_i"
	activity "ACT_VM_PICKUPSTART" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.In" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
}

$sequence "pickuploop" {
	"pickup_loop"
	"pickup_loop_i"
	activity "ACT_VM_PICKUPLOOP" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
}

$sequence "pickupend" {
	"pickup_end"
	"pickup_end_i"
	activity "ACT_VM_PICKUPEND" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.Out" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
}

$sequence "bayonet_unequip" {
	"bayonet_unequip_a"
	"bayonet_unequip_a_i"
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
	"bayonet_equip_a"
	"bayonet_equip_a_i"
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

$sequence "bash_bayonet" {
	"bayonet_bash_a"
	"bayonet_bash_a_i"
	activity "ACT_VM_HITCENTER_BAYONET" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Bash.Fast" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	node "0"
}

$sequence "slash_bayonet" {
	"bayonet_bash_a"
	"bayonet_bash_a_i"
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

$sequence "holster" {
	"v_m1c_sog_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 0 "MCV_Weapon_Foley_M1C.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$sequence "gren_ironsight_test" {
	"grenade_ironsight"
	fadein 0.2
	fadeout 0.2
	hidden
	addlayer "walklayerironsight"
}

$sequence "grenade_idle" {
	"basePose_a"
	"ironsight_transition"
	activity "ACT_VM_GRENADE" 1
	blend "ironsight" 0 0.5
	blendwidth 2
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	blendlayer "gren_ironsight_test" 0 0 1 0 poseparameter ironsight
	node "0"
}

$sequence "grenade_shoot" {
	"gren_shoot1_a"
	"gren_shoot1_ironsight_a"
	activity "ACT_VM_GRENADE_SHOOT" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_MUZZLEFLASH 0 "" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "grenade_reload" {
	"gren_reload_a"
	"gren_reload_a_i"
	activity "ACT_VM_GRENADE_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_RifleGrenade.Raise" }
	{ event 5004 5 "MCV_Weapon_Foley_RifleGrenade.Attach" }
	{ event 5004 35 "MCV_Weapon_Foley_RifleGrenade.Lower" }
	fadein 0
	fadeout 0.2
}

$sequence "grenade_draw" {
	"v_m1c_sog_anims\grenade_draw.smd"
	"v_m1c_sog_anims\grenade_draw_2.smd"
	activity "ACT_VM_GRENADE_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_RifleGrenade.Raise" }
	{ event 5004 5 "MCV_Weapon_Foley_RifleGrenade.Attach" }
	{ event 5004 35 "MCV_Weapon_Foley_RifleGrenade.Lower" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	fps 30
	
	
}

$sequence "grenade_draw_empty" {
	"v_m1c_sog_anims\grenade_draw_empty.smd"
	"v_m1c_sog_anims\grenade_draw_empty_2.smd"
	activity "ACT_VM_GRENADE_DRAW_EMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M1C.Draw" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$sequence "ChargeStart" {
	"ChargeStart_a"
	"ChargeStart_a_i"
	activity "ACT_VM_CHARGE_START" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0
	fadeout 0.2
	node "0"
}

$sequence "ChargeLoop" {
	"ChargeLoop_a"
	"ChargeLoop_a_i"
	activity "ACT_VM_CHARGE_LOOP" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0
	fadeout 0.2
	node "0"
}

$sequence "ChargeStab" {
	"ChargeEnd_a"
	"ChargeEnd_a_i"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\guns\carbine_m1c\m1a1c_sog.qc"
//	}
}

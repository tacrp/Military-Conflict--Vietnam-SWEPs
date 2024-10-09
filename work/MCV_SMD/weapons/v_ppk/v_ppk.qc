// Created by Crowbar 0.74

$modelname "weapons/mcv/v_ppk.mdl"

$bodygroup "studio"
{
	studio "walther_ppk_ref.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition -1.909 -5.24 -13.755

$cdmaterials "models\weapons\mcv\v_ppk\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "Base" -12.5 0 1.05 rotate 0 180 0
$attachment "eject" "Base" -1.5 0.4 1 rotate 0 90 0

$cbox 0 0 0 0 0 0

$bbox -22.288 -14.564 -27.51 32.767 10.745 0

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
$definebone "Base" "" -2.98601 -14.678635 -3.319699 0 89.999989 0 0 0 0 0 0 0
$definebone "Mag" "Base" 0.35354 -0.018744 -0.026416 0 0 0 0 0 0 0 0 0
$definebone "Bullet.001" "Mag" -0.171465 0 0.817988 0 0 0 0 0 0 0 0 0
$definebone "Bullet.002" "Mag" -0.108943 0 0.322092 0 0 0 0 0 0 0 0 0
$definebone "Bullet.003" "Mag" -0.040975 0 -0.132449 0 0 0 0 0 0 0 0 0
$definebone "Bullet.004" "Mag" -0.00699 0 -0.58699 0 0 0 0 0 0 0 0 0
$definebone "Bullet.005" "Mag" 0.082218 0 -1.037283 0 0 0 0 0 0 0 0 0
$definebone "Bullet.006" "Mag" 0.141691 0 -1.487576 0 0 0 0 0 0 0 0 0
$definebone "Bullet.007" "Mag" 0.184511 0 -1.946365 0 0 0 0 0 0 0 0 0
$definebone "Bullet.008" "Mag" 0.227331 0 -2.368451 0 0 0 0 0 0 0 0 0
$definebone "Hammer" "Base" 1.576775 -0.009689 0.479131 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" -1.348083 -0.009689 0.192636 0 0 0 0 0 0 0 0 0
$definebone "Slide" "Base" -1.125498 -0.009689 0.956924 0 0 0 0 0 0 0 0 0
$definebone "Rhand_IKtarget" "Base" 4.695441 9.197552 -9.473289 66.050532 84.613326 15.771352 0 0 0 0 0 0
$definebone "LHand_IKtarget" "Base" 4.077479 -9.183509 -10.461119 30.66869 -109.26686 178.998522 0 0 0 0 0 0

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

$poseparameter "ammo_fraction" 0 1 loop 0
$poseparameter "empty" 0 1 loop 0
$poseparameter "player_movement" 0 260 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "Bullet0_corrective_animation" "v_ppk_anims\Bullet0_corrective_animation.smd" {
}

$animation "Bullet1_corrective_animation" "v_ppk_anims\Bullet1_corrective_animation.smd" {
}

$animation "Bullet2_corrective_animation" "v_ppk_anims\Bullet2_corrective_animation.smd" {
}

$animation "Bullet3_corrective_animation" "v_ppk_anims\Bullet3_corrective_animation.smd" {
}

$animation "Bullet4_corrective_animation" "v_ppk_anims\Bullet4_corrective_animation.smd" {
}

$animation "Bullet5_corrective_animation" "v_ppk_anims\Bullet5_corrective_animation.smd" {
}

$animation "Bullet6_corrective_animation" "v_ppk_anims\Bullet6_corrective_animation.smd" {
}

$animation "Bullet7_corrective_animation" "v_ppk_anims\Bullet7_corrective_animation.smd" {
}

$animation "Default_corrective_animation" "v_ppk_anims\Default_corrective_animation.smd" {
}

$animation "Slideback_corrective_animation" "v_ppk_anims\Slideback_corrective_animation.smd" {
}

$animation "runIdle_a_corrective_animation" "v_ppk_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_ppk_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_ppk_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_ppk_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_ppk_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_ppk_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_a_corrective_animation" "v_ppk_anims\shoot2_a_corrective_animation.smd" {
}

$animation "shoot2_ironsight_a_corrective_animation" "v_ppk_anims\shoot2_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3_a_corrective_animation" "v_ppk_anims\shoot3_a_corrective_animation.smd" {
}

$animation "shoot3_ironsight_a_corrective_animation" "v_ppk_anims\shoot3_ironsight_a_corrective_animation.smd" {
}

$animation "shoot4_a_corrective_animation" "v_ppk_anims\shoot4_a_corrective_animation.smd" {
}

$animation "shoot4_ironsight_a_corrective_animation" "v_ppk_anims\shoot4_ironsight_a_corrective_animation.smd" {
}

$animation "shootlast_a_corrective_animation" "v_ppk_anims\shootlast_a_corrective_animation.smd" {
}

$animation "shootlast_ironsight_a_corrective_animation" "v_ppk_anims\shootlast_ironsight_a_corrective_animation.smd" {
}

$animation "PoseDelta" "v_ppk_anims\PoseDelta.smd" {
	fps 30
	
	
}

$animation "Default" "v_ppk_anims\Default.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Default_corrective_animation" 0
}

$animation "Bullet7" "v_ppk_anims\Bullet7.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet7_corrective_animation" 0
}

$animation "Bullet6" "v_ppk_anims\Bullet6.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet6_corrective_animation" 0
}

$animation "Bullet5" "v_ppk_anims\Bullet5.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet5_corrective_animation" 0
}

$animation "Bullet4" "v_ppk_anims\Bullet4.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet4_corrective_animation" 0
}

$animation "Bullet3" "v_ppk_anims\Bullet3.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet3_corrective_animation" 0
}

$animation "Bullet2" "v_ppk_anims\Bullet2.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet2_corrective_animation" 0
}

$animation "Bullet1" "v_ppk_anims\Bullet1.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet1_corrective_animation" 0
}

$animation "Bullet0" "v_ppk_anims\Bullet0.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet0_corrective_animation" 0
}

$animation "Slideback" "v_ppk_anims\Slideback.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Slideback_corrective_animation" 0
}

$animation "basePose_a" "v_ppk_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "ironsight" "v_ppk_anims\ironsight.smd" {
	fps 0.5
	
	
}

$animation "ironsight_transition" "v_ppk_anims\ironsight_transition.smd" {
	fps 0.5
	
	
}

$animation "runIdle_a" "v_ppk_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_ppk_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_ppk_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_ppk_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "shoot1_a" "v_ppk_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_ppk_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "shoot2_a" "v_ppk_anims\shoot2_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_a_corrective_animation" 0
}

$animation "shoot2_ironsight_a" "v_ppk_anims\shoot2_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_ironsight_a_corrective_animation" 0
}

$animation "shoot3_a" "v_ppk_anims\shoot3_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_a_corrective_animation" 0
}

$animation "shoot3_ironsight_a" "v_ppk_anims\shoot3_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_ironsight_a_corrective_animation" 0
}

$animation "shoot4_a" "v_ppk_anims\shoot4_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot4_a_corrective_animation" 0
}

$animation "shoot4_ironsight_a" "v_ppk_anims\shoot4_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot4_ironsight_a_corrective_animation" 0
}

$animation "shootlast_a" "v_ppk_anims\shootlast_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_a_corrective_animation" 0
}

$animation "shootlast_ironsight_a" "v_ppk_anims\shootlast_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_ironsight_a_corrective_animation" 0
}

$animation "nearwall_s_a" "v_ppk_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_ppk_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_ppk_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_ppk_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_ppk_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_ppk_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "proneF" "v_ppk_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_ppk_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_ppk_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_ppk_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_ppk_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_ppk_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_ppk_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_ppk_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_ppk_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_ppk_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$sequence "BulletCounter" {
	"Bullet0"
	"Bullet1"
	"Bullet2"
	"Bullet3"
	"Bullet4"
	"Bullet5"
	"Bullet6"
	"Bullet7"
	"Default"
	blend "ammo_fraction" 0 1
	blendwidth 9
	delta
	fadein 0.2
	fadeout 0.2
	hidden
	node "0"
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
	addlayer "BulletCounter"
	addlayer "SlidePosition"
	node "0"
}

$sequence "draw" {
	"v_ppk_anims\draw.smd"
	"v_ppk_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_PPK.Draw" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	addlayer "BulletCounter"
	addlayer "SlidePosition"
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
	fps 30
	  
	
}

$sequence "Firstdraw" {
	"v_ppk_anims\Firstdraw.smd"
	"v_ppk_anims\Firstdraw_2.smd"
	activity "ACT_VM_FIRSTDRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_PPK.Draw" }
	{ event 5004 9 "MCV_Weapon_Foley_PPK_Reload.MetalStart" }
	{ event 5004 13 "MCV_Weapon_Foley_PPK_Reload.MetalEnd" }
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
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	{ event AE_MUZZLEFLASH 0 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
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
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
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
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "shoot4" {
	"shoot4_a"
	"shoot4_ironsight_a"
	activity "ACT_VM_PRIMARYATTACK" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	{ event AE_MUZZLEFLASH 0 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
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
	{ event 5004 1 "MCV_Weapon_Foley_PPK_ShootLast.Metal" }
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	{ event AE_MUZZLEFLASH 0 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "reload" {
	"v_ppk_anims\reload.smd"
	"v_ppk_anims\reload_2.smd"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_PPK_Reload.Hand" }
	{ event 5004 11 "MCV_Weapon_Foley_PPK_Reload.MagOut" }
	{ event 5004 46 "MCV_Weapon_Foley_PPK_Reload.MagIn" }
	{ event 5004 52 "MCV_Weapon_Foley_PPK_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 58 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 36 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	addlayer "BulletCounter"
	addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "reload_empty" {
	"v_ppk_anims\reload_empty.smd"
	"v_ppk_anims\reload_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_PPK_Reload.Hand" }
	{ event 5004 11 "MCV_Weapon_Foley_PPK_Reload.MagOut" }
	{ event 5004 46 "MCV_Weapon_Foley_PPK_Reload.MagIn" }
	{ event 5004 52 "MCV_Weapon_Foley_PPK_Reload.HandEnd" }
	{ event 5004 64 "MCV_Weapon_Foley_PPK_Reload.MetalStart" }
	{ event 5004 67 "MCV_Weapon_Foley_PPK_Reload.MetalEnd" }
	{ event 5004 77 "MCV_Weapon_Foley_PPK_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 77 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 36 "ammo_fraction" }
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
	addlayer "SlidePosition"
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
	addlayer "SlidePosition"
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
	addlayer "SlidePosition"
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
	addlayer "SlidePosition"
	addlayer "BulletCounter"
	realtime
}

$sequence "bash" {
	"v_ppk_anims\bash.smd"
	"v_ppk_anims\bash_2.smd"
	activity "ACT_VM_HITCENTER" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 3200 3 "" }
	{ event 5004 1 "MCV_Weapon_Foley_Bash.Fast" }
	fadein 0
	fadeout 0.2
	addlayer "SlidePosition"
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
	addlayer "SlidePosition"
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
	addlayer "SlidePosition"
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
	addlayer "SlidePosition"
	addlayer "BulletCounter"
}

$sequence "holster" {
	"v_ppk_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 1 "MCV_Weapon_Foley_PPK.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "SlidePosition"
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
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\pistol_pm\walther_ppk.qc"
//	}
}

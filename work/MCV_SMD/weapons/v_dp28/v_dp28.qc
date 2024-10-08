// Created by Crowbar 0.74

$modelname "weapons/mcv/v_dp28.mdl"

$bodygroup "studio"
{
	studio "Ref_new.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition -1.213 -18.377 -13.755

$cdmaterials "models\weapons\mcv\v_dp28\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "Base" -32 0 0.1 rotate 0 -180 0
$attachment "eject" "Base" -1.9 0 -1 rotate 90 90 0

$cbox 0 0 0 0 0 0

$bbox -10.278 -11.665 -27.509 47.032 9.24 0

$definebone "root" "" 0 7.450089 -27.509027 0 0 0 0 0 0 0 0 0
$definebone "pelvis" "root" -0.000002 0 0 -89.790336 -89.996943 89.996943 0 0 0 0 0 0
$definebone "spine_01" "pelvis" 4.255468 -0.335183 -0.000002 0 -7.153264 0 0 0 0 0 0 0
$definebone "spine_02" "spine_01" 7.43125 1.496477 0.000002 0 14.063248 0 0 0 0 0 0 0
$definebone "spine_03" "spine_02" 5.278481 0.165541 0.000001 0 2.779475 0 0 0 0 0 0 0
$definebone "clavicle_r" "spine_03" 4.678658 -1.075636 1.488978 66.457891 -74.414952 113.208671 0 0 0 0 0 0
$definebone "upperarm_r" "clavicle_r" -6.214486 -0.000006 -0.000026 -39.361188 171.560801 166.195564 0 0 0 0 0 0
$definebone "lowerarm_r" "upperarm_r" 11.944885 -0.000001 -0.000002 -11.599014 34.295442 3.613506 0 0 0 0 0 0
$definebone "hand_r" "lowerarm_r" 10.620186 0 0 40.97506 158.047668 82.471003 0 0 0 0 0 0
$definebone "index_01_r" "hand_r" -4.751106 -0.694494 0.830577 -3.76267 25.538685 14.867223 0 0 0 0 0 0
$definebone "index_02_r" "index_01_r" -1.688072 0.000046 -0.000031 -0.475209 11.986116 1.337744 0 0 0 0 0 0
$definebone "index_03_r" "index_02_r" -1.33614 0.000055 -0.000012 0.996949 -9.496592 1.137552 0 0 0 0 0 0
$definebone "middle_01_r" "hand_r" -4.820496 -0.50946 -0.22476 -7.039532 22.827331 1.91809 0 0 0 0 0 0
$definebone "middle_02_r" "middle_01_r" -1.826988 -0.000069 0.000007 1.136748 12.28067 -2.025007 0 0 0 0 0 0
$definebone "middle_03_r" "middle_02_r" -1.436577 0.000004 0.000001 -4.38972 -15.399551 0.781569 0 0 0 0 0 0
$definebone "pinky_01_r" "hand_r" -3.992357 -0.891188 -1.827909 -18.932822 20.187427 -18.724433 0 0 0 0 0 0
$definebone "pinky_02_r" "pinky_01_r" -1.405918 -0.000024 -0.000001 -1.315571 11.208259 1.06386 0 0 0 0 0 0
$definebone "pinky_03_r" "pinky_02_r" -1.175362 0.000125 -0.000021 3.869411 1.038605 0.445639 0 0 0 0 0 0
$definebone "ring_01_r" "hand_r" -4.526751 -0.690573 -1.120744 -10.988244 23.293488 -13.509885 0 0 0 0 0 0
$definebone "ring_02_r" "ring_01_r" -1.744041 0.000034 -0.000007 -1.669886 13.315316 0.301259 0 0 0 0 0 0
$definebone "ring_03_r" "ring_02_r" -1.368767 0.000023 0.000005 2.987747 -12.899511 -0.36068 0 0 0 0 0 0
$definebone "thumb_01_r" "hand_r" -1.874798 -0.935127 0.999174 36.92026 27.057822 95.069512 0 0 0 0 0 0
$definebone "thumb_02_r" "thumb_01_r" -1.523453 0.000034 0.00003 9.832821 15.151515 1.613449 0 0 0 0 0 0
$definebone "thumb_03_r" "thumb_02_r" -1.599281 0.000004 0.000013 0.480718 -12.385751 2.414095 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" 5.511818 0.000006 -0.000001 -0.000449 179.999773 166.489945 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" 0.196846 -0.000002 0.000002 0.000335 -179.999117 160.050416 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 4.678658 -1.075636 -1.488979 66.457925 105.584814 113.208541 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.214489 0.000005 0.000019 39.360365 -8.439268 13.804506 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.944893 -0.000032 -0.000194 -11.598272 -34.295479 -3.613929 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620171 0.000004 0.00001 -40.973765 21.9507 -97.528066 0 0 0 0 0 0
$definebone "index_01_l" "hand_l" 4.75116 0.694376 -0.830474 -3.764674 25.536503 14.866764 0 0 0 0 0 0
$definebone "index_02_l" "index_01_l" 1.688065 -0.000027 0.000002 -0.475151 11.986516 1.337912 0 0 0 0 0 0
$definebone "index_03_l" "index_02_l" 1.336147 -0.000053 -0.00001 -1.90789 -9.554295 1.137834 0 0 0 0 0 0
$definebone "middle_01_l" "hand_l" 4.820515 0.50934 0.224865 -7.040161 22.825895 1.917685 0 0 0 0 0 0
$definebone "middle_02_l" "middle_01_l" 1.827003 0.000068 0.000009 1.13675 12.280673 -2.02501 0 0 0 0 0 0
$definebone "middle_03_l" "middle_02_l" 1.436577 -0.000008 0.000008 -0.387836 -15.345014 0.779217 0 0 0 0 0 0
$definebone "pinky_01_l" "hand_l" 3.992353 0.891087 1.827995 -18.934254 20.186216 -18.724953 0 0 0 0 0 0
$definebone "pinky_02_l" "pinky_01_l" 1.405922 0.000023 -0.000009 -1.315974 11.208145 1.063923 0 0 0 0 0 0
$definebone "pinky_03_l" "pinky_02_l" 1.175365 -0.000131 0.000003 7.050415 1.063473 0.448055 0 0 0 0 0 0
$definebone "ring_01_l" "hand_l" 4.526758 0.690458 1.120842 -10.989675 23.292052 -13.510295 0 0 0 0 0 0
$definebone "ring_02_l" "ring_01_l" 1.744045 -0.000031 0 -1.670171 13.315717 0.301544 0 0 0 0 0 0
$definebone "ring_03_l" "ring_02_l" 1.368763 -0.000031 -0.000018 9.085969 -12.938532 -0.365207 0 0 0 0 0 0
$definebone "thumb_01_l" "hand_l" 1.874853 0.935081 -0.99913 36.919116 27.057076 95.069567 0 0 0 0 0 0
$definebone "thumb_02_l" "thumb_01_l" 1.523453 -0.000034 0 9.832704 15.151402 1.612767 0 0 0 0 0 0
$definebone "thumb_03_l" "thumb_02_l" 1.599281 0 0.000009 4.129706 -12.231683 2.421154 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511808 -0.000002 0.000005 0.000289 0.000396 -13.510171 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.196848 0.000001 -0.000002 0.000859 -0.000114 -19.951821 0 0 0 0 0 0
$definebone "cam_driver" "" 0 0 0 0 -89.999982 0 0 0 0 0 0 0
$definebone "Base" "" -2.883701 -17.779638 -3.425864 0 89.999982 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 11.985273 8.260983 -2.097095 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" 5.514884 0.001257 -1.245997 0 0 0 0 0 0 0 0 0
$definebone "Mag" "Base" -4.752171 -0.006281 1.200068 0 0 0 0 0 0 0 0 0
$definebone "MagRotate" "Mag" 0.000614 0.000667 0.503254 0 0 0 0 0 0 0 0 0
$definebone "Lock" "MagRotate" 4.542721 0.005373 0.217081 0 0 0 0 0 0 0 0 0
$definebone "Bipod1" "Base" -17.250216 -0.737885 -1.619603 0 0 -29.828987 0 0 0 0 0 0
$definebone "Bipod2" "Base" -17.250216 0.711405 -1.552819 0 0 27.50524 0 0 0 0 0 0
$definebone "Bolt" "Base" -1.111696 1.286179 -1.152144 0 0 0 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" -8.444609 -2.219278 -2.254766 66.092831 -137.02037 177.158592 0 0 0 0 0 0

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
$poseparameter "player_movement" 0 198 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "magRotate_base_corrective_animation" "v_dp28_anims\magRotate_base_corrective_animation.smd" {
}

$animation "magRotate_270_corrective_animation" "v_dp28_anims\magRotate_270_corrective_animation.smd" {
}

$animation "magRotate_180_corrective_animation" "v_dp28_anims\magRotate_180_corrective_animation.smd" {
}

$animation "magRotate_90_corrective_animation" "v_dp28_anims\magRotate_90_corrective_animation.smd" {
}

$animation "runIdle_a_corrective_animation" "v_dp28_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_dp28_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_dp28_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_dp28_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_dp28_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_dp28_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_a_corrective_animation" "v_dp28_anims\shoot2_a_corrective_animation.smd" {
}

$animation "shoot2_ironsight_a_corrective_animation" "v_dp28_anims\shoot2_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3_a_corrective_animation" "v_dp28_anims\shoot3_a_corrective_animation.smd" {
}

$animation "shoot3_ironsight_a_corrective_animation" "v_dp28_anims\shoot3_ironsight_a_corrective_animation.smd" {
}

$animation "shoot1d_a_corrective_animation" "v_dp28_anims\shoot1d_a_corrective_animation.smd" {
}

$animation "shoot1d_ironsight_a_corrective_animation" "v_dp28_anims\shoot1d_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2d_a_corrective_animation" "v_dp28_anims\shoot2d_a_corrective_animation.smd" {
}

$animation "shoot2d_ironsight_a_corrective_animation" "v_dp28_anims\shoot2d_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3d_a_corrective_animation" "v_dp28_anims\shoot3d_a_corrective_animation.smd" {
}

$animation "shoot3d_ironsight_a_corrective_animation" "v_dp28_anims\shoot3d_ironsight_a_corrective_animation.smd" {
}

$animation "magRotate_delta" "v_dp28_anims\magRotate_delta.smd" {
	fps 30
	
	
}

$animation "magRotate_base" "v_dp28_anims\magRotate_base.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "magRotate_base_corrective_animation" 0
}

$animation "magRotate_90" "v_dp28_anims\magRotate_90.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "magRotate_90_corrective_animation" 0
}

$animation "magRotate_180" "v_dp28_anims\magRotate_180.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "magRotate_180_corrective_animation" 0
}

$animation "magRotate_270" "v_dp28_anims\magRotate_270.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "magRotate_270_corrective_animation" 0
}

$animation "magRotate_360" "v_dp28_anims\magRotate_360.smd" {
	fps 30
}

$animation "basePose_a" "v_dp28_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "ironsight" "v_dp28_anims\ironsight.smd" {
	fps 0.5
	
	
}

$animation "ironsight_transition" "v_dp28_anims\ironsight_transition.smd" {
	fps 0.5
	
	
}

$animation "runIdle_a" "v_dp28_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_dp28_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_dp28_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_dp28_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "shoot1_a" "v_dp28_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_dp28_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "shoot2_a" "v_dp28_anims\shoot2_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_a_corrective_animation" 0
}

$animation "shoot2_ironsight_a" "v_dp28_anims\shoot2_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_ironsight_a_corrective_animation" 0
}

$animation "shoot3_a" "v_dp28_anims\shoot3_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_a_corrective_animation" 0
}

$animation "shoot3_ironsight_a" "v_dp28_anims\shoot3_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_ironsight_a_corrective_animation" 0
}

$animation "nearwall_s_a" "v_dp28_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_dp28_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_dp28_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_dp28_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_dp28_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_dp28_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "prone_deployF" "v_dp28_anims\prone_deployF.smd" {
	fps 30
	loop
	
	
}

$animation "prone_deployB" "v_dp28_anims\prone_deployB.smd" {
	fps 30
	
	
}

$animation "prone_deployL" "v_dp28_anims\prone_deployL.smd" {
	fps 30
	
	
}

$animation "prone_deployR" "v_dp28_anims\prone_deployR.smd" {
	fps 30
	
	
}

$animation "proneF" "v_dp28_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_dp28_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_dp28_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_dp28_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_dp28_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_dp28_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_dp28_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_dp28_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_dp28_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_dp28_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "deploy_s_a" "v_dp28_anims\deploy_s_a.smd" {
	fps 40
	
	
}

$animation "deploy_s_a_i" "v_dp28_anims\deploy_s_a_i.smd" {
	fps 40
	
	
}

$animation "deploy_a" "v_dp28_anims\deploy_a.smd" {
	fps 30
	
	
}

$animation "ironsightdeploy" "v_dp28_anims\ironsightdeploy.smd" {
	fps 0.5
	
	
}

$animation "deploy_e_a" "v_dp28_anims\deploy_e_a.smd" {
	fps 40
	
	
}

$animation "deploy_e_a_i" "v_dp28_anims\deploy_e_a_i.smd" {
	fps 40
	
	
}

$animation "shoot1d_a" "v_dp28_anims\shoot1d_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1d_a_corrective_animation" 0
}

$animation "shoot1d_ironsight_a" "v_dp28_anims\shoot1d_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1d_ironsight_a_corrective_animation" 0
}

$animation "shoot2d_a" "v_dp28_anims\shoot2d_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2d_a_corrective_animation" 0
}

$animation "shoot2d_ironsight_a" "v_dp28_anims\shoot2d_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2d_ironsight_a_corrective_animation" 0
}

$animation "shoot3d_a" "v_dp28_anims\shoot3d_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3d_a_corrective_animation" 0
}

$animation "shoot3d_ironsight_a" "v_dp28_anims\shoot3d_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3d_ironsight_a_corrective_animation" 0
}

$sequence "MagRotate" {
	"magRotate_base"
	"magRotate_270"
	"magRotate_180"
	"magRotate_90"
	"magRotate_base"
	autoplay
	blend "ammo_fraction" 0 1
	blendwidth 5
	delta
	fadein 0.2
	fadeout 0.2
	hidden
	node "0"
}

$sequence "runlayer" {
	"runIdle_a"
	"run_a"
	blend "player_movement" 100 185
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
	blend "player_movement" 0 198
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
	blend "player_movement" 0 99
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
	blend "ironsight" 0 1
	blendwidth 3
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	blendlayer "ironsight_test" 0 0 1 0 poseparameter ironsight
	node "0"
}

$sequence "draw" {
	"v_dp28_anims\draw.smd"
	"v_dp28_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_DP28.Draw" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$sequence "Firstdraw" {
	"v_dp28_anims\Firstdraw.smd"
	"v_dp28_anims\Firstdraw_2.smd"
	activity "ACT_VM_FIRSTDRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_DP28.Draw" }
	{ event 5004 10 "MCV_Weapon_Foley_DP28_Reload.Metal" }
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
	"v_dp28_anims\reload.smd"
	"v_dp28_anims\reload_2.smd"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_DP28_Reload.Hand" }
	{ event 5004 20 "MCV_Weapon_Foley_DP28_Reload.MagOut" }
	{ event 5004 62 "MCV_Weapon_Foley_DP28_Reload.MagIn" }
	{ event 5004 70 "MCV_Weapon_Foley_DP28_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 89 "" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 44 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "reload_empty" {
	"v_dp28_anims\reload_empty.smd"
	"v_dp28_anims\reload_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_DP28_Reload.Hand" }
	{ event 5004 20 "MCV_Weapon_Foley_DP28_Reload.MagOut" }
	{ event 5004 62 "MCV_Weapon_Foley_DP28_Reload.MagIn" }
	{ event 5004 107 "MCV_Weapon_Foley_DP28_Reload.Metal" }
	{ event 5004 110 "MCV_Weapon_Foley_DP28_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 117 "" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 44 "ammo_fraction" }
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
	addlayer "runlayer"
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
	addlayer "runlayer"
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
	addlayer "runlayer"
	node "0"
}

$sequence "prone_deploy" {
	"prone_deployF"
	"prone_deployL"
	"prone_deployB"
	"prone_deployR"
	"prone_deployF"
	activity "ACT_VM_CRAWLDEPLOY" 1
	blend "move_yaw" -180 180
	blendwidth 5
	{ event 5004 1 "MCV_Weapon_Foley_Movement.ProneCrawl" }
	{ event 5004 10 "MCV_Weapon_Foley_Movement.ProneCrawl_GunHeavy" }
	fadein 0.3
	fadeout 0.3
	realtime
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
	{ event 5004 10 "MCV_Weapon_Foley_Movement.ProneCrawl_GunHeavy" }
	fadein 0.3
	fadeout 0.3
	realtime
}

$sequence "bash" {
	"v_dp28_anims\bash.smd"
	"v_dp28_anims\bash_2.smd"
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
	addlayer "runlayer"
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
	addlayer "runlayer"
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
	addlayer "runlayer"
}

$sequence "idletodeploy" {
	"deploy_s_a"
	"deploy_s_a_i"
	activity "ACT_VM_IDLETODEPLOY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M16A1_Reload.Hand" }
	{ event 5004 14 "MCV_Weapon_Foley_BAR_Unpack.MetalOut" }
	fadein 0.2
	fadeout 0.2
	node "0"
}

$sequence "deploy" {
	"deploy_a"
	"ironsightdeploy"
	activity "ACT_VM_DEPLOY" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0.2
	fadeout 0.2
	node "0"
}

$sequence "reload_deploy" {
	"v_dp28_anims\reload_deploy.smd"
	"v_dp28_anims\reload_deploy_2.smd"
	activity "ACT_VM_RELOAD_DEPLOYED" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_DP28_Reload.Hand" }
	{ event 5004 20 "MCV_Weapon_Foley_DP28_Reload.MagOut" }
	{ event 5004 62 "MCV_Weapon_Foley_DP28_Reload.MagIn" }
	{ event 5004 70 "MCV_Weapon_Foley_DP28_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 89 "" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 44 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
	
	
}

$sequence "reload_deploy_empty" {
	"v_dp28_anims\reload_deploy_empty.smd"
	"v_dp28_anims\reload_deploy_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY_DEPLOYED" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_DP28_Reload.Hand" }
	{ event 5004 20 "MCV_Weapon_Foley_DP28_Reload.MagOut" }
	{ event 5004 62 "MCV_Weapon_Foley_DP28_Reload.MagIn" }
	{ event 5004 107 "MCV_Weapon_Foley_DP28_Reload.Metal" }
	{ event 5004 110 "MCV_Weapon_Foley_DP28_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 117 "" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 44 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
	
	
}

$sequence "deploytoidle" {
	"deploy_e_a"
	"deploy_e_a_i"
	activity "ACT_VM_DEPLOYTOIDLE" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M16A1_Reload.Hand" }
	{ event 5004 22 "MCV_Weapon_Foley_BAR_Unpack.MetalOut" }
	fadein 0.2
	fadeout 0.2
	node "0"
}

$sequence "deployshoot1" {
	"shoot1d_a"
	"shoot1d_ironsight_a"
	activity "ACT_VM_DEPLOYSHOOT" 1
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

$sequence "deployshoot2" {
	"shoot2d_a"
	"shoot2d_ironsight_a"
	activity "ACT_VM_DEPLOYSHOOT" 1
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

$sequence "deployshoot3" {
	"shoot3d_a"
	"shoot3d_ironsight_a"
	activity "ACT_VM_DEPLOYSHOOT" 1
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

$sequence "holster" {
	"v_dp28_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 0 "MCV_Weapon_Foley_DP28.Holster" }
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
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\lmg_dp28\DP28_new.qc"
//	}
}

// Created by Crowbar 0.74

$modelname "weapons/mcv/v_l2a1.mdl"

$bodygroup "studio"
{
	studio "l2a1_ref.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition 2.752 -21.368 -12.075

$cdmaterials "models\weapons\mcv\v_fal\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "muzzle" "Base" -38.1 0 0.2 rotate 0 -180 0
$attachment "eject" "Base" -3 0.9 0.7 rotate 0 90 0
$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -11.182 -22.68 -27.51 53.919 28.183 3.36

$definebone "root" "" 0 7.450089 -27.509027 0 0 0 0 0 0 0 0 0
$definebone "pelvis" "root" -0.000002 0 0 -89.790623 -89.997175 89.997175 0 0 0 0 0 0
$definebone "spine_01" "pelvis" 4.255466 -0.335183 -0.000002 0 -7.153262 0 0 0 0 0 0 0
$definebone "spine_02" "spine_01" 7.43125 1.496479 0.000002 0 14.063249 0 0 0 0 0 0 0
$definebone "spine_03" "spine_02" 5.278479 0.165544 0.000001 0 2.779475 0 0 0 0 0 0 0
$definebone "clavicle_r" "spine_03" 4.678655 -1.075638 1.488977 66.457884 -74.414959 113.208733 0 0 0 0 0 0
$definebone "upperarm_r" "clavicle_r" -6.214478 -0.000009 -0.000026 -39.361202 171.560801 166.195564 0 0 0 0 0 0
$definebone "lowerarm_r" "upperarm_r" 11.944885 0 0 -11.599014 34.295469 3.613484 0 0 0 0 0 0
$definebone "hand_r" "lowerarm_r" 10.620188 0 0 40.975077 158.047627 82.470989 0 0 0 0 0 0
$definebone "index_01_r" "hand_r" -4.751108 -0.694498 0.83058 -3.762675 25.538683 14.867227 0 0 0 0 0 0
$definebone "index_02_r" "index_01_r" -1.688068 0.000047 -0.000031 -0.475213 11.986115 1.337745 0 0 0 0 0 0
$definebone "index_03_r" "index_02_r" -1.33614 0.000055 -0.00001 0.996946 -9.496594 1.137554 0 0 0 0 0 0
$definebone "middle_01_r" "hand_r" -4.820494 -0.509464 -0.224759 -7.039535 22.827334 1.918093 0 0 0 0 0 0
$definebone "middle_02_r" "middle_01_r" -1.826984 -0.000069 0.000008 1.136744 12.280669 -2.025003 0 0 0 0 0 0
$definebone "middle_03_r" "middle_02_r" -1.436569 0.000004 0.000003 -4.389719 -15.399553 0.781576 0 0 0 0 0 0
$definebone "pinky_01_r" "hand_r" -3.992357 -0.891191 -1.827909 -18.932827 20.18743 -18.724426 0 0 0 0 0 0
$definebone "pinky_02_r" "pinky_01_r" -1.405918 -0.000025 -0.000002 -1.315574 11.208263 1.063867 0 0 0 0 0 0
$definebone "pinky_03_r" "pinky_02_r" -1.175358 0.000126 -0.000019 3.869406 1.038608 0.445644 0 0 0 0 0 0
$definebone "ring_01_r" "hand_r" -4.526751 -0.69058 -1.120741 -10.988246 23.293493 -13.509884 0 0 0 0 0 0
$definebone "ring_02_r" "ring_01_r" -1.744038 0.000032 -0.000008 -1.66989 13.315318 0.301259 0 0 0 0 0 0
$definebone "ring_03_r" "ring_02_r" -1.368771 0.000023 0.000002 2.987742 -12.899505 -0.360677 0 0 0 0 0 0
$definebone "thumb_01_r" "hand_r" -1.874796 -0.935125 0.999175 36.92026 27.057822 95.069526 0 0 0 0 0 0
$definebone "thumb_02_r" "thumb_01_r" -1.523447 0.000031 0.000031 9.832821 15.151525 1.613443 0 0 0 0 0 0
$definebone "thumb_03_r" "thumb_02_r" -1.599285 0.000011 0.000015 0.480713 -12.385745 2.414095 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" 5.51182 0.000008 -0.000002 -0.000423 179.999745 166.489945 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" 0.196846 -0.000002 0.000003 0.000359 -179.999117 160.050416 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 4.678655 -1.075635 -1.488978 66.457932 105.584814 113.208528 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.214486 0.000008 0.000019 39.360369 -8.439265 13.8045 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.944888 -0.000031 -0.0002 -11.598266 -34.295466 -3.613934 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620165 0.000002 0.000006 -40.973755 21.950705 -97.52808 0 0 0 0 0 0
$definebone "index_01_l" "hand_l" 4.751158 0.694374 -0.830474 -3.764682 25.536503 14.866772 0 0 0 0 0 0
$definebone "index_02_l" "index_01_l" 1.688065 -0.000022 0.000002 -0.475157 11.986512 1.337913 0 0 0 0 0 0
$definebone "index_03_l" "index_02_l" 1.336151 -0.000051 -0.000009 -1.907894 -9.554295 1.137835 0 0 0 0 0 0
$definebone "middle_01_l" "hand_l" 4.820515 0.509338 0.224866 -7.040164 22.8259 1.917695 0 0 0 0 0 0
$definebone "middle_02_l" "middle_01_l" 1.826992 0.000066 0.00001 1.136743 12.280665 -2.025001 0 0 0 0 0 0
$definebone "middle_03_l" "middle_02_l" 1.436581 -0.000006 0.00001 -0.387838 -15.345009 0.779228 0 0 0 0 0 0
$definebone "pinky_01_l" "hand_l" 3.992353 0.891087 1.827993 -18.934246 20.186228 -18.724943 0 0 0 0 0 0
$definebone "pinky_02_l" "pinky_01_l" 1.405926 0.000031 -0.000003 -1.315972 11.208145 1.063927 0 0 0 0 0 0
$definebone "pinky_03_l" "pinky_02_l" 1.175362 -0.000132 0.000001 7.050414 1.063467 0.448053 0 0 0 0 0 0
$definebone "ring_01_l" "hand_l" 4.526758 0.690464 1.120843 -10.989675 23.292055 -13.510282 0 0 0 0 0 0
$definebone "ring_02_l" "ring_01_l" 1.744041 -0.000031 -0.000002 -1.670173 13.315707 0.301554 0 0 0 0 0 0
$definebone "ring_03_l" "ring_02_l" 1.368767 -0.000031 -0.000018 9.085959 -12.938534 -0.365195 0 0 0 0 0 0
$definebone "thumb_01_l" "hand_l" 1.874857 0.935081 -0.999129 36.919095 27.057076 95.069581 0 0 0 0 0 0
$definebone "thumb_02_l" "thumb_01_l" 1.523453 -0.000032 -0.000002 9.832704 15.151419 1.612756 0 0 0 0 0 0
$definebone "thumb_03_l" "thumb_02_l" 1.599281 -0.000004 0.00001 4.129713 -12.231671 2.421142 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511806 -0.000002 0.000003 0.000292 0.000412 -13.510177 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.196849 0.000003 -0.000001 0.000862 -0.000112 -19.951824 0 0 0 0 0 0
$definebone "cam_driver" "" 0 0 0 0 -89.999982 0 0 0 0 0 0 0
$definebone "Base" "" -3.747713 -17.93362 -3.222658 0 89.999989 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 12.139252 7.396971 -2.300301 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" 2.2794 0.001257 -1.476642 0 0 0 0 0 0 0 0 0
$definebone "Mag" "Base" -2.718773 -0.00628 -0.523277 0 0 0 0 0 0 0 0 0
$definebone "Bullet" "Mag" 0.058435 0.000667 0.097283 0 0 0 0 0 0 0 0 0
$definebone "Bipod1" "Base" -19.916365 -1.251504 -1.177897 0 0 0 0 0 0 0 0 0
$definebone "Bipod2" "Base" -19.923742 0.641124 -1.168808 0 0 0 0 0 0 0 0 0
$definebone "Bolt" "Base" -3.181225 0.046171 1.126797 0 0 0 0 0 0 0 0 0
$definebone "MagRelease" "Base" -0.372688 -0.753957 -1.57645 0 0 0 0 0 0 0 0 0
$definebone "Boltpuller" "Base" -5.015694 -1.462808 0.175908 0 0 0 0 0 0 0 0 0
$definebone "UpperReceiver_Low" "" -3.741919 -18.427114 -5.599432 0 -179.999978 0 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" -6.078049 -2.613559 -2.699255 76.909241 -129.790724 -173.945958 0 0 0 0 0 0

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

$poseparameter "player_movement" 0 256 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "runIdle_a_corrective_animation" "v_l2a1_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_l2a1_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_l2a1_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_l2a1_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_l2a1_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_l2a1_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_a_corrective_animation" "v_l2a1_anims\shoot2_a_corrective_animation.smd" {
}

$animation "shoot2_ironsight_a_corrective_animation" "v_l2a1_anims\shoot2_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3_a_corrective_animation" "v_l2a1_anims\shoot3_a_corrective_animation.smd" {
}

$animation "shoot3_ironsight_a_corrective_animation" "v_l2a1_anims\shoot3_ironsight_a_corrective_animation.smd" {
}

$animation "shoot1d_a_corrective_animation" "v_l2a1_anims\shoot1d_a_corrective_animation.smd" {
}

$animation "shoot1d_ironsight_a_corrective_animation" "v_l2a1_anims\shoot1d_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2d_a_corrective_animation" "v_l2a1_anims\shoot2d_a_corrective_animation.smd" {
}

$animation "shoot2d_ironsight_a_corrective_animation" "v_l2a1_anims\shoot2d_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3d_a_corrective_animation" "v_l2a1_anims\shoot3d_a_corrective_animation.smd" {
}

$animation "shoot3d_ironsight_a_corrective_animation" "v_l2a1_anims\shoot3d_ironsight_a_corrective_animation.smd" {
}

$animation "basePose_a" "v_l2a1_anims\basePose_a.smd" {
	fps 30
	loop
	numframes 60
	
	
}

$animation "ironsight" "v_l2a1_anims\ironsight.smd" {
	fps 30
	frame 1 1
	numframes 60
	
	
}

$animation "ironsight_transition" "v_l2a1_anims\ironsight_transition.smd" {
	fps 30
	numframes 60
	
	
}

$animation "runIdle_a" "v_l2a1_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_l2a1_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_l2a1_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_l2a1_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "shoot1_a" "v_l2a1_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_l2a1_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "shoot2_a" "v_l2a1_anims\shoot2_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_a_corrective_animation" 0
}

$animation "shoot2_ironsight_a" "v_l2a1_anims\shoot2_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_ironsight_a_corrective_animation" 0
}

$animation "shoot3_a" "v_l2a1_anims\shoot3_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_a_corrective_animation" 0
}

$animation "shoot3_ironsight_a" "v_l2a1_anims\shoot3_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_ironsight_a_corrective_animation" 0
}

$animation "nearwall_s_a" "v_l2a1_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_l2a1_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_l2a1_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_l2a1_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_l2a1_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_l2a1_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "prone_deployF" "v_l2a1_anims\prone_deployF.smd" {
	fps 30
	loop
	
	
}

$animation "prone_deployB" "v_l2a1_anims\prone_deployB.smd" {
	fps 30
	
	
}

$animation "prone_deployL" "v_l2a1_anims\prone_deployL.smd" {
	fps 30
	
	
}

$animation "prone_deployR" "v_l2a1_anims\prone_deployR.smd" {
	fps 30
	
	
}

$animation "proneF" "v_l2a1_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_l2a1_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_l2a1_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_l2a1_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_l2a1_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_l2a1_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_l2a1_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_l2a1_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_l2a1_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_l2a1_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "deploy_s_a" "v_l2a1_anims\deploy_s_a.smd" {
	fps 40
	
	
}

$animation "deploy_s_a_i" "v_l2a1_anims\deploy_s_a_i.smd" {
	fps 40
	
	
}

$animation "deploy_a" "v_l2a1_anims\deploy_a.smd" {
	fps 30
	
	
}

$animation "ironsightdeploy" "v_l2a1_anims\ironsightdeploy.smd" {
	fps 30
	frame 0 1
	numframes 60
	
	
}

$animation "deploy_e_a" "v_l2a1_anims\deploy_e_a.smd" {
	fps 40
	
	
}

$animation "deploy_e_a_i" "v_l2a1_anims\deploy_e_a_i.smd" {
	fps 40
	
	
}

$animation "shoot1d_a" "v_l2a1_anims\shoot1d_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1d_a_corrective_animation" 0
}

$animation "shoot1d_ironsight_a" "v_l2a1_anims\shoot1d_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1d_ironsight_a_corrective_animation" 0
}

$animation "shoot2d_a" "v_l2a1_anims\shoot2d_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2d_a_corrective_animation" 0
}

$animation "shoot2d_ironsight_a" "v_l2a1_anims\shoot2d_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2d_ironsight_a_corrective_animation" 0
}

$animation "shoot3d_a" "v_l2a1_anims\shoot3d_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3d_a_corrective_animation" 0
}

$animation "shoot3d_ironsight_a" "v_l2a1_anims\shoot3d_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3d_ironsight_a_corrective_animation" 0
}

$animation "change_firemode_idle" "v_l2a1_anims\change_firemode_idle.smd" {
	fps 30
	
	
}

$animation "change_firemode_iron" "v_l2a1_anims\change_firemode_iron.smd" {
	fps 30
	
	
}

$animation "change_firemode_idle_d" "v_l2a1_anims\change_firemode_idle_d.smd" {
	fps 30
	
	
}

$animation "change_firemode_iron_d" "v_l2a1_anims\change_firemode_iron_d.smd" {
	fps 30
	
	
}

$sequence "runlayer" {
	"runIdle_a"
	"run_a"
	blend "player_movement" 128 221
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
	blend "player_movement" 0 256
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
	blend "player_movement" 0 128
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
	"v_l2a1_anims\draw.smd"
	"v_l2a1_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_L2A1.Draw" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	fps 30
	
	
}

$sequence "Firstdraw" {
	"v_l2a1_anims\Firstdraw.smd"
	"v_l2a1_anims\Firstdraw_2.smd"
	activity "ACT_VM_READY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_L2A1.Draw" }
	{ event 5004 8 "MCV_Weapon_Foley_L2A1_Reload.MetalStart" }
	{ event 5004 15 "MCV_Weapon_Foley_L2A1_Reload.MetalEnd" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
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
	fadein 0
	fadeout 0
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
	fadein 0
	fadeout 0
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
	fadein 0
	fadeout 0
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
	"v_l2a1_anims\reload.smd"
	"v_l2a1_anims\reload_2.smd"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_L2A1_Reload.Hand" }
	{ event 5004 18 "MCV_Weapon_Foley_L2A1_Reload.MagOut" }
	{ event 5004 65 "MCV_Weapon_Foley_L2A1_Reload.MagIn" }
	{ event 5004 77 "MCV_Weapon_Foley_L2A1.Holster" }
	{ event AE_WPN_COMPLETE_RELOAD 50 "" }
	fadein 0.2
	fadeout 0.2
	//addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "reload_empty" {
	"v_l2a1_anims\reload_empty.smd"
	"v_l2a1_anims\reload_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_L2A1_Reload.Hand" }
	{ event 5004 18 "MCV_Weapon_Foley_L2A1_Reload.MagOut" }
	{ event 5004 65 "MCV_Weapon_Foley_L2A1_Reload.MagIn" }
	{ event 5004 82 "MCV_Weapon_Foley_L2A1_Reload.MetalStart" }
	{ event 5004 89 "MCV_Weapon_Foley_L2A1_Reload.MetalEnd" }
	{ event 5004 100 "MCV_Weapon_Foley_L2A1.Holster" }
	{ event AE_WPN_COMPLETE_RELOAD 79 "" }
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
	{ event 5004 10 "MCV_Weapon_Foley_Movement.ProneCrawl_GunMedium" }
	fadein 0.3
	fadeout 0.3
	realtime
}

$sequence "bash" {
	"v_l2a1_anims\bash.smd"
	"v_l2a1_anims\bash_2.smd"
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
	"v_l2a1_anims\reload_deploy.smd"
	"v_l2a1_anims\reload_deploy_2.smd"
	activity "ACT_VM_RELOAD_DEPLOYED" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_L2A1_Reload.Hand" }
	{ event 5004 18 "MCV_Weapon_Foley_L2A1_Reload.MagOut" }
	{ event 5004 65 "MCV_Weapon_Foley_L2A1_Reload.MagIn" }
	{ event 5004 77 "MCV_Weapon_Foley_L2A1.Holster" }
	{ event AE_WPN_COMPLETE_RELOAD 50 "" }
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
	
	
}

$sequence "reload_deploy_empty" {
	"v_l2a1_anims\reload_deploy_empty.smd"
	"v_l2a1_anims\reload_deploy_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY_DEPLOYED" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_L2A1_Reload.Hand" }
	{ event 5004 18 "MCV_Weapon_Foley_L2A1_Reload.MagOut" }
	{ event 5004 65 "MCV_Weapon_Foley_L2A1_Reload.MagIn" }
	{ event 5004 82 "MCV_Weapon_Foley_L2A1_Reload.MetalStart" }
	{ event 5004 89 "MCV_Weapon_Foley_L2A1_Reload.MetalEnd" }
	{ event 5004 100 "MCV_Weapon_Foley_L2A1.Holster" }
	{ event AE_WPN_COMPLETE_RELOAD 79 "" }
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
	addlayer "walklayer"
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

$sequence "change_firemode_deploy" {
	"change_firemode_idle_d"
	"change_firemode_iron_d"
	activity "ACT_VM_FIREMODE_DEPLOY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 6 "MCV_Weapon_Foley_AK47.DrawMetal" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
}

$sequence "holster" {
	"v_l2a1_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 0 "MCV_Weapon_Foley_L2A1.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	fps 30
	
	
}

$includemodel "weapons/gesture_animations.mdl"

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\rifle_fal\l2a1.qc"
//	}
}

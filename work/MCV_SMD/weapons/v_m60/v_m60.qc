// Created by Crowbar 0.74

$modelname "weapons/mcv/v_m60.mdl"

$bodygroup "studio"
{
	studio "Ref.smd"
}
$bodygroup "bipod"
{
	studio "bipod_new.smd"
}
$bodygroup "bullet01"
{
	studio "Bullet.006.smd"
	blank
}
$bodygroup "bullet02"
{
	studio "Bullet.005.smd"
	blank
}
$bodygroup "bullet03"
{
	studio "Bullet.004.smd"
	blank
}
$bodygroup "bullet04"
{
	studio "Bullet.003.smd"
	blank
}
$bodygroup "bullet05"
{
	studio "Bullet.002.smd"
	blank
}
$bodygroup "bullet06"
{
	studio "Bullet.001.smd"
	blank
}
$bodygroup "bullet07"
{
	studio "Bullet.smd"
	blank
}
$bodygroup "clamped1"
{
	studio "body9_model0.smd"
}
$bodygroup "clamped2"
{
	studio "body10_model0.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 10.486 -22.848 -15.272

$cdmaterials "models\weapons\mcv\v_m60\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "Base" -32 0 0.5 rotate 0 -180 0
$attachment "eject" "Base" 3.5 1 1 rotate 0 90 0

$cbox 0 0 0 0 0 0

$bbox -9.182 -12.761 -32.406 54.878 33.732 1.863

$definebone "root" "" 0 7.450089 -27.509027 0 0 0 0 0 0 0 0 0
$definebone "pelvis" "root" -0.000002 0 0 -89.790336 -89.996943 89.996943 0 0 0 0 0 0
$definebone "spine_01" "pelvis" 4.255468 -0.335183 -0.000002 0 -7.153264 0 0 0 0 0 0 0
$definebone "spine_02" "spine_01" 7.431248 1.496477 0.000002 0 14.063251 0 0 0 0 0 0 0
$definebone "spine_03" "spine_02" 5.278479 0.165541 0.000001 0 2.779477 0 0 0 0 0 0 0
$definebone "clavicle_r" "spine_03" 4.678654 -1.075636 1.488977 66.457877 -74.414959 113.208678 0 0 0 0 0 0
$definebone "upperarm_r" "clavicle_r" -6.214482 -0.000007 -0.000027 -39.224533 171.579666 165.731412 0 0 0 0 0 0
$definebone "lowerarm_r" "upperarm_r" 11.944882 0 0 -11.59903 34.295845 3.613612 0 0 0 0 0 0
$definebone "hand_r" "lowerarm_r" 10.620178 0 0.000001 40.946001 157.604826 81.848083 0 0 0 0 0 0
$definebone "index_01_r" "hand_r" -4.751106 -0.694496 0.830576 -3.762664 25.538673 14.867218 0 0 0 0 0 0
$definebone "index_02_r" "index_01_r" -1.688072 0.000046 -0.000032 -0.475205 11.986101 1.337743 0 0 0 0 0 0
$definebone "index_03_r" "index_02_r" -1.336136 0.00005 -0.000012 0.996953 -9.49661 1.137551 0 0 0 0 0 0
$definebone "middle_01_r" "hand_r" -4.820496 -0.50946 -0.22476 -7.039526 22.827327 1.918086 0 0 0 0 0 0
$definebone "middle_02_r" "middle_01_r" -1.826988 -0.000067 0.000003 1.136755 12.280665 -2.025009 0 0 0 0 0 0
$definebone "middle_03_r" "middle_02_r" -1.436581 0.000011 0.000004 -4.389713 -15.399555 0.781563 0 0 0 0 0 0
$definebone "pinky_01_r" "hand_r" -3.992357 -0.891188 -1.827908 -18.93282 20.187422 -18.724439 0 0 0 0 0 0
$definebone "pinky_02_r" "pinky_01_r" -1.405918 -0.000025 -0.000007 -1.315562 11.208259 1.063858 0 0 0 0 0 0
$definebone "pinky_03_r" "pinky_02_r" -1.175358 0.000128 -0.000018 3.869419 1.038545 0.445637 0 0 0 0 0 0
$definebone "ring_01_r" "hand_r" -4.526751 -0.690577 -1.120744 -10.988238 23.293482 -13.509896 0 0 0 0 0 0
$definebone "ring_02_r" "ring_01_r" -1.744041 0.000034 -0.000011 -1.669877 13.315305 0.30125 0 0 0 0 0 0
$definebone "ring_03_r" "ring_02_r" -1.368774 0.000023 0.000005 2.987751 -12.899517 -0.360687 0 0 0 0 0 0
$definebone "thumb_01_r" "hand_r" -1.874802 -0.935125 0.999173 36.92027 27.057825 95.069512 0 0 0 0 0 0
$definebone "thumb_02_r" "thumb_01_r" -1.523451 0.000031 0.00003 9.832821 15.151508 1.613455 0 0 0 0 0 0
$definebone "thumb_03_r" "thumb_02_r" -1.599281 0.000006 0.000014 0.480715 -12.385756 2.414103 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" 5.511812 0.000006 -0.000003 -0.0004 179.999759 166.489945 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" 0.196849 -0.000001 0.000001 0.000347 -179.999117 160.050416 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 4.678655 -1.075636 -1.488978 66.457918 105.584814 113.208535 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.214485 0.000006 0.00002 39.301749 -8.431127 14.003665 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.944885 -0.000031 -0.000192 -11.598272 -34.295435 -3.613929 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620165 0 0.000009 -40.961717 22.140693 -97.795523 0 0 0 0 0 0
$definebone "index_01_l" "hand_l" 4.751156 0.69438 -0.830472 -3.764673 25.536506 14.866755 0 0 0 0 0 0
$definebone "index_02_l" "index_01_l" 1.688068 -0.000025 0.000003 -0.475147 11.986508 1.337908 0 0 0 0 0 0
$definebone "index_03_l" "index_02_l" 1.336147 -0.000055 -0.00001 -1.907887 -9.554301 1.13783 0 0 0 0 0 0
$definebone "middle_01_l" "hand_l" 4.820513 0.50934 0.224866 -7.040159 22.8259 1.917678 0 0 0 0 0 0
$definebone "middle_02_l" "middle_01_l" 1.826992 0.000069 0.00001 1.136752 12.280665 -2.025016 0 0 0 0 0 0
$definebone "middle_03_l" "middle_02_l" 1.436577 -0.000008 0.000009 -0.387835 -15.345005 0.77921 0 0 0 0 0 0
$definebone "pinky_01_l" "hand_l" 3.992352 0.89109 1.827999 -18.934247 20.186226 -18.724962 0 0 0 0 0 0
$definebone "pinky_02_l" "pinky_01_l" 1.405922 0.000023 -0.000005 -1.315966 11.208149 1.063908 0 0 0 0 0 0
$definebone "pinky_03_l" "pinky_02_l" 1.175362 -0.00013 0.000001 7.050423 1.063473 0.448036 0 0 0 0 0 0
$definebone "ring_01_l" "hand_l" 4.526756 0.69046 1.120842 -10.989672 23.292055 -13.510296 0 0 0 0 0 0
$definebone "ring_02_l" "ring_01_l" 1.744045 -0.000031 -0.000002 -1.670166 13.315708 0.301533 0 0 0 0 0 0
$definebone "ring_03_l" "ring_02_l" 1.368763 -0.000034 -0.000015 9.085969 -12.938526 -0.36522 0 0 0 0 0 0
$definebone "thumb_01_l" "hand_l" 1.874849 0.935083 -0.999131 36.919116 27.057087 95.069567 0 0 0 0 0 0
$definebone "thumb_02_l" "thumb_01_l" 1.523455 -0.000032 -0.000005 9.832706 15.151404 1.612768 0 0 0 0 0 0
$definebone "thumb_03_l" "thumb_02_l" 1.599277 0 0.000009 4.129712 -12.231684 2.421153 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511805 -0.000006 0.000006 0.000287 0.000388 -13.510168 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.196848 0.000003 -0.000001 0.000855 -0.000109 -19.951824 0 0 0 0 0 0
$definebone "cam_driver" "" 0 0 0 0 -89.999982 0 0 0 0 0 0 0
$definebone "Base" "" -5.028079 -20.001778 -5.072764 0 89.999989 0 0 0 0 0 0 0
$definebone "Mag" "Base" 3.562271 -2.670158 -1.409541 0 0 0 0 0 0 0 0 0
$definebone "Bipod1" "Base" -30.088285 -1.115845 -1.463938 0 0 -27.237152 0 0 0 0 0 0
$definebone "Bipod2" "Base" -30.088285 2.377126 -1.463938 0 0 -150.316399 0 0 0 0 0 0
$definebone "Bullet" "Mag" -0.408161 -0.457545 0.99114 0 0 0 0 0 0 0 0 0
$definebone "Bullet.001" "Bullet" 0 0.630064 0.121601 0 0 0 0 0 0 0 0 0
$definebone "Bullet.002" "Bullet.001" -0.000011 0.607194 0.227037 0 0 0 0 0 0 0 0 0
$definebone "Bullet.003" "Bullet.002" 0 0.480475 0.464635 0 0 0 0 0 0 0 0 0
$definebone "Bullet.004" "Bullet.003" 0 0.406556 0.591353 0 0 0 0 0 0 0 0 0
$definebone "Bullet.005" "Bullet.004" 0 0.711706 0.311517 0 0 0 0 0 0 0 0 0
$definebone "Bullet.006" "Bullet.005" 0 0.817265 0.063021 0 0 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 9.604701 0.807206 -5.540215 61.317313 92.966477 16.915489 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" -2.194311 -2.454018 -2.619441 75.62686 -84.766104 -121.787027 0 0 0 0 0 0
$definebone "Cover" "Base" 0.499826 0.085256 2.349092 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" 3.278049 0.085256 -2.979594 0 0 0 0 0 0 0 0 0
$definebone "BoltSlide" "Base" 0.42424 1.625255 -1.006774 0 0 0 0 0 0 0 0 0

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

$poseparameter "player_movement" 0 195 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "runIdle_a_corrective_animation" "v_m60_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_m60_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_m60_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_m60_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_m60_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_m60_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_a_corrective_animation" "v_m60_anims\shoot2_a_corrective_animation.smd" {
}

$animation "shoot2_ironsight_a_corrective_animation" "v_m60_anims\shoot2_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3_a_corrective_animation" "v_m60_anims\shoot3_a_corrective_animation.smd" {
}

$animation "shoot3_ironsight_a_corrective_animation" "v_m60_anims\shoot3_ironsight_a_corrective_animation.smd" {
}

$animation "shoot1_d_a_corrective_animation" "v_m60_anims\shoot1_d_a_corrective_animation.smd" {
}

$animation "shoot2_d_a_corrective_animation" "v_m60_anims\shoot2_d_a_corrective_animation.smd" {
}

$animation "shoot3_d_a_corrective_animation" "v_m60_anims\shoot3_d_a_corrective_animation.smd" {
}

$animation "idle_delta" "v_m60_anims\idle_delta.smd" {
	fps 2
	
	
}

$animation "basePose_a" "v_m60_anims\basePose_a.smd" {
	fps 30
	numframes 60
	
	
}

$animation "ironsight" "v_m60_anims\ironsight.smd" {
	fps 30
	frame 1 1
	numframes 60
	
	
}

$animation "ironsight_transition" "v_m60_anims\ironsight_transition.smd" {
	fps 30
	frame 0 1
	numframes 60
	
	
}

$animation "runIdle_a" "v_m60_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_m60_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_m60_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_m60_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "shoot1_a" "v_m60_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_m60_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "shoot2_a" "v_m60_anims\shoot2_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_a_corrective_animation" 0
}

$animation "shoot2_ironsight_a" "v_m60_anims\shoot2_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_ironsight_a_corrective_animation" 0
}

$animation "shoot3_a" "v_m60_anims\shoot3_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_a_corrective_animation" 0
}

$animation "shoot3_ironsight_a" "v_m60_anims\shoot3_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_ironsight_a_corrective_animation" 0
}

$animation "nearwall_s_a" "v_m60_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_m60_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_m60_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_m60_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_m60_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_m60_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "prone_deployF" "v_m60_anims\prone_deployF.smd" {
	fps 30
	loop
	
	
}

$animation "prone_deployB" "v_m60_anims\prone_deployB.smd" {
	fps 30
	
	
}

$animation "prone_deployL" "v_m60_anims\prone_deployL.smd" {
	fps 30
	
	
}

$animation "prone_deployR" "v_m60_anims\prone_deployR.smd" {
	fps 30
	
	
}

$animation "proneF" "v_m60_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_m60_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_m60_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_m60_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_m60_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_m60_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_m60_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_m60_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_m60_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_m60_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "deploy_s_a" "v_m60_anims\deploy_s_a.smd" {
	fps 40
	
	
}

$animation "deploy_s_a_i" "v_m60_anims\deploy_s_a_i.smd" {
	fps 40
	
	
}

$animation "deploy_a" "v_m60_anims\deploy_a.smd" {
	fps 30
	frame 0 0
	numframes 60
	
	
	
}

$animation "ironsightdeploy" "v_m60_anims\ironsightdeploy.smd" {
	fps 30
	frame 1 1
	numframes 60
	
	
}

$animation "deploy_e_a" "v_m60_anims\deploy_e_a.smd" {
	fps 40
	
	
}

$animation "deploy_e_a_i" "v_m60_anims\deploy_e_a_i.smd" {
	fps 40
	
	
}

$animation "shoot1_d_a" "v_m60_anims\shoot1_d_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_d_a_corrective_animation" 0
}

$animation "shoot2_d_a" "v_m60_anims\shoot2_d_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_d_a_corrective_animation" 0
}

$animation "shoot3_d_a" "v_m60_anims\shoot3_d_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_d_a_corrective_animation" 0
}

$sequence "runlayer" {
	"runIdle_a"
	"run_a"
	blend "player_movement" 106 195
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
	blend "player_movement" 0 195
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
	blend "player_movement" 0 106
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
	node "0"
}

$sequence "draw" {
	"v_m60_anims\draw.smd"
	"v_m60_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M60.Draw" }
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 1 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	fps 30
	
	
}

$sequence "Firstdraw" {
	"v_m60_anims\Firstdraw.smd"
	"v_m60_anims\Firstdraw_2.smd"
	activity "ACT_VM_READY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M60.Draw" }
	{ event 5004 10 "MCV_Weapon_Foley_M60_Reload.Metal" }
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 1 "" }
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
	{ event AE_MUZZLEFLASH 0 "SMG1 MUZZLE" }
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 0 "" }
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	hidden
	node "Fire"
	snap
}

$sequence "shootpose2" {
	"shoot2_a"
	"shoot2_ironsight_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_MUZZLEFLASH 0 "SMG1 MUZZLE" }
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 0 "" }
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	hidden
	node "Fire"
	snap
}

$sequence "shootpose3" {
	"shoot3_a"
	"shoot3_ironsight_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_MUZZLEFLASH 0 "SMG1 MUZZLE" }
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 0 "" }
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	hidden
	node "Fire"
	snap
}

$sequence "reload" {
	"v_m60_anims\reload.smd"
	"v_m60_anims\reload_2.smd"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M60_Reload.Hand" }
	{ event 5004 18 "MCV_Weapon_Foley_M60_Reload.CoverStart" }
	{ event 5004 21 "MCV_Weapon_Foley_M60_Reload.BulletsOut" }
	{ event 5004 42 "MCV_Weapon_Foley_M60_Reload.MagOut" }
	{ event AE_CL_BODYGROUP_SET_TO_NEXTCLIP 54 "" }
	{ event 5004 75 "MCV_Weapon_Foley_M60_Reload.MagIn" }
	{ event 5004 94 "MCV_Weapon_Foley_M60_Reload.BulletsIn" }
	{ event 5004 123 "MCV_Weapon_Foley_M60_Reload.CoverEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 134 "" }
	{ event 5004 134 "MCV_Weapon_Foley_M60_Reload.HandEnd" }
	fadein 0.2
	fadeout 0.2
	//addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "reload_empty" {
	"v_m60_anims\reload_empty.smd"
	"v_m60_anims\reload_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M60_Reload.Hand" }
	{ event 5004 18 "MCV_Weapon_Foley_M60_Reload.CoverStart" }
	{ event 5004 42 "MCV_Weapon_Foley_M60_Reload.MagOut" }
	{ event AE_CL_BODYGROUP_SET_TO_NEXTCLIP 54 "" }
	{ event 5004 75 "MCV_Weapon_Foley_M60_Reload.MagIn" }
	{ event 5004 94 "MCV_Weapon_Foley_M60_Reload.BulletsIn" }
	{ event 5004 123 "MCV_Weapon_Foley_M60_Reload.CoverEnd" }
	{ event 5004 150 "MCV_Weapon_Foley_M60_Reload.Metal" }
	{ event 5004 155 "MCV_Weapon_Foley_M60_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 165 "" }
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
	{ event 5004 10 "MCV_Weapon_Foley_Movement.ProneCrawl_GunHeavy" }
	fadein 0.3
	fadeout 0.3
	realtime
}

$sequence "bash" {
	"v_m60_anims\bash.smd"
	"v_m60_anims\bash_2.smd"
	activity "ACT_VM_HITCENTER" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 3200 3 "" }
	{ event 5004 1 "MCV_Weapon_Foley_Bash.Fast" }
	fadein 0
	fadeout 0.2
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
	activity "ACT_VM_DEPLOYED_IN" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M16A1_Reload.Hand" }
	{ event 5004 8 "MCV_Weapon_Foley_BAR_Unpack.MetalIn" }
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
	"v_m60_anims\reload_deploy.smd"
	"v_m60_anims\reload_deploy_2.smd"
	activity "ACT_VM_RELOAD_DEPLOYED" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M60_Reload.Hand" }
	{ event 5004 18 "MCV_Weapon_Foley_M60_Reload.CoverStart" }
	{ event 5004 21 "MCV_Weapon_Foley_M60_Reload.BulletsOut" }
	{ event 5004 42 "MCV_Weapon_Foley_M60_Reload.MagOut" }
	{ event AE_CL_BODYGROUP_SET_TO_NEXTCLIP 54 "" }
	{ event 5004 75 "MCV_Weapon_Foley_M60_Reload.MagIn" }
	{ event 5004 94 "MCV_Weapon_Foley_M60_Reload.BulletsIn" }
	{ event 5004 120 "MCV_Weapon_Foley_M60_Reload.CoverEnd" }
	{ event 5004 134 "MCV_Weapon_Foley_M60_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 134 "" }
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
	
	
}

$sequence "reload_deploy_empty" {
	"v_m60_anims\reload_deploy_empty.smd"
	"v_m60_anims\reload_deploy_empty_2.smd"
	activity "ACT_VM_DEPLOYED_RELOAD_EMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M60_Reload.Hand" }
	{ event 5004 18 "MCV_Weapon_Foley_M60_Reload.CoverStart" }
	{ event 5004 42 "MCV_Weapon_Foley_M60_Reload.MagOut" }
	{ event AE_CL_BODYGROUP_SET_TO_NEXTCLIP 54 "" }
	{ event 5004 75 "MCV_Weapon_Foley_M60_Reload.MagIn" }
	{ event 5004 94 "MCV_Weapon_Foley_M60_Reload.BulletsIn" }
	{ event 5004 120 "MCV_Weapon_Foley_M60_Reload.CoverEnd" }
	{ event 5004 150 "MCV_Weapon_Foley_M60_Reload.Metal" }
	{ event 5004 155 "MCV_Weapon_Foley_M60_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 165 "" }
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
	
	
}

$sequence "deploytoidle" {
	"deploy_e_a"
	"deploy_e_a_i"
	activity "ACT_VM_DEPLOYED_OUT" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M16A1_Reload.Hand" }
	{ event 5004 22 "MCV_Weapon_Foley_BAR_Unpack.MetalOut" }
	fadein 0.2
	fadeout 0.2
	node "0"
}

$sequence "deployshoot1" {
	"deploy_a"
	"ironsight_transition"
	"ironsightdeploy"
	activity "ACT_VM_PRIMARYATTACK_DEPLOYED" 1
	blend "ironsight" 0 1
	blendwidth 3
	snap
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "deployshoot1_pose"
	node "0"
}

$sequence "deployshoot2" {
	"deploy_a"
	"ironsight_transition"
	"ironsightdeploy"
	activity "ACT_VM_PRIMARYATTACK_DEPLOYED" 1
	blend "ironsight" 0 1
	blendwidth 3
	snap
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "deployshoot2_pose"
	node "0"
}

$sequence "deployshoot3" {
	"deploy_a"
	"ironsight_transition"
	"ironsightdeploy"
	activity "ACT_VM_PRIMARYATTACK_DEPLOYED" 1
	blend "ironsight" 0 1
	blendwidth 3
	snap
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "deployshoot3_pose"
	node "0"
}

$sequence "deployshoot4" {
	"deploy_a"
	"ironsight_transition"
	"ironsightdeploy"
	activity "ACT_VM_PRIMARYATTACK_DEPLOYED" 1
	blend "ironsight" 0 1
	blendwidth 3
	snap
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "deployshoot4_pose"
	node "0"
}

$sequence "deployshoot1_pose" {
	"shoot1_d_a"
	"shoot1_d_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_MUZZLEFLASH 0 "SMG1 MUZZLE" }
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 0 "" }
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	hidden
	node "Fire"
	snap
}

$sequence "deployshoot2_pose" {
	"shoot2_d_a"
	"shoot2_d_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_MUZZLEFLASH 0 "SMG1 MUZZLE" }
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 0 "" }
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	hidden
	node "Fire"
	snap
}

$sequence "deployshoot3_pose" {
	"shoot3_d_a"
	"shoot3_d_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_MUZZLEFLASH 0 "SMG1 MUZZLE" }
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 0 "" }
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	hidden
	node "Fire"
	snap
}

$sequence "deployshoot4_pose" {
	"shoot3_d_a"
	"shoot3_d_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_MUZZLEFLASH 0 "SMG1 MUZZLE" }
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 0 "" }
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	hidden
	node "Fire"
	snap
}

$sequence "holster" {
	"v_m60_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 0 "MCV_Weapon_Foley_M60.Holster" }
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
//		"value" "models\guns\lmg_m60\m60_new.qc"
//	}
}

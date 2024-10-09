// Created by Crowbar 0.74

$modelname "weapons/mcv/v_stoner63.mdl"

$bodygroup "studio"
{
	studio "Ref_new_bipodless.smd"
}
$bodygroup "bullet01"
{
	studio "Bulletnew.smd"
	blank
}
$bodygroup "bullet02"
{
	studio "Bulletnew.001.smd"
	blank
}
$bodygroup "bullet03"
{
	studio "Bulletnew.002.smd"
	blank
}
$bodygroup "bullet04"
{
	studio "Bulletnew.003.smd"
	blank
}
$bodygroup "bullet05"
{
	studio "Bulletnew.004.smd"
	blank
}
$bodygroup "bullet06"
{
	studio "Bulletnew.005.smd"
	blank
}
$bodygroup "bullet07"
{
	studio "Bulletnew.006.smd"
	blank
}
$bodygroup "bullet08"
{
	studio "Bulletnew.007.smd"
	blank
}
$bodygroup "bullet09"
{
	studio "Bulletnew.008.smd"
	blank
}
$bodygroup "bullet10"
{
	studio "Bulletnew.009.smd"
	blank
}
$bodygroup "bullet11"
{
	studio "Bulletnew.010.smd"
	blank
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 4.937 -16.104 -12.214

$cdmaterials "models\weapons\mcv\v_stoner63\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "Base" -24.3 0 0.8 rotate 0 180 0
$attachment "eject" "Base" 1 1 1 rotate 0 90 0

$cbox 0 0 0 0 0 0

$bbox -10.182 -14.446 -27.51 42.39 24.319 3.082

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
$definebone "Base" "" -3.850274 -18.600327 -4.251705 0 89.999989 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 12.805958 7.29441 -1.271254 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" 3.961849 0.642975 -1.929704 0 0 0 0 0 0 0 0 0
$definebone "Mag" "Base" -2.857964 -1.151006 -1.511703 0 0 0 0 0 0 0 0 0
$definebone "MagCover" "Mag" 2.895435 -2.097063 0.046948 0 0 0 0 0 0 0 0 0
$definebone "Bullet" "Mag" 3.508892 -1.179811 -0.847633 0 0 90.483266 0 0 0 0 0 0
$definebone "Bullet.001" "Bullet" -0.000002 0.689174 0 0.131895 -0.00212 -0.920915 0 0 0 0 0 0
$definebone "Bullet.002" "Bullet.001" -0.000006 0.481626 0 -0.30086 -0.001604 0.534856 0 0 0 0 0 0
$definebone "Bullet.003" "Bullet.002" -0.000004 0.504691 0 0.289057 -0.008021 -3.8269 0 0 0 0 0 0
$definebone "Bullet.004" "Bullet.003" -0.000006 0.488307 0 -0.076031 -0.012777 -16.07485 0 0 0 0 0 0
$definebone "Bullet.005" "Bullet.004" -0.000006 0.490659 0 -0.161402 0.062911 -28.624981 0 0 0 0 0 0
$definebone "Bullet.006" "Bullet.005" -0.000004 0.501841 0 -0.270264 -0.029679 4.228881 0 0 0 0 0 0
$definebone "Bullet.007" "Bullet.006" -0.000002 0.488363 0 0.094194 0.190222 -31.654495 0 0 0 0 0 0
$definebone "Bullet.008" "Bullet.007" 0.000002 0.470322 0 0.187529 0.040966 -13.177336 0 0 0 0 0 0
$definebone "Bullet.009" "Bullet.008" 0 0.484582 0 -0.31146 0.005157 -0.60131 0 0 0 0 0 0
$definebone "Bullet.010" "Bullet.009" -0.000002 0.46471 0 0.81509 -0.004297 -0.763858 0 0 0 0 0 0
$definebone "Bullet.011" "Bullet.010" 0 0.497667 0 0.167991 0.003036 0.353868 0 0 0 0 0 0
$definebone "Bolt" "Base" -10.90696 0.478617 -2.315958 0 0 0 0 0 0 0 0 0
$definebone "Cover" "Base" -2.474586 -0.057514 1.528718 0 0 0 0 0 0 0 0 0
$definebone "BulletCover" "Cover" 3.390135 1.751309 0.13198 0 0 0 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" -5.101414 -1.461181 -2.970007 78.142364 -177.228082 143.319867 0 0 0 0 0 0

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

$poseparameter "player_movement" 0 160 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "runIdle_a_corrective_animation" "v_stoner63_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_stoner63_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_stoner63_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_stoner63_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_stoner63_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_stoner63_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_a_corrective_animation" "v_stoner63_anims\shoot2_a_corrective_animation.smd" {
}

$animation "shoot2_ironsight_a_corrective_animation" "v_stoner63_anims\shoot2_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3_a_corrective_animation" "v_stoner63_anims\shoot3_a_corrective_animation.smd" {
}

$animation "shoot3_ironsight_a_corrective_animation" "v_stoner63_anims\shoot3_ironsight_a_corrective_animation.smd" {
}

$animation "shoot1_d_a_corrective_animation" "v_stoner63_anims\shoot1_d_a_corrective_animation.smd" {
}

$animation "shoot1_di_a_corrective_animation" "v_stoner63_anims\shoot1_di_a_corrective_animation.smd" {
}

$animation "shoot2_d_a_corrective_animation" "v_stoner63_anims\shoot2_d_a_corrective_animation.smd" {
}

$animation "shoot2_di_a_corrective_animation" "v_stoner63_anims\shoot2_di_a_corrective_animation.smd" {
}

$animation "shoot3_d_a_corrective_animation" "v_stoner63_anims\shoot3_d_a_corrective_animation.smd" {
}

$animation "shoot3_di_a_corrective_animation" "v_stoner63_anims\shoot3_di_a_corrective_animation.smd" {
}

$animation "basePose_a" "v_stoner63_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "ironsight" "v_stoner63_anims\ironsight.smd" {
	fps 0.5
	
	
}

$animation "ironsight_transition" "v_stoner63_anims\ironsight_transition.smd" {
	fps 0.5
	
	
}

$animation "runIdle_a" "v_stoner63_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_stoner63_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_stoner63_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_stoner63_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "shoot1_a" "v_stoner63_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_stoner63_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "shoot2_a" "v_stoner63_anims\shoot2_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_a_corrective_animation" 0
}

$animation "shoot2_ironsight_a" "v_stoner63_anims\shoot2_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_ironsight_a_corrective_animation" 0
}

$animation "shoot3_a" "v_stoner63_anims\shoot3_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_a_corrective_animation" 0
}

$animation "shoot3_ironsight_a" "v_stoner63_anims\shoot3_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_ironsight_a_corrective_animation" 0
}

$animation "nearwall_s_a" "v_stoner63_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_stoner63_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_stoner63_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_stoner63_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_stoner63_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_stoner63_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "prone_deployF" "v_stoner63_anims\prone_deployF.smd" {
	fps 30
	loop
	
	
}

$animation "prone_deployB" "v_stoner63_anims\prone_deployB.smd" {
	fps 30
	
	
}

$animation "prone_deployL" "v_stoner63_anims\prone_deployL.smd" {
	fps 30
	
	
}

$animation "prone_deployR" "v_stoner63_anims\prone_deployR.smd" {
	fps 30
	
	
}

$animation "proneF" "v_stoner63_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_stoner63_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_stoner63_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_stoner63_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_stoner63_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_stoner63_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_stoner63_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_stoner63_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_stoner63_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_stoner63_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "deploy_s_a" "v_stoner63_anims\deploy_s_a.smd" {
	fps 40
	
	
}

$animation "deploy_s_a_i" "v_stoner63_anims\deploy_s_a_i.smd" {
	fps 40
	
	
}

$animation "deploy_a" "v_stoner63_anims\deploy_a.smd" {
	fps 30
	
	
}

$animation "ironsightdeploy" "v_stoner63_anims\ironsightdeploy.smd" {
	fps 0.5
	
	
}

$animation "deploy_e_a" "v_stoner63_anims\deploy_e_a.smd" {
	fps 40
	
	
}

$animation "deploy_e_a_i" "v_stoner63_anims\deploy_e_a_i.smd" {
	fps 40
	
	
}

$animation "shoot1_d_a" "v_stoner63_anims\shoot1_d_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_d_a_corrective_animation" 0
}

$animation "shoot1_di_a" "v_stoner63_anims\shoot1_di_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_di_a_corrective_animation" 0
}

$animation "shoot2_d_a" "v_stoner63_anims\shoot2_d_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_d_a_corrective_animation" 0
}

$animation "shoot2_di_a" "v_stoner63_anims\shoot2_di_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_di_a_corrective_animation" 0
}

$animation "shoot3_d_a" "v_stoner63_anims\shoot3_d_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_d_a_corrective_animation" 0
}

$animation "shoot3_di_a" "v_stoner63_anims\shoot3_di_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_di_a_corrective_animation" 0
}

$sequence "runlayer" {
	"runIdle_a"
	"run_a"
	blend "player_movement" 80 158
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
	blend "player_movement" 0 160
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
	"v_stoner63_anims\draw.smd"
	"v_stoner63_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Stoner63.Draw" }
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 1 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$sequence "Firstdraw" {
	"v_stoner63_anims\Firstdraw.smd"
	"v_stoner63_anims\Firstdraw_2.smd"
	activity "ACT_VM_FIRSTDRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Stoner63.Draw" }
	{ event 5004 9 "MCV_Weapon_Foley_Stoner63_Reload.Metal" }
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 1 "" }
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
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 0 "" }
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
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 0 "" }
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
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 0 "" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "reload" {
	"v_stoner63_anims\reload.smd"
	"v_stoner63_anims\reload_2.smd"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Stoner63_Reload.Hand" }
	{ event 5004 12 "MCV_Weapon_Foley_Stoner63_Reload.CoverStart" }
	{ event 5004 14 "MCV_Weapon_Foley_Stoner63_Reload.BulletsOut" }
	{ event 5004 38 "MCV_Weapon_Foley_Stoner63_Reload.MagOut" }
	{ event AE_CL_BODYGROUP_SET_TO_NEXTCLIP 60 "" }
	{ event 5004 80 "MCV_Weapon_Foley_Stoner63_Reload.MagIn" }
	{ event 5004 117 "MCV_Weapon_Foley_Stoner63_Reload.BulletsIn" }
	{ event 5004 146 "MCV_Weapon_Foley_Stoner63_Reload.CoverEnd" }
	{ event 5004 147 "MCV_Weapon_Foley_Stoner63_Reload.Hand" }
	{ event AE_WPN_COMPLETE_RELOAD 151 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "reload_empty" {
	"v_stoner63_anims\reload_empty.smd"
	"v_stoner63_anims\reload_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Stoner63_Reload.Hand" }
	{ event 5004 12 "MCV_Weapon_Foley_Stoner63_Reload.CoverStart" }
	{ event 5004 38 "MCV_Weapon_Foley_Stoner63_Reload.MagOut" }
	{ event AE_CL_BODYGROUP_SET_TO_NEXTCLIP 60 "" }
	{ event 5004 80 "MCV_Weapon_Foley_Stoner63_Reload.MagIn" }
	{ event 5004 117 "MCV_Weapon_Foley_Stoner63_Reload.BulletsIn" }
	{ event 5004 146 "MCV_Weapon_Foley_Stoner63_Reload.CoverEnd" }
	{ event 5004 158 "MCV_Weapon_Foley_Stoner63_Reload.HandEnd" }
	{ event 5004 170 "MCV_Weapon_Foley_Stoner63_Reload.Metal" }
	{ event 5004 171 "MCV_Weapon_Foley_Stoner63_Reload.Hand" }
	{ event AE_WPN_COMPLETE_RELOAD 184 "" }
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
	"v_stoner63_anims\bash.smd"
	"v_stoner63_anims\bash_2.smd"
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
	activity "ACT_VM_IDLETODEPLOY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M16A1_Reload.Hand" }
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
	"v_stoner63_anims\reload_deploy.smd"
	"v_stoner63_anims\reload_deploy_2.smd"
	activity "ACT_VM_RELOAD_DEPLOYED" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Stoner63_Reload.Hand" }
	{ event 5004 12 "MCV_Weapon_Foley_Stoner63_Reload.CoverStart" }
	{ event 5004 14 "MCV_Weapon_Foley_Stoner63_Reload.BulletsOut" }
	{ event 5004 38 "MCV_Weapon_Foley_Stoner63_Reload.MagOut" }
	{ event AE_CL_BODYGROUP_SET_TO_NEXTCLIP 60 "" }
	{ event 5004 80 "MCV_Weapon_Foley_Stoner63_Reload.MagIn" }
	{ event 5004 117 "MCV_Weapon_Foley_Stoner63_Reload.BulletsIn" }
	{ event 5004 146 "MCV_Weapon_Foley_Stoner63_Reload.CoverEnd" }
	{ event 5004 158 "MCV_Weapon_Foley_Stoner63_Reload.HandEnd" }
	{ event 5004 170 "MCV_Weapon_Foley_Stoner63_Reload.Metal" }
	{ event 5004 171 "MCV_Weapon_Foley_Stoner63_Reload.Hand" }
	{ event AE_WPN_COMPLETE_RELOAD 184 "" }
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
	
	
}

$sequence "reload_deploy_empty" {
	"v_stoner63_anims\reload_deploy_empty.smd"
	"v_stoner63_anims\reload_deploy_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY_DEPLOYED" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Stoner63_Reload.Hand" }
	{ event 5004 12 "MCV_Weapon_Foley_Stoner63_Reload.CoverStart" }
	{ event 5004 38 "MCV_Weapon_Foley_Stoner63_Reload.MagOut" }
	{ event AE_CL_BODYGROUP_SET_TO_NEXTCLIP 60 "" }
	{ event 5004 80 "MCV_Weapon_Foley_Stoner63_Reload.MagIn" }
	{ event 5004 117 "MCV_Weapon_Foley_Stoner63_Reload.BulletsIn" }
	{ event 5004 146 "MCV_Weapon_Foley_Stoner63_Reload.CoverEnd" }
	{ event 5004 158 "MCV_Weapon_Foley_Stoner63_Reload.HandEnd" }
	{ event 5004 170 "MCV_Weapon_Foley_Stoner63_Reload.Metal" }
	{ event 5004 171 "MCV_Weapon_Foley_Stoner63_Reload.Hand" }
	{ event AE_WPN_COMPLETE_RELOAD 184 "" }
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
	fadein 0.2
	fadeout 0.2
	node "0"
}

$sequence "deployshoot1" {
	"shoot1_d_a"
	"shoot1_di_a"
	activity "ACT_VM_DEPLOYSHOOT" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	{ event AE_MUZZLEFLASH 0 "" }
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 0 "" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "deployshoot2" {
	"shoot2_d_a"
	"shoot2_di_a"
	activity "ACT_VM_DEPLOYSHOOT" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	{ event AE_MUZZLEFLASH 0 "" }
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 0 "" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "deployshoot3" {
	"shoot3_d_a"
	"shoot3_di_a"
	activity "ACT_VM_DEPLOYSHOOT" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	{ event AE_MUZZLEFLASH 0 "" }
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 0 "" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "holster" {
	"v_stoner63_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 0 "MCV_Weapon_Foley_Stoner63.Holster" }
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
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\lmg_stoner63\Stoner_new.qc"
//	}
}

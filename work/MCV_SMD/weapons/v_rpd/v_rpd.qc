// Created by Crowbar 0.74

$modelname "weapons/mcv/v_rpd.mdl"

$bodygroup "studio"
{
	studio "RPDRef_new.smd"
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
$bodygroup "bullet12"
{
	studio "Bulletnew.011.smd"
	blank
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 6.644 -21.124 -12.114

$cdmaterials "models\weapons\mcv\v_rpd\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "Base" -29.8 0 2 rotate 0 180 0
$attachment "eject" "Base" -0.5 1 3 rotate 0 90 0

$cbox 0 0 0 0 0 0

$bbox -10.182 -15.458 -28.409 52.429 28.746 4.181

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
$definebone "Base" "" -4.489726 -24.454287 -6.925748 0 89.999989 0 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" 18.834118 -4.713187 1.639447 0 0 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 18.659918 6.654958 1.40279 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" 5.751492 0.003524 0.08463 0 0 0 0 0 0 0 0 0
$definebone "Mag" "Base" -1.141232 -1.151006 -4.964828 0 0 0 0 0 0 0 0 0
$definebone "MagCover" "Mag" 0 -3.087374 1.878552 0 0 0 0 0 0 0 0 0
$definebone "Trigger.001" "Base" 3.310593 1.547794 1.667976 0 0 0 0 0 0 0 0 0
$definebone "Cover" "Base" -3.148222 -0.057513 3.294791 0 0 0 0 0 0 0 0 0
$definebone "Bipod1" "Base" -27.648403 -0.364478 -0.040445 0 0 0 0 0 0 0 0 0
$definebone "Bipod2" "Base" -27.648403 0.323435 -0.040445 0 0 0 0 0 0 0 0 0
$definebone "Magholder" "Base" 0.838842 -0.935707 -0.985338 0 0 0 0 0 0 0 0 0
$definebone "Bullet" "Mag" 0.000006 -1.159416 1.992567 0 0 90.483266 0 0 0 0 0 0
$definebone "Bullet.001" "Bullet" 0.000002 0.689173 -0.000001 0.131952 -0.000172 -0.07712 0 0 0 0 0 0
$definebone "Bullet.002" "Bullet.001" 0 0.721596 0 -0.30086 0.003209 -1.092459 0 0 0 0 0 0
$definebone "Bullet.003" "Bullet.002" 0.000004 0.700417 0 0.289 -0.008766 -4.180702 0 0 0 0 0 0
$definebone "Bullet.004" "Bullet.003" 0.000002 0.704014 0 -0.074313 0.001031 1.283539 0 0 0 0 0 0
$definebone "Bullet.005" "Bullet.004" 0 0.723357 0 -0.177101 -0.009053 3.961257 0 0 0 0 0 0
$definebone "Bullet.006" "Bullet.005" 0 0.707716 0 -0.271296 -0.009397 1.335163 0 0 0 0 0 0
$definebone "Bullet.007" "Bullet.006" 0.000002 0.734225 0 0.050936 0.087319 -13.93743 0 0 0 0 0 0
$definebone "Bullet.008" "Bullet.007" 0 0.697392 0.000001 0.289114 0.16398 -65.911175 0 0 0 0 0 0
$definebone "Bullet.009" "Bullet.008" -0.000002 0.700337 0 -0.302465 0.093621 -10.990816 0 0 0 0 0 0
$definebone "Bullet.010" "Bullet.009" -0.000002 0.703105 0 0.813887 -0.028419 -5.02919 0 0 0 0 0 0
$definebone "Bullet.011" "Bullet.010" -0.000008 0.711529 0 0.167419 -0.02395 -2.789614 0 0 0 0 0 0

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
$bonemerge "lhand_ikTarget"
$bonemerge "rhand_ikTarget"


$sectionframes 30 30

$poseparameter "player_movement" 0 220 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "runIdle_a_corrective_animation" "v_rpd_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_rpd_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_rpd_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_rpd_anims\walk_a_corrective_animation.smd" {
}

$animation "walk_a_r_corrective_animation" "v_rpd_anims\walk_a_r_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_rpd_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_rpd_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_a_corrective_animation" "v_rpd_anims\shoot2_a_corrective_animation.smd" {
}

$animation "shoot2_ironsight_a_corrective_animation" "v_rpd_anims\shoot2_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3_a_corrective_animation" "v_rpd_anims\shoot3_a_corrective_animation.smd" {
}

$animation "shoot3_ironsight_a_corrective_animation" "v_rpd_anims\shoot3_ironsight_a_corrective_animation.smd" {
}

$animation "shoot1_d_a_corrective_animation" "v_rpd_anims\shoot1_d_a_corrective_animation.smd" {
}

$animation "shoot1_di_a_corrective_animation" "v_rpd_anims\shoot1_di_a_corrective_animation.smd" {
}

$animation "shoot2_d_a_corrective_animation" "v_rpd_anims\shoot2_d_a_corrective_animation.smd" {
}

$animation "shoot2_di_a_corrective_animation" "v_rpd_anims\shoot2_di_a_corrective_animation.smd" {
}

$animation "shoot3_d_a_corrective_animation" "v_rpd_anims\shoot3_d_a_corrective_animation.smd" {
}

$animation "shoot3_di_a_corrective_animation" "v_rpd_anims\shoot3_di_a_corrective_animation.smd" {
}

$animation "basePose_a" "v_rpd_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "ironsight" "v_rpd_anims\ironsight.smd" {
	fps 0.5
	
	
}

$animation "ironsight_transition" "v_rpd_anims\ironsight_transition.smd" {
	fps 0.5
	
	
}

$animation "walkPoses" "v_rpd_anims\walkPoses.smd" {
	fps 30
	
	
}

$animation "runIdle_a" "v_rpd_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_rpd_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_rpd_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_rpd_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "walk_a_r" "v_rpd_anims\walk_a_r.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_r_corrective_animation" 0
	
	
}

$animation "shoot1_a" "v_rpd_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_rpd_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "shoot2_a" "v_rpd_anims\shoot2_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_a_corrective_animation" 0
}

$animation "shoot2_ironsight_a" "v_rpd_anims\shoot2_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_ironsight_a_corrective_animation" 0
}

$animation "shoot3_a" "v_rpd_anims\shoot3_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_a_corrective_animation" 0
}

$animation "shoot3_ironsight_a" "v_rpd_anims\shoot3_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_ironsight_a_corrective_animation" 0
}

$animation "nearwall_s_a" "v_rpd_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_rpd_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_rpd_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_rpd_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_rpd_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_rpd_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "prone_deployF" "v_rpd_anims\prone_deployF.smd" {
	fps 30
	loop
	
	
}

$animation "prone_deployB" "v_rpd_anims\prone_deployB.smd" {
	fps 30
	
	
}

$animation "prone_deployL" "v_rpd_anims\prone_deployL.smd" {
	fps 30
	
	
}

$animation "prone_deployR" "v_rpd_anims\prone_deployR.smd" {
	fps 30
	
	
}

$animation "proneF" "v_rpd_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_rpd_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_rpd_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_rpd_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_rpd_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_rpd_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_rpd_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_rpd_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_rpd_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_rpd_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "deploy_s_a" "v_rpd_anims\deploy_s_a.smd" {
	fps 40
	
	
}

$animation "deploy_s_a_i" "v_rpd_anims\deploy_s_a_i.smd" {
	fps 40
	
	
}

$animation "deploy_a" "v_rpd_anims\deploy_a.smd" {
	fps 30
	
	
}

$animation "ironsightdeploy" "v_rpd_anims\ironsightdeploy.smd" {
	fps 0.5
	
	
}

$animation "deploy_e_a" "v_rpd_anims\deploy_e_a.smd" {
	fps 40
	
	
}

$animation "deploy_e_a_i" "v_rpd_anims\deploy_e_a_i.smd" {
	fps 40
	
	
}

$animation "shoot1_d_a" "v_rpd_anims\shoot1_d_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_d_a_corrective_animation" 0
}

$animation "shoot1_di_a" "v_rpd_anims\shoot1_di_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_di_a_corrective_animation" 0
}

$animation "shoot2_d_a" "v_rpd_anims\shoot2_d_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_d_a_corrective_animation" 0
}

$animation "shoot2_di_a" "v_rpd_anims\shoot2_di_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_di_a_corrective_animation" 0
}

$animation "shoot3_d_a" "v_rpd_anims\shoot3_d_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_d_a_corrective_animation" 0
}

$animation "shoot3_di_a" "v_rpd_anims\shoot3_di_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_di_a_corrective_animation" 0
}

$sequence "runlayer" {
	"runIdle_a"
	"run_a"
	blend "player_movement" 110 200
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
	blend "player_movement" 0 220
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

$sequence "walklayerreload" {
	"walkIdle_a"
	"walk_a_r"
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
	"v_rpd_anims\draw.smd"
	"v_rpd_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_RPD.Draw" }
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 1 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$sequence "Firstdraw" {
	"v_rpd_anims\Firstdraw.smd"
	"v_rpd_anims\Firstdraw_2.smd"
	activity "ACT_VM_FIRSTDRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_RPD.Draw" }
	{ event 5004 8 "MCV_Weapon_Foley_RPD_Reload.MetalStart" }
	{ event 5004 14 "MCV_Weapon_Foley_RPD_Reload.MetalEnd" }
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
	"v_rpd_anims\reload.smd"
	"v_rpd_anims\reload_2.smd"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_RPD_Reload.Hand" }
	{ event 5004 16 "MCV_Weapon_Foley_RPD_Reload.CoverStart" }
	{ event 5004 18 "MCV_Weapon_Foley_RPD_Reload.BulletsOut" }
	{ event 5004 35 "MCV_Weapon_Foley_RPD_Reload.MetalDing_Out" }
	{ event 5004 43 "MCV_Weapon_Foley_RPD_Reload.MagOut" }
	{ event AE_CL_BODYGROUP_SET_TO_NEXTCLIP 48 "" }
	{ event 5004 75 "MCV_Weapon_Foley_RPD_Reload.MagIn" }
	{ event 5004 85 "MCV_Weapon_Foley_RPD_Reload.MetalDing_In" }
	{ event 5004 105 "MCV_Weapon_Foley_RPD_Reload.BulletsIn" }
	{ event 5004 137 "MCV_Weapon_Foley_RPD_Reload.CoverEnd" }
	{ event 5004 150 "MCV_Weapon_Foley_RPD_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 126 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerreload"
	node "0"
	fps 30
	
	
}

$sequence "reload_empty" {
	"v_rpd_anims\reload_empty.smd"
	"v_rpd_anims\reload_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_RPD_Reload.Hand" }
	{ event 5004 8 "MCV_Weapon_Foley_RPD_Reload.MetalStart" }
	{ event 5004 15 "MCV_Weapon_Foley_RPD_Reload.MetalEnd" }
	{ event 5004 37 "MCV_Weapon_Foley_RPD_Reload.CoverStart" }
	{ event 5004 57 "MCV_Weapon_Foley_RPD_Reload.MetalDing_Out" }
	{ event 5004 63 "MCV_Weapon_Foley_RPD_Reload.MagOut" }
	{ event AE_CL_BODYGROUP_SET_TO_NEXTCLIP 67 "" }
	{ event 5004 95 "MCV_Weapon_Foley_RPD_Reload.MagIn" }
	{ event 5004 107 "MCV_Weapon_Foley_RPD_Reload.MetalDing_In" }
	{ event 5004 127 "MCV_Weapon_Foley_RPD_Reload.BulletsIn" }
	{ event 5004 158 "MCV_Weapon_Foley_RPD_Reload.CoverEnd" }
	{ event 5004 170 "MCV_Weapon_Foley_RPD_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 148 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerreload"
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
	"v_rpd_anims\bash.smd"
	"v_rpd_anims\bash_2.smd"
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
	{ event 5004 1 "MCV_Weapon_Foley_RPD_Reload.Hand" }
	{ event 5004 13 "MCV_Weapon_Foley_BAR_Unpack.MetalOut" }
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
	"v_rpd_anims\reload_deploy.smd"
	"v_rpd_anims\reload_deploy_2.smd"
	activity "ACT_VM_RELOAD_DEPLOYED" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_RPD_Reload.Hand" }
	{ event 5004 16 "MCV_Weapon_Foley_RPD_Reload.CoverStart" }
	{ event 5004 18 "MCV_Weapon_Foley_RPD_Reload.BulletsOut" }
	{ event 5004 35 "MCV_Weapon_Foley_RPD_Reload.MetalDing_Out" }
	{ event 5004 43 "MCV_Weapon_Foley_RPD_Reload.MagOut" }
	{ event AE_CL_BODYGROUP_SET_TO_NEXTCLIP 48 "" }
	{ event 5004 75 "MCV_Weapon_Foley_RPD_Reload.MagIn" }
	{ event 5004 85 "MCV_Weapon_Foley_RPD_Reload.MetalDing_In" }
	{ event 5004 105 "MCV_Weapon_Foley_RPD_Reload.BulletsIn" }
	{ event 5004 137 "MCV_Weapon_Foley_RPD_Reload.CoverEnd" }
	{ event 5004 150 "MCV_Weapon_Foley_RPD_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 126 "" }
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
	
	
}

$sequence "reload_deploy_empty" {
	"v_rpd_anims\reload_deploy_empty.smd"
	"v_rpd_anims\reload_deploy_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY_DEPLOYED" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_RPD_Reload.Hand" }
	{ event 5004 8 "MCV_Weapon_Foley_RPD_Reload.MetalStart" }
	{ event 5004 15 "MCV_Weapon_Foley_RPD_Reload.MetalEnd" }
	{ event 5004 37 "MCV_Weapon_Foley_RPD_Reload.CoverStart" }
	{ event 5004 57 "MCV_Weapon_Foley_RPD_Reload.MetalDing_Out" }
	{ event 5004 63 "MCV_Weapon_Foley_RPD_Reload.MagOut" }
	{ event AE_CL_BODYGROUP_SET_TO_NEXTCLIP 67 "" }
	{ event 5004 95 "MCV_Weapon_Foley_RPD_Reload.MagIn" }
	{ event 5004 107 "MCV_Weapon_Foley_RPD_Reload.MetalDing_In" }
	{ event 5004 127 "MCV_Weapon_Foley_RPD_Reload.BulletsIn" }
	{ event 5004 158 "MCV_Weapon_Foley_RPD_Reload.CoverEnd" }
	{ event 5004 170 "MCV_Weapon_Foley_RPD_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 148 "" }
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
	"v_rpd_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 0 "MCV_Weapon_Foley_RPD.Holster" }
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
//		"value" "models\guns\lmg_rpd\rpd_new.qc"
//	}
}

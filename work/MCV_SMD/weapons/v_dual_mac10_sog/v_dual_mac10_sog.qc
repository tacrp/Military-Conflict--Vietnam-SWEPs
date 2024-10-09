// Created by Crowbar 0.74

$modelname "weapons/mcv/v_dual_mac10_sog.mdl"

$bodygroup "studio"
{
	studio "DualMac10_sog.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition -0.362 -10.61 -8.5

$cdmaterials "models\weapons\mcv\v_mac10\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "BaseMesh" -16.3 0 1.5 rotate 0 180 0
$attachment "eject" "BaseMesh" -0.5 0.4 1.85 rotate -10 90 0
$attachment "muzzle2" "BaseLeftMesh" -16.3 0 1.5 rotate 0 180 0
$attachment "eject2" "BaseLeftMesh" -0.5 0.4 1.85 rotate -10 90 0

$cbox 0 0 0 0 0 0

$bbox -15.217 -26.739 -27.51 36.436 26.016 10.51

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
$definebone "BaseMesh" "hand_r" 19.31752 11.87331 25.163818 75.00019 90.005842 0.004521 0 0 0 0 0 0
$definebone "Mag" "BaseMesh" -0.053419 -0.018743 0.740857 0.000119 -0.000114 -0.000059 0 0 0 0 0 0
$definebone "Bullet" "Mag" 0.052629 0 -0.395272 0.000004 0.000001 -0.000002 0 0 0 0 0 0
$definebone "Trigger" "BaseMesh" -1.916581 -0.009685 0.206911 0.000119 -0.000114 -0.000002 0 0 0 0 0 0
$definebone "Bolt" "BaseMesh" -3.145596 -0.00968 2.700375 0.000119 -0.000114 -0.000059 0 0 0 0 0 0
$definebone "rhand_ikTarget" "BaseMesh" 9.315657 8.158643 -1.874594 0.000119 -0.000056 -0.000002 0 0 0 0 0 0
$definebone "LHand_IKtarget" "BaseMesh" 7.897327 -5.924537 -1.63793 0.000119 -0.000114 -0.000002 0 0 0 0 0 0
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
$definebone "BaseLeftMesh" "hand_l" -20.289322 -11.872781 -25.164263 -75.000046 -90.000631 -179.999363 0 0 0 0 0 0
$definebone "MagLeft" "BaseLeftMesh" -0.05342 -0.018744 0.740858 0.000005 -0.000002 0.000007 0 0 0 0 0 0
$definebone "BulletLeft" "MagLeft" 0.052629 0 -0.205458 0.000005 -0.000002 0.000007 0 0 0 0 0 0
$definebone "TriggerLeft" "BaseLeftMesh" -1.91658 -0.009688 0.206911 0.000005 -0.000002 0.000007 0 0 0 0 0 0
$definebone "BoltLeft" "BaseLeftMesh" -3.145601 -0.009687 2.700382 0.000005 -0.000002 0.000007 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511806 -0.000002 0.000003 0.000292 0.000412 -13.510177 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.196849 0.000003 -0.000001 0.000862 -0.000112 -19.951824 0 0 0 0 0 0
$definebone "cam_driver" "" 0 0 0 0 -89.999982 0 0 0 0 0 0 0

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
$bonemerge "BaseMesh"
$bonemerge "rhand_ikTarget"
$bonemerge "LHand_IKtarget"
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


$sectionframes 30 30

$poseparameter "ammo_fraction" 0 0.03333 loop 0
$poseparameter "player_movement" 0 260 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$weightlist "weights_runlayer" {
	 "root" 1
	 "pelvis" 1
	 "spine_01" 1
	 "spine_02" 1
	 "spine_03" 1
	 "clavicle_r" 1
	 "upperarm_r" 1
	 "lowerarm_r" 1
	 "hand_r" 1
	 "index_01_r" 1
	 "index_02_r" 1
	 "index_03_r" 1
	 "middle_01_r" 1
	 "middle_02_r" 1
	 "middle_03_r" 1
	 "pinky_01_r" 1
	 "pinky_02_r" 1
	 "pinky_03_r" 1
	 "ring_01_r" 1
	 "ring_02_r" 1
	 "ring_03_r" 1
	 "thumb_01_r" 1
	 "thumb_02_r" 1
	 "thumb_03_r" 1
	 "BaseMesh" 0
	 "Mag" 0
	 "Bullet" 0
	 "Trigger" 0
	 "Bolt" 0
	 "rhand_ikTarget" 0
	 "LHand_IKtarget" 0
	 "lowerarm_twist_01_r" 1
	 "upperarm_twist_01_r" 1
	 "clavicle_l" 1
	 "upperarm_l" 1
	 "lowerarm_l" 1
	 "hand_l" 1
	 "index_01_l" 1
	 "index_02_l" 1
	 "index_03_l" 1
	 "middle_01_l" 1
	 "middle_02_l" 1
	 "middle_03_l" 1
	 "pinky_01_l" 1
	 "pinky_02_l" 1
	 "pinky_03_l" 1
	 "ring_01_l" 1
	 "ring_02_l" 1
	 "ring_03_l" 1
	 "thumb_01_l" 1
	 "thumb_02_l" 1
	 "thumb_03_l" 1
	 "BaseLeftMesh" 0
	 "MagLeft" 0
	 "BulletLeft" 0
	 "TriggerLeft" 0
	 "BoltLeft" 0
	 "lowerarm_twist_01_l" 1
	 "upperarm_twist_01_l" 1
	 "cam_driver" 1
}

$animation "BothEmpty_corrective_animation" "v_dual_mac10_sog_anims\BothEmpty_corrective_animation.smd" {
}

$animation "RightEmpty_corrective_animation" "v_dual_mac10_sog_anims\RightEmpty_corrective_animation.smd" {
}

$animation "Default_corrective_animation" "v_dual_mac10_sog_anims\Default_corrective_animation.smd" {
}

$animation "runIdle_a_corrective_animation" "v_dual_mac10_sog_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_dual_mac10_sog_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_dual_mac10_sog_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_dual_mac10_sog_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_r_a_corrective_animation" "v_dual_mac10_sog_anims\shoot1_r_a_corrective_animation.smd" {
}

$animation "shoot1_r_ironsight_a_corrective_animation" "v_dual_mac10_sog_anims\shoot1_r_ironsight_a_corrective_animation.smd" {
}

$animation "shoot1_l_a_corrective_animation" "v_dual_mac10_sog_anims\shoot1_l_a_corrective_animation.smd" {
}

$animation "shoot1_l_ironsight_a_corrective_animation" "v_dual_mac10_sog_anims\shoot1_l_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_r_a_corrective_animation" "v_dual_mac10_sog_anims\shoot2_r_a_corrective_animation.smd" {
}

$animation "shoot2_r_ironsight_a_corrective_animation" "v_dual_mac10_sog_anims\shoot2_r_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_l_a_corrective_animation" "v_dual_mac10_sog_anims\shoot2_l_a_corrective_animation.smd" {
}

$animation "shoot2_l_ironsight_a_corrective_animation" "v_dual_mac10_sog_anims\shoot2_l_ironsight_a_corrective_animation.smd" {
}

$animation "shootlast_r_a_corrective_animation" "v_dual_mac10_sog_anims\shootlast_r_a_corrective_animation.smd" {
}

$animation "shootlast_r_ironsight_a_corrective_animation" "v_dual_mac10_sog_anims\shootlast_r_ironsight_a_corrective_animation.smd" {
}

$animation "shootlast_l_a_corrective_animation" "v_dual_mac10_sog_anims\shootlast_l_a_corrective_animation.smd" {
}

$animation "shootlast_l_ironsight_a_corrective_animation" "v_dual_mac10_sog_anims\shootlast_l_ironsight_a_corrective_animation.smd" {
}

$animation "PoseDelta" "v_dual_mac10_sog_anims\PoseDelta.smd" {
	fps 30
	
	
}

$animation "Default" "v_dual_mac10_sog_anims\Default.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Default_corrective_animation" 0
}

$animation "RightEmpty" "v_dual_mac10_sog_anims\RightEmpty.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "RightEmpty_corrective_animation" 0
}

$animation "BothEmpty" "v_dual_mac10_sog_anims\BothEmpty.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "BothEmpty_corrective_animation" 0
}

$animation "basePose_a" "v_dual_mac10_sog_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "ironsight" "v_dual_mac10_sog_anims\ironsight.smd" {
	fps 0.5
	
	
}

$animation "ironsight_transition" "v_dual_mac10_sog_anims\ironsight_transition.smd" {
	fps 0.5
	
	
}

$animation "runIdle_a" "v_dual_mac10_sog_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	weightlist "weights_runlayer"
}

$animation "run_a" "v_dual_mac10_sog_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	weightlist "weights_runlayer"
}

$animation "walkIdle_a" "v_dual_mac10_sog_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	weightlist "weights_runlayer"
}

$animation "walk_a" "v_dual_mac10_sog_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	weightlist "weights_runlayer"
}

$animation "FirstDraw_a" "v_dual_mac10_sog_anims\FirstDraw_a.smd" {
	fps 30
	
	
}

$animation "FirstDraw_a_i" "v_dual_mac10_sog_anims\FirstDraw_a_i.smd" {
	fps 30
	
	
}

$animation "shoot1_r_a" "v_dual_mac10_sog_anims\shoot1_r_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_r_a_corrective_animation" 0
}

$animation "shoot1_r_ironsight_a" "v_dual_mac10_sog_anims\shoot1_r_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_r_ironsight_a_corrective_animation" 0
}

$animation "shoot1_l_a" "v_dual_mac10_sog_anims\shoot1_l_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_l_a_corrective_animation" 0
}

$animation "shoot1_l_ironsight_a" "v_dual_mac10_sog_anims\shoot1_l_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_l_ironsight_a_corrective_animation" 0
}

$animation "shoot2_r_a" "v_dual_mac10_sog_anims\shoot2_r_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_r_a_corrective_animation" 0
}

$animation "shoot2_r_ironsight_a" "v_dual_mac10_sog_anims\shoot2_r_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_r_ironsight_a_corrective_animation" 0
}

$animation "shoot2_l_a" "v_dual_mac10_sog_anims\shoot2_l_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_l_a_corrective_animation" 0
}

$animation "shoot2_l_ironsight_a" "v_dual_mac10_sog_anims\shoot2_l_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_l_ironsight_a_corrective_animation" 0
}

$animation "shootlast_r_a" "v_dual_mac10_sog_anims\shootlast_r_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_r_a_corrective_animation" 0
}

$animation "shootlast_r_ironsight_a" "v_dual_mac10_sog_anims\shootlast_r_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_r_ironsight_a_corrective_animation" 0
}

$animation "shootlast_l_a" "v_dual_mac10_sog_anims\shootlast_l_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_l_a_corrective_animation" 0
}

$animation "shootlast_l_ironsight_a" "v_dual_mac10_sog_anims\shootlast_l_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_l_ironsight_a_corrective_animation" 0
}

$animation "reload_a" "v_dual_mac10_sog_anims\reload_a.smd" {
	fps 30
	
	
}

$animation "reload_a_i" "v_dual_mac10_sog_anims\reload_a_i.smd" {
	fps 30
	
	
}

$animation "reload_ra" "v_dual_mac10_sog_anims\reload_ra.smd" {
	fps 30
	
	
}

$animation "reload_ra_i" "v_dual_mac10_sog_anims\reload_ra_i.smd" {
	fps 30
	
	
}

$animation "reload_er_a" "v_dual_mac10_sog_anims\reload_er_a.smd" {
	fps 30
	
	
	
	
}

$animation "reload_er_a_i" "v_dual_mac10_sog_anims\reload_er_a_i.smd" {
	fps 30
	
	
	
	
}

$animation "reload_e_a" "v_dual_mac10_sog_anims\reload_e_a.smd" {
	fps 30
	
	
}

$animation "reload_e_a_i" "v_dual_mac10_sog_anims\reload_e_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a" "v_dual_mac10_sog_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_dual_mac10_sog_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_dual_mac10_sog_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_dual_mac10_sog_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_dual_mac10_sog_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_dual_mac10_sog_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "proneF" "v_dual_mac10_sog_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_dual_mac10_sog_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_dual_mac10_sog_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_dual_mac10_sog_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_dual_mac10_sog_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_dual_mac10_sog_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_dual_mac10_sog_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_dual_mac10_sog_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_dual_mac10_sog_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_dual_mac10_sog_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$sequence "SlidePosition" {
	"BothEmpty"
	"RightEmpty"
	"RightEmpty"
	"Default"
	blend "ammo_fraction" 0 0.03333
	blendwidth 4
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
	addlayer "SlidePosition"
	node "0"
}

$sequence "draw" {
	"v_dual_mac10_sog_anims\draw.smd"
	"v_dual_mac10_sog_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_MAC10.Draw" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
	fps 30
	  
	
}

$sequence "Firstdraw" {
	"FirstDraw_a"
	"FirstDraw_a_i"
	activity "ACT_VM_FIRSTDRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_MAC10.Draw" }
	{ event 5004 11 "MCV_Weapon_Foley_MAC10.DrawMetal_Dual" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
}

$sequence "shoot1_r" {
	"shoot1_r_a"
	"shoot1_r_ironsight_a"
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

$sequence "shoot1_l" {
	"shoot1_l_a"
	"shoot1_l_ironsight_a"
	activity "ACT_VM_SECONDARYATTACK" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_CLIENT_EJECT_BRASS 0 "eject2" }
	{ event AE_MUZZLEFLASH 0 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "shoot2_r" {
	"shoot2_r_a"
	"shoot2_r_ironsight_a"
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

$sequence "shoot2_l" {
	"shoot2_l_a"
	"shoot2_l_ironsight_a"
	activity "ACT_VM_SECONDARYATTACK" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_CLIENT_EJECT_BRASS 0 "eject2" }
	{ event AE_MUZZLEFLASH 0 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "shootlast_r" {
	"shootlast_r_a"
	"shootlast_r_ironsight_a"
	activity "ACT_VM_PRIMARYSHOOTLAST" 1
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

$sequence "shootlast_l" {
	"shootlast_l_a"
	"shootlast_l_ironsight_a"
	activity "ACT_VM_SECONDARYSHOOTLAST" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_CLIENT_EJECT_BRASS 0 "eject2" }
	{ event AE_MUZZLEFLASH 0 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "reload" {
	"reload_a"
	"reload_a_i"
	activity "ACT_VM_SECONDARY_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_MAC10_Reload.Hand" }
	{ event 5004 12 "MCV_Weapon_Foley_MAC10_Reload.MagOut" }
	{ event 5004 42 "MCV_Weapon_Foley_MAC10_Reload.MagIn" }
	{ event 5004 52 "MCV_Weapon_Foley_MAC10_Reload.Hand" }
	{ event 5004 80 "MCV_Weapon_Foley_MAC10_Reload.MagOut" }
	{ event 5004 112 "MCV_Weapon_Foley_MAC10_Reload.MagIn" }
	{ event 5004 120 "MCV_Weapon_Foley_MAC10_Reload.HandEnd" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 76 "ammo_fraction" }
	{ event AE_WPN_COMPLETE_RELOAD 76 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	node "0"
}

$sequence "reloadRightOnly" {
	"reload_ra"
	"reload_ra_i"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_MAC10_Reload.Hand" }
	{ event 5004 12 "MCV_Weapon_Foley_MAC10_Reload.MagOut" }
	{ event 5004 42 "MCV_Weapon_Foley_MAC10_Reload.MagIn" }
	{ event 5004 52 "MCV_Weapon_Foley_MAC10_Reload.HandEnd" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 46 "ammo_fraction" }
	{ event AE_WPN_COMPLETE_RELOAD 46 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	node "0"
}

$sequence "reload_emptyRightOnly" {
	"reload_er_a"
	"reload_er_a_i"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_MAC10_Reload.Hand" }
	{ event 5004 12 "MCV_Weapon_Foley_MAC10_Reload.MagOut" }
	{ event 5004 42 "MCV_Weapon_Foley_MAC10_Reload.MagIn" }
	{ event 5004 68 "MCV_Weapon_Foley_MAC10.DrawMetal_Dual" }
	{ event 5004 72 "MCV_Weapon_Foley_MAC10_Reload.Hand" }
	{ event 5004 100 "MCV_Weapon_Foley_MAC10_Reload.MagOut" }
	{ event 5004 132 "MCV_Weapon_Foley_MAC10_Reload.MagIn" }
	{ event 5004 140 "MCV_Weapon_Foley_MAC10_Reload.HandEnd" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 91 "ammo_fraction" }
	{ event AE_WPN_COMPLETE_RELOAD 91 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	node "0"
}

$sequence "reload_empty" {
	"reload_e_a"
	"reload_e_a_i"
	activity "ACT_VM_SECONDARY_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_MAC10_Reload.Hand" }
	{ event 5004 12 "MCV_Weapon_Foley_MAC10_Reload.MagOut" }
	{ event 5004 42 "MCV_Weapon_Foley_MAC10_Reload.MagIn" }
	{ event 5004 68 "MCV_Weapon_Foley_MAC10.DrawMetal_Dual" }
	{ event 5004 72 "MCV_Weapon_Foley_MAC10_Reload.Hand" }
	{ event 5004 100 "MCV_Weapon_Foley_MAC10_Reload.MagOut" }
	{ event 5004 132 "MCV_Weapon_Foley_MAC10_Reload.MagIn" }
	{ event 5004 158 "MCV_Weapon_Foley_MAC10.DrawMetal_Dual" }
	{ event 5004 162 "MCV_Weapon_Foley_MAC10_Reload.HandEnd" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 93 "ammo_fraction" }
	{ event AE_WPN_COMPLETE_RELOAD 93 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	node "0"
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
	addlayer "SlidePosition"
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
	realtime
}

$sequence "bash" {
	"v_dual_mac10_sog_anims\bash.smd"
	"v_dual_mac10_sog_anims\bash_2.smd"
	activity "ACT_VM_HITCENTER" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 3200 3 "" }
	{ event 5004 1 "MCV_Weapon_Foley_Bash.Fast" }
	fadein 0
	fadeout 0.2
	addlayer "SlidePosition"
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
	addlayer "SlidePosition"
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
	addlayer "SlidePosition"
	addlayer "walklayer"
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
	addlayer "SlidePosition"
	addlayer "walklayer"
}

$sequence "holster" {
	"v_dual_mac10_sog_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 1 "MCV_Weapon_Foley_MAC10.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\dualsmg_mac10\dualmac10_sog.qc"
//	}
}

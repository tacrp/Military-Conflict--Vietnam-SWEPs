// Created by Crowbar 0.74

$modelname "weapons/mcv/v_dual_swm10.mdl"

$bodygroup "studio"
{
	studio "DualSWM10.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 0.205 -9.676 -1.775

$cdmaterials "models\weapons\mcv\v_swm10\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "BaseMesh" -8.35 0 1.4 rotate 0 180 0
$attachment "muzzle2" "BaseLeftMesh" -8.35 0 1.4 rotate 0 180 0

$cbox 0 0 0 0 0 0

$bbox -9.645 -17.249 -27.51 28.996 17.659 23.96

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
$definebone "BaseMesh" "hand_r" 17.970957 10.897517 27.354527 75.00019 90.005487 0.004235 0 0 0 0 0 0
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
$definebone "BaseLeftMesh" "hand_l" -16.635946 -10.897026 -27.354927 -75.000006 -89.999975 180.000005 0 0 0 0 0 0
$definebone "HammerLeft" "BaseLeftMesh" 1.172844 0.00387 0.361635 0.000001 0.00017 0.000007 0 0 0 0 0 0
$definebone "CyHolderLeft" "BaseLeftMesh" -2.909409 -0.116096 -0.378865 0.000001 0.00017 0.000007 0 0 0 0 0 0
$definebone "CyLeft" "CyHolderLeft" 1.368912 0.119954 1.216498 0.000001 -0.000002 0.000007 0 0 0 0 0 0
$definebone "BulletPosLeft" "CyLeft" 1.166945 0 0 0.000001 -0.000002 0.000007 0 0 0 0 0 0
$definebone "BulletLeft.001" "BulletPosLeft" -0.699532 0.501534 0.289545 0.000001 -0.000002 0.000007 0 0 0 0 0 0
$definebone "BulletHeadLeft.001" "BulletLeft.001" -0.628338 0 0 0.000001 -0.000002 0.000007 0 0 0 0 0 0
$definebone "BulletLeft.002" "BulletPosLeft" -0.699532 0.001723 0.577367 0.000001 -0.000002 0.000007 0 0 0 0 0 0
$definebone "BulletHeadLeft.002" "BulletLeft.002" -0.628338 0 0 0.000001 -0.000002 0.000007 0 0 0 0 0 0
$definebone "BulletLeft.003" "BulletPosLeft" -0.69953 -0.498777 0.287822 0.000001 -0.000002 0.000007 0 0 0 0 0 0
$definebone "BulletHeadLeft.003" "BulletLeft.003" -0.628338 0 0 0.000001 -0.000002 0.000007 0 0 0 0 0 0
$definebone "BulletLeft.004" "BulletPosLeft" -0.69953 -0.496294 -0.290442 0.000001 -0.000002 0.000007 0 0 0 0 0 0
$definebone "BulletHeadLeft.004" "BulletLeft.004" -0.628338 0 0 0.000001 -0.000002 0.000007 0 0 0 0 0 0
$definebone "BulletLeft.005" "BulletPosLeft" -0.69953 0.002551 -0.578333 0.000001 -0.000002 0.000007 0 0 0 0 0 0
$definebone "BulletHeadLeft.005" "BulletLeft.005" -0.628338 0 0 0.000001 -0.000002 0.000007 0 0 0 0 0 0
$definebone "BulletLeft.006" "BulletPosLeft" -0.699526 0.502242 -0.290088 0.000001 -0.000002 0.000007 0 0 0 0 0 0
$definebone "BulletHeadLeft.006" "BulletLeft.006" -0.628338 0 0 0.000001 -0.000002 0.000007 0 0 0 0 0 0
$definebone "PusherLeft" "CyHolderLeft" -0.630154 0.119954 1.216498 0.000001 -0.000002 0.000007 0 0 0 0 0 0
$definebone "TriggerLeft" "BaseLeftMesh" -1.045784 0.006299 -0.388173 0.000001 0.00017 0.000007 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511806 -0.000002 0.000003 0.000292 0.000412 -13.510177 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.196849 0.000003 -0.000001 0.000862 -0.000112 -19.951824 0 0 0 0 0 0
$definebone "cam_driver" "" 0 0 0 0 -89.999982 0 0 0 0 0 0 0
$definebone "Base" "" -4.33264 -16.435041 -4.023893 0 89.999989 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 10.640673 6.812044 -1.499065 0 0 0 0 0 0 0 0 0
$definebone "Hammer" "Base" 1.172878 0.003853 0.361695 0.000286 0.000057 0.000057 0 0 0 0 0 0
$definebone "CyHolder" "Base" -2.909386 -0.116105 -0.378792 0.000286 0.000057 0.000057 0 0 0 0 0 0
$definebone "Cy" "CyHolder" 1.368919 0.119956 1.216498 0 0 0 0 0 0 0 0 0
$definebone "BulletPos" "Cy" 1.166941 0 0.000002 0 0 0 0 0 0 0 0 0
$definebone "Bullet.001" "BulletPos" -0.699532 0.501534 0.289544 0 0 0 0 0 0 0 0 0
$definebone "BulletHead.001" "Bullet.001" -0.628336 0.000001 -0.000001 0 0 0 0 0 0 0 0 0
$definebone "Bullet.002" "BulletPos" -0.699532 0.001725 0.577365 0 0 0 0 0 0 0 0 0
$definebone "BulletHead.002" "Bullet.002" -0.628336 0.000001 -0.000001 0 0 0 0 0 0 0 0 0
$definebone "Bullet.003" "BulletPos" -0.699528 -0.498775 0.287819 0 0 0 0 0 0 0 0 0
$definebone "BulletHead.003" "Bullet.003" -0.628336 0 -0.000001 0 0 0 0 0 0 0 0 0
$definebone "Bullet.004" "BulletPos" -0.699533 -0.496294 -0.290443 0 0 0 0 0 0 0 0 0
$definebone "BulletHead.004" "Bullet.004" -0.628336 0 -0.000001 0 0 0 0 0 0 0 0 0
$definebone "Bullet.005" "BulletPos" -0.699532 0.002551 -0.578332 0 0 0 0 0 0 0 0 0
$definebone "BulletHead.005" "Bullet.005" -0.628336 0.000001 -0.000001 0 0 0 0 0 0 0 0 0
$definebone "Bullet.006" "BulletPos" -0.699533 0.502242 -0.290087 0 0 0 0 0 0 0 0 0
$definebone "BulletHead.006" "Bullet.006" -0.628336 0.000001 -0.000001 0 0 0 0 0 0 0 0 0
$definebone "Pusher" "CyHolder" -0.630156 0.119956 1.216496 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" -1.045753 0.006287 -0.388106 0.000286 0.000057 0.000057 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" 6.720085 -10.973631 -1.147131 -20.115269 -87.91978 178.262746 0 0 0 0 0 0

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


$sectionframes 30 29

$poseparameter "ammo_fraction" 0 1 loop 0
$poseparameter "player_movement" 0 260 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "revolver_firemode_pose" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "Bullet0_corrective_animation" "v_dual_swm10_anims\Bullet0_corrective_animation.smd" {
}

$animation "Bullet1_corrective_animation" "v_dual_swm10_anims\Bullet1_corrective_animation.smd" {
}

$animation "Bullet2_corrective_animation" "v_dual_swm10_anims\Bullet2_corrective_animation.smd" {
}

$animation "Bullet3_corrective_animation" "v_dual_swm10_anims\Bullet3_corrective_animation.smd" {
}

$animation "Bullet4_corrective_animation" "v_dual_swm10_anims\Bullet4_corrective_animation.smd" {
}

$animation "Bullet5_corrective_animation" "v_dual_swm10_anims\Bullet5_corrective_animation.smd" {
}

$animation "Bullet6_corrective_animation" "v_dual_swm10_anims\Bullet6_corrective_animation.smd" {
}

$animation "Bullet7_corrective_animation" "v_dual_swm10_anims\Bullet7_corrective_animation.smd" {
}

$animation "Bullet8_corrective_animation" "v_dual_swm10_anims\Bullet8_corrective_animation.smd" {
}

$animation "Bullet9_corrective_animation" "v_dual_swm10_anims\Bullet9_corrective_animation.smd" {
}

$animation "Bullet10_corrective_animation" "v_dual_swm10_anims\Bullet10_corrective_animation.smd" {
}

$animation "Bullet11_corrective_animation" "v_dual_swm10_anims\Bullet11_corrective_animation.smd" {
}

$animation "Default_corrective_animation" "v_dual_swm10_anims\Default_corrective_animation.smd" {
}

$animation "runIdle_a_corrective_animation" "v_dual_swm10_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_dual_swm10_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_dual_swm10_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_dual_swm10_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot_r_a_corrective_animation" "v_dual_swm10_anims\shoot_r_a_corrective_animation.smd" {
}

$animation "shoot_r_ironsight_a_corrective_animation" "v_dual_swm10_anims\shoot_r_ironsight_a_corrective_animation.smd" {
}

$animation "shoot_l_a_corrective_animation" "v_dual_swm10_anims\shoot_l_a_corrective_animation.smd" {
}

$animation "shoot_l_ironsight_a_corrective_animation" "v_dual_swm10_anims\shoot_l_ironsight_a_corrective_animation.smd" {
}

$animation "shoot_p_r_a_corrective_animation" "v_dual_swm10_anims\shoot_p_r_a_corrective_animation.smd" {
}

$animation "shoot_p_r_ironsight_a_corrective_animation" "v_dual_swm10_anims\shoot_p_r_ironsight_a_corrective_animation.smd" {
}

$animation "shoot_p_l_a_corrective_animation" "v_dual_swm10_anims\shoot_p_l_a_corrective_animation.smd" {
}

$animation "shoot_p_l_ironsight_a_corrective_animation" "v_dual_swm10_anims\shoot_p_l_ironsight_a_corrective_animation.smd" {
}

$animation "shoot_d_r_a_corrective_animation" "v_dual_swm10_anims\shoot_d_r_a_corrective_animation.smd" {
}

$animation "shoot_d_r_ironsight_a_corrective_animation" "v_dual_swm10_anims\shoot_d_r_ironsight_a_corrective_animation.smd" {
}

$animation "shoot_d_l_a_corrective_animation" "v_dual_swm10_anims\shoot_d_l_a_corrective_animation.smd" {
}

$animation "shoot_d_l_ironsight_a_corrective_animation" "v_dual_swm10_anims\shoot_d_l_ironsight_a_corrective_animation.smd" {
}

$animation "PoseDelta" "v_dual_swm10_anims\PoseDelta.smd" {
	fps 30
	
	
}

$animation "Default" "v_dual_swm10_anims\Default.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Default_corrective_animation" 0
}

$animation "Bullet11" "v_dual_swm10_anims\Bullet11.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet11_corrective_animation" 0
}

$animation "Bullet10" "v_dual_swm10_anims\Bullet10.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet10_corrective_animation" 0
}

$animation "Bullet9" "v_dual_swm10_anims\Bullet9.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet9_corrective_animation" 0
}

$animation "Bullet8" "v_dual_swm10_anims\Bullet8.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet8_corrective_animation" 0
}

$animation "Bullet7" "v_dual_swm10_anims\Bullet7.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet7_corrective_animation" 0
}

$animation "Bullet6" "v_dual_swm10_anims\Bullet6.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet6_corrective_animation" 0
}

$animation "Bullet5" "v_dual_swm10_anims\Bullet5.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet5_corrective_animation" 0
}

$animation "Bullet4" "v_dual_swm10_anims\Bullet4.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet4_corrective_animation" 0
}

$animation "Bullet3" "v_dual_swm10_anims\Bullet3.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet3_corrective_animation" 0
}

$animation "Bullet2" "v_dual_swm10_anims\Bullet2.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet2_corrective_animation" 0
}

$animation "Bullet1" "v_dual_swm10_anims\Bullet1.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet1_corrective_animation" 0
}

$animation "Bullet0" "v_dual_swm10_anims\Bullet0.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet0_corrective_animation" 0
}

$animation "basePose_a" "v_dual_swm10_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "ironsight" "v_dual_swm10_anims\ironsight.smd" {
	fps 0.5
	
	
}

$animation "ironsight_transition" "v_dual_swm10_anims\ironsight_transition.smd" {
	fps 0.5
	
	
}

$animation "runIdle_a" "v_dual_swm10_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
}

$animation "run_a" "v_dual_swm10_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
}

$animation "walkIdle_a" "v_dual_swm10_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
}

$animation "walk_a" "v_dual_swm10_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
}

$animation "idle_delayed_a" "v_dual_swm10_anims\idle_delayed_a.smd" {
	fps 30
	
	
}

$animation "ironsight_delayed" "v_dual_swm10_anims\ironsight_delayed.smd" {
	fps 0.5
	
	
}

$animation "ironsight_transition_delayed" "v_dual_swm10_anims\ironsight_transition_delayed.smd" {
	fps 0.5
	
	
}

$animation "shoot_r_a" "v_dual_swm10_anims\shoot_r_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_r_a_corrective_animation" 0
}

$animation "shoot_r_ironsight_a" "v_dual_swm10_anims\shoot_r_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_r_ironsight_a_corrective_animation" 0
}

$animation "shoot_l_a" "v_dual_swm10_anims\shoot_l_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_l_a_corrective_animation" 0
}

$animation "shoot_l_ironsight_a" "v_dual_swm10_anims\shoot_l_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_l_ironsight_a_corrective_animation" 0
}

$animation "shoot_p_r_a" "v_dual_swm10_anims\shoot_p_r_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_p_r_a_corrective_animation" 0
}

$animation "shoot_p_r_ironsight_a" "v_dual_swm10_anims\shoot_p_r_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_p_r_ironsight_a_corrective_animation" 0
}

$animation "shoot_p_l_a" "v_dual_swm10_anims\shoot_p_l_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_p_l_a_corrective_animation" 0
}

$animation "shoot_p_l_ironsight_a" "v_dual_swm10_anims\shoot_p_l_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_p_l_ironsight_a_corrective_animation" 0
}

$animation "shoot_d_r_a" "v_dual_swm10_anims\shoot_d_r_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_d_r_a_corrective_animation" 0
}

$animation "shoot_d_r_ironsight_a" "v_dual_swm10_anims\shoot_d_r_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_d_r_ironsight_a_corrective_animation" 0
}

$animation "shoot_d_l_a" "v_dual_swm10_anims\shoot_d_l_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_d_l_a_corrective_animation" 0
}

$animation "shoot_d_l_ironsight_a" "v_dual_swm10_anims\shoot_d_l_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_d_l_ironsight_a_corrective_animation" 0
}

$animation "reload_a" "v_dual_swm10_anims\reload_a.smd" {
	fps 30
	
	
}

$animation "reload_a_i" "v_dual_swm10_anims\reload_a_i.smd" {
	fps 30
	
	
}

$animation "reload_d_a" "v_dual_swm10_anims\reload_d_a.smd" {
	fps 30
	
	
}

$animation "reload_d_a_i" "v_dual_swm10_anims\reload_d_a_i.smd" {
	fps 30
	
	
}

$animation "reload_r_a" "v_dual_swm10_anims\reload_r_a.smd" {
	fps 30
	
	
}

$animation "reload_r_a_i" "v_dual_swm10_anims\reload_r_a_i.smd" {
	fps 30
	
	
}

$animation "reload_d_r_a" "v_dual_swm10_anims\reload_d_r_a.smd" {
	fps 30
	
	
}

$animation "reload_d_r_a_i" "v_dual_swm10_anims\reload_d_r_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a" "v_dual_swm10_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_dual_swm10_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_d_s_a" "v_dual_swm10_anims\nearwall_d_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_d_s_a_i" "v_dual_swm10_anims\nearwall_d_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_dual_swm10_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_dual_swm10_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_d_a" "v_dual_swm10_anims\nearwall_d_a.smd" {
	fps 30
	
	
}

$animation "nearwall_d_a_i" "v_dual_swm10_anims\nearwall_d_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_dual_swm10_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_dual_swm10_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_d_e_a" "v_dual_swm10_anims\nearwall_d_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_d_e_a_i" "v_dual_swm10_anims\nearwall_d_e_a_i.smd" {
	fps 30
	
	
}

$animation "proneF" "v_dual_swm10_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_dual_swm10_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_dual_swm10_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_dual_swm10_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pronedF" "v_dual_swm10_anims\pronedF.smd" {
	fps 30
	
	
}

$animation "pronedB" "v_dual_swm10_anims\pronedB.smd" {
	fps 30
	
	
}

$animation "pronedL" "v_dual_swm10_anims\pronedL.smd" {
	fps 30
	
	
}

$animation "pronedR" "v_dual_swm10_anims\pronedR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_dual_swm10_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_dual_swm10_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_d_s_a" "v_dual_swm10_anims\pickup_d_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_d_s_a_i" "v_dual_swm10_anims\pickup_d_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_dual_swm10_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_dual_swm10_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_d_a" "v_dual_swm10_anims\pickup_d_a.smd" {
	fps 30
	
	
}

$animation "pickup_d_a_i" "v_dual_swm10_anims\pickup_d_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_dual_swm10_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_dual_swm10_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_d_e_a" "v_dual_swm10_anims\pickup_d_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_d_e_a_i" "v_dual_swm10_anims\pickup_d_e_a_i.smd" {
	fps 30
	
	
}

$animation "change_firemode_todelayed_a" "v_dual_swm10_anims\change_firemode_todelayed_a.smd" {
	fps 30
	
	
}

$animation "change_firemode_todelayed_iron_a" "v_dual_swm10_anims\change_firemode_todelayed_iron_a.smd" {
	fps 30
	
	
}

$animation "change_firemode_tonormal_a" "v_dual_swm10_anims\change_firemode_tonormal_a.smd" {
	fps 30
	
	
}

$animation "change_firemode_tonormal_iron_a" "v_dual_swm10_anims\change_firemode_tonormal_iron_a.smd" {
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
	"Bullet8"
	"Bullet9"
	"Bullet10"
	"Bullet11"
	"Default"
	blend "ammo_fraction" 0 1
	blendwidth 13
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

$sequence "idle" {
	"basePose_a"
	"ironsight_transition"
	"ironsight"
	"idle_delayed_a"
	"ironsight_transition_delayed"
	"ironsight_delayed"
	activity "ACT_VM_IDLE" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	blendwidth 3
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "BulletCounter"
}

$sequence "FirstDraw" {
	"v_dual_swm10_anims\FirstDraw.smd"
	"v_dual_swm10_anims\FirstDraw_2.smd"
	activity "ACT_VM_FIRSTDRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M1917.Draw" }
	{ event 5004 10 "MCV_Weapon_Foley_Revolver.HammerOut" }
	{ event 5004 12 "MCV_Weapon_Foley_Revolver.HammerOut" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "BulletCounter"
	node "0"
	fps 30
	
	
}

$sequence "draw" {
	"v_dual_swm10_anims\draw.smd"
	"v_dual_swm10_anims\draw_2.smd"
	"v_dual_swm10_anims\draw_3.smd"
	"v_dual_swm10_anims\draw_4.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	{ event 5004 1 "MCV_Weapon_Foley_M1917.Draw" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "BulletCounter"
	node "0"
	fps 30
	  
	
}

$sequence "shoot_hammer_right" {
	"shoot_r_a"
	"shoot_r_ironsight_a"
	activity "ACT_VM_PRIMARYATTACK" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event 5004 10 "MCV_Weapon_Foley_Revolver.Hand" }
	{ event 5004 15 "MCV_Weapon_Foley_Revolver.HammerOut" }
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	{ event AE_MUZZLEFLASH 0 "" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "shoot_hammer_left" {
	"shoot_l_a"
	"shoot_l_ironsight_a"
	activity "ACT_VM_SECONDARYATTACK" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event 5004 10 "MCV_Weapon_Foley_Revolver.Hand" }
	{ event 5004 15 "MCV_Weapon_Foley_Revolver.HammerOut" }
	{ event AE_CLIENT_EJECT_BRASS 0 "eject2" }
	{ event AE_MUZZLEFLASH 0 "" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "reload" {
	"reload_a"
	"reload_a_i"
	"reload_d_a"
	"reload_d_a_i"
	activity "ACT_VM_SECONDARY_RELOAD" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	{ event 5004 1 "MCV_Weapon_Foley_SWM12_Reload.Hand" }
	{ event 5004 7 "MCV_Weapon_Foley_SWM12_Reload.Start" }
	{ event 5004 28 "MCV_Weapon_Foley_SWM12_Reload.Mid_Eject" }
	{ event 5004 60 "MCV_Weapon_Foley_SWM12_Reload.Mid_Insert" }
	{ event 5004 70 "MCV_Weapon_Foley_SWM12_Reload.HandEnd" }
	{ event 5004 75 "MCV_Weapon_Foley_SWM12_Reload.End" }
	{ event 5004 80 "MCV_Weapon_Foley_SWM12_Reload.Hand" }
	{ event 5004 90 "MCV_Weapon_Foley_SWM12_Reload.Start" }
	{ event 5004 110 "MCV_Weapon_Foley_SWM12_Reload.Mid_Eject" }
	{ event 5004 145 "MCV_Weapon_Foley_SWM12_Reload.Mid_Insert" }
	{ event 5004 150 "MCV_Weapon_Foley_SWM12_Reload.HandEnd" }
	{ event 5004 155 "MCV_Weapon_Foley_SWM12_Reload.End" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 10 "ammo_fraction" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 41 "ammo_fraction" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 85 "ammo_fraction" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 124 "ammo_fraction" }
	{ event AE_WPN_COMPLETE_RELOAD 157 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	addlayer "BulletCounter"
	node "0"
}

$sequence "reloadRightOnly" {
	"reload_r_a"
	"reload_r_a_i"
	"reload_d_r_a"
	"reload_d_r_a_i"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	{ event 5004 1 "MCV_Weapon_Foley_SWM12_Reload.Hand" }
	{ event 5004 7 "MCV_Weapon_Foley_SWM12_Reload.Start" }
	{ event 5004 28 "MCV_Weapon_Foley_SWM12_Reload.Mid_Eject" }
	{ event 5004 60 "MCV_Weapon_Foley_SWM12_Reload.Mid_Insert" }
	{ event 5004 70 "MCV_Weapon_Foley_SWM12_Reload.HandEnd" }
	{ event 5004 75 "MCV_Weapon_Foley_SWM12_Reload.End" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 10 "ammo_fraction" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 41 "ammo_fraction" }
	{ event AE_WPN_COMPLETE_RELOAD 77 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	addlayer "BulletCounter"
	node "0"
}

$sequence "idletonearwall" {
	"nearwall_s_a"
	"nearwall_s_a_i"
	"nearwall_d_s_a"
	"nearwall_d_s_a_i"
	activity "ACT_VM_IDLE_TO_LOWERED" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.In" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "BulletCounter"
	node "0"
}

$sequence "nearwall" {
	"nearwall_a"
	"nearwall_a_i"
	"nearwall_d_a"
	"nearwall_d_a_i"
	activity "ACT_VM_IDLE_LOWERED" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "BulletCounter"
	node "0"
}

$sequence "nearwalltoidle" {
	"nearwall_e_a"
	"nearwall_e_a_i"
	"nearwall_d_e_a"
	"nearwall_d_e_a_i"
	activity "ACT_VM_LOWERED_TO_IDLE" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.Out" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "BulletCounter"
	node "0"
}

$sequence "prone" {
	"proneF"
	"proneL"
	"proneB"
	"proneR"
	"proneF"
	"pronedF"
	"pronedL"
	"pronedB"
	"pronedR"
	"pronedF"
	activity "ACT_VM_CRAWL" 1
	blend "move_yaw" -180 180
	blend "revolver_firemode_pose" 0 1
	blendwidth 5
	{ event 5004 1 "MCV_Weapon_Foley_Movement.ProneCrawl" }
	{ event 5004 10 "MCV_Weapon_Foley_Movement.ProneCrawl_GunLight" }
	fadein 0.2
	fadeout 0.2
	addlayer "BulletCounter"
	realtime
}

$sequence "bash" {
	"v_dual_swm10_anims\bash.smd"
	"v_dual_swm10_anims\bash_2.smd"
	"v_dual_swm10_anims\bash_3.smd"
	"v_dual_swm10_anims\bash_4.smd"
	activity "ACT_VM_BASH" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	{ event 3200 3 "" }
	{ event 5004 1 "MCV_Weapon_Foley_Bash.Fast" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	addlayer "BulletCounter"
	node "0"
	fps 30
}

$sequence "pickupstart" {
	"pickup_s_a"
	"pickup_s_a_i"
	"pickup_d_s_a"
	"pickup_d_s_a_i"
	activity "ACT_VM_PICKUPSTART" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.In" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "BulletCounter"
}

$sequence "pickuploop" {
	"pickup_a"
	"pickup_a_i"
	"pickup_d_a"
	"pickup_d_a_i"
	activity "ACT_VM_PICKUPLOOP" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "BulletCounter"
}

$sequence "pickupend" {
	"pickup_e_a"
	"pickup_e_a_i"
	"pickup_d_e_a"
	"pickup_d_e_a_i"
	activity "ACT_VM_PICKUPEND" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.Out" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "BulletCounter"
}

$sequence "holster" {
	"v_dual_swm10_anims\holster.smd"
	"v_dual_swm10_anims\holster_2.smd"
	activity "ACT_VM_HOLSTER" 1
	blend "revolver_firemode_pose" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M1917.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "BulletCounter"
	fps 30
	
	
}

$sequence "prepare_delayed_right" {
	"shoot_p_r_a"
	"shoot_p_r_ironsight_a"
	activity "ACT_VM_HAULBACK" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event 5004 0 "MCV_Weapon_Foley_Revolver.HammerOutSlow" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "prepare_delayed_left" {
	"shoot_p_l_a"
	"shoot_p_l_ironsight_a"
	activity "ACT_VM_HAULBACK2" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event 5004 0 "MCV_Weapon_Foley_Revolver.HammerOutSlow" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "shoot_delayed_right" {
	"shoot_d_r_a"
	"shoot_d_r_ironsight_a"
	activity "ACT_VM_PRIMARYATTACK2" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	{ event AE_MUZZLEFLASH 0 "" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "shoot_delayed_left" {
	"shoot_d_l_a"
	"shoot_d_l_ironsight_a"
	activity "ACT_VM_SECONDARYATTACK2" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_CLIENT_EJECT_BRASS 0 "eject2" }
	{ event AE_MUZZLEFLASH 0 "" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "changefiremode_todelayed" {
	"change_firemode_todelayed_a"
	"change_firemode_todelayed_iron_a"
	activity "ACT_VM_FIREMODE1" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event AE_WPN_SET_POSEPARAM 4 "revolver_firemode_pose 1" }
	{ event 5004 1 "MCV_Weapon_Foley_Revolver.Hand" }
	{ event 5004 6 "MCV_Weapon_Foley_Revolver.HammerIn" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "BulletCounter"
}

$sequence "changefiremode_tohammer" {
	"change_firemode_tonormal_a"
	"change_firemode_tonormal_iron_a"
	activity "ACT_VM_FIREMODE2" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event AE_WPN_SET_POSEPARAM 4 "revolver_firemode_pose 0" }
	{ event 5004 1 "MCV_Weapon_Foley_Revolver.Hand" }
	{ event 5004 7 "MCV_Weapon_Foley_Revolver.HammerOut" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "BulletCounter"
}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\dualpistol_swm12\dualswm10.qc"
//	}
}

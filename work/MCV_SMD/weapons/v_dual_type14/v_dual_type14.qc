// Created by Crowbar 0.74

$modelname "weapons/mcv/v_dual_type14.mdl"

$bodygroup "studioRight"
{
	studio "RefDualType14.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition 7.145 -8.392 -6.96

$cdmaterials "models\weapons\mcv\v_type14\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "BaseMesh" -8.3 0 2.13 rotate 0 -180 0
$attachment "eject" "BaseMesh" 0.8 0 1.1 rotate -89 90 0
$attachment "muzzle2" "BaseLeftMesh" -8.3 0 2.13 rotate 0 -180 0
$attachment "eject2" "BaseLeftMesh" 0.8 0 1.1 rotate -88.99 90 0

$cbox 0 0 0 0 0 0

$bbox -10.357 -29.562 -27.51 27.141 43.851 13.591

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
$definebone "BaseMesh" "hand_r" 19.317572 11.785625 26.964272 75.00019 90.00548 0.004232 0 0 0 0 0 0
$definebone "Mag" "BaseMesh" 0.907945 -0.018744 0.444054 0.00012 0 -0.000009 0 0 0 0 0 0
$definebone "Bullet.001" "Mag" -0.089967 0 0.219597 0.000005 0 -0.000009 0 0 0 0 0 0
$definebone "Bullet.002" "Mag" 0.167763 0 -0.206937 0.000005 0 -0.000009 0 0 0 0 0 0
$definebone "Bullet.003" "Mag" 0.291016 0 -0.647614 0.000005 0 -0.000009 0 0 0 0 0 0
$definebone "Bullet.004" "Mag" 0.462922 -0.000001 -1.064051 0.000005 0 -0.000009 0 0 0 0 0 0
$definebone "Bullet.005" "Mag" 0.650547 -0.000001 -1.484716 0.000005 0 -0.000009 0 0 0 0 0 0
$definebone "Bullet.006" "Mag" 0.852744 -0.000001 -1.903677 0.000005 0 -0.000009 0 0 0 0 0 0
$definebone "Bullet.007" "Mag" 1.047943 -0.000001 -2.309915 0.000005 0 -0.000009 0 0 0 0 0 0
$definebone "Bullet.008" "Mag" 1.245091 -0.000002 -2.741497 0.000005 0 -0.000009 0 0 0 0 0 0
$definebone "Pusher" "Mag" 1.024094 -0.000001 -3.243024 0.000005 0 -0.000009 0 0 0 0 0 0
$definebone "Trigger" "BaseMesh" -1.002631 -0.009689 0.10351 0.00012 0 -0.000009 0 0 0 0 0 0
$definebone "MagRelease" "BaseMesh" 0.341104 -0.694033 -0.278898 0.00012 0 -0.000009 0 0 0 0 0 0
$definebone "rhand_ikTarget" "BaseMesh" 11.077444 8.158658 -2.255874 0.00012 0 -0.000009 0 0 0 0 0 0
$definebone "LHand_IKtarget" "BaseMesh" 9.659132 -5.924522 -2.019215 0.00012 -0.000057 -0.000009 0 0 0 0 0 0
$definebone "Barrel" "BaseMesh" -2.741628 -0.009688 1.109304 0.00012 0 -0.000009 0 0 0 0 0 0
$definebone "Bolt" "Barrel" 2.942657 0 0.000004 0.000005 0 -0.000009 0 0 0 0 0 0
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
$definebone "BaseLeftMesh" "hand_l" -20.289324 -11.785075 -26.964701 -75.000046 -90.000631 -179.999336 0 0 0 0 0 0
$definebone "MagLeft" "BaseLeftMesh" 0.907945 -0.018744 0.444056 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "BulletLeft.001" "MagLeft" -0.089965 0 0.219598 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "BulletLeft.002" "MagLeft" 0.167763 0 -0.206937 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "BulletLeft.003" "MagLeft" 0.291017 0 -0.647616 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "BulletLeft.004" "MagLeft" 0.462923 0 -1.064054 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "BulletLeft.005" "MagLeft" 0.65055 0 -1.484719 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "BulletLeft.006" "MagLeft" 0.852747 -0.000001 -1.903682 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "BulletLeft.007" "MagLeft" 1.047944 -0.000001 -2.30992 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "BulletLeft.008" "MagLeft" 1.245093 -0.000001 -2.741503 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "PusherLeft" "MagLeft" 1.024096 -0.000001 -3.243032 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "TriggerLeft" "BaseLeftMesh" -1.002629 -0.009688 0.10351 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "MagReleaseLeft" "BaseLeftMesh" 0.341102 -0.694034 -0.278898 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "BarrelLeft" "BaseLeftMesh" -2.74163 -0.009688 1.109304 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "BoltLeft" "BarrelLeft" 2.942661 0.000001 0.000001 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511806 -0.000002 0.000006 0.000295 0.000398 -13.51017 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.19685 0.000003 -0.000002 0.000861 -0.00011 -19.951824 0 0 0 0 0 0
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

$include "../../militaryconflict_vietnam_v2.qci"

$sectionframes 30 30

$poseparameter "ammo_fraction" 0 1 loop 0
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
	 "Bullet.001" 0
	 "Bullet.002" 0
	 "Bullet.003" 0
	 "Bullet.004" 0
	 "Bullet.005" 0
	 "Bullet.006" 0
	 "Bullet.007" 0
	 "Bullet.008" 0
	 "Pusher" 0
	 "Trigger" 0
	 "MagRelease" 0
	 "rhand_ikTarget" 0
	 "LHand_IKtarget" 0
	 "Barrel" 0
	 "Bolt" 0
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
	 "BulletLeft.001" 0
	 "BulletLeft.002" 0
	 "BulletLeft.003" 0
	 "BulletLeft.004" 0
	 "BulletLeft.005" 0
	 "BulletLeft.006" 0
	 "BulletLeft.007" 0
	 "BulletLeft.008" 0
	 "PusherLeft" 0
	 "TriggerLeft" 0
	 "MagReleaseLeft" 0
	 "BarrelLeft" 0
	 "BoltLeft" 0
	 "lowerarm_twist_01_l" 1
	 "upperarm_twist_01_l" 1
	 "cam_driver" 1
}

$animation "BothEmpty_corrective_animation" "v_dual_type14_anims\BothEmpty_corrective_animation.smd" {
}

$animation "RightEmpty_corrective_animation" "v_dual_type14_anims\RightEmpty_corrective_animation.smd" {
}

$animation "DefaultSlide_corrective_animation" "v_dual_type14_anims\DefaultSlide_corrective_animation.smd" {
}

$animation "Bullet16_corrective_animation" "v_dual_type14_anims\Bullet16_corrective_animation.smd" {
}

$animation "Bullet15_corrective_animation" "v_dual_type14_anims\Bullet15_corrective_animation.smd" {
}

$animation "Bullet14_corrective_animation" "v_dual_type14_anims\Bullet14_corrective_animation.smd" {
}

$animation "Bullet13_corrective_animation" "v_dual_type14_anims\Bullet13_corrective_animation.smd" {
}

$animation "Bullet12_corrective_animation" "v_dual_type14_anims\Bullet12_corrective_animation.smd" {
}

$animation "Bullet11_corrective_animation" "v_dual_type14_anims\Bullet11_corrective_animation.smd" {
}

$animation "Bullet10_corrective_animation" "v_dual_type14_anims\Bullet10_corrective_animation.smd" {
}

$animation "Bullet09_corrective_animation" "v_dual_type14_anims\Bullet09_corrective_animation.smd" {
}

$animation "Bullet08_corrective_animation" "v_dual_type14_anims\Bullet08_corrective_animation.smd" {
}

$animation "Bullet07_corrective_animation" "v_dual_type14_anims\Bullet07_corrective_animation.smd" {
}

$animation "Bullet06_corrective_animation" "v_dual_type14_anims\Bullet06_corrective_animation.smd" {
}

$animation "Bullet05_corrective_animation" "v_dual_type14_anims\Bullet05_corrective_animation.smd" {
}

$animation "Bullet04_corrective_animation" "v_dual_type14_anims\Bullet04_corrective_animation.smd" {
}

$animation "Bullet03_corrective_animation" "v_dual_type14_anims\Bullet03_corrective_animation.smd" {
}

$animation "Bullet02_corrective_animation" "v_dual_type14_anims\Bullet02_corrective_animation.smd" {
}

$animation "Bullet01_corrective_animation" "v_dual_type14_anims\Bullet01_corrective_animation.smd" {
}

$animation "Default_corrective_animation" "v_dual_type14_anims\Default_corrective_animation.smd" {
}

$animation "runIdle_a_corrective_animation" "v_dual_type14_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_dual_type14_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_dual_type14_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_dual_type14_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_r_a_corrective_animation" "v_dual_type14_anims\shoot1_r_a_corrective_animation.smd" {
}

$animation "shoot1_r_ironsight_a_corrective_animation" "v_dual_type14_anims\shoot1_r_ironsight_a_corrective_animation.smd" {
}

$animation "shoot1_l_a_corrective_animation" "v_dual_type14_anims\shoot1_l_a_corrective_animation.smd" {
}

$animation "shoot1_l_ironsight_a_corrective_animation" "v_dual_type14_anims\shoot1_l_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_r_a_corrective_animation" "v_dual_type14_anims\shoot2_r_a_corrective_animation.smd" {
}

$animation "shoot2_r_ironsight_a_corrective_animation" "v_dual_type14_anims\shoot2_r_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_l_a_corrective_animation" "v_dual_type14_anims\shoot2_l_a_corrective_animation.smd" {
}

$animation "shoot2_l_ironsight_a_corrective_animation" "v_dual_type14_anims\shoot2_l_ironsight_a_corrective_animation.smd" {
}

$animation "shootlast_r_a_corrective_animation" "v_dual_type14_anims\shootlast_r_a_corrective_animation.smd" {
}

$animation "shootlast_r_ironsight_a_corrective_animation" "v_dual_type14_anims\shootlast_r_ironsight_a_corrective_animation.smd" {
}

$animation "shootlast_l_a_corrective_animation" "v_dual_type14_anims\shootlast_l_a_corrective_animation.smd" {
}

$animation "shootlast_l_ironsight_a_corrective_animation" "v_dual_type14_anims\shootlast_l_ironsight_a_corrective_animation.smd" {
}

$animation "PoseDelta" "v_dual_type14_anims\PoseDelta.smd" {
	fps 30
	
	
}

$animation "DefaultSlide" "v_dual_type14_anims\DefaultSlide.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "DefaultSlide_corrective_animation" 0
}

$animation "RightEmpty" "v_dual_type14_anims\RightEmpty.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "RightEmpty_corrective_animation" 0
}

$animation "BothEmpty" "v_dual_type14_anims\BothEmpty.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "BothEmpty_corrective_animation" 0
}

$animation "Default" "v_dual_type14_anims\Default.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Default_corrective_animation" 0
}

$animation "Bullet01" "v_dual_type14_anims\Bullet01.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet01_corrective_animation" 0
}

$animation "Bullet02" "v_dual_type14_anims\Bullet02.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet02_corrective_animation" 0
}

$animation "Bullet03" "v_dual_type14_anims\Bullet03.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet03_corrective_animation" 0
}

$animation "Bullet04" "v_dual_type14_anims\Bullet04.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet04_corrective_animation" 0
}

$animation "Bullet05" "v_dual_type14_anims\Bullet05.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet05_corrective_animation" 0
}

$animation "Bullet06" "v_dual_type14_anims\Bullet06.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet06_corrective_animation" 0
}

$animation "Bullet07" "v_dual_type14_anims\Bullet07.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet07_corrective_animation" 0
}

$animation "Bullet08" "v_dual_type14_anims\Bullet08.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet08_corrective_animation" 0
}

$animation "Bullet09" "v_dual_type14_anims\Bullet09.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet09_corrective_animation" 0
}

$animation "Bullet10" "v_dual_type14_anims\Bullet10.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet10_corrective_animation" 0
}

$animation "Bullet11" "v_dual_type14_anims\Bullet11.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet11_corrective_animation" 0
}

$animation "Bullet12" "v_dual_type14_anims\Bullet12.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet12_corrective_animation" 0
}

$animation "Bullet13" "v_dual_type14_anims\Bullet13.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet13_corrective_animation" 0
}

$animation "Bullet14" "v_dual_type14_anims\Bullet14.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet14_corrective_animation" 0
}

$animation "Bullet15" "v_dual_type14_anims\Bullet15.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet15_corrective_animation" 0
}

$animation "Bullet16" "v_dual_type14_anims\Bullet16.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet16_corrective_animation" 0
}

$animation "basePose_a" "v_dual_type14_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "ironsight" "v_dual_type14_anims\ironsight.smd" {
	fps 30
	frame 0 1
	numframes 60
	
	
}

$animation "ironsight_transition" "v_dual_type14_anims\ironsight_transition.smd" {
	fps 30
	frame 0 1
	numframes 60
	
	
}

$animation "runIdle_a" "v_dual_type14_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	weightlist "weights_runlayer"
}

$animation "run_a" "v_dual_type14_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	weightlist "weights_runlayer"
}

$animation "walkIdle_a" "v_dual_type14_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	weightlist "weights_runlayer"
}

$animation "walk_a" "v_dual_type14_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	weightlist "weights_runlayer"
}

$animation "FirstDraw_a" "v_dual_type14_anims\FirstDraw_a.smd" {
	fps 30
	
	
}

$animation "FirstDraw_a_i" "v_dual_type14_anims\FirstDraw_a_i.smd" {
	fps 30
	
	
}

$animation "shoot1_r_a" "v_dual_type14_anims\shoot1_r_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_r_a_corrective_animation" 0
}

$animation "shoot1_r_ironsight_a" "v_dual_type14_anims\shoot1_r_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_r_ironsight_a_corrective_animation" 0
}

$animation "shoot1_l_a" "v_dual_type14_anims\shoot1_l_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_l_a_corrective_animation" 0
}

$animation "shoot1_l_ironsight_a" "v_dual_type14_anims\shoot1_l_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_l_ironsight_a_corrective_animation" 0
}

$animation "shoot2_r_a" "v_dual_type14_anims\shoot2_r_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_r_a_corrective_animation" 0
}

$animation "shoot2_r_ironsight_a" "v_dual_type14_anims\shoot2_r_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_r_ironsight_a_corrective_animation" 0
}

$animation "shoot2_l_a" "v_dual_type14_anims\shoot2_l_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_l_a_corrective_animation" 0
}

$animation "shoot2_l_ironsight_a" "v_dual_type14_anims\shoot2_l_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_l_ironsight_a_corrective_animation" 0
}

$animation "shootlast_r_a" "v_dual_type14_anims\shootlast_r_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_r_a_corrective_animation" 0
}

$animation "shootlast_r_ironsight_a" "v_dual_type14_anims\shootlast_r_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_r_ironsight_a_corrective_animation" 0
}

$animation "shootlast_l_a" "v_dual_type14_anims\shootlast_l_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_l_a_corrective_animation" 0
}

$animation "shootlast_l_ironsight_a" "v_dual_type14_anims\shootlast_l_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_l_ironsight_a_corrective_animation" 0
}

$animation "reload_a" "v_dual_type14_anims\reload_a.smd" {
	fps 30
	
	
}

$animation "reload_a_i" "v_dual_type14_anims\reload_a_i.smd" {
	fps 30
	
	
}

$animation "reload_r_a" "v_dual_type14_anims\reload_r_a.smd" {
	fps 30
	
	
}

$animation "reload_r_a_i" "v_dual_type14_anims\reload_r_a_i.smd" {
	fps 30
	
	
}

$animation "reload_re_a" "v_dual_type14_anims\reload_re_a.smd" {
	fps 30
	
	
}

$animation "reload_re_a_i" "v_dual_type14_anims\reload_re_a_i.smd" {
	fps 30
	
	
}

$animation "reload_e_a" "v_dual_type14_anims\reload_e_a.smd" {
	fps 30
	
	
}

$animation "reload_e_a_i" "v_dual_type14_anims\reload_e_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a" "v_dual_type14_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_dual_type14_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_dual_type14_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_dual_type14_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_dual_type14_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_dual_type14_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "proneF" "v_dual_type14_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_dual_type14_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_dual_type14_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_dual_type14_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_dual_type14_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_dual_type14_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_dual_type14_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_dual_type14_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_dual_type14_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_dual_type14_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$sequence "SlidePosition" {
	"BothEmpty"
	"RightEmpty"
	"RightEmpty"
	"DefaultSlide"
	blend "ammo_fraction" 0 0.125
	blendwidth 4
	delta
	fadein 0.2
	fadeout 0.2
	hidden
	node "0"
}

$sequence "BulletCounter" {
	"Bullet16"
	"Bullet15"
	"Bullet14"
	"Bullet13"
	"Bullet12"
	"Bullet11"
	"Bullet10"
	"Bullet09"
	"Bullet08"
	"Bullet07"
	"Bullet06"
	"Bullet05"
	"Bullet04"
	"Bullet03"
	"Bullet02"
	"Bullet01"
	"Default"
	blend "ammo_fraction" 0 1
	blendwidth 17
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
	"ironsight"
	activity "ACT_VM_IDLE" 1
	blend "ironsight" 0 1
	blendwidth 3
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "SlidePosition"
	addlayer "BulletCounter"
	node "0"
}

$sequence "draw" {
	"v_dual_type14_anims\draw.smd"
	"v_dual_type14_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Type14.Draw" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "BulletCounter"
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
	fps 30
	  
	
}

$sequence "Firstdraw" {
	"FirstDraw_a"
	"FirstDraw_a_i"
	activity "ACT_VM_READY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Type14.Draw" }
	{ event 5004 6 "MCV_Weapon_Foley_Type14_Reload.MetalStart" }
	{ event 5004 12 "MCV_Weapon_Foley_Type14_Reload.MetalEnd" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
}
$sequence "shoot1_r" {
	"basePose_a"
	"ironsight_transition"
	"ironsight"
	activity "ACT_VM_PRIMARYATTACK" 1
	blend "ironsight" 0 1
	blendwidth 3
	fadein 0
	fadeout 0
	addlayer "walklayerironsight"
	addlayer "SlidePosition"
	addlayer "BulletCounter"
	addlayer "shoot1pose_r"
	node "0"
}

$sequence "shoot1pose_r" {
	"shoot1_r_a"
	"shoot1_r_ironsight_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	snap
	hidden
}

$sequence "shoot1_l" {
	"basePose_a"
	"ironsight_transition"
	"ironsight"
	activity "ACT_VM_SECONDARYATTACK" 1
	blend "ironsight" 0 1
	blendwidth 3
	fadein 0
	fadeout 0
	addlayer "walklayerironsight"
	addlayer "SlidePosition"
	addlayer "BulletCounter"
	addlayer "shoot1pose_l"
	node "0"
}

$sequence "shoot1pose_l" {
	"shoot1_l_a"
	"shoot1_l_ironsight_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	snap
	hidden
}

$sequence "shoot2_r" {
	"basePose_a"
	"ironsight_transition"
	"ironsight"
	activity "ACT_VM_PRIMARYATTACK" 1
	blend "ironsight" 0 1
	blendwidth 3
	fadein 0
	fadeout 0
	addlayer "walklayerironsight"
	addlayer "SlidePosition"
	addlayer "BulletCounter"
	addlayer "shoot2pose_r"
	node "0"
}

$sequence "shoot2pose_r" {
	"shoot2_r_a"
	"shoot2_r_ironsight_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	snap
	hidden
}

$sequence "shoot2_l" {
	"basePose_a"
	"ironsight_transition"
	"ironsight"
	activity "ACT_VM_SECONDARYATTACK" 1
	blend "ironsight" 0 1
	blendwidth 3
	fadein 0
	fadeout 0
	addlayer "walklayerironsight"
	addlayer "SlidePosition"
	addlayer "BulletCounter"
	addlayer "shoot2pose_l"
	node "0"
}

$sequence "shoot2pose_l" {
	"shoot2_l_a"
	"shoot2_l_ironsight_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	snap
	hidden
}

$sequence "shootlast_r" {
	"shootlast_r_a"
	"shootlast_r_ironsight_a"
	activity "ACT_VM_PRIMARYSHOOTLAST" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event 5004 1 "MCV_Weapon_Foley_PM_ShootLast.Metal" }
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
	{ event 5004 1 "MCV_Weapon_Foley_PM_ShootLast.Metal" }
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
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Type14_Reload.Hand" }
	{ event 5004 11 "MCV_Weapon_Foley_Type14_Reload.MagOut" }
	{ event 5004 43 "MCV_Weapon_Foley_Type14_Reload.MagIn" }
	{ event 5004 58 "MCV_Weapon_Foley_Type14_Reload.HandEnd" }
	{ event 5004 60 "MCV_Weapon_Foley_Type14_Reload.Hand" }
	{ event 5004 70 "MCV_Weapon_Foley_Type14_Reload.MagOut" }
	{ event 5004 105 "MCV_Weapon_Foley_Type14_Reload.MagIn" }
	{ event 5004 115 "MCV_Weapon_Foley_Type14_Reload.HandEnd" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 5 "ammo_fraction" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 35 "ammo_fraction" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 66 "ammo_fraction" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 90 "ammo_fraction" }
	{ event AE_WPN_COMPLETE_RELOAD 114 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	addlayer "BulletCounter"
	node "0"
}

$sequence "reloadRightOnly" {
	"reload_r_a"
	"reload_r_a_i"
	activity "ACT_VM_MISSRIGHT" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Type14_Reload.Hand" }
	{ event 5004 11 "MCV_Weapon_Foley_Type14_Reload.MagOut" }
	{ event 5004 43 "MCV_Weapon_Foley_Type14_Reload.MagIn" }
	{ event 5004 58 "MCV_Weapon_Foley_Type14_Reload.HandEnd" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 5 "ammo_fraction" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 35 "ammo_fraction" }
	{ event AE_WPN_COMPLETE_RELOAD 54 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	addlayer "BulletCounter"
	node "0"
}

$sequence "reload_emptyRightOnly" {
	"reload_re_a"
	"reload_re_a_i"
	activity "ACT_VM_MISSRIGHT2" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Type14_Reload.Hand" }
	{ event 5004 10 "MCV_Weapon_Foley_Type14_Reload.MagOut" }
	{ event 5004 11 "MCV_Weapon_Foley_Type14_Reload.MetalSpecial" }
	{ event 5004 43 "MCV_Weapon_Foley_Type14_Reload.MagIn" }
	{ event 5004 60 "MCV_Weapon_Foley_Type14.Draw" }
	{ event 5004 66 "MCV_Weapon_Foley_Type14_Reload.MetalStart" }
	{ event 5004 74 "MCV_Weapon_Foley_Type14_Reload.MetalEnd" }
	{ event 5004 85 "MCV_Weapon_Foley_Type14_Reload.HandEnd" }
	{ event 5004 90 "MCV_Weapon_Foley_Type14_Reload.Hand" }
	{ event 5004 98 "MCV_Weapon_Foley_Type14_Reload.MagOut" }
	{ event 5004 132 "MCV_Weapon_Foley_Type14_Reload.MagIn" }
	{ event 5004 148 "MCV_Weapon_Foley_Type14_Reload.HandEnd" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 5 "ammo_fraction" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 35 "ammo_fraction" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 90 "ammo_fraction" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 115 "ammo_fraction" }
	{ event AE_WPN_COMPLETE_RELOAD 141 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	addlayer "BulletCounter"
	node "0"
}

$sequence "reload_empty" {
	"reload_e_a"
	"reload_e_a_i"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Type14_Reload.Hand" }
	{ event 5004 10 "MCV_Weapon_Foley_Type14_Reload.MagOut" }
	{ event 5004 11 "MCV_Weapon_Foley_Type14_Reload.MetalSpecial" }
	{ event 5004 43 "MCV_Weapon_Foley_Type14_Reload.MagIn" }
	{ event 5004 60 "MCV_Weapon_Foley_Type14.Draw" }
	{ event 5004 66 "MCV_Weapon_Foley_Type14_Reload.MetalStart" }
	{ event 5004 74 "MCV_Weapon_Foley_Type14_Reload.MetalEnd" }
	{ event 5004 85 "MCV_Weapon_Foley_Type14_Reload.HandEnd" }
	{ event 5004 90 "MCV_Weapon_Foley_Type14_Reload.Hand" }
	{ event 5004 98 "MCV_Weapon_Foley_Type14_Reload.MagOut" }
	{ event 5004 99 "MCV_Weapon_Foley_Type14_Reload.MetalSpecial" }
	{ event 5004 132 "MCV_Weapon_Foley_Type14_Reload.MagIn" }
	{ event 5004 150 "MCV_Weapon_Foley_Type14.Draw" }
	{ event 5004 152 "MCV_Weapon_Foley_Type14_Reload.MetalStart" }
	{ event 5004 162 "MCV_Weapon_Foley_Type14_Reload.MetalEnd" }
	{ event 5004 168 "MCV_Weapon_Foley_Type14_Reload.HandEnd" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 5 "ammo_fraction" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 35 "ammo_fraction" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 90 "ammo_fraction" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 115 "ammo_fraction" }
	{ event AE_WPN_COMPLETE_RELOAD 165 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	addlayer "BulletCounter"
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
	addlayer "BulletCounter"
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
	addlayer "BulletCounter"
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
	"v_dual_type14_anims\bash.smd"
	"v_dual_type14_anims\bash_2.smd"
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
	addlayer "SlidePosition"
	addlayer "BulletCounter"
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
	addlayer "BulletCounter"
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
	addlayer "BulletCounter"
	addlayer "walklayer"
}

$sequence "holster" {
	"v_dual_type14_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 1 "MCV_Weapon_Foley_Type14.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "BulletCounter"
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\dualpistol_type14\dualType14.qc"
//	}
}

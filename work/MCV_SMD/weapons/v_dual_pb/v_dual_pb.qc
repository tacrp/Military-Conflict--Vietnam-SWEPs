// Created by Crowbar 0.74

$modelname "weapons/mcv/v_dual_pb.mdl"

$bodygroup "studioRight"
{
	studio "RefDualPB.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition 0.157 -11.526 -13.755

$cdmaterials "models\weapons\mcv\v_pb\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "BaseMesh" -8.3 0 2.13 rotate 0 -180 0
$attachment "eject" "BaseMesh" -0.1 0 1.6 rotate -20 90 0
$attachment "muzzle2" "BaseLeftMesh" -8.3 0 2.13 rotate 0 -180 0
$attachment "eject2" "BaseLeftMesh" -0.1 0 1.6 rotate -20 90 0

$cbox 0 0 0 0 0 0

$bbox -9.182 -19.583 -27.51 32.235 19.896 0

$definebone "root" "" 0 7.450089 -27.509027 0 0 0 0 0 0 0 0 0
$definebone "pelvis" "root" -0.000002 0 0 -89.790336 -89.996943 89.996943 0 0 0 0 0 0
$definebone "spine_01" "pelvis" 4.255468 -0.335183 -0.000002 0 -7.153264 0 0 0 0 0 0 0
$definebone "spine_02" "spine_01" 7.431248 1.496477 0.000002 0 14.063251 0 0 0 0 0 0 0
$definebone "spine_03" "spine_02" 5.278479 0.165541 0.000001 0 2.779477 0 0 0 0 0 0 0
$definebone "clavicle_r" "spine_03" 4.678654 -1.075636 1.488977 66.457877 -74.414959 113.208678 0 0 0 0 0 0
$definebone "upperarm_r" "clavicle_r" -6.214482 -0.000007 -0.000027 -17.285762 100.610947 -158.881279 0 0 0 0 0 0
$definebone "lowerarm_r" "upperarm_r" 11.944885 0 0 -17.318628 58.87147 -2.620262 0 0 0 0 0 0
$definebone "hand_r" "lowerarm_r" 10.62018 -0.000001 -0.000001 -17.390541 154.858994 115.958184 0 0 0 0 0 0
$definebone "index_01_r" "hand_r" -4.751108 -0.694492 0.830575 -3.762682 25.538663 14.867227 0 0 0 0 0 0
$definebone "index_02_r" "index_01_r" -1.688068 0.000045 -0.000034 -0.475224 11.986097 1.33774 0 0 0 0 0 0
$definebone "index_03_r" "index_02_r" -1.336138 0.000054 -0.000012 0.996933 -9.49661 1.137549 0 0 0 0 0 0
$definebone "middle_01_r" "hand_r" -4.820497 -0.509459 -0.224759 -7.039541 22.827317 1.918093 0 0 0 0 0 0
$definebone "middle_02_r" "middle_01_r" -1.826991 -0.000065 0.000006 1.136737 12.280644 -2.025002 0 0 0 0 0 0
$definebone "middle_03_r" "middle_02_r" -1.436577 0.000011 0.000004 -4.389721 -15.399572 0.781576 0 0 0 0 0 0
$definebone "pinky_01_r" "hand_r" -3.992359 -0.891186 -1.827908 -18.932822 20.18741 -18.724433 0 0 0 0 0 0
$definebone "pinky_02_r" "pinky_01_r" -1.40592 -0.000024 -0.000003 -1.315563 11.208242 1.063875 0 0 0 0 0 0
$definebone "pinky_03_r" "pinky_02_r" -1.175364 0.000127 -0.000019 3.869417 1.038582 0.445653 0 0 0 0 0 0
$definebone "ring_01_r" "hand_r" -4.526755 -0.690574 -1.120743 -10.988249 23.293472 -13.509884 0 0 0 0 0 0
$definebone "ring_02_r" "ring_01_r" -1.744044 0.000039 -0.000008 -1.669888 13.315291 0.301262 0 0 0 0 0 0
$definebone "ring_03_r" "ring_02_r" -1.368763 0.000024 0.000004 2.987743 -12.899527 -0.360675 0 0 0 0 0 0
$definebone "thumb_01_r" "hand_r" -1.874802 -0.935125 0.999173 36.920239 27.057801 95.069526 0 0 0 0 0 0
$definebone "thumb_02_r" "thumb_01_r" -1.523451 0.00003 0.000029 9.832801 15.151547 1.613454 0 0 0 0 0 0
$definebone "thumb_03_r" "thumb_02_r" -1.599283 0.000003 0.000013 0.480701 -12.385724 2.414109 0 0 0 0 0 0
$definebone "BaseMesh" "hand_r" -5.796916 -0.550033 8.299196 0.001078 0.001432 -75.000292 0 0 0 0 0 0
$definebone "Mag" "BaseMesh" 0.084805 -0.018744 1.059228 0.000112 -0.00001 -0.000003 0 0 0 0 0 0
$definebone "Bullet.001" "Mag" -0.051861 0 0.223938 -0.000003 -0.00001 -0.000003 0 0 0 0 0 0
$definebone "Bullet.002" "Mag" -0.011209 0 -0.207644 -0.000003 -0.00001 -0.000003 0 0 0 0 0 0
$definebone "Bullet.003" "Mag" 0.033796 -0.000001 -0.691232 -0.000003 -0.00001 -0.000003 0 0 0 0 0 0
$definebone "Bullet.004" "Mag" 0.074448 -0.000001 -1.122814 -0.000003 -0.00001 -0.000003 0 0 0 0 0 0
$definebone "Bullet.005" "Mag" 0.163632 -0.000001 -1.606582 -0.000003 -0.00001 -0.000003 0 0 0 0 0 0
$definebone "Bullet.006" "Mag" 0.204285 -0.000002 -2.038164 -0.000003 -0.00001 -0.000003 0 0 0 0 0 0
$definebone "Bullet.007" "Mag" 0.293468 -0.000002 -2.502457 -0.000003 -0.00001 -0.000003 0 0 0 0 0 0
$definebone "Bullet.008" "Mag" 0.334123 -0.000002 -2.934039 -0.000003 -0.00001 -0.000003 0 0 0 0 0 0
$definebone "Hammer" "BaseMesh" 1.745956 -0.00969 0.758464 0.000112 -0.00001 -0.000003 0 0 0 0 0 0
$definebone "Trigger" "BaseMesh" -1.76192 -0.009689 0.390344 0.000112 -0.00001 -0.000003 0 0 0 0 0 0
$definebone "Slide" "BaseMesh" -1.187037 -0.009688 1.460376 0.000112 -0.00001 -0.000003 0 0 0 0 0 0
$definebone "rhand_ikTarget" "BaseMesh" 5.797153 8.158661 -1.616759 -5.623408 89.810526 -8.287666 0 0 0 0 0 0
$definebone "LHand_IKtarget" "BaseMesh" 5.594568 -8.20946 -1.447655 -74.114956 55.708648 -136.89378 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" 5.511815 0.000004 -0.000003 -0.000407 179.999745 166.489945 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" 0.19685 -0.000003 0.000003 0.000347 -179.999117 160.050416 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 4.678655 -1.075636 -1.488978 66.457918 105.584814 113.208535 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.214485 0.000006 0.00002 22.980641 -99.667971 -29.934701 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.944892 -0.000034 -0.00019 -17.480136 -59.829554 2.906045 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620167 0.000009 0.000007 -4.919399 -141.006291 -157.41481 0 0 0 0 0 0
$definebone "index_01_l" "hand_l" 4.751155 0.694376 -0.830473 -3.764671 25.536488 14.866762 0 0 0 0 0 0
$definebone "index_02_l" "index_01_l" 1.688066 -0.000026 0.000002 -0.475149 11.986496 1.337908 0 0 0 0 0 0
$definebone "index_03_l" "index_02_l" 1.336144 -0.000052 -0.00001 -1.907888 -9.554314 1.13783 0 0 0 0 0 0
$definebone "middle_01_l" "hand_l" 4.820514 0.50934 0.224865 -7.040155 22.825884 1.917687 0 0 0 0 0 0
$definebone "middle_02_l" "middle_01_l" 1.826997 0.000066 0.000009 1.136754 12.28065 -2.025005 0 0 0 0 0 0
$definebone "middle_03_l" "middle_02_l" 1.436582 -0.00001 0.000008 -0.387829 -15.345021 0.77922 0 0 0 0 0 0
$definebone "pinky_01_l" "hand_l" 3.992351 0.891088 1.827995 -18.934237 20.186211 -18.724953 0 0 0 0 0 0
$definebone "pinky_02_l" "pinky_01_l" 1.405921 0.000023 -0.000005 -1.315953 11.208132 1.063923 0 0 0 0 0 0
$definebone "pinky_03_l" "pinky_02_l" 1.175364 -0.000129 0.000003 7.050432 1.063457 0.448048 0 0 0 0 0 0
$definebone "ring_01_l" "hand_l" 4.526755 0.690459 1.120841 -10.989666 23.29204 -13.51029 0 0 0 0 0 0
$definebone "ring_02_l" "ring_01_l" 1.744043 -0.000031 -0.000003 -1.67016 13.315699 0.301546 0 0 0 0 0 0
$definebone "ring_03_l" "ring_02_l" 1.368764 -0.000032 -0.000017 9.085973 -12.938543 -0.365207 0 0 0 0 0 0
$definebone "thumb_01_l" "hand_l" 1.87485 0.935081 -0.99913 36.919102 27.057065 95.069574 0 0 0 0 0 0
$definebone "thumb_02_l" "thumb_01_l" 1.523453 -0.000033 -0.000003 9.832685 15.15141 1.612771 0 0 0 0 0 0
$definebone "thumb_03_l" "thumb_02_l" 1.59928 0.000002 0.000007 4.129697 -12.231674 2.421159 0 0 0 0 0 0
$definebone "BaseLeftMesh" "hand_l" -5.594591 -2.229009 2.72543 -0.000169 -0.000058 104.999959 0 0 0 0 0 0
$definebone "MagLeft" "BaseLeftMesh" 0.084803 -0.018744 1.059231 -0.000001 -0.000002 0.000008 0 0 0 0 0 0
$definebone "BulletLeft.001" "MagLeft" -0.051861 0 0.223939 -0.000001 -0.000002 0.000008 0 0 0 0 0 0
$definebone "BulletLeft.002" "MagLeft" -0.011209 0 -0.207645 -0.000001 -0.000002 0.000008 0 0 0 0 0 0
$definebone "BulletLeft.003" "MagLeft" 0.033796 0 -0.691233 -0.000001 -0.000002 0.000008 0 0 0 0 0 0
$definebone "BulletLeft.004" "MagLeft" 0.074449 0 -1.122816 -0.000001 -0.000002 0.000008 0 0 0 0 0 0
$definebone "BulletLeft.005" "MagLeft" 0.163633 0 -1.606586 -0.000001 -0.000002 0.000008 0 0 0 0 0 0
$definebone "BulletLeft.006" "MagLeft" 0.204287 0 -2.038168 -0.000001 -0.000002 0.000008 0 0 0 0 0 0
$definebone "BulletLeft.007" "MagLeft" 0.29347 0 -2.502462 -0.000001 -0.000002 0.000008 0 0 0 0 0 0
$definebone "BulletLeft.008" "MagLeft" 0.334123 0 -2.934046 -0.000001 -0.000002 0.000008 0 0 0 0 0 0
$definebone "HammerLeft" "BaseLeftMesh" 1.745955 -0.009689 0.758466 -0.000001 -0.000002 0.000008 0 0 0 0 0 0
$definebone "TriggerLeft" "BaseLeftMesh" -1.761923 -0.009688 0.390344 -0.000001 -0.000002 0.000008 0 0 0 0 0 0
$definebone "SlideLeft" "BaseLeftMesh" -1.187039 -0.009689 1.460379 -0.000001 -0.000002 0.000008 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511806 0 0.000003 0.000292 0.000417 -13.510174 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.196849 0.000002 0 0.000854 -0.000125 -19.951826 0 0 0 0 0 0
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
	 "Hammer" 0
	 "Trigger" 0
	 "Slide" 0
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
	 "BulletLeft.001" 0
	 "BulletLeft.002" 0
	 "BulletLeft.003" 0
	 "BulletLeft.004" 0
	 "BulletLeft.005" 0
	 "BulletLeft.006" 0
	 "BulletLeft.007" 0
	 "BulletLeft.008" 0
	 "HammerLeft" 0
	 "TriggerLeft" 0
	 "SlideLeft" 0
	 "lowerarm_twist_01_l" 1
	 "upperarm_twist_01_l" 1
	 "cam_driver" 1
}

$animation "BothEmpty_corrective_animation" "v_dual_pb_anims\BothEmpty_corrective_animation.smd" {
}

$animation "RightEmpty_corrective_animation" "v_dual_pb_anims\RightEmpty_corrective_animation.smd" {
}

$animation "DefaultSlide_corrective_animation" "v_dual_pb_anims\DefaultSlide_corrective_animation.smd" {
}

$animation "Bullet16_corrective_animation" "v_dual_pb_anims\Bullet16_corrective_animation.smd" {
}

$animation "Bullet15_corrective_animation" "v_dual_pb_anims\Bullet15_corrective_animation.smd" {
}

$animation "Bullet14_corrective_animation" "v_dual_pb_anims\Bullet14_corrective_animation.smd" {
}

$animation "Bullet13_corrective_animation" "v_dual_pb_anims\Bullet13_corrective_animation.smd" {
}

$animation "Bullet12_corrective_animation" "v_dual_pb_anims\Bullet12_corrective_animation.smd" {
}

$animation "Bullet11_corrective_animation" "v_dual_pb_anims\Bullet11_corrective_animation.smd" {
}

$animation "Bullet10_corrective_animation" "v_dual_pb_anims\Bullet10_corrective_animation.smd" {
}

$animation "Bullet09_corrective_animation" "v_dual_pb_anims\Bullet09_corrective_animation.smd" {
}

$animation "Bullet08_corrective_animation" "v_dual_pb_anims\Bullet08_corrective_animation.smd" {
}

$animation "Bullet07_corrective_animation" "v_dual_pb_anims\Bullet07_corrective_animation.smd" {
}

$animation "Bullet06_corrective_animation" "v_dual_pb_anims\Bullet06_corrective_animation.smd" {
}

$animation "Bullet05_corrective_animation" "v_dual_pb_anims\Bullet05_corrective_animation.smd" {
}

$animation "Bullet04_corrective_animation" "v_dual_pb_anims\Bullet04_corrective_animation.smd" {
}

$animation "Bullet03_corrective_animation" "v_dual_pb_anims\Bullet03_corrective_animation.smd" {
}

$animation "Bullet02_corrective_animation" "v_dual_pb_anims\Bullet02_corrective_animation.smd" {
}

$animation "Bullet01_corrective_animation" "v_dual_pb_anims\Bullet01_corrective_animation.smd" {
}

$animation "Default_corrective_animation" "v_dual_pb_anims\Default_corrective_animation.smd" {
}

$animation "runIdle_a_corrective_animation" "v_dual_pb_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_dual_pb_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_dual_pb_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_dual_pb_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_r_a_corrective_animation" "v_dual_pb_anims\shoot1_r_a_corrective_animation.smd" {
}

$animation "shoot1_r_ironsight_a_corrective_animation" "v_dual_pb_anims\shoot1_r_ironsight_a_corrective_animation.smd" {
}

$animation "shoot1_l_a_corrective_animation" "v_dual_pb_anims\shoot1_l_a_corrective_animation.smd" {
}

$animation "shoot1_l_ironsight_a_corrective_animation" "v_dual_pb_anims\shoot1_l_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_r_a_corrective_animation" "v_dual_pb_anims\shoot2_r_a_corrective_animation.smd" {
}

$animation "shoot2_r_ironsight_a_corrective_animation" "v_dual_pb_anims\shoot2_r_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_l_a_corrective_animation" "v_dual_pb_anims\shoot2_l_a_corrective_animation.smd" {
}

$animation "shoot2_l_ironsight_a_corrective_animation" "v_dual_pb_anims\shoot2_l_ironsight_a_corrective_animation.smd" {
}

$animation "shootlast_r_a_corrective_animation" "v_dual_pb_anims\shootlast_r_a_corrective_animation.smd" {
}

$animation "shootlast_r_ironsight_a_corrective_animation" "v_dual_pb_anims\shootlast_r_ironsight_a_corrective_animation.smd" {
}

$animation "shootlast_l_a_corrective_animation" "v_dual_pb_anims\shootlast_l_a_corrective_animation.smd" {
}

$animation "shootlast_l_ironsight_a_corrective_animation" "v_dual_pb_anims\shootlast_l_ironsight_a_corrective_animation.smd" {
}

$animation "PoseDelta" "v_dual_pb_anims\PoseDelta.smd" {
	fps 30
	
	
}

$animation "DefaultSlide" "v_dual_pb_anims\DefaultSlide.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "DefaultSlide_corrective_animation" 0
}

$animation "RightEmpty" "v_dual_pb_anims\RightEmpty.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "RightEmpty_corrective_animation" 0
}

$animation "BothEmpty" "v_dual_pb_anims\BothEmpty.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "BothEmpty_corrective_animation" 0
}

$animation "Default" "v_dual_pb_anims\Default.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Default_corrective_animation" 0
}

$animation "Bullet01" "v_dual_pb_anims\Bullet01.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet01_corrective_animation" 0
}

$animation "Bullet02" "v_dual_pb_anims\Bullet02.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet02_corrective_animation" 0
}

$animation "Bullet03" "v_dual_pb_anims\Bullet03.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet03_corrective_animation" 0
}

$animation "Bullet04" "v_dual_pb_anims\Bullet04.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet04_corrective_animation" 0
}

$animation "Bullet05" "v_dual_pb_anims\Bullet05.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet05_corrective_animation" 0
}

$animation "Bullet06" "v_dual_pb_anims\Bullet06.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet06_corrective_animation" 0
}

$animation "Bullet07" "v_dual_pb_anims\Bullet07.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet07_corrective_animation" 0
}

$animation "Bullet08" "v_dual_pb_anims\Bullet08.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet08_corrective_animation" 0
}

$animation "Bullet09" "v_dual_pb_anims\Bullet09.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet09_corrective_animation" 0
}

$animation "Bullet10" "v_dual_pb_anims\Bullet10.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet10_corrective_animation" 0
}

$animation "Bullet11" "v_dual_pb_anims\Bullet11.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet11_corrective_animation" 0
}

$animation "Bullet12" "v_dual_pb_anims\Bullet12.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet12_corrective_animation" 0
}

$animation "Bullet13" "v_dual_pb_anims\Bullet13.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet13_corrective_animation" 0
}

$animation "Bullet14" "v_dual_pb_anims\Bullet14.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet14_corrective_animation" 0
}

$animation "Bullet15" "v_dual_pb_anims\Bullet15.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet15_corrective_animation" 0
}

$animation "Bullet16" "v_dual_pb_anims\Bullet16.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet16_corrective_animation" 0
}

$animation "basePose_a" "v_dual_pb_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "ironsight" "v_dual_pb_anims\ironsight.smd" {
	fps 30
	frame 0 1
	numframes 60
	
	
}

$animation "ironsight_transition" "v_dual_pb_anims\ironsight_transition.smd" {
	fps 30
	frame 0 1
	numframes 60
	
	
}

$animation "runIdle_a" "v_dual_pb_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	weightlist "weights_runlayer"
}

$animation "run_a" "v_dual_pb_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	weightlist "weights_runlayer"
}

$animation "walkIdle_a" "v_dual_pb_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	weightlist "weights_runlayer"
}

$animation "walk_a" "v_dual_pb_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	weightlist "weights_runlayer"
}

$animation "FirstDraw_a" "v_dual_pb_anims\FirstDraw_a.smd" {
	fps 30
	
	
}

$animation "FirstDraw_a_i" "v_dual_pb_anims\FirstDraw_a_i.smd" {
	fps 30
	
	
}

$animation "shoot1_r_a" "v_dual_pb_anims\shoot1_r_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_r_a_corrective_animation" 0
}

$animation "shoot1_r_ironsight_a" "v_dual_pb_anims\shoot1_r_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_r_ironsight_a_corrective_animation" 0
}

$animation "shoot1_l_a" "v_dual_pb_anims\shoot1_l_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_l_a_corrective_animation" 0
}

$animation "shoot1_l_ironsight_a" "v_dual_pb_anims\shoot1_l_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_l_ironsight_a_corrective_animation" 0
}

$animation "shoot2_r_a" "v_dual_pb_anims\shoot2_r_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_r_a_corrective_animation" 0
}

$animation "shoot2_r_ironsight_a" "v_dual_pb_anims\shoot2_r_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_r_ironsight_a_corrective_animation" 0
}

$animation "shoot2_l_a" "v_dual_pb_anims\shoot2_l_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_l_a_corrective_animation" 0
}

$animation "shoot2_l_ironsight_a" "v_dual_pb_anims\shoot2_l_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_l_ironsight_a_corrective_animation" 0
}

$animation "shootlast_r_a" "v_dual_pb_anims\shootlast_r_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_r_a_corrective_animation" 0
}

$animation "shootlast_r_ironsight_a" "v_dual_pb_anims\shootlast_r_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_r_ironsight_a_corrective_animation" 0
}

$animation "shootlast_l_a" "v_dual_pb_anims\shootlast_l_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_l_a_corrective_animation" 0
}

$animation "shootlast_l_ironsight_a" "v_dual_pb_anims\shootlast_l_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_l_ironsight_a_corrective_animation" 0
}

$animation "reload_a" "v_dual_pb_anims\reload_a.smd" {
	fps 30
	
	
}

$animation "reload_a_i" "v_dual_pb_anims\reload_a_i.smd" {
	fps 30
	
	
}

$animation "reload_r_a" "v_dual_pb_anims\reload_r_a.smd" {
	fps 30
	
	
}

$animation "reload_r_a_i" "v_dual_pb_anims\reload_r_a_i.smd" {
	fps 30
	
	
}

$animation "reload_re_a" "v_dual_pb_anims\reload_re_a.smd" {
	fps 30
	
	
}

$animation "reload_re_a_i" "v_dual_pb_anims\reload_re_a_i.smd" {
	fps 30
	
	
}

$animation "reload_e_a" "v_dual_pb_anims\reload_e_a.smd" {
	fps 30
	
	
}

$animation "reload_e_a_i" "v_dual_pb_anims\reload_e_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a" "v_dual_pb_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_dual_pb_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_dual_pb_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_dual_pb_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_dual_pb_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_dual_pb_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "proneF" "v_dual_pb_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_dual_pb_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_dual_pb_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_dual_pb_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_dual_pb_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_dual_pb_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_dual_pb_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_dual_pb_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_dual_pb_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_dual_pb_anims\pickup_e_a_i.smd" {
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
	"v_dual_pb_anims\draw.smd"
	"v_dual_pb_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_PB.Draw" }
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
	{ event 5004 1 "MCV_Weapon_Foley_PB.Draw" }
	{ event 5004 9 "MCV_Weapon_Foley_PB.DrawMetal" }
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
	{ event 5004 1 "MCV_Weapon_Foley_PB_ShootLast.Metal" }
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
	{ event 5004 1 "MCV_Weapon_Foley_PB_ShootLast.Metal" }
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
	{ event 5004 1 "MCV_Weapon_Foley_PB_Reload.Hand" }
	{ event 5004 12 "MCV_Weapon_Foley_PB_Reload.MagOut_Dual" }
	{ event 5004 45 "MCV_Weapon_Foley_PB_Reload.MagIn_Dual" }
	{ event 5004 55 "MCV_Weapon_Foley_PB_Reload.HandEnd" }
	{ event 5004 60 "MCV_Weapon_Foley_PB_Reload.Hand" }
	{ event 5004 70 "MCV_Weapon_Foley_PB_Reload.MagOut_Dual" }
	{ event 5004 105 "MCV_Weapon_Foley_PB_Reload.MagIn_Dual" }
	{ event 5004 120 "MCV_Weapon_Foley_PB_Reload.HandEnd" }
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
	{ event 5004 1 "MCV_Weapon_Foley_PB_Reload.Hand" }
	{ event 5004 12 "MCV_Weapon_Foley_PB_Reload.MagOut_Dual" }
	{ event 5004 45 "MCV_Weapon_Foley_PB_Reload.MagIn_Dual" }
	{ event 5004 55 "MCV_Weapon_Foley_PB_Reload.HandEnd" }
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
	{ event 5004 1 "MCV_Weapon_Foley_PB_Reload.Hand" }
	{ event 5004 12 "MCV_Weapon_Foley_PB_Reload.MagOut_Dual" }
	{ event 5004 45 "MCV_Weapon_Foley_PB_Reload.MagIn_Dual" }
	{ event 5004 70 "MCV_Weapon_Foley_PB_Reload.Metal_Dual" }
	{ event 5004 80 "MCV_Weapon_Foley_PB_Reload.HandEnd" }
	{ event 5004 85 "MCV_Weapon_Foley_PB_Reload.Hand" }
	{ event 5004 98 "MCV_Weapon_Foley_PB_Reload.MagOut_Dual" }
	{ event 5004 132 "MCV_Weapon_Foley_PB_Reload.MagIn_Dual" }
	{ event 5004 148 "MCV_Weapon_Foley_PB_Reload.HandEnd" }
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
	{ event 5004 1 "MCV_Weapon_Foley_PB_Reload.Hand" }
	{ event 5004 12 "MCV_Weapon_Foley_PB_Reload.MagOut_Dual" }
	{ event 5004 45 "MCV_Weapon_Foley_PB_Reload.MagIn_Dual" }
	{ event 5004 70 "MCV_Weapon_Foley_PB_Reload.Metal_Dual" }
	{ event 5004 80 "MCV_Weapon_Foley_PB_Reload.HandEnd" }
	{ event 5004 85 "MCV_Weapon_Foley_PB_Reload.Hand" }
	{ event 5004 98 "MCV_Weapon_Foley_PB_Reload.MagOut_Dual" }
	{ event 5004 132 "MCV_Weapon_Foley_PB_Reload.MagIn_Dual" }
	{ event 5004 154 "MCV_Weapon_Foley_PB_Reload.Metal_Dual" }
	{ event 5004 160 "MCV_Weapon_Foley_PB_Reload.HandEnd" }
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
	"v_dual_pb_anims\bash.smd"
	"v_dual_pb_anims\bash_2.smd"
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
	"v_dual_pb_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 1 "MCV_Weapon_Foley_PM.Holster" }
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
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\dualpistol_pmpb\dualPB.qc"
//	}
}

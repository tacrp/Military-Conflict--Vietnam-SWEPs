// Created by Crowbar 0.74

$modelname "weapons/mcv/v_dual_type67.mdl"

$bodygroup "studioRight"
{
	studio "DualType67.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition 6.747 -9.379 -7.672

$cdmaterials "models\weapons\mcv\v_type67\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "BaseMesh" -8.3 0 2.13 rotate 0 -180 0
$attachment "eject" "BaseMesh" -0.5 0 1.6 rotate -20 90 0
$attachment "muzzle2" "BaseLeftMesh" -8.3 0 2.13 rotate 0 -180 0
$attachment "eject2" "BaseLeftMesh" -0.5 0 1.6 rotate -20 90 0

$cbox 0 0 0 0 0 0

$bbox -10.063 -29.38 -27.51 28.821 42.875 12.166

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
$definebone "BaseMesh" "hand_r" 19.317551 11.579793 25.524105 75.00019 90.00548 0.004232 0 0 0 0 0 0
$definebone "Mag" "BaseMesh" 0.084805 -0.018744 1.059229 0.00012 0 -0.000009 0 0 0 0 0 0
$definebone "Bullet.001" "Mag" -0.051861 0 0.223938 0.000005 0 -0.000009 0 0 0 0 0 0
$definebone "Bullet.002" "Mag" -0.011209 0 -0.207644 0.000005 0 -0.000009 0 0 0 0 0 0
$definebone "Bullet.003" "Mag" 0.033795 0 -0.691232 0.000005 0 -0.000009 0 0 0 0 0 0
$definebone "Bullet.004" "Mag" 0.074449 -0.000001 -1.122813 0.000005 0 -0.000009 0 0 0 0 0 0
$definebone "Bullet.005" "Mag" 0.163631 -0.000001 -1.606582 0.000005 0 -0.000009 0 0 0 0 0 0
$definebone "Bullet.006" "Mag" 0.204285 -0.000001 -2.038164 0.000005 0 -0.000009 0 0 0 0 0 0
$definebone "Bullet.007" "Mag" 0.293468 -0.000001 -2.502457 0.000005 0 -0.000009 0 0 0 0 0 0
$definebone "Bullet.008" "Mag" 0.334122 -0.000002 -2.934039 0.000005 0 -0.000009 0 0 0 0 0 0
$definebone "Pusher" "Mag" -0.276662 0.000001 0.113848 0.000005 0 -0.000009 0 0 0 0 0 0
$definebone "Hammer" "BaseMesh" 2.010009 -0.00969 0.338714 0.00012 0 -0.000009 0 0 0 0 0 0
$definebone "Trigger" "BaseMesh" -1.56103 -0.009689 0.390344 0.00012 0 -0.000009 0 0 0 0 0 0
$definebone "Slide" "BaseMesh" 0.581642 -0.009688 1.460375 0.00012 0 -0.000009 0 0 0 0 0 0
$definebone "rhand_ikTarget" "BaseMesh" 9.739622 8.158659 -1.684319 0.00012 0 -0.000009 0 0 0 0 0 0
$definebone "LHand_IKtarget" "BaseMesh" 8.321308 -5.924521 -1.447658 0.00012 -0.000057 -0.000009 0 0 0 0 0 0
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
$definebone "BaseLeftMesh" "hand_l" -20.289328 -11.579246 -25.524536 -75.000046 -90.000631 -179.999336 0 0 0 0 0 0
$definebone "MagLeft" "BaseLeftMesh" 0.084803 -0.018744 1.059232 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "BulletLeft.001" "MagLeft" -0.05186 0 0.223938 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "BulletLeft.002" "MagLeft" -0.011209 0 -0.207645 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "BulletLeft.003" "MagLeft" 0.033796 0 -0.691233 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "BulletLeft.004" "MagLeft" 0.074449 0 -1.122816 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "BulletLeft.005" "MagLeft" 0.163633 0 -1.606585 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "BulletLeft.006" "MagLeft" 0.204287 0 -2.038168 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "BulletLeft.007" "MagLeft" 0.29347 0 -2.502461 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "BulletLeft.008" "MagLeft" 0.334124 0 -2.934044 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "PusherLeft" "MagLeft" -0.276662 0 0.113848 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "HammerLeft" "BaseLeftMesh" 2.01001 -0.009689 0.338717 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "TriggerLeft" "BaseLeftMesh" -1.561028 -0.009689 0.390344 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
$definebone "SlideLeft" "BaseLeftMesh" 0.581644 -0.009689 1.46038 -0.000001 -0.000002 0.000014 0 0 0 0 0 0
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


$sectionframes 30 30

$poseparameter "ammo_fraction" 0 0.125 loop 0
$poseparameter "ammo_fraction1" 0 1 loop 0
$poseparameter "ammo_fraction2" 0 1 loop 0
$poseparameter "player_movement" 0 260 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$weightlist "weights_BulletCounterRight" {
	 "root" 0
	 "pelvis" 0
	 "spine_01" 0
	 "spine_02" 0
	 "spine_03" 0
	 "clavicle_r" 0
	 "upperarm_r" 0
	 "lowerarm_r" 0
	 "hand_r" 0
	 "index_01_r" 0
	 "index_02_r" 0
	 "index_03_r" 0
	 "middle_01_r" 0
	 "middle_02_r" 0
	 "middle_03_r" 0
	 "pinky_01_r" 0
	 "pinky_02_r" 0
	 "pinky_03_r" 0
	 "ring_01_r" 0
	 "ring_02_r" 0
	 "ring_03_r" 0
	 "thumb_01_r" 0
	 "thumb_02_r" 0
	 "thumb_03_r" 0
	 "BaseMesh" 1
	 "Mag" 1
	 "Bullet.001" 1
	 "Bullet.002" 1
	 "Bullet.003" 1
	 "Bullet.004" 1
	 "Bullet.005" 1
	 "Bullet.006" 1
	 "Bullet.007" 1
	 "Bullet.008" 1
	 "Pusher" 1
	 "Hammer" 1
	 "Trigger" 1
	 "Slide" 1
	 "rhand_ikTarget" 1
	 "LHand_IKtarget" 1
	 "lowerarm_twist_01_r" 0
	 "upperarm_twist_01_r" 0
	 "clavicle_l" 0
	 "upperarm_l" 0
	 "lowerarm_l" 0
	 "hand_l" 0
	 "index_01_l" 0
	 "index_02_l" 0
	 "index_03_l" 0
	 "middle_01_l" 0
	 "middle_02_l" 0
	 "middle_03_l" 0
	 "pinky_01_l" 0
	 "pinky_02_l" 0
	 "pinky_03_l" 0
	 "ring_01_l" 0
	 "ring_02_l" 0
	 "ring_03_l" 0
	 "thumb_01_l" 0
	 "thumb_02_l" 0
	 "thumb_03_l" 0
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
	 "HammerLeft" 0
	 "TriggerLeft" 0
	 "SlideLeft" 0
	 "lowerarm_twist_01_l" 0
	 "upperarm_twist_01_l" 0
	 "cam_driver" 0
}

$weightlist "weights_BulletCounterLeft" {
	 "root" 0
	 "pelvis" 0
	 "spine_01" 0
	 "spine_02" 0
	 "spine_03" 0
	 "clavicle_r" 0
	 "upperarm_r" 0
	 "lowerarm_r" 0
	 "hand_r" 0
	 "index_01_r" 0
	 "index_02_r" 0
	 "index_03_r" 0
	 "middle_01_r" 0
	 "middle_02_r" 0
	 "middle_03_r" 0
	 "pinky_01_r" 0
	 "pinky_02_r" 0
	 "pinky_03_r" 0
	 "ring_01_r" 0
	 "ring_02_r" 0
	 "ring_03_r" 0
	 "thumb_01_r" 0
	 "thumb_02_r" 0
	 "thumb_03_r" 0
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
	 "Hammer" 0
	 "Trigger" 0
	 "Slide" 0
	 "rhand_ikTarget" 0
	 "LHand_IKtarget" 0
	 "lowerarm_twist_01_r" 0
	 "upperarm_twist_01_r" 0
	 "clavicle_l" 0
	 "upperarm_l" 0
	 "lowerarm_l" 0
	 "hand_l" 0
	 "index_01_l" 0
	 "index_02_l" 0
	 "index_03_l" 0
	 "middle_01_l" 0
	 "middle_02_l" 0
	 "middle_03_l" 0
	 "pinky_01_l" 0
	 "pinky_02_l" 0
	 "pinky_03_l" 0
	 "ring_01_l" 0
	 "ring_02_l" 0
	 "ring_03_l" 0
	 "thumb_01_l" 0
	 "thumb_02_l" 0
	 "thumb_03_l" 0
	 "BaseLeftMesh" 1
	 "MagLeft" 1
	 "BulletLeft.001" 1
	 "BulletLeft.002" 1
	 "BulletLeft.003" 1
	 "BulletLeft.004" 1
	 "BulletLeft.005" 1
	 "BulletLeft.006" 1
	 "BulletLeft.007" 1
	 "BulletLeft.008" 1
	 "PusherLeft" 1
	 "HammerLeft" 1
	 "TriggerLeft" 1
	 "SlideLeft" 1
	 "lowerarm_twist_01_l" 0
	 "upperarm_twist_01_l" 0
	 "cam_driver" 0
}

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
	 "PusherLeft" 0
	 "HammerLeft" 0
	 "TriggerLeft" 0
	 "SlideLeft" 0
	 "lowerarm_twist_01_l" 1
	 "upperarm_twist_01_l" 1
	 "cam_driver" 1
}

$animation "BothEmpty_corrective_animation" "v_dual_type67_anims\BothEmpty_corrective_animation.smd" {
}

$animation "RightEmpty_corrective_animation" "v_dual_type67_anims\RightEmpty_corrective_animation.smd" {
}

$animation "DefaultSlide_corrective_animation" "v_dual_type67_anims\DefaultSlide_corrective_animation.smd" {
}

$animation "Bullet15_corrective_animation" "v_dual_type67_anims\Bullet15_corrective_animation.smd" {
}

$animation "Bullet13_corrective_animation" "v_dual_type67_anims\Bullet13_corrective_animation.smd" {
}

$animation "Bullet11_corrective_animation" "v_dual_type67_anims\Bullet11_corrective_animation.smd" {
}

$animation "Bullet09_corrective_animation" "v_dual_type67_anims\Bullet09_corrective_animation.smd" {
}

$animation "Bullet07_corrective_animation" "v_dual_type67_anims\Bullet07_corrective_animation.smd" {
}

$animation "Bullet05_corrective_animation" "v_dual_type67_anims\Bullet05_corrective_animation.smd" {
}

$animation "Bullet03_corrective_animation" "v_dual_type67_anims\Bullet03_corrective_animation.smd" {
}

$animation "Bullet01_corrective_animation" "v_dual_type67_anims\Bullet01_corrective_animation.smd" {
}

$animation "Default_corrective_animation" "v_dual_type67_anims\Default_corrective_animation.smd" {
}

$animation "Bullet16_corrective_animation" "v_dual_type67_anims\Bullet16_corrective_animation.smd" {
}

$animation "Bullet14_corrective_animation" "v_dual_type67_anims\Bullet14_corrective_animation.smd" {
}

$animation "Bullet12_corrective_animation" "v_dual_type67_anims\Bullet12_corrective_animation.smd" {
}

$animation "Bullet10_corrective_animation" "v_dual_type67_anims\Bullet10_corrective_animation.smd" {
}

$animation "Bullet08_corrective_animation" "v_dual_type67_anims\Bullet08_corrective_animation.smd" {
}

$animation "Bullet06_corrective_animation" "v_dual_type67_anims\Bullet06_corrective_animation.smd" {
}

$animation "Bullet04_corrective_animation" "v_dual_type67_anims\Bullet04_corrective_animation.smd" {
}

$animation "Bullet02_corrective_animation" "v_dual_type67_anims\Bullet02_corrective_animation.smd" {
}

$animation "DefaultLeft_corrective_animation" "v_dual_type67_anims\DefaultLeft_corrective_animation.smd" {
}

$animation "runIdle_a_corrective_animation" "v_dual_type67_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_dual_type67_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_dual_type67_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_dual_type67_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_r_a_corrective_animation" "v_dual_type67_anims\shoot1_r_a_corrective_animation.smd" {
}

$animation "shoot1_r_ironsight_a_corrective_animation" "v_dual_type67_anims\shoot1_r_ironsight_a_corrective_animation.smd" {
}

$animation "shoot1_l_a_corrective_animation" "v_dual_type67_anims\shoot1_l_a_corrective_animation.smd" {
}

$animation "shoot1_l_ironsight_a_corrective_animation" "v_dual_type67_anims\shoot1_l_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_r_a_corrective_animation" "v_dual_type67_anims\shoot2_r_a_corrective_animation.smd" {
}

$animation "shoot2_r_ironsight_a_corrective_animation" "v_dual_type67_anims\shoot2_r_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_l_a_corrective_animation" "v_dual_type67_anims\shoot2_l_a_corrective_animation.smd" {
}

$animation "shoot2_l_ironsight_a_corrective_animation" "v_dual_type67_anims\shoot2_l_ironsight_a_corrective_animation.smd" {
}

$animation "shootlast_r_a_corrective_animation" "v_dual_type67_anims\shootlast_r_a_corrective_animation.smd" {
}

$animation "shootlast_r_ironsight_a_corrective_animation" "v_dual_type67_anims\shootlast_r_ironsight_a_corrective_animation.smd" {
}

$animation "shootlast_l_a_corrective_animation" "v_dual_type67_anims\shootlast_l_a_corrective_animation.smd" {
}

$animation "shootlast_l_ironsight_a_corrective_animation" "v_dual_type67_anims\shootlast_l_ironsight_a_corrective_animation.smd" {
}

$animation "PoseDelta" "v_dual_type67_anims\PoseDelta.smd" {
	fps 30
	
	
}

$animation "DefaultSlide" "v_dual_type67_anims\DefaultSlide.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "DefaultSlide_corrective_animation" 0
}

$animation "RightEmpty" "v_dual_type67_anims\RightEmpty.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "RightEmpty_corrective_animation" 0
}

$animation "BothEmpty" "v_dual_type67_anims\BothEmpty.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "BothEmpty_corrective_animation" 0
}

$animation "Default" "v_dual_type67_anims\Default.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Default_corrective_animation" 0
	weightlist "weights_BulletCounterRight"
}

$animation "Bullet01" "v_dual_type67_anims\Bullet01.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet01_corrective_animation" 0
	weightlist "weights_BulletCounterRight"
}

$animation "Bullet03" "v_dual_type67_anims\Bullet03.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet03_corrective_animation" 0
	weightlist "weights_BulletCounterRight"
}

$animation "Bullet05" "v_dual_type67_anims\Bullet05.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet05_corrective_animation" 0
	weightlist "weights_BulletCounterRight"
}

$animation "Bullet07" "v_dual_type67_anims\Bullet07.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet07_corrective_animation" 0
	weightlist "weights_BulletCounterRight"
}

$animation "Bullet09" "v_dual_type67_anims\Bullet09.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet09_corrective_animation" 0
	weightlist "weights_BulletCounterRight"
}

$animation "Bullet11" "v_dual_type67_anims\Bullet11.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet11_corrective_animation" 0
	weightlist "weights_BulletCounterRight"
}

$animation "Bullet13" "v_dual_type67_anims\Bullet13.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet13_corrective_animation" 0
	weightlist "weights_BulletCounterRight"
}

$animation "Bullet15" "v_dual_type67_anims\Bullet15.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet15_corrective_animation" 0
	weightlist "weights_BulletCounterRight"
}

$animation "DefaultLeft" "v_dual_type67_anims\DefaultLeft.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "DefaultLeft_corrective_animation" 0
	weightlist "weights_BulletCounterLeft"
}

$animation "Bullet02" "v_dual_type67_anims\Bullet02.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet02_corrective_animation" 0
	weightlist "weights_BulletCounterLeft"
}

$animation "Bullet04" "v_dual_type67_anims\Bullet04.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet04_corrective_animation" 0
	weightlist "weights_BulletCounterLeft"
}

$animation "Bullet06" "v_dual_type67_anims\Bullet06.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet06_corrective_animation" 0
	weightlist "weights_BulletCounterLeft"
}

$animation "Bullet08" "v_dual_type67_anims\Bullet08.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet08_corrective_animation" 0
	weightlist "weights_BulletCounterLeft"
}

$animation "Bullet10" "v_dual_type67_anims\Bullet10.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet10_corrective_animation" 0
	weightlist "weights_BulletCounterLeft"
}

$animation "Bullet12" "v_dual_type67_anims\Bullet12.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet12_corrective_animation" 0
	weightlist "weights_BulletCounterLeft"
}

$animation "Bullet14" "v_dual_type67_anims\Bullet14.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet14_corrective_animation" 0
	weightlist "weights_BulletCounterLeft"
}

$animation "Bullet16" "v_dual_type67_anims\Bullet16.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet16_corrective_animation" 0
	weightlist "weights_BulletCounterLeft"
}

$animation "basePose_a" "v_dual_type67_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "ironsight" "v_dual_type67_anims\ironsight.smd" {
	fps 0.5
	
	
}

$animation "ironsight_transition" "v_dual_type67_anims\ironsight_transition.smd" {
	fps 0.5
	
	
}

$animation "runIdle_a" "v_dual_type67_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	weightlist "weights_runlayer"
}

$animation "run_a" "v_dual_type67_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	weightlist "weights_runlayer"
}

$animation "walkIdle_a" "v_dual_type67_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	weightlist "weights_runlayer"
}

$animation "walk_a" "v_dual_type67_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	weightlist "weights_runlayer"
}

$animation "FirstDraw_a" "v_dual_type67_anims\FirstDraw_a.smd" {
	fps 30
	
	
}

$animation "FirstDraw_a_i" "v_dual_type67_anims\FirstDraw_a_i.smd" {
	fps 30
	
	
}

$animation "shoot1_r_a" "v_dual_type67_anims\shoot1_r_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_r_a_corrective_animation" 0
}

$animation "shoot1_r_ironsight_a" "v_dual_type67_anims\shoot1_r_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_r_ironsight_a_corrective_animation" 0
}

$animation "shoot1_l_a" "v_dual_type67_anims\shoot1_l_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_l_a_corrective_animation" 0
}

$animation "shoot1_l_ironsight_a" "v_dual_type67_anims\shoot1_l_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_l_ironsight_a_corrective_animation" 0
}

$animation "shoot2_r_a" "v_dual_type67_anims\shoot2_r_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_r_a_corrective_animation" 0
}

$animation "shoot2_r_ironsight_a" "v_dual_type67_anims\shoot2_r_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_r_ironsight_a_corrective_animation" 0
}

$animation "shoot2_l_a" "v_dual_type67_anims\shoot2_l_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_l_a_corrective_animation" 0
}

$animation "shoot2_l_ironsight_a" "v_dual_type67_anims\shoot2_l_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_l_ironsight_a_corrective_animation" 0
}

$animation "shootlast_r_a" "v_dual_type67_anims\shootlast_r_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_r_a_corrective_animation" 0
}

$animation "shootlast_r_ironsight_a" "v_dual_type67_anims\shootlast_r_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_r_ironsight_a_corrective_animation" 0
}

$animation "shootlast_l_a" "v_dual_type67_anims\shootlast_l_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_l_a_corrective_animation" 0
}

$animation "shootlast_l_ironsight_a" "v_dual_type67_anims\shootlast_l_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_l_ironsight_a_corrective_animation" 0
}

$animation "reload_a" "v_dual_type67_anims\reload_a.smd" {
	fps 30
	
	
}

$animation "reload_a_i" "v_dual_type67_anims\reload_a_i.smd" {
	fps 30
	
	
}

$animation "reload_ra" "v_dual_type67_anims\reload_ra.smd" {
	fps 30
	
	
}

$animation "reload_ra_i" "v_dual_type67_anims\reload_ra_i.smd" {
	fps 30
	
	
}

$animation "reload_er_a" "v_dual_type67_anims\reload_er_a.smd" {
	fps 30
	
	
}

$animation "reload_er_a_i" "v_dual_type67_anims\reload_er_a_i.smd" {
	fps 30
	
	
}

$animation "reload_e_a" "v_dual_type67_anims\reload_e_a.smd" {
	fps 30
	
	
}

$animation "reload_e_a_i" "v_dual_type67_anims\reload_e_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a" "v_dual_type67_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_dual_type67_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_dual_type67_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_dual_type67_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_dual_type67_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_dual_type67_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "proneF" "v_dual_type67_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_dual_type67_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_dual_type67_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_dual_type67_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_dual_type67_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_dual_type67_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_dual_type67_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_dual_type67_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_dual_type67_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_dual_type67_anims\pickup_e_a_i.smd" {
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

$sequence "BulletCounterRight" {
	"Bullet15"
	"Bullet13"
	"Bullet11"
	"Bullet09"
	"Bullet07"
	"Bullet05"
	"Bullet03"
	"Bullet01"
	"Default"
	blend "ammo_fraction1" 0 1
	blendwidth 9
	delta
	fadein 0.2
	fadeout 0.2
	hidden
	node "0"
}

$sequence "BulletCounterLeft" {
	"Bullet16"
	"Bullet14"
	"Bullet12"
	"Bullet10"
	"Bullet08"
	"Bullet06"
	"Bullet04"
	"Bullet02"
	"DefaultLeft"
	blend "ammo_fraction2" 0 1
	blendwidth 9
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
	addlayer "BulletCounterRight"
	addlayer "BulletCounterLeft"
	node "0"
}

$sequence "draw" {
	"v_dual_type67_anims\draw.smd"
	"v_dual_type67_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Type67.Draw" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction1" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction2" }
	fadein 0
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "BulletCounterRight"
	addlayer "BulletCounterLeft"
	node "0"
	fps 30
	  
	
}

$sequence "Firstdraw" {
	"FirstDraw_a"
	"FirstDraw_a_i"
	activity "ACT_VM_FIRSTDRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Type67.Draw" }
	{ event 5004 6 "MCV_Weapon_Foley_Type67.DrawMetal" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction1" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction2" }
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
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction1" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction2" }
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
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction1" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction2" }
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
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction1" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction2" }
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
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction1" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction2" }
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
	{ event 5004 1 "MCV_Weapon_Foley_Type67_ShootLast.Metal" }
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	{ event AE_MUZZLEFLASH 0 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction1" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction2" }
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
	{ event 5004 1 "MCV_Weapon_Foley_Type67_ShootLast.Metal" }
	{ event AE_CLIENT_EJECT_BRASS 0 "eject2" }
	{ event AE_MUZZLEFLASH 0 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction1" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction2" }
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
	{ event 5004 1 "MCV_Weapon_Foley_Type67_Reload.Hand" }
	{ event 5004 14 "MCV_Weapon_Foley_Type67_Reload.MagOut" }
	{ event 5004 40 "MCV_Weapon_Foley_Type67_Reload.MagIn" }
	{ event 5004 60 "MCV_Weapon_Foley_Type67_Reload.HandEnd" }
	{ event 5004 1 "MCV_Weapon_Foley_Type67_Reload.Hand" }
	{ event 5004 78 "MCV_Weapon_Foley_Type67_Reload.MagOut" }
	{ event 5004 110 "MCV_Weapon_Foley_Type67_Reload.MagIn_Dual" }
	{ event 5004 125 "MCV_Weapon_Foley_Type67_Reload.HandEnd" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 5 "ammo_fraction1" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 35 "ammo_fraction1" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 66 "ammo_fraction2" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 90 "ammo_fraction2" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 90 "ammo_fraction" }
	{ event AE_WPN_COMPLETE_RELOAD 123 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	addlayer "BulletCounterRight"
	addlayer "BulletCounterLeft"
	node "0"
}

$sequence "reloadRightOnly" {
	"reload_ra"
	"reload_ra_i"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Type67_Reload.Hand" }
	{ event 5004 14 "MCV_Weapon_Foley_Type67_Reload.MagOut" }
	{ event 5004 40 "MCV_Weapon_Foley_Type67_Reload.MagIn" }
	{ event 5004 60 "MCV_Weapon_Foley_Type67_Reload.HandEnd" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 5 "ammo_fraction1" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 35 "ammo_fraction1" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 35 "ammo_fraction" }
	{ event AE_WPN_COMPLETE_RELOAD 54 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	addlayer "BulletCounterRight"
	addlayer "BulletCounterLeft"
	node "0"
}

$sequence "reload_emptyRightOnly" {
	"reload_er_a"
	"reload_er_a_i"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Type67_Reload.Hand" }
	{ event 5004 14 "MCV_Weapon_Foley_Type67_Reload.MagOut" }
	{ event 5004 40 "MCV_Weapon_Foley_Type67_Reload.MagIn" }
	{ event 5004 68 "MCV_Weapon_Foley_Type67_Reload.Metal" }
	{ event 5004 80 "MCV_Weapon_Foley_Type67_Reload.HandEnd" }
	{ event 5004 90 "MCV_Weapon_Foley_Type67_Reload.Hand" }
	{ event 5004 95 "MCV_Weapon_Foley_Type67_Reload.MagOut" }
	{ event 5004 129 "MCV_Weapon_Foley_Type67_Reload.MagIn_Dual" }
	{ event 5004 145 "MCV_Weapon_Foley_Type67_Reload.HandEnd" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 5 "ammo_fraction1" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 35 "ammo_fraction1" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 90 "ammo_fraction2" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 120 "ammo_fraction2" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 120 "ammo_fraction" }
	{ event AE_WPN_COMPLETE_RELOAD 141 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	addlayer "BulletCounterRight"
	addlayer "BulletCounterLeft"
	node "0"
}

$sequence "reload_empty" {
	"reload_e_a"
	"reload_e_a_i"
	activity "ACT_VM_SECONDARY_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Type67_Reload.Hand" }
	{ event 5004 14 "MCV_Weapon_Foley_Type67_Reload.MagOut" }
	{ event 5004 40 "MCV_Weapon_Foley_Type67_Reload.MagIn" }
	{ event 5004 68 "MCV_Weapon_Foley_Type67_Reload.Metal" }
	{ event 5004 80 "MCV_Weapon_Foley_Type67_Reload.HandEnd" }
	{ event 5004 90 "MCV_Weapon_Foley_Type67_Reload.Hand" }
	{ event 5004 95 "MCV_Weapon_Foley_Type67_Reload.MagOut" }
	{ event 5004 129 "MCV_Weapon_Foley_Type67_Reload.MagIn_Dual" }
	{ event 5004 154 "MCV_Weapon_Foley_Type67_Reload.Metal" }
	{ event 5004 165 "MCV_Weapon_Foley_Type67_Reload.HandEnd" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 5 "ammo_fraction1" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 35 "ammo_fraction1" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 90 "ammo_fraction2" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 120 "ammo_fraction2" }
	{ event AE_WPN_COMPLETE_RELOAD 163 "" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 120 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	addlayer "BulletCounterRight"
	addlayer "BulletCounterLeft"
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
	addlayer "BulletCounterRight"
	addlayer "BulletCounterLeft"
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
	addlayer "BulletCounterRight"
	addlayer "BulletCounterLeft"
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
	addlayer "BulletCounterRight"
	addlayer "BulletCounterLeft"
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
	addlayer "BulletCounterRight"
	addlayer "BulletCounterLeft"
	realtime
}

$sequence "bash" {
	"v_dual_type67_anims\bash.smd"
	"v_dual_type67_anims\bash_2.smd"
	activity "ACT_VM_HITCENTER" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 3200 3 "" }
	{ event 5004 1 "MCV_Weapon_Foley_Bash.Fast" }
	fadein 0
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "BulletCounterRight"
	addlayer "BulletCounterLeft"
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
	addlayer "BulletCounterRight"
	addlayer "BulletCounterLeft"
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
	addlayer "BulletCounterRight"
	addlayer "BulletCounterLeft"
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
	addlayer "BulletCounterRight"
	addlayer "BulletCounterLeft"
	addlayer "walklayer"
}

$sequence "holster" {
	"v_dual_type67_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 1 "MCV_Weapon_Foley_Type67.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "BulletCounterRight"
	addlayer "BulletCounterLeft"
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\dualpistol_type67\dualType67.qc"
//	}
}

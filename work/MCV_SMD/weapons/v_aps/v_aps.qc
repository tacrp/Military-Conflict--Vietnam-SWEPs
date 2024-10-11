// Created by Crowbar 0.74

$modelname "weapons/mcv/v_aps.mdl"

$bodygroup "studio"
{
	studio "Ref_APS.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition -1.909 -9.006 -13.755

$cdmaterials "models\weapons\mcv\v_aps\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "muzzle" "Base" -7.3 0 1.3 rotate 0 180 0
$attachment "eject" "Base" -1.5 0.4 1.5 rotate -45 90 0
$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -9.182 -14.564 -27.51 27.193 10.745 0

$definebone "root" "" 0 7.450089 -27.509027 0 0 0 0 0 0 0 0 0
$definebone "pelvis" "root" -0.000002 0 0 -89.790623 -89.997175 89.997175 0 0 0 0 0 0
$definebone "spine_01" "pelvis" 4.255466 -0.335183 -0.000002 0 -7.153262 0 0 0 0 0 0 0
$definebone "spine_02" "spine_01" 7.43125 1.496479 0.000002 0 14.063249 0 0 0 0 0 0 0
$definebone "spine_03" "spine_02" 5.278479 0.165544 0.000001 0 2.779475 0 0 0 0 0 0 0
$definebone "clavicle_r" "spine_03" 4.678655 -1.075638 1.488977 66.457884 -74.414959 113.208733 0 0 0 0 0 0
$definebone "upperarm_r" "clavicle_r" -6.214478 -0.000009 -0.000026 -17.285778 100.610954 -158.881279 0 0 0 0 0 0
$definebone "lowerarm_r" "upperarm_r" 11.944889 0.000001 0 -17.318629 58.871477 -2.620276 0 0 0 0 0 0
$definebone "hand_r" "lowerarm_r" 10.620185 0.000001 0 -17.390541 154.858994 115.958184 0 0 0 0 0 0
$definebone "index_01_r" "hand_r" -4.75111 -0.694493 0.830576 -3.762676 25.538678 14.867225 0 0 0 0 0 0
$definebone "index_02_r" "index_01_r" -1.688068 0.000045 -0.000035 -0.475214 11.98611 1.337738 0 0 0 0 0 0
$definebone "index_03_r" "index_02_r" -1.336136 0.000056 -0.000012 0.996943 -9.496597 1.137547 0 0 0 0 0 0
$definebone "middle_01_r" "hand_r" -4.820498 -0.509459 -0.224759 -7.039535 22.827327 1.918091 0 0 0 0 0 0
$definebone "middle_02_r" "middle_01_r" -1.82699 -0.000065 0.000007 1.136744 12.280662 -2.025007 0 0 0 0 0 0
$definebone "middle_03_r" "middle_02_r" -1.436579 0.000012 0.000003 -4.389718 -15.399553 0.781568 0 0 0 0 0 0
$definebone "pinky_01_r" "hand_r" -3.992361 -0.891186 -1.827908 -18.932822 20.187425 -18.724433 0 0 0 0 0 0
$definebone "pinky_02_r" "pinky_01_r" -1.40592 -0.000024 -0.000004 -1.315573 11.208261 1.06387 0 0 0 0 0 0
$definebone "pinky_03_r" "pinky_02_r" -1.175362 0.000127 -0.00002 3.869409 1.038603 0.445648 0 0 0 0 0 0
$definebone "ring_01_r" "hand_r" -4.526754 -0.690574 -1.120743 -10.988245 23.293488 -13.509886 0 0 0 0 0 0
$definebone "ring_02_r" "ring_01_r" -1.744049 0.000036 -0.000008 -1.669886 13.315305 0.301261 0 0 0 0 0 0
$definebone "ring_03_r" "ring_02_r" -1.368765 0.000026 0.000006 2.987745 -12.899514 -0.360678 0 0 0 0 0 0
$definebone "thumb_01_r" "hand_r" -1.874802 -0.935125 0.999176 36.920246 27.057823 95.069519 0 0 0 0 0 0
$definebone "thumb_02_r" "thumb_01_r" -1.523451 0.000034 0.000029 9.832819 15.15153 1.613449 0 0 0 0 0 0
$definebone "thumb_03_r" "thumb_02_r" -1.599283 0.000004 0.000012 0.480715 -12.385735 2.414103 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" 5.511816 0.000005 -0.000002 -0.000397 179.999759 166.489945 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" 0.196852 -0.000002 0.000003 0.000357 -179.999117 160.050416 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 4.678655 -1.075635 -1.488978 66.457932 105.584814 113.208528 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.214486 0.000008 0.000019 23.505883 -122.013256 -45.028872 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.944896 -0.000031 -0.00019 -14.983586 -47.287128 -0.613695 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620169 0.000006 0.000012 10.370842 -141.974279 -168.145898 0 0 0 0 0 0
$definebone "index_01_l" "hand_l" 4.751153 0.694373 -0.830471 -3.764673 25.536491 14.866769 0 0 0 0 0 0
$definebone "index_02_l" "index_01_l" 1.688066 -0.000025 0.000003 -0.475151 11.986501 1.337916 0 0 0 0 0 0
$definebone "index_03_l" "index_02_l" 1.336144 -0.000052 -0.000009 -1.907889 -9.554303 1.137838 0 0 0 0 0 0
$definebone "middle_01_l" "hand_l" 4.820512 0.509337 0.224866 -7.040156 22.825888 1.917693 0 0 0 0 0 0
$definebone "middle_02_l" "middle_01_l" 1.826997 0.000067 0.000009 1.136751 12.280649 -2.025 0 0 0 0 0 0
$definebone "middle_03_l" "middle_02_l" 1.436582 -0.000009 0.000008 -0.387831 -15.345021 0.779225 0 0 0 0 0 0
$definebone "pinky_01_l" "hand_l" 3.992348 0.891088 1.827996 -18.934241 20.186214 -18.724948 0 0 0 0 0 0
$definebone "pinky_02_l" "pinky_01_l" 1.405922 0.000024 -0.000004 -1.31596 11.208135 1.063925 0 0 0 0 0 0
$definebone "pinky_03_l" "pinky_02_l" 1.175363 -0.00013 0.000003 7.050425 1.063461 0.448052 0 0 0 0 0 0
$definebone "ring_01_l" "hand_l" 4.526751 0.690458 1.120843 -10.989669 23.292045 -13.510284 0 0 0 0 0 0
$definebone "ring_02_l" "ring_01_l" 1.744043 -0.00003 -0.000001 -1.670164 13.3157 0.301551 0 0 0 0 0 0
$definebone "ring_03_l" "ring_02_l" 1.368764 -0.000033 -0.000016 9.08597 -12.938541 -0.365201 0 0 0 0 0 0
$definebone "thumb_01_l" "hand_l" 1.874849 0.93508 -0.999129 36.919105 27.05706 95.069581 0 0 0 0 0 0
$definebone "thumb_02_l" "thumb_01_l" 1.523454 -0.000033 -0.000004 9.832688 15.151409 1.612762 0 0 0 0 0 0
$definebone "thumb_03_l" "thumb_02_l" 1.59928 0.000002 0.000005 4.129698 -12.231678 2.421151 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511807 -0.000002 0.000005 0.00029 0.00046 -13.510177 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.19685 0.000002 -0.000001 0.00086 -0.000113 -19.951821 0 0 0 0 0 0
$definebone "cam_driver" "" 0 0 0 0 -89.999982 0 0 0 0 0 0 0
$definebone "Base" "" -2.98601 -14.069451 -3.431383 0 89.999989 0 0 0 0 0 0 0
$definebone "Mag" "Base" -0.255643 -0.013077 0.719978 0 0 0 0 0 0 0 0 0
$definebone "Bullet.001" "Mag" -0.006948 0.141676 0.160609 0 0 0 0 0 0 0 0 0
$definebone "Bullet.002" "Mag" 0.055573 -0.161511 -0.128439 0 0 0 0 0 0 0 0 0
$definebone "Bullet.003" "Mag" 0.123542 0.138843 -0.407301 0 0 0 0 0 0 0 0 0
$definebone "Bullet.004" "Mag" 0.157526 -0.150177 -0.708832 0 0 0 0 0 0 0 0 0
$definebone "Bullet.005" "Mag" 0.246735 0.128982 -1.031389 0 0 0 0 0 0 0 0 0
$definebone "Bullet.006" "Mag" 0.306208 -0.140316 -1.342953 0 0 0 0 0 0 0 0 0
$definebone "Bullet.007" "Mag" 0.349028 0.146119 -1.660563 0 0 0 0 0 0 0 0 0
$definebone "Bullet.008" "Mag" 0.391848 -0.142764 -1.950449 0 0 0 0 0 0 0 0 0
$definebone "Pusher" "Mag" 0.101691 -0.005667 -0.503864 0 0 0 0 0 0 0 0 0
$definebone "Bullet.009" "Mag" 0.395413 0.141676 -2.250739 0 0 0 0 0 0 0 0 0
$definebone "Bullet.010" "Mag" 0.457935 -0.161511 -2.539788 0 0 0 0 0 0 0 0 0
$definebone "Bullet.011" "Mag" 0.525904 0.138843 -2.81865 0 0 0 0 0 0 0 0 0
$definebone "Bullet.012" "Mag" 0.559888 -0.150177 -3.120179 0 0 0 0 0 0 0 0 0
$definebone "Bullet.013" "Mag" 0.649096 0.128982 -3.442737 0 0 0 0 0 0 0 0 0
$definebone "Bullet.014" "Mag" 0.70857 -0.140316 -3.7543 0 0 0 0 0 0 0 0 0
$definebone "Bullet.015" "Mag" 0.75139 0.146119 -4.071912 0 0 0 0 0 0 0 0 0
$definebone "Bullet.016" "Mag" 0.794209 -0.142764 -4.361795 0 0 0 0 0 0 0 0 0
$definebone "Bullet.017" "Mag" 0.849597 0.146119 -4.678274 0 0 0 0 0 0 0 0 0
$definebone "Bullet.018" "Mag" 0.892417 -0.142764 -4.968159 0 0 0 0 0 0 0 0 0
$definebone "Hammer" "Base" 1.798613 -0.009689 0.692775 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" -1.577578 -0.009689 -0.180214 0 0 0 0 0 0 0 0 0
$definebone "Slide" "Base" -1.734681 -0.009689 1.068608 0 0 0 0 0 0 0 0 0
$definebone "Rhand_IKtarget" "Base" 5.376168 8.158671 -2.024018 -5.623409 89.810506 -8.287662 0 0 0 0 0 0
$definebone "LHand_IKtarget" "Base" 5.173583 -3.209471 -1.854916 -74.114956 55.708754 -136.893766 0 0 0 0 0 0

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
$poseparameter "empty" 0 1 loop 0
$poseparameter "player_movement" 0 260 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "Bullet0_corrective_animation" "v_aps_anims\Bullet0_corrective_animation.smd" {
}

$animation "Bullet1_corrective_animation" "v_aps_anims\Bullet1_corrective_animation.smd" {
}

$animation "Bullet2_corrective_animation" "v_aps_anims\Bullet2_corrective_animation.smd" {
}

$animation "Bullet3_corrective_animation" "v_aps_anims\Bullet3_corrective_animation.smd" {
}

$animation "Bullet4_corrective_animation" "v_aps_anims\Bullet4_corrective_animation.smd" {
}

$animation "Bullet5_corrective_animation" "v_aps_anims\Bullet5_corrective_animation.smd" {
}

$animation "Bullet6_corrective_animation" "v_aps_anims\Bullet6_corrective_animation.smd" {
}

$animation "Bullet7_corrective_animation" "v_aps_anims\Bullet7_corrective_animation.smd" {
}

$animation "Bullet8_corrective_animation" "v_aps_anims\Bullet8_corrective_animation.smd" {
}

$animation "Bullet9_corrective_animation" "v_aps_anims\Bullet9_corrective_animation.smd" {
}

$animation "Bullet10_corrective_animation" "v_aps_anims\Bullet10_corrective_animation.smd" {
}

$animation "Bullet11_corrective_animation" "v_aps_anims\Bullet11_corrective_animation.smd" {
}

$animation "Bullet12_corrective_animation" "v_aps_anims\Bullet12_corrective_animation.smd" {
}

$animation "Bullet13_corrective_animation" "v_aps_anims\Bullet13_corrective_animation.smd" {
}

$animation "Bullet14_corrective_animation" "v_aps_anims\Bullet14_corrective_animation.smd" {
}

$animation "Bullet15_corrective_animation" "v_aps_anims\Bullet15_corrective_animation.smd" {
}

$animation "Bullet16_corrective_animation" "v_aps_anims\Bullet16_corrective_animation.smd" {
}

$animation "Bullet17_corrective_animation" "v_aps_anims\Bullet17_corrective_animation.smd" {
}

$animation "Bullet18_corrective_animation" "v_aps_anims\Bullet18_corrective_animation.smd" {
}

$animation "Default_corrective_animation" "v_aps_anims\Default_corrective_animation.smd" {
}

$animation "Slideback_corrective_animation" "v_aps_anims\Slideback_corrective_animation.smd" {
}

$animation "runIdle_a_corrective_animation" "v_aps_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_aps_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_aps_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_aps_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_aps_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_aps_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "shootlast_a_corrective_animation" "v_aps_anims\shootlast_a_corrective_animation.smd" {
}

$animation "shootlast_ironsight_a_corrective_animation" "v_aps_anims\shootlast_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_a_corrective_animation" "v_aps_anims\shoot2_a_corrective_animation.smd" {
}

$animation "shoot2_ironsight_a_corrective_animation" "v_aps_anims\shoot2_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3_a_corrective_animation" "v_aps_anims\shoot3_a_corrective_animation.smd" {
}

$animation "shoot3_ironsight_a_corrective_animation" "v_aps_anims\shoot3_ironsight_a_corrective_animation.smd" {
}

$animation "shoot4_a_corrective_animation" "v_aps_anims\shoot4_a_corrective_animation.smd" {
}

$animation "shoot4_ironsight_a_corrective_animation" "v_aps_anims\shoot4_ironsight_a_corrective_animation.smd" {
}

$animation "PoseDelta" "v_aps_anims\PoseDelta.smd" {
	fps 30
	
	
}

$animation "Default" "v_aps_anims\Default.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Default_corrective_animation" 0
}

$animation "Bullet18" "v_aps_anims\Bullet18.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet18_corrective_animation" 0
}

$animation "Bullet17" "v_aps_anims\Bullet17.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet17_corrective_animation" 0
}

$animation "Bullet16" "v_aps_anims\Bullet16.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet16_corrective_animation" 0
}

$animation "Bullet15" "v_aps_anims\Bullet15.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet15_corrective_animation" 0
}

$animation "Bullet14" "v_aps_anims\Bullet14.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet14_corrective_animation" 0
}

$animation "Bullet13" "v_aps_anims\Bullet13.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet13_corrective_animation" 0
}

$animation "Bullet12" "v_aps_anims\Bullet12.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet12_corrective_animation" 0
}

$animation "Bullet11" "v_aps_anims\Bullet11.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet11_corrective_animation" 0
}

$animation "Bullet10" "v_aps_anims\Bullet10.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet10_corrective_animation" 0
}

$animation "Bullet9" "v_aps_anims\Bullet9.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet9_corrective_animation" 0
}

$animation "Bullet8" "v_aps_anims\Bullet8.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet8_corrective_animation" 0
}

$animation "Bullet7" "v_aps_anims\Bullet7.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet7_corrective_animation" 0
}

$animation "Bullet6" "v_aps_anims\Bullet6.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet6_corrective_animation" 0
}

$animation "Bullet5" "v_aps_anims\Bullet5.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet5_corrective_animation" 0
}

$animation "Bullet4" "v_aps_anims\Bullet4.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet4_corrective_animation" 0
}

$animation "Bullet3" "v_aps_anims\Bullet3.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet3_corrective_animation" 0
}

$animation "Bullet2" "v_aps_anims\Bullet2.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet2_corrective_animation" 0
}

$animation "Bullet1" "v_aps_anims\Bullet1.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet1_corrective_animation" 0
}

$animation "Bullet0" "v_aps_anims\Bullet0.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet0_corrective_animation" 0
}

$animation "Slideforward" "v_aps_anims\Slideforward.smd" {
	fps 30
	numframes 24
	subtract "Slideback_corrective_animation" 0
}

$animation "Slideback" "v_aps_anims\Slideback.smd" {
	fps 30
	numframes 24
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Slideback_corrective_animation" 0
}

$animation "basePose_a" "v_aps_anims\basePose_a.smd" {
	fps 30
	numframes 60
	
	
}

$animation "ironsight" "v_aps_anims\ironsight.smd" {
	fps 30
	frame 1 1
	numframes 60
	
	
}

$animation "ironsight_transition" "v_aps_anims\ironsight_transition.smd" {
	fps 30
	numframes 60
	
	
}

$animation "walkDelta" "v_aps_anims\walkDelta.smd" {
	fps 30
	
	
}

$animation "runIdle_a" "v_aps_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_aps_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_aps_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_aps_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "shootlast_a" "v_aps_anims\shootlast_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_a_corrective_animation" 0
}

$animation "shootlast_ironsight_a" "v_aps_anims\shootlast_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_ironsight_a_corrective_animation" 0
}

$animation "shoot1_a" "v_aps_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_aps_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "shoot2_a" "v_aps_anims\shoot2_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_a_corrective_animation" 0
}

$animation "shoot2_ironsight_a" "v_aps_anims\shoot2_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_ironsight_a_corrective_animation" 0
}

$animation "shoot3_a" "v_aps_anims\shoot3_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_a_corrective_animation" 0
}

$animation "shoot3_ironsight_a" "v_aps_anims\shoot3_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_ironsight_a_corrective_animation" 0
}

$animation "shoot4_a" "v_aps_anims\shoot4_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot4_a_corrective_animation" 0
}

$animation "shoot4_ironsight_a" "v_aps_anims\shoot4_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot4_ironsight_a_corrective_animation" 0
}

$animation "nearwall_s_a" "v_aps_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_aps_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_aps_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_aps_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_aps_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_aps_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "proneF" "v_aps_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_aps_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_aps_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_aps_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_aps_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_aps_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_aps_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_aps_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_aps_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_aps_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "change_firemode_idle" "v_aps_anims\change_firemode_idle.smd" {
	fps 30
	
	
}

$animation "change_firemode_iron" "v_aps_anims\change_firemode_iron.smd" {
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
	"Bullet12"
	"Bullet13"
	"Bullet14"
	"Bullet15"
	"Bullet16"
	"Bullet17"
	"Bullet18"
	"Bullet18"
	"Bullet18"
	blend "ammo_fraction" 0 1
	blendwidth 21
	delta
	fadein 0.2
	fadeout 0.2
	hidden
	node "0"
}

$sequence "SlidePosition" {
	"Slideback"
	"Slideforward"
	blend "empty" 0 1
	blendwidth 2
	delta
	snap
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
	blend "ironsight" 0 0.5
	blend "empty" 0 1
	blendwidth 3
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	//blendlayer "ironsight_test" 0 0 1 0 poseparameter ironsight
	addlayer "BulletCounter"
	addlayer "SlidePosition"
}

$sequence "draw" {
	"v_aps_anims\draw.smd"
	"v_aps_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_APS.Draw" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	addlayer "BulletCounter"
	addlayer "SlidePosition"
	addlayer "walklayerironsight"
	node "0"
	fps 30	
}

$sequence "Firstdraw" {
	"v_aps_anims\Firstdraw.smd"
	"v_aps_anims\Firstdraw_2.smd"
	activity "ACT_VM_READY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_APS.Draw" }
	{ event 5004 8 "MCV_Weapon_Foley_APS_Reload.MetalStart" }
	{ event 5004 15 "MCV_Weapon_Foley_APS_Reload.MetalEnd" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	addlayer "BulletCounter"
	addlayer "walklayerironsight"
	node "0"
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
	addlayer "BulletCounter"
	addlayer "shoot1_pose"
	//addlayer "SlidePosition"
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
	addlayer "BulletCounter"
	addlayer "shoot2_pose"
	//addlayer "SlidePosition"
}

//$sequence "shoot3" {
	//"basePose_a"
	//"ironsight_transition"
	//"ironsight"
	//activity "ACT_VM_PRIMARYATTACK" 1
	//blend "ironsight" 0 0.5
	//blendwidth 3
	//fadein 0
	//fadeout 0
	//addlayer "walklayer"
	//addlayer "runlayer"
	//addlayer "BulletCounter"
	//addlayer "shoot3_pose"
	//addlayer "SlidePosition"
//}

//$sequence "shoot4" {
	//"basePose_a"
	//"ironsight_transition"
	//"ironsight"
	//activity "ACT_VM_PRIMARYATTACK" 1
	//blend "ironsight" 0 0.5
	//blendwidth 3
	//fadein 0
	//fadeout 0
	//addlayer "walklayer"
	//addlayer "runlayer"
	//addlayer "BulletCounter"
	//addlayer "shoot4_pose"
	//addlayer "SlidePosition"
//}

$sequence "shootlast" {
	"basePose_a"
	"ironsight_transition"
	"ironsight"
	activity "ACT_VM_SHOOTLAST" 1
	blend "ironsight" 0 0.5
	blend "empty" 0 1
	blendwidth 3
	fadein 0
	fadeout 0
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "BulletCounter"
	addlayer "shootlast_pose"
	addlayer "SlidePosition"
}

$sequence "shoot1_pose" {
	"shoot1_a"
	"shoot1_ironsight_a"
	blend "ironsight" 0 1
	blend "empty" 0 1
	delta
	snap
	hidden
}

$sequence "shoot2_pose" {
	"shoot2_a"
	"shoot2_ironsight_a"
	blend "ironsight" 0 1
	blend "empty" 0 1
	delta
	snap
	hidden
}

$sequence "shoot3_pose" {
	"shoot3_a"
	"shoot3_ironsight_a"
	blend "ironsight" 0 1
	blend "empty" 0 1
	delta
	snap
	hidden
}

$sequence "shoot4_pose" {
	"shoot4_a"
	"shoot4_ironsight_a"
	blend "ironsight" 0 1
	blend "empty" 0 1
	delta
	snap
	hidden
}

$sequence "shootlast_pose" {
	"shootlast_a"
	"shootlast_ironsight_a"
	blend "ironsight" 0 1
	blend "empty" 0 1
	delta
	snap
	hidden
}

$sequence "reload" {
	"v_aps_anims\reload.smd"
	"v_aps_anims\reload_2.smd"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_APS_Reload.Hand" }
	{ event 5004 11 "MCV_Weapon_Foley_APS_Reload.MagOut" }
	{ event 5004 50 "MCV_Weapon_Foley_APS_Reload.MagIn" }
	{ event 5004 60 "MCV_Weapon_Foley_APS_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 58 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 41 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	addlayer "BulletCounter"
	// addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "reload_empty" {
	"v_aps_anims\reload_empty.smd"
	"v_aps_anims\reload_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_APS_Reload.Hand" }
	{ event 5004 11 "MCV_Weapon_Foley_APS_Reload.MagOut" }
	{ event 5004 50 "MCV_Weapon_Foley_APS_Reload.MagIn" }
	{ event 5004 72 "MCV_Weapon_Foley_APS_Reload.MetalSpecial" }
	{ event 5004 75 "MCV_Weapon_Foley_APS_Reload.MetalEnd" }
	{ event 5004 60 "MCV_Weapon_Foley_APS_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 77 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 41 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	addlayer "BulletCounter"
	// addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "idletonearwall" {
	"nearwall_s_a"
	"nearwall_s_a_i"
	activity "ACT_VM_IDLE_TO_LOWERED" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.In" }
	fadein 0.2
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "BulletCounter"
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
	addlayer "BulletCounter"
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
	"v_aps_anims\bash.smd"
	"v_aps_anims\bash_2.smd"
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
	addlayer "walklayer"
	addlayer "SlidePosition"
	addlayer "BulletCounter"
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
	addlayer "SlidePosition"
	addlayer "BulletCounter"
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
	addlayer "walklayer"
	addlayer "SlidePosition"
	addlayer "BulletCounter"
}

$sequence "holster" {
	"v_aps_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 1 "MCV_Weapon_Foley_APS.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "BulletCounter"
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
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
	addlayer "SlidePosition"
	addlayer "BulletCounter"
}

$includemodel "weapons/gesture_animations.mdl"

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\guns\pistol_aps\APS.qc"
//	}
}

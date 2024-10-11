// Created by Crowbar 0.74

$modelname "weapons/mcv/v_qspr.mdl"

$bodygroup "studio"
{
	studio "qspr.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition -2.797 -7.499 -13.755

$cdmaterials "models\weapons\mcv\v_qspr\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "Base" -4.05 0 1.4 rotate 0 180 0

$cbox 0 0 0 0 0 0

$bbox -10.182 -14.564 -27.51 25.18 8.97 0

$definebone "root" "" 0 7.450089 -27.509027 0 0 0 0 0 0 0 0 0
$definebone "pelvis" "root" -0.000002 0 0 -89.790623 -89.997175 89.997175 0 0 0 0 0 0
$definebone "spine_01" "pelvis" 4.255466 -0.335183 -0.000002 0 -7.153262 0 0 0 0 0 0 0
$definebone "spine_02" "spine_01" 7.43125 1.496478 0.000002 0 14.063249 0 0 0 0 0 0 0
$definebone "spine_03" "spine_02" 5.278479 0.165543 0.000001 0 2.779475 0 0 0 0 0 0 0
$definebone "clavicle_r" "spine_03" 4.678654 -1.075637 1.488977 66.457884 -74.414959 113.208678 0 0 0 0 0 0
$definebone "upperarm_r" "clavicle_r" -6.214481 -0.000008 -0.000026 -39.361178 171.560815 166.195564 0 0 0 0 0 0
$definebone "lowerarm_r" "upperarm_r" 11.944883 0 0 -11.599 34.295469 3.613498 0 0 0 0 0 0
$definebone "hand_r" "lowerarm_r" 10.62018 0 0.000001 40.97507 158.04764 82.470989 0 0 0 0 0 0
$definebone "index_01_r" "hand_r" -4.751106 -0.694494 0.830578 -3.762674 25.53868 14.867228 0 0 0 0 0 0
$definebone "index_02_r" "index_01_r" -1.688068 0.000049 -0.000031 -0.475214 11.986108 1.337747 0 0 0 0 0 0
$definebone "index_03_r" "index_02_r" -1.33614 0.000057 -0.000011 0.996944 -9.496602 1.137555 0 0 0 0 0 0
$definebone "middle_01_r" "hand_r" -4.820494 -0.509457 -0.224758 -7.039534 22.827331 1.918096 0 0 0 0 0 0
$definebone "middle_02_r" "middle_01_r" -1.826977 -0.000069 0.000006 1.136743 12.280668 -2.025001 0 0 0 0 0 0
$definebone "middle_03_r" "middle_02_r" -1.436573 0.000006 0.000002 -4.389719 -15.399551 0.781576 0 0 0 0 0 0
$definebone "pinky_01_r" "hand_r" -3.992355 -0.891188 -1.827906 -18.932823 20.187425 -18.724426 0 0 0 0 0 0
$definebone "pinky_02_r" "pinky_01_r" -1.405918 -0.000031 -0.000005 -1.315571 11.208258 1.063874 0 0 0 0 0 0
$definebone "pinky_03_r" "pinky_02_r" -1.175362 0.000123 -0.000019 3.869414 1.038602 0.445651 0 0 0 0 0 0
$definebone "ring_01_r" "hand_r" -4.526749 -0.690577 -1.120743 -10.988245 23.293486 -13.509882 0 0 0 0 0 0
$definebone "ring_02_r" "ring_01_r" -1.744045 0.000031 -0.000006 -1.669886 13.315307 0.301261 0 0 0 0 0 0
$definebone "ring_03_r" "ring_02_r" -1.368771 0.000028 0.000004 2.987744 -12.899514 -0.36068 0 0 0 0 0 0
$definebone "thumb_01_r" "hand_r" -1.8748 -0.935122 0.999173 36.920249 27.057817 95.069526 0 0 0 0 0 0
$definebone "thumb_02_r" "thumb_01_r" -1.523449 0.000031 0.00003 9.832815 15.151523 1.613447 0 0 0 0 0 0
$definebone "thumb_03_r" "thumb_02_r" -1.599281 0.000006 0.000016 0.48071 -12.385742 2.414099 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" 5.511816 0.000006 -0.000001 -0.000429 179.999745 166.489945 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" 0.19685 -0.000002 0.000002 0.000343 -179.999103 160.050416 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 4.678654 -1.075633 -1.488978 66.457932 105.584814 113.208582 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.214486 0.000007 0.000017 39.360369 -8.439268 13.804506 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.944885 -0.000031 -0.000195 -11.598268 -34.295476 -3.613934 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620169 0.000004 0.000005 -40.973755 21.950695 -97.528073 0 0 0 0 0 0
$definebone "index_01_l" "hand_l" 4.751158 0.694378 -0.830476 -3.76467 25.536501 14.866766 0 0 0 0 0 0
$definebone "index_02_l" "index_01_l" 1.688068 -0.000029 0.000002 -0.475146 11.986504 1.337911 0 0 0 0 0 0
$definebone "index_03_l" "index_02_l" 1.336147 -0.000051 -0.000009 -1.907885 -9.554303 1.137832 0 0 0 0 0 0
$definebone "middle_01_l" "hand_l" 4.820515 0.509344 0.224866 -7.040155 22.825895 1.91769 0 0 0 0 0 0
$definebone "middle_02_l" "middle_01_l" 1.826992 0.000065 0.00001 1.136754 12.280663 -2.025006 0 0 0 0 0 0
$definebone "middle_03_l" "middle_02_l" 1.436577 -0.00001 0.000009 -0.38783 -15.345012 0.77922 0 0 0 0 0 0
$definebone "pinky_01_l" "hand_l" 3.992352 0.891088 1.827995 -18.934241 20.186225 -18.724948 0 0 0 0 0 0
$definebone "pinky_02_l" "pinky_01_l" 1.405922 0.000027 -0.000006 -1.315969 11.208148 1.063926 0 0 0 0 0 0
$definebone "pinky_03_l" "pinky_02_l" 1.175365 -0.000129 0.000002 7.05042 1.063472 0.448053 0 0 0 0 0 0
$definebone "ring_01_l" "hand_l" 4.526758 0.690462 1.120839 -10.989667 23.292052 -13.510285 0 0 0 0 0 0
$definebone "ring_02_l" "ring_01_l" 1.744034 -0.000033 0 -1.670163 13.315712 0.301551 0 0 0 0 0 0
$definebone "ring_03_l" "ring_02_l" 1.368763 -0.000032 -0.000018 9.085974 -12.938532 -0.365201 0 0 0 0 0 0
$definebone "thumb_01_l" "hand_l" 1.874853 0.935081 -0.999131 36.919105 27.057077 95.069574 0 0 0 0 0 0
$definebone "thumb_02_l" "thumb_01_l" 1.523453 -0.000032 -0.000002 9.832703 15.151409 1.612759 0 0 0 0 0 0
$definebone "thumb_03_l" "thumb_02_l" 1.599279 -0.000002 0.000008 4.12971 -12.231674 2.421144 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511805 -0.000002 0.000002 0.00029 0.000404 -13.510177 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.19685 0.000002 -0.000002 0.000864 -0.000116 -19.951826 0 0 0 0 0 0
$definebone "cam_driver" "" 0 0 0 0 -89.999982 0 0 0 0 0 0 0
$definebone "Base" "" -4.33264 -16.435041 -4.023893 0 89.999989 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 10.640673 6.812044 -1.499065 0 0 0 0 0 0 0 0 0
$definebone "Hammer" "Base" 1.172841 0.003867 0.361636 0 0 0 0 0 0 0 0 0
$definebone "CyHolder" "Base" -2.909418 -0.116088 -0.378866 0 0 0 0 0 0 0 0 0
$definebone "Cy" "CyHolder" 1.368917 0.119955 1.216499 0 0 0 0 0 0 0 0 0
$definebone "BulletPos" "Cy" 1.166946 0 0 0 0 0 0 0 0 0 0 0
$definebone "Bullet.001" "BulletPos" -0.699533 0.501534 0.289546 0 0 0 0 0 0 0 0 0
$definebone "Bullet.002" "BulletPos" -0.699533 0.001722 0.577368 0 0 0 0 0 0 0 0 0
$definebone "Bullet.003" "BulletPos" -0.699533 -0.498777 0.287822 0 0 0 0 0 0 0 0 0
$definebone "Bullet.004" "BulletPos" -0.699533 -0.496295 -0.290442 0 0 0 0 0 0 0 0 0
$definebone "Bullet.005" "BulletPos" -0.699533 0.00255 -0.578333 0 0 0 0 0 0 0 0 0
$definebone "Bullet.006" "BulletPos" -0.699533 0.502241 -0.290088 0 0 0 0 0 0 0 0 0
$definebone "Pusher" "CyHolder" -0.630154 0.119955 1.216499 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" -1.045788 0.006302 -0.388174 0 0 0 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" 7.151364 -10.530141 -9.756922 30.66869 -109.26686 178.998522 0 0 0 0 0 0

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

$poseparameter "ammo_fraction" 0 1 loop 0
$poseparameter "player_movement" 0 260 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "revolver_firemode_pose" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "Bullet0_corrective_animation" "v_qspr_anims\Bullet0_corrective_animation.smd" {
}

$animation "Bullet1_corrective_animation" "v_qspr_anims\Bullet1_corrective_animation.smd" {
}

$animation "Bullet2_corrective_animation" "v_qspr_anims\Bullet2_corrective_animation.smd" {
}

$animation "Bullet3_corrective_animation" "v_qspr_anims\Bullet3_corrective_animation.smd" {
}

$animation "Bullet4_corrective_animation" "v_qspr_anims\Bullet4_corrective_animation.smd" {
}

$animation "Bullet5_corrective_animation" "v_qspr_anims\Bullet5_corrective_animation.smd" {
}

$animation "Default_corrective_animation" "v_qspr_anims\Default_corrective_animation.smd" {
}

$animation "runIdle_a_corrective_animation" "v_qspr_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_qspr_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_qspr_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_qspr_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot_a_corrective_animation" "v_qspr_anims\shoot_a_corrective_animation.smd" {
}

$animation "shoot_ironsight_a_corrective_animation" "v_qspr_anims\shoot_ironsight_a_corrective_animation.smd" {
}

$animation "shoot_w_a_corrective_animation" "v_qspr_anims\shoot_w_a_corrective_animation.smd" {
}

$animation "shoot_w_ironsight_a_corrective_animation" "v_qspr_anims\shoot_w_ironsight_a_corrective_animation.smd" {
}

$animation "shoot_p_a_corrective_animation" "v_qspr_anims\shoot_p_a_corrective_animation.smd" {
}

$animation "shoot_p_ironsight_a_corrective_animation" "v_qspr_anims\shoot_p_ironsight_a_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_qspr_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_qspr_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "PoseDelta" "v_qspr_anims\PoseDelta.smd" {
	fps 30
	
	
}

$animation "Default" "v_qspr_anims\Default.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Default_corrective_animation" 0
}

$animation "Bullet5" "v_qspr_anims\Bullet5.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet5_corrective_animation" 0
}

$animation "Bullet4" "v_qspr_anims\Bullet4.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet4_corrective_animation" 0
}

$animation "Bullet3" "v_qspr_anims\Bullet3.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet3_corrective_animation" 0
}

$animation "Bullet2" "v_qspr_anims\Bullet2.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet2_corrective_animation" 0
}

$animation "Bullet1" "v_qspr_anims\Bullet1.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet1_corrective_animation" 0
}

$animation "Bullet0" "v_qspr_anims\Bullet0.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet0_corrective_animation" 0
}

$animation "basePose_a" "v_qspr_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "ironsight" "v_qspr_anims\ironsight.smd" {
	fps 0.5
	
	
}

$animation "ironsight_transition" "v_qspr_anims\ironsight_transition.smd" {
	fps 0.5
	
	
}

$animation "runIdle_a" "v_qspr_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_qspr_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_qspr_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_qspr_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "idle_delayed_a" "v_qspr_anims\idle_delayed_a.smd" {
	fps 30
	
	
}

$animation "ironsight_delayed" "v_qspr_anims\ironsight_delayed.smd" {
	fps 0.5
	
	
}

$animation "ironsight_transition_delayed" "v_qspr_anims\ironsight_transition_delayed.smd" {
	fps 0.5
	
	
}

$animation "idle_western_a" "v_qspr_anims\idle_western_a.smd" {
	fps 30
	
	
}

$animation "ironsight_western" "v_qspr_anims\ironsight_western.smd" {
	fps 0.5
	
	
}

$animation "ironsight_transition_western" "v_qspr_anims\ironsight_transition_western.smd" {
	fps 0.5
	
	
}

$animation "shoot_a" "v_qspr_anims\shoot_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_a_corrective_animation" 0
}

$animation "shoot_ironsight_a" "v_qspr_anims\shoot_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_ironsight_a_corrective_animation" 0
}

$animation "shoot_w_a" "v_qspr_anims\shoot_w_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_w_a_corrective_animation" 0
}

$animation "shoot_w_ironsight_a" "v_qspr_anims\shoot_w_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_w_ironsight_a_corrective_animation" 0
}

$animation "shoot_p_a" "v_qspr_anims\shoot_p_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_p_a_corrective_animation" 0
}

$animation "shoot_p_ironsight_a" "v_qspr_anims\shoot_p_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_p_ironsight_a_corrective_animation" 0
}

$animation "shoot1_a" "v_qspr_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_qspr_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "d_nearwall_s_a" "v_qspr_anims\d_nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a" "v_qspr_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "w_nearwall_s_a" "v_qspr_anims\w_nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "d_nearwall_s_a_i" "v_qspr_anims\d_nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_qspr_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "w_nearwall_s_a_i" "v_qspr_anims\w_nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "d_nearwall_a" "v_qspr_anims\d_nearwall_a.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_qspr_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "w_nearwall_a" "v_qspr_anims\w_nearwall_a.smd" {
	fps 30
	
	
}

$animation "d_nearwall_a_i" "v_qspr_anims\d_nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a_i" "v_qspr_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "w_nearwall_a_i" "v_qspr_anims\w_nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "d_nearwall_e_a" "v_qspr_anims\d_nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_qspr_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "w_nearwall_e_a" "v_qspr_anims\w_nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "d_nearwall_e_a_i" "v_qspr_anims\d_nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_qspr_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "w_nearwall_e_a_i" "v_qspr_anims\w_nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "d_proneF" "v_qspr_anims\d_proneF.smd" {
	fps 30
	
	
}

$animation "d_proneB" "v_qspr_anims\d_proneB.smd" {
	fps 30
	
	
}

$animation "d_proneL" "v_qspr_anims\d_proneL.smd" {
	fps 30
	
	
}

$animation "d_proneR" "v_qspr_anims\d_proneR.smd" {
	fps 30
	
	
}

$animation "proneF" "v_qspr_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_qspr_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_qspr_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_qspr_anims\proneR.smd" {
	fps 30
	
	
}

$animation "w_proneF" "v_qspr_anims\w_proneF.smd" {
	fps 30
	
	
}

$animation "w_proneB" "v_qspr_anims\w_proneB.smd" {
	fps 30
	
	
}

$animation "w_proneL" "v_qspr_anims\w_proneL.smd" {
	fps 30
	
	
}

$animation "w_proneR" "v_qspr_anims\w_proneR.smd" {
	fps 30
	
	
}

$animation "d_pickup_s_a" "v_qspr_anims\d_pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_qspr_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "w_pickup_s_a" "v_qspr_anims\w_pickup_s_a.smd" {
	fps 30
	
	
}

$animation "d_pickup_s_a_i" "v_qspr_anims\d_pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_qspr_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "w_pickup_s_a_i" "v_qspr_anims\w_pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "d_pickup_a" "v_qspr_anims\d_pickup_a.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_qspr_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "w_pickup_a" "v_qspr_anims\w_pickup_a.smd" {
	fps 30
	
	
}

$animation "d_pickup_a_i" "v_qspr_anims\d_pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a_i" "v_qspr_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "w_pickup_a_i" "v_qspr_anims\w_pickup_a_i.smd" {
	fps 30
	
	
}

$animation "d_pickup_e_a" "v_qspr_anims\d_pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_qspr_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "w_pickup_e_a" "v_qspr_anims\w_pickup_e_a.smd" {
	fps 30
	
	
}

$animation "d_pickup_e_a_i" "v_qspr_anims\d_pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_qspr_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "w_pickup_e_a_i" "v_qspr_anims\w_pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "change_firemode_towestern_a" "v_qspr_anims\change_firemode_towestern_a.smd" {
	fps 30
	
	
}

$animation "change_firemode_towestern_iron_a" "v_qspr_anims\change_firemode_towestern_iron_a.smd" {
	fps 30
	
	
}

$animation "change_firemode_todelayed_a" "v_qspr_anims\change_firemode_todelayed_a.smd" {
	fps 30
	
	
}

$animation "change_firemode_todelayed_iron_a" "v_qspr_anims\change_firemode_todelayed_iron_a.smd" {
	fps 30
	
	
}

$animation "change_firemode_tonormal_a" "v_qspr_anims\change_firemode_tonormal_a.smd" {
	fps 30
	
	
}

$animation "change_firemode_tonormal_iron_a" "v_qspr_anims\change_firemode_tonormal_iron_a.smd" {
	fps 30
	
	
}

$sequence "BulletCounter" {
	"Bullet0"
	"Bullet1"
	"Bullet2"
	"Bullet3"
	"Bullet4"
	"Bullet5"
	"Default"
	blend "ammo_fraction" 0 1
	blendwidth 7
	delta
	fadein 0.2
	fadeout 0.2
	hidden
	node "0"
}

$sequence "runlayer" {
	"runIdle_a"
	"run_a"
	"runIdle_a"
	"runIdle_a"
	blend "player_movement" 161 260
	blend "ironsight" 0 1
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
	"walk_a"
	"walk_a"
	blend "player_movement" 0 260
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
	"idle_western_a"
	"ironsight_transition_western"
	"ironsight_western"
	activity "ACT_VM_IDLE" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
}

$sequence "FirstDraw" {
	"v_qspr_anims\FirstDraw.smd"
	"v_qspr_anims\FirstDraw_2.smd"
	"v_qspr_anims\FirstDraw_3.smd"
	"v_qspr_anims\FirstDraw_4.smd"
	"v_qspr_anims\FirstDraw_5.smd"
	"v_qspr_anims\FirstDraw_6.smd"
	activity "ACT_VM_READY" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M1917.Draw" }
	{ event 5004 10 "MCV_Weapon_Foley_M1917.DrawMetal" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
	fps 30
}

$sequence "draw" {
	"v_qspr_anims\draw.smd"
	"v_qspr_anims\draw_2.smd"
	"v_qspr_anims\draw_3.smd"
	"v_qspr_anims\draw_4.smd"
	"v_qspr_anims\draw_5.smd"
	"v_qspr_anims\draw_6.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M1917.Draw" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
	fps 30
	  
	
}

$sequence "shoot_hammer" {
	"shoot_a"
	"shoot_ironsight_a"
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

$sequence "shoot_western" {
	"shoot_w_a"
	"shoot_w_ironsight_a"
	activity "ACT_VM_PRIMARYATTACK1" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event 5004 0 "MCV_Weapon_Foley_Revolver.HammerStrike" }
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	{ event AE_MUZZLEFLASH 0 "" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "prepare_delayed" {
	"shoot_p_a"
	"shoot_p_ironsight_a"
	activity "ACT_VM_HAULBACK" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event 5004 0 "MCV_Weapon_Foley_Revolver.HammerOutSlow" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "shoot_delayed" {
	"shoot1_a"
	"shoot1_ironsight_a"
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

$sequence "reload" {
	"v_qspr_anims\reload.smd"
	"v_qspr_anims\reload_2.smd"
	"v_qspr_anims\reload_3.smd"
	"v_qspr_anims\reload_4.smd"
	"v_qspr_anims\reload_5.smd"
	"v_qspr_anims\reload_6.smd"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	blendwidth 2
	{ event AE_WPN_CLIP_TO_POSEPARAM 0 "ammo_fraction" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 10 "ammo_fraction" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 28 "ammo_fraction" }
	{ event 5004 1 "MCV_Weapon_Foley_SWM12_Reload.Hand" }
	{ event 5004 7 "MCV_Weapon_Foley_SWM12_Reload.Start" }
	{ event 5004 18 "MCV_Weapon_Foley_SWM12_Reload.Mid_Eject" }
	{ event 5004 40 "MCV_Weapon_Foley_SWM12_Reload.Mid_Insert" }
	{ event 5004 45 "MCV_Weapon_Foley_SWM12_Reload.HandEnd" }
	{ event 5004 53 "MCV_Weapon_Foley_SWM12_Reload.End" }
	{ event AE_WPN_COMPLETE_RELOAD 54 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "BulletCounter"
	addlayer "walklayerironsight"
	node "0"
	fps 30
}

$sequence "idletonearwall" {
	"nearwall_s_a"
	"nearwall_s_a_i"
	"d_nearwall_s_a"
	"d_nearwall_s_a_i"
	"w_nearwall_s_a"
	"w_nearwall_s_a_i"
	activity "ACT_VM_IDLE_TO_LOWERED" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.In" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	node "0"
}

$sequence "nearwall" {
	"nearwall_a"
	"nearwall_a_i"
	"d_nearwall_a"
	"d_nearwall_a_i"
	"w_nearwall_a"
	"w_nearwall_a_i"
	activity "ACT_VM_IDLE_LOWERED" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	blendwidth 2
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	node "0"
}

$sequence "nearwalltoidle" {
	"nearwall_e_a"
	"nearwall_e_a_i"
	"d_nearwall_e_a"
	"d_nearwall_e_a_i"
	"w_nearwall_e_a"
	"w_nearwall_e_a_i"
	activity "ACT_VM_LOWERED_TO_IDLE" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.Out" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	node "0"
}

$sequence "prone" {
	"proneF"
	"proneL"
	"proneB"
	"proneR"
	"proneF"
	"d_proneF"
	"d_proneL"
	"d_proneB"
	"d_proneR"
	"d_proneF"
	"w_proneF"
	"w_proneL"
	"w_proneB"
	"w_proneR"
	"w_proneF"
	activity "ACT_VM_CRAWL" 1
	blend "move_yaw" -180 180
	blend "revolver_firemode_pose" 0 1
	blendwidth 5
	{ event 5004 1 "MCV_Weapon_Foley_Movement.ProneCrawl" }
	{ event 5004 10 "MCV_Weapon_Foley_Movement.ProneCrawl_GunLight" }
	fadein 0.2
	fadeout 0.2
	realtime
}

$sequence "bash" {
	"v_qspr_anims\bash.smd"
	"v_qspr_anims\bash_2.smd"
	"v_qspr_anims\bash_3.smd"
	"v_qspr_anims\bash_4.smd"
	"v_qspr_anims\bash_5.smd"
	"v_qspr_anims\bash_6.smd"
	activity "ACT_VM_HITCENTER" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
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
	"d_pickup_s_a"
	"d_pickup_s_a_i"
	"w_pickup_s_a"
	"w_pickup_s_a_i"
	activity "ACT_VM_PICKUPSTART" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.In" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
}

$sequence "pickuploop" {
	"pickup_a"
	"pickup_a_i"
	"d_pickup_a"
	"d_pickup_a_i"
	"w_pickup_a"
	"w_pickup_a_i"
	activity "ACT_VM_PICKUPLOOP" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	blendwidth 2
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
}

$sequence "pickupend" {
	"pickup_e_a"
	"pickup_e_a_i"
	"d_pickup_e_a"
	"d_pickup_e_a_i"
	"w_pickup_e_a"
	"w_pickup_e_a_i"
	activity "ACT_VM_PICKUPEND" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.Out" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
}

$sequence "holster" {
	"v_qspr_anims\holster.smd"
	"v_qspr_anims\holster_2.smd"
	"v_qspr_anims\holster_3.smd"
	activity "ACT_VM_HOLSTER" 1
	blend "revolver_firemode_pose" 0 1
	blendwidth 3
	{ event 5004 1 "MCV_Weapon_Foley_SWM12.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$sequence "changefiremode_towestern" {
	"change_firemode_towestern_a"
	"change_firemode_towestern_iron_a"
	activity "ACT_VM_FIREMODE" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event AE_WPN_SET_POSEPARAM 4 "revolver_firemode_pose 1" }
	{ event 5004 1 "MCV_Weapon_Foley_Revolver.Hand" }
	{ event 5004 7 "MCV_Weapon_Foley_Revolver.HammerIn" }
	{ event 5004 10 "MCV_Weapon_Foley_Revolver.Hand" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
}

$sequence "changefiremode_todelayed" {
	"change_firemode_todelayed_a"
	"change_firemode_todelayed_iron_a"
	activity "ACT_VM_FIREMODE1" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event AE_WPN_SET_POSEPARAM 4 "revolver_firemode_pose 0.5" }
	{ event 5004 1 "MCV_Weapon_Foley_Revolver.Hand" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
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
}

$includemodel "weapons/gesture_animations.mdl"

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\guns\pistol_swm12\QSPR.qc"
//	}
}

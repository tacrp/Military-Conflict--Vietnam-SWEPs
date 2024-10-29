// Created by Crowbar 0.74

$modelname "weapons/mcv/v_swm12.mdl"

$bodygroup "studio"
{
	studio "ref_new.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition -2.674 -7.971 -13.755

$cdmaterials "models\weapons\mcv\v_swm12\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "Base" -4.95 0 1.4 rotate 0 180 0

$cbox 0 0 0 0 0 0

$bbox -10.182 -14.318 -27.509 26.124 8.97 0

$definebone "root" "" 0 7.450089 -27.509027 0 0 0 0 0 0 0 0 0
$definebone "pelvis" "root" -0.000002 0 0 -89.790336 -89.996943 89.996943 0 0 0 0 0 0
$definebone "spine_01" "pelvis" 4.255468 -0.335183 -0.000002 0 -7.153264 0 0 0 0 0 0 0
$definebone "spine_02" "spine_01" 7.43125 1.496477 0.000002 0 14.063248 0 0 0 0 0 0 0
$definebone "spine_03" "spine_02" 5.278481 0.165541 0.000001 0 2.779475 0 0 0 0 0 0 0
$definebone "clavicle_r" "spine_03" 4.678658 -1.075636 1.488978 66.457891 -74.414952 113.208671 0 0 0 0 0 0
$definebone "upperarm_r" "clavicle_r" -6.214486 -0.000006 -0.000026 -39.361188 171.560801 166.195564 0 0 0 0 0 0
$definebone "lowerarm_r" "upperarm_r" 11.944885 -0.000001 -0.000002 -11.599014 34.295442 3.613506 0 0 0 0 0 0
$definebone "hand_r" "lowerarm_r" 10.620186 0 0 40.97506 158.047668 82.471003 0 0 0 0 0 0
$definebone "index_01_r" "hand_r" -4.751106 -0.694494 0.830577 -3.76267 25.538685 14.867223 0 0 0 0 0 0
$definebone "index_02_r" "index_01_r" -1.688072 0.000046 -0.000031 -0.475209 11.986116 1.337744 0 0 0 0 0 0
$definebone "index_03_r" "index_02_r" -1.33614 0.000055 -0.000012 0.996949 -9.496592 1.137552 0 0 0 0 0 0
$definebone "middle_01_r" "hand_r" -4.820496 -0.50946 -0.22476 -7.039532 22.827331 1.91809 0 0 0 0 0 0
$definebone "middle_02_r" "middle_01_r" -1.826988 -0.000069 0.000007 1.136748 12.28067 -2.025007 0 0 0 0 0 0
$definebone "middle_03_r" "middle_02_r" -1.436577 0.000004 0.000001 -4.38972 -15.399551 0.781569 0 0 0 0 0 0
$definebone "pinky_01_r" "hand_r" -3.992357 -0.891188 -1.827909 -18.932822 20.187427 -18.724433 0 0 0 0 0 0
$definebone "pinky_02_r" "pinky_01_r" -1.405918 -0.000024 -0.000001 -1.315571 11.208259 1.06386 0 0 0 0 0 0
$definebone "pinky_03_r" "pinky_02_r" -1.175362 0.000125 -0.000021 3.869411 1.038605 0.445639 0 0 0 0 0 0
$definebone "ring_01_r" "hand_r" -4.526751 -0.690573 -1.120744 -10.988244 23.293488 -13.509885 0 0 0 0 0 0
$definebone "ring_02_r" "ring_01_r" -1.744041 0.000034 -0.000007 -1.669886 13.315316 0.301259 0 0 0 0 0 0
$definebone "ring_03_r" "ring_02_r" -1.368767 0.000023 0.000005 2.987747 -12.899511 -0.36068 0 0 0 0 0 0
$definebone "thumb_01_r" "hand_r" -1.874798 -0.935127 0.999174 36.92026 27.057822 95.069512 0 0 0 0 0 0
$definebone "thumb_02_r" "thumb_01_r" -1.523453 0.000034 0.00003 9.832821 15.151515 1.613449 0 0 0 0 0 0
$definebone "thumb_03_r" "thumb_02_r" -1.599281 0.000004 0.000013 0.480718 -12.385751 2.414095 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" 5.511818 0.000006 -0.000001 -0.000449 179.999773 166.489945 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" 0.196846 -0.000002 0.000002 0.000335 -179.999117 160.050416 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 4.678658 -1.075636 -1.488979 66.457925 105.584814 113.208541 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.214489 0.000005 0.000019 39.360365 -8.439268 13.804506 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.944893 -0.000032 -0.000194 -11.598272 -34.295479 -3.613929 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620171 0.000004 0.00001 -40.973765 21.9507 -97.528066 0 0 0 0 0 0
$definebone "index_01_l" "hand_l" 4.75116 0.694376 -0.830474 -3.764674 25.536503 14.866764 0 0 0 0 0 0
$definebone "index_02_l" "index_01_l" 1.688065 -0.000027 0.000002 -0.475151 11.986516 1.337912 0 0 0 0 0 0
$definebone "index_03_l" "index_02_l" 1.336147 -0.000053 -0.00001 -1.90789 -9.554295 1.137834 0 0 0 0 0 0
$definebone "middle_01_l" "hand_l" 4.820515 0.50934 0.224865 -7.040161 22.825895 1.917685 0 0 0 0 0 0
$definebone "middle_02_l" "middle_01_l" 1.827003 0.000068 0.000009 1.13675 12.280673 -2.02501 0 0 0 0 0 0
$definebone "middle_03_l" "middle_02_l" 1.436577 -0.000008 0.000008 -0.387836 -15.345014 0.779217 0 0 0 0 0 0
$definebone "pinky_01_l" "hand_l" 3.992353 0.891087 1.827995 -18.934254 20.186216 -18.724953 0 0 0 0 0 0
$definebone "pinky_02_l" "pinky_01_l" 1.405922 0.000023 -0.000009 -1.315974 11.208145 1.063923 0 0 0 0 0 0
$definebone "pinky_03_l" "pinky_02_l" 1.175365 -0.000131 0.000003 7.050415 1.063473 0.448055 0 0 0 0 0 0
$definebone "ring_01_l" "hand_l" 4.526758 0.690458 1.120842 -10.989675 23.292052 -13.510295 0 0 0 0 0 0
$definebone "ring_02_l" "ring_01_l" 1.744045 -0.000031 0 -1.670171 13.315717 0.301544 0 0 0 0 0 0
$definebone "ring_03_l" "ring_02_l" 1.368763 -0.000031 -0.000018 9.085969 -12.938532 -0.365207 0 0 0 0 0 0
$definebone "thumb_01_l" "hand_l" 1.874853 0.935081 -0.99913 36.919116 27.057076 95.069567 0 0 0 0 0 0
$definebone "thumb_02_l" "thumb_01_l" 1.523453 -0.000034 0 9.832704 15.151402 1.612767 0 0 0 0 0 0
$definebone "thumb_03_l" "thumb_02_l" 1.599281 0 0.000009 4.129706 -12.231683 2.421154 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511808 -0.000002 0.000005 0.000289 0.000396 -13.510171 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.196848 0.000001 -0.000002 0.000859 -0.000114 -19.951821 0 0 0 0 0 0
$definebone "cam_driver" "" 0 0 0 0 -89.999982 0 0 0 0 0 0 0
$definebone "Base" "" -4.33264 -16.435041 -4.023893 0 89.999982 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 10.640676 6.812044 -1.499065 0 0 0 0 0 0 0 0 0
$definebone "Hammer" "Base" 1.172842 0.003867 0.361636 0 0 0 0 0 0 0 0 0
$definebone "CyHolder" "Base" -2.909418 -0.116088 -0.378866 0 0 0 0 0 0 0 0 0
$definebone "Cy" "CyHolder" 1.368917 0.119955 1.216499 0 0 0 0 0 0 0 0 0
$definebone "BulletPos" "Cy" 1.166946 0 0 0 0 0 0 0 0 0 0 0
$definebone "Bullet.001" "BulletPos" -0.699533 0.501534 0.289546 0 0 0 0 0 0 0 0 0
$definebone "BulletHead.001" "Bullet.001" -0.628338 0 0 0 0 0 0 0 0 0 0 0
$definebone "Bullet.002" "BulletPos" -0.699533 0.001723 0.577368 0 0 0 0 0 0 0 0 0
$definebone "BulletHead.002" "Bullet.002" -0.628338 0 0 0 0 0 0 0 0 0 0 0
$definebone "Bullet.003" "BulletPos" -0.699533 -0.498777 0.287822 0 0 0 0 0 0 0 0 0
$definebone "BulletHead.003" "Bullet.003" -0.628338 0 0 0 0 0 0 0 0 0 0 0
$definebone "Bullet.004" "BulletPos" -0.699533 -0.496295 -0.290442 0 0 0 0 0 0 0 0 0
$definebone "BulletHead.004" "Bullet.004" -0.628338 0 0 0 0 0 0 0 0 0 0 0
$definebone "Bullet.005" "BulletPos" -0.699533 0.002551 -0.578333 0 0 0 0 0 0 0 0 0
$definebone "BulletHead.005" "Bullet.005" -0.628338 0 0 0 0 0 0 0 0 0 0 0
$definebone "Bullet.006" "BulletPos" -0.699533 0.502242 -0.290088 0 0 0 0 0 0 0 0 0
$definebone "BulletHead.006" "Bullet.006" -0.628338 0 0 0 0 0 0 0 0 0 0 0
$definebone "Pusher" "CyHolder" -0.630154 0.119955 1.216499 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" -1.045788 0.006302 -0.388174 0 0 0 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" 7.151367 -10.53014 -9.756924 30.668693 -109.266866 178.998522 0 0 0 0 0 0

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




$animation "Bullet0_corrective_animation" "v_swm12_anims\Bullet0_corrective_animation.smd" {
}

$animation "Bullet1_corrective_animation" "v_swm12_anims\Bullet1_corrective_animation.smd" {
}

$animation "Bullet2_corrective_animation" "v_swm12_anims\Bullet2_corrective_animation.smd" {
}

$animation "Bullet3_corrective_animation" "v_swm12_anims\Bullet3_corrective_animation.smd" {
}

$animation "Bullet4_corrective_animation" "v_swm12_anims\Bullet4_corrective_animation.smd" {
}

$animation "Bullet5_corrective_animation" "v_swm12_anims\Bullet5_corrective_animation.smd" {
}

$animation "Default_corrective_animation" "v_swm12_anims\Default_corrective_animation.smd" {
}

$animation "runIdle_a_corrective_animation" "v_swm12_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_swm12_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_swm12_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_swm12_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot_a_corrective_animation" "v_swm12_anims\shoot_a_corrective_animation.smd" {
}

$animation "shoot_ironsight_a_corrective_animation" "v_swm12_anims\shoot_ironsight_a_corrective_animation.smd" {
}

$animation "shoot_w_a_corrective_animation" "v_swm12_anims\shoot_w_a_corrective_animation.smd" {
}

$animation "shoot_w_ironsight_a_corrective_animation" "v_swm12_anims\shoot_w_ironsight_a_corrective_animation.smd" {
}

$animation "shoot_p_a_corrective_animation" "v_swm12_anims\shoot_p_a_corrective_animation.smd" {
}

$animation "shoot_p_ironsight_a_corrective_animation" "v_swm12_anims\shoot_p_ironsight_a_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_swm12_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_swm12_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "PoseDelta" "v_swm12_anims\PoseDelta.smd" {
	fps 30
	
	
}

$animation "Default" "v_swm12_anims\Default.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Default_corrective_animation" 0
}

$animation "Bullet5" "v_swm12_anims\Bullet5.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet5_corrective_animation" 0
}

$animation "Bullet4" "v_swm12_anims\Bullet4.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet4_corrective_animation" 0
}

$animation "Bullet3" "v_swm12_anims\Bullet3.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet3_corrective_animation" 0
}

$animation "Bullet2" "v_swm12_anims\Bullet2.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet2_corrective_animation" 0
}

$animation "Bullet1" "v_swm12_anims\Bullet1.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet1_corrective_animation" 0
}

$animation "Bullet0" "v_swm12_anims\Bullet0.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet0_corrective_animation" 0
}

$animation "basePose_a" "v_swm12_anims\basePose_a.smd" {
	fps 30
	numframes 60
}

$animation "ironsight" "v_swm12_anims\ironsight.smd" {
	fps 30
	frame 1 1
	numframes 60
	
	
}

$animation "ironsight_transition" "v_swm12_anims\ironsight_transition.smd" {
	fps 30
	frame 0 1
	numframes 60
	
	
}

$animation "runIdle_a" "v_swm12_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_swm12_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_swm12_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_swm12_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "idle_delayed_a" "v_swm12_anims\idle_delayed_a.smd" {
	fps 30
	
	
}

$animation "ironsight_delayed" "v_swm12_anims\ironsight_delayed.smd" {
	fps 30
	frame 0 1
	numframes 60
	
	
}

$animation "ironsight_transition_delayed" "v_swm12_anims\ironsight_transition_delayed.smd" {
	fps 30
	frame 0 1
	numframes 60
	
	
}

$animation "idle_western_a" "v_swm12_anims\idle_western_a.smd" {
	fps 30
	
	
}

$animation "ironsight_western" "v_swm12_anims\ironsight_western.smd" {
	fps 30
	frame 0 1
	numframes 60
	
	
}

$animation "ironsight_transition_western" "v_swm12_anims\ironsight_transition_western.smd" {
	fps 30
	frame 0 1
	numframes 60
	
	
}

$animation "shoot_a" "v_swm12_anims\shoot_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_a_corrective_animation" 0
}

$animation "shoot_ironsight_a" "v_swm12_anims\shoot_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_ironsight_a_corrective_animation" 0
}

$animation "shoot_w_a" "v_swm12_anims\shoot_w_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_w_a_corrective_animation" 0
}

$animation "shoot_w_ironsight_a" "v_swm12_anims\shoot_w_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_w_ironsight_a_corrective_animation" 0
}

$animation "shoot_p_a" "v_swm12_anims\shoot_p_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_p_a_corrective_animation" 0
}

$animation "shoot_p_ironsight_a" "v_swm12_anims\shoot_p_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_p_ironsight_a_corrective_animation" 0
}

$animation "shoot1_a" "v_swm12_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_swm12_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "d_nearwall_s_a" "v_swm12_anims\d_nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a" "v_swm12_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "w_nearwall_s_a" "v_swm12_anims\w_nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "d_nearwall_s_a_i" "v_swm12_anims\d_nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_swm12_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "w_nearwall_s_a_i" "v_swm12_anims\w_nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "d_nearwall_a" "v_swm12_anims\d_nearwall_a.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_swm12_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "w_nearwall_a" "v_swm12_anims\w_nearwall_a.smd" {
	fps 30
	
	
}

$animation "d_nearwall_a_i" "v_swm12_anims\d_nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a_i" "v_swm12_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "w_nearwall_a_i" "v_swm12_anims\w_nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "d_nearwall_e_a" "v_swm12_anims\d_nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_swm12_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "w_nearwall_e_a" "v_swm12_anims\w_nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "d_nearwall_e_a_i" "v_swm12_anims\d_nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_swm12_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "w_nearwall_e_a_i" "v_swm12_anims\w_nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "d_proneF" "v_swm12_anims\d_proneF.smd" {
	fps 30
	
	
}

$animation "d_proneB" "v_swm12_anims\d_proneB.smd" {
	fps 30
	
	
}

$animation "d_proneL" "v_swm12_anims\d_proneL.smd" {
	fps 30
	
	
}

$animation "d_proneR" "v_swm12_anims\d_proneR.smd" {
	fps 30
	
	
}

$animation "proneF" "v_swm12_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_swm12_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_swm12_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_swm12_anims\proneR.smd" {
	fps 30
	
	
}

$animation "w_proneF" "v_swm12_anims\w_proneF.smd" {
	fps 30
	
	
}

$animation "w_proneB" "v_swm12_anims\w_proneB.smd" {
	fps 30
	
	
}

$animation "w_proneL" "v_swm12_anims\w_proneL.smd" {
	fps 30
	
	
}

$animation "w_proneR" "v_swm12_anims\w_proneR.smd" {
	fps 30
	
	
}

$animation "d_pickup_s_a" "v_swm12_anims\d_pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_swm12_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "w_pickup_s_a" "v_swm12_anims\w_pickup_s_a.smd" {
	fps 30
	
	
}

$animation "d_pickup_s_a_i" "v_swm12_anims\d_pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_swm12_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "w_pickup_s_a_i" "v_swm12_anims\w_pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "d_pickup_a" "v_swm12_anims\d_pickup_a.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_swm12_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "w_pickup_a" "v_swm12_anims\w_pickup_a.smd" {
	fps 30
	
	
}

$animation "d_pickup_a_i" "v_swm12_anims\d_pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a_i" "v_swm12_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "w_pickup_a_i" "v_swm12_anims\w_pickup_a_i.smd" {
	fps 30
	
	
}

$animation "d_pickup_e_a" "v_swm12_anims\d_pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_swm12_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "w_pickup_e_a" "v_swm12_anims\w_pickup_e_a.smd" {
	fps 30
	
	
}

$animation "d_pickup_e_a_i" "v_swm12_anims\d_pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_swm12_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "w_pickup_e_a_i" "v_swm12_anims\w_pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "change_firemode_towestern_a" "v_swm12_anims\change_firemode_towestern_a.smd" {
	fps 30
	
	
}

$animation "change_firemode_towestern_iron_a" "v_swm12_anims\change_firemode_towestern_iron_a.smd" {
	fps 30
	
	
}

$animation "change_firemode_todelayed_a" "v_swm12_anims\change_firemode_todelayed_a.smd" {
	fps 30
	
	
}

$animation "change_firemode_todelayed_iron_a" "v_swm12_anims\change_firemode_todelayed_iron_a.smd" {
	fps 30
	
	
}

$animation "change_firemode_tonormal_a" "v_swm12_anims\change_firemode_tonormal_a.smd" {
	fps 30
	
	
}

$animation "change_firemode_tonormal_iron_a" "v_swm12_anims\change_firemode_tonormal_iron_a.smd" {
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
	"v_swm12_anims\FirstDraw.smd"
	"v_swm12_anims\FirstDraw_2.smd"
	"v_swm12_anims\FirstDraw_3.smd"
	"v_swm12_anims\FirstDraw_4.smd"
	"v_swm12_anims\FirstDraw_5.smd"
	"v_swm12_anims\FirstDraw_6.smd"
	activity "ACT_VM_READY" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M1917.Draw" }
	{ event 5004 10 "MCV_Weapon_Foley_M1917.DrawMetal" }
	fadein 0
	fadeout 0.2
	addlayer "walklayerironsight"
	node "0"
	fps 30
}

$sequence "draw" {
	"v_swm12_anims\draw.smd"
	"v_swm12_anims\draw_2.smd"
	"v_swm12_anims\draw_3.smd"
	"v_swm12_anims\draw_4.smd"
	"v_swm12_anims\draw_5.smd"
	"v_swm12_anims\draw_6.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M1917.Draw" }
	fadein 0
	fadeout 0.2
	addlayer "walklayerironsight"
	node "0"
	fps 30
	  
	
}

$sequence "shoot_hammer" {
	"basePose_a"
	"ironsight_transition"
	"ironsight"
	"idle_delayed_a"
	"ironsight_transition_delayed"
	"ironsight_delayed"
	"idle_western_a"
	"ironsight_transition_western"
	"ironsight_western"
	activity "ACT_VM_PRIMARYATTACK" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	{ event 5004 10 "MCV_Weapon_Foley_Revolver.Hand" }
	{ event 5004 15 "MCV_Weapon_Foley_Revolver.HammerOut" }
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	{ event AE_MUZZLEFLASH 0 "" }
	snap
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "shoot_hammer_pose"
}

$sequence "shoot_hammer_pose" {
	"shoot_a"
	"shoot_ironsight_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	snap
	hidden
}

$sequence "shoot_western" {
	"basePose_a"
	"ironsight_transition"
	"ironsight"
	"idle_delayed_a"
	"ironsight_transition_delayed"
	"ironsight_delayed"
	"idle_western_a"
	"ironsight_transition_western"
	"ironsight_western"
	activity "ACT_VM_PRIMARYATTACK_1" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	{ event 5004 0 "MCV_Weapon_Foley_Revolver.HammerStrike" }
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	{ event AE_MUZZLEFLASH 0 "" }
	snap
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "shoot_western_pose"
}

$sequence "shoot_western_pose" {
	"shoot_w_a"
	"shoot_w_ironsight_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	snap
	hidden
}

$sequence "prepare_delayed" {
	"basePose_a"
	"ironsight_transition"
	"ironsight"
	"idle_delayed_a"
	"ironsight_transition_delayed"
	"ironsight_delayed"
	"idle_western_a"
	"ironsight_transition_western"
	"ironsight_western"
	activity "ACT_VM_HAULBACK" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	{ event 5004 0 "MCV_Weapon_Foley_Revolver.HammerOutSlow" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	addlayer "prepare_delayed_pose"
}

$sequence "prepare_delayed_pose" {
	"shoot_p_a"
	"shoot_p_ironsight_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	snap
	hidden
}

$sequence "shoot_delayed" {
	"basePose_a"
	"ironsight_transition"
	"ironsight"
	"idle_delayed_a"
	"ironsight_transition_delayed"
	"ironsight_delayed"
	"idle_western_a"
	"ironsight_transition_western"
	"ironsight_western"
	activity "ACT_VM_PRIMARYATTACK_2" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	snap
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "shoot_delayed_pose"
}

$sequence "shoot_delayed_pose" {
	"shoot1_a"
	"shoot1_ironsight_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	snap
	hidden
}

$sequence "reload" {
	"v_swm12_anims\reload.smd"
	"v_swm12_anims\reload_2.smd"
	"v_swm12_anims\reload_3.smd"
	"v_swm12_anims\reload_4.smd"
	"v_swm12_anims\reload_5.smd"
	"v_swm12_anims\reload_6.smd"
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
	"v_swm12_anims\bash.smd"
	"v_swm12_anims\bash_2.smd"
	"v_swm12_anims\bash_3.smd"
	"v_swm12_anims\bash_4.smd"
	"v_swm12_anims\bash_5.smd"
	"v_swm12_anims\bash_6.smd"
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
	"v_swm12_anims\holster.smd"
	"v_swm12_anims\holster_2.smd"
	"v_swm12_anims\holster_3.smd"
	activity "ACT_VM_HOLSTER" 1
	blend "revolver_firemode_pose" 0 1
	blendwidth 3
	{ event 5004 1 "MCV_Weapon_Foley_SWM12.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
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
	activity "ACT_VM_IFIREMODE" 1
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
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\pistol_swm12\swm12_new.qc"
//	}
}

// Created by Crowbar 0.74

$modelname "weapons/mcv/v_dual_m1895.mdl"

$bodygroup "studio"
{
	studio "ref_new.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 0.814 -5.573 -3.534

$cdmaterials "models\weapons\mcv\v_m1895\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "BaseMesh" -7.1 0 0.8 rotate 0 180 0
$attachment "muzzle2" "BaseLeftMesh" -7.1 0 0.8 rotate 0 180 0

$cbox 0 0 0 0 0 0

$bbox -17.129 -19.789 -31.979 28.274 21.416 24.911

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
$definebone "BaseMesh" "hand_r" 17.944706 11.122166 28.291027 75.00019 90.005139 0.003831 0 0 0 0 0 0
$definebone "Hammer" "BaseMesh" 1.709823 -0.022407 -0.649801 0.00012 0.000057 -0.000009 0 0 0 0 0 0
$definebone "CyCloser" "BaseMesh" 0.686922 0.55922 -0.638972 0.00012 0.000057 -0.000009 0 0 0 0 0 0
$definebone "Cy" "BaseMesh" -0.694048 -0.05092 0.181682 0.00012 0.000057 -0.000009 0 0 0 0 0 0
$definebone "Bullet.001" "Cy" 0.010786 0.452353 0.367307 0.000005 0 -0.000009 0 0 0 0 0 0
$definebone "Bullet.002" "Cy" 0.010786 -0.576877 -0.136375 0.000005 0 -0.000009 0 0 0 0 0 0
$definebone "PusherHolder" "BaseMesh" -2.90365 -0.055237 0.764853 0.00012 0.000057 -0.000009 0 0 0 0 0 0
$definebone "Pusher" "PusherHolder" -0.46398 0.002532 -0.634765 0.000005 0 -0.000009 0 0 0 0 0 0
$definebone "Trigger" "BaseMesh" -0.38315 -0.019974 -1.204661 0.00012 0.000057 0.000049 0 0 0 0 0 0
$definebone "rhand_ikTarget" "BaseMesh" 11.487101 6.785776 -1.95843 0.00012 0.000057 -0.000009 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" 5.511815 0.000008 -0.000001 -0.000447 179.999759 166.489945 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" 0.196847 -0.000001 0.000003 0.00034 -179.999103 160.050416 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 4.678655 -1.075636 -1.488978 66.457918 105.584814 113.208535 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.214485 0.000006 0.00002 39.360369 -8.439261 13.804507 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.944885 -0.000029 -0.000194 -11.598263 -34.295486 -3.613932 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620166 0.000002 0.00001 -40.973745 21.950707 -97.528066 0 0 0 0 0 0
$definebone "BaseLeftMesh" "hand_l" -16.662228 -11.121649 -28.291414 -75.00004 -90.000003 -179.999978 0 0 0 0 0 0
$definebone "HammerLeft" "BaseLeftMesh" 1.709824 -0.022406 -0.6498 -0.000003 0.00017 0.000014 0 0 0 0 0 0
$definebone "CyCloserLeft" "BaseLeftMesh" 0.686924 0.55922 -0.638973 -0.000003 0.00017 0.000014 0 0 0 0 0 0
$definebone "CyLeft" "BaseLeftMesh" -0.694052 -0.050922 0.181683 -0.000003 0.00017 0.000014 0 0 0 0 0 0
$definebone "BulletLeft" "CyLeft" 0.010788 0.452354 0.367306 -0.000003 -0.000002 0.000014 0 0 0 0 0 0
$definebone "Bullet.004" "CyLeft" 0.010784 -0.576877 -0.136377 -0.000003 -0.000002 0.000014 0 0 0 0 0 0
$definebone "PusherHolderLeft" "BaseLeftMesh" -2.903652 -0.055242 0.764855 -0.000003 0.00017 0.000014 0 0 0 0 0 0
$definebone "PusherLeft" "PusherHolderLeft" -0.463982 0.002532 -0.634766 -0.000003 -0.000002 0.000014 0 0 0 0 0 0
$definebone "TriggerLeft" "BaseLeftMesh" -0.38315 -0.019977 -1.204664 -0.000003 0.00017 0.000014 0 0 0 0 0 0
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
$definebone "lhand_ikTarget" "BaseLeftMesh" 6.482468 -0.878394 -2.889333 -6.081554 -85.939981 179.258889 0 0 0 0 0 0

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
$bonemerge "lowerarm_twist_01_r"
$bonemerge "upperarm_twist_01_r"
$bonemerge "clavicle_l"
$bonemerge "upperarm_l"
$bonemerge "lowerarm_l"
$bonemerge "hand_l"
$bonemerge "BaseLeftMesh"
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
$bonemerge "lhand_ikTarget"

$include "../../militaryconflict_vietnam_v2.qci"

$sectionframes 30 29

$poseparameter "player_movement" 0 260 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "revolver_firemode_pose" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "runIdle_a_corrective_animation" "v_dual_m1895_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_dual_m1895_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_dual_m1895_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_dual_m1895_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot_r_a_corrective_animation" "v_dual_m1895_anims\shoot_r_a_corrective_animation.smd" {
}

$animation "shoot_r_ironsight_a_corrective_animation" "v_dual_m1895_anims\shoot_r_ironsight_a_corrective_animation.smd" {
}

$animation "shoot_l_a_corrective_animation" "v_dual_m1895_anims\shoot_l_a_corrective_animation.smd" {
}

$animation "shoot_l_ironsight_a_corrective_animation" "v_dual_m1895_anims\shoot_l_ironsight_a_corrective_animation.smd" {
}

$animation "shoot_p_r_a_corrective_animation" "v_dual_m1895_anims\shoot_p_r_a_corrective_animation.smd" {
}

$animation "shoot_p_r_ironsight_a_corrective_animation" "v_dual_m1895_anims\shoot_p_r_ironsight_a_corrective_animation.smd" {
}

$animation "shoot_p_l_a_corrective_animation" "v_dual_m1895_anims\shoot_p_l_a_corrective_animation.smd" {
}

$animation "shoot_p_l_ironsight_a_corrective_animation" "v_dual_m1895_anims\shoot_p_l_ironsight_a_corrective_animation.smd" {
}

$animation "shoot_d_r_a_corrective_animation" "v_dual_m1895_anims\shoot_d_r_a_corrective_animation.smd" {
}

$animation "shoot_d_r_ironsight_a_corrective_animation" "v_dual_m1895_anims\shoot_d_r_ironsight_a_corrective_animation.smd" {
}

$animation "shoot_d_l_a_corrective_animation" "v_dual_m1895_anims\shoot_d_l_a_corrective_animation.smd" {
}

$animation "shoot_d_l_ironsight_a_corrective_animation" "v_dual_m1895_anims\shoot_d_l_ironsight_a_corrective_animation.smd" {
}

$animation "basePose_a" "v_dual_m1895_anims\basePose_a.smd" {
	fps 30
	numframes 60
	
	
}

$animation "ironsight" "v_dual_m1895_anims\ironsight.smd" {
	fps 30
	frame 1 1
	numframes 60
	
	
}

$animation "ironsight_transition" "v_dual_m1895_anims\ironsight_transition.smd" {
	fps 30
	frame 0 1
	numframes 60
	
	
}

$animation "runIdle_a" "v_dual_m1895_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
}

$animation "run_a" "v_dual_m1895_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
}

$animation "walkIdle_a" "v_dual_m1895_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
}

$animation "walk_a" "v_dual_m1895_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
}

$animation "idle_delayed_a" "v_dual_m1895_anims\idle_delayed_a.smd" {
	fps 30
	
	
}

$animation "ironsight_delayed" "v_dual_m1895_anims\ironsight_delayed.smd" {
	fps 30
	frame 0 1
	numframes 60
	
	
}

$animation "ironsight_transition_delayed" "v_dual_m1895_anims\ironsight_transition_delayed.smd" {
	fps 30
	frame 0 1
	numframes 60
	
	
}

$animation "shoot_r_a" "v_dual_m1895_anims\shoot_r_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_r_a_corrective_animation" 0
}

$animation "shoot_r_ironsight_a" "v_dual_m1895_anims\shoot_r_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_r_ironsight_a_corrective_animation" 0
}

$animation "shoot_l_a" "v_dual_m1895_anims\shoot_l_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_l_a_corrective_animation" 0
}

$animation "shoot_l_ironsight_a" "v_dual_m1895_anims\shoot_l_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_l_ironsight_a_corrective_animation" 0
}

$animation "shoot_p_r_a" "v_dual_m1895_anims\shoot_p_r_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_p_r_a_corrective_animation" 0
}

$animation "shoot_p_r_ironsight_a" "v_dual_m1895_anims\shoot_p_r_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_p_r_ironsight_a_corrective_animation" 0
}

$animation "shoot_p_l_a" "v_dual_m1895_anims\shoot_p_l_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_p_l_a_corrective_animation" 0
}

$animation "shoot_p_l_ironsight_a" "v_dual_m1895_anims\shoot_p_l_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_p_l_ironsight_a_corrective_animation" 0
}

$animation "shoot_d_r_a" "v_dual_m1895_anims\shoot_d_r_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_d_r_a_corrective_animation" 0
}

$animation "shoot_d_r_ironsight_a" "v_dual_m1895_anims\shoot_d_r_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_d_r_ironsight_a_corrective_animation" 0
}

$animation "shoot_d_l_a" "v_dual_m1895_anims\shoot_d_l_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_d_l_a_corrective_animation" 0
}

$animation "shoot_d_l_ironsight_a" "v_dual_m1895_anims\shoot_d_l_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot_d_l_ironsight_a_corrective_animation" 0
}

$animation "reload_s" "v_dual_m1895_anims\reload_s.smd" {
	fps 30
	
	
}

$animation "reload_s_i" "v_dual_m1895_anims\reload_s_i.smd" {
	fps 30
	
	
}

$animation "reload_s_d" "v_dual_m1895_anims\reload_s_d.smd" {
	fps 30
	
	
}

$animation "reload_s_d_i" "v_dual_m1895_anims\reload_s_d_i.smd" {
	fps 30
	
	
}

$animation "reload_l" "v_dual_m1895_anims\reload_l.smd" {
	fps 30
	loop
	
	
}

$animation "reload_l_i" "v_dual_m1895_anims\reload_l_i.smd" {
	fps 30
	
	
}

$animation "reload_l_d" "v_dual_m1895_anims\reload_l_d.smd" {
	fps 30
	
	
}

$animation "reload_l_d_i" "v_dual_m1895_anims\reload_l_d_i.smd" {
	fps 30
	
	
}

$animation "reload_e" "v_dual_m1895_anims\reload_e.smd" {
	fps 30
	
	
}

$animation "reload_e_i" "v_dual_m1895_anims\reload_e_i.smd" {
	fps 30
	
	
}

$animation "reload_e_d" "v_dual_m1895_anims\reload_e_d.smd" {
	fps 30
	
	
}

$animation "reload_e_d_i" "v_dual_m1895_anims\reload_e_d_i.smd" {
	fps 30
	
	
}

$animation "reload_ch" "v_dual_m1895_anims\reload_ch.smd" {
	fps 30
	
	
}

$animation "reload_ch_i" "v_dual_m1895_anims\reload_ch_i.smd" {
	fps 30
	
	
}

$animation "reload_ch_d" "v_dual_m1895_anims\reload_ch_d.smd" {
	fps 30
	
	
}

$animation "reload_ch_d_i" "v_dual_m1895_anims\reload_ch_d_i.smd" {
	fps 30
	
	
}

$animation "reload_l_l" "v_dual_m1895_anims\reload_l_l.smd" {
	fps 30
	loop
	
	
}

$animation "reload_l_l_i" "v_dual_m1895_anims\reload_l_l_i.smd" {
	fps 30
	
	
}

$animation "reload_l_l_d" "v_dual_m1895_anims\reload_l_l_d.smd" {
	fps 30
	
	
}

$animation "reload_l_l_d_i" "v_dual_m1895_anims\reload_l_l_d_i.smd" {
	fps 30
	
	
}

$animation "reload_e_l" "v_dual_m1895_anims\reload_e_l.smd" {
	fps 30
	
	
}

$animation "reload_e_l_i" "v_dual_m1895_anims\reload_e_l_i.smd" {
	fps 30
	
	
}

$animation "reload_e_l_d" "v_dual_m1895_anims\reload_e_l_d.smd" {
	fps 30
	
	
}

$animation "reload_e_l_d_i" "v_dual_m1895_anims\reload_e_l_d_i.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a" "v_dual_m1895_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_dual_m1895_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_d_s_a" "v_dual_m1895_anims\nearwall_d_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_d_s_a_i" "v_dual_m1895_anims\nearwall_d_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_dual_m1895_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_dual_m1895_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_d_a" "v_dual_m1895_anims\nearwall_d_a.smd" {
	fps 30
	
	
}

$animation "nearwall_d_a_i" "v_dual_m1895_anims\nearwall_d_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_dual_m1895_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_dual_m1895_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_d_e_a" "v_dual_m1895_anims\nearwall_d_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_d_e_a_i" "v_dual_m1895_anims\nearwall_d_e_a_i.smd" {
	fps 30
	
	
}

$animation "proneF" "v_dual_m1895_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_dual_m1895_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_dual_m1895_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_dual_m1895_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pronedF" "v_dual_m1895_anims\pronedF.smd" {
	fps 30
	
	
}

$animation "pronedB" "v_dual_m1895_anims\pronedB.smd" {
	fps 30
	
	
}

$animation "pronedL" "v_dual_m1895_anims\pronedL.smd" {
	fps 30
	
	
}

$animation "pronedR" "v_dual_m1895_anims\pronedR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_dual_m1895_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_dual_m1895_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_d_s_a" "v_dual_m1895_anims\pickup_d_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_d_s_a_i" "v_dual_m1895_anims\pickup_d_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_dual_m1895_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_dual_m1895_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_d_a" "v_dual_m1895_anims\pickup_d_a.smd" {
	fps 30
	
	
}

$animation "pickup_d_a_i" "v_dual_m1895_anims\pickup_d_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_dual_m1895_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_dual_m1895_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_d_e_a" "v_dual_m1895_anims\pickup_d_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_d_e_a_i" "v_dual_m1895_anims\pickup_d_e_a_i.smd" {
	fps 30
	
	
}

$animation "change_firemode_todelayed_a" "v_dual_m1895_anims\change_firemode_todelayed_a.smd" {
	fps 30
	
	
}

$animation "change_firemode_todelayed_iron_a" "v_dual_m1895_anims\change_firemode_todelayed_iron_a.smd" {
	fps 30
	
	
}

$animation "change_firemode_tonormal_a" "v_dual_m1895_anims\change_firemode_tonormal_a.smd" {
	fps 30
	
	
}

$animation "change_firemode_tonormal_iron_a" "v_dual_m1895_anims\change_firemode_tonormal_iron_a.smd" {
	fps 30
	
	
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
}

$sequence "FirstDraw" {
	"v_dual_m1895_anims\FirstDraw.smd"
	"v_dual_m1895_anims\FirstDraw_2.smd"
	activity "ACT_VM_READY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event AE_WPN_SET_POSEPARAM 4 "revolver_firemode_pose 0" }
	{ event 5004 1 "MCV_Weapon_Foley_M1895.Draw" }
	{ event 5004 10 "MCV_Weapon_Foley_Revolver.HammerOut" }
	{ event 5004 12 "MCV_Weapon_Foley_Revolver.HammerOut" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
	fps 30
	
	
}

$sequence "draw" {
	"v_dual_m1895_anims\draw.smd"
	"v_dual_m1895_anims\draw_2.smd"
	"v_dual_m1895_anims\draw_3.smd"
	"v_dual_m1895_anims\draw_4.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	{ event 5004 1 "MCV_Weapon_Foley_M1895.Draw" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
	fps 30
	  
	
}

$sequence "shoot_hammer_right" {
	"basePose_a"
	"ironsight_transition"
	"ironsight"
	"idle_delayed_a"
	"ironsight_transition_delayed"
	"ironsight_delayed"
	activity "ACT_VM_PRIMARYATTACK" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	blendwidth 3
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	addlayer "shoot_hammer_right_pose"
}

$sequence "shoot_hammer_right_pose" {
	"shoot_r_a"
	"shoot_r_ironsight_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event 5004 10 "MCV_Weapon_Foley_Revolver.Hand" }
	{ event 5004 15 "MCV_Weapon_Foley_Revolver.HammerOut" }
	snap
	hidden
}

$sequence "shoot_hammer_left" {
	"basePose_a"
	"ironsight_transition"
	"ironsight"
	"idle_delayed_a"
	"ironsight_transition_delayed"
	"ironsight_delayed"
	activity "ACT_VM_SECONDARYATTACK" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	blendwidth 3
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	addlayer "shoot_hammer_left_pose"
}

$sequence "shoot_hammer_left_pose" {
	"shoot_l_a"
	"shoot_l_ironsight_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event 5004 10 "MCV_Weapon_Foley_Revolver.Hand" }
	{ event 5004 15 "MCV_Weapon_Foley_Revolver.HammerOut" }
	snap
	hidden
}

$sequence "prepare_delayed_right" {
	"basePose_a"
	"ironsight_transition"
	"ironsight"
	"idle_delayed_a"
	"ironsight_transition_delayed"
	"ironsight_delayed"
	activity "ACT_VM_HAULBACK" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	blendwidth 3
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	addlayer "prepare_delayed_right_pose"
}

$sequence "prepare_delayed_right_pose" {
	"shoot_p_r_a"
	"shoot_p_r_ironsight_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event 5004 0 "MCV_Weapon_Foley_Revolver.HammerOutSlow" }
	snap
	hidden
}

$sequence "prepare_delayed_left" {
	"basePose_a"
	"ironsight_transition"
	"ironsight"
	"idle_delayed_a"
	"ironsight_transition_delayed"
	"ironsight_delayed"
	activity "ACT_VM_PULLPIN" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	blendwidth 3
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	addlayer "prepare_delayed_left_pose"
}

$sequence "prepare_delayed_left_pose" {
	"shoot_p_l_a"
	"shoot_p_l_ironsight_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event 5004 0 "MCV_Weapon_Foley_Revolver.HammerOutSlow" }
	snap
	hidden
}

$sequence "shoot_delayed_right" {
	"basePose_a"
	"ironsight_transition"
	"ironsight"
	"idle_delayed_a"
	"ironsight_transition_delayed"
	"ironsight_delayed"
	activity "ACT_VM_PRIMARYATTACK_2" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	blendwidth 3
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	addlayer "shoot_delayed_right_pose"
}

$sequence "shoot_delayed_right_pose" {
	"shoot_d_r_a"
	"shoot_d_r_ironsight_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	snap
	hidden
}

$sequence "shoot_delayed_left" {
	"basePose_a"
	"ironsight_transition"
	"ironsight"
	"idle_delayed_a"
	"ironsight_transition_delayed"
	"ironsight_delayed"
	activity "ACT_VM_PRIMARYATTACK_3" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	blendwidth 3
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	addlayer "shoot_delayed_left_pose"
}

$sequence "shoot_delayed_left_pose" {
	"shoot_d_l_a"
	"shoot_d_l_ironsight_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	snap
	hidden
}

$sequence "reload_start" {
	"reload_s"
	"reload_s_i"
	"reload_s_d"
	"reload_s_d_i"
	activity "ACT_SHOTGUN_RELOAD_START" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	{ event 5004 1 "MCV_Weapon_Foley_M1895_Reload.Start" }
	{ event 5004 2 "MCV_Weapon_Foley_M1895_Reload.Hand" }
	fadein 0.05
	fadeout 0.05
	addlayer "walklayerironsight"
	node "0"
}

$sequence "reload_insert" {
	"reload_l"
	"reload_l_i"
	"reload_l_d"
	"reload_l_d_i"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	{ event 5004 0 "MCV_Weapon_Foley_M1895_Reload.Mid_Eject" }
	{ event 5004 4 "MCV_Weapon_Foley_M1895_Reload.Mid_Insert" }
	{ event 5004 8 "MCV_Weapon_Foley_M1895_Reload.Mid_Spin" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	node "0"
	snap
}

$sequence "reload_end_right" {
	"reload_e"
	"reload_e_i"
	"reload_e_d"
	"reload_e_d_i"
	activity "ACT_VM_RELOAD_END_EMPTY" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	{ event 5004 1 "MCV_Weapon_Foley_M1895_Reload.End" }
	{ event 5004 2 "MCV_Weapon_Foley_M1895_Reload.HandEnd" }
	fadein 0.05
	fadeout 0.2
	addlayer "walklayerironsight"
	node "0"
}

$sequence "reload_changehand" {
	"reload_ch"
	"reload_ch_i"
	"reload_ch_d"
	"reload_ch_d_i"
	activity "ACT_VM_RELOAD_END" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	{ event 5004 1 "MCV_Weapon_Foley_M1895_Reload.Start" }
	{ event 5004 2 "MCV_Weapon_Foley_M1895_Reload.Hand" }
	fadein 0.05
	fadeout 0.05
	addlayer "walklayerironsight"
	node "0"
}

$sequence "reload_insert_left" {
	"reload_l_l"
	"reload_l_l_i"
	"reload_l_l_d"
	"reload_l_l_d_i"
	activity "ACT_VM_RELOAD2" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	{ event 5004 0 "MCV_Weapon_Foley_M1895_Reload.Mid_Eject" }
	{ event 5004 4 "MCV_Weapon_Foley_M1895_Reload.Mid_Insert" }
	{ event 5004 8 "MCV_Weapon_Foley_M1895_Reload.Mid_Spin" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	node "0"
	snap
}

$sequence "reload_end_left" {
	"reload_e_l"
	"reload_e_l_i"
	"reload_e_l_d"
	"reload_e_l_d_i"
	activity "ACT_SHOTGUN_RELOAD_FINISH" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	{ event 5004 1 "MCV_Weapon_Foley_M1895_Reload.End" }
	{ event 5004 2 "MCV_Weapon_Foley_M1895_Reload.HandEnd" }
	fadein 0.05
	fadeout 0.2
	addlayer "walklayerironsight"
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
	realtime
}

$sequence "bash" {
	"v_dual_m1895_anims\bash.smd"
	"v_dual_m1895_anims\bash_2.smd"
	"v_dual_m1895_anims\bash_3.smd"
	"v_dual_m1895_anims\bash_4.smd"
	activity "ACT_VM_HITCENTER" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
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
	"pickup_d_s_a"
	"pickup_d_s_a_i"
	activity "ACT_VM_PICKUPSTART" 1
	blend "ironsight" 0 1
	blend "revolver_firemode_pose" 0 1
	{ event 5004 1 "MCV_Weapon_Foley_CommonSmall.In" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
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
}

$sequence "holster" {
	"v_dual_m1895_anims\holster.smd"
	"v_dual_m1895_anims\holster_2.smd"
	activity "ACT_VM_HOLSTER" 1
	blend "revolver_firemode_pose" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M1895.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
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

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\dualpistol_m1895\dualm1895.qc"
//	}
}

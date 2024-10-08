// Created by Crowbar 0.74

$modelname "weapons/mcv/v_m1g_s.mdl"

$bodygroup "studio"
{
	studio "ref_new.smd"
}
$bodygroup "sight"
{
	studio "m1g_ironsight_new.smd"
}
$bodygroup "bayonet"
{
	blank
	studio "v_bayonet_new.smd"
	studio "v_bayonet_long_new.smd"
}
$bodygroup "scope"
{
	studio "m1g_scope_new.smd"
	blank
}
$bodygroup "mount"
{
	blank
	studio "m1g_mount_new.smd"
}
$bodygroup "grenade"
{
	blank
	studio "m1g_grenade_new.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition -1.348 -28.728 -13.236

$mostlyopaque

$cdmaterials "models\weapons\mcv\v_m1g_s\"
$cdmaterials "models\weapons\mcv\v_bayonet\"
$cdmaterials "models\weapons\mcv\v_m1905_bayonet\"
$cdmaterials "models\weapons\mcv\shells\"
$cdmaterials "models\weapons\mcv\optics\"
$cdmaterials "models\weapons\mcv\rif_gl\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "Base" -30.3 0 1.55 rotate -0.2 179.9 0
$attachment "eject" "Base" 0.2 0 1.5 rotate -20 90 0

$cbox 0 0 0 0 0 0

$bbox -9.182 -12.609 -27.51 66.637 9.914 1.039

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
$definebone "Base" "" -3.461899 -18.154814 -3.245792 0 89.999989 0 0 0 0 0 0 0
$definebone "Mag" "Base" 17.819454 -0.067795 -10.465799 0 0 0 0 0 0 0 0 0
$definebone "Bullet" "Mag" -1.815839 -0.0768 0.093879 0 0 0 0 0 0 0 0 0
$definebone "BulletMove" "Bullet" 0.486882 -0.169641 0.888871 0 0 0 0 0 0 0 0 0
$definebone "BulletMove.001" "Bullet" 0.45322 0.336866 0.664926 0 0 0 0 0 0 0 0 0
$definebone "BulletMove.002" "Bullet" 0.45322 -0.170683 0.321432 0 0 0 0 0 0 0 0 0
$definebone "BulletMove.003" "Bullet" 0.45322 0.336866 0.100983 0 0 0 0 0 0 0 0 0
$definebone "BulletMove.004" "Bullet" 0.45322 -0.17581 -0.242511 0 0 0 0 0 0 0 0 0
$definebone "BulletMove.005" "Bullet" 0.45322 0.341993 -0.462961 0 0 0 0 0 0 0 0 0
$definebone "BulletMove.006" "Bullet" 0.45322 -0.17581 -0.785948 0 0 0 0 0 0 0 0 0
$definebone "BulletMove.007" "Bullet" 0.45322 0.336866 -0.991017 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" 4.99699 -0.079616 -1.5178 0 0 0 0 0 0 0 0 0
$definebone "Bolt" "Base" 0.633913 0.835282 1.387999 0 0 0 0 0 0 0 0 0
$definebone "BoltRotate" "Bolt" -0.298975 -0.852933 -0.060855 0 0 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 13.548346 7.682785 -2.277167 0 0 0 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" 13.548346 -4.517508 -2.277167 0 0 0 0 0 0 0 0 0
$definebone "Bayonet" "Base" -27.088066 0.008976 -0.271634 0 0 0 0 0 0 0 0 0
$definebone "Grenade" "Base" -35.274986 0.008976 1.545426 0 0 0 0 0 0 0 0 0

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
$poseparameter "player_movement" 0 276 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "Slideback_corrective_animation" "v_m1g_s_anims\Slideback_corrective_animation.smd" {
}

$animation "Default_corrective_animation" "v_m1g_s_anims\Default_corrective_animation.smd" {
}

$animation "Bullet08_corrective_animation" "v_m1g_s_anims\Bullet08_corrective_animation.smd" {
}

$animation "Bullet07_corrective_animation" "v_m1g_s_anims\Bullet07_corrective_animation.smd" {
}

$animation "Bullet06_corrective_animation" "v_m1g_s_anims\Bullet06_corrective_animation.smd" {
}

$animation "Bullet05_corrective_animation" "v_m1g_s_anims\Bullet05_corrective_animation.smd" {
}

$animation "Bullet04_corrective_animation" "v_m1g_s_anims\Bullet04_corrective_animation.smd" {
}

$animation "Bullet03_corrective_animation" "v_m1g_s_anims\Bullet03_corrective_animation.smd" {
}

$animation "Bullet02_corrective_animation" "v_m1g_s_anims\Bullet02_corrective_animation.smd" {
}

$animation "Bullet01_corrective_animation" "v_m1g_s_anims\Bullet01_corrective_animation.smd" {
}

$animation "FullBullet_corrective_animation" "v_m1g_s_anims\FullBullet_corrective_animation.smd" {
}

$animation "runIdle_a_corrective_animation" "v_m1g_s_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_m1g_s_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_m1g_s_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_m1g_s_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_m1g_s_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_m1g_s_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_a_corrective_animation" "v_m1g_s_anims\shoot2_a_corrective_animation.smd" {
}

$animation "shoot2_ironsight_a_corrective_animation" "v_m1g_s_anims\shoot2_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3_a_corrective_animation" "v_m1g_s_anims\shoot3_a_corrective_animation.smd" {
}

$animation "shoot3_ironsight_a_corrective_animation" "v_m1g_s_anims\shoot3_ironsight_a_corrective_animation.smd" {
}

$animation "shootlast_a_corrective_animation" "v_m1g_s_anims\shootlast_a_corrective_animation.smd" {
}

$animation "shootlast_ironsight_a_corrective_animation" "v_m1g_s_anims\shootlast_ironsight_a_corrective_animation.smd" {
}

$animation "gren_shoot1_a_corrective_animation" "v_m1g_s_anims\gren_shoot1_a_corrective_animation.smd" {
}

$animation "gren_shoot1_ironsight_a_corrective_animation" "v_m1g_s_anims\gren_shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "PoseDelta" "v_m1g_s_anims\PoseDelta.smd" {
	fps 30
	
	
}

$animation "PoseDeltaEmpty" "v_m1g_s_anims\PoseDeltaEmpty.smd" {
	fps 30
	
	
}

$animation "Iron" "v_m1g_s_anims\Iron.smd" {
	fps 30
	
	
}

$animation "IronEmpty" "v_m1g_s_anims\IronEmpty.smd" {
	fps 30
	
	
}

$animation "PoseDelta2" "v_m1g_s_anims\PoseDelta2.smd" {
	fps 30
	
	
}

$animation "Default" "v_m1g_s_anims\Default.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Default_corrective_animation" 0
}

$animation "Slideback" "v_m1g_s_anims\Slideback.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Slideback_corrective_animation" 0
}

$animation "BulletDelta" "v_m1g_s_anims\BulletDelta.smd" {
	fps 30
	
	
}

$animation "FullBullet" "v_m1g_s_anims\FullBullet.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "FullBullet_corrective_animation" 0
}

$animation "Bullet01" "v_m1g_s_anims\Bullet01.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet01_corrective_animation" 0
}

$animation "Bullet02" "v_m1g_s_anims\Bullet02.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet02_corrective_animation" 0
}

$animation "Bullet03" "v_m1g_s_anims\Bullet03.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet03_corrective_animation" 0
}

$animation "Bullet04" "v_m1g_s_anims\Bullet04.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet04_corrective_animation" 0
}

$animation "Bullet05" "v_m1g_s_anims\Bullet05.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet05_corrective_animation" 0
}

$animation "Bullet06" "v_m1g_s_anims\Bullet06.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet06_corrective_animation" 0
}

$animation "Bullet07" "v_m1g_s_anims\Bullet07.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet07_corrective_animation" 0
}

$animation "Bullet08" "v_m1g_s_anims\Bullet08.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "Bullet08_corrective_animation" 0
}

$animation "basePose_a" "v_m1g_s_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "ironsight" "v_m1g_s_anims\ironsight.smd" {
	fps 0.5
	
	
}

$animation "ironsight_transition" "v_m1g_s_anims\ironsight_transition.smd" {
	fps 0.5
	
	
}

$animation "walkDelta" "v_m1g_s_anims\walkDelta.smd" {
	fps 30
	
	
}

$animation "runIdle_a" "v_m1g_s_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_m1g_s_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_m1g_s_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_m1g_s_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "shootdelta" "v_m1g_s_anims\shootdelta.smd" {
	fps 30
	
	
}

$animation "shoot1_a" "v_m1g_s_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_m1g_s_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "shoot2_a" "v_m1g_s_anims\shoot2_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_a_corrective_animation" 0
}

$animation "shoot2_ironsight_a" "v_m1g_s_anims\shoot2_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_ironsight_a_corrective_animation" 0
}

$animation "shoot3_a" "v_m1g_s_anims\shoot3_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_a_corrective_animation" 0
}

$animation "shoot3_ironsight_a" "v_m1g_s_anims\shoot3_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_ironsight_a_corrective_animation" 0
}

$animation "shootlast_a" "v_m1g_s_anims\shootlast_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_a_corrective_animation" 0
}

$animation "shootlast_ironsight_a" "v_m1g_s_anims\shootlast_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shootlast_ironsight_a_corrective_animation" 0
}

$animation "nearwall_s_a" "v_m1g_s_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_m1g_s_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_m1g_s_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_m1g_s_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_m1g_s_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_m1g_s_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "proneF" "v_m1g_s_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_m1g_s_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_m1g_s_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_m1g_s_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_m1g_s_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_m1g_s_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_m1g_s_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_m1g_s_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_m1g_s_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_m1g_s_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "grenade_ironsight" "v_m1g_s_anims\grenade_ironsight.smd" {
	fps 0.5
	
	
}

$animation "gren_shoot1_a" "v_m1g_s_anims\gren_shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "gren_shoot1_a_corrective_animation" 0
}

$animation "gren_shoot1_ironsight_a" "v_m1g_s_anims\gren_shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "gren_shoot1_ironsight_a_corrective_animation" 0
}

$animation "gren_reload_a" "v_m1g_s_anims\gren_reload_a.smd" {
	fps 30
	
	
}

$animation "gren_reload_a_i" "v_m1g_s_anims\gren_reload_a_i.smd" {
	fps 30
	
	
}

$animation "bayonet_unequip_a" "v_m1g_s_anims\bayonet_unequip_a.smd" {
	fps 30
	
	
}

$animation "bayonet_unequip_a_i" "v_m1g_s_anims\bayonet_unequip_a_i.smd" {
	fps 30
	
	
}

$animation "bayonet_equip_a" "v_m1g_s_anims\bayonet_equip_a.smd" {
	fps 30
	
	
}

$animation "bayonet_equip_a_i" "v_m1g_s_anims\bayonet_equip_a_i.smd" {
	fps 30
	
	
}

$animation "bash_a" "v_m1g_s_anims\bash_a.smd" {
	fps 30
	
	
}

$animation "bash_a_i" "v_m1g_s_anims\bash_a_i.smd" {
	fps 30
	
	
}

$animation "scope_adjust_idle" "v_m1g_s_anims\scope_adjust_idle.smd" {
	fps 30
	
	
}

$animation "scope_adjust_iron" "v_m1g_s_anims\scope_adjust_iron.smd" {
	fps 30
	
	
}

$animation "charge_s_a" "v_m1g_s_anims\charge_s_a.smd" {
	fps 30
	
	
}

$animation "charge_s_a_i" "v_m1g_s_anims\charge_s_a_i.smd" {
	fps 30
	
	
}

$animation "charge_a" "v_m1g_s_anims\charge_a.smd" {
	fps 30
	loop
	
	
}

$animation "charge_a_i" "v_m1g_s_anims\charge_a_i.smd" {
	fps 30
	
	
}

$animation "charge_e" "v_m1g_s_anims\charge_e.smd" {
	fps 30
	
	
}

$animation "charge_e_i" "v_m1g_s_anims\charge_e_i.smd" {
	fps 30
	
	
}

$sequence "SlidePosition" {
	"Slideback"
	"Default"
	blend "ammo_fraction" 0 0.11
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
	hidden
	node "0"
}

$sequence "BulletCounter" {
	"Bullet08"
	"Bullet07"
	"Bullet06"
	"Bullet05"
	"Bullet04"
	"Bullet03"
	"Bullet02"
	"Bullet01"
	"FullBullet"
	blend "ammo_fraction" 0 1
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
	blend "player_movement" 134 228
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
	"walkIdle_a"
	"walkIdle_a"
	"walkIdle_a"
	blend "player_movement" 0 276
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
	"v_m1g_s_anims\draw.smd"
	"v_m1g_s_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M1G.Draw" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	  
	
}

$sequence "Firstdraw" {
	"v_m1g_s_anims\Firstdraw.smd"
	"v_m1g_s_anims\Firstdraw_2.smd"
	activity "ACT_VM_FIRSTDRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M1G.Draw" }
	{ event 5004 12 "MCV_Weapon_Foley_M1G.DrawMetalStart" }
	{ event 5004 17 "MCV_Weapon_Foley_M1G.DrawMetalEnd" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
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
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
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
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
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
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "shootlast" {
	"shootlast_a"
	"shootlast_ironsight_a"
	activity "ACT_VM_SHOOTLAST" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	{ event AE_MUZZLEFLASH 0 "" }
	{ event 5004 1 "MCV_Weapon_Foley_M1G.LovelyClipPing" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 0 "ammo_fraction" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "reload" {
	"v_m1g_s_anims\reload.smd"
	"v_m1g_s_anims\reload_2.smd"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M1G_Reload.Hand" }
	{ event 5004 9 "MCV_Weapon_Foley_M1G_Reload.MetalMid" }
	{ event 5004 13 "MCV_Weapon_Foley_M1G.LovelyClipPing" }
	{ event 5004 35 "MCV_Weapon_Foley_M1G_Reload.MetalStart" }
	{ event 5004 54 "MCV_Weapon_Foley_M1G_Reload.MetalMid" }
	{ event 5004 65 "MCV_Weapon_Foley_M1G_Reload.MetalEnd" }
	{ event 5004 75 "MCV_Weapon_Foley_M1G_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 71 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 30 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	addlayer "BulletCounter"
	node "0"
	fps 30
	
	
}

$sequence "reload_empty" {
	"v_m1g_s_anims\reload_empty.smd"
	"v_m1g_s_anims\reload_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 3 "MCV_Weapon_Foley_M1G_Reload.Hand" }
	{ event 5004 35 "MCV_Weapon_Foley_M1G_Reload.MetalStart" }
	{ event 5004 54 "MCV_Weapon_Foley_M1G_Reload.MetalMid" }
	{ event 5004 65 "MCV_Weapon_Foley_M1G_Reload.MetalEnd" }
	{ event 5004 75 "MCV_Weapon_Foley_M1G_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 71 "" }
	{ event AE_WPN_CLIP_TO_POSEPARAM 1 "ammo_fraction" }
	{ event AE_WPN_NEXTCLIP_TO_POSEPARAM 30 "ammo_fraction" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	addlayer "BulletCounter"
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
	{ event 5004 1 "MCV_Weapon_Foley_Nearwall.Out" }
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
	{ event 5004 10 "MCV_Weapon_Foley_Movement.ProneCrawl_GunMedium" }
	fadein 0.3
	fadeout 0.3
	realtime
}

$sequence "bash" {
	"v_m1g_s_anims\bash.smd"
	"v_m1g_s_anims\bash_2.smd"
	activity "ACT_VM_BASH" 1
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
	{ event 5004 1 "MCV_Weapon_Foley_Pickup.In" }
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
	{ event 5004 1 "MCV_Weapon_Foley_Pickup.Out" }
	fadein 0.2
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
}

$sequence "gren_ironsight_test" {
	"grenade_ironsight"
	fadein 0.2
	fadeout 0.2
	hidden
	addlayer "walklayerironsight"
}

$sequence "grenade_idle" {
	"basePose_a"
	"ironsight_transition"
	activity "ACT_VM_GRENADE" 1
	blend "ironsight" 0 0.5
	blendwidth 2
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	blendlayer "gren_ironsight_test" 0 0 1 0 poseparameter ironsight
	node "0"
}

$sequence "grenade_shoot" {
	"gren_shoot1_a"
	"gren_shoot1_ironsight_a"
	activity "ACT_VM_GRENADE_SHOOT" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_MUZZLEFLASH 0 "" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "grenade_reload" {
	"gren_reload_a"
	"gren_reload_a_i"
	activity "ACT_VM_GRENADE_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_RifleGrenade.Raise" }
	{ event 5004 5 "MCV_Weapon_Foley_RifleGrenade.Attach" }
	{ event 5004 35 "MCV_Weapon_Foley_RifleGrenade.Lower" }
	fadein 0
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
}

$sequence "grenade_draw" {
	"v_m1g_s_anims\grenade_draw.smd"
	"v_m1g_s_anims\grenade_draw_2.smd"
	activity "ACT_VM_GRENADE_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_RifleGrenade.Raise" }
	{ event 5004 5 "MCV_Weapon_Foley_RifleGrenade.Attach" }
	{ event 5004 35 "MCV_Weapon_Foley_RifleGrenade.Lower" }
	{ event AE_WPN_SET_POSEPARAM 0 "ammo_fraction 1" }
	fadein 0.2
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
	fps 30
	
	
}

$sequence "Grenade_draw_empty" {
	"v_m1g_s_anims\Grenade_draw_empty.smd"
	"v_m1g_s_anims\Grenade_draw_empty_2.smd"
	activity "ACT_VM_GRENADE_DRAW_EMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M1G.Draw" }
	{ event AE_WPN_SET_POSEPARAM 0 "ammo_fraction 1" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	  
	
}

$sequence "holster" {
	"v_m1g_s_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 0 "MCV_Weapon_Foley_kar98.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$sequence "bayonet_unequip" {
	"bayonet_unequip_a"
	"bayonet_unequip_a_i"
	activity "ACT_VM_BAYONET_UNEQUIP" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event AE_CL_SETUP_BAYONET 35 "0" }
	{ event 5004 1 "MCV_Weapon_Foley_Bayonet.HandMovement_2" }
	{ event 5004 24 "MCV_Weapon_Foley_Bayonet.KnifeMovement_Off" }
	fadein 0.2
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
}

$sequence "bayonet_equip" {
	"bayonet_equip_a"
	"bayonet_equip_a_i"
	activity "ACT_VM_BAYONET_EQUIP" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event AE_CL_SETUP_BAYONET 5 "1" }
	{ event 5004 1 "MCV_Weapon_Foley_Bayonet.HandMovement_1" }
	{ event 5004 22 "MCV_Weapon_Foley_Bayonet.KnifeMovement_On" }
	fadein 0.2
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
}

$sequence "bash_bayonet" {
	"bash_a"
	"bash_a_i"
	activity "ACT_VM_BASH_BAYONET" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Bash.Fast" }
	fadein 0
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
	node "0"
}

$sequence "slash_bayonet" {
	"bash_a"
	"bash_a_i"
	activity "ACT_VM_SLASH_BAYONET" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 3200 3 "" }
	{ event 5004 1 "MCV_Weapon_Foley_Bash.Fast" }
	fadein 0
	fadeout 0.2
	addlayer "SlidePosition"
	addlayer "walklayer"
	node "0"
}

$sequence "Scope_adjust" {
	"scope_adjust_idle"
	"scope_adjust_iron"
	activity "ACT_VM_SCOPE_ADJUST" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 0 "MCV_Weapon_Foley_Zoom.HandIn" }
	{ event 5004 13 "MCV_Weapon_Foley_Zoom.Adjust" }
	{ event 5004 20 "MCV_Weapon_Foley_Zoom.HandOut" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "SlidePosition"
}

$sequence "ChargeStart" {
	"charge_s_a"
	"charge_s_a_i"
	activity "ACT_VM_CHARGE_START" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0
	fadeout 0.2
	addlayer "SlidePosition"
	node "0"
}

$sequence "ChargeLoop" {
	"charge_a"
	"charge_a_i"
	activity "ACT_VM_CHARGE_LOOP" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0
	fadeout 0.2
	addlayer "SlidePosition"
	node "0"
}

$sequence "ChargeStab" {
	"charge_e"
	"charge_e_i"
	activity "ACT_VM_CHARGE_STAB" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0
	fadeout 0.2
	addlayer "SlidePosition"
	node "0"
}

$includemodel "weapons/gesture_animations.mdl"

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\sniper_m1g_s\m1g_new.qc"
//	}
}

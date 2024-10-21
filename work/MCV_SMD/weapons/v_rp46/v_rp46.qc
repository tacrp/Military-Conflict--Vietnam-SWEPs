// Created by Crowbar 0.74

$modelname "weapons/mcv/v_rp46.mdl"

$bodygroup "studio"
{
	studio "Ref_new.smd"
}
$bodygroup "bullet01"
{
	studio "Bullet_new.001.smd"
	blank
}
$bodygroup "bullet02"
{
	studio "Bullet_new.002.smd"
	blank
}
$bodygroup "bullet03"
{
	studio "Bullet_new.003.smd"
	blank
}
$bodygroup "bullet04"
{
	studio "Bullet_new.004.smd"
	blank
}
$bodygroup "bullet05"
{
	studio "Bullet_new.005.smd"
	blank
}
$bodygroup "bullet06"
{
	studio "Bullet_new.006.smd"
	blank
}
$bodygroup "bullet07"
{
	studio "Bullet_new.007.smd"
	blank
}
$bodygroup "bullet08"
{
	studio "Bullet_new.008.smd"
	blank
}
$bodygroup "bullet09"
{
	studio "Bullet_new.009.smd"
	blank
}
$bodygroup "bullet10"
{
	studio "Bullet_new.010.smd"
	blank
}
$bodygroup "bullet11"
{
	studio "Bullet_new.011.smd"
	blank
}
$bodygroup "bullet12"
{
	studio "Bullet_new.012.smd"
	blank
}
$bodygroup "bullet13"
{
	studio "Bullet_new.013.smd"
	blank
}
$bodygroup "clamped1"
{
	studio "body14_model0.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 5.76 -19.466 -11.752

$cdmaterials "models\weapons\mcv\v_dp28\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "Base" -32 0 0.1 rotate 0 -180 0
$attachment "eject" "Base" -5 0 1.5 rotate 0 -90 0

$cbox 0 0 0 0 0 0

$bbox -10.278 -16.574 -27.509 49.211 28.093 4.005

$definebone "root" "" 0 7.450089 -27.509027 0 0 0 0 0 0 0 0 0
$definebone "pelvis" "root" -0.000002 0 0 -89.790623 -89.997175 89.997175 0 0 0 0 0 0
$definebone "spine_01" "pelvis" 4.255466 -0.335183 -0.000002 0 -7.153263 0 0 0 0 0 0 0
$definebone "spine_02" "spine_01" 7.431252 1.49648 0.000002 0 14.063249 0 0 0 0 0 0 0
$definebone "spine_03" "spine_02" 5.278481 0.165543 0.000001 0 2.779475 0 0 0 0 0 0 0
$definebone "clavicle_r" "spine_03" 4.67866 -1.075639 1.488978 66.457884 -74.414959 113.208726 0 0 0 0 0 0
$definebone "upperarm_r" "clavicle_r" -6.214482 -0.000009 -0.000026 -39.361205 171.560801 166.195564 0 0 0 0 0 0
$definebone "lowerarm_r" "upperarm_r" 11.944889 -0.000001 -0.000001 -11.599007 34.295479 3.613485 0 0 0 0 0 0
$definebone "hand_r" "lowerarm_r" 10.620192 0 0.000001 40.975083 158.047599 82.470989 0 0 0 0 0 0
$definebone "index_01_r" "hand_r" -4.751112 -0.694496 0.83058 -3.762671 25.53868 14.867218 0 0 0 0 0 0
$definebone "index_02_r" "index_01_r" -1.688072 0.000047 -0.000031 -0.475211 11.986108 1.337741 0 0 0 0 0 0
$definebone "index_03_r" "index_02_r" -1.336143 0.000055 -0.00001 0.996948 -9.496599 1.13755 0 0 0 0 0 0
$definebone "middle_01_r" "hand_r" -4.820498 -0.509464 -0.224758 -7.039534 22.827327 1.918084 0 0 0 0 0 0
$definebone "middle_02_r" "middle_01_r" -1.826988 -0.00007 0.000008 1.136747 12.280661 -2.025012 0 0 0 0 0 0
$definebone "middle_03_r" "middle_02_r" -1.436569 0.000004 0.000003 -4.389721 -15.399561 0.781565 0 0 0 0 0 0
$definebone "pinky_01_r" "hand_r" -3.992361 -0.89119 -1.827911 -18.932828 20.187423 -18.724439 0 0 0 0 0 0
$definebone "pinky_02_r" "pinky_01_r" -1.405918 -0.000024 -0.000003 -1.315578 11.208256 1.063858 0 0 0 0 0 0
$definebone "pinky_03_r" "pinky_02_r" -1.175362 0.000127 -0.000019 3.869407 1.0386 0.445637 0 0 0 0 0 0
$definebone "ring_01_r" "hand_r" -4.526752 -0.69058 -1.120744 -10.988245 23.293484 -13.509892 0 0 0 0 0 0
$definebone "ring_02_r" "ring_01_r" -1.744038 0.000031 -0.000008 -1.669886 13.315313 0.301254 0 0 0 0 0 0
$definebone "ring_03_r" "ring_02_r" -1.368771 0.000025 0.000005 2.987744 -12.899516 -0.360684 0 0 0 0 0 0
$definebone "thumb_01_r" "hand_r" -1.874798 -0.935127 0.999176 36.920267 27.057825 95.069506 0 0 0 0 0 0
$definebone "thumb_02_r" "thumb_01_r" -1.523449 0.000034 0.000028 9.832821 15.151511 1.613454 0 0 0 0 0 0
$definebone "thumb_03_r" "thumb_02_r" -1.599285 0.000011 0.000014 0.480718 -12.385757 2.414098 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" 5.511822 0.000006 0 -0.000422 179.999745 166.489945 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" 0.196846 -0.000003 0.000003 0.000355 -179.999117 160.050416 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 4.67866 -1.075637 -1.488979 66.457925 105.584814 113.208541 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.21449 0.000007 0.000019 39.360369 -8.439266 13.804506 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.9449 -0.000031 -0.000198 -11.598267 -34.295479 -3.613931 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620174 -0.000002 0.000006 -40.973758 21.950698 -97.528066 0 0 0 0 0 0
$definebone "index_01_l" "hand_l" 4.751162 0.694376 -0.830476 -3.764677 25.53651 14.866764 0 0 0 0 0 0
$definebone "index_02_l" "index_01_l" 1.688065 -0.000024 0.000002 -0.475151 11.986517 1.337912 0 0 0 0 0 0
$definebone "index_03_l" "index_02_l" 1.336155 -0.00005 -0.00001 -1.90789 -9.554288 1.137835 0 0 0 0 0 0
$definebone "middle_01_l" "hand_l" 4.820517 0.509338 0.224866 -7.040164 22.825903 1.917685 0 0 0 0 0 0
$definebone "middle_02_l" "middle_01_l" 1.827 0.000066 0.00001 1.136748 12.280675 -2.025011 0 0 0 0 0 0
$definebone "middle_03_l" "middle_02_l" 1.436584 -0.000004 0.000008 -0.387837 -15.34501 0.779217 0 0 0 0 0 0
$definebone "pinky_01_l" "hand_l" 3.992357 0.891087 1.827994 -18.934254 20.186226 -18.724955 0 0 0 0 0 0
$definebone "pinky_02_l" "pinky_01_l" 1.405926 0.000028 -0.000004 -1.315977 11.20815 1.063921 0 0 0 0 0 0
$definebone "pinky_03_l" "pinky_02_l" 1.175365 -0.000131 0.000003 7.050412 1.063478 0.44805 0 0 0 0 0 0
$definebone "ring_01_l" "hand_l" 4.526762 0.690462 1.120843 -10.989676 23.292058 -13.510295 0 0 0 0 0 0
$definebone "ring_02_l" "ring_01_l" 1.744041 -0.000031 0 -1.670174 13.315718 0.301541 0 0 0 0 0 0
$definebone "ring_03_l" "ring_02_l" 1.368771 -0.000032 -0.000017 9.085966 -12.938529 -0.365209 0 0 0 0 0 0
$definebone "thumb_01_l" "hand_l" 1.874859 0.93508 -0.999132 36.919116 27.057081 95.069567 0 0 0 0 0 0
$definebone "thumb_02_l" "thumb_01_l" 1.523453 -0.000032 -0.000003 9.832708 15.151407 1.612762 0 0 0 0 0 0
$definebone "thumb_03_l" "thumb_02_l" 1.599285 -0.000004 0.00001 4.129711 -12.231677 2.421151 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511812 -0.000006 0.000004 0.000292 0.000397 -13.510171 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.196849 0.000004 -0.000001 0.000861 -0.000113 -19.951823 0 0 0 0 0 0
$definebone "cam_driver" "" 0 0 0 0 -89.999982 0 0 0 0 0 0 0
$definebone "Base" "" -2.883701 -17.779638 -3.425864 0 89.999982 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 11.985273 8.260983 -2.097095 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" 5.514882 0.001257 -1.245997 0 0 0 0 0 0 0 0 0
$definebone "Bipod1" "Base" -17.250216 -0.737885 -1.619603 0 0 -29.828987 0 0 0 0 0 0
$definebone "Bipod2" "Base" -17.250216 0.711405 -1.552819 0 0 27.50524 0 0 0 0 0 0
$definebone "Bolt" "Base" -1.1117 1.286179 -1.152144 0 0 0 0 0 0 0 0 0
$definebone "Bullet.001" "Base" -5.171755 -0.20862 1.505044 0 0 6.336054 0 0 0 0 0 0
$definebone "Bullet.002" "Bullet.001" -0.000006 0.459162 0 0 0 -11.328121 0 0 0 0 0 0
$definebone "Bullet.003" "Bullet.002" 0 0.900968 0 0 0 -24.739515 0 0 0 0 0 0
$definebone "Bullet.004" "Bullet.003" 0 0.901381 0 0 0 -44.672432 0 0 0 0 0 0
$definebone "Bullet.005" "Bullet.004" 0.000002 0.922342 0 0 0 -15.060883 0 0 0 0 0 0
$definebone "Bullet.006" "Bullet.005" 0 0.903524 -0.000001 0 0 -0.005157 0 0 0 0 0 0
$definebone "Bullet.007" "Bullet.006" 0.000002 0.911954 0 0 0 -0.513485 0 0 0 0 0 0
$definebone "Bullet.008" "Bullet.007" 0 0.911308 0 0 0 -0.223052 0 0 0 0 0 0
$definebone "Bullet.009" "Bullet.008" 0.000004 0.907638 0.000001 0 0 0.447709 0 0 0 0 0 0
$definebone "Bullet.010" "Bullet.009" 0 0.907838 0 0 0 0.867114 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" -8.444609 -2.219278 -2.254766 66.092831 -137.02037 177.158592 0 0 0 0 0 0
$definebone "Cover" "Base" -7.939478 -0.000241 1.602741 0 0 0 0 0 0 0 0 0

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

$poseparameter "player_movement" 0 198 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "runIdle_a_corrective_animation" "v_rp46_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_rp46_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_rp46_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_rp46_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_rp46_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_rp46_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_a_corrective_animation" "v_rp46_anims\shoot2_a_corrective_animation.smd" {
}

$animation "shoot2_ironsight_a_corrective_animation" "v_rp46_anims\shoot2_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3_a_corrective_animation" "v_rp46_anims\shoot3_a_corrective_animation.smd" {
}

$animation "shoot3_ironsight_a_corrective_animation" "v_rp46_anims\shoot3_ironsight_a_corrective_animation.smd" {
}

$animation "shoot1d_a_corrective_animation" "v_rp46_anims\shoot1d_a_corrective_animation.smd" {
}

$animation "shoot1d_ironsight_a_corrective_animation" "v_rp46_anims\shoot1d_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2d_a_corrective_animation" "v_rp46_anims\shoot2d_a_corrective_animation.smd" {
}

$animation "shoot2d_ironsight_a_corrective_animation" "v_rp46_anims\shoot2d_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3d_a_corrective_animation" "v_rp46_anims\shoot3d_a_corrective_animation.smd" {
}

$animation "shoot3d_ironsight_a_corrective_animation" "v_rp46_anims\shoot3d_ironsight_a_corrective_animation.smd" {
}

$animation "basePose_a" "v_rp46_anims\basePose_a.smd" {
	fps 30
	numframes 60
}

$animation "ironsight" "v_rp46_anims\ironsight.smd" {
	fps 30
	frame 1 1
	numframes 60
	
	
}

$animation "ironsight_transition" "v_rp46_anims\ironsight_transition.smd" {
	fps 30
	frame 0 1
	numframes 60
	
	
}

$animation "runIdle_a" "v_rp46_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_rp46_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_rp46_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_rp46_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "shoot1_a" "v_rp46_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_rp46_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "shoot2_a" "v_rp46_anims\shoot2_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_a_corrective_animation" 0
}

$animation "shoot2_ironsight_a" "v_rp46_anims\shoot2_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_ironsight_a_corrective_animation" 0
}

$animation "shoot3_a" "v_rp46_anims\shoot3_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_a_corrective_animation" 0
}

$animation "shoot3_ironsight_a" "v_rp46_anims\shoot3_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_ironsight_a_corrective_animation" 0
}

$animation "nearwall_s_a" "v_rp46_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_rp46_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_rp46_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_rp46_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_rp46_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_rp46_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "prone_deployF" "v_rp46_anims\prone_deployF.smd" {
	fps 30
	loop
	
	
}

$animation "prone_deployB" "v_rp46_anims\prone_deployB.smd" {
	fps 30
	
	
}

$animation "prone_deployL" "v_rp46_anims\prone_deployL.smd" {
	fps 30
	
	
}

$animation "prone_deployR" "v_rp46_anims\prone_deployR.smd" {
	fps 30
	
	
}

$animation "proneF" "v_rp46_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_rp46_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_rp46_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_rp46_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_rp46_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_rp46_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_rp46_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_rp46_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_rp46_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_rp46_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "deploy_s_a" "v_rp46_anims\deploy_s_a.smd" {
	fps 40
	
	
}

$animation "deploy_s_a_i" "v_rp46_anims\deploy_s_a_i.smd" {
	fps 40
	
	
}

$animation "deploy_a" "v_rp46_anims\deploy_a.smd" {
	fps 30
	frame 0 0
	numframes 60
	
	
	
}

$animation "ironsightdeploy" "v_rp46_anims\ironsightdeploy.smd" {
	fps 30
	frame 0 1
	numframes 60
	
	
}

$animation "deploy_e_a" "v_rp46_anims\deploy_e_a.smd" {
	fps 40
	
	
}

$animation "deploy_e_a_i" "v_rp46_anims\deploy_e_a_i.smd" {
	fps 40
	
	
}

$animation "shoot1d_a" "v_rp46_anims\shoot1d_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1d_a_corrective_animation" 0
}

$animation "shoot1d_ironsight_a" "v_rp46_anims\shoot1d_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1d_ironsight_a_corrective_animation" 0
}

$animation "shoot2d_a" "v_rp46_anims\shoot2d_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2d_a_corrective_animation" 0
}

$animation "shoot2d_ironsight_a" "v_rp46_anims\shoot2d_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2d_ironsight_a_corrective_animation" 0
}

$animation "shoot3d_a" "v_rp46_anims\shoot3d_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3d_a_corrective_animation" 0
}

$animation "shoot3d_ironsight_a" "v_rp46_anims\shoot3d_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3d_ironsight_a_corrective_animation" 0
}

$sequence "runlayer" {
	"runIdle_a"
	"run_a"
	blend "player_movement" 100 185
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
	blend "player_movement" 0 198
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
	blend "player_movement" 0 99
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
	node "0"
}

$sequence "draw" {
	"v_rp46_anims\draw.smd"
	"v_rp46_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_DP28.Draw" }
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 0 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$sequence "Firstdraw" {
	"v_rp46_anims\Firstdraw.smd"
	"v_rp46_anims\Firstdraw_2.smd"
	activity "ACT_VM_READY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_DP28.Draw" }
	{ event 5004 11 "MCV_Weapon_Foley_DP28_Reload.Metal" }
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 0 "" }
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
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 0 "" }
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
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 0 "" }
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
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 0 "" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "reload" {
	"v_rp46_anims\reload.smd"
	"v_rp46_anims\reload_2.smd"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_DP28_Reload.Hand" }
	{ event 5004 17 "MCV_Weapon_Foley_RP46_Reload.CoverStart" }
	{ event 5004 18 "MCV_Weapon_Foley_RP46_Reload.BulletsOut" }
	{ event 5004 57 "MCV_Weapon_Foley_RP46_Reload.BulletsIn" }
	{ event 5004 83 "MCV_Weapon_Foley_RP46_Reload.CoverEnd" }
	{ event 5004 98 "MCV_Weapon_Foley_DP28_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 89 "" }
	{ event AE_CL_BODYGROUP_SET_TO_NEXTCLIP 40 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "reload_empty" {
	"v_rp46_anims\reload_empty.smd"
	"v_rp46_anims\reload_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_DP28_Reload.Hand" }
	{ event 5004 17 "MCV_Weapon_Foley_RP46_Reload.CoverStart" }
	{ event 5004 18 "MCV_Weapon_Foley_RP46_Reload.BulletsOut" }
	{ event 5004 57 "MCV_Weapon_Foley_RP46_Reload.BulletsIn" }
	{ event 5004 83 "MCV_Weapon_Foley_RP46_Reload.CoverEnd" }
	{ event 5004 106 "MCV_Weapon_Foley_DP28_Reload.Metal" }
	{ event 5004 110 "MCV_Weapon_Foley_DP28_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 111 "" }
	{ event AE_CL_BODYGROUP_SET_TO_NEXTCLIP 40 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
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
	addlayer "walklayer"
	addlayer "runlayer"
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
	addlayer "walklayer"
	addlayer "runlayer"
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
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
}

$sequence "prone_deploy" {
	"prone_deployF"
	"prone_deployL"
	"prone_deployB"
	"prone_deployR"
	"prone_deployF"
	activity "ACT_VM_CRAWLDEPLOY" 1
	blend "move_yaw" -180 180
	blendwidth 5
	{ event 5004 1 "MCV_Weapon_Foley_Movement.ProneCrawl" }
	{ event 5004 10 "MCV_Weapon_Foley_Movement.ProneCrawl_GunHeavy" }
	fadein 0.3
	fadeout 0.3
	realtime
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
	{ event 5004 12 "MCV_Weapon_Foley_Movement.ProneCrawl" }
	fadein 0.3
	fadeout 0.3
	realtime
}

$sequence "bash" {
	"v_rp46_anims\bash.smd"
	"v_rp46_anims\bash_2.smd"
	activity "ACT_VM_HITCENTER" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 3200 3 "" }
	{ event 5004 1 "MCV_Weapon_Foley_Bash.Fast" }
	fadein 0
	fadeout 0.2
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
	addlayer "walklayer"
	addlayer "runlayer"
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
	addlayer "runlayer"
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
	addlayer "walklayer"
	addlayer "runlayer"
}

$sequence "idletodeploy" {
	"deploy_s_a"
	"deploy_s_a_i"
	activity "ACT_VM_DEPLOYED_IN" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M16A1_Reload.Hand" }
	{ event 5004 14 "MCV_Weapon_Foley_BAR_Unpack.MetalOut" }
	fadein 0.2
	fadeout 0.2
	node "0"
}

$sequence "deploy" {
	"deploy_a"
	"ironsightdeploy"
	activity "ACT_VM_DEPLOY" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	node "0"
}

$sequence "reload_deploy" {
	"v_rp46_anims\reload_deploy.smd"
	"v_rp46_anims\reload_deploy_2.smd"
	activity "ACT_VM_RELOAD_DEPLOYED" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_DP28_Reload.Hand" }
	{ event 5004 17 "MCV_Weapon_Foley_RP46_Reload.CoverStart" }
	{ event 5004 17 "MCV_Weapon_Foley_RP46_Reload.BulletsOut" }
	{ event 5004 57 "MCV_Weapon_Foley_RP46_Reload.BulletsIn" }
	{ event 5004 83 "MCV_Weapon_Foley_RP46_Reload.CoverEnd" }
	{ event 5004 90 "MCV_Weapon_Foley_DP28_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 89 "" }
	{ event AE_CL_BODYGROUP_SET_TO_NEXTCLIP 40 "" }
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
	
	
}

$sequence "reload_deploy_empty" {
	"v_rp46_anims\reload_deploy_empty.smd"
	"v_rp46_anims\reload_deploy_empty_2.smd"
	activity "ACT_VM_DEPLOYED_RELOAD_EMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_DP28_Reload.Hand" }
	{ event 5004 17 "MCV_Weapon_Foley_RP46_Reload.CoverStart" }
	{ event 5004 18 "MCV_Weapon_Foley_RP46_Reload.BulletsOut" }
	{ event 5004 57 "MCV_Weapon_Foley_RP46_Reload.BulletsIn" }
	{ event 5004 83 "MCV_Weapon_Foley_RP46_Reload.CoverEnd" }
	{ event 5004 106 "MCV_Weapon_Foley_DP28_Reload.Metal" }
	{ event 5004 122 "MCV_Weapon_Foley_DP28_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 117 "" }
	{ event AE_CL_BODYGROUP_SET_TO_NEXTCLIP 40 "" }
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
	
	
}

$sequence "deploytoidle" {
	"deploy_e_a"
	"deploy_e_a_i"
	activity "ACT_VM_DEPLOYED_OUT" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M16A1_Reload.Hand" }
	{ event 5004 22 "MCV_Weapon_Foley_BAR_Unpack.MetalOut" }
	fadein 0.2
	fadeout 0.2
	node "0"
}

$sequence "deployshoot1" {
	"shoot1d_a"
	"shoot1d_ironsight_a"
	activity "ACT_VM_PRIMARYATTACK_DEPLOYED" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	{ event AE_MUZZLEFLASH 0 "" }
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 0 "" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "deployshoot2" {
	"shoot2d_a"
	"shoot2d_ironsight_a"
	activity "ACT_VM_PRIMARYATTACK_DEPLOYED" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	{ event AE_MUZZLEFLASH 0 "" }
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 0 "" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "deployshoot3" {
	"shoot3d_a"
	"shoot3d_ironsight_a"
	activity "ACT_VM_PRIMARYATTACK_DEPLOYED" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	{ event AE_CLIENT_EJECT_BRASS 0 "eject" }
	{ event AE_MUZZLEFLASH 0 "" }
	{ event AE_CL_BODYGROUP_SET_TO_CLIP 0 "" }
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "holster" {
	"v_rp46_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 0 "MCV_Weapon_Foley_DP28.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$includemodel "weapons/gesture_animations.mdl"

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\lmg_dp28\lmg_rp46\rp46_new.qc"
//	}
}

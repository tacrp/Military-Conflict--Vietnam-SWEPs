// Created by Crowbar 0.74

$modelname "weapons/mcv/v_stg44.mdl"

$bodygroup "studio"
{
	studio "ref_new.smd"
}
$bodygroup "scope"
{
	studio "stg44_scope_new.smd"
	blank
}
$bodygroup "magazine"
{
	studio "magazine_30.smd"
	studio "magazine_20.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 4.517 -16.152 -12.183

$cdmaterials "models\weapons\mcv\v_stg44\"
$cdmaterials "models\weapons\mcv\shells\"
$cdmaterials "models\weapons\mcv\optics\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "Base" -24 0 0.7 rotate 0 177 0
$attachment "eject" "Base" -3.4 0 1 rotate 0 90 0

$cbox 0 0 0 0 0 0

$bbox -11.839 -14.245 -27.509 44.143 23.279 3.143

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
$definebone "Base" "" -3.617775 -21.909624 -4.272883 0 89.999982 0 0 0 0 0 0 0
$definebone "Mag" "Base" -2.738092 -0.015065 -1.418666 0 0 0 0 0 0 0 0 0
$definebone "Bullet" "Mag" 0.082529 0.010043 1.101437 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" 2.930595 0.005151 -1.911677 0 0 0 0 0 0 0 0 0
$definebone "Bolt" "Base" -2.05538 -0.453646 1.827135 0 0 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 17.30316 7.526908 -1.250076 0 0 0 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" 17.30316 -4.673384 -1.250076 0 0 0 0 0 0 0 0 0
$definebone "MagRelease" "Base" -0.785795 -0.813228 -1.376884 0 0 0 0 0 0 0 0 0

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

$poseparameter "player_movement" 0 276 loop 0
$poseparameter "ironsight" 0 1 loop 0
$poseparameter "move_yaw" -180 180 loop 0




$animation "runIdle_a_corrective_animation" "v_stg44_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_stg44_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_stg44_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_stg44_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_stg44_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_stg44_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_a_corrective_animation" "v_stg44_anims\shoot2_a_corrective_animation.smd" {
}

$animation "shoot2_ironsight_a_corrective_animation" "v_stg44_anims\shoot2_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3_a_corrective_animation" "v_stg44_anims\shoot3_a_corrective_animation.smd" {
}

$animation "shoot3_ironsight_a_corrective_animation" "v_stg44_anims\shoot3_ironsight_a_corrective_animation.smd" {
}

$animation "basePose_a" "v_stg44_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "ironsight" "v_stg44_anims\ironsight.smd" {
	fps 30
	frame 0 1
	numframes 60
	
	
}

$animation "ironsight_transition" "v_stg44_anims\ironsight_transition.smd" {
	fps 30
	frame 0 1
	numframes 60
	
	
}

$animation "runIdle_a" "v_stg44_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_stg44_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_stg44_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_stg44_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "shoot1_a" "v_stg44_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_stg44_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "shoot2_a" "v_stg44_anims\shoot2_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_a_corrective_animation" 0
}

$animation "shoot2_ironsight_a" "v_stg44_anims\shoot2_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_ironsight_a_corrective_animation" 0
}

$animation "shoot3_a" "v_stg44_anims\shoot3_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_a_corrective_animation" 0
}

$animation "shoot3_ironsight_a" "v_stg44_anims\shoot3_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_ironsight_a_corrective_animation" 0
}

$animation "nearwall_s_a" "v_stg44_anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "v_stg44_anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "v_stg44_anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "v_stg44_anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "v_stg44_anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "v_stg44_anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "proneF" "v_stg44_anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "v_stg44_anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "v_stg44_anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "v_stg44_anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "v_stg44_anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "v_stg44_anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "v_stg44_anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "v_stg44_anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "v_stg44_anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "v_stg44_anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "change_firemode_idle" "v_stg44_anims\change_firemode_idle.smd" {
	fps 30
	
	
}

$animation "change_firemode_iron" "v_stg44_anims\change_firemode_iron.smd" {
	fps 30
	
	
}

$animation "scope_adjust_idle" "v_stg44_anims\scope_adjust_idle.smd" {
	fps 30
	
	
}

$animation "scope_adjust_iron" "v_stg44_anims\scope_adjust_iron.smd" {
	fps 30
	
	
}

$sequence "runlayer" {
	"runIdle_a"
	"run_a"
	blend "player_movement" 131 225
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
	"v_stg44_anims\draw.smd"
	"v_stg44_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_STG44.Draw" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	  
	
}

$sequence "Firstdraw" {
	"v_stg44_anims\Firstdraw.smd"
	"v_stg44_anims\Firstdraw_2.smd"
	activity "ACT_VM_READY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_STG44.Draw" }
	{ event 5004 7 "MCV_Weapon_Foley_STG44_Reload.MetalStart" }
	{ event 5004 15 "MCV_Weapon_Foley_STG44_Reload.MetalEnd" }
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
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "reload" {
	"v_stg44_anims\reload.smd"
	"v_stg44_anims\reload_2.smd"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_STG44_Reload.Hand" }
	{ event 5004 17 "MCV_Weapon_Foley_STG44_Reload.MagOut" }
	{ event 5004 41 "MCV_Weapon_Foley_STG44_Reload.MagIn" }
	{ event 5004 66 "MCV_Weapon_Foley_STG44_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 58 "" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "reload_empty" {
	"v_stg44_anims\reload_empty.smd"
	"v_stg44_anims\reload_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_STG44_Reload.Hand" }
	{ event 5004 17 "MCV_Weapon_Foley_STG44_Reload.MagOut" }
	{ event 5004 41 "MCV_Weapon_Foley_STG44_Reload.MagIn" }
	{ event 5004 74 "MCV_Weapon_Foley_STG44_Reload.MetalStart" }
	{ event 5004 82 "MCV_Weapon_Foley_STG44_Reload.MetalEnd" }
	{ event 5004 90 "MCV_Weapon_Foley_STG44_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 88 "" }
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
	"v_stg44_anims\bash.smd"
	"v_stg44_anims\bash_2.smd"
	activity "ACT_VM_HITCENTER" 1
	blend "ironsight" 0 1
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
	activity "ACT_VM_PICKUPSTART" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Pickup.In" }
	fadein 0.2
	fadeout 0.2
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
	addlayer "walklayer"
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
}

$sequence "holster" {
	"v_stg44_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 0 "MCV_Weapon_Foley_STG44.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$sequence "Scope_adjust" {
	"scope_adjust_idle"
	"scope_adjust_iron"
	activity "ACT_VM_FIDGET" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
}

$includemodel "weapons/gesture_animations.mdl"

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\rifle_stg44\stg44_new.qc"
//	}
}

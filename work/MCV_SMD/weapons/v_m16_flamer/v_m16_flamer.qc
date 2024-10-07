// Created by Crowbar 0.74

$modelname "weapons/mcv/v_m16_flamer.mdl"

$bodygroup "studio"
{
	studio "m16_flamer.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 4.795 -17.277 -12.919

$cdmaterials "models\weapons\mcv\v_m203\"
$cdmaterials "models\weapons\mcv\v_m9a1\"
$cdmaterials "models\player\equipment\"
$cdmaterials "models\weapons\mcv\v_bayonet\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0
$attachment "muzzle" "Base" -26.5 0 1 rotate 0 -180 0
$attachment "muzzle2" "Base" -19.6 0 -1.9 rotate 0 -180 0
$attachment "eject" "Base" 0.5 0.4 1 rotate 0 90 0

$cbox 0 0 0 0 0 0

$bbox -9.55 -16.808 -27.509 44.105 26.398 1.672

$definebone "root" "" 0 7.450089 -27.509027 0 0 0 0 0 0 0 0 0
$definebone "pelvis" "root" -0.000002 0 0 -89.790623 -89.997175 89.997175 0 0 0 0 0 0
$definebone "spine_01" "pelvis" 4.255466 -0.335184 -0.000002 0 -7.153263 0 0 0 0 0 0 0
$definebone "spine_02" "spine_01" 7.431253 1.49648 0.000002 0 14.063249 0 0 0 0 0 0 0
$definebone "spine_03" "spine_02" 5.278481 0.165543 0.000001 0 2.779475 0 0 0 0 0 0 0
$definebone "clavicle_r" "spine_03" 4.67866 -1.075639 1.488978 66.457891 -74.414904 113.20878 0 0 0 0 0 0
$definebone "upperarm_r" "clavicle_r" -6.214482 -0.000009 -0.000027 -39.361202 171.560787 166.195592 0 0 0 0 0 0
$definebone "lowerarm_r" "upperarm_r" 11.944891 -0.000001 0 -11.599023 34.295466 3.613491 0 0 0 0 0 0
$definebone "hand_r" "lowerarm_r" 10.620197 0 0 40.975056 158.047627 82.471003 0 0 0 0 0 0
$definebone "index_01_r" "hand_r" -4.751114 -0.694496 0.830582 -3.76267 25.538683 14.867216 0 0 0 0 0 0
$definebone "index_02_r" "index_01_r" -1.68808 0.000042 -0.000031 -0.475209 11.986107 1.337743 0 0 0 0 0 0
$definebone "index_03_r" "index_02_r" -1.336143 0.000057 -0.00001 0.99695 -9.496599 1.137552 0 0 0 0 0 0
$definebone "middle_01_r" "hand_r" -4.820499 -0.509462 -0.224759 -7.039533 22.827331 1.918086 0 0 0 0 0 0
$definebone "middle_02_r" "middle_01_r" -1.826992 -0.000071 0.000008 1.136748 12.280666 -2.02501 0 0 0 0 0 0
$definebone "middle_03_r" "middle_02_r" -1.436577 0.000006 0.000004 -4.389719 -15.399558 0.781567 0 0 0 0 0 0
$definebone "pinky_01_r" "hand_r" -3.992363 -0.891186 -1.827911 -18.932825 20.18743 -18.724438 0 0 0 0 0 0
$definebone "pinky_02_r" "pinky_01_r" -1.405922 -0.000028 -0.000001 -1.315578 11.208261 1.063858 0 0 0 0 0 0
$definebone "pinky_03_r" "pinky_02_r" -1.175354 0.000128 -0.00002 3.869405 1.038605 0.445637 0 0 0 0 0 0
$definebone "ring_01_r" "hand_r" -4.526758 -0.690575 -1.120744 -10.988245 23.293489 -13.509891 0 0 0 0 0 0
$definebone "ring_02_r" "ring_01_r" -1.744041 0.000031 -0.000006 -1.669888 13.31532 0.301252 0 0 0 0 0 0
$definebone "ring_03_r" "ring_02_r" -1.368771 0.000025 0.000003 2.987744 -12.899508 -0.360686 0 0 0 0 0 0
$definebone "thumb_01_r" "hand_r" -1.8748 -0.935127 0.999177 36.92027 27.05783 95.069506 0 0 0 0 0 0
$definebone "thumb_02_r" "thumb_01_r" -1.523449 0.000034 0.000032 9.832823 15.151511 1.613448 0 0 0 0 0 0
$definebone "thumb_03_r" "thumb_02_r" -1.599281 0.00001 0.000013 0.480719 -12.385753 2.414095 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" 5.511824 0.000006 -0.000004 -0.000447 179.999745 166.489945 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" 0.196846 -0.000003 0.000004 0.000348 -179.999117 160.050416 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 4.678659 -1.075637 -1.488979 66.457925 105.584814 113.208541 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.214491 0.00001 0.00002 39.360369 -8.439266 13.804506 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.944896 -0.000032 -0.000199 -11.598267 -34.295479 -3.613931 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620178 -0.000004 0.000006 -40.973758 21.950698 -97.528066 0 0 0 0 0 0
$definebone "index_01_l" "hand_l" 4.751169 0.694376 -0.830476 -3.764677 25.53651 14.866764 0 0 0 0 0 0
$definebone "index_02_l" "index_01_l" 1.688061 -0.000023 0.000002 -0.475151 11.986517 1.337912 0 0 0 0 0 0
$definebone "index_03_l" "index_02_l" 1.336151 -0.00005 -0.000009 -1.90789 -9.554288 1.137835 0 0 0 0 0 0
$definebone "middle_01_l" "hand_l" 4.820518 0.50934 0.224866 -7.040164 22.825903 1.917685 0 0 0 0 0 0
$definebone "middle_02_l" "middle_01_l" 1.827 0.000064 0.00001 1.136748 12.280675 -2.025011 0 0 0 0 0 0
$definebone "middle_03_l" "middle_02_l" 1.436581 -0.000006 0.00001 -0.387837 -15.34501 0.779217 0 0 0 0 0 0
$definebone "pinky_01_l" "hand_l" 3.992359 0.891087 1.827996 -18.934254 20.186226 -18.724955 0 0 0 0 0 0
$definebone "pinky_02_l" "pinky_01_l" 1.405926 0.000031 -0.000006 -1.315977 11.20815 1.063921 0 0 0 0 0 0
$definebone "pinky_03_l" "pinky_02_l" 1.175362 -0.000128 0.000003 7.050412 1.063478 0.44805 0 0 0 0 0 0
$definebone "ring_01_l" "hand_l" 4.526766 0.690464 1.120844 -10.989676 23.292058 -13.510295 0 0 0 0 0 0
$definebone "ring_02_l" "ring_01_l" 1.744041 -0.000031 0 -1.670174 13.315718 0.301541 0 0 0 0 0 0
$definebone "ring_03_l" "ring_02_l" 1.368771 -0.000032 -0.000021 9.085966 -12.938529 -0.365209 0 0 0 0 0 0
$definebone "thumb_01_l" "hand_l" 1.874865 0.935081 -0.999132 36.919116 27.057081 95.069567 0 0 0 0 0 0
$definebone "thumb_02_l" "thumb_01_l" 1.523458 -0.000031 -0.000003 9.832708 15.151407 1.612762 0 0 0 0 0 0
$definebone "thumb_03_l" "thumb_02_l" 1.599277 -0.000004 0.000012 4.129711 -12.231677 2.421151 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511814 -0.00001 0.000002 0.000292 0.000397 -13.510171 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.196849 0.000007 0 0.000861 -0.000113 -19.951823 0 0 0 0 0 0
$definebone "cam_driver" "" 0 0 0 0 -89.999982 0 0 0 0 0 0 0
$definebone "Base" "" -4.186056 -19.136522 -4.481611 0 89.999982 0 0 0 0 0 0 0
$definebone "Mag" "Base" 0.050734 -0.015066 -0.906442 0 0 0 0 0 0 0 0 0
$definebone "Bullet" "Mag" 0.026926 -0.174472 1.260252 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" 3.332498 -0.003282 -0.934897 0 0 0 0 0 0 0 0 0
$definebone "Bolt" "Base" 0.381264 0.001023 0.888928 0 0 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 14.530058 6.958628 -1.041348 0 0 0 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" 14.530058 -5.241665 -1.041348 0 0 0 0 0 0 0 0 0
$definebone "BoltCover" "Base" 0.381264 0.63069 0.557508 0 0 0 0 0 0 0 0 0
$definebone "Boltpuller" "Base" 6.50118 0.256561 2.048409 0 0 0 0 0 0 0 0 0
$definebone "M203_Ironsight" "Base" -12.288616 -0.003284 2.635598 0 0 0 0 0 0 0 0 0

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

$include "../../militaryconflict_vietnam.qci"


$sectionframes 30 29

$poseparameter "player_movement" 0 276 loop 0
$poseparameter "ironsight" 0 1 loop 0




$animation "runIdle_a_corrective_animation" "v_m16_flamer_anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "v_m16_flamer_anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "v_m16_flamer_anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "v_m16_flamer_anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "v_m16_flamer_anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "v_m16_flamer_anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_a_corrective_animation" "v_m16_flamer_anims\shoot2_a_corrective_animation.smd" {
}

$animation "shoot2_ironsight_a_corrective_animation" "v_m16_flamer_anims\shoot2_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3_a_corrective_animation" "v_m16_flamer_anims\shoot3_a_corrective_animation.smd" {
}

$animation "shoot3_ironsight_a_corrective_animation" "v_m16_flamer_anims\shoot3_ironsight_a_corrective_animation.smd" {
}

$animation "gl_shoot_a_corrective_animation" "v_m16_flamer_anims\gl_shoot_a_corrective_animation.smd" {
}

$animation "gl_shoot_ironsight_a_corrective_animation" "v_m16_flamer_anims\gl_shoot_ironsight_a_corrective_animation.smd" {
}

$animation "basePose_a" "v_m16_flamer_anims\basePose_a.smd" {
	fps 30
	loop
	
	
}

$animation "runIdle_a" "v_m16_flamer_anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "v_m16_flamer_anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "v_m16_flamer_anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "v_m16_flamer_anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "shoot1_a" "v_m16_flamer_anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "v_m16_flamer_anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "shoot2_a" "v_m16_flamer_anims\shoot2_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_a_corrective_animation" 0
}

$animation "shoot2_ironsight_a" "v_m16_flamer_anims\shoot2_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_ironsight_a_corrective_animation" 0
}

$animation "shoot3_a" "v_m16_flamer_anims\shoot3_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_a_corrective_animation" 0
}

$animation "shoot3_ironsight_a" "v_m16_flamer_anims\shoot3_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_ironsight_a_corrective_animation" 0
}

$animation "change_firemode_idle" "v_m16_flamer_anims\change_firemode_idle.smd" {
	fps 30
	
	
}

$animation "change_firemode_iron" "v_m16_flamer_anims\change_firemode_iron.smd" {
	fps 30
	
	
}

$animation "gl_shoot_a" "v_m16_flamer_anims\gl_shoot_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "gl_shoot_a_corrective_animation" 0
}

$animation "gl_shoot_ironsight_a" "v_m16_flamer_anims\gl_shoot_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "gl_shoot_ironsight_a_corrective_animation" 0
}

$sequence "runlayer" {
	"runIdle_a"
	"run_a"
	blend "player_movement" 134 229
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

$sequence "idle" {
	"basePose_a"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
}

$sequence "draw" {
	"v_m16_flamer_anims\draw.smd"
	"v_m16_flamer_anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_M16A1.Draw" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	  
	
}

$sequence "Firstdraw" {
	"v_m16_flamer_anims\Firstdraw.smd"
	activity "ACT_VM_FIRSTDRAW" 1
	{ event 5004 1 "MCV_Weapon_Foley_M16A1.Draw" }
	{ event 5004 9 "MCV_Weapon_Foley_M16A1.DrawMetalStart" }
	{ event 5004 15 "MCV_Weapon_Foley_M16A1.DrawMetalEnd" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	fps 30
	
	
}

$sequence "ironsight" {
	"v_m16_flamer_anims\ironsight.smd"
	activity "ACT_VM_IRONSIGHT" 1
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 0.5
	
	
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
	"v_m16_flamer_anims\reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 1 "MCV_Weapon_Foley_M16A1_Reload.Hand" }
	{ event 5004 6 "MCV_Weapon_Foley_M16A1_Reload.MagOut" }
	{ event 5004 44 "MCV_Weapon_Foley_M16A1_Reload.MagIn" }
	{ event 5004 50 "MCV_Weapon_Foley_M16A1_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 48 "" }
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
	
	
}

$sequence "reload_empty" {
	"v_m16_flamer_anims\reload_empty.smd"
	activity "ACT_VM_RELOADEMPTY" 1
	{ event 5004 1 "MCV_Weapon_Foley_M16A1_Reload.Hand" }
	{ event 5004 6 "MCV_Weapon_Foley_M16A1_Reload.MagOut" }
	{ event 5004 44 "MCV_Weapon_Foley_M16A1_Reload.MagIn" }
	{ event 5004 57 "MCV_Weapon_Foley_M16A1_Reload.HandEnd" }
	{ event 5004 67 "MCV_Weapon_Foley_M16A1_Reload.MetalStart" }
	{ event 5004 75 "MCV_Weapon_Foley_M16A1_Reload.MetalEnd" }
	{ event 5004 80 "MCV_Weapon_Foley_M16A1_Reload.Hand" }
	{ event AE_WPN_COMPLETE_RELOAD 79 "" }
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
	
	
}

$sequence "idletoironsight" {
	"v_m16_flamer_anims\idletoironsight.smd"
	activity "ACT_VM_IDLETOIRONSIGHT" 1
	{ event 5004 1 "MCV_Weapon_Foley_Ironsights.In" }
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
	
	
}

$sequence "ironsighttoidle" {
	"v_m16_flamer_anims\ironsighttoidle.smd"
	activity "ACT_VM_IRONSIGHTTOIDLE" 1
	{ event 5004 1 "MCV_Weapon_Foley_Ironsights.Out" }
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
	
	
}

$sequence "idletonearwall" {
	"v_m16_flamer_anims\idletonearwall.smd"
	activity "ACT_VM_IDLE_TO_LOWERED" 1
	{ event 5004 1 "MCV_Weapon_Foley_Nearwall.In" }
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
	
	
}

$sequence "nearwall" {
	"v_m16_flamer_anims\nearwall.smd"
	activity "ACT_VM_IDLE_LOWERED" 1
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
	loop
	
	
}

$sequence "nearwalltoidle" {
	"v_m16_flamer_anims\nearwalltoidle.smd"
	activity "ACT_VM_LOWERED_TO_IDLE" 1
	{ event 5004 1 "MCV_Weapon_Foley_Nearwall.Out" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	node "0"
	fps 30
	  
	
}

$sequence "prone" {
	"v_m16_flamer_anims\prone.smd"
	activity "ACT_VM_CRAWL" 1
	{ event 5004 1 "MCV_Weapon_Foley_Movement.ProneCrawl" }
	{ event 5004 10 "MCV_Weapon_Foley_Movement.ProneCrawl_GunMedium" }
	fadein 0.2
	fadeout 0.2
	fps 20
	loop
	
	
}

$sequence "pronetoidle" {
	"v_m16_flamer_anims\pronetoidle.smd"
	activity "ACT_VM_CRAWLTOIDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	
	
}

$sequence "idletoprone" {
	"v_m16_flamer_anims\idletoprone.smd"
	activity "ACT_VM_IDLETOPRONE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	
	
}

$sequence "bash" {
	"v_m16_flamer_anims\bash.smd"
	activity "ACT_VM_BASH" 1
	{ event 3200 3 "" }
	{ event 5004 1 "MCV_Weapon_Foley_Bash.Fast" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	node "0"
	fps 30
	
	
}

$sequence "pickupstart" {
	"v_m16_flamer_anims\pickupstart.smd"
	activity "ACT_VM_PICKUPSTART" 1
	{ event 5004 1 "MCV_Weapon_Foley_Pickup.In" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	fps 30
	  
	
}

$sequence "pickupend" {
	"v_m16_flamer_anims\pickupend.smd"
	activity "ACT_VM_PICKUPEND" 1
	{ event 5004 1 "MCV_Weapon_Foley_Pickup.Out" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	fps 30
	  
	
}

$sequence "pickuploop" {
	"v_m16_flamer_anims\pickuploop.smd"
	activity "ACT_VM_PICKUPLOOP" 1
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	fps 30
	loop
	
	
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
	"v_m16_flamer_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 0 "MCV_Weapon_Foley_M16A1.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$sequence "gl" {
	"v_m16_flamer_anims\gl.smd"
	activity "ACT_VM_GL" 1
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$sequence "idle_to_gl" {
	"v_m16_flamer_anims\idle_to_gl.smd"
	activity "ACT_VM_IDLETOGL" 1
	{ event 5004 1 "MCV_Weapon_Foley_Ironsights.In" }
	{ event 5004 10 "MCV_Weapon_Foley_M16A1_GrenadeSight.In" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	fps 30
	
	
}

$sequence "gl_to_idle" {
	"v_m16_flamer_anims\gl_to_idle.smd"
	activity "ACT_VM_GLTOIDLE" 1
	{ event 5004 1 "MCV_Weapon_Foley_Ironsights.Out" }
	{ event 5004 15 "MCV_Weapon_Foley_M16A1_GrenadeSight.Out" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	fps 30
	
	
}

$sequence "irongl" {
	"v_m16_flamer_anims\irongl.smd"
	activity "ACT_VM_IRONGL" 1
	fadein 0.2
	fadeout 0.2
	fps 1
	
	
}

$sequence "gl_to_irongl" {
	"v_m16_flamer_anims\gl_to_irongl.smd"
	activity "ACT_VM_GLTOIRONGL" 1
	{ event 5004 1 "MCV_Weapon_Foley_Ironsights.In" }
	fadein 0.2
	fadeout 0.2
	fps 30
	
	
}

$sequence "irongl_to_gl" {
	"v_m16_flamer_anims\irongl_to_gl.smd"
	activity "ACT_VM_IRONGLTOGL" 1
	{ event 5004 1 "MCV_Weapon_Foley_Ironsights.Out" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	fps 30
	
	
}

$sequence "gl_shoot" {
	"gl_shoot_a"
	"gl_shoot_ironsight_a"
	activity "ACT_VM_SECONDARYATTACK" 1
	blend "ironsight" 0 1
	blendwidth 2
	delta
	fadein 0
	fadeout 0.2
	node "Fire"
}

$sequence "reload_secondary" {
	"v_m16_flamer_anims\reload_secondary.smd"
	activity "ACT_VM_RELOAD_SECONDARY" 1
	{ event 5004 1 "MCV_Weapon_Foley_M16A1_Reload.Hand" }
	{ event 5004 12 "MCV_Weapon_Foley_M16A1_Reload.GrenadeStart" }
	{ event 5004 30 "MCV_Weapon_Foley_M16A1_Reload.Grenade" }
	{ event 5004 53 "MCV_Weapon_Foley_M16A1_Reload.GrenadeEnd" }
	{ event 5004 61 "MCV_Weapon_Foley_M16A1_Reload.HandEnd" }
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
	
	
}

$sequence "gl_draw" {
	"v_m16_flamer_anims\gl_draw.smd"
	activity "ACT_VM_GL_DRAW" 1
	{ event 5004 1 "MCV_Weapon_Foley_M16A1.Draw" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	fps 30
	
	
}

$sequence "idletonearwall_grenade" {
	"v_m16_flamer_anims\idletonearwall_grenade.smd"
	activity "ACT_VM_IDLE_TO_LOWERED_GL" 1
	{ event 5004 1 "MCV_Weapon_Foley_Nearwall.In" }
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
	
	
}

$sequence "nearwall_grenade" {
	"v_m16_flamer_anims\nearwall_grenade.smd"
	activity "ACT_VM_IDLE_LOWERED_GL" 1
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
	loop
	
	
}

$sequence "nearwalltoidle_grenade" {
	"v_m16_flamer_anims\nearwalltoidle_grenade.smd"
	activity "ACT_VM_LOWERED_TO_IDLE_GL" 1
	{ event 5004 1 "MCV_Weapon_Foley_Nearwall.Out" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	node "0"
	fps 30
	  
	
}

$sequence "prone_grenade" {
	"v_m16_flamer_anims\prone_grenade.smd"
	activity "ACT_VM_CRAWL_GL" 1
	{ event 5004 1 "MCV_Weapon_Foley_Movement.ProneCrawl" }
	{ event 5004 17 "MCV_Weapon_Foley_Movement.ProneCrawl" }
	fadein 0.2
	fadeout 0.2
	fps 20
	loop
	
	
}

$sequence "pronetoidle_grenade" {
	"v_m16_flamer_anims\pronetoidle_grenade.smd"
	activity "ACT_VM_CRAWLTOIDLE_GL" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	
	
}

$sequence "idletoprone_grenade" {
	"v_m16_flamer_anims\idletoprone_grenade.smd"
	activity "ACT_VM_IDLETOPRONE_GL" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	
	
}

$sequence "bash_grenade" {
	"v_m16_flamer_anims\bash_grenade.smd"
	activity "ACT_VM_BASH_GL" 1
	{ event 3200 3 "" }
	{ event 5004 1 "MCV_Weapon_Foley_Bash.Fast" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	node "0"
	fps 30
	
	
}

$sequence "pickupstart_grenade" {
	"v_m16_flamer_anims\pickupstart_grenade.smd"
	activity "ACT_VM_PICKUPSTART_GL" 1
	{ event 5004 1 "MCV_Weapon_Foley_Pickup.In" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	fps 30
	  
	
}

$sequence "pickupend_grenade" {
	"v_m16_flamer_anims\pickupend_grenade.smd"
	activity "ACT_VM_PICKUPEND_GL" 1
	{ event 5004 1 "MCV_Weapon_Foley_Pickup.Out" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	fps 30
	  
	
}

$sequence "pickuploop_grenade" {
	"v_m16_flamer_anims\pickuploop_grenade.smd"
	activity "ACT_VM_PICKUPLOOP_GL" 1
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	fps 30
	loop
	
	
}

$sequence "holster_grenade" {
	"v_m16_flamer_anims\holster_grenade.smd"
	activity "ACT_VM_HOLSTER_GL" 1
	{ event 5004 0 "MCV_Weapon_Foley_M16A1.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	fps 30
	
	
}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\rifle_m16a1\m16_flamer.qc"
//	}
}

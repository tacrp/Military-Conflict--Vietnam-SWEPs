// Created by Crowbar 0.74

$modelname "weapons/mcv/v_md63.mdl"

$bodygroup "studio"
{
	studio "ref_md63.smd"
}
$bodygroup "bayonet"
{
	blank
	studio "v_bayonetAKM.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 3.75 -16.199 -12.694

$cdmaterials "models\weapons\mcv\v_akm\"
$cdmaterials "models\weapons\mcv\v_ak47\"
$cdmaterials "models\weapons\mcv\v_ak47_bayonet\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "muzzle" "Base" -20 0 0.15 rotate 1 180 0
$attachment "eject" "Base" -1 0 0.7 rotate 0 90 0
$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -10.182 -15.554 -27.509 42.58 23.054 2.121

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
$definebone "Base" "" -3.180958 -17.779638 -3.275469 0 89.999982 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 11.985279 7.963726 -2.24749 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" 3.735501 0.001257 -1.323763 0 0 0 0 0 0 0 0 0
$definebone "Mag" "Base" -0.000669 -0.000546 -1.339116 0 0 0 0 0 0 0 0 0
$definebone "Bullets" "Mag" 0.047661 0 0.671442 0 0 0 0 0 0 0 0 0
$definebone "Lock" "Base" 4.805533 0.899266 -0.325907 0 0 0 0 0 0 0 0 0
$definebone "Bolt" "Base" -1.555565 -0.000546 0.655778 0 0 0 0 0 0 0 0 0
$definebone "Bayonet" "Base" -19.841324 0.316513 -0.959334 0 0 0 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" -4.223866 -1.637676 -4.269257 -1.780352 -97.898665 166.050792 0 0 0 0 0 0

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




$animation "runIdle_a_corrective_animation" "anims\runIdle_a_corrective_animation.smd" {
}

$animation "run_a_corrective_animation" "anims\run_a_corrective_animation.smd" {
}

$animation "walkIdle_a_corrective_animation" "anims\walkIdle_a_corrective_animation.smd" {
}

$animation "walk_a_corrective_animation" "anims\walk_a_corrective_animation.smd" {
}

$animation "shoot1_a_corrective_animation" "anims\shoot1_a_corrective_animation.smd" {
}

$animation "shoot1_ironsight_a_corrective_animation" "anims\shoot1_ironsight_a_corrective_animation.smd" {
}

$animation "shoot2_a_corrective_animation" "anims\shoot2_a_corrective_animation.smd" {
}

$animation "shoot2_ironsight_a_corrective_animation" "anims\shoot2_ironsight_a_corrective_animation.smd" {
}

$animation "shoot3_a_corrective_animation" "anims\shoot3_a_corrective_animation.smd" {
}

$animation "shoot3_ironsight_a_corrective_animation" "anims\shoot3_ironsight_a_corrective_animation.smd" {
}

$animation "basePose_a" "anims\basePose_a.smd" {
	fps 30
	numframes 60
	
	
}

$animation "ironsight" "anims\ironsight.smd" {
	fps 30
	frame 1 1
	numframes 60
	
	
}

$animation "ironsight_transition" "anims\ironsight_transition.smd" {
	fps 30
	numframes 60
	
	
}

$animation "runIdle_a" "anims\runIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "runIdle_a_corrective_animation" 0
	
	
}

$animation "run_a" "anims\run_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "run_a_corrective_animation" 0
	
	
}

$animation "walkIdle_a" "anims\walkIdle_a.smd" {
	fps 30
	loop
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walkIdle_a_corrective_animation" 0
	
	
}

$animation "walk_a" "anims\walk_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "walk_a_corrective_animation" 0
	
	
}

$animation "shoot1_a" "anims\shoot1_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_a_corrective_animation" 0
}

$animation "shoot1_ironsight_a" "anims\shoot1_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot1_ironsight_a_corrective_animation" 0
}

$animation "shoot2_a" "anims\shoot2_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_a_corrective_animation" 0
}

$animation "shoot2_ironsight_a" "anims\shoot2_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot2_ironsight_a_corrective_animation" 0
}

$animation "shoot3_a" "anims\shoot3_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_a_corrective_animation" 0
}

$animation "shoot3_ironsight_a" "anims\shoot3_ironsight_a.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "shoot3_ironsight_a_corrective_animation" 0
}

$animation "nearwall_s_a" "anims\nearwall_s_a.smd" {
	fps 30
	
	
}

$animation "nearwall_s_a_i" "anims\nearwall_s_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_a" "anims\nearwall_a.smd" {
	fps 30
	loop
	
	
}

$animation "nearwall_a_i" "anims\nearwall_a_i.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a" "anims\nearwall_e_a.smd" {
	fps 30
	
	
}

$animation "nearwall_e_a_i" "anims\nearwall_e_a_i.smd" {
	fps 30
	
	
}

$animation "proneF" "anims\proneF.smd" {
	fps 30
	loop
	
	
}

$animation "proneB" "anims\proneB.smd" {
	fps 30
	
	
}

$animation "proneL" "anims\proneL.smd" {
	fps 30
	
	
}

$animation "proneR" "anims\proneR.smd" {
	fps 30
	
	
}

$animation "pickup_s_a" "anims\pickup_s_a.smd" {
	fps 30
	
	
}

$animation "pickup_s_a_i" "anims\pickup_s_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_a" "anims\pickup_a.smd" {
	fps 30
	loop
	
	
}

$animation "pickup_a_i" "anims\pickup_a_i.smd" {
	fps 30
	
	
}

$animation "pickup_e_a" "anims\pickup_e_a.smd" {
	fps 30
	
	
}

$animation "pickup_e_a_i" "anims\pickup_e_a_i.smd" {
	fps 30
	
	
}

$animation "bayonet_e_a" "anims\bayonet_e_a.smd" {
	fps 30
	
	
}

$animation "bayonet_e_a_i" "anims\bayonet_e_a_i.smd" {
	fps 30
	
	
}

$animation "bayonet_s_a" "anims\bayonet_s_a.smd" {
	fps 30
	
	
}

$animation "bayonet_s_a_i" "anims\bayonet_s_a_i.smd" {
	fps 30
	
	
}

$animation "change_firemode_idle" "anims\change_firemode_idle.smd" {
	fps 30
	
	
}

$animation "change_firemode_iron" "anims\change_firemode_iron.smd" {
	fps 30
	
	
}

$animation "bayonet_attack_a" "anims\bayonet_attack_a.smd" {
	fps 30
	
	
}

$animation "bayonet_attack_a_i" "anims\bayonet_attack_a_i.smd" {
	fps 30
	
	
}

$animation "Charge_s_a" "anims\Charge_s_a.smd" {
	fps 30
	
	
}

$animation "Charge_s_a_i" "anims\Charge_s_a_i.smd" {
	fps 30
	
	
}

$animation "Charge_l_a" "anims\Charge_l_a.smd" {
	fps 30
	loop
	
	
}

$animation "Charge_l_a_i" "anims\Charge_l_a_i.smd" {
	fps 30
	
	
}

$animation "Charge_e_a" "anims\Charge_e_a.smd" {
	fps 30
	
	
}

$animation "Charge_e_a_i" "anims\Charge_e_a_i.smd" {
	fps 30
	
	
}

$sequence "runlayer" {
	"runIdle_a"
	"run_a"
	blend "player_movement" 138 232
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
	blend "ironsight" 0 0.5
	blendwidth 3
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
	addlayer "runlayer"
	node "0"
}

$sequence "draw" {
	"anims\draw.smd"
	"anims\draw_2.smd"
	activity "ACT_VM_DRAW" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_AK47.Draw" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	fps 30
	  
	
}

$sequence "Firstdraw" {
	"anims\Firstdraw.smd"
	"anims\Firstdraw_2.smd"
	activity "ACT_VM_READY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_AK47.Draw" }
	{ event 5004 11 "MCV_Weapon_Foley_AK47.DrawMetal" }
	{ event 5004 22 "MCV_Weapon_Foley_AK47_Reload.MetalStart" }
	{ event 5004 29 "MCV_Weapon_Foley_AK47_Reload.MetalEnd" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	fps 30
	
	
}

$sequence "shoot1" {
	"basePose_a"
	"ironsight_transition"
	"ironsight"
	activity "ACT_VM_PRIMARYATTACK" 1
	blend "ironsight" 0 0.5
	blendwidth 3
	snap
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "shootpose1"
	node "0"
}

$sequence "shoot2" {
	"basePose_a"
	"ironsight_transition"
	"ironsight"
	activity "ACT_VM_PRIMARYATTACK" 1
	blend "ironsight" 0 0.5
	blendwidth 3
	snap
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "shootpose2"
	node "0"
}

$sequence "shoot3" {
	"basePose_a"
	"ironsight_transition"
	"ironsight"
	activity "ACT_VM_PRIMARYATTACK" 1
	blend "ironsight" 0 0.5
	blendwidth 3
	snap
	addlayer "walklayer"
	addlayer "runlayer"
	addlayer "shootpose3"
	node "0"
}

$sequence "shootpose1" {
	"shoot1_a"
	"shoot1_ironsight_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	snap
	hidden
	node "Fire"
}

$sequence "shootpose2" {
	"shoot2_a"
	"shoot2_ironsight_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	snap
	hidden
	node "Fire"
}

$sequence "shootpose3" {
	"shoot3_a"
	"shoot3_ironsight_a"
	blend "ironsight" 0 1
	blendwidth 2
	delta
	snap
	hidden
	node "Fire"
}

$sequence "reload" {
	"anims\reload.smd"
	"anims\reload_2.smd"
	activity "ACT_VM_RELOAD" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_AK47_Reload.Hand" }
	{ event 5004 12 "MCV_Weapon_Foley_AK47_Reload.MagOut" }
	{ event 5004 45 "MCV_Weapon_Foley_AK47_Reload.MagIn" }
	{ event 5004 60 "MCV_Weapon_Foley_AK47_Reload.HandEnd" }
	{ event AE_WPN_COMPLETE_RELOAD 54 "" }
	fadein 0.2
	fadeout 0.2
	//addlayer "walklayerironsight"
	node "0"
	fps 30
	
	
}

$sequence "reload_empty" {
	"anims\reload_empty.smd"
	"anims\reload_empty_2.smd"
	activity "ACT_VM_RELOADEMPTY" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_AK47_Reload.Hand" }
	{ event 5004 12 "MCV_Weapon_Foley_AK47_Reload.MagOut" }
	{ event 5004 45 "MCV_Weapon_Foley_AK47_Reload.MagIn" }
	{ event 5004 60 "MCV_Weapon_Foley_AK47_Reload.HandEnd" }
	{ event 5004 70 "MCV_Weapon_Foley_AK47_Reload.MetalStart" }
	{ event 5004 78 "MCV_Weapon_Foley_AK47_Reload.MetalEnd" }
	{ event 5004 80 "MCV_Weapon_Foley_AK47_Reload.Hand" }
	{ event AE_WPN_COMPLETE_RELOAD 81 "" }
	fadein 0.2
	fadeout 0.2
	//addlayer "walklayerironsight"
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
	"anims\bash.smd"
	"anims\bash_2.smd"
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

$sequence "bayonet_unequip" {
	"bayonet_e_a"
	"bayonet_e_a_i"
	activity "ACT_VM_DETACH_SILENCER" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event AE_CL_SETUP_BAYONET 40 "0" }
	{ event 5004 1 "MCV_Weapon_Foley_Bayonet.HandMovement_2" }
	{ event 5004 24 "MCV_Weapon_Foley_Bayonet.KnifeMovement_Off" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayer"
}

$sequence "bayonet_equip" {
	"bayonet_s_a"
	"bayonet_s_a_i"
	activity "ACT_VM_ATTACH_SILENCER" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event AE_CL_SETUP_BAYONET 5 "1" }
	{ event 5004 1 "MCV_Weapon_Foley_Bayonet.HandMovement_1" }
	{ event 5004 22 "MCV_Weapon_Foley_Bayonet.KnifeMovement_On" }
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
	"anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 5004 0 "MCV_Weapon_Foley_AK47.Holster" }
	fadein 0.2
	fadeout 0.2
	addlayer "walklayerironsight"
	fps 30
	
	
}

$sequence "bash_bayonet" {
	"bayonet_attack_a"
	"bayonet_attack_a_i"
	activity "ACT_VM_HITLEFT" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 5004 1 "MCV_Weapon_Foley_Bash.Fast" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	node "0"
}

$sequence "slash_bayonet" {
	"bayonet_attack_a"
	"bayonet_attack_a_i"
	activity "ACT_VM_HITRIGHT" 1
	blend "ironsight" 0 1
	blendwidth 2
	{ event 3200 3 "" }
	{ event 5004 1 "MCV_Weapon_Foley_Bash.Fast" }
	fadein 0
	fadeout 0.2
	addlayer "walklayer"
	node "0"
}

$sequence "ChargeStart" {
	"Charge_s_a"
	"Charge_s_a_i"
	activity "ACT_VM_CHARGE_START" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0
	fadeout 0.2
	node "0"
}

$sequence "ChargeLoop" {
	"Charge_l_a"
	"Charge_l_a_i"
	activity "ACT_VM_CHARGE_LOOP" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0
	fadeout 0.2
	node "0"
}

$sequence "ChargeStab" {
	"Charge_e_a"
	"Charge_e_a_i"
	activity "ACT_VM_CHARGE_STAB" 1
	blend "ironsight" 0 1
	blendwidth 2
	fadein 0
	fadeout 0.2
	node "0"
}

$includemodel "weapons/gesture_animations.mdl"

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\rifle_ak47\md63.qc"
//	}
}

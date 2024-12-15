// Created by Crowbar 0.74

// Far more labor-intensive method, which would require a lot more hands-on work and doesn't produce significantly better results.
// Keeping here for reference.


$modelname "weapons/mcv/v_ak47.mdl"

$bodygroup "studio"
{
	studio "refAK_new.smd"
}
$bodygroup "bayonet"
{
	blank
	studio "v_bayonetAK.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 4.348 -17.192 -12.716

$cdmaterials "models\weapons\mcv\v_ak47\"
$cdmaterials "models\weapons\mcv\v_ak47_bayonet\"
$cdmaterials "models\weapons\mcv\v_akm\"
$cdmaterials "models\weapons\mcv\shells\"
$cdmaterials "models\weapons\mcv\v_kbkg60\"

$attachment "muzzle" "Base" -20 0 0.15 rotate 1 180 0
$attachment "eject" "Base" -1 0 0.7 rotate 0 90 0
$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -10.182 -15.552 -27.509 44.565 24.248 2.077

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
$definebone "Base" "" -3.180958 -17.779638 -3.275469 0 89.999982 0 0 0 0 0 0 0
$definebone "rhand_ikTarget" "Base" 11.985275 7.963726 -2.24749 0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Base" 3.735499 0.001257 -1.323763 0 0 0 0 0 0 0 0 0
$definebone "Mag" "Base" -0.000669 -0.000546 -1.339116 0 0 0 0 0 0 0 0 0
$definebone "Bullets" "Mag" 0.047661 0 0.671442 0 0 0 0 0 0 0 0 0
$definebone "Lock" "Base" 4.805531 0.899267 -0.325907 0 0 0 0 0 0 0 0 0
$definebone "Bolt" "Base" -1.555565 -0.000546 0.655778 0 0 0 0 0 0 0 0 0
$definebone "Bayonet" "Base" -17.412373 0.316513 -0.959334 0 0 0 0 0 0 0 0 0
$definebone "lhand_ikTarget" "Base" -3.72439 -2.136778 -2.093783 66.092831 -137.02037 177.158592 0 0 0 0 0 0

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

$animation "ref_idle" "v_ak47_anims/basePose_a.smd" fps 30 frame 0 1
$animation "ref_shoot" "v_ak47_anims/basePose_a.smd" fps 30 frame 0 1
$animation "ref_shoot_ads" "v_ak47_anims/basePose_a.smd" fps 30 frame 0 1

$animation "fire_layer1" "v_ak47_anims/shoot1_a.smd" fps 30 subtract fire_layer1 0
$animation "fire_layer2" "v_ak47_anims/shoot2_a.smd" fps 30 subtract fire_layer2 0
$animation "fire_layer3" "v_ak47_anims/shoot3_a.smd" fps 30 subtract fire_layer3 0

$animation "fire_ads_layer1" "v_ak47_anims/shoot1_ironsight_a.smd" fps 30 subtract fire_ads_layer1 0
$animation "fire_ads_layer2" "v_ak47_anims/shoot2_ironsight_a.smd" fps 30 subtract fire_ads_layer2 0
$animation "fire_ads_layer3" "v_ak47_anims/shoot3_ironsight_a.smd" fps 30 subtract fire_ads_layer3 0

$sequence "fire_r_1" fire_layer1 fps 30 loop delta hidden
$sequence "fire_r_2" fire_layer2 fps 30 loop delta hidden
$sequence "fire_r_3" fire_layer3 fps 30 loop delta hidden

$sequence "fire_ads_r_1" fire_ads_layer1 fps 30 loop delta hidden
$sequence "fire_ads_r_2" fire_ads_layer2 fps 30 loop delta hidden
$sequence "fire_ads_r_3" fire_ads_layer3 fps 30 loop delta hidden


$sequence "idle" {
	"ref_idle"
	activity "ACT_VM_IDLE" 1
	fadein 0.15
	fadeout 0.15
	fps 30
}

$sequence "fire1" {
	"ref_shoot"
	activity "ACT_VM_PRIMARYATTACK" 1
	addlayer "fire_r_1"
	fadein 0
	fadeout 0.1
	snap
	fps 30
}

$sequence "fire2" {
	"ref_shoot"
	activity "ACT_VM_PRIMARYATTACK" 1
	addlayer "fire_r_2"
	fadein 0
	fadeout 0.1
	snap
	fps 30
}

$sequence "fire3" {
	"ref_shoot"
	activity "ACT_VM_PRIMARYATTACK" 1
	addlayer "fire_r_3"
	fadein 0
	fadeout 0.1
	snap
	fps 30
}

$sequence "fire1_ads" {
	"ref_shoot_ads"
	activity "ACT_VM_PRIMARYATTACK_ADS" 1
	addlayer "fire_ads_r_1"
	fadein 0
	fadeout 0.1
	snap
	fps 30
}

$sequence "fire2_ads" {
	"ref_shoot_ads"
	activity "ACT_VM_PRIMARYATTACK_ADS" 1
	addlayer "fire_ads_r_2"
	fadein 0
	fadeout 0.1
	snap
	fps 30
}

$sequence "fire3_ads" {
	"ref_shoot_ads"
	activity "ACT_VM_PRIMARYATTACK_ADS" 1
	addlayer "fire_ads_r_3"
	fadein 0
	fadeout 0.1
	snap
	fps 30
}

$includemodel "weapons/gesture_animations.mdl"

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\guns\rifle_ak47\AK47_new.qc"
//	}
}

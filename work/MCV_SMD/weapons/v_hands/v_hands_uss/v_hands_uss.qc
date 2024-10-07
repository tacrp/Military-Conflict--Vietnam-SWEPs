// Created by Crowbar 0.74

$modelname "weapons/mcv/v_hands/v_hands_uss.mdl"

$bodygroup "cloth_top"
{
	studio "US_sleeve_long.smd"
	studio "US_sleeve_short.smd"
}
$bodygroup "gloves"
{
	studio "v_glove_blank.smd"
	studio "v_glove_bandage.smd"
	studio "v_glove_bandage2.smd"
	studio "v_glove_black.smd"
	studio "v_glove_black_half.smd"
	studio "v_glove_brown.smd"
	studio "v_glove_brown_half.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition -0.009 9.835 -15.823

$cdmaterials "models\weapons\mcv\v_hand\"
$cdmaterials "models\player\equipment\"

$texturegroup "skinfamilies"
{
	{ "cloth01" "v_hands_light"  }
	{ "cloth02" "v_hands_light"  }
	{ "cloth03" "v_hands_light"  }
	{ "cloth04" "v_hands_light"  }
	{ "cloth05" "v_hands_light"  }
	{ "cloth01" "v_hands_dark"   }
	{ "cloth02" "v_hands_dark"   }
	{ "cloth03" "v_hands_dark"   }
	{ "cloth04" "v_hands_dark"   }
	{ "cloth05" "v_hands_dark"   }
	{ "cloth01" "v_hands_medium" }
	{ "cloth02" "v_hands_medium" }
	{ "cloth03" "v_hands_medium" }
	{ "cloth04" "v_hands_medium" }
	{ "cloth05" "v_hands_medium" }
	{ "cloth06" "v_hands_medium" }
	{ "cloth07" "v_hands_medium" }
}

$cbox 0 0 0 0 0 0

$bbox -17.218 -31.554 -27.51 -2.453 31.536 -4.136

$definebone "root" "" 0 7.450089 -27.509027 0 0 0 0 0 0 0 0 0
$definebone "pelvis" "root" -0.000002 0 0 -89.790623 -89.997175 89.997175 0 0 0 0 0 0
$definebone "spine_01" "pelvis" 4.255465 -0.335203 -0.000002 0 -7.153664 0 0 0 0 0 0 0
$definebone "spine_02" "spine_01" 7.431253 1.4965 0.000002 0 14.063479 0 0 0 0 0 0 0
$definebone "spine_03" "spine_02" 5.278478 0.165533 0.000001 0 2.779304 0 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 4.678658 -1.075628 -1.488978 66.457987 105.584985 113.208528 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.214485 0.000012 0.000013 39.360362 -8.439269 13.804506 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.944897 -0.000013 -0.000211 -11.598276 -34.295305 -3.613928 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620178 0 -0.00002 -40.973639 21.950756 -97.528305 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511818 0.000006 -0.00001 0.00028 0.000056 -13.51017 0 0 0 0 0 0
$definebone "clavicle_r" "spine_03" 4.678667 -1.075629 1.488977 66.457884 -74.414959 113.208616 0 0 0 0 0 0
$definebone "upperarm_r" "clavicle_r" -6.214487 -0.000005 -0.000019 -39.361274 171.560855 166.195359 0 0 0 0 0 0
$definebone "lowerarm_r" "upperarm_r" 11.944918 0 0 -11.599113 34.295384 -86.386709 0 0 0 0 0 0
$definebone "hand_r" "lowerarm_r" 10.620189 0.000001 0 -16.39349 136.882305 7.274699 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" 5.511823 -0.000002 0.000006 -0.000128 -179.9998 76.489601 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.196847 0.000003 0 0.000854 -0.000057 -19.951882 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" 0.196848 -0.000005 0.000001 -0.000063 -179.999937 160.048121 0 0 0 0 0 0
$definebone "index_01_l" "hand_l" 4.75116 0.694378 -0.830478 -3.764671 25.536501 14.866875 0 0 0 0 0 0
$definebone "index_02_l" "index_01_l" 1.688053 -0.000024 0.000001 -0.474918 11.986268 1.337967 0 0 0 0 0 0
$definebone "index_03_l" "index_02_l" 1.336151 -0.000051 -0.000007 -1.907942 -9.554243 1.137832 0 0 0 0 0 0
$definebone "middle_01_l" "hand_l" 4.820513 0.509338 0.224859 -7.040154 22.825842 1.917798 0 0 0 0 0 0
$definebone "middle_02_l" "middle_01_l" 1.827 0.000073 0.000009 1.136698 12.280716 -2.025066 0 0 0 0 0 0
$definebone "middle_03_l" "middle_02_l" 1.436573 -0.00001 0.000008 -0.387428 -15.345292 0.779272 0 0 0 0 0 0
$definebone "pinky_01_l" "hand_l" 3.992353 0.891087 1.827992 -18.93401 20.185997 -18.724839 0 0 0 0 0 0
$definebone "pinky_02_l" "pinky_01_l" 1.405922 0.000031 -0.000006 -1.316016 11.208148 1.063975 0 0 0 0 0 0
$definebone "pinky_03_l" "pinky_02_l" 1.175358 -0.000133 0.000009 7.050081 1.063698 0.44816 0 0 0 0 0 0
$definebone "ring_01_l" "hand_l" 4.526758 0.690466 1.120836 -10.989724 23.292169 -13.510236 0 0 0 0 0 0
$definebone "ring_02_l" "ring_01_l" 1.744041 -0.000031 -0.000004 -1.669706 13.31537 0.301546 0 0 0 0 0 0
$definebone "ring_03_l" "ring_02_l" 1.368763 -0.000029 -0.00001 9.08568 -12.938302 -0.364977 0 0 0 0 0 0
$definebone "thumb_01_l" "hand_l" 1.874865 0.935089 -0.999133 36.919099 27.057082 95.069574 0 0 0 0 0 0
$definebone "thumb_02_l" "thumb_01_l" 1.523451 -0.000032 -0.000006 9.832758 15.151525 1.612994 0 0 0 0 0 0
$definebone "thumb_03_l" "thumb_02_l" 1.599283 -0.000006 0.000006 4.129645 -12.231731 2.420923 0 0 0 0 0 0
$definebone "index_01_r" "hand_r" -4.751154 -0.694384 0.830485 -3.763874 25.536964 14.867003 0 0 0 0 0 0
$definebone "index_02_r" "index_01_r" -1.688076 0.000046 -0.000026 -0.475095 11.986173 1.337804 0 0 0 0 0 0
$definebone "index_03_r" "index_02_r" -1.336143 0.000051 -0.000011 0.997006 -9.496542 1.137498 0 0 0 0 0 0
$definebone "middle_01_r" "hand_r" -4.820513 -0.509354 -0.224855 -7.040619 22.825785 1.917925 0 0 0 0 0 0
$definebone "middle_02_r" "middle_01_r" -1.826988 -0.000077 0.000008 1.136864 12.280838 -2.024944 0 0 0 0 0 0
$definebone "middle_03_r" "middle_02_r" -1.436581 0.00001 -0.000002 -4.390001 -15.399841 0.781519 0 0 0 0 0 0
$definebone "pinky_01_r" "hand_r" -3.992365 -0.891088 -1.82799 -18.933903 20.185936 -18.724596 0 0 0 0 0 0
$definebone "pinky_02_r" "pinky_01_r" -1.405922 -0.000026 -0.000001 -1.315567 11.208201 1.063932 0 0 0 0 0 0
$definebone "pinky_03_r" "pinky_02_r" -1.175369 0.000119 -0.000017 3.869531 1.038771 0.445824 0 0 0 0 0 0
$definebone "ring_01_r" "hand_r" -4.526766 -0.690475 -1.120831 -10.98933 23.292 -13.510109 0 0 0 0 0 0
$definebone "ring_02_r" "ring_01_r" -1.744049 0.000035 -0.000016 -1.669775 13.315429 0.301497 0 0 0 0 0 0
$definebone "ring_03_r" "ring_02_r" -1.368763 0.000019 -0.000002 2.987744 -12.899455 -0.360786 0 0 0 0 0 0
$definebone "thumb_01_r" "hand_r" -1.874853 -0.935091 0.999135 36.919047 27.056386 95.069184 0 0 0 0 0 0
$definebone "thumb_02_r" "thumb_01_r" -1.523455 0.000034 0.000021 9.833444 15.151523 1.613216 0 0 0 0 0 0
$definebone "thumb_03_r" "thumb_02_r" -1.599279 0.000008 -0.000007 0.479163 -12.385915 2.414784 0 0 0 0 0 0





$sequence "idle" {
	"v_hands_uss_anims\idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
	loop
	
	
}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\guns\v_hands\us_hands\v_hands_uss.qc"
//	}
}

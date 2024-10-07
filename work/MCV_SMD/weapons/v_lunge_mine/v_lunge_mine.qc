// Created by Crowbar 0.74

$modelname "weapons/mcv/v_lunge_mine.mdl"

$bodygroup "studio"
{
	studio "ref.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition 1.564 -24.028 -12.88

$cdmaterials "models\weapons\mcv\v_lungemine\"

$attachment "cam" "cam_driver" 0 0 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -11.811 -10.939 -27.509 59.867 14.067 1.75

$definebone "root" "" 0 7.450089 -27.509027 0 0 0 0 0 0 0 0 0
$definebone "pelvis" "root" -0.000002 0 0 -89.790623 -89.999067 89.999067 0 0 0 0 0 0
$definebone "spine_01" "pelvis" 4.25547 -0.335207 -0.000003 0 -7.153837 0 0 0 0 0 0 0
$definebone "spine_02" "spine_01" 7.431244 1.496522 0 0 14.063535 0 0 0 0 0 0 0
$definebone "spine_03" "spine_02" 5.278483 0.165544 0 0 2.779417 0 0 0 0 0 0 0
$definebone "clavicle_l" "spine_03" 2.489222 -14.187499 -11.803704 21.36025 -162.377256 -108.853879 0 0 0 0 0 0
$definebone "upperarm_l" "clavicle_l" 6.21452 -0.000003 -0.000006 -6.792187 -86.29513 -24.813941 0 0 0 0 0 0
$definebone "lowerarm_l" "upperarm_l" 11.944861 0.000003 0.000011 -15.011666 -46.555228 -3.6133 0 0 0 0 0 0
$definebone "hand_l" "lowerarm_l" 10.620148 -0.000004 0.000011 -25.42409 49.431356 -151.253747 0 0 0 0 0 0
$definebone "index_01_l" "hand_l" 4.751232 0.694273 -0.830474 -15.431532 38.573527 -3.474529 0 0 0 0 0 0
$definebone "index_02_l" "index_01_l" 1.687992 -0.000002 0 -1.41595 86.596888 -0.103137 0 0 0 0 0 0
$definebone "index_03_l" "index_02_l" 1.336142 0.000004 -0.000005 0.518698 11.694292 1.420932 0 0 0 0 0 0
$definebone "middle_01_l" "hand_l" 4.82058 0.509297 0.224865 -7.031516 88.51516 -21.324399 0 0 0 0 0 0
$definebone "middle_02_l" "middle_01_l" 1.826917 0.000004 0.000001 2.308335 66.722199 -0.253138 0 0 0 0 0 0
$definebone "middle_03_l" "middle_02_l" 1.436554 -0.000004 0 -3.592215 -41.679583 2.643162 0 0 0 0 0 0
$definebone "pinky_01_l" "hand_l" 3.992388 0.890996 1.828013 5.294584 104.770662 -29.922092 0 0 0 0 0 0
$definebone "pinky_02_l" "pinky_01_l" 1.405894 -0.000006 0 -1.67166 59.050872 -0.261099 0 0 0 0 0 0
$definebone "pinky_03_l" "pinky_02_l" 1.175451 0 -0.000002 3.624819 -27.040623 -1.426898 0 0 0 0 0 0
$definebone "ring_01_l" "hand_l" 4.52673 0.690354 1.120829 1.752159 104.638129 -29.211684 0 0 0 0 0 0
$definebone "ring_02_l" "ring_01_l" 1.744166 0 0.000002 -1.402423 57.810359 -0.955122 0 0 0 0 0 0
$definebone "ring_03_l" "ring_02_l" 1.368767 0 0.000001 2.426021 -42.314026 -1.781161 0 0 0 0 0 0
$definebone "thumb_01_l" "hand_l" 1.874819 0.935028 -0.999146 38.909682 25.530253 91.401557 0 0 0 0 0 0
$definebone "thumb_02_l" "thumb_01_l" 1.523489 0 0.000002 -5.336816 8.712047 -5.438117 0 0 0 0 0 0
$definebone "thumb_03_l" "thumb_02_l" 1.599297 0 0.000006 0.479164 -12.385637 2.414787 0 0 0 0 0 0
$definebone "lowerarm_twist_01_l" "lowerarm_l" 5.511814 -0.000006 0.000003 0 0.000002 -52.254837 0 0 0 0 0 0
$definebone "upperarm_twist_01_l" "upperarm_l" 0.19685 -0.000003 -0.000001 -0.000002 0.000001 0 0 0 0 0 0 0
$definebone "clavicle_r" "spine_03" 4.658432 -1.196792 0.263834 52.053425 -95.57845 102.52327 0 0 0 0 0 0
$definebone "upperarm_r" "clavicle_r" -6.214492 -0.00001 -0.000012 14.040507 -94.976922 -10.792175 0 0 0 0 0 0
$definebone "lowerarm_r" "upperarm_r" -11.944907 0.00001 0.000011 -20.843982 -85.682688 -3.613307 0 0 0 0 0 0
$definebone "hand_r" "lowerarm_r" -10.620182 0.000007 0 -1.817937 56.842856 -134.666974 0 0 0 0 0 0
$definebone "index_01_r" "hand_r" -4.751163 -0.69438 0.830482 -17.759004 25.536906 -0.077574 0 0 0 0 0 0
$definebone "index_02_r" "index_01_r" -1.688066 0.000037 -0.00003 -0.475269 11.986108 1.337803 0 0 0 0 0 0
$definebone "index_03_r" "index_02_r" -1.336144 0.000049 -0.000006 0.997294 -9.496313 1.137382 0 0 0 0 0 0
$definebone "middle_01_r" "hand_r" -4.82052 -0.509342 -0.224858 -9.84302 69.600563 -23.010499 0 0 0 0 0 0
$definebone "middle_02_r" "middle_01_r" -1.826998 -0.000056 0.000005 2.187264 53.348046 -0.780086 0 0 0 0 0 0
$definebone "middle_03_r" "middle_02_r" -1.43658 0.00001 -0.000001 -3.51693 32.690098 -2.742581 0 0 0 0 0 0
$definebone "pinky_01_r" "hand_r" -3.992366 -0.891089 -1.827992 22.873732 105.176833 -20.242601 0 0 0 0 0 0
$definebone "pinky_02_r" "pinky_01_r" -1.405929 -0.000031 -0.000001 -1.315686 11.208028 1.063807 0 0 0 0 0 0
$definebone "pinky_03_r" "pinky_02_r" -1.175365 0.000123 -0.000013 2.707056 40.482449 2.801817 0 0 0 0 0 0
$definebone "ring_01_r" "hand_r" -4.526769 -0.690462 -1.120839 4.982092 87.361794 -28.432805 0 0 0 0 0 0
$definebone "ring_02_r" "ring_01_r" -1.744045 0.000036 -0.000007 -1.499197 51.475147 -0.794585 0 0 0 0 0 0
$definebone "ring_03_r" "ring_02_r" -1.368765 0.000029 0 2.701618 20.146683 1.326161 0 0 0 0 0 0
$definebone "thumb_01_r" "hand_r" -1.874856 -0.935088 0.999135 34.163578 68.689402 124.51719 0 0 0 0 0 0
$definebone "thumb_02_r" "thumb_01_r" -1.523455 0.000042 0.000022 7.954438 43.092907 6.019147 0 0 0 0 0 0
$definebone "thumb_03_r" "thumb_02_r" -1.599284 -0.000002 0 -1.534773 37.382694 1.925024 0 0 0 0 0 0
$definebone "lowerarm_twist_01_r" "lowerarm_r" -5.511816 0.000007 0.000001 -0.000003 -0.000002 -50.521253 0 0 0 0 0 0
$definebone "upperarm_twist_01_r" "upperarm_r" -0.196847 -0.000003 -0.000002 0.000004 0 -19.951879 0 0 0 0 0 0
$definebone "Base" "" -3.371336 -17.809372 -4.057035 0 0 0 0 0 0 0 0 0
$definebone "cam_driver" "" 0 0 0 0 -89.999982 -0.000057 0 0 0 0 0 0

$bonemerge "root"
$bonemerge "pelvis"
$bonemerge "spine_01"
$bonemerge "spine_02"
$bonemerge "spine_03"
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


$sectionframes 30 32

$sequence "idle" {
	"v_lunge_mine_anims\idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
	loop
}

$sequence "draw" {
	"v_lunge_mine_anims\draw.smd"
	activity "ACT_VM_DRAW" 1
	fadein 0
	fadeout 0.2
	node "0"
	fps 30
}

$sequence "idletorun" {
	"v_lunge_mine_anims\idletorun.smd"
	activity "ACT_VM_IDLETORUN" 1
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
}

$sequence "run" {
	"v_lunge_mine_anims\run.smd"
	activity "ACT_VM_RUN" 1
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
}

$sequence "runtoidle" {
	"v_lunge_mine_anims\runtoidle.smd"
	activity "ACT_VM_RUNTOIDLE" 1
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
}

$sequence "walk" {
	"v_lunge_mine_anims\walk.smd"
	activity "ACT_VM_WALK" 1
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
}

$sequence "idletonearwall" {
	"v_lunge_mine_anims\idletonearwall.smd"
	activity "ACT_VM_IDLE_TO_LOWERED" 1
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
}

$sequence "nearwall" {
	"v_lunge_mine_anims\nearwall.smd"
	activity "ACT_VM_IDLE_LOWERED" 1
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
	loop
}

$sequence "nearwalltoidle" {
	"v_lunge_mine_anims\nearwalltoidle.smd"
	activity "ACT_VM_LOWERED_TO_IDLE" 1
	fadein 0.2
	fadeout 0.2
	node "0"
	fps 30
}

$sequence "prone" {
	"v_lunge_mine_anims\prone.smd"
	activity "ACT_VM_CRAWL" 1
	fadein 0.2
	fadeout 0.2
	fps 20
	loop
}

$sequence "pronetoidle" {
	"v_lunge_mine_anims\pronetoidle.smd"
	activity "ACT_VM_CRAWLTOIDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "idletoprone" {
	"v_lunge_mine_anims\idletoprone.smd"
	activity "ACT_VM_IDLETOPRONE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "pickupstart" {
	"v_lunge_mine_anims\pickupstart.smd"
	activity "ACT_VM_PICKUPSTART" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "pickuploop" {
	"v_lunge_mine_anims\pickuploop.smd"
	activity "ACT_VM_PICKUPLOOP" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "pickupend" {
	"v_lunge_mine_anims\pickupend.smd"
	activity "ACT_VM_PICKUPEND" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "holster" {
	"v_lunge_mine_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	fadein 0.2
	fadeout 0.2
	fps 90
}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "models\guns\equipment_lungemine\jesus.qc"
//	}
}

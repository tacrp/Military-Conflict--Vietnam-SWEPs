// Created by Crowbar 0.74

$modelname "weapons\mcv\w_m16a1.mdl"

$bodygroup "tape"
{
	studio "w_m16a1_lod0.smd"
	studio "w_m16a1_tape_lod0.smd"
}
$bodygroup "bayonet"
{
	blank
	studio "w_m16a1_m7b_lod0.smd"
}
$bodygroup "magazine"
{
	studio "w_magazine20_lod0.smd"
}

$lod 15
{
	replacemodel "w_m16a1_lod0.smd" "w_m16a1_lod0_lod1.smd"
	replacemodel "w_m16a1_tape_lod0.smd" "w_m16a1_tape_lod0_lod1.smd"
	replacemodel "w_m16a1_m7b_lod0.smd" "w_m16a1_m7b_lod0_lod1.smd"
	replacemodel "w_magazine20_lod0.smd" "w_magazine20_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_m16a1_lod0.smd" "w_m16a1_lod0_lod2.smd"
	replacemodel "w_m16a1_tape_lod0.smd" "w_m16a1_tape_lod0_lod2.smd"
	replacemodel "w_m16a1_m7b_lod0.smd" "w_m16a1_m7b_lod0_lod2.smd"
	replacemodel "w_magazine20_lod0.smd" "w_magazine20_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.053 -6.911 -0.92

$cdmaterials "models\weapons\mcv\w_bayonet\"
$cdmaterials "models\weapons\mcv\w_m16a1\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 0.7 23.8 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" 0 0.7 1.8 rotate 0 180 180
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 -1.5 1.8 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -14.827 -1.211 -6.803 28.411 1.105 3.536

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999989 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone4" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_m16a1_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_m16a1_physics.smd"
{
	$mass 8
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 8

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\car15m16\w_m16a1_smd.qc"
//	}
}

// Created by Crowbar 0.74

$modelname "weapons\mcv\w_l1a1_sog.mdl"

$bodygroup "Body"
{
	studio "w_l1a1_sog_lod0.smd"
}
$bodygroup "bayonet"
{
	blank
	studio "w_l1a1_m7b_lod0.smd"
}

$lod 15
{
	replacemodel "w_l1a1_sog_lod0.smd" "w_l1a1_sog_lod0_lod1.smd"
	replacemodel "w_l1a1_m7b_lod0.smd" "w_l1a1_m7b_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_l1a1_sog_lod0.smd" "w_l1a1_sog_lod0_lod2.smd"
	replacemodel "w_l1a1_m7b_lod0.smd" "w_l1a1_m7b_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.018 -8.735 -2.466

$cdmaterials "models\weapons\mcv\w_bayonet\"
$cdmaterials "models\weapons\mcv\w_fal\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 0.5 21.1 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -1 1 3.3 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 -0.5 3 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -17.032 -2.187 -7.952 34.236 1.825 3.019

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999989 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone4" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_l1a1_sog_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_l1a1_sog_physics.smd"
{
	$mass 8
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 6

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\fal\w_l1a1_sog.qc"
//	}
}

// Created by Crowbar 0.74

$modelname "weapons\mcv\w_mas38.mdl"

$bodygroup "Body"
{
	studio "w_mas38_lod0.smd"
}

$lod 15
{
	replacemodel "w_mas38_lod0.smd" "w_mas38_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_mas38_lod0.smd" "w_mas38_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.272 2.357 -1.808

$cdmaterials "models\weapons\mcv\w_mas38\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 1.8 12.1 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.75 1.7 0.5 rotate 0 -180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 0 1 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -16.99 -1.627 -7.04 12.228 1.206 3.343

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000009 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_mas38_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_mas38_physics.smd"
{
	$mass 8
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 9

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\player\animation_iiopn\w_model\mas38\w_mas38.qc"
//	}
}

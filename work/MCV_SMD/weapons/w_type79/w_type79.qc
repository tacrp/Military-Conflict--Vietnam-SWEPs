// Created by Crowbar 0.74

$modelname "weapons\mcv\w_type79.mdl"

$bodygroup "Body"
{
	studio "w_type79_lod0.smd"
}

$lod 15
{
	replacemodel "w_type79_lod0.smd" "w_type79_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_type79_lod0.smd" "w_type79_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 -3.41 0.325

$cdmaterials "models\weapons\mcv\w_type79\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 3.4 8.8 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" 0 4.4 3.8 rotate 0 180 90

$cbox 0 0 0 0 0 0

$bbox -2.227 -1.121 -4.013 9.007 1.121 4.642

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000009 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_type79_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_type79_physics.smd"
{
	$mass 2
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 4

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\player\animation_iiopn\w_model\m8type79\w_type79.qc"
//	}
}

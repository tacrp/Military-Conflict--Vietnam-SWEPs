// Created by Crowbar 0.74

$modelname "weapons\mcv\w_m24.mdl"

$bodygroup "Body"
{
	studio "w_m24_test.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition -0.091 -6.881 -0.7

$cdmaterials "models\weapons\mcv\w_bren\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 2.5 28.5 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" 0 0.3 2 rotate 0 -90 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 3 2 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -15.208 -5.733 -11.999 28.982 5.546 10.619

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000009 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_m24_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_m24_physics.smd"
{
	$mass 8
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 1

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\player\animation_iiopn\w_model\m24\w_m24.qc"
//	}
}

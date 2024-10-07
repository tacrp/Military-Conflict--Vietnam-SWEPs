// Created by Crowbar 0.74

$modelname "weapons\mcv\w_gp25.mdl"

$bodygroup "Body"
{
	studio "w_gp25_lod0.smd"
}

$lod 15
{
	replacemodel "w_gp25_lod0.smd" "w_gp25_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_gp25_lod0.smd" "w_gp25_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.141 -3.082 -2.528

$cdmaterials "models\weapons\mcv\w_akm\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 0.5 20.3 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -1 1 3.3 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 -0.5 3 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -14.742 -1.864 -8.002 20.946 2.145 2.887

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000009 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_gp25_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_gp25_physics.smd"
{
	$mass 8
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 10

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\player\animation_iiopn\w_model\gp25\w_gp25.qc"
//	}
}

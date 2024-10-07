// Created by Crowbar 0.74

$modelname "weapons\mcv\w_type14.mdl"

$bodygroup "Body"
{
	studio "w_type14_lod0.smd"
}

$lod 15
{
	replacemodel "w_type14_lod0.smd" "w_type14_lod0_lod1.smd"
	nofacial
}
$lod 25
{
	replacemodel "w_type14_lod0.smd" "w_type14_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.009 -1.827 -0.008

$cdmaterials "models\weapons\mcv\w_type14\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 2.3 10.5 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.65 2.6 1 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 0 0 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -2.699 -0.845 -3.167 6.419 0.872 2.996

$definebone "ValveBiped.weapon_bone" "" 0 0.0005 -0.064417 0 0.000172 89.999968 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 -0.000172 0 0.000116 0 0 0 0 0 0


$sequence "idle" {
	"w_type14_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_type14_physics.smd"
{
	$mass 4
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 3

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\pistol\w_type14.qc"
//	}
}

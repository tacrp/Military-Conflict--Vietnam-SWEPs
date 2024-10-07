// Created by Crowbar 0.74

$modelname "weapons\mcv\w_fist.mdl"

$bodygroup "Body"
{
	studio "w_fist_lod0.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 0.009 0.001 0.006

$cdmaterials ""

$cbox 0 0 0 0 0 0

$bbox -5.611 -1.003 -1.883 9.698 1.003 2.448

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000009 0 0 0 0 0 0


$sequence "idle" {
	"w_fist_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_fist_physics.smd"
{
	$mass 1
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
//		"value" "e:\animations\vietnamcontent\vietnam\models\player\animation_iiopn\w_model\knife\w_fists.qc"
//	}
}

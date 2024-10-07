// Created by Crowbar 0.74

$modelname "weapons\mcv\w_wrench.mdl"

$bodygroup "Body"
{
	studio "w_wrench_lod0.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 0 -0.818 0.965

$cdmaterials "models\weapons\mcv\w_wrench\"
$cdmaterials ""

$cbox 0 0 0 0 0 0

$bbox -8.949 -0.923 -1.551 10.477 0.923 3.546

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000016 0 0 0 0 0 0


$sequence "idle" {
	"w_wrench_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_wrench_physics.smd"
{
	$mass 1
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
//		"value" "e:\animations\vietnamcontent\vietnam\models\player\animation_iiopn\w_model\knife\w_wrench.qc"
//	}
}

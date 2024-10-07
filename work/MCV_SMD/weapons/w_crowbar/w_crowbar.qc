// Created by Crowbar 0.74

$modelname "weapons\mcv\w_crowbar.mdl"

$bodygroup "Body"
{
	studio "w_crowbar_lod0.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 0 0.3 -1.865

$cdmaterials "models\weapons\mcv\w_crowbar\"
$cdmaterials ""

$cbox 0 0 0 0 0 0

$bbox -12.931 -1.212 -6.512 12.578 1.212 3.151

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000016 0 0 0 0 0 0


$sequence "idle" {
	"w_crowbar_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_crowbar_physics.smd"
{
	$mass 2
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
//		"value" "e:\animations\vietnamcontent\vietnam\models\player\animation_iiopn\w_model\crowbar\w_crowbar.qc"
//	}
}

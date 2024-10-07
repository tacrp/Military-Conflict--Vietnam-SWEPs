// Created by Crowbar 0.74

$modelname "weapons\mcv\w_shovel.mdl"

$bodygroup "studio"
{
	studio "w_us_shovel_lod0.smd"
	studio "w_vc_shovel_lod0.smd"
}

$lod 20
{
	replacemodel "w_us_shovel_lod0.smd" "w_us_shovel_lod0_lod1.smd"
	replacemodel "w_vc_shovel_lod0.smd" "w_vc_shovel_lod0_lod1.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.078 -0.377 -0.452

$cdmaterials "models\weapons\mcv\w_shovel\"
$cdmaterials ""

$cbox 0 0 0 0 0 0

$bbox -14.37 -0.965 -4.101 15.078 1.044 3.092

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000043 0 0 0 0 0 0


$sequence "idle" {
	"w_shovel_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_shovel_physics.smd"
{
	$mass 2
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\shovel\w_shovel.qc"
//	}
}

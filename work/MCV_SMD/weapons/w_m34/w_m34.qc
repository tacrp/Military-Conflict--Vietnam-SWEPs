// Created by Crowbar 0.74

$modelname "weapons\mcv\w_m34.mdl"

$bodygroup "Body"
{
	studio "w_m34_lod0.smd"
}

$lod 12
{
	replacemodel "w_m34_lod0.smd" "w_m34_lod0_lod1.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.128 0.029 0.614

$cdmaterials "models\weapons\mcv\w_m34\"
$cdmaterials ""

$attachment "0" "ValveBiped.weapon_bone" 0 3.5 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -1.433 -1.433 -2.565 1.433 1.469 3.53

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999968 0 0 0 0 0 0


$sequence "idle" {
	"w_m34_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_m34_physics.smd"
{
	$mass 4
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\grenade\w_m34.qc"
//	}
}

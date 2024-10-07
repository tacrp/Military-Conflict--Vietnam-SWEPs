// Created by Crowbar 0.74

$modelname "weapons\mcv\w_m1905_bayonet.mdl"

$bodygroup "Body"
{
	studio "w_m1905_lod0.smd"
}

$lod 15
{
	replacemodel "w_m1905_lod0.smd" "w_m1905_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_m1905_lod0.smd" "w_m1905_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.024 -9.448 -0.112

$cdmaterials "models\weapons\mcv\w_m1905_bayonet\"

$cbox 0 0 0 0 0 0

$bbox -4.754 -0.774 -2.649 23.804 0.835 2.478

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999982 0 0 0 0 0 0


$sequence "idle" {
	"w_m1905_bayonet_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_m1905_bayonet_physics.smd"
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
//		"value" "models\player\animation_iiopn\w_model\knife\w_m1905_lod0.qc"
//	}
}

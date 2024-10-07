// Created by Crowbar 0.74

$modelname "weapons\mcv\w_type30_bayonet.mdl"

$bodygroup "Body"
{
	studio "w_type30_lod0.smd"
}

$lod 15
{
	replacemodel "w_type30_lod0.smd" "w_type30_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_type30_lod0.smd" "w_type30_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.108 -8.213 -0.186

$cdmaterials "models\weapons\mcv\w_type30_bayonet\"

$cbox 0 0 0 0 0 0

$bbox -5.614 -0.842 -2.544 21.78 0.767 2.172

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999982 0 0 0 0 0 0


$sequence "idle" {
	"w_type30_bayonet_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_type30_bayonet_physics.smd"
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
//		"value" "models\player\animation_iiopn\w_model\knife\w_type30_lod0.qc"
//	}
}

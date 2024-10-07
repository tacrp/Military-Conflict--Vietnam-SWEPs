// Created by Crowbar 0.74

$modelname "weapons\mcv\w_m7_bayonet.mdl"

$bodygroup "Body"
{
	studio "w_m7b_lod0.smd"
}

$lod 15
{
	replacemodel "w_m7b_lod0.smd" "w_m7b_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_m7b_lod0.smd" "w_m7b_lod0_lod2.smd"
	nofacial
}

$surfaceprop "pottery"

$contents "solid"

$illumposition 0.008 -2.069 0.318

$cdmaterials "models\weapons\mcv\w_bayonet\"

$cbox 0 0 0 0 0 0

$bbox -5.611 -1.003 -1.883 9.698 1.003 2.448

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.093465 0 0.000172 89.999989 0 0 0 0 0 0


$sequence "idle" {
	"w_m7_bayonet_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_m7_bayonet_physics.smd"
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
//		"value" "models\guns\bayonet_ak47_m7\wbake\w_m7b_lod0.qc"
//	}
}

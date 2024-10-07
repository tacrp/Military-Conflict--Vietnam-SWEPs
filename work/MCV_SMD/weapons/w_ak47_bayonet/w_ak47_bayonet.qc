// Created by Crowbar 0.74

$modelname "weapons\mcv\w_ak47_bayonet.mdl"

$bodygroup "Body"
{
	studio "w_akb_lod0.smd"
}

$lod 15
{
	replacemodel "w_akb_lod0.smd" "w_akb_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_akb_lod0.smd" "w_akb_lod0_lod2.smd"
	nofacial
}

$surfaceprop "pottery"

$contents "solid"

$illumposition -0.008 -3.302 0.357

$cdmaterials "models\weapons\mcv\w_ak47_bayonet\"

$cbox 0 0 0 0 0 0

$bbox -5.074 -0.818 -1.25 11.647 0.818 1.9

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.093465 0 0.000172 89.999989 0 0 0 0 0 0


$sequence "idle" {
	"w_ak47_bayonet_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_ak47_bayonet_physics.smd"
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
//		"value" "models\guns\bayonet_ak47_m7\wbake\w_akb_lod0.qc"
//	}
}

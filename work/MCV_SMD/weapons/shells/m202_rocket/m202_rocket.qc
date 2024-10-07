// Created by Crowbar 0.74

$modelname "weapons\shells\m202_rocket.mdl"

$bodygroup "Body"
{
	studio "m202_rocket_lod0.smd"
}

$lod 6
{
	replacemodel "m202_rocket_lod0.smd" "m202_rocket_lod0_lod1.smd"
	nofacial
}
$lod 12
{
	replacemodel "m202_rocket_lod0.smd" "m202_rocket_lod0_lod2.smd"
	nofacial
}
$lod 18
{
	replacemodel "m202_rocket_lod0.smd" "m202_rocket_lod0_lod3.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 -0.006 0.018

$cdmaterials "models\weapons\mcv\shells\"

$attachment "0" "base" 0 0 -10 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -11.515 -2.212 -2.212 11.384 2.212 2.212

$definebone "base" "" 0 0 0 0 0 89.999982 0 0 0 0 0 0


$sequence "idle" {
	"m202_rocket_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "m202_rocket_physics.smd"
{
	$mass 7
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\shells\m202_rocket.qc"
//	}
}

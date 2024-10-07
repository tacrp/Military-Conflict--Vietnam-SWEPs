// Created by Crowbar 0.74

$modelname "weapons\shells\flare.mdl"

$bodygroup "Body"
{
	studio "flare_lod0.smd"
}

$lod 6
{
	replacemodel "flare_lod0.smd" "flare_lod0_lod1.smd"
	nofacial
}
$lod 9
{
	replacemodel "flare_lod0.smd" "flare_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.004 -0.074 0.01

$cdmaterials "models\weapons\mcv\shells\"

$attachment "0" "base" 0 0 2.5 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -1.909 -1.076 -1.076 2 1.076 1.076

$definebone "base" "" 0 0 0 0 0 89.999982 0 0 0 0 0 0


$sequence "idle" {
	"flare_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "flare_physics.smd"
{
	$mass 7
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
//		"value" "d:\mcv\mcv-content\vietnam\models\shells\flare.qc"
//	}
}

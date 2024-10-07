// Created by Crowbar 0.74

$modelname "weapons\shells\rpg2_rocket.mdl"

$bodygroup "Body"
{
	studio "rpg2_rocket_lod0.smd"
}

$lod 6
{
	replacemodel "rpg2_rocket_lod0.smd" "rpg2_rocket_lod0_lod1.smd"
	nofacial
}
$lod 12
{
	replacemodel "rpg2_rocket_lod0.smd" "rpg2_rocket_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 1.234 0

$cdmaterials "models\weapons\mcv\shells\"

$attachment "0" "base" 0 0 -10 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -8.787 -1.844 -1.844 6.543 1.844 1.844

$definebone "base" "" 0 0 0 0 0 89.999989 0 0 0 0 0 0


$sequence "idle" {
	"rpg2_rocket_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "rpg2_rocket_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\shells\rpg2_rocket.qc"
//	}
}

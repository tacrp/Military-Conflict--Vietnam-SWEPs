// Created by Crowbar 0.74

$modelname "weapons\shells\gren_ignited.mdl"

$bodygroup "Body"
{
	studio "gren_ignited_lod0.smd"
}

$lod 5
{
	replacemodel "gren_ignited_lod0.smd" "gren_ignited_lod0_lod1.smd"
	nofacial
}
$lod 9
{
	replacemodel "gren_ignited_lod0.smd" "gren_ignited_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.004 -0.826 0.005

$cdmaterials "models\weapons\mcv\shells\"

$attachment "0" "root" 0 2 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -2.129 -1.327 -1.327 2.656 1.327 1.327

$definebone "root" "" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"gren_ignited_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "gren_ignited_physics.smd"
{
	$mass 7
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\shells\gren_ignited.qc"
//	}
}

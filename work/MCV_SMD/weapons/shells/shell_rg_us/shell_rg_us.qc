// Created by Crowbar 0.74

$modelname "weapons\shells\shell_rg_us.mdl"

$bodygroup "Body"
{
	studio "shell_rg_us_lod0.smd"
}

$lod 6
{
	replacemodel "shell_rg_us_lod0.smd" "shell_rg_us_lod0_lod1.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 -0.941 0

$cdmaterials "models\weapons\mcv\rif_gl\"

$attachment "0" "root" 0 5 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -4.526 -1.365 -1.365 6.408 1.365 1.365

$definebone "root" "" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"shell_rg_us_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "shell_rg_us_physics.smd"
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
//		"value" "d:\mcv\mcv-content\vietnam\models\shells\shell_rg_us.qc"
//	}
}

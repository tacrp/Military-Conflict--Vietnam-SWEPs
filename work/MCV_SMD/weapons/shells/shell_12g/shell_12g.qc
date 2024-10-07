// Created by Crowbar 0.74

$modelname "weapons\shells\shell_12g.mdl"

$bodygroup "Body"
{
	studio "shell_12g_lod0.smd"
}

$lod 3
{
	replacemodel "shell_12g_lod0.smd" "shell_12g_lod0_lod1.smd"
	nofacial
}
$lod 6
{
	replacemodel "shell_12g_lod0.smd" "shell_12g_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.008 0.031 -0.001

$cdmaterials "models\weapons\mcv\shells\"

$cbox 0 0 0 0 0 0

$bbox -1.205 -0.467 -0.483 1.142 0.483 0.481

$definebone "root" "" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"shell_12g_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "models\shells\shell_12g_lod0.qc"
//	}
}

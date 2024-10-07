// Created by Crowbar 0.74

$modelname "weapons\shells\shell_gren.mdl"

$bodygroup "Body"
{
	studio "shell_gren_lod0.smd"
}

$lod 6
{
	replacemodel "shell_gren_lod0.smd" "shell_gren_lod0_lod1.smd"
	nofacial
}
$lod 9
{
	replacemodel "shell_gren_lod0.smd" "shell_gren_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.001 -0.035 0.011

$cdmaterials "models\weapons\mcv\shells\"

$cbox 0 0 0 0 0 0

$bbox -0.868 -0.952 -0.955 0.937 0.953 0.977

$definebone "root" "" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"shell_gren_anims\idle.smd"
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
//		"value" "models\shells\shell_gren.qc"
//	}
}

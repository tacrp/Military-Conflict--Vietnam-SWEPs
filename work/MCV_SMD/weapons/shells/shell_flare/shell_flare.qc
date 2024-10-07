// Created by Crowbar 0.74

$modelname "weapons\shells\shell_flare.mdl"

$bodygroup "Body"
{
	studio "shell_flare_lod0.smd"
}

$lod 5
{
	replacemodel "shell_flare_lod0.smd" "shell_flare_lod0_lod1.smd"
	nofacial
}
$lod 11
{
	replacemodel "shell_flare_lod0.smd" "shell_flare_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.007 -0.011 0

$cdmaterials "models\weapons\mcv\shells\"

$cbox 0 0 0 0 0 0

$bbox -0.326 -0.826 -0.832 0.349 0.812 0.832

$definebone "root" "" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"shell_flare_anims\idle.smd"
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
//		"value" "models\shells\shell_flare_lod0.qc"
//	}
}

// Created by Crowbar 0.74

$modelname "weapons\shells\shell_762x39sov.mdl"

$bodygroup "Body"
{
	studio "shell_762x39sov_lod0.smd"
}

$lod 3
{
	replacemodel "shell_762x39sov_lod0.smd" "shell_762x39sov_lod0_lod1.smd"
	nofacial
}
$lod 6
{
	replacemodel "shell_762x39sov_lod0.smd" "shell_762x39sov_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 0.117 0

$cdmaterials "models\weapons\mcv\shells\"

$cbox 0 0 0 0 0 0

$bbox -0.94 -0.248 -0.248 0.705 0.248 0.248

$definebone "root" "" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"shell_762x39sov_anims\idle.smd"
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
//		"value" "models\shells\shell_762x39sov_lod0.qc"
//	}
}

// Created by Crowbar 0.74

$modelname "weapons\shells\shell_9x19.mdl"

$bodygroup "Body"
{
	studio "shell_9x19_lod0.smd"
}

$lod 3
{
	replacemodel "shell_9x19_lod0.smd" "shell_9x19_lod0_lod1.smd"
	nofacial
}
$lod 6
{
	replacemodel "shell_9x19_lod0.smd" "shell_9x19_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.001 -0.004 -0.001

$cdmaterials "models\weapons\mcv\shells\"

$cbox 0 0 0 0 0 0

$bbox -0.485 -0.274 -0.274 0.493 0.273 0.273

$definebone "root" "" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"shell_9x19_anims\idle.smd"
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
//		"value" "models\shells\shell_9x19_lod0.qc"
//	}
}

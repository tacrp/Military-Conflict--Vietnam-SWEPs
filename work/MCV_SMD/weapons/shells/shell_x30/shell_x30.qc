// Created by Crowbar 0.74

$modelname "weapons\shells\shell_x30.mdl"

$bodygroup "Body"
{
	studio "shell_x30_lod0.smd"
}

$lod 3
{
	replacemodel "shell_x30_lod0.smd" "shell_x30_lod0_lod1.smd"
	nofacial
}
$lod 6
{
	replacemodel "shell_x30_lod0.smd" "shell_x30_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 0.275 0

$cdmaterials "models\weapons\mcv\shells\"

$cbox 0 0 0 0 0 0

$bbox -1.126 -0.219 -0.219 0.577 0.219 0.219

$definebone "root" "" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"shell_x30_anims\idle.smd"
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
//		"value" "models\shells\shell_x30_lod0.qc"
//	}
}

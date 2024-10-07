// Created by Crowbar 0.74

$modelname "weapons\shells\shell_762x25t.mdl"

$bodygroup "Body"
{
	studio "shell_762x25t_lod0.smd"
}

$lod 3
{
	replacemodel "shell_762x25t_lod0.smd" "shell_762x25t_lod0_lod1.smd"
	nofacial
}
$lod 6
{
	replacemodel "shell_762x25t_lod0.smd" "shell_762x25t_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 0.143 0.001

$cdmaterials "models\weapons\mcv\shells\"

$cbox 0 0 0 0 0 0

$bbox -0.718 -0.213 -0.213 0.432 0.213 0.214

$definebone "root" "" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"shell_762x25t_anims\idle.smd"
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
//		"value" "models\shells\shell_762x25t_lod0.qc"
//	}
}

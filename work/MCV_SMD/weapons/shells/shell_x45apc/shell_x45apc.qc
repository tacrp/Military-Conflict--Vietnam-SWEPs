// Created by Crowbar 0.74

$modelname "weapons\shells\shell_x45apc.mdl"

$bodygroup "Body"
{
	studio "shell_x45apc_lod0.smd"
}

$lod 3
{
	replacemodel "shell_x45apc_lod0.smd" "shell_x45apc_lod0_lod1.smd"
	nofacial
}
$lod 6
{
	replacemodel "shell_x45apc_lod0.smd" "shell_x45apc_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.001 0.215 0.001

$cdmaterials "models\weapons\mcv\shells\"

$cbox 0 0 0 0 0 0

$bbox -0.735 -0.29 -0.29 0.304 0.291 0.291

$definebone "root" "" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"shell_x45apc_anims\idle.smd"
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
//		"value" "models\shells\shell_x45apc_lod0.qc"
//	}
}

// Created by Crowbar 0.74

$modelname "weapons\shells\shell_792x57ma.mdl"

$bodygroup "Body"
{
	studio "shell_792x57ma_lod0.smd"
}

$lod 3
{
	replacemodel "shell_792x57ma_lod0.smd" "shell_792x57ma_lod0_lod1.smd"
	nofacial
}
$lod 6
{
	replacemodel "shell_792x57ma_lod0.smd" "shell_792x57ma_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 0.184 0

$cdmaterials "models\weapons\mcv\shells\"

$cbox 0 0 0 0 0 0

$bbox -1.494 -0.289 -0.288 1.127 0.288 0.287

$definebone "root" "" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"shell_792x57ma_anims\idle.smd"
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
//		"value" "models\shells\shell_792x57ma_lod0.qc"
//	}
}

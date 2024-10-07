// Created by Crowbar 0.74

$modelname "weapons\shells\shell_145x114.mdl"

$bodygroup "Body"
{
	studio "shell_145x114_lod0.smd"
}

$lod 3
{
	replacemodel "shell_145x114_lod0.smd" "shell_145x114_lod0_lod1.smd"
	nofacial
}
$lod 6
{
	replacemodel "shell_145x114_lod0.smd" "shell_145x114_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 0 0.541

$cdmaterials "models\weapons\mcv\shells\"

$cbox 0 0 0 0 0 0

$bbox -2.608 -0.538 0 2.608 0.538 1.082

$definebone "Bone001" "" 0 0 0 0 -89.999982 0 0 0 0 0 0 0


$sequence "idle" {
	"shell_145x114_anims\idle.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\shells\shell_145x114_lod0.qc"
//	}
}

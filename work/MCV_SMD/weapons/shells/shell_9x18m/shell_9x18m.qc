// Created by Crowbar 0.74

$modelname "weapons\shells\shell_9x18m.mdl"

$bodygroup "Body"
{
	studio "shell_9x18m_lod0.smd"
}

$lod 3
{
	replacemodel "shell_9x18m_lod0.smd" "shell_9x18m_lod0_lod1.smd"
	nofacial
}
$lod 6
{
	replacemodel "shell_9x18m_lod0.smd" "shell_9x18m_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 0.153 0

$cdmaterials "models\weapons\mcv\shells\"

$cbox 0 0 0 0 0 0

$bbox -0.538 -0.218 -0.218 0.232 0.218 0.219

$definebone "root" "" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"shell_9x18m_anims\idle.smd"
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
//		"value" "models\shells\shell_9x18m.qc"
//	}
}

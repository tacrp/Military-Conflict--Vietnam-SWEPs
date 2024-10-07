// Created by Crowbar 0.74

$modelname "weapons\shells\shell_556x45n.mdl"

$bodygroup "Body"
{
	studio "shell_556x45n_lod0.smd"
}

$lod 3
{
	replacemodel "shell_556x45n_lod0.smd" "shell_556x45n_lod0_lod1.smd"
	nofacial
}
$lod 6
{
	replacemodel "shell_556x45n_lod0.smd" "shell_556x45n_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 0.053 0

$cdmaterials "models\weapons\mcv\shells\"

$cbox 0 0 0 0 0 0

$bbox -1.056 -0.208 -0.208 0.95 0.208 0.208

$definebone "root" "" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"shell_556x45n_anims\idle.smd"
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
//		"value" "models\shells\shell_556x45n_lod0.qc"
//	}
}

// Created by Crowbar 0.74

$modelname "weapons\shells\shell_rg_vc.mdl"

$bodygroup "Body"
{
	studio "shell_rg_vc_lod0.smd"
}

$lod 6
{
	replacemodel "shell_rg_vc_lod0.smd" "shell_rg_vc_lod0_lod1.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 0 0

$cdmaterials "models\weapons\mcv\rif_gl\"

$attachment "0" "root" 0 7 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -6.768 -1.449 -1.523 6.768 1.449 1.523

$definebone "root" "" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"shell_rg_vc_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "shell_rg_vc_physics.smd"
{
	$mass 7
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\mcv\mcv-content\vietnam\models\shells\shell_rg_vc.qc"
//	}
}

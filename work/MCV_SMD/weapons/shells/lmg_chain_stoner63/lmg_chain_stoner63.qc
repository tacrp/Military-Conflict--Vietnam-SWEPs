// Created by Crowbar 0.74

$modelname "weapons\shells\lmg_chain_stoner63.mdl"

$bodygroup "Body"
{
	studio "lmg_chain_stoner63_lod0.smd"
}

$lod 5
{
	replacemodel "lmg_chain_stoner63_lod0.smd" "lmg_chain_stoner63_lod0_lod1.smd"
	nofacial
}
$lod 9
{
	replacemodel "lmg_chain_stoner63_lod0.smd" "lmg_chain_stoner63_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.013 0 0.231

$cdmaterials "models\weapons\mcv\shells\"
$cdmaterials "models\weapons\mcv\v_stoner63\"

$cbox 0 0 0 0 0 0

$bbox -0.733 -0.54 -0.249 0.731 0.585 0.714

$definebone "lmg_chain_stoner63_lod0" "" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"lmg_chain_stoner63_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "lmg_chain_stoner63_physics.smd"
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
//		"value" "models\shells\lmg_chain_stoner63.qc"
//	}
}

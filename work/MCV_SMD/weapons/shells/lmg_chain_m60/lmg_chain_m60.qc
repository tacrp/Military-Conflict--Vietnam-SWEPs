// Created by Crowbar 0.74

$modelname "weapons\shells\lmg_chain_m60.mdl"

$bodygroup "Body"
{
	studio "lmg_chain_m60_lod0.smd"
}

$lod 5
{
	replacemodel "lmg_chain_m60_lod0.smd" "lmg_chain_m60_lod0_lod1.smd"
	nofacial
}
$lod 9
{
	replacemodel "lmg_chain_m60_lod0.smd" "lmg_chain_m60_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.119 0.226 0.209

$cdmaterials "models\weapons\mcv\shells\"
$cdmaterials "models\weapons\mcv\v_m60\"

$cbox 0 0 0 0 0 0

$bbox -1.322 -0.774 -0.249 1.088 0.699 0.524

$definebone "lmg_chain_m60_lod0" "" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"lmg_chain_m60_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "lmg_chain_m60_physics.smd"
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
//		"value" "models\shells\lmg_chain_m60.qc"
//	}
}

// Created by Crowbar 0.74

$modelname "weapons\shells\lmg_chain_rpd.mdl"

$bodygroup "Body"
{
	studio "lmg_chain_rpd_lod0.smd"
}

$lod 5
{
	replacemodel "lmg_chain_rpd_lod0.smd" "lmg_chain_rpd_lod0_lod1.smd"
	nofacial
}
$lod 9
{
	replacemodel "lmg_chain_rpd_lod0.smd" "lmg_chain_rpd_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.069 0 0.18

$cdmaterials "models\weapons\mcv\shells\"
$cdmaterials "models\weapons\mcv\v_rpd\"

$cbox 0 0 0 0 0 0

$bbox -1.255 -0.519 -0.003 1.16 0.547 0.597

$definebone "lmg_chain_rpd_lod0" "" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"lmg_chain_rpd_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "lmg_chain_rpd_physics.smd"
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
//		"value" "models\shells\lmg_chain_rpd.qc"
//	}
}

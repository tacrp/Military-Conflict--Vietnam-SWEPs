// Created by Crowbar 0.74

$modelname "weapons\mcv\w_kar98_s.mdl"

$bodygroup "Body"
{
	studio "w_kar98s_lod0.smd"
}
$bodygroup "bayonet"
{
	blank
	studio "w_kar98s_w_akb_lod0.smd"
	studio "w_kar98s_w_type30_lod0.smd"
}
$bodygroup "scope"
{
	studio "w_kar98s_scope_lod0.smd"
	blank
}
$bodygroup "mount"
{
	blank
	studio "w_kar98s_vcm_lod1.smd"
}
$bodygroup "grenade"
{
	blank
	studio "w_kar98s_vcg_lod0.smd"
}

$lod 15
{
	replacemodel "w_kar98s_lod0.smd" "w_kar98s_lod0_lod1.smd"
	replacemodel "w_kar98s_w_akb_lod0.smd" "w_kar98s_w_akb_lod0_lod1.smd"
	replacemodel "w_kar98s_w_type30_lod0.smd" "w_kar98s_w_type30_lod0_lod1.smd"
	replacemodel "w_kar98s_scope_lod0.smd" "w_kar98s_scope_lod0_lod1.smd"
	replacemodel "w_kar98s_vcm_lod1.smd" "w_kar98s_vcm_lod1_lod1.smd"
	replacemodel "w_kar98s_vcg_lod0.smd" "w_kar98s_vcg_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_kar98s_lod0.smd" "w_kar98s_lod0_lod2.smd"
	replacemodel "w_kar98s_w_akb_lod0.smd" "w_kar98s_w_akb_lod0_lod2.smd"
	replacemodel "w_kar98s_w_type30_lod0.smd" "w_kar98s_w_type30_lod0_lod2.smd"
	replacemodel "w_kar98s_scope_lod0.smd" "w_kar98s_scope_lod0_lod2.smd"
	replacemodel "w_kar98s_vcm_lod1.smd" "w_kar98s_vcm_lod1_lod2.smd"
	replacemodel "w_kar98s_vcg_lod0.smd" "w_kar98s_vcg_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.336 -10.522 -0.716

$cdmaterials "models\weapons\mcv\w_ak47_bayonet\"
$cdmaterials "models\weapons\mcv\w_type30_bayonet\"
$cdmaterials "models\weapons\mcv\w_kar98_s\"
$cdmaterials "models\weapons\mcv\rif_gl\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 1.3 25.6 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.75 1.7 -0.7 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone" -0.75 1.7 -0.7 rotate 0 180 90

$cbox 0 0 0 0 0 0

$bbox -18.838 -2.129 -5.475 39.682 1.457 3.699

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000009 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone3" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone4" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_kar98_s_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_kar98_s_physics.smd"
{
	$mass 8
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 3

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "models\player\animation_iiopn\w_model\kar98\w_kar98s.qc"
//	}
}

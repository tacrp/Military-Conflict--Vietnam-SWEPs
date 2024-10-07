// Created by Crowbar 0.74

$modelname "weapons\mcv\w_type63.mdl"

$bodygroup "Body"
{
	studio "w_type63_lod0.smd"
}
$bodygroup "bayonet"
{
	blank
	studio "w_sks_w_akb_lod0.smd"
}
$bodygroup "mount"
{
	blank
	studio "w_sks_vcm_lod0.smd"
}
$bodygroup "grenade"
{
	blank
	studio "w_sks_vcg_lod0.smd"
}

$lod 8
{
	replacemodel "w_type63_lod0.smd" "w_type63_lod0_lod1.smd"
	replacemodel "w_sks_w_akb_lod0.smd" "w_sks_w_akb_lod0_lod1.smd"
	replacemodel "w_sks_vcm_lod0.smd" "w_sks_vcm_lod0_lod1.smd"
	replacemodel "w_sks_vcg_lod0.smd" "w_sks_vcg_lod0_lod1.smd"
	nofacial
}
$lod 14
{
	replacemodel "w_type63_lod0.smd" "w_type63_lod0_lod2.smd"
	replacemodel "w_sks_w_akb_lod0.smd" "w_sks_w_akb_lod0_lod2.smd"
	replacemodel "w_sks_vcm_lod0.smd" "w_sks_vcm_lod0_lod2.smd"
	replacemodel "w_sks_vcg_lod0.smd" "w_sks_vcg_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.207 -6.474 -1.321

$cdmaterials "models\weapons\mcv\w_ak47_bayonet\"
$cdmaterials "models\weapons\mcv\w_type63\"
$cdmaterials "models\weapons\mcv\rif_gl\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 1.3 21 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" 0 1.8 2 rotate 0 90 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 0 0.5 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -19.68 -1.861 -5.787 32.287 1.447 3.268

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999982 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone3" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone4" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_type63_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_type63_physics.smd"
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
//		"value" "e:\animations\vietnamcontent\vietnam\models\player\animation_iiopn\w_model\sks\w_type63_smd.qc"
//	}
}

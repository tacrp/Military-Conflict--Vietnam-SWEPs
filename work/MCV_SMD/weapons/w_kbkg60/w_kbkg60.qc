// Created by Crowbar 0.74

$modelname "weapons\mcv\w_kbkg60.mdl"

$bodygroup "Body"
{
	studio "w_kbkg60_lod0.smd"
}
$bodygroup "bayonet"
{
	blank
	studio "w_ak_akb_lod0.smd"
}
$bodygroup "mount"
{
	blank
	studio "w_ak_vcm_lod0.smd"
}
$bodygroup "grenade"
{
	blank
	studio "w_ak_vcg_lod0.smd"
}
$bodygroup "magazine"
{
	studio "w_ak_kbkg60_mag_30.smd"
	studio "w_ak_kbkg60_mag_20.smd"
	studio "w_ak_kbkg60_mag_10.smd"
}

$lod 15
{
	replacemodel "w_kbkg60_lod0.smd" "w_kbkg60_lod0_lod1.smd"
	replacemodel "w_ak_akb_lod0.smd" "w_ak_akb_lod0_lod1.smd"
	replacemodel "w_ak_vcm_lod0.smd" "w_ak_vcm_lod0_lod1.smd"
	replacemodel "w_ak_vcg_lod0.smd" "w_ak_vcg_lod0_lod1.smd"
	replacemodel "w_ak_kbkg60_mag_30.smd" "w_ak_kbkg60_mag_30_lod1.smd"
	replacemodel "w_ak_kbkg60_mag_20.smd" "w_ak_kbkg60_mag_20_lod1.smd"
	replacemodel "w_ak_kbkg60_mag_10.smd" "w_ak_kbkg60_mag_10_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_kbkg60_lod0.smd" "w_kbkg60_lod0_lod2.smd"
	replacemodel "w_ak_akb_lod0.smd" "w_ak_akb_lod0_lod2.smd"
	replacemodel "w_ak_vcm_lod0.smd" "w_ak_vcm_lod0_lod2.smd"
	replacemodel "w_ak_vcg_lod0.smd" "w_ak_vcg_lod0_lod2.smd"
	replacemodel "w_ak_kbkg60_mag_30.smd" "w_ak_kbkg60_mag_30_lod2.smd"
	replacemodel "w_ak_kbkg60_mag_20.smd" "w_ak_kbkg60_mag_20_lod2.smd"
	replacemodel "w_ak_kbkg60_mag_10.smd" "w_ak_kbkg60_mag_10_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.214 -9.395 -2.513

$cdmaterials "models\weapons\mcv\w_ak47_bayonet\"
$cdmaterials "models\weapons\mcv\w_kbkg60\"
$cdmaterials "models\weapons\mcv\rif_gl\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 0.5 20.9 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -1 1 3.3 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 -0.5 3 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -13.668 -1.864 -8.002 32.175 1.437 2.887

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.00005 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone4" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_kbkg60_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_kbkg60_physics.smd"
{
	$mass 8
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 9

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\ak\w_kbkg60.qc"
//	}
}

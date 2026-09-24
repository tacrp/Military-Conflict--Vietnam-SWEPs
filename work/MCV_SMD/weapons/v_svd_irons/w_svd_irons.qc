// Editable local compile source. Run compile.py or compile this QC in Crowbar.
// Created by Crowbar 0.74

$modelname "weapons\mcv\w_svd_irons.mdl"

$bodygroup "Body"
{
	studio "w_svd_irons_mesh0.smd"
}
$bodygroup "bayonet"
{
	blank
	studio "assets/w_svd_akb_lod0.smd"
}

$lod 15
{
	replacemodel "w_svd_irons_mesh0.smd" "w_svd_irons_mesh1.smd"
	replacemodel "assets/w_svd_akb_lod0.smd" "assets/w_svd_akb_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_svd_irons_mesh0.smd" "w_svd_irons_mesh2.smd"
	replacemodel "assets/w_svd_akb_lod0.smd" "assets/w_svd_akb_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 0 0

$cdmaterials "models\weapons\mcv\w_ak47_bayonet\"
$cdmaterials "models\weapons\mcv\w_svd\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 0.5 35 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -1 1 6 rotate 0 -180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 -1 5 rotate -90 -90 0
$attachment "glint" "ValveBiped.weapon_bone" 0 2.8 9.5 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -12.888 -1.621 -5.181 41.345 1.901 4.401

$definebone "ValveBiped.Bip01_R_Hand" "" -7.014842 -1.029472 -1.718515 12.956000 0.692000 -179.701000 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone" "ValveBiped.Bip01_R_Hand" 0 0 -0.064417 0 0 90.000016 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone4" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"assets/idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "assets/w_svd_physics.smd"
{
	$mass 8
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 4

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\svd\w_svd.qc"
//	}
}

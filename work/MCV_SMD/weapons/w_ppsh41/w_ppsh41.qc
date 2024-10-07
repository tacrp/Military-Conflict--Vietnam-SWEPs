// Created by Crowbar 0.74

$modelname "weapons\mcv\w_ppsh41.mdl"

$bodygroup "Body"
{
	studio "w_ppsh41_lod0.smd"
}
$bodygroup "mag"
{
	studio "w_ppsh41_mag1.smd"
}

$lod 15
{
	replacemodel "w_ppsh41_lod0.smd" "w_ppsh41_lod0_lod1.smd"
	replacemodel "w_ppsh41_mag1.smd" "w_ppsh41_mag1_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_ppsh41_lod0.smd" "w_ppsh41_lod0_lod2.smd"
	replacemodel "w_ppsh41_mag1.smd" "w_ppsh41_mag1_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.274 2.15 -2.42

$cdmaterials "models\weapons\mcv\w_ppsh41\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 1.5 14.5 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" 0 2.3 1.5 rotate 0 90 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 0 1.5 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -19.011 -1.506 -8.188 14.601 1.141 2.939

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.00005 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_ppsh41_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_ppsh41_physics.smd"
{
	$mass 8
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 6

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\ppsh41\w_ppsh41.qc"
//	}
}

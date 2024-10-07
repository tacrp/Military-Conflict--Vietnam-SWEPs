// Created by Crowbar 0.74

$modelname "weapons\mcv\w_ak47.mdl"

$bodygroup "Body"
{
	studio "w_ak47_lod0.smd"
}
$bodygroup "bayonet"
{
	blank
	studio "w_ak_akb_lod0.smd"
}

$lod 15
{
	replacemodel "w_ak47_lod0.smd" "w_ak47_lod0_lod1.smd"
	replacemodel "w_ak_akb_lod0.smd" "w_ak_akb_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_ak47_lod0.smd" "w_ak47_lod0_lod2.smd"
	replacemodel "w_ak_akb_lod0.smd" "w_ak_akb_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.407 -6.741 -2.526

$cdmaterials "models\weapons\mcv\w_ak47_bayonet\"
$cdmaterials "models\weapons\mcv\w_ak47\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 0.5 20.9 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -1 1 3.3 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 -0.5 3 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -13.668 -1.864 -8.002 26.867 1.05 2.887

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000009 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone4" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_ak47_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_ak47_physics.smd"
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
//		"value" "e:\animations\vietnamcontent\vietnam\models\player\animation_iiopn\w_model\ak\w_ak47.qc"
//	}
}

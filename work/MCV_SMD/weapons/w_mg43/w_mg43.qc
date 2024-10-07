// Created by Crowbar 0.74

$modelname "weapons\mcv\w_mg43.mdl"

$bodygroup "Body"
{
	studio "w_mg43_lod0.smd"
}
$bodygroup "bipod"
{
	studio "w_mg43_bipod1_lod0.smd"
	studio "w_mg43_bipod2_lod0.smd"
}

$lod 15
{
	replacemodel "w_mg43_lod0.smd" "w_mg43_lod0_lod1.smd"
	replacemodel "w_mg43_bipod1_lod0.smd" "w_mg43_bipod1_lod0_lod1.smd"
	replacemodel "w_mg43_bipod2_lod0.smd" "w_mg43_bipod2_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_mg43_lod0.smd" "w_mg43_lod0_lod2.smd"
	replacemodel "w_mg43_bipod1_lod0.smd" "w_mg43_bipod1_lod0_lod2.smd"
	replacemodel "w_mg43_bipod2_lod0.smd" "w_mg43_bipod2_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.004 -6.513 -3.483

$cdmaterials "models\weapons\mcv\w_mg43\"
$cdmaterials "models\player\equipment\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 1 28.7 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -1.4 1.7 1.6 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 3 0.2 1.5 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -15.948 -7.105 -11.578 29.081 7.112 4.612

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000043 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone4" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone3" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_mg43_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_mg43_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\mg43\w_mg43.qc"
//	}
}

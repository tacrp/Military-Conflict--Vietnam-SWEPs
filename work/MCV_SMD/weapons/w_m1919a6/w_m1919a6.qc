// Created by Crowbar 0.74

$modelname "weapons\mcv\w_m1919a6.mdl"

$bodygroup "Body"
{
	studio "w_m1919a6_lod0.smd"
}
$bodygroup "bipod"
{
	studio "w_m1919a6_bipod1.smd"
	studio "w_m1919a6_bipod2.smd"
}

$lod 15
{
	replacemodel "w_m1919a6_lod0.smd" "w_m1919a6_lod0_lod1.smd"
	replacemodel "w_m1919a6_bipod1.smd" "w_m1919a6_bipod1_lod1.smd"
	replacemodel "w_m1919a6_bipod2.smd" "w_m1919a6_bipod2_lod1.smd"
	replacebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone"
	nofacial
}
$lod 30
{
	replacemodel "w_m1919a6_lod0.smd" "w_m1919a6_lod0_lod2.smd"
	replacemodel "w_m1919a6_bipod1.smd" "w_m1919a6_bipod1_lod2.smd"
	replacemodel "w_m1919a6_bipod2.smd" "w_m1919a6_bipod2_lod2.smd"
	replacebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.006 -6.295 -1.994

$cdmaterials "models\weapons\mcv\w_m1919a6\"
$cdmaterials "models\player\equipment\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 1 31.8 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.8 1.8 5.8 rotate 0 -180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 2 0 -1.4 rotate -90 90 0

$cbox 0 0 0 0 0 0

$bbox -19.399 -6.176 -7.87 31.978 6.189 4.245

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000043 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone4" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone3" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_m1919a6_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_m1919a6_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\m1919a6\w_m1919a6.qc"
//	}
}

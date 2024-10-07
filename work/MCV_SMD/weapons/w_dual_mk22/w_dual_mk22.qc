// Created by Crowbar 0.74

$modelname "weapons\mcv\w_dual_mk22.mdl"

$bodygroup "studio"
{
	studio "w_mk22_dual_lod0.smd"
}
$bodygroup "mk22_variants"
{
	studio "w_mk22_bg_basic_dual_lod0.smd"
	studio "w_mk22_bg_mod0_dual_lod0.smd"
}

$lod 15
{
	replacemodel "w_mk22_dual_lod0.smd" "w_mk22_dual_lod0_lod1.smd"
	replacemodel "w_mk22_bg_basic_dual_lod0.smd" "w_mk22_bg_basic_dual_lod0_lod1.smd"
	replacemodel "w_mk22_bg_mod0_dual_lod0.smd" "w_mk22_bg_mod0_dual_lod0_lod1.smd"
	nofacial
}
$lod 25
{
	replacemodel "w_mk22_dual_lod0.smd" "w_mk22_dual_lod0_lod2.smd"
	replacemodel "w_mk22_bg_basic_dual_lod0.smd" "w_mk22_bg_basic_dual_lod0_lod2.smd"
	replacemodel "w_mk22_bg_mod0_dual_lod0.smd" "w_mk22_bg_mod0_dual_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.02 -4.68 0.262

$cdmaterials "models\weapons\mcv\w_mk22\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 2.15 5.9 rotate -90 -90 0
$attachment "muzzle_equipment" "ValveBiped.weapon_bone" 0 2.15 11.2 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.5 2.4 2 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 0 0 rotate -90 -90 0
$attachment "muzzle2" "ValveBiped.weapon_bone_left" 0 2.15 5.9 rotate -90 -90 0
$attachment "muzzle_equipment2" "ValveBiped.weapon_bone_left" 0 2.15 11.2 rotate -90 -90 0
$attachment "shell_eject2" "ValveBiped.weapon_bone_left" -0.5 2.4 2 rotate 0 180 90
$attachment "mag_eject2" "ValveBiped.weapon_bone_left" 0 0 0 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -2.063 -0.768 -2.835 11.094 0.727 3.11

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000009 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone_left" "" 0 0 -0.064417 0 0 90.000009 0 0 0 0 0 0


$sequence "idle" {
	"w_dual_mk22_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_dual_mk22_physics.smd"
{
	$mass 4
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\dualweapon\w_dual_mk22.qc"
//	}
}

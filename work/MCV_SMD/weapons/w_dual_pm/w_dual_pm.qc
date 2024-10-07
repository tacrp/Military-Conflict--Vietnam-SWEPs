// Created by Crowbar 0.74

$modelname "weapons\mcv\w_dual_pm.mdl"

$bodygroup "Body"
{
	studio "w_pm_dual_lod0.smd"
}

$lod 15
{
	replacemodel "w_pm_dual_lod0.smd" "w_pm_dual_lod0_lod1.smd"
	replacebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone"
	nofacial
}
$lod 25
{
	replacemodel "w_pm_dual_lod0.smd" "w_pm_dual_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.05 -1.557 0.209

$cdmaterials "models\weapons\mcv\w_pm\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 2.3 4.8 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.65 2.6 1.5 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 0 0 rotate -90 -90 0
$attachment "muzzle2" "ValveBiped.weapon_bone_left" 0 2.3 4.8 rotate -90 -90 0
$attachment "shell_eject2" "ValveBiped.weapon_bone_left" -0.65 2.6 1.5 rotate 0 180 90
$attachment "mag_eject2" "ValveBiped.weapon_bone_left" 0 0 0 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -1.927 -0.716 -2.568 4.995 0.716 2.873

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000009 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone_left" "" 0 0 -0.064417 0 0 90.000009 0 0 0 0 0 0


$sequence "idle" {
	"w_dual_pm_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_dual_pm_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\dualweapon\w_dual_pm.qc"
//	}
}

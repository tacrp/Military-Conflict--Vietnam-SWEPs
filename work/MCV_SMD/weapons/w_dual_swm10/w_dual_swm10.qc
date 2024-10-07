// Created by Crowbar 0.74

$modelname "weapons\mcv\w_dual_swm10.mdl"

$bodygroup "Body"
{
	studio "w_swm10_dual_lod0.smd"
}

$lod 15
{
	replacemodel "w_swm10_dual_lod0.smd" "w_swm10_dual_lod0_lod1.smd"
	nofacial
}
$lod 25
{
	replacemodel "w_swm10_dual_lod0.smd" "w_swm10_dual_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.71 -3.048 0.882

$cdmaterials "models\weapons\mcv\w_swm10\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 3 8.5 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" 0 2.6 2.5 rotate 0 180 90
$attachment "mag_eject2" "ValveBiped.weapon_bone" 0 2.6 2.5 rotate 0 180 90
$attachment "muzzle2" "ValveBiped.weapon_bone_left" 0 3 8.5 rotate -90 -90 0
$attachment "shell_eject2" "ValveBiped.weapon_bone_left" 0 2.6 2.5 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone_left" 0 2.6 2.5 rotate 0 180 90

$cbox 0 0 0 0 0 0

$bbox -2.684 -0.776 -2.211 8.763 2.196 3.75

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999962 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone_left" "" 1.424839 0 -0.064417 0 0 89.999962 0 0 0 0 0 0


$sequence "idle" {
	"w_dual_swm10_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_dual_swm10_physics.smd"
{
	$mass 4
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 5

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\dualweapon\w_dual_swm10.qc"
//	}
}

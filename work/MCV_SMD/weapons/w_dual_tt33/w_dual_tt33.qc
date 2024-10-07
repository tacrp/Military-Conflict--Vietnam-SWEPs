// Created by Crowbar 0.74

$modelname "weapons\mcv\w_dual_tt33.mdl"

$bodygroup "Body"
{
	studio "w_tt33_dual_lod0.smd"
}

$lod 15
{
	replacemodel "w_tt33_dual_lod0.smd" "w_tt33_dual_lod0_lod1.smd"
	nofacial
}
$lod 25
{
	replacemodel "w_tt33_dual_lod0.smd" "w_tt33_dual_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.061 -2.271 0.176

$cdmaterials "models\weapons\mcv\w_tt33\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 2.3 6.2 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.3 2.6 2.5 rotate 0 -180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 0 0 rotate -90 -90 0
$attachment "muzzle2" "ValveBiped.weapon_bone_left" 0 2.3 6.2 rotate -90 -90 0
$attachment "shell_eject2" "ValveBiped.weapon_bone_left" -0.3 2.6 2.5 rotate 0 -180 90
$attachment "mag_eject2" "ValveBiped.weapon_bone_left" 0 0 0 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -1.827 -0.601 -2.503 6.366 0.601 2.88

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000009 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone_left" "" 0 0 -0.064417 0 0 90.000009 0 0 0 0 0 0


$sequence "idle" {
	"w_dual_tt33_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_dual_tt33_physics.smd"
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
//		"value" "e:\animations\vietnamcontent\vietnam\models\player\animation_iiopn\w_model\dualweapon\w_dual_tt33.qc"
//	}
}

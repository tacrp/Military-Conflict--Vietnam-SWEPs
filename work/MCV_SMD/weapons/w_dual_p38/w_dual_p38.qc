// Created by Crowbar 0.74

$modelname "weapons\mcv\w_dual_p38.mdl"

$bodygroup "Body"
{
	studio "w_p38_dual_lod0.smd"
}

$lod 15
{
	replacemodel "w_p38_dual_lod0.smd" "w_p38_dual_lod0_lod1.smd"
	nofacial
}
$lod 25
{
	replacemodel "w_p38_dual_lod0.smd" "w_p38_dual_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.012 -2.044 0.249

$cdmaterials "models\weapons\mcv\w_p38\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 2.3 6.3 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.65 2.6 1.5 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 0 0 rotate -90 -90 0
$attachment "muzzle2" "ValveBiped.weapon_bone_left" 0 2.3 6.3 rotate -90 -90 0
$attachment "shell_eject2" "ValveBiped.weapon_bone_left" -0.65 2.6 1.5 rotate 0 180 90
$attachment "mag_ejec2t" "ValveBiped.weapon_bone_left" 0 0 0 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -2.38 -0.75 -2.454 6.703 0.75 2.925

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000009 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone_left" "" 0 0 -0.064417 0 0 90.000009 0 0 0 0 0 0


$sequence "idle" {
	"w_dual_p38_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_dual_p38_physics.smd"
{
	$mass 4
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 1

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\player\animation_iiopn\w_model\dualweapon\w_dual_p38.qc"
//	}
}

// Created by Crowbar 0.74

$modelname "weapons\mcv\w_dual_mac10.mdl"

$bodygroup "Body"
{
	studio "w_mac10_dual_lod0.smd"
}

$lod 15
{
	replacemodel "w_mac10_dual_lod0.smd" "w_mac10_dual_lod0_lod1.smd"
	replacebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone"
	nofacial
}
$lod 30
{
	replacemodel "w_mac10_dual_lod0.smd" "w_mac10_dual_lod0_lod2.smd"
	replacebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.001 -0.477 -1.113

$cdmaterials "models\weapons\mcv\w_mac10\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 2.4 6.7 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.75 2.7 0.5 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 0 0 rotate -90 -90 0
$attachment "muzzle2" "ValveBiped.weapon_bone_left" 0 2.4 6.7 rotate -90 -90 0
$attachment "shell_eject2" "ValveBiped.weapon_bone_left" -0.75 2.7 0.5 rotate 0 180 90
$attachment "mag_ejec2t" "ValveBiped.weapon_bone_left" 0 0 0 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -4.993 -0.869 -6.33 6.041 0.869 4.103

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000009 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone_left" "" 0 0 -0.064417 0 0 90.000009 0 0 0 0 0 0


$sequence "idle" {
	"w_dual_mac10_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_dual_mac10_physics.smd"
{
	$mass 8
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 8

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\player\animation_iiopn\w_model\dualweapon\w_dual_mac10.qc"
//	}
}

// Created by Crowbar 0.74

$modelname "weapons\mcv\w_dual_uzi.mdl"

$bodygroup "Body"
{
	studio "w_uzi_dual_lod0.smd"
}

$lod 15
{
	replacemodel "w_uzi_dual_lod0.smd" "w_uzi_dual_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_uzi_dual_lod0.smd" "w_uzi_dual_lod0_lod2.smd"
	replacebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 -2.027 -0.549

$cdmaterials "models\weapons\mcv\w_uzi\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 2.4 6.7 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.75 2.7 0.5 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 0 0 rotate -90 -90 0
$attachment "muzzle2" "ValveBiped.weapon_bone_left" 0 2.4 6.7 rotate -90 -90 0
$attachment "shell_eject2" "ValveBiped.weapon_bone_left" -0.75 2.7 0.5 rotate 0 180 90
$attachment "mag_ejec2t" "ValveBiped.weapon_bone_left" 0 0 0 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -7.239 -0.89 -5.894 12.215 0.89 4.87

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000016 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone_left" "" 0 0 -0.064417 0 0 90.000016 0 0 0 0 0 0


$sequence "idle" {
	"w_dual_uzi_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_dual_uzi_physics.smd"
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
//		"value" "e:\animations\vietnamcontent\vietnam\models\player\animation_iiopn\w_model\dualweapon\w_dual_uzi.qc"
//	}
}

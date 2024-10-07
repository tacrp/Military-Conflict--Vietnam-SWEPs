// Created by Crowbar 0.74

$modelname "weapons\mcv\w_dual_mac10_sog.mdl"

$bodygroup "Body"
{
	studio "w_mac10_dual_sog_lod0.smd"
}

$lod 15
{
	replacemodel "w_mac10_dual_sog_lod0.smd" "w_mac10_dual_sog_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_mac10_dual_sog_lod0.smd" "w_mac10_dual_sog_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.037 -4.184 -1.113

$cdmaterials "models\weapons\mcv\w_mac10\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 2.4 13.1 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.75 2.7 0.5 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 0 0 rotate -90 -90 0
$attachment "muzzle2" "ValveBiped.weapon_bone_left" 0 2.4 13.1 rotate -90 -90 0
$attachment "shell_eject2" "ValveBiped.weapon_bone_left" -0.75 2.7 0.5 rotate 0 180 90
$attachment "mag_ejec2t" "ValveBiped.weapon_bone_left" 0 0 0 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -4.913 -1.357 -6.17 13.292 1.381 4.263

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999968 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone_left" "" 0 0 -0.064417 0 0 89.999968 0 0 0 0 0 0


$sequence "idle" {
	"w_dual_mac10_sog_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_dual_mac10_sog_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\dualweapon\w_dual_mac10_sog.qc"
//	}
}

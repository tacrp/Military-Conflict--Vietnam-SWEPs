// Created by Crowbar 0.74

$modelname "weapons\mcv\w_dual_vz61_silencer.mdl"

$bodygroup "Body"
{
	studio "w_vz61_dual_silent_lod0.smd"
}

$lod 15
{
	replacemodel "w_vz61_dual_silent_lod0.smd" "w_vz61_dual_silent_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_vz61_dual_silent_lod0.smd" "w_vz61_dual_silent_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.044 -3.049 0.612

$cdmaterials "models\weapons\mcv\w_vz61\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 2.6 17.1 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" 0 2.3 -1 rotate 0 90 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 0 0 rotate -90 -90 0
$attachment "muzzle2" "ValveBiped.weapon_bone_left" 0 2.6 17.1 rotate -90 -90 0
$attachment "shell_eject2" "ValveBiped.weapon_bone_left" 0 2.3 -1 rotate 0 90 90
$attachment "mag_eject2" "ValveBiped.weapon_bone_left" 0 0 0 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -11.286 -0.863 -3.239 17.373 0.835 4.313

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999968 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone_left" "" 0 0 -0.064417 0 0 89.999968 0 0 0 0 0 0


$sequence "idle" {
	"w_dual_vz61_silencer_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_dual_vz61_silencer_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\dualweapon\w_dual_vz61_silent.qc"
//	}
}

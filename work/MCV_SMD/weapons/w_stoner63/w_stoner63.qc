// Created by Crowbar 0.74

$modelname "weapons\mcv\w_stoner63.mdl"

$bodygroup "Body"
{
	studio "w_stoner63_lod0.smd"
}

$lod 15
{
	replacemodel "w_stoner63_lod0.smd" "w_stoner63_lod0_lod1.smd"
	replacebone "ValveBiped.weapon_bone4" "ValveBiped.weapon_bone"
	nofacial
}
$lod 30
{
	replacemodel "w_stoner63_lod0.smd" "w_stoner63_lod0_lod2.smd"
	replacebone "ValveBiped.weapon_bone4" "ValveBiped.weapon_bone"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.166 -5.74 -2.995

$cdmaterials "models\weapons\mcv\w_stoner63\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 0.5 25.7 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.5 1.2 2.5 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 -2 3.5 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -15.299 -3.539 -9.057 26.536 3.51 2.776

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999962 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone3" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone4" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_stoner63_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_stoner63_physics.smd"
{
	$mass 8
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 7

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\stoner63\w_stoner63.qc"
//	}
}

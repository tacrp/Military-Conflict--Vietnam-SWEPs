// Created by Crowbar 0.74

$modelname "weapons\mcv\w_l2a1.mdl"

$bodygroup "Body"
{
	studio "w_l2a1_lod0.smd"
}
$bodygroup "bipod"
{
	studio "w_l2a1_bp0_lod0.smd"
	studio "w_l2a1_bp1_lod0.smd"
}

$lod 15
{
	replacemodel "w_l2a1_lod0.smd" "w_l2a1_lod0_lod1.smd"
	replacemodel "w_l2a1_bp0_lod0.smd" "w_l2a1_bp0_lod0_lod1.smd"
	replacemodel "w_l2a1_bp1_lod0.smd" "w_l2a1_bp1_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_l2a1_lod0.smd" "w_l2a1_lod0_lod2.smd"
	replacemodel "w_l2a1_bp0_lod0.smd" "w_l2a1_bp0_lod0_lod2.smd"
	replacemodel "w_l2a1_bp1_lod0.smd" "w_l2a1_bp1_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.002 -9.586 -4.95

$cdmaterials "models\weapons\mcv\w_fal\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 0.5 36.1 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -1 1 3.3 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 3 2 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -17.032 -6.165 -12.931 36.579 6.169 3.015

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999989 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_l2a1_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_l2a1_physics.smd"
{
	$mass 8
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 6

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\fal\w_l2a1.qc"
//	}
}

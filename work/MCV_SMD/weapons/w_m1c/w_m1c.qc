// Created by Crowbar 0.74

$modelname "weapons\mcv\w_m1c.mdl"

$bodygroup "Body"
{
	studio "w_m1c_lod0.smd"
}
$bodygroup "bayonet"
{
	blank
	studio "w_m1c_w_m7b_lod0.smd"
}

$lod 15
{
	replacemodel "w_m1c_lod0.smd" "w_m1c_lod0_lod1.smd"
	replacemodel "w_m1c_w_m7b_lod0.smd" "w_m1c_w_m7b_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_m1c_lod0.smd" "w_m1c_lod0_lod2.smd"
	replacemodel "w_m1c_w_m7b_lod0.smd" "w_m1c_w_m7b_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.479 -2.413 -1.403

$cdmaterials "models\weapons\mcv\w_bayonet\"
$cdmaterials "models\weapons\mcv\w_m1c\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 1.3 21 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" 0 1.3 -2 rotate 0 90 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 -0.5 -1.2 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -20.832 -1.971 -6.31 25.443 1.357 2.32

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999982 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone3" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone4" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_m1c_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_m1c_physics.smd"
{
	$mass 8
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\m1c\w_m1c_smd.qc"
//	}
}

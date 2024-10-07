// Created by Crowbar 0.74

$modelname "weapons\mcv\w_rp46.mdl"

$bodygroup "Body"
{
	studio "w_rp46_lod0.smd"
}
$bodygroup "bipod"
{
	studio "w_dp28_bipod1_lod0.smd"
	studio "w_dp28_bipod2_lod0.smd"
}
$bodygroup "ammo_belt"
{
	studio "w_rp46_ammo_belt.smd"
}
$bodygroup "handle"
{
	studio "rp46_pistol_handle.smd"
}

$lod 15
{
	replacemodel "w_rp46_lod0.smd" "w_rp46_lod0_lod1.smd"
	replacemodel "w_dp28_bipod1_lod0.smd" "w_dp28_bipod1_lod0_lod1.smd"
	replacemodel "w_dp28_bipod2_lod0.smd" "w_dp28_bipod2_lod0_lod1.smd"
	replacemodel "w_rp46_ammo_belt.smd" "w_rp46_ammo_belt_lod1.smd"
	replacemodel "rp46_pistol_handle.smd" "rp46_pistol_handle_lod1.smd"
	replacebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone"
	nofacial
}
$lod 30
{
	replacemodel "w_rp46_lod0.smd" "w_rp46_lod0_lod2.smd"
	replacemodel "w_dp28_bipod1_lod0.smd" "w_dp28_bipod1_lod0_lod2.smd"
	replacemodel "w_dp28_bipod2_lod0.smd" "w_dp28_bipod2_lod0_lod2.smd"
	replacemodel "w_rp46_ammo_belt.smd" "w_rp46_ammo_belt_lod2.smd"
	replacemodel "rp46_pistol_handle.smd" "rp46_pistol_handle_lod2.smd"
	replacebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 -10.333 -4.182

$cdmaterials "models\weapons\mcv\w_dp28\"
$cdmaterials "models\player\equipment\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 1.5 36.1 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" 0 0.6 4 rotate 0 -90 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 2.5 8 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -15.766 -7.937 -13.406 36.403 7.937 5.4

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000016 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone4" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_rp46_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_rp46_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\dp28\w_rp46.qc"
//	}
}

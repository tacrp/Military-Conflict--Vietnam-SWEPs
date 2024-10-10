// Created by Crowbar 0.74

$modelname "weapons\mcv\w_car15.mdl"

$bodygroup "Body"
{
	studio "w_car15_lod0.smd"
}
$bodygroup "scope"
{
	blank
	studio "w_car15_scope_lod0.smd"
	studio "w_single_point_OEG.smd"
}
$bodygroup "magazine"
{
	studio "w_magazine30_lod0.smd"
	studio "w_magazine20_lod0.smd"
}

$lod 15
{
	replacemodel "w_car15_lod0.smd" "w_car15_lod0_lod1.smd"
	replacemodel "w_car15_scope_lod0.smd" "w_car15_scope_lod0_lod1.smd"
	replacemodel "w_single_point_OEG.smd" "w_single_point_OEG_lod1.smd"
	replacemodel "w_magazine30_lod0.smd" "w_magazine30_lod0_lod1.smd"
	replacemodel "w_magazine20_lod0.smd" "w_magazine20_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_car15_lod0.smd" "w_car15_lod0_lod2.smd"
	replacemodel "w_car15_scope_lod0.smd" "w_car15_scope_lod0_lod2.smd"
	replacemodel "w_single_point_OEG.smd" "w_single_point_OEG_lod2.smd"
	replacemodel "w_magazine30_lod0.smd" "w_magazine30_lod0_lod2.smd"
	replacemodel "w_magazine20_lod0.smd" "w_magazine20_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.061 -3.4 -0.522

$cdmaterials "models\weapons\mcv\w_m16a1\"
$cdmaterials "models\weapons\mcv\w_car15\"
$cdmaterials "models\weapons\mcv\w_m203\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 0.7 18.5 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" 0 0.7 1.8 rotate 0 180 180
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 -1.5 1.8 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -12.295 -1.296 -6.803 19.196 1.296 5.508

$definebone "ValveBiped.Bip01_R_Hand" "" -6 -1 -3.25 0 0 180 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone" "ValveBiped.Bip01_R_Hand" 0 0 -0.064417 0 0 89.999989 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_car15_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_car15_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\car15m16\w_car15.qc"
//	}
}

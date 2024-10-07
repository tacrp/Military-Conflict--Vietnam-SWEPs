// Created by Crowbar 0.74

$modelname "weapons\mcv\w_pps43.mdl"

$bodygroup "Body"
{
	studio "w_pps43_lod0.smd"
}

$lod 15
{
	replacemodel "w_pps43_lod0.smd" "w_pps43_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_pps43_lod0.smd" "w_pps43_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.267 -1.76 -2.546

$cdmaterials "models\weapons\mcv\w_pps43\"

$attachment "muzzle" "ValveBiped.weapon_bone" 0 1.1 15.5 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" 0 1.6 1.3 rotate 0 90 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 0 3.8 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -16.57 -1.707 -8.201 19.835 1.174 2.826

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999982 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_pps43_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_pps43_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\ppsh41\w_pps43.qc"
//	}
}

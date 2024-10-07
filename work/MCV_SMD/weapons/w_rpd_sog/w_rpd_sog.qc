// Created by Crowbar 0.74

$modelname "weapons\mcv\w_rpd_sog.mdl"

$bodygroup "Body"
{
	studio "w_rpd_sog_lod0.smd"
}

$lod 15
{
	replacemodel "w_rpd_sog_lod0.smd" "w_rpd_sog_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_rpd_sog_lod0.smd" "w_rpd_sog_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.297 -1.47 -1.853

$cdmaterials "models\weapons\mcv\w_rpd\"
$cdmaterials "models\player\equipment\"

$attachment "muzzle" "ValveBiped.weapon_bone" 0.1 1.3 18.9 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.5 1.8 4 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 -1 4.5 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -14.916 -3.046 -7.378 17.718 3.763 3.353

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000043 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone3" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone4" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_rpd_sog_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_rpd_sog_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\rpd\w_rpd_sog.qc"
//	}
}

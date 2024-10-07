// Created by Crowbar 0.74

$modelname "weapons\mcv\w_ppk.mdl"

$bodygroup "Body"
{
	studio "w_walther_ppk_lod0.smd"
}

$lod 15
{
	replacemodel "w_walther_ppk_lod0.smd" "w_walther_ppk_lod0_lod1.smd"
	nofacial
}
$lod 25
{
	replacemodel "w_walther_ppk_lod0.smd" "w_walther_ppk_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 -4.429 0.119

$cdmaterials "models\weapons\mcv\w_ppk\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 2.2 11.1 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.65 2.6 1.5 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 0 0 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -2.517 -0.804 -2.581 11.24 0.799 2.982

$definebone "ValveBiped.weapon_bone" "" 0 0.0005 -0.064417 0 0 89.999989 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_ppk_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_ppk_physics.smd"
{
	$mass 4
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 4

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\pistol\w_walther_ppk.qc"
//	}
}

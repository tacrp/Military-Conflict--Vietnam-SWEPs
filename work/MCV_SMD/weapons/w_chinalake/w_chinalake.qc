// Created by Crowbar 0.74

$modelname "weapons\mcv\w_chinalake.mdl"

$bodygroup "Body"
{
	studio "w_china_lake_lod0.smd"
}

$lod 15
{
	replacemodel "w_china_lake_lod0.smd" "w_china_lake_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_china_lake_lod0.smd" "w_china_lake_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.015 1.124 -0.279

$cdmaterials "models\weapons\mcv\w_m79\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 1.7 14.2 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" 0 3 0 rotate 0 90 90
$attachment "mag_eject" "ValveBiped.weapon_bone" 0 3 0 rotate 0 90 90

$cbox 0 0 0 0 0 0

$bbox -17.632 -1.429 -4.132 15.336 1.415 3.441

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.00005 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone3" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_chinalake_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_chinalake_physics.smd"
{
	$mass 8
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 1

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\chinalake\w_chinalake.qc"
//	}
}

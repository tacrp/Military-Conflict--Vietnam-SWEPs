// Created by Crowbar 0.74

$modelname "weapons\mcv\w_m50.mdl"

$bodygroup "Body"
{
	studio "w_m50_lod0.smd"
}

$lod 15
{
	replacemodel "w_m50_lod0.smd" "w_m50_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_m50_lod0.smd" "w_m50_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.082 1.642 -2.247

$cdmaterials "models\weapons\mcv\w_m50_madsen\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 1.2 13.5 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -1 1.1 4.7 rotate 0 -180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 0 5 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -17.437 -1.08 -7.532 14.221 1.233 2.706

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000009 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_m50_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_m50_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\swm76\w_m50.qc"
//	}
}

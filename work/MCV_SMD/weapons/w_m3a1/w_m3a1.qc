// Created by Crowbar 0.74

$modelname "weapons\mcv\w_m3a1.mdl"

$bodygroup "Body"
{
	studio "w_m3a1_lod0.smd"
}

$lod 15
{
	replacemodel "w_m3a1_lod0.smd" "w_m3a1_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_m3a1_lod0.smd" "w_m3a1_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.236 -1.472 -2.052

$cdmaterials "models\weapons\mcv\w_m3a1\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 2.6 16.3 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -1 3.5 6 rotate 0 145 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 1 6 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -11.602 -1.163 -8.886 14.36 1.464 4.513

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000009 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_m3a1_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_m3a1_physics.smd"
{
	$mass 8
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 9

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\player\animation_iiopn\w_model\m3a1\w_m3a1.qc"
//	}
}

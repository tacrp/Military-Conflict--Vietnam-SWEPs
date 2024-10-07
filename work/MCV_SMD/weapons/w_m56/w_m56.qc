// Created by Crowbar 0.74

$modelname "weapons\mcv\w_m56.mdl"

$bodygroup "Body"
{
	studio "w_m56_lod0.smd"
}

$lod 15
{
	replacemodel "w_m56_lod0.smd" "w_m56_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_m56_lod0.smd" "w_m56_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.465 -1.694 -1.321

$cdmaterials "models\weapons\mcv\w_m56\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" -0.1 1.85 17.4 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.05 2.75 7 rotate 0 112 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 0 7.5 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -14.315 -1.779 -6.13 17.646 0.875 3.41

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000043 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_m56_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_m56_physics.smd"
{
	$mass 8
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 3

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\m56\w_m56.qc"
//	}
}

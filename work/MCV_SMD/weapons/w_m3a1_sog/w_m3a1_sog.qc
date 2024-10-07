// Created by Crowbar 0.74

$modelname "weapons\mcv\w_m3a1_sog.mdl"

$bodygroup "Body"
{
	studio "w_m3a1_sog_lod0.smd"
}

$lod 15
{
	replacemodel "w_m3a1_sog_lod0.smd" "w_m3a1_sog_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_m3a1_sog_lod0.smd" "w_m3a1_sog_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.236 -4.747 -2.052

$cdmaterials "models\weapons\mcv\w_m3a1\"

$attachment "muzzle" "ValveBiped.weapon_bone" 0 2.1 20.7 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -1 3.5 6 rotate 0 145 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 1 6 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -11.602 -1.099 -8.95 20.919 1.464 4.513

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999982 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_m3a1_sog_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_m3a1_sog_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\m3a1\w_m3a1_sog.qc"
//	}
}

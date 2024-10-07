// Created by Crowbar 0.74

$modelname "weapons\mcv\w_type64.mdl"

$bodygroup "Body"
{
	studio "w_type64_lod0.smd"
}

$lod 15
{
	replacemodel "w_type64_lod0.smd" "w_type64_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_type64_lod0.smd" "w_type64_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.385 -3.946 -1.948

$cdmaterials "models\weapons\mcv\w_type64\"

$attachment "muzzle" "ValveBiped.weapon_bone" 0 1.2 20.1 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -1.1 1.5 2.7 rotate 0 -180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 0 4.3 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -12.487 -1.661 -6.673 20.526 0.891 2.593

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000037 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_type64_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_type64_physics.smd"
{
	$mass 8
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 5

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\type64\w_type64.qc"
//	}
}

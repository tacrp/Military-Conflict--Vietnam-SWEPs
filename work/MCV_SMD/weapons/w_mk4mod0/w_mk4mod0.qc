// Created by Crowbar 0.74

$modelname "weapons\mcv\w_mk4mod0.mdl"

$bodygroup "magazine"
{
	studio "w_magazine20_lod0.smd"
}
$bodygroup "tape"
{
	studio "w_mk4mod0_lod0.smd"
	studio "w_mk4mod0_tape_lod0.smd"
}

$lod 15
{
	replacemodel "w_magazine20_lod0.smd" "w_magazine20_lod0_lod1.smd"
	replacemodel "w_mk4mod0_lod0.smd" "w_mk4mod0_lod0_lod1.smd"
	replacemodel "w_mk4mod0_tape_lod0.smd" "w_mk4mod0_tape_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_magazine20_lod0.smd" "w_magazine20_lod0_lod2.smd"
	replacemodel "w_mk4mod0_lod0.smd" "w_mk4mod0_lod0_lod2.smd"
	replacemodel "w_mk4mod0_tape_lod0.smd" "w_mk4mod0_tape_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.053 -7.174 -0.92

$cdmaterials "models\weapons\mcv\w_bayonet\"
$cdmaterials "models\weapons\mcv\w_m16a1\"
$cdmaterials "models\weapons\mcv\w_car15\"
$cdmaterials "models\weapons\mcv\w_m203\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 0.7 29 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" 0 0.7 1.8 rotate 0 180 180
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 -1.5 1.8 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -14.827 -1.298 -6.868 29.193 1.427 3.471

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999989 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_mk4mod0_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_mk4mod0_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\car15m16\w_mk4mod0.qc"
//	}
}

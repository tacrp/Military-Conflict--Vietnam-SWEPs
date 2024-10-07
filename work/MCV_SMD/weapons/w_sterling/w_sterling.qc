// Created by Crowbar 0.74

$modelname "weapons\mcv\w_sterling.mdl"

$bodygroup "Body"
{
	studio "w_sterling_lod0.smd"
}

$lod 15
{
	replacemodel "w_sterling_lod0.smd" "w_sterling_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_sterling_lod0.smd" "w_sterling_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 4.865 0.334 -0.684

$cdmaterials "models\weapons\mcv\w_sterling\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 1.8 14.6 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.5 1.5 4.2 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 2 2 4.5 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -15.929 -1.522 -4.976 15.037 11.668 3.295

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000043 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_sterling_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_sterling_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\sten\w_sterling.qc"
//	}
}

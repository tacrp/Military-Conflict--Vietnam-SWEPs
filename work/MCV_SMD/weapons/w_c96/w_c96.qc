// Created by Crowbar 0.74

$modelname "weapons\mcv\w_c96.mdl"

$bodygroup "Body"
{
	studio "w_c96_lod0.smd"
}

$lod 15
{
	replacemodel "w_c96_lod0.smd" "w_c96_lod0_lod1.smd"
	replacebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone"
	nofacial
}
$lod 25
{
	replacemodel "w_c96_lod0.smd" "w_c96_lod0_lod2.smd"
	replacebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.027 -4.783 0.221

$cdmaterials "models\weapons\mcv\w_c96\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 3.2 11.3 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.05 3.4 4 rotate 0 147 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 3.2 4 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -2.139 -0.829 -3.487 11.614 0.738 4.175

$definebone "ValveBiped.weapon_bone" "" 0 0.0005 -0.064417 0 0.000172 89.999968 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 -0.000172 0 0.000115 0 0 0 0 0 0


$sequence "idle" {
	"w_c96_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_c96_physics.smd"
{
	$mass 4
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\pistol\w_c96.qc"
//	}
}

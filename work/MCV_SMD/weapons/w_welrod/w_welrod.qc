// Created by Crowbar 0.74

$modelname "weapons\mcv\w_welrod.mdl"

$bodygroup "Body"
{
	studio "w_welrod_lod0.smd"
}

$lod 15
{
	replacemodel "w_welrod_lod0.smd" "w_welrod_lod0_lod1.smd"
	nofacial
}
$lod 25
{
	replacemodel "w_welrod_lod0.smd" "w_welrod_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.012 -3.224 0.165

$cdmaterials "models\weapons\mcv\w_welrod\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 2 9.6 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.1 2.9 0 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 0 0 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -3.305 -0.931 -2.727 9.739 0.941 2.886

$definebone "ValveBiped.weapon_bone" "" 0 0.0005 -0.064417 0 0.000172 89.999968 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 -0.000172 0 0.000115 0 0 0 0 0 0


$sequence "idle" {
	"w_welrod_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_welrod_physics.smd"
{
	$mass 4
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\pistol\w_welrod.qc"
//	}
}

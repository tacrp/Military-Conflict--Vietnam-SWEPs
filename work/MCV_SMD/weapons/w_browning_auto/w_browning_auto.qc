// Created by Crowbar 0.74

$modelname "weapons\mcv\w_browning_auto.mdl"

$bodygroup "Body"
{
	studio "w_browning_auto_lod0.smd"
}

$lod 15
{
	replacemodel "w_browning_auto_lod0.smd" "w_browning_auto_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_browning_auto_lod0.smd" "w_browning_auto_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.256 -3.128 -1.628

$cdmaterials "models\weapons\mcv\w_browning_auto5\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 1.6 26.5 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.75 1.3 -1.9 rotate 0 -180 90

$cbox 0 0 0 0 0 0

$bbox -20.305 -1.262 -5.799 26.749 0.931 2.619

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999989 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_browning_auto_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_browning_auto_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\browning_auto5\w_browning_auto.qc"
//	}
}

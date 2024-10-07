// Created by Crowbar 0.74

$modelname "weapons\mcv\w_rpg7.mdl"

$bodygroup "Body"
{
	studio "w_rpg7_lod0.smd"
}
$bodygroup "rocket"
{
	studio "w_rpg7_bg_rocket_lod0.smd"
	blank
}

$lod 15
{
	replacemodel "w_rpg7_lod0.smd" "w_rpg7_lod0_lod1.smd"
	replacemodel "w_rpg7_bg_rocket_lod0.smd" "w_rpg7_bg_rocket_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_rpg7_lod0.smd" "w_rpg7_lod0_lod2.smd"
	replacemodel "w_rpg7_bg_rocket_lod0.smd" "w_rpg7_bg_rocket_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.027 -1.403 -1.087

$cdmaterials "models\weapons\mcv\w_rpg7\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 0 14 rotate -90 -90 0
$attachment "backblast" "ValveBiped.weapon_bone" 0 0 -25 rotate 90 90 0

$cbox 0 0 0 0 0 0

$bbox -25.32 -2.559 -6.697 28.216 2.559 4.512

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000009 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_rpg7_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_rpg7_physics.smd"
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
//		"value" "c:\src\mcv\game2\vietnam\models\weapons\test\w_rpg7.qc"
//	}
}

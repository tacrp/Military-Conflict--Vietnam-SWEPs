// Created by Crowbar 0.74

$modelname "weapons\mcv\w_lunge_mine.mdl"

$bodygroup "Body"
{
	studio "w_lungemine_lod0.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 0.163 -16.481 1.639

$cdmaterials "models\weapons\mcv\w_lungemine\"
$cdmaterials "models\weapons\mcv\v_lungemine\"

$cbox 0 0 0 0 0 0

$bbox -7.632 -2.599 -1.161 40.418 3.001 4.476

$definebone "ValveBiped.weapon_bone" "" 0 0.0005 -0.064417 0 0.000172 89.999982 0 0 0 0 0 0


$sequence "idle" {
	"w_lunge_mine_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_lunge_mine_physics.smd"
{
	$mass 2
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
//		"value" "models\guns\equipment_lungemine\wbake\w_lungemine.qc"
//	}
}

// Created by Crowbar 0.74

$modelname "weapons\mcv\w_m1895.mdl"

$bodygroup "Body"
{
	studio "w_m1895_lod0.smd"
}

$lod 15
{
	replacemodel "w_m1895_lod0.smd" "w_m1895_lod0_lod1.smd"
	nofacial
}
$lod 25
{
	replacemodel "w_m1895_lod0.smd" "w_m1895_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.012 -3.112 0.582

$cdmaterials "models\weapons\mcv\w_m1895\"

$attachment "muzzle" "ValveBiped.weapon_bone" 0 3.25 8.7 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" 0 2.8 2.3 rotate 0 180 90

$cbox 0 0 0 0 0 0

$bbox -2.746 -1.22 -2.726 8.985 1.22 4.078

$definebone "ValveBiped.weapon_bone" "" 0 0.0005 -0.064417 0 0.000172 89.999982 0 0 0 0 0 0


$sequence "idle" {
	"w_m1895_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_m1895_physics.smd"
{
	$mass 4
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
//		"value" "models\guns\pistol_m1895\wbake\w_m1895.qc"
//	}
}

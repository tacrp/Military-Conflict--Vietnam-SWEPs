// Created by Crowbar 0.74

$modelname "weapons\mcv\w_swm12.mdl"

$bodygroup "Body"
{
	studio "w_swm12_lod0.smd"
}

$lod 15
{
	replacemodel "w_swm12_lod0.smd" "w_swm12_lod0_lod1.smd"
	nofacial
}
$lod 25
{
	replacemodel "w_swm12_lod0.smd" "w_swm12_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 -1.527 0.852

$cdmaterials "models\weapons\mcv\w_swm12\"

$attachment "muzzle" "ValveBiped.weapon_bone" 0 3 5.5 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" 0 2.6 2.5 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone" 0 2.6 2.5 rotate 0 180 90

$cbox 0 0 0 0 0 0

$bbox -2.684 -0.776 -2.146 5.704 0.776 3.815

$definebone "ValveBiped.weapon_bone" "" 0 0.0005 -0.064417 0 0.000172 89.999982 0 0 0 0 0 0


$sequence "idle" {
	"w_swm12_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_swm12_physics.smd"
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
//		"value" "models\guns\pistol_swm12\wbake\w_swm12.qc"
//	}
}

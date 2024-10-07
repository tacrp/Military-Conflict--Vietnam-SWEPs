// Created by Crowbar 0.74

$modelname "weapons\mcv\w_highpower.mdl"

$bodygroup "Body"
{
	studio "w_highpower_lod0.smd"
}

$lod 15
{
	replacemodel "w_highpower_lod0.smd" "w_highpower_lod0_lod1.smd"
	nofacial
}
$lod 25
{
	replacemodel "w_highpower_lod0.smd" "w_highpower_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.037 -2.33 -0.164

$cdmaterials "models\weapons\mcv\w_highpower\"

$attachment "muzzle" "ValveBiped.weapon_bone" 0 2.1 6.8 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.45 2.3 2.3 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 0 0 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -4.515 -0.557 -4.59 6.723 1.2 4.422

$definebone "ValveBiped.weapon_bone" "" 0 0.0005 -0.064417 0 0.000172 89.999982 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 -0.000172 0 0.000115 0 0 0 0 0 0


$sequence "idle" {
	"w_highpower_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_highpower_physics.smd"
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
//		"value" "models\guns\pistol_m1911\wbake\w_highpower.qc"
//	}
}

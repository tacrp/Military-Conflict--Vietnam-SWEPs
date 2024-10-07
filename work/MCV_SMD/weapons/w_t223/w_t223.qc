// Created by Crowbar 0.74

$modelname "weapons\mcv\w_t223.mdl"

$bodygroup "Body"
{
	studio "w_t223_lod0.smd"
}
$bodygroup "bayonet"
{
	blank
	studio "w_t223_bayonet_lod0.smd"
}
$bodygroup "magazine"
{
	studio "magazine_25.smd"
	studio "magazine_40.smd"
}

$lod 15
{
	replacemodel "w_t223_lod0.smd" "w_t223_lod0_lod1.smd"
	replacemodel "w_t223_bayonet_lod0.smd" "w_t223_bayonet_lod0_lod1.smd"
	replacemodel "magazine_25.smd" "magazine_25_lod1.smd"
	replacemodel "magazine_40.smd" "magazine_40_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_t223_lod0.smd" "w_t223_lod0_lod2.smd"
	replacemodel "w_t223_bayonet_lod0.smd" "w_t223_bayonet_lod0_lod2.smd"
	replacemodel "magazine_25.smd" "magazine_25_lod2.smd"
	replacemodel "magazine_40.smd" "magazine_40_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.128 -7.047 -3.369

$cdmaterials "models\weapons\mcv\w_bayonet\"
$cdmaterials "models\weapons\mcv\w_t223\"

$attachment "muzzle" "ValveBiped.weapon_bone" 0 0.5 22.1 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.2 1.2 3.2 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 -1.4 3 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -13.648 -0.863 -8.754 26.336 1.067 2.309

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999989 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone4" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_t223_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_t223_physics.smd"
{
	$mass 8
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\t223\smd\w_t223.qc"
//	}
}

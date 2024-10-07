// Created by Crowbar 0.74

$modelname "weapons\mcv\w_stg44.mdl"

$bodygroup "Body"
{
	studio "w_stg44_lod0.smd"
}
$bodygroup "scope"
{
	studio "w_stg44_scope_lod0.smd"
	blank
}
$bodygroup "magazine"
{
	studio "w_magazine30_lod0.smd"
	studio "w_magazine20_lod0.smd"
}

$lod 15
{
	replacemodel "w_stg44_lod0.smd" "w_stg44_lod0_lod1.smd"
	replacemodel "w_stg44_scope_lod0.smd" "w_stg44_scope_lod0_lod1.smd"
	replacemodel "w_magazine30_lod0.smd" "w_magazine30_lod0_lod1.smd"
	replacemodel "w_magazine20_lod0.smd" "w_magazine20_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_stg44_lod0.smd" "w_stg44_lod0_lod2.smd"
	replacemodel "w_stg44_scope_lod0.smd" "w_stg44_scope_lod0_lod2.smd"
	replacemodel "w_magazine30_lod0.smd" "w_magazine30_lod0_lod2.smd"
	replacemodel "w_magazine20_lod0.smd" "w_magazine20_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.011 -4.184 -1.456

$cdmaterials "models\weapons\mcv\w_stg44\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 1.4 22.7 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.5 1.7 4.8 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 0 4.5 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -14.617 -1.27 -8.826 23.02 1.291 5.56

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999982 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_stg44_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_stg44_physics.smd"
{
	$mass 10
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 9

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "models\player\animation_iiopn\w_model\stg44\w_stg44.qc"
//	}
}

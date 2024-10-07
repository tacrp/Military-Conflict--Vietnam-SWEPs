// Created by Crowbar 0.74

$modelname "weapons\mcv\w_m1897.mdl"

$bodygroup "Body"
{
	studio "w_m1897_lod0.smd"
}
$bodygroup "bayonet"
{
	blank
	studio "w_m1897_akb_lod0.smd"
}

$lod 15
{
	replacemodel "w_m1897_lod0.smd" "w_m1897_lod0_lod1.smd"
	replacemodel "w_m1897_akb_lod0.smd" "w_m1897_akb_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_m1897_lod0.smd" "w_m1897_lod0_lod2.smd"
	replacemodel "w_m1897_akb_lod0.smd" "w_m1897_akb_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.014 -4.106 -1.746

$cdmaterials "models\weapons\mcv\w_m1897\"
$cdmaterials "models\weapons\mcv\w_ak47_bayonet\"
$cdmaterials "models\weapons\mcv\w_type30_bayonet\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 1.2 21.7 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.75 1 0.5 rotate 0 180 90

$cbox 0 0 0 0 0 0

$bbox -21.947 -1.233 -6.439 30.159 1.251 2.652

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999968 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone4" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_m1897_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_m1897_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\m1897\w_m1897.qc"
//	}
}

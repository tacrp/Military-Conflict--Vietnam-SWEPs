// Created by Crowbar 0.74

$modelname "weapons\mcv\w_m1928.mdl"

$bodygroup "Body"
{
	studio "w_m1928_lod0.smd"
}

$lod 15
{
	replacemodel "w_m1928_lod0.smd" "w_m1928_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_m1928_lod0.smd" "w_m1928_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.02 0.787 -0.81

$cdmaterials "models\weapons\mcv\w_m1928\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 2.2 17.9 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.6 2.5 1.2 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 1 1 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -18.556 -3.682 -5.245 16.973 3.686 3.437

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999962 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_m1928_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_m1928_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\m1928\w_m1928.qc"
//	}
}

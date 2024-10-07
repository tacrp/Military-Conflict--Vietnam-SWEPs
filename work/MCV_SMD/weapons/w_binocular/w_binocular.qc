// Created by Crowbar 0.74

$modelname "weapons\mcv\w_binocular.mdl"

$bodygroup "studio"
{
	studio "w_binocular_lod0.smd"
	studio "w_binocular2_lod0.smd"
}

$lod 15
{
	replacemodel "w_binocular_lod0.smd" "w_binocular_lod0_lod1.smd"
	replacemodel "w_binocular2_lod0.smd" "w_binocular2_lod0_lod1.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 0.076 0.098

$cdmaterials "models\weapons\mcv\w_binoculars\"
$cdmaterials ""

$cbox 0 0 0 0 0 0

$bbox -2.568 -3.57 -1.513 2.3 3.57 1.685

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000009 0 0 0 0 0 0


$sequence "idle" {
	"w_binocular_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_binocular_physics.smd"
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
//		"value" "e:\animations\vietnamcontent\vietnam\models\player\animation_iiopn\w_model\binocular\w_binocular.qc"
//	}
}

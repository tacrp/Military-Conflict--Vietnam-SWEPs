// Created by Crowbar 0.74

$modelname "weapons\mcv\w_box.mdl"

$bodygroup "studio"
{
	studio "w_usbox_lod0.smd"
	studio "w_vcbox_lod0.smd"
}

$lod 45
{
	replacemodel "w_usbox_lod0.smd" "w_usbox_lod0_lod1.smd"
	replacemodel "w_vcbox_lod0.smd" "w_vcbox_lod0_lod1.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.061 0 0.49

$cdmaterials "models\weapons\mcv\w_box\"
$cdmaterials ""

$texturegroup "skinfamilies"
{
	{ "w_usbox"        "w_vcbox"        }
	{ "w_usbox_medkit" "w_vcbox_medkit" }
}

$cbox 0 0 0 0 0 0

$bbox -2.899 -6.303 -3.533 2.899 6.303 4.261

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 90.000009 0 0 0 0 0 0


$sequence "idle" {
	"w_box_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_box_physics.smd"
{
	$mass 8
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 1

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\player\animation_iiopn\w_model\box\w_box.qc"
//	}
}

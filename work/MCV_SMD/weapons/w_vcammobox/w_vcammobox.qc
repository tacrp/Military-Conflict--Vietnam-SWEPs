// Created by Crowbar 0.74

$modelname "weapons\mcv\w_vcammobox.mdl"

$bodygroup "studio"
{
	studio "w_vcboxnew_lod0.smd"
}

$lod 15
{
	replacemodel "w_vcboxnew_lod0.smd" "w_vcboxnew_lod0_lod1.smd"
	nofacial
}
$lod 40
{
	replacemodel "w_vcboxnew_lod0.smd" "w_vcboxnew_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.169 0.066 0.325

$cdmaterials "models\weapons\mcv\w_box\"

$cbox 0 0 0 0 0 0

$bbox -2.122 -5.763 -5.992 2.07 5.731 6.651

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999982 0 0 0 0 0 0


$sequence "idle" {
	"w_vcammobox_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_vcammobox_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\box\w_vcammobox.qc"
//	}
}

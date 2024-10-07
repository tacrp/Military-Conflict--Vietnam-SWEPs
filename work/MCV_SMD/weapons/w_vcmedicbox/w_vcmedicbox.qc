// Created by Crowbar 0.74

$modelname "weapons\mcv\w_vcmedicbox.mdl"

$bodygroup "studio"
{
	studio "w_viet_medicbag_lod0.smd"
}

$lod 15
{
	replacemodel "w_viet_medicbag_lod0.smd" "w_viet_medicbag_lod0_lod1.smd"
	nofacial
}
$lod 45
{
	replacemodel "w_viet_medicbag_lod0.smd" "w_viet_medicbag_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.039 0.114 0.366

$cdmaterials "models\weapons\mcv\w_box\"

$cbox 0 0 0 0 0 0

$bbox -2.987 -5.328 -3.958 3.034 5.396 4.848

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999989 0 0 0 0 0 0


$sequence "idle" {
	"w_vcmedicbox_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_vcmedicbox_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\box\w_vcmedicbox.qc"
//	}
}

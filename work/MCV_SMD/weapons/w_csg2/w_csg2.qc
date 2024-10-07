// Created by Crowbar 0.74

$modelname "weapons\mcv\w_csg2.mdl"

$bodygroup "Body"
{
	studio "w_csg2_lod0.smd"
}

$lod 12
{
	replacemodel "w_csg2_lod0.smd" "w_csg2_lod0_lod1.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 0 0.211

$cdmaterials "models\weapons\mcv\w_csg2\"
$cdmaterials ""

$attachment "0" "ValveBiped.weapon_bone" 0 -5.5 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -1.666 -1.666 -5.49 1.666 1.666 5.879

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999968 0 0 0 0 0 0


$sequence "idle" {
	"w_csg2_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_csg2_physics.smd"
{
	$mass 4
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\grenade\w_csg2_lod0.qc"
//	}
}

// Created by Crowbar 0.74

$modelname "weapons\mcv\w_csg.mdl"

$bodygroup "Body"
{
	studio "w_csg_lod0.smd"
}

$lod 12
{
	replacemodel "w_csg_lod0.smd" "w_csg_lod0_lod1.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 0 0.231

$cdmaterials "models\weapons\mcv\w_csg\"
$cdmaterials ""

$attachment "0" "ValveBiped.weapon_bone" 0 -5.5 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -1.828 -1.828 -5.49 1.828 1.828 5.919

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999968 0 0 0 0 0 0


$sequence "idle" {
	"w_csg_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_csg_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\grenade\w_csg_lod0.qc"
//	}
}

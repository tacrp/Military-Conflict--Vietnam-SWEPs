// Created by Crowbar 0.74

$modelname "weapons\mcv\w_mk3a2.mdl"

$bodygroup "Body"
{
	studio "w_mk3a2_lod0.smd"
}

$lod 12
{
	replacemodel "w_mk3a2_lod0.smd" "w_mk3a2_lod0_lod1.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.112 0.343 0.743

$cdmaterials "models\weapons\mcv\w_mk32\"
$cdmaterials ""

$attachment "0" "ValveBiped.weapon_bone" 0 3.5 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -2.082 -1.433 -2.565 1.433 1.639 3.775

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999968 0 0 0 0 0 0


$sequence "idle" {
	"w_mk3a2_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_mk3a2_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\grenade\w_mk3a2.qc"
//	}
}

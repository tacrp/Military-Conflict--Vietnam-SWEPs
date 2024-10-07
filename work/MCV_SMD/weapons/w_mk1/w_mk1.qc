// Created by Crowbar 0.74

$modelname "weapons\mcv\w_mk1.mdl"

$bodygroup "Body"
{
	studio "w_mk1_lod0.smd"
}

$lod 12
{
	replacemodel "w_mk1_lod0.smd" "w_mk1_lod0_lod1.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.056 0.141 0.132

$cdmaterials "models\weapons\mcv\w_mk1\"
$cdmaterials ""

$attachment "0" "ValveBiped.weapon_bone" 0 3.5 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -1.812 -1.507 -2.686 1.53 1.618 2.988

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999968 0 0 0 0 0 0


$sequence "idle" {
	"w_mk1_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_mk1_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\grenade\w_mk1.qc"
//	}
}

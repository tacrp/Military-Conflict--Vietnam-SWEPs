// Created by Crowbar 0.74

$modelname "weapons\mcv\w_sickle.mdl"

$bodygroup "Body"
{
	studio "w_sickle_lod0.smd"
}

$lod 15
{
	replacemodel "w_sickle_lod0.smd" "w_sickle_lod0_lod1.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.125 -6.881 0.233

$cdmaterials "models\weapons\mcv\w_sickle\"
$cdmaterials ""

$cbox 0 0 0 0 0 0

$bbox -6.219 -1.122 -2.129 20.084 1.255 2.665

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999968 0 0 0 0 0 0


$sequence "idle" {
	"w_sickle_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_sickle_physics.smd"
{
	$mass 1
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\knife\w_sickle.qc"
//	}
}

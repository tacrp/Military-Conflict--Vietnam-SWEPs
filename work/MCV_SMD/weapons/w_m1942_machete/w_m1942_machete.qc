// Created by Crowbar 0.74

$modelname "weapons\mcv\w_m1942_machete.mdl"

$bodygroup "Body"
{
	studio "w_m1942_machete_lod0.smd"
}

$lod 15
{
	replacemodel "w_m1942_machete_lod0.smd" "w_m1942_machete_lod0_lod1.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.07 -6.65 -0.294

$cdmaterials "models\weapons\mcv\w_m1942_machete\"
$cdmaterials ""

$cbox 0 0 0 0 0 0

$bbox -4.853 -0.537 -1.529 18.583 0.718 1.186

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999968 0 0 0 0 0 0


$sequence "idle" {
	"w_m1942_machete_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_m1942_machete_physics.smd"
{
	$mass 1
	$inertia 1
	$damping 0
	$rotdamping 1
	$rootbone " "
	$concave
	$maxconvexpieces 1

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\knife\w_m1942_machete.qc"
//	}
}

// Created by Crowbar 0.74

$modelname "weapons\mcv\w_css_ignited.mdl"

$bodygroup "body"
{
	studio "w_css_white_ignited_lod0.smd"
	studio "w_css_black_ignited_lod0.smd"
}

$lod 12
{
	replacemodel "w_css_white_ignited_lod0.smd" "w_css_white_ignited_lod0_lod1.smd"
	replacemodel "w_css_black_ignited_lod0.smd" "w_css_black_ignited_lod0_lod1.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition -0.014 -0.001 0.886

$cdmaterials "models\weapons\mcv\w_css\"
$cdmaterials "models\weapons\mcv\shells\"

$attachment "0" "ValveBiped.weapon_bone" 0 -5.5 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -1.666 -1.666 -5.49 1.666 1.666 5.879

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999989 0 0 0 0 0 0


$sequence "idle" {
	"w_css_ignited_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_css_ignited_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\grenade\css_gren_but_with_bodygroups_instead_skins\w_css_ignited.qc"
//	}
}

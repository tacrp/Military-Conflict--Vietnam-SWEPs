// Created by Crowbar 0.74

$modelname "weapons\shells\rpg7_rocket.mdl"

$bodygroup "Body"
{
	studio "shell_rocket_lod0.smd"
}

$lod 15
{
	replacemodel "shell_rocket_lod0.smd" "shell_rocket_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "shell_rocket_lod0.smd" "shell_rocket_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 3.959 0

$cdmaterials "models\weapons\mcv\v_rpg7\"
$cdmaterials "models\weapons\mcv\w_rpg7\"

$attachment "0" "base" 0 0 -13 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -20.796 -5.123 -5.114 12.972 5.148 5.146

$definebone "base" "" 0 0 0 0 0 89.999982 0 0 0 0 0 0


$sequence "idle" {
	"rpg7_rocket_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "rpg7_rocket_physics.smd"
{
	$mass 7
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 4

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\guns\launcher_rpg7\wbake\rpg7_shell_rocket.qc"
//	}
}

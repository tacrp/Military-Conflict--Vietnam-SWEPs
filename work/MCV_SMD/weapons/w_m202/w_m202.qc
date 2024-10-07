// Created by Crowbar 0.74

$modelname "weapons\mcv\w_m202.mdl"

$bodygroup "Body"
{
	studio "w_m202_lod0.smd"
}

$lod 23
{
	replacemodel "w_m202_lod0.smd" "w_m202_lod0_lod1.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 1.712 2.248 -2.545

$cdmaterials "models\weapons\mcv\w_bayonet\"
$cdmaterials "models\weapons\mcv\w_m202\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 0.1 13.5 rotate -90 -90 0
$attachment "muzzle_equipment" "ValveBiped.weapon_bone" 0 -1.7 18.3 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.75 0.7 1.5 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 0 0 rotate -90 -90 0
$attachment "backblast" "ValveBiped.weapon_bone" 0 0.1 -17.75 rotate 90 -90 0

$cbox 0 0 0 0 0 0

$bbox -17.989 -3.414 -9.993 13.76 7.055 4.902

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999962 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_m202_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_m202_physics.smd"
{
	$mass 8
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 6

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "e:\animations\vietnamcontent\vietnam\models\player\animation_iiopn\w_model\m202\w_m202.qc"
//	}
}

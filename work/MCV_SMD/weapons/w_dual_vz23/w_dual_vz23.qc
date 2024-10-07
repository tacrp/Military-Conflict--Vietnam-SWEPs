// Created by Crowbar 0.74

$modelname "weapons\mcv\w_dual_vz23.mdl"

$bodygroup "Body"
{
	studio "w_vz23_dual_lod0.smd"
}

$lod 15
{
	replacemodel "w_vz23_dual_lod0.smd" "w_vz23_dual_lod0_lod1.smd"
	nofacial
}
$lod 30
{
	replacemodel "w_vz23_dual_lod0.smd" "w_vz23_dual_lod0_lod2.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 1.266 2.104 -0.827

$cdmaterials "models\weapons\mcv\w_vz23\"
$cdmaterials ""

$attachment "muzzle" "ValveBiped.weapon_bone" 0 2.5 12 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone" -0.6 2.7 0.7 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 0 0 rotate -90 -90 0
$attachment "muzzle" "ValveBiped.weapon_bone_left" 0 2.5 12 rotate -90 -90 0
$attachment "shell_eject" "ValveBiped.weapon_bone_left" -0.6 2.7 0.7 rotate 0 180 90
$attachment "mag_eject" "ValveBiped.weapon_bone_left" 0 0 0 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -17.124 -1.422 -6.123 12.979 3.536 4.337

$definebone "ValveBiped.weapon_bone" "" 0 0 0 0 0 90.000043 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone_left" "" 2.100534 0 -0.064417 0 0 90.000043 0 0 0 0 0 0


$sequence "idle" {
	"w_dual_vz23_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_dual_vz23_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\dualweapon\w_dual_vz23.qc"
//	}
}

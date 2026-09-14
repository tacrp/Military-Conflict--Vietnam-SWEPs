// KEEP: kitbash world mesh; rebuild with work/build_xm16super.py
// Created by Crowbar 0.74

$modelname "weapons\mcv\w_xm16super.mdl"

$bodygroup "Body"
{
	studio "xm16super_world.smd"
}

$cdmaterials "models/weapons/mcv/v_m16a1/"
$cdmaterials "models/weapons/mcv/v_uzi/"
$cdmaterials "models/weapons/mcv/shells/"
$cdmaterials "models/weapons/mcv/optics/"

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 0 0


$attachment "muzzle" "ValveBiped.weapon_bone" 0.000000 0.700000 29.000000 rotate -90 -90 0
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 -1.5 1.8 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -14.827 -1.298 -6.868 29.193 1.427 3.471

$definebone "ValveBiped.Bip01_R_Hand" "" -6.183419 -1.000000 -1.925614 12.956000 0.000000 180.000000 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone" "ValveBiped.Bip01_R_Hand" 0 0 -0.064417 0 0 89.999989 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone2" "ValveBiped.weapon_bone" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"../../../MCV_SMD_OG/weapons/w_mk4mod0/w_mk4mod0_anims/idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "../../../MCV_SMD_OG/weapons/w_mk4mod0/w_mk4mod0_physics.smd"
{
	$mass 8
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 8

}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\car15m16\w_mk4mod0.qc"
//	}
}

$attachment "muzzle_equipment" "ValveBiped.weapon_bone" 0.000000 -1.765000 17.185000 rotate -90 -90 0

$attachment "shell_eject" "ValveBiped.weapon_bone" -0.340000 0.700000 0.100000 rotate 0 180 90

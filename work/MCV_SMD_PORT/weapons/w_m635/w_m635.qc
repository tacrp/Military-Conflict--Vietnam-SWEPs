// KEEP: kitbash world mesh; rebuild with work/build_m635.py
// Created by Crowbar 0.74

$modelname "weapons\mcv\w_m635.mdl"

$bodygroup "Body"
{
	studio "m635_world.smd"
}

$cdmaterials "models/weapons/mcv/v_m16a1/"
$cdmaterials "models/weapons/mcv/v_uzi/"
$cdmaterials "models/weapons/mcv/shells/"
$cdmaterials "models/weapons/mcv/optics/"

$cdmaterials "models/weapons/mcv/v_m601/"

$surfaceprop "weapon"

$contents "solid"

$illumposition 0 0 0


$attachment "muzzle" "ValveBiped.weapon_bone" 0.000000 0.700000 14.550000 rotate -90 -90 0
$attachment "mag_eject" "ValveBiped.weapon_bone2" 0 -1.5 1.8 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -1.238015 -15.601934 -6.172864 1.290080 12.650608 3.524386

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

$collisionmodel "m635_collision.smd"
{
	$mass 2.61
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "


}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\car15m16\w_mk4mod0.qc"
//	}
}

$attachment "shell_eject" "ValveBiped.weapon_bone" -0.340000 0.700000 0.100000 rotate 0 180 90

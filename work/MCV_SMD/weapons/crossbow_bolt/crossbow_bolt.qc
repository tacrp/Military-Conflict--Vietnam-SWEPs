// Created by Crowbar 0.74

$modelname "weapons/mcv/crossbow_bolt.mdl"

$bodygroup "body"
{
	studio "crossbow_bolt.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 0 -2 0

$cdmaterials "models\weapons\mcv\w_crossbow\"

$attachment "0" "crossbow_bolt" 0 -4 12 rotate 0 -90 0

$cbox 0 0 0 0 0 0

$bbox -5.897 -1.509 -12.061 20.033 1.535 0.238

$definebone "Crossbow" "" 0 0 0 0 0 89.999989 0 0 0 0 0 0
$definebone "crossbow_bolt" "" -0.012965 -17.819363 -12.06123 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"crossbow_bolt_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\guns\launcher_crossbow\crossbow_bolt.qc"
//	}
}

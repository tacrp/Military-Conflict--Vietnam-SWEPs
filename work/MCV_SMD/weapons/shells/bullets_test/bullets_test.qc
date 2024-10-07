// Created by Crowbar 0.74

$modelname "weapons\shells\bullets_test.mdl"

$bodygroup "Body"
{
	studio "bullets_test.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition -3.323 0.167 3.29

$cdmaterials "models\weapons\mcv\shells\"

$cbox 0 0 0 0 0 0

$bbox -14.199 -19.147 0 13.866 12.501 6.579

$definebone "root" "" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"bullets_test_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$keyvalues
{
// CSGO compiler adds the qc_path keyvalue section automatically.
//	qc_path 
//	{
//		"value" "models\shells\bullets_test.qc"
//	}
}

// Created by Crowbar 0.74

$modelname "weapons\mcv\w_m18.mdl"

$bodygroup "body"
{
	studio "w_m18_red.smd"
	studio "w_m18_green.smd"
	studio "w_m18_yellow.smd"
	studio "w_m18_violet.smd"
	studio "w_m18.smd"
	studio "w_incen1.smd"
	studio "w_incen2.smd"
	studio "w_riot.smd"
}

$lod 12
{
	replacemodel "w_m18_red.smd" "w_m18_red_lod1.smd"
	replacemodel "w_m18_green.smd" "w_m18_green_lod1.smd"
	replacemodel "w_m18_yellow.smd" "w_m18_yellow_lod1.smd"
	replacemodel "w_m18_violet.smd" "w_m18_violet_lod1.smd"
	replacemodel "w_m18.smd" "w_m18_lod1.smd"
	replacemodel "w_incen1.smd" "w_incen1_lod1.smd"
	replacemodel "w_incen2.smd" "w_incen2_lod1.smd"
	replacemodel "w_riot.smd" "w_riot_lod1.smd"
	nofacial
}

$surfaceprop "weapon"

$contents "solid"

$illumposition 0.151 0.349 0.624

$cdmaterials "models\weapons\mcv\w_m18\"

$texturegroup "skinfamilies"
{
	{ "w_m18_red"    }
	{ "w_m18_green"  }
	{ "w_m18_yellow" }
	{ "w_m18_violet" }
	{ "w_m18"        }
	{ "w_incen1"     }
	{ "w_incen2"     }
	{ "w_riot"       }
}

$attachment "0" "ValveBiped.weapon_bone" 0 3.5 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -1.866 -1.433 -2.565 1.433 1.469 3.539

$definebone "ValveBiped.weapon_bone" "" 0 0 -0.064417 0 0 89.999989 0 0 0 0 0 0


$sequence "idle" {
	"w_m18_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "w_m18_physics.smd"
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
//		"value" "d:\dev_content2\mcv\mcv-content\vietnam\models\player\animation_iiopn\w_model\grenade\m18_gren_but_with_bodygroups_instead_skins\w_m18_lod0.qc"
//	}
}

// Created by Crowbar 0.71

$modelname "weapons/arccw_go/v_rif_galil_ar.mdl"

$bodygroup "studio"
{
	studio "body.smd"
}
$bodygroup "mag"
{
	studio "mag.smd"
}
$bodygroup "barrel"
{
	studio "barrel.smd"
	studio "barrel_long.smd"
	studio "barrel_short.smd"
}
$bodygroup "stock"
{
	studio "stock.smd"
	blank
}
$bodygroup "rs"
{
	studio "rs1.smd"
	studio "rs2.smd"
	blank
}
$bodygroup "sidemount"
{
	blank
	studio "ak47_sidemount.smd"
}
$bodygroup "ubrms"
{
	blank
	studio "ak47_ubrms.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition -2.412 -17.715 -9.249

$cdmaterials "models\weapons\v_arccw_go\rif_galil_ar\"
$cdmaterials "models\weapons\v_arccw_go\ins2\"
$cdmaterials "models\weapons\v_arccw_go\atts\"

$attachment "1" "v_weapon.sg556_Parent" -0.06 3.15 26.51 rotate -90 -90 0
$attachment "2" "v_weapon.sg556_Parent" 0 3.68 6.5 rotate 0 -180 0
$attachment "unzoom" "v_weapon" -5.1 -1 11.5 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -10.498 -18.637 -15.395 43.716 11.551 1.353

$definebone "v_weapon.Bip01_Neck" "" 0.000011 20.603065 -1.576342 -16.006953 89.999982 89.999873 0 0 0 0 0 0
$definebone "v_weapon.Bip01_L_Clavicle" "v_weapon.Bip01_Neck" -0.999641 0.234795 1.2233 -69.622912 163.993006 0.000057 0 0 0 0 0 0
$definebone "v_weapon.Bip01_L_UpperArm" "v_weapon.Bip01_L_Clavicle" 5.773738 0 0 22.64347 0.384684 0.597538 0 0 0 0 0 0
$definebone "v_weapon.Bip01_L_Forearm" "v_weapon.Bip01_L_UpperArm" 11.576876 0 0.000006 0.00001 -0.041998 0 0 0 0 0 0 0
$definebone "v_weapon.Bip01_L_Hand" "v_weapon.Bip01_L_Forearm" 10.295579 0 -0.000002 -2.498775 -1.242173 -89.582295 0 0 0 0 0 0
$definebone "v_weapon.Bip01_L_Finger0" "v_weapon.Bip01_L_Hand" 1.149529 0.416498 -1.414116 18.383468 13.491913 80.63166 0 0 0 0 0 0
$definebone "v_weapon.Bip01_L_Finger01" "v_weapon.Bip01_L_Finger0" 1.263882 0.000001 -0.000002 0.000024 0.000004 -0.000014 0 0 0 0 0 0
$definebone "v_weapon.Bip01_L_Finger02" "v_weapon.Bip01_L_Finger01" 1.188945 0 -0.000004 0.000022 -0.488153 -0.000012 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "v_weapon.Bip01_L_Finger02" -0.176399 -0.5569 -0.1665 0.000137 0.000005 9.999995 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "v_weapon.Bip01_L_Finger01" -0.178598 -0.5643 -0.099504 0.00014 0.000008 9.999989 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "v_weapon.Bip01_L_Finger0" -0.1806 -0.5734 -0.019201 0.000138 0.000006 9.999877 0 0 0 0 0 0
$definebone "v_weapon.Bip01_L_Finger1" "v_weapon.Bip01_L_Hand" 3.77376 0.133217 -0.970575 8.162473 0.340466 0.527178 0 0 0 0 0 0
$definebone "v_weapon.Bip01_L_Finger11" "v_weapon.Bip01_L_Finger1" 1.433455 0.000002 0 -0.000001 1.448389 0.000001 0 0 0 0 0 0
$definebone "v_weapon.Bip01_L_Finger12" "v_weapon.Bip01_L_Finger11" 1.019167 0.000008 0 -0.000001 1.448398 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "v_weapon.Bip01_L_Finger12" 0.046598 -0.006195 -0.2287 -0.000001 0.000014 -179.999978 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "v_weapon.Bip01_L_Finger11" 0.046801 -0.005003 -0.228699 0 0.000012 179.999909 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "v_weapon.Bip01_L_Finger1" 0.046898 -0.003899 -0.2288 0 0.00001 179.999978 0 0 0 0 0 0
$definebone "v_weapon.Bip01_L_Finger2" "v_weapon.Bip01_L_Hand" 3.799515 0.014956 -0.039958 -1.985356 1.299999 -0.498645 0 0 0 0 0 0
$definebone "v_weapon.Bip01_L_Finger21" "v_weapon.Bip01_L_Finger2" 1.774878 0.000004 0 0 1.448399 0 0 0 0 0 0 0
$definebone "v_weapon.Bip01_L_Finger22" "v_weapon.Bip01_L_Finger21" 1.008841 0.000004 0 0 1.448397 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "v_weapon.Bip01_L_Finger22" 0.0058 -0.000299 -0.2334 0 0.000014 -179.999978 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "v_weapon.Bip01_L_Finger21" 0.005796 -0.000097 -0.2335 0 0.000017 -179.999978 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "v_weapon.Bip01_L_Finger2" 0.005798 0.000002 -0.2335 0 0.000012 -179.999978 0 0 0 0 0 0
$definebone "v_weapon.Bip01_L_Finger3" "v_weapon.Bip01_L_Hand" 3.632765 0.059048 0.757493 -9.344711 2.459669 -0.939021 0 0 0 0 0 0
$definebone "v_weapon.Bip01_L_Finger31" "v_weapon.Bip01_L_Finger3" 1.500137 0.000002 0 0 1.448392 -0.000002 0 0 0 0 0 0
$definebone "v_weapon.Bip01_L_Finger32" "v_weapon.Bip01_L_Finger31" 0.905668 0 -0.000001 0 1.448394 -0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "v_weapon.Bip01_L_Finger32" -0.024099 0.0028 -0.2322 0 0.000014 179.999909 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "v_weapon.Bip01_L_Finger31" -0.024099 0.002102 -0.2323 0 0.000012 179.999978 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "v_weapon.Bip01_L_Finger3" -0.0242 0.001499 -0.2323 0.000002 0.00001 179.999978 0 0 0 0 0 0
$definebone "v_weapon.Bip01_L_Finger4" "v_weapon.Bip01_L_Hand" 3.323326 0.233744 1.479073 -18.576327 1.802655 -1.857759 0 0 0 0 0 0
$definebone "v_weapon.Bip01_L_Finger41" "v_weapon.Bip01_L_Finger4" 0.963097 0.000008 0.000001 0 1.448399 -0.000005 0 0 0 0 0 0
$definebone "v_weapon.Bip01_L_Finger42" "v_weapon.Bip01_L_Finger41" 0.682896 0.000002 0 0.000002 1.448397 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "v_weapon.Bip01_L_Finger42" 0 0.000002 0 0.000003 0.000014 179.999978 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "v_weapon.Bip01_L_Finger41" 0 0.000002 0 -0.000001 0.000019 179.999978 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "v_weapon.Bip01_L_Finger4" -0.061199 0.005199 -0.2253 0.000003 0.000017 -179.999978 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "v_weapon.Bip01_L_Hand" 0.208301 -0.4939 -0.207 1.092287 -0.313388 -173.603123 0 0 0 0 0 0
$definebone "v_weapon.Bip01_L_ForeTwist" "v_weapon.Bip01_L_UpperArm" 11.576876 0 0.000006 0.00001 -0.041998 0.39133 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "v_weapon.Bip01_L_ForeTwist" -1.737901 0.0933 -0.444605 -0.417798 -1.926972 0.342285 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Forearm" -11.576893 0 0.008501 -0.041997 -0.000288 0.391388 0 0 0 0 0 0
$definebone "v_weapon.Bip01_R_Clavicle" "v_weapon.Bip01_Neck" -0.999641 0.234802 -1.2233 69.622796 163.992323 -0.000745 0 0 0 0 0 0
$definebone "v_weapon.Bip01_R_UpperArm" "v_weapon.Bip01_R_Clavicle" 5.773738 0 0.000004 -22.6434 0.384682 -0.597541 0 0 0 0 0 0
$definebone "v_weapon.Bip01_R_Forearm" "v_weapon.Bip01_R_UpperArm" 11.576878 0 -0.000002 0.000003 -0.042 -0.000002 0 0 0 0 0 0
$definebone "v_weapon.Bip01_R_Hand" "v_weapon.Bip01_R_Forearm" 10.29558 0 0 2.498787 -1.242174 89.582295 0 0 0 0 0 0
$definebone "v_weapon.Bip01_R_Finger0" "v_weapon.Bip01_R_Hand" 1.149521 0.416502 1.414117 -18.383468 13.491893 -80.63166 0 0 0 0 0 0
$definebone "v_weapon.Bip01_R_Finger01" "v_weapon.Bip01_R_Finger0" 1.263883 0 -0.000008 0.000007 -0.488159 -0.000001 0 0 0 0 0 0
$definebone "v_weapon.Bip01_R_Finger02" "v_weapon.Bip01_R_Finger01" 1.188942 -0.000002 0.000008 0.00001 -0.488161 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "v_weapon.Bip01_R_Finger02" -0.176325 -0.556922 0.16646 0.000009 0 -10.000005 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "v_weapon.Bip01_R_Finger01" -0.17861 -0.564292 0.099525 0.000007 0 -10.000004 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "v_weapon.Bip01_R_Finger0" -0.180557 -0.573446 0.019196 0.000003 0.000001 -10.000005 0 0 0 0 0 0
$definebone "v_weapon.Bip01_R_Finger1" "v_weapon.Bip01_R_Hand" 3.773754 0.133215 0.970574 -8.162469 0.340451 -0.527176 0 0 0 0 0 0
$definebone "v_weapon.Bip01_R_Finger11" "v_weapon.Bip01_R_Finger1" 1.433456 -0.000002 0 0.000003 1.448377 0.000003 0 0 0 0 0 0
$definebone "v_weapon.Bip01_R_Finger12" "v_weapon.Bip01_R_Finger11" 1.019165 0 0 0.000005 1.448373 0.000004 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "v_weapon.Bip01_R_Finger12" 0.046591 -0.006235 0.228735 0.000005 -0.00001 179.999978 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "v_weapon.Bip01_R_Finger11" 0.046736 -0.005051 0.228735 0.000003 -0.000005 179.999978 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "v_weapon.Bip01_R_Finger1" 0.046852 -0.003876 0.228735 0.000004 -0.000009 179.999978 0 0 0 0 0 0
$definebone "v_weapon.Bip01_R_Finger2" "v_weapon.Bip01_R_Hand" 3.799515 0.014956 0.039959 1.985354 1.299975 0.498648 0 0 0 0 0 0
$definebone "v_weapon.Bip01_R_Finger21" "v_weapon.Bip01_R_Finger2" 1.774876 -0.000002 0 -0.000002 1.448385 0.000002 0 0 0 0 0 0
$definebone "v_weapon.Bip01_R_Finger22" "v_weapon.Bip01_R_Finger21" 1.008841 -0.000002 0 -0.000002 1.448383 0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "v_weapon.Bip01_R_Finger22" 0.00577 -0.000261 0.233444 -0.000002 -0.000007 179.999978 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "v_weapon.Bip01_R_Finger21" 0.005777 -0.000113 0.233444 -0.000002 0 179.999978 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "v_weapon.Bip01_R_Finger2" 0.005779 0.000027 0.233444 -0.000002 0.000002 179.999978 0 0 0 0 0 0
$definebone "v_weapon.Bip01_R_Finger3" "v_weapon.Bip01_R_Hand" 3.632769 0.05905 -0.757493 9.344708 2.459646 0.939023 0 0 0 0 0 0
$definebone "v_weapon.Bip01_R_Finger31" "v_weapon.Bip01_R_Finger3" 1.500139 0 0 -0.000006 1.448373 0.000003 0 0 0 0 0 0
$definebone "v_weapon.Bip01_R_Finger32" "v_weapon.Bip01_R_Finger31" 0.905661 -0.000002 0 -0.000005 1.44837 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "v_weapon.Bip01_R_Finger32" -0.024103 0.002743 0.232252 -0.000004 -0.000007 179.999978 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "v_weapon.Bip01_R_Finger31" -0.024168 0.002138 0.232252 -0.000005 -0.000009 179.999978 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "v_weapon.Bip01_R_Finger3" -0.024214 0.001526 0.232252 -0.000005 -0.000003 179.999978 0 0 0 0 0 0
$definebone "v_weapon.Bip01_R_Finger4" "v_weapon.Bip01_R_Hand" 3.323328 0.233746 -1.479073 18.57632 1.802642 1.857761 0 0 0 0 0 0
$definebone "v_weapon.Bip01_R_Finger41" "v_weapon.Bip01_R_Finger4" 0.963097 0.000006 0 -0.000012 1.448382 0.000003 0 0 0 0 0 0
$definebone "v_weapon.Bip01_R_Finger42" "v_weapon.Bip01_R_Finger41" 0.682894 0 0 -0.000006 1.448382 0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "v_weapon.Bip01_R_Finger42" 0 -0.000002 0 -0.000007 0 179.999978 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "v_weapon.Bip01_R_Finger41" 0 0.000002 0 -0.000012 0.000003 179.999978 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "v_weapon.Bip01_R_Finger4" -0.061132 0.005182 0.225312 -0.000007 0.000002 179.999978 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "v_weapon.Bip01_R_Hand" 0.208307 -0.493855 0.206971 1.092342 -0.313351 -173.603 0 0 0 0 0 0
$definebone "v_weapon.Bip01_R_ForeTwist" "v_weapon.Bip01_R_UpperArm" 11.576878 0 -0.000002 0.000003 -0.042 -0.391333 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "v_weapon.Bip01_R_ForeTwist" -1.737897 0.093261 -0.444616 -0.417795 -1.926973 0.342282 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Forearm" -11.57692 0.000057 -0.008526 -0.042045 -0.000345 0.391327 0 0 0 0 0 0
$definebone "v_weapon" "" 0 0 0 0 0.001776 0 0 0 0 0 0 0
$definebone "v_weapon.sg556_Parent" "v_weapon.Bip01_R_Hand" -3.219928 6.331688 8.898158 -0.525918 89.270204 102.256654 0 0 0 0 0 0
$definebone "v_weapon.sg556_Chamber" "v_weapon.sg556_Parent" -0.073058 3.873741 7.295827 -0.000005 0.000058 -0.000003 0 0 0 0 0 0
$definebone "v_weapon.sg556_Trigger" "v_weapon.sg556_Parent" -0.000001 1.669846 2.202711 -0.000005 0.000058 -0.000118 0 0 0 0 0 0
$definebone "v_weapon.sg556_Clip" "v_weapon.sg556_Parent" 0 -0.879918 5.86527 -0.000005 0.000058 -0.000003 0 0 0 0 0 0

$bonemerge "v_weapon.Bip01_Neck"
$bonemerge "v_weapon.Bip01_L_Clavicle"
$bonemerge "v_weapon.Bip01_L_UpperArm"
$bonemerge "v_weapon.Bip01_L_Forearm"
$bonemerge "v_weapon.Bip01_L_Hand"
$bonemerge "v_weapon.Bip01_L_Finger0"
$bonemerge "v_weapon.Bip01_L_Finger01"
$bonemerge "v_weapon.Bip01_L_Finger02"
$bonemerge "ValveBiped.Bip01_L_Finger02"
$bonemerge "ValveBiped.Bip01_L_Finger01"
$bonemerge "ValveBiped.Bip01_L_Finger0"
$bonemerge "v_weapon.Bip01_L_Finger1"
$bonemerge "v_weapon.Bip01_L_Finger11"
$bonemerge "v_weapon.Bip01_L_Finger12"
$bonemerge "ValveBiped.Bip01_L_Finger12"
$bonemerge "ValveBiped.Bip01_L_Finger11"
$bonemerge "ValveBiped.Bip01_L_Finger1"
$bonemerge "v_weapon.Bip01_L_Finger2"
$bonemerge "v_weapon.Bip01_L_Finger21"
$bonemerge "v_weapon.Bip01_L_Finger22"
$bonemerge "ValveBiped.Bip01_L_Finger22"
$bonemerge "ValveBiped.Bip01_L_Finger21"
$bonemerge "ValveBiped.Bip01_L_Finger2"
$bonemerge "v_weapon.Bip01_L_Finger3"
$bonemerge "v_weapon.Bip01_L_Finger31"
$bonemerge "v_weapon.Bip01_L_Finger32"
$bonemerge "ValveBiped.Bip01_L_Finger32"
$bonemerge "ValveBiped.Bip01_L_Finger31"
$bonemerge "ValveBiped.Bip01_L_Finger3"
$bonemerge "v_weapon.Bip01_L_Finger4"
$bonemerge "v_weapon.Bip01_L_Finger41"
$bonemerge "v_weapon.Bip01_L_Finger42"
$bonemerge "ValveBiped.Bip01_L_Finger42"
$bonemerge "ValveBiped.Bip01_L_Finger41"
$bonemerge "ValveBiped.Bip01_L_Finger4"
$bonemerge "ValveBiped.Bip01_L_Hand"
$bonemerge "v_weapon.Bip01_L_ForeTwist"
$bonemerge "ValveBiped.Bip01_L_Forearm"
$bonemerge "ValveBiped.Bip01_L_UpperArm"
$bonemerge "v_weapon.Bip01_R_Clavicle"
$bonemerge "v_weapon.Bip01_R_UpperArm"
$bonemerge "v_weapon.Bip01_R_Forearm"
$bonemerge "v_weapon.Bip01_R_Hand"
$bonemerge "v_weapon.Bip01_R_Finger0"
$bonemerge "v_weapon.Bip01_R_Finger01"
$bonemerge "v_weapon.Bip01_R_Finger02"
$bonemerge "ValveBiped.Bip01_R_Finger02"
$bonemerge "ValveBiped.Bip01_R_Finger01"
$bonemerge "ValveBiped.Bip01_R_Finger0"
$bonemerge "v_weapon.Bip01_R_Finger1"
$bonemerge "v_weapon.Bip01_R_Finger11"
$bonemerge "v_weapon.Bip01_R_Finger12"
$bonemerge "ValveBiped.Bip01_R_Finger12"
$bonemerge "ValveBiped.Bip01_R_Finger11"
$bonemerge "ValveBiped.Bip01_R_Finger1"
$bonemerge "v_weapon.Bip01_R_Finger2"
$bonemerge "v_weapon.Bip01_R_Finger21"
$bonemerge "v_weapon.Bip01_R_Finger22"
$bonemerge "ValveBiped.Bip01_R_Finger22"
$bonemerge "ValveBiped.Bip01_R_Finger21"
$bonemerge "ValveBiped.Bip01_R_Finger2"
$bonemerge "v_weapon.Bip01_R_Finger3"
$bonemerge "v_weapon.Bip01_R_Finger31"
$bonemerge "v_weapon.Bip01_R_Finger32"
$bonemerge "ValveBiped.Bip01_R_Finger32"
$bonemerge "ValveBiped.Bip01_R_Finger31"
$bonemerge "ValveBiped.Bip01_R_Finger3"
$bonemerge "v_weapon.Bip01_R_Finger4"
$bonemerge "v_weapon.Bip01_R_Finger41"
$bonemerge "v_weapon.Bip01_R_Finger42"
$bonemerge "ValveBiped.Bip01_R_Finger42"
$bonemerge "ValveBiped.Bip01_R_Finger41"
$bonemerge "ValveBiped.Bip01_R_Finger4"
$bonemerge "ValveBiped.Bip01_R_Hand"
$bonemerge "v_weapon.Bip01_R_ForeTwist"
$bonemerge "ValveBiped.Bip01_R_Forearm"
$bonemerge "ValveBiped.Bip01_R_UpperArm"


$sectionframes 30 30

$sequence "idle" {
	"v_rif_galil_ar_anims\idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "reload" {
	"v_rif_galil_ar_anims\reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 9 "ARCCW_GO_GALIL_ARM.Clipout" }
	{ event 5004 29 "ARCCW_GO_GALIL_ARM.Clipin" }
	{ event 5004 58 "ARCCW_GO_GALIL_ARM.BoltBack" }
	{ event 5004 66 "ARCCW_GO_GALIL_ARM.BoltForward" }
	{ event AE_WPN_COMPLETE_RELOAD 31 "" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "reload_part" {
	"v_rif_galil_ar_anims\reload_part.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 9 "ARCCW_GO_GALIL_ARM.Clipout" }
	{ event 5004 29 "ARCCW_GO_GALIL_ARM.Clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "draw" {
	"v_rif_galil_ar_anims\draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "ARCCW_GO_GALIL_ARM.Draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "ready" {
	"v_rif_galil_ar_anims\ready.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "ARCCW_GO_GALIL_ARM.Draw" }
	{ event 5004 9 "ARCCW_GO_GALIL_ARM.BoltBack" }
	{ event 5004 17 "ARCCW_GO_GALIL_ARM.BoltForward" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "shoot1" {
	"v_rif_galil_ar_anims\shoot1.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	{ event 5001 0 "1" }
	{ event AE_CLIENT_EJECT_BRASS 0 "" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "lookat01" {
	"v_rif_galil_ar_anims\lookat01.smd"
	{ event AE_CL_SET_STATTRAK_GLOW 0 "1" }
	{ event AE_CL_SET_STATTRAK_GLOW 79 "0" }
	{ event AE_BEGIN_TAUNT_LOOP 78 "0.246153" }
	{ event 5004 2 "ARCCW_GO_GALIL_ARM.WeaponMove1" }
	{ event 5004 77 "ARCCW_GO_GALIL_ARM.WeaponMove2" }
	{ event 5004 112 "ARCCW_GO_GALIL_ARM.WeaponMove3" }
	fadein 0.3
	fadeout 0.3
	fps 30
}

$sequence "lookat01_prepare" {
	"v_rif_galil_ar_anims\lookat01_prepare.smd"
	fadein 0.2
	fadeout 0.2
	fps 45
}

$sequence "lookat01_loop" {
	"v_rif_galil_ar_anims\lookat01_loop.smd"
	fadein 0.2
	fadeout 0.2
	fps 15
}

$sequence "ironsight_fidget" {
	"v_rif_galil_ar_anims\ironsight_fidget.smd"
	activity "ACT_VM_FIDGET" 1
	fadein 0.1
	fadeout 1
	fps 40
}

$sequence "ironsight_fire" {
	"v_rif_galil_ar_anims\ironsight_fire.smd"
	activity "ACT_VM_SECONDARYATTACK" 1
	{ event 5001 0 "1" }
	{ event AE_CLIENT_EJECT_BRASS 0 "" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$keyvalues
{
	qc_path 
	{
		"value"		"models\weapons\v_models\rif_sg556\v_sg556.qc"
	}
	qc_path 
	{
		"value"		"i:\modelsmdl\extracttest31\vgalil\v_rif_sg556.qc"
	}
}


$collisionmodel "body.smd"
{
	$mass 5
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "

}

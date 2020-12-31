att.PrintName = "18-Round 9mm USP"
att.Icon = Material("entities/acwatt_go_usp_mag_regular.png", "mips smooth")
att.Description = "Converts the pistol into 9mm, allowing for higher mag capacity and more controlability."
att.Desc_Pros = {
    "pro.magcap"
}
att.Desc_Cons = {
}
att.SortOrder = 2.5
att.AutoStats = true
att.Slot = "go_usp_mag"

att.ActivateElements = {"9mm"}
att.Override_ClipSize = 18
att.Mult_Damage = 0.7
att.Mult_DamageMin = 0.9
att.Mult_Recoil = 0.8
att.Mult_RPM = 1.15
att.Mult_ShootPitch = 0.85

att.Hook_GetShootSound = function(wep, snd)
    if snd == wep.ShootSound or snd == wep.FirstShootSound then return "arccw_go/hkp2000/hkp2000-1.wav" end
end
att.Hook_GetDistantShootSound = function(wep, sound)
    if snd == wep.DistantShootSound then return "arccw_go/hkp2000/hkp2000-1-distant.wav" end
end
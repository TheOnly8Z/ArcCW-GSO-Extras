att.PrintName = "24-Round 9mm P250"
att.Icon = Material("entities/acwatt_go_p250_mag_21.png", "mips smooth")
att.Description = "Extended magazine for the 9mm conversion."
att.Desc_Pros = {
    "pro.magcap"
}
att.Desc_Cons = {
}
att.SortOrder = 3
att.AutoStats = true
att.Slot = "go_p250_mag"
att.Override_Trivia_Calibre = "9x19mm Parabellum"

att.ActivateElements = {"go_p250_mag_21"}
att.Override_ClipSize_Priority = 2
att.Override_ClipSize = 24
att.Mult_SpeedMult = 0.975
att.Mult_SightTime = 1.1
att.Mult_ReloadTime = 1.2

att.Mult_RPM = 1.2
att.Mult_Damage = 0.7
att.Mult_DamageMin = 0.9
att.Mult_Recoil = 0.5
att.Mult_RecoilSide = 0.7
--att.Mult_ShootPitch = 1.1

att.Hook_GetShootSound = function(wep, snd)
    if snd == wep.ShootSound or snd == wep.FirstShootSound then return "arccw_go/hkp2000/hkp2000-1.wav" end
end
--[[att.Hook_GetDistantShootSound = function(wep, sound)
    if snd == wep.DistantShootSound then return "arccw_go/usp/usp_unsil-1-distant.wav" end
end]]
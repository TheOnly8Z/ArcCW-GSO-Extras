att.PrintName = "13-Round .40 S&W P250"
att.Icon = Material("entities/acwatt_go_p250_mag_regular.png", "mips smooth")
att.Description = "Barrel and magazine kit converting to .40 S&W. It performs slightly better at range than the .357 SIG."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.SortOrder = 4.5
att.AutoStats = true
att.Slot = "go_p250_mag"
att.Override_Trivia_Calibre = ".40 S&W"

att.Mult_Damage = 0.9
att.Mult_DamageMin = 1.1
att.Mult_Range = 1.2
--att.Mult_ShootPitch = 1.1

att.Hook_GetShootSound = function(wep, snd)
    if snd == wep.ShootSound or snd == wep.FirstShootSound then return "arccw_go/usp/usp_unsilenced_01.wav" end
end
--[[att.Hook_GetDistantShootSound = function(wep, sound)
    if snd == wep.DistantShootSound then return "arccw_go/usp/usp_unsil-1-distant.wav" end
end]]
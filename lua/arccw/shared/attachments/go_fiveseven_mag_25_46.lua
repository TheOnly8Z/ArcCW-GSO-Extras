att.PrintName = "25-Round 4.6mm HK"
att.Icon = Material("entities/acwatt_go_fiveseven_mag_regular.png", "mips smooth")
att.Description = "A curious conversion kit that makes the weapon fire 4.6x30mm cartridges. While both are thin PDW ammunition, the 4.6mm is slightly worse at long range and can load more in the magazine."
att.Desc_Pros = {
    "pro.magcap"
}
att.Desc_Cons = {
}
att.SortOrder = -10
att.AutoStats = true
att.Slot = "go_fiveseven_mag"
att.Override_Trivia_Calibre = "4.6x30mm"

att.Override_ClipSize = 25

att.Mult_Damage = 1.05
att.Mult_DamageMin = 0.85
att.Mult_Recoil = 0.95
att.Mult_RPM = 1.1

att.Hook_GetShootSound = function(wep, snd)
    if snd == wep.ShootSound or snd == wep.FirstShootSound then return "arccw_go/fiveseven/fiveseven_46.wav" end
end

--[[att.Hook_GetDistantShootSound = function(wep, snd)
    if snd == wep.DistantShootSound then return "arccw_go/mp7/mp7-1-distant.wav" end
end]]

att.Hook_NameChange = function(wep, name)
    return "Four-siX"
end
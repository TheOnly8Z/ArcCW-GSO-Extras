att.PrintName = "40-Round 4.6mm HK"
att.Icon = Material("entities/acwatt_go_fiveseven_mag_30.png", "mips smooth")
att.Description = "Extended magazine loaded with 4.6x30mm cartridges. It's almost like a baby MP7."
att.Desc_Pros = {
    "pro.magcap"
}
att.Desc_Cons = {
}
att.SortOrder = -12
att.AutoStats = true
att.Slot = "go_fiveseven_mag"
att.Override_Trivia_Calibre = "4.6x30mm"

att.ActivateElements = {"go_fiveseven_mag_30"}

att.Override_ClipSize = 40
att.Mult_ReloadTime = 1.25
att.Mult_SightTime = 1.15
att.Mult_SpeedMult = 0.95

att.Mult_Damage = 1.05
att.Mult_DamageMin = 0.85
att.Mult_Recoil = 0.95
att.Mult_RPM = 1.05

att.Hook_GetShootSound = function(wep, snd)
    if snd == wep.ShootSound or snd == wep.FirstShootSound then return "arccw_go/mp7/mp7_01.wav" end
end

att.Hook_GetDistantShootSound = function(wep, snd)
    if snd == wep.DistantShootSound then return "arccw_go/mp7/mp7-1-distant.wav" end
end

att.Hook_NameChange = function(wep, name)
    return "Four-siX"
end
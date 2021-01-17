att.PrintName = "15-Round 9mm P250"
att.Icon = Material("entities/acwatt_go_p250_mag_regular.png", "mips smooth")
att.Description = "Barrel and magazine kit converting to 9mm. While it has less stopping power, more rounds can be loaded."
att.Desc_Pros = {
    "pro.magcap"
}
att.Desc_Cons = {
}
att.SortOrder = 3.5
att.AutoStats = true
att.Slot = "go_p250_mag"
att.Override_Trivia_Calibre = "9x19mm Parabellum"
att.Hook_GetCapacity = function(wep, cap)
    if wep.Attachments[3].Installed == "go_p250_slide_short" then
        return 12
    else
        return 15
    end
end

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
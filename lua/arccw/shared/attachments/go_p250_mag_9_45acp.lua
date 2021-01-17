att.PrintName = "9-Round .45 ACP P250"
att.Icon = Material("entities/acwatt_go_p250_mag_regular.png", "mips smooth")
att.Description = "Barrel and magazine kit converting to .45 ACP. It is more powerful up close, but loads much less due to its size."
att.Desc_Pros = {
}
att.Desc_Cons = {
    "con.magcap"
}
att.SortOrder = 5.5
att.AutoStats = true
att.Slot = "go_p250_mag"
att.Override_Trivia_Calibre = ".45 ACP"
att.Hook_GetCapacity = function(wep, cap)
    if wep.Attachments[3].Installed == "go_p250_slide_short" then
        return 6
    else
        return 9
    end
end

att.Mult_Damage = 1.1
att.Mult_DamageMin = 0.9
att.Mult_Recoil = 0.9

att.Hook_GetShootSound = function(wep, snd)
    if snd == wep.ShootSound or snd == wep.FirstShootSound then return "arccw_go/usp/usp_unsilenced_01.wav" end
end
--[[att.Hook_GetDistantShootSound = function(wep, sound)
    if snd == wep.DistantShootSound then return "arccw_go/usp/usp_unsil-1-distant.wav" end
end]]
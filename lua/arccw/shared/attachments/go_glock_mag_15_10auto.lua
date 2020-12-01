att.PrintName = "15-Round 10mm G20"
att.Icon = Material("entities/acwatt_go_glock_mag_regular.png", "mips smooth")
att.Description = "Convert the weapon to the 10mm Glock 20. It is stronger than 9mm at all ranges, but kicks quite harder."
att.Desc_Pros = {
}
att.Desc_Cons = {
    "con.magcap",
    "con.nog18"
}
att.SortOrder = 5.5
att.AutoStats = true
att.Slot = "go_glock_mag"
att.GivesFlags = {"noauto"}
att.ExcludeFlags = {"go_glock_slide_auto"}
att.Override_Trivia_Calibre = "10mm Auto"
att.Hook_GetCapacity = function(wep, cap)
    if wep.Attachments[3].Installed == "go_glock_slide_short" then
        return 12
    else
        return 15
    end
end
att.Hook_NameChange = function(wep, name)
    if wep.Attachments[3].Installed == "go_glock_slide_short" then
        return "Glock 29"
    elseif wep.Attachments[3].Installed == "go_glock_slide_long" then
        return "Glock 20L"
    else
        return "Glock 20"
    end
end

att.Mult_RPM = 0.8
att.Mult_Damage = 1.15
att.Mult_DamageMin = 1.15
att.Mult_Recoil = 1.2
att.Mult_ShootPitch = 1.1

att.Hook_GetShootSound = function(wep, snd)
    if snd == wep.ShootSound then return "arccw_go/p250/p250_01.wav" end
end
att.Hook_GetDistantShootSound = function(wep, sound)
    if snd == wep.DistantShootSound then return "arccw_go/p250/p250-1-distant.wav" end
end
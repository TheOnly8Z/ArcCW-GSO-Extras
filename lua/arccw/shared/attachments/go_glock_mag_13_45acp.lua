att.PrintName = "13-Round .45ACP G21"
att.Icon = Material("entities/acwatt_go_glock_mag_regular.png", "mips smooth")
att.Description = "Convert the weapon to the Glock 21, firing the venerable .45 ACP. It is more powerful than 10mm Auto up close, but loads even less rounds due to its size."
att.Desc_Pros = {
}
att.Desc_Cons = {
    "con.magcap",
    "con.nog18"
}
att.SortOrder = 4.5
att.AutoStats = true
att.Slot = "go_glock_mag"
att.GivesFlags = {"noauto"}
att.ExcludeFlags = {"go_glock_slide_auto"}
att.Override_Trivia_Calibre = ".45 ACP"
att.Hook_GetCapacity = function(wep, cap)
    if wep.Attachments[3].Installed == "go_glock_slide_short" then
        return 10
    else
        return 13
    end
end
att.Hook_NameChange = function(wep, name)
    if wep.Attachments[3].Installed == "go_glock_slide_short" then
        return "Glock 30"
    elseif wep.Attachments[3].Installed == "go_glock_slide_long" then
        return "Glock 21L"
    else
        return "Glock 21"
    end
end

att.Mult_RPM = 0.9
att.Mult_Damage = 1.3
att.Mult_DamageMin = 1.1
att.Mult_Recoil = 1.3
att.Mult_ShootPitch = 1.1

att.Hook_GetShootSound = function(wep, snd)
    if snd == wep.ShootSound or snd == wep.FirstShootSound then return "arccw_go/usp/usp_unsilenced_02.wav" end
end
att.Hook_GetDistantShootSound = function(wep, sound)
    if snd == wep.DistantShootSound then return "arccw_go/usp/usp_unsil-1-distant.wav" end
end
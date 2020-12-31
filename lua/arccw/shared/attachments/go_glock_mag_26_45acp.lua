att.PrintName = "26-Round .45ACP G21"
att.Icon = Material("entities/acwatt_go_glock_mag_28.png", "mips smooth")
att.Description = "Extended .45 ACP magazine for the Glock 21. Heavy, but may be worth the extra ammo."
att.Desc_Pros = {
    "pro.magcap"
}
att.Desc_Cons = {
    "con.nog18"
}
att.SortOrder = 4
att.AutoStats = true
att.Slot = "go_glock_mag"
att.GivesFlags = {"noauto"}
att.ExcludeFlags = {"go_glock_slide_auto"}
att.Override_Trivia_Calibre = ".45 ACP"
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

att.ActivateElements = {"go_glock_mag_28"}
att.Override_ClipSize = 26
att.Mult_MoveSpeed = 0.95
att.Mult_SightTime = 1.15
att.Mult_ReloadTime = 1.25

att.Hook_SelectReloadAnimation = function(wep, anim)
    if anim == "reload" then
        return "reload_long"
    elseif anim == "reload_empty" then
        return "reload_long_empty"
    end
end

att.Hook_GetShootSound = function(wep, snd)
    if snd == wep.ShootSound or snd == wep.FirstShootSound then return "arccw_go/usp/usp_unsilenced_02.wav" end
end
att.Hook_GetDistantShootSound = function(wep, sound)
    if snd == wep.DistantShootSound then return "arccw_go/usp/usp_unsil-1-distant.wav" end
end
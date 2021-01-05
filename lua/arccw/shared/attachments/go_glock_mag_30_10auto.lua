att.PrintName = "30-Round 10mm G20"
att.Icon = Material("entities/acwatt_go_glock_mag_28.png", "mips smooth")
att.Description = "Extended 10mm magazine for the Glock 20. Heavy, but may be worth the extra ammo."
att.Desc_Pros = {
    "pro.magcap"
}
att.Desc_Cons = {
    "con.nog18"
}
att.SortOrder = 5
att.AutoStats = true
att.Slot = "go_glock_mag"
att.GivesFlags = {"noauto"}
att.ExcludeFlags = {"go_glock_slide_auto"}
att.Override_Trivia_Calibre = "10mm Auto"
att.Hook_NameChange = function(wep, name)
    if wep.Attachments[3].Installed == "go_glock_slide_short" then
        return "Glock 29"
    elseif wep.Attachments[3].Installed == "go_glock_slide_long" then
        return "Glock 20L"
    else
        return "Glock 20"
    end
end

att.Mult_RPM = 0.7
att.Mult_Damage = 1.2
att.Mult_DamageMin = 1.2
att.Mult_Recoil = 1.5
--att.Mult_ShootPitch = 0.95

att.ActivateElements = {"go_glock_mag_28"}
att.Override_ClipSize = 30
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
    if snd == wep.ShootSound or snd == wep.FirstShootSound then return "arccw_go/glock18/glock_10.wav" end
end
--[[att.Hook_GetDistantShootSound = function(wep, sound)
    if snd == wep.DistantShootSound then return "arccw_go/p250/p250-1-distant.wav" end
end]]
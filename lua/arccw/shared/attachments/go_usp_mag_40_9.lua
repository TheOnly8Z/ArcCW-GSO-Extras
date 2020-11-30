att.PrintName = "40-Round 9mm USP"
att.Icon = Material("entities/acwatt_go_usp_mag_30.png", "mips smooth")
att.Description = "Extended magazine for the 9mm USP conversion. Heavy, but may be worth the extra ammo."
att.Desc_Pros = {
    "pro.magcap"
}
att.Desc_Cons = {
}
att.SortOrder = 2
att.AutoStats = true
att.Slot = "go_usp_mag"

att.ActivateElements = {"9mm", "go_usp_mag_30"}
att.Override_ClipSize = 40
att.Mult_Damage = 0.7
att.Mult_DamageMin = 0.9
att.Mult_Recoil = 0.8
att.Mult_RPM = 1.15
att.Mult_ShootPitch = 0.85
att.Hook_GetShootSound = function(wep, sound)
    return "arccw_go/hkp2000/hkp2000-1.wav"
end
att.Hook_GetDistantShootSound = function(wep, sound)
    return "arccw_go/hkp2000/hkp2000-1-distant.wav"
end

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
    if snd == wep.ShootSound then return "arccw_go/hkp2000/hkp2000-1.wav" end
end
att.Hook_GetDistantShootSound = function(wep, sound)
    if snd == wep.DistantShootSound then return "arccw_go/hkp2000/hkp2000-1-distant.wav" end
end
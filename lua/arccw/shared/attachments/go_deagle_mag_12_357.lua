att.PrintName = "12-Round .357 Deagle"
att.Icon = Material("entities/acwatt_go_deagle_mag_9.png", "mips smooth")
att.Description = "Extended magazine for the .357 Magnum conversion. If onedeag doesn't work, try twelvedeag."
att.Desc_Pros = {
    "pro.magcap"
}
att.Desc_Cons = {
}
att.SortOrder = 4
att.AutoStats = true
att.Slot = "go_deagle_mag"
att.ActivateElements = {"go_deagle_mag_9"}
att.Override_Trivia_Calibre = ".357 Magnum"

att.Override_ClipSize = 12
att.Mult_Damage = 0.8
att.Mult_DamageMin = 0.8
att.Mult_Recoil = 0.6
att.Mult_VisualRecoilMult = 0.6

att.Mult_SpeedMult = 0.95
att.Mult_SightTime = 1.15
att.Mult_ReloadTime = 1.25

att.Hook_SelectReloadAnimation = function(wep, anim)
    if anim == "reload" then
        return "reload_long"
    elseif anim == "reload_empty" then
        return "reload_long_empty"
    end
end
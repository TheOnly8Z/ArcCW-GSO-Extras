att.PrintName = "10-Round .44 Deagle"
att.Icon = Material("entities/acwatt_go_deagle_mag_9.png", "mips smooth")
att.Description = "Extended magazine for the .44 Magnum conversion. Heavier, but gives even more ammo per magazine."
att.Desc_Pros = {
    "pro.magcap"
}
att.Desc_Cons = {
}
att.SortOrder = 5
att.AutoStats = true
att.Slot = "go_deagle_mag"
att.ActivateElements = {"go_deagle_mag_9"}
att.Override_Trivia_Calibre = ".44 Magnum"

att.Override_ClipSize = 10
att.Mult_Damage = 0.9
att.Mult_DamageMin = 0.9
att.Mult_Recoil = 0.8

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
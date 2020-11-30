att.PrintName = "30-Round 5.56mm USGI"
att.Icon = Material("entities/acwatt_go_g3_mag_30_556.png", "mips smooth")
att.Description = "Standard-sized magazine with a minor decrease in handling."
att.Desc_Pros = {
    "pro.magcap"
}
att.Desc_Cons = {
}
att.SortOrder = 20
att.AutoStats = true
att.Slot = "go_m16a2_mag"

att.Mult_SightTime = 1.1
att.Override_ClipSize = 30
att.Mult_ReloadTime = 1.05

att.Hook_SelectReloadAnimation = function(wep, anim)
    if anim == "reload_smallmag" then
        return "reload"
    elseif anim == "reload_smallmag_empty" then
        return "reload_empty"
    end
end
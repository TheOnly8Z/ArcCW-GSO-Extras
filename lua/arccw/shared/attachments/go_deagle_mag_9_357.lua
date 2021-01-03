att.PrintName = "9-Round .357 Deagle"
att.Icon = Material("entities/acwatt_go_deagle_mag_regular.png", "mips smooth")
att.Description = "Barrel and magazine conversion that uses the smaller and less powerful .357 Magnum. Because of the smaller size, it can fit 2 more rounds in the same magazine."
att.Desc_Pros = {
    "pro.magcap"
}
att.Desc_Cons = {
}
att.SortOrder = 4.5
att.AutoStats = true
att.Slot = "go_deagle_mag"
att.Override_Trivia_Calibre = ".357 Magnum"

att.Override_ClipSize = 9
att.Mult_Damage = 0.8
att.Mult_DamageMin = 0.8
att.Mult_Recoil = 0.6
att.Mult_VisualRecoilMult = 0.6

att.Hook_GetShootSound = function(wep, snd)
    if snd == wep.ShootSound or snd == wep.FirstShootSound then return "arccw_go/deagle/deagle_357.wav" end
end
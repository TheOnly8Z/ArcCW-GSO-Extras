att.PrintName = "8-Round .44 Deagle"
att.Icon = Material("entities/acwatt_go_deagle_mag_regular.png", "mips smooth")
att.Description = "Barrel and magazine conversion that uses the relatively less powerful .44 Magnum. It can squeeze one more round in the same magazine."
att.Desc_Pros = {
    "pro.magcap"
}
att.Desc_Cons = {
}
att.SortOrder = 5.5
att.AutoStats = true
att.Slot = "go_deagle_mag"
att.Override_Trivia_Calibre = ".44 Magnum"

att.Override_ClipSize = 8
att.Mult_Damage = 0.9
att.Mult_DamageMin = 0.9
att.Mult_Recoil = 0.8
att.Mult_VisualRecoilMult = 0.8

att.Hook_GetShootSound = function(wep, snd)
    if snd == wep.ShootSound or snd == wep.FirstShootSound then return "arccw_go/deagle/deagle_44.wav" end
end
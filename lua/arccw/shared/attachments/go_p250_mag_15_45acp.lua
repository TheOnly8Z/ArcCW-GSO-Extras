att.PrintName = "15-Round .45 ACP P250"
att.Icon = Material("entities/acwatt_go_p250_mag_21.png", "mips smooth")
att.Description = "Extended magazine for the .45 ACP conversion."
att.Desc_Pros = {
    "pro.magcap"
}
att.Desc_Cons = {
}
att.SortOrder = 5
att.AutoStats = true
att.Slot = "go_p250_mag"
att.Override_Trivia_Calibre = ".45 ACP"

att.ActivateElements = {"go_p250_mag_21"}
att.Override_ClipSize_Priority = 2
att.Override_ClipSize = 15
att.Mult_SpeedMult = 0.975
att.Mult_SightTime = 1.1
att.Mult_ReloadTime = 1.2

att.Mult_Damage = 1.1
att.Mult_DamageMin = 0.9
att.Mult_Recoil = 0.9


att.Hook_GetShootSound = function(wep, snd)
    if snd == wep.ShootSound or snd == wep.FirstShootSound then return "arccw_go/usp/usp_unsilenced_01.wav" end
end
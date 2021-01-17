att.PrintName = "21-Round .40 S&W P250"
att.Icon = Material("entities/acwatt_go_p250_mag_21.png", "mips smooth")
att.Description = "Extended magazine for the .40 S&W conversion."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.SortOrder = 4
att.AutoStats = true
att.Slot = "go_p250_mag"
att.Override_Trivia_Calibre = ".40 S&W"

att.ActivateElements = {"go_p250_mag_21"}
att.Override_ClipSize_Priority = 2
att.Override_ClipSize = 21
att.Mult_SpeedMult = 0.975
att.Mult_SightTime = 1.1
att.Mult_ReloadTime = 1.2

att.Mult_Damage = 0.9
att.Mult_DamageMin = 1.1
att.Mult_Range = 1.2

att.Hook_GetShootSound = function(wep, snd)
    if snd == wep.ShootSound or snd == wep.FirstShootSound then return "arccw_go/usp/usp_unsilenced_01.wav" end
end
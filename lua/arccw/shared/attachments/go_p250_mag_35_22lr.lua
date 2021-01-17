att.PrintName = "35-Round .22 LR P250"
att.Icon = Material("entities/acwatt_go_p250_mag_21.png", "mips smooth")
att.Description = "Extended magazine for the .22 LR conversion."
att.Desc_Pros = {
    "pro.magcap"
}
att.Desc_Cons = {
}
att.SortOrder = 2
att.AutoStats = true
att.Slot = "go_p250_mag"
att.Override_Trivia_Calibre = ".22 LR"

att.ActivateElements = {"go_p250_mag_21"}
att.Override_ClipSize_Priority = 2
att.Override_ClipSize = 35
att.Mult_SpeedMult = 0.975
att.Mult_SightTime = 1.1
att.Mult_ReloadTime = 1.2

att.Mult_RPM = 1.4
att.Mult_Damage = 0.35
att.Mult_DamageMin = 0.35
att.Mult_Recoil = 0.25
att.Mult_RecoilSide = 0.25
att.Mult_ShootPitch = 0.9
att.Mult_AccuracyMOA = 0.5

att.Hook_GetShootSound = function(wep, snd)
    if snd == wep.ShootSound or snd == wep.FirstShootSound then return "arccw_go/22lr.wav" end
end
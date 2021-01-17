att.PrintName = "20-Round .22 LR P250"
att.Icon = Material("entities/acwatt_go_p250_mag_regular.png", "mips smooth")
att.Description = "Barrel and magazine kit converting to .22 LR. As a plinking cartridge, it does very little damage, but simplified internals allows for better performance."
att.Desc_Pros = {
    "pro.magcap"
}
att.Desc_Cons = {
}
att.SortOrder = 2.5
att.AutoStats = true
att.Slot = "go_p250_mag"
att.Override_Trivia_Calibre = ".22 Long Rifle"
att.Override_Trivia_Mechanism = "Blowback"

att.Hook_GetCapacity = function(wep, cap)
    if wep.Attachments[3].Installed == "go_p250_slide_short" then
        return 12
    else
        return 20
    end
end

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
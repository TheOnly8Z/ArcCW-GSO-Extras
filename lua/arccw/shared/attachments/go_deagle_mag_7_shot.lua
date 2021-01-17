att.PrintName = "7-Round 40ga Deagle"
att.Icon = Material("entities/acwatt_go_deagle_mag_regular.png", "mips smooth")
att.Description = "A curious barrel and magazine that fits custom 40 Gauge shotshells, which aren't too powerful because of the tiny bore diameter. Probably someone's range toy."
att.Desc_Pros = {
    "pro.num.8"
}
att.Desc_Cons = {
}
att.SortOrder = 2.5
att.AutoStats = true
att.Slot = "go_deagle_mag"
att.Override_Trivia_Calibre = "40 Gauge"
att.Override_Ammo = "buckshot"

att.Override_Num = 8
att.Mult_AccuracyMOA = 3
att.Mult_Damage = 1.2
att.Mult_DamageMin = 0.7
att.Mult_Recoil = 0.7
att.Mult_RPM = 0.8
att.Mult_Range = 0.75

att.Override_IsShotgun = true
att.Override_ShellModel = "models/shells/shell_12gauge.mdl"
att.Override_ShellScale = 0.8
att.Override_ShellSounds = ArcCW.ShotgunShellSoundsTable

att.Hook_AddShootSound = function(wep)
    if wep:GetBuff_Override("Silencer") then
        wep:MyEmitSound("arccw_go/m590_suppressed_fp.wav", 90, 100, 0.4, CHAN_WEAPON - 1)
    else
        wep:MyEmitSound("arccw_go/sawedoff/sawedoff-1.wav", 90, 100, 0.4, CHAN_WEAPON - 1)
    end
end
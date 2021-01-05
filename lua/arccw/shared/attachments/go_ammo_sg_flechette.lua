att.PrintName = "Flechette Shells"
att.Icon = Material("entities/acwatt_go_ammo_sg_flechette.png", "smooth mips")
att.Description = "Thin, sharp pointed projectiles provide better performance over range and superior penetration."
att.Desc_Pros = {
    "pro.pen.12"
}
att.Desc_Cons = {
}
att.Slot = "go_ammo"

att.AutoStats = true

att.Mult_Damage = 0.7
att.Mult_DamageMin = 1
att.Mult_Range = 2
att.Mult_AccuracyMOA = 0.5
att.Mult_MoveDispersion = 1.5
att.Override_Penetration = 12

att.Hook_Compatible = function(wep)
    if !wep:GetIsShotgun() then return false end
end
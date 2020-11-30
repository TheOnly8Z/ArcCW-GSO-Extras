att.PrintName = "API Rounds"
att.Icon = Material("entities/acwatt_go_ammo_api.png")
att.Description = "Armor piercing, incendiary rounds that penetrates further, punches harder and lights targets on fire. It is, however, less accurate."
att.Desc_Pros = {
    "pro.ignite"
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "go_ammo"

att.Mult_DamageMin = 1.2
att.Mult_Penetration = 2
att.Mult_AccuracyMOA = 1.5
att.Mult_Recoil = 1.2

att.Override_DamageType = DMG_BURN

att.Hook_Compatible = function(wep)
    if wep:GetIsShotgun() then return false end
end
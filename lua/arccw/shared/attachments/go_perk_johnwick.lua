att.PrintName = "John Wick"
att.Icon = Material("entities/acwatt_go_perk_johnwick.png", "mips smooth")
att.Description = "u kill my dog"
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = false
att.Slot = "go_perk"
att.JohnWick = true

att.Ignore = false
att.NoRandom = true

att.Mult_MeleeDamage = 2
att.Mult_MeleeAttackTime = 0.5
att.Mult_MeleeTime = 0.5
att.Mult_CycleTime = 0.5
att.Mult_ReloadTime = 0.75
att.Mult_MoveDispersion = 0.1
att.Mult_SightedSpeedMult = 2

att.Hook_BulletHit = function(wep, data)
    if CLIENT then return end

    if data.tr.HitGroup == HITGROUP_HEAD then
        data.damage = data.damage * 3
    end
end
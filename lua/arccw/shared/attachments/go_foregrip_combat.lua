att.PrintName = "Combat Grip"
att.Icon = Material("entities/acwatt_go_foregrip_combat.png", "mips smooth")
att.Description = "Wow it is folding"

att.SortOrder = 1

att.Desc_Pros = {
    "-20% Recoil in sights",
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "foregrip"

att.LHIK = true

att.Model = "models/weapons/arccw_go/atts/foregrip_combat.mdl"
att.ModelOffset = Vector(0.5, 0, 0)

att.Mult_RecoilSide = 1.15

att.Mult_DrawTime = 0.75
att.Mult_SightTime = 1.05

att.Mult_MoveSpeed = 0.95

att.Override_HoldtypeActive = "smg"

att.Hook_ModifyRecoil = function(wep)
    local fuckyeah = 1 - ( 0.20 * ( 1 - wep:GetSightDelta() ) )

    return {
        Recoil = fuckyeah
    }
end
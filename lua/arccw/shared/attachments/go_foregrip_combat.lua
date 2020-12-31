att.PrintName = "Combat Foregrip"
att.Icon = Material("entities/acwatt_go_foregrip_combat.png", "mips smooth")
att.Description = "Light folding grip. Improves recoil control when aiming."

att.SortOrder = 1

att.Desc_Pros = {
    "pro.foregrip_combat",
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "foregrip"

att.LHIK = true

att.Model = "models/weapons/arccw_go/atts/foregrip_combat.mdl"
att.ModelOffset = Vector(0.5, 0, 0)

att.Mult_RecoilSide = 1.15
att.Mult_SightTime = 1.05
att.Mult_MoveSpeed = 0.95
att.Mult_DrawTime = 0.75
att.Mult_HolsterTime = 0.75

att.Override_HoldtypeActive = "smg"

att.Hook_ModifyRecoil = function(wep)
    local fuckyeah = 1 - ( 0.25 * ( 1 - wep:GetSightDelta() ) )

    return {
        Recoil = fuckyeah
    }
end
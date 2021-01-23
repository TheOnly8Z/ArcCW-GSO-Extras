att.PrintName = "SAW Stock"
att.Icon = Material("entities/acwatt_go_stock_m249.png", "mips smooth")
att.Description = "Long and solid stock that can be held in the hip easily. Allows for controllable hipfiring, but is really heavy."
att.Desc_Pros = {
    "pro.stock_m249"
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "go_stock"

att.Model = "models/weapons/arccw_go/atts/stock_m249.mdl"
att.ModelOffset = Vector(0, 0, -0.3)

att.ActivateElements = {"go_stock_none"}

att.Mult_SightedSpeedMult = 0.5
att.Mult_HipDispersion = 0.8
att.Mult_SightTime = 1.5

att.Hook_ModifyRecoil = function(wep, tbl)
    tbl.Recoil = tbl.Recoil * (0.7 + ( 0.3 * ( 1 - wep:GetSightDelta() ) ))
end
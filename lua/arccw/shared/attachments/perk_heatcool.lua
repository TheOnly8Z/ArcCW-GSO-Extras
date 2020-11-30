att.PrintName = "Cool Head"
att.Icon = Material("entities/acwatt_perk_heatcool.png", "smooth mips")
att.Description = "Stay cool! Heat will dissipate quicker and sooner."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Slot = {"perk", "go_perk"}

att.NotForNPC = true

att.SortOrder = 1

att.AutoStats = true
att.Mult_HeatDelayTime = 0.7
att.Mult_HeatDissipation = 1.5

att.Hook_Compatible = function(wep)
    if !(wep.Jamming or wep:GetBuff_Override("Override_Jamming")) then return false end
end
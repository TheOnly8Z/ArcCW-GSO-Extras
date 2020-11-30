att.PrintName = "Air Time"
att.Icon = Material("entities/acwatt_perk_heatair.png", "smooth mips")
att.Description = "Let it air! Heat will dissipate almost instantly, but slower and at a lower capacity."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Slot = {"perk", "go_perk"}

att.NotForNPC = true

att.SortOrder = 1

att.AutoStats = true
att.Mult_HeatDelayTime = 0.15
att.Mult_HeatDissipation = 0.5
att.Mult_HeatCapacity = 0.3

att.Hook_Compatible = function(wep)
    if !(wep.Jamming or wep:GetBuff_Override("Override_Jamming")) then return false end
end
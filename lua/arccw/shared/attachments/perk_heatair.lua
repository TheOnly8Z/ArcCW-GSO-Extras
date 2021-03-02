att.PrintName = "Air Time"
att.Icon = Material("entities/acwatt_perk_heatair.png", "smooth mips")
att.Description = "Let it air! Heat will dissipate almost instantly, but slower. In addition, heat is vented from the gun and converted back into gas, increasing the cyclic rate."
att.Desc_Pros = {
    "con.gsoe.heat_fast"
}
att.Desc_Cons = {
}
att.Slot = {"perk", "go_perk"}

att.NotForNPC = true

att.SortOrder = 1

att.AutoStats = true
att.Mult_HeatDelayTime = 0.15
att.Mult_HeatDissipation = 0.5
att.Mult_HeatCapacity = 0.5

att.Hook_Compatible = function(wep)
    if !(wep.Jamming or wep:GetBuff_Override("Override_Jamming")) then return false end
end

att.M_Hook_Mult_RPM = function(wep, data)
	data.mult = (1 + (wep:GetHeat()/wep:GetMaxHeat())*1/2 )
end
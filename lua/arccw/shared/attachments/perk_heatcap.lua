att.PrintName = "Man On Fire"
att.Icon = Material("entities/acwatt_perk_heatcap.png", "smooth mips")
att.Description = "Handle the heat! Heat capacity and disspiation rate is boosted, but heat reduces the cyclic rate."
att.Desc_Pros = {}
att.Desc_Cons = {} -- "con.gsoe.heat_slow"
att.Slot = {"perk", "go_perk"}

att.NotForNPC = true

att.SortOrder = 1

att.AutoStats = true
att.Mult_HeatCapacity = 1.5
att.Mult_HeatDissipation = 1.5
--att.Mult_FixTime = 0.5
--att.Override_HeatFix = true

att.Hook_Compatible = function(wep)
    if !(wep.Jamming or wep:GetBuff_Override("Override_Jamming")) then return false end
end

--[[]
att.M_Hook_Mult_RPM = function(wep, data)
    data.mult = (data.mult - (wep:GetHeat() / wep:GetMaxHeat()) * 0.25 )
end
]]
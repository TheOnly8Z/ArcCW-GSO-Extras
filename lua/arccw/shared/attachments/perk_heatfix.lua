att.PrintName = "Hot Wrench"
att.Icon = Material("entities/acwatt_perk_heatfix.png", "smooth mips")
att.Description = "Just bang on it! Overheating will be fixed instantly, but heat vents slower."
att.Desc_Pros = {
    "Instantly fix overheating"
}
att.Desc_Cons = {
}
att.Slot = {"perk", "go_perk"}

att.NotForNPC = true

att.SortOrder = 1

att.AutoStats = true
att.Mult_HeatDissipation = 0.5
-- att.Mult_FixTime = 0.75
att.Override_HeatFix = true

att.Hook_Compatible = function(wep)
    if !(wep.Jamming or wep:GetBuff_Override("Override_Jamming")) then return false end
end
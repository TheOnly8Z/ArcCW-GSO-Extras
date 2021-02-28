att.PrintName = "Marksman Trigger"
att.Icon = Material("entities/acwatt_go_perk_semi.png")
att.Description = "Switch for a semi-automatic only firing group and trigger capable of very high accuracy and very stable firing."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "go_perk"

att.Override_Firemodes_Priority = 100
att.Override_Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

att.Hook_Compatible = function(wep)
    if wep:GetIsShotgun() or wep.ManualAction or wep.TriggerDelay or wep:GetBuff_Override("Override_TriggerDelay") then return false end
end

att.Mult_AccuracyMOA = 0.6
att.Mult_MoveDispersion = 0.6
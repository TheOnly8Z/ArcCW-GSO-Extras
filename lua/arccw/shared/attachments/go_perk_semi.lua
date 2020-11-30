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
    --[[]
    -- Search for any non-semi firemodes. If there are none, this isn't applicable
    for i, v in pairs(wep.Firemodes) do
        if !v then continue end
        if v.Mode and v.Mode != 1 and v.Mode != 0 then
            return
        end
    end
    return false
    ]]
    if wep:GetIsShotgun() or wep.ManualAction then return false end
end

att.Mult_AccuracyMOA = 0.6
att.Mult_MoveDispersion = 0.6
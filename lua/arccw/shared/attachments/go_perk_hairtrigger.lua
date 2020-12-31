att.PrintName = "Hair Trigger"
att.Icon = Material("entities/acwatt_go_perk_hairtrigger.png", "smooth mips")
att.Description = "Lightweight and fine-tuned trigger allows for a much shorter trigger delay."
att.Desc_Pros = {
    "pro.hairtrigger"
}
att.Desc_Cons = {
}
att.Slot = "go_perk"

att.AutoStats = true
att.Mult_TriggerDelayTime = 0.4

att.Hook_Compatible = function(wep)
    if !wep.TriggerDelay and !wep:GetBuff_Override("Override_TriggerDelay") then return false end
end